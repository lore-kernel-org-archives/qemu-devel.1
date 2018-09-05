Received: from eggs.gnu.org ([2001:4830:134:3::10]:48430)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <fli@suse.com>) id 1fxVrf-0002ox-1m
	for qemu-devel@nongnu.org; Wed, 05 Sep 2018 07:20:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <fli@suse.com>) id 1fxVra-0002MI-Vz
	for qemu-devel@nongnu.org; Wed, 05 Sep 2018 07:20:51 -0400
Received: from mx2.suse.de ([195.135.220.15]:53990 helo=mx1.suse.de)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <fli@suse.com>) id 1fxVra-0002GV-Lg
	for qemu-devel@nongnu.org; Wed, 05 Sep 2018 07:20:46 -0400
References: <20180904110822.12863-1-fli@suse.com>
	<20180904110822.12863-2-fli@suse.com>
	<20180904112620.GG22349@redhat.com>
	<0831de15-95cb-0774-10f9-8b03f4141c10@suse.com>
	<20180905083641.GD3026@redhat.com>
From: Fei Li <fli@suse.com>
Message-ID: <c7666ea1-20c2-8037-3f9d-79f3dc12e413@suse.com>
Date: Wed, 5 Sep 2018 19:20:39 +0800
MIME-Version: 1.0
In-Reply-To: <20180905083641.GD3026@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 1/5] Fix segmentation fault when
 qemu_signal_init fails
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "=?UTF-8?Q?Daniel_P._Berrang=c3=a9?=" <berrange@redhat.com>
Cc: qemu-devel@nongnu.org



On 09/05/2018 04:36 PM, Daniel P. Berrang=C3=A9 wrote:
> On Wed, Sep 05, 2018 at 12:17:24PM +0800, Fei Li wrote:
>> Thanks for the review! :)
>>
>>
>> On 09/04/2018 07:26 PM, Daniel P. Berrang=C3=A9 wrote:
>>> On Tue, Sep 04, 2018 at 07:08:18PM +0800, Fei Li wrote:
>>>
... snip ...
>>>>            free(info);
>>>>            return -1;
>>>>        }
>>>> @@ -94,17 +97,21 @@ static int qemu_signalfd_compat(const sigset_t *=
mask)
>>>>        return fds[0];
>>>>    }
>>>> -int qemu_signalfd(const sigset_t *mask)
>>>> +int qemu_signalfd(const sigset_t *mask, Error **errp)
>>>>    {
>>>> -#if defined(CONFIG_SIGNALFD)
>>>>        int ret;
>>>> +    Error *local_err =3D NULL;
>>>> +#if defined(CONFIG_SIGNALFD)
>>>>        ret =3D syscall(SYS_signalfd, -1, mask, _NSIG / 8);
>>>>        if (ret !=3D -1) {
>>>>            qemu_set_cloexec(ret);
>>>>            return ret;
>>>>        }
>>>>    #endif
>>>> -
>>>> -    return qemu_signalfd_compat(mask);
>>>> +    ret =3D qemu_signalfd_compat(mask, &local_err);
>>>> +    if (local_err) {
>>>> +        error_propagate(errp, local_err);
>>>> +    }
>>> Using a local_err is not required - you can just pass errp stright
>>> to qemu_signalfd_compat() and then check
>>>
>>>      if (ret < 0)
>> For the use of a local error object & error_propagate call, I'd like t=
o
>> explain here. :)
>> In our code, the initial caller passes two kinds of Error to the call =
trace,
>> one is
>> something like &error_abort and &error_fatal, the other is NULL.
>>
>> For the former, the exit() occurs in the functions where
>> error_handle_fatal() is called
>> (e.g. called by error_propagate/error_setg/...). The patch3: qemu_init=
_vcpu
>> is the case,
>> that means the system will exit in the final callee: qemu_thread_creat=
e(),
>> instead of
>> the initial caller pc_new_cpu(). In such case, I think propagating see=
ms
>> more reasonable.
> I don't really agree. It is preferrable to abort immediately at the dee=
pest
> place which raises the error. The stack trace will thus show the full c=
all
> chain leading upto the problem.
Sorry for the above example, it is not exactly correct: for the patch3=20
case, the
system will exit in device_set_realized(), where the first=20
error_propagate() is called
if we pass errp directly, but not in the final callee.. Sorry for the=20
misleading.

For another example, its call trace:
qemu_thread_create(, NULL)
<=3D iothread_complete(, NULL)
<=3D=3D user_creatable_complete(, NULL)
<=3D=3D=3D object_new_with_propv(, errp)
<=3D=3D=3D=3D object_new_with_props(, errp) {... error_propagate(errp,=20
local_err); ...}
<=3D=3D=3D=3D=3D iothread_create(, &error_abort)
The exit occurs in object_new_with_props where the first error_propagate=20
is called.

Either the device_set_realized() or object_new_with_props() is a middle=20
caller, thus
we can only see the top half stack trace until where=20
error_handle_fatal() is called.

In other words, the exit() occurs neither in the final callee nor the=20
initial caller.
Sorry for the misleading example again..
>
>> How do you think passing errp straightly for the latter case, and use =
a
>> local error object &
>> error_propagate for the former case? This is a distinct treatment, but=
 would
>> shorten the code.
> It is inappropriate to second-guess whether the caller is a passing in
> NULL or &error_abort, or another Error object. What is passed in can
> change at any time in the future.
ok.
>
> We should only ever use a local error where the local method has a need
> to look at the error contents before returning to the caller. Any other
> case should just use the errp directly.
>
> Regards,
> Daniel
Have a nice day, thanks
Fei
