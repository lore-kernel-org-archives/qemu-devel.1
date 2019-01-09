Received: from eggs.gnu.org ([209.51.188.92]:41380)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ghEy9-00041B-VT
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 09:36:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ghEy8-0006Hn-3n
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 09:36:33 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47384)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1ghEy7-0006Fy-Qn
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 09:36:32 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <20181225140449.15786-1-fli@suse.com>
	<20181225140449.15786-7-fli@suse.com>
	<87lg3wmln8.fsf@dusky.pond.sub.org>
	<5DCFD2A7-85F6-42ED-8CBB-B42B6605BE6F@126.com>
	<87ftu3kri2.fsf@dusky.pond.sub.org>
	<ab38ce34-1832-30e5-2649-f67b9b1755e4@126.com>
Date: Wed, 09 Jan 2019 15:36:27 +0100
In-Reply-To: <ab38ce34-1832-30e5-2649-f67b9b1755e4@126.com> (Fei Li's message
	of "Wed, 9 Jan 2019 21:19:49 +0800")
Message-ID: <875zuxew44.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-4.0 v9 06/16] qemu_thread: Make
 qemu_thread_create() handle errors properly
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fei Li <lifei1214@126.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org, shirley17fei@gmail.com

Fei Li <lifei1214@126.com> writes:

> =E5=9C=A8 2019/1/9 =E4=B8=8A=E5=8D=881:07, Markus Armbruster =E5=86=99=E9=
=81=93:
>> fei <lifei1214@126.com> writes:
>>
>>>> =E5=9C=A8 2019=E5=B9=B41=E6=9C=888=E6=97=A5=EF=BC=8C01:18=EF=BC=8CMark=
us Armbruster <armbru@redhat.com> =E5=86=99=E9=81=93=EF=BC=9A
>>>>
>>>> Fei Li <fli@suse.com> writes:
[...]
>>>>> diff --git a/util/qemu-thread-posix.c b/util/qemu-thread-posix.c
>>>>> index 865e476df5..39834b0551 100644
>>>>> --- a/util/qemu-thread-posix.c
>>>>> +++ b/util/qemu-thread-posix.c
>>>>> @@ -15,6 +15,7 @@
>>>>> #include "qemu/atomic.h"
>>>>> #include "qemu/notify.h"
>>>>> #include "qemu-thread-common.h"
>>>>> +#include "qapi/error.h"
>>>>>
>>>>> static bool name_threads;
>>>>>
>>>>> @@ -500,9 +501,13 @@ static void *qemu_thread_start(void *args)
>>>>>      return r;
>>>>> }
>>>>>
>>>>> -void qemu_thread_create(QemuThread *thread, const char *name,
>>>>> -                       void *(*start_routine)(void*),
>>>>> -                       void *arg, int mode)
>>>>> +/*
>>>>> + * Return a boolean: true/false to indicate whether it succeeds.
>>>>> + * If fails, propagate the error to Error **errp and set the errno.
>>>>> + */
>>>> Let's write something that can pass as a function contract:
>>>>
>>>>    /*
>>>>     * Create a new thread with name @name
>>>>     * The thread executes @start_routine() with argument @arg.
>>>>     * The thread will be created in a detached state if @mode is
>>>>     * QEMU_THREAD_DETACHED, and in a jounable state if it's
>>>>     * QEMU_THREAD_JOINABLE.
>>>>     * On success, return true.
>>>>     * On failure, set @errno, store an error through @errp and return
>>>>     * false.
>>>>     */
>>> Thanks so much for amending! :)
>>>> Personally, I'd return negative errno instead of false, and dispense
>>>> with setting errno.
>>> Emm, I think I have replied this in last version, but due to several re=
asons I did not wait for your feedback and sent the v9. Sorry for that.. An=
d I like to paste my two considerations here:
>>> =E2=80=9C- Actually only one caller needs the errno, that is the above =
qemu_signalfd_compat().
>> Yes.
>>
>>> - For the returning value, I remember there's once a email thread talki=
ng about it: returning a bool (and let the passed errp hold the error messa=
ge) is to keep the consistency with glib.
>> GLib doesn't discourage return types other than boolean.  It only asks
>> that if you return boolean, then true should mean success and false
>> should mean failure.  See
>>
>>      https://developer.gnome.org/glib/stable/glib-Error-Reporting.html
>>
>> under "Rules for use of GError", item "By convention, if you return a
>> boolean value".
>>
>> The discussion you remember was about a convention we used to enforce in
>> QEMU, namely to avoid returning boolean success, and return void
>> instead.  That was basically a bad idea.
>>
>>> So IMO I am wondering whether it is really needed to change the bool (t=
rue/false) to int (0/-errno), just for that sole function: qemu_signalfd_co=
mpat() which needs the errno. Besides if we return -errno, for each caller =
we need add a local variable like =E2=80=9Cret=3D qemu_thread_create()=E2=
=80=9D to store the -errno.
>> Well, you either assign the error code to errno just for that caller, or
>> you return the error code just for that caller.  I'd do the latter
>> because I consider it slightly simpler.  Compare
>>
>>   * On success, return true.
>>   * On failure, set @errno, store an error through @errp and return
>>   * false.
>>
>> to
>>
>>   * On success, return zero.
>>   * On failure, store an error through @errp and return negative errno.
>>
>> where the second sentence describes just two instead of three actions.
>>
>> [...]
> Ok, decribing two actions than three is indeed simpler. But I still
> have one uncertain:
> for those callers do not need the errno value, could we just check the
> return value
> to see whether it is negative, but not cache the unused return value? I m=
ean
>
> In the caller:
>
> {...
> =C2=A0=C2=A0=C2=A0 if (qemu_thread_create() < 0) {// do some cleanup}
> ...}

This is just fine when you handle all errors the same.

> instead of
>
> {=C2=A0=C2=A0=C2=A0 int ret;
> ...
> =C2=A0=C2=A0=C2=A0 ret =3D qemu_thread_create();
> =C2=A0=C2=A0=C2=A0 if (ret < 0) { //do some cleanup }
>
> ...}

I'd object to this one unless the value of @ret gets used elsewhere.

> As the first one can lessen quite a lot of codes. :)
>
> Have a nice day, thanks
>
> Fei
