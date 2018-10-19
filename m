Received: from eggs.gnu.org ([2001:4830:134:3::10]:33100)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <fli@suse.com>) id 1gDLFI-0000LA-NX
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 23:14:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <fli@suse.com>) id 1gDLFE-0004G8-Fn
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 23:14:40 -0400
Received: from mx2.suse.de ([195.135.220.15]:37336 helo=mx1.suse.de)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <fli@suse.com>) id 1gDLFE-00049W-0C
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 23:14:36 -0400
References: <20181010120841.13214-1-fli@suse.com>
	<20181010120841.13214-2-fli@suse.com>
	<87in286bst.fsf@dusky.pond.sub.org>
	<3bef7443-9212-db30-a27f-4aa1bd70e65b@suse.com>
	<87zhvjsimc.fsf@dusky.pond.sub.org>
	<3906b0bf-a9ec-e4ac-8948-59419b126799@suse.com>
	<874ldr2t4i.fsf@dusky.pond.sub.org>
	<b6b23d75-bff9-d982-00b1-933567f81347@suse.com>
From: Fei Li <fli@suse.com>
Message-ID: <b0b18204-369e-893d-4d29-0b1be6fac548@suse.com>
Date: Fri, 19 Oct 2018 11:14:17 +0800
MIME-Version: 1.0
In-Reply-To: <b6b23d75-bff9-d982-00b1-933567f81347@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH RFC v5 1/7] Fix segmentation fault when
 qemu_signal_init fails
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org

Kindly ping. :)

Main discuss whether adding the Error for qemu_thread_create() or not.
For details, please see blow:

On 10/17/2018 04:17 PM, Fei Li wrote:
> Sorry for the late reply! Omitted this one..
>
>
> On 10/12/2018 09:26 PM, Markus Armbruster wrote:
>> Fei Li <fli@suse.com> writes:
>>
>>> On 10/12/2018 03:56 PM, Markus Armbruster wrote:
>>>> Fei Li <fli@suse.com> writes:
>>>>
>>>>> On 10/11/2018 06:02 PM, Markus Armbruster wrote:
>>>>>> Fei Li <fli@suse.com> writes:
>>>>>>
...snip...
>>>>> For the patch series' current implementation, the=C2=A0 modified
>>>>> qemu_thread_create()
>>>>> in 7/7 patch returns a Boolean value to indicate whether it succeed=
s
>>>>> and set the
>>>>> error reason into the passed errp, and did not set the errno.=20
>>>>> Actually
>>>>> another
>>>>> similar errno-set issue has been talked in last patch. :)
>>>>> If we set the errno in future qemu_thread_create(), we need to
>>>>> distinguish the Linux
>>>>> and Windows implementation. For Linux, we can use error_setg_errno(=
)
>>>>> to set errno.
>>>>> But for Windows, I am not sure if we can use
>>>>>
>>>>> "errno =3D GetLastError()"
>>>> No, that won't work.
>>>>
>>>>> to set errno, as this seems a little weird. Do you have any idea=20
>>>>> about this?
>>>>>
>>>>> BTW, if we have a decent errno-set way for Windows, I will adopt=20
>>>>> your above
>>>>> proposal for this patch.
>>>> According to MS docs, _beginthreadex() sets errno on failure:
>>>>
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 If successful, each of these function=
s returns a handle to=20
>>>> the newly
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 created thread; however, if the newly=
 created thread exits too
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 quickly, _beginthread might not retur=
n a valid handle. (See the
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 discussion in the Remarks section.) O=
n an error, _beginthread
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 returns -1L, and errno is set to EAGA=
IN if there are too many
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 threads, to EINVAL if the argument is=
 invalid or the stack=20
>>>> size is
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 incorrect, or to EACCES if there are =
insufficient resources=20
>>>> (such as
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 memory). On an error, _beginthreadex =
returns 0, and errno and
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 _doserrno are set.
>>>>
>>>> https://docs.microsoft.com/cpp/c-runtime-library/reference/beginthre=
ad-beginthreadex=20
>>>>
>>>>
>>>> Looks like the current code's use of GetLastError() after
>>>> _beginthreadex() failure is wrong.
>>>>
>>>> Fix that, and both qemu_thread_create() implementations set errno on
>>>> failure, which in turn lets you make qemu_signalfd_compat() and thus
>>>> qemu_signalfd() behave sanely regardless of which qemu_thread_create=
()
>>>> implementation they use below the hood.
>>> Thanks for the detail explanation. :)
>>> To fix that, how about replacing the "GetLastError()" with the return=
ed
>>> value "hThread" (actually returns 0)? I mean
>>> =C2=A0=C2=A0=C2=A0 ...
>>> =C2=A0=C2=A0=C2=A0=C2=A0 hThread =3D (HANDLE) _beginthreadex(NULL, 0,=
 win32_start_routine,
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 data, 0, &thread->tid);
>>> =C2=A0=C2=A0=C2=A0=C2=A0 if (!hThread) {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (data->mode !=3D =
QEMU_THREAD_DETACHED) {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 DeleteCriticalSection(&data->cs);
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 error_setg_win32(err=
p, hThread,
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 "failed to create win32_start_routine");
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 g_free(data);
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return false;
>>> =C2=A0=C2=A0=C2=A0=C2=A0 }
>> No.=C2=A0 On failure, _beginthreadex() returns *zero*, not an error co=
de.=C2=A0 It
>> also sets errno.=C2=A0 That's the error code you need to use:
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0 hThread =3D (HANDLE) _beginthreadex(NULL, 0, =
win32_start_routine,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 data, 0, &thread->tid);
>> =C2=A0=C2=A0=C2=A0=C2=A0 if (!hThread) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 error_setg_errno(errp=
, errno, "can't create thread");
>> =C2=A0=C2=A0=C2=A0=C2=A0 }
> Ok, clearer, we also want the errno message to be printed, along
> with _beginthreadex() sets the errno's value by default.
> Thanks.
The below are my thoughts about why keeping the Error:
>> Except I really wouldn't convert qemu_thread_create() to Error!=C2=A0 =
I'd
>> make it return zero on success, a negative errno code on failure, and
>> leave the Error business to its callers.=C2=A0 Basically, replace
>> error_exit(err, ...) by return err.
> Emm, I am afraid not converting to Error means it is a little bit=20
> trickier to
> handle for the callers. Especially for migration callers [see patch 7/7=
],
> they have no initial errp passed, thus error_setg_xx() seems less usefu=
l.
> Instead in the caller I choose the error_reportf_err(local_err, ...)=20
> to only print
> the detail error message and return that caller's original failing tag.
> (But for those callers who already have the errp passed, both "return=20
> ret"
> and "convert qemu_thread_create() to Error" are fine to me.)
>
> Besides, there is only one caller needs the errno value, that is=20
> qemu_signal_init():
> "return -errno". Other callers do not use errno to indicate if it=20
> succeeds.
>
> Thus the current patches choose pass Error to hold the detail error
> message and return a bool to indicate if the function succeeds.
>
> Would you like to share your reason for not converting this function=20
> to Error?
> [1#begin]
>> The caller qemu_signalfd_compat() can then do
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0 ret =3D qemu_thread_create(&thread, "signalfd=
_compat",
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 sigwait_compat, info,=20
>> QEMU_THREAD_DETACHED);
>> =C2=A0=C2=A0=C2=A0=C2=A0 if (ret < 0) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 errno =3D ret;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -1;
>> =C2=A0=C2=A0=C2=A0=C2=A0 }
> [1#end]
> [2#begin]
>> A caller that already has an Error **errp parameter could do
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0 ret =3D qemu_thread_create(...);
>> =C2=A0=C2=A0=C2=A0=C2=A0 if (ret < 0) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 error_setg_errno(errp=
, -ret, "<error message goes here>");
>> =C2=A0=C2=A0=C2=A0=C2=A0 }
> [2#end]
> [3#begin]
>> Callers that want to continue aborting on failure simply do
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0 ret =3D qemu_thread_create(...);
>> =C2=A0=C2=A0=C2=A0=C2=A0 assert(ret >=3D 0);
> [3#end]
>> If that turns out to be too much of a bother, you could create a
>> convenience wrapper for it:
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0 void qemu_thread_create_nofail(QemuThread *th=
read, const char=20
>> *name,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 void *(*s=
tart_routine)(void*),
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 void *arg=
, int mode)
>> =C2=A0=C2=A0=C2=A0=C2=A0 {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int err =3D qemu_thre=
ad_create(thread, name, start_routine,=20
>> arg, mode);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (err) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 error_exit(err, __func__);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> =C2=A0=C2=A0=C2=A0=C2=A0 }
> I am wondering the above qemu_thread_create_nofail is a convenience for
> "[3#begin] =3D> [3#end]"=C2=A0 or=C2=A0 "[1#begin] =3D> [3#end]"..
> If for "[3#begin] =3D> [3#end]", I'd like to use the xxx_nofail wrapper=
=20
> as the error
> message is more detailed.
> If for "[1#begin] =3D> [3#end]", I'd like to explain more for this patc=
h=20
> series: we
> want our qemu code to be more robust by not making qemu exit(-1) after
> qemu_thread_create() fails and let the callers handle this. E.g. for=20
> hmp/qmp
> callers, make qemu abort() seems too violent if they fails.
>
> Have a nice day
> Fei
Have a nice day, thanks
Fei
