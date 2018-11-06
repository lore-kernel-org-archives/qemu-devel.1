Received: from eggs.gnu.org ([2001:4830:134:3::10]:41638)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <fli@suse.com>) id 1gJtbV-0004X6-67
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 00:08:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <fli@suse.com>) id 1gJtbR-0001er-5d
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 00:08:41 -0500
Received: from mx2.suse.de ([195.135.220.15]:42982 helo=mx1.suse.de)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <fli@suse.com>) id 1gJtbQ-0001d0-T0
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 00:08:37 -0500
References: <20181101101715.9443-1-fli@suse.com>
	<20181101101715.9443-2-fli@suse.com> <87h8gvvedh.fsf@trasno.org>
From: Fei Li <fli@suse.com>
Message-ID: <b36e2918-bddd-4b28-3e5c-d48e513a986b@suse.com>
Date: Tue, 6 Nov 2018 13:08:26 +0800
MIME-Version: 1.0
In-Reply-To: <87h8gvvedh.fsf@trasno.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH RFC v7 1/9] Fix segmentation fault when
 qemu_signal_init fails
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: quintela@redhat.com
Cc: peterx@redhat.com, famz@redhat.com, qemu-devel@nongnu.org, dgilbert@redhat.com, armbru@redhat.com

Hi,


On 11/05/2018 09:32 PM, Juan Quintela wrote:
> Fei Li <fli@suse.com> wrote:
>> When qemu_signal_init() fails in qemu_init_main_loop(), we return
>> without setting an error.  Its callers crash then when they try to
>> report the error with error_report_err().
>>
>> To avoid such segmentation fault, add a new Error parameter to make
>> the call trace to propagate the err to the final caller.
> Hi
>
> I agree that there is a bug that exist here.  But I think that the patc=
h
> is not 100% correct.  What is the warrantee that when we call
> qemu_signal_init() errp is not *already* assigned.
>
> I think that we need to use here the same code that in the call to
> aio_context_new() ...
>
> i.e.
>
>
> intsead of this
>
>>       init_clocks(qemu_timer_notify_cb);
>>  =20
>> -    ret =3D qemu_signal_init();
>> +    ret =3D qemu_signal_init(errp);
>>       if (ret) {
>>           return ret;
>>       }
>      init_clocks(qemu_timer_notify_cb);
>
>      ret =3D qemu_signal_init();
>      ret =3D qemu_signal_init(&local_error);
>      if (ret) {
>           error_propagate(errp, local_error);
>           return ret;
>      }
>
> This way it works correctly if errp is NULL, errp is already assigned,
> etc, etc,
>
> Or I am missing something?
>
> Later, Juan.
We have discussed this in the first round of this patch series, just as=20
Daniel
and Fam said, we only need the local_err & error_propagate() when functio=
ns
like object_new_with_propv() returns void, in that way we need the=20
&local_err to
check whether that function succeeds.
But in qemu_signal_init, we have the "if (ret) {...}" to judge whether=20
it succeeds.
For more details, the following threads can be referred:

09/04/2018 07:26 PM
Re: [Qemu-devel] [PATCH 1/5] Fix segmentation fault when=20
qemu_signal_init fails

BTW, if qemu_signalfd() fails, we use an "error_setg_errno()" to handle:
- for NULL errp, we just set the error message to errp;
- for not-NULL errp, besides the error_setv() we have the=20
error_handle_fatal(errp, err).
 =C2=A0 If the passed errp is &error_fatal/&error_abort, qemu will exit(1=
)=20
right here.

Have a nice day, thanks :)
Fei
