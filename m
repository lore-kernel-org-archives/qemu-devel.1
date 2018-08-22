Received: from eggs.gnu.org ([2001:4830:134:3::10]:49807)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1fsVX2-0007Ny-Bb
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 11:58:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1fsVWy-0003nB-Ht
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 11:58:52 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:53157)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1fsVWy-0003mD-8V
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 11:58:48 -0400
Received: by mail-it0-f65.google.com with SMTP id d9-v6so3497511itf.2
	for <qemu-devel@nongnu.org>; Wed, 22 Aug 2018 08:58:47 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180822154611.GN12750@redhat.com>
References: <20180822142956.6859-1-marcandre.lureau@redhat.com>
	<20180822142956.6859-4-marcandre.lureau@redhat.com>
	<20180822154611.GN12750@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Wed, 22 Aug 2018 17:58:46 +0200
Message-ID: <CAMxuvawr-ooy91ZHTHx+aLYhgpH5gBoAKQz_pvF=kcHzadjLog@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 3/3] seccomp: set the seccomp filter to
 all threads
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Paul Moore <pmoore@redhat.com>, Eduardo Otubo <otubo@redhat.com>

On Wed, Aug 22, 2018 at 5:46 PM, Daniel P. Berrang=C3=A9 <berrange@redhat.c=
om> wrote:
> On Wed, Aug 22, 2018 at 04:29:56PM +0200, Marc-Andr=C3=A9 Lureau wrote:
>> When using "-seccomp on", the seccomp policy is only applied to the
>> main thread, the vcpu worker thread and other worker threads created
>> after seccomp policy is applied; the seccomp policy is not applied to
>> e.g. the RCU thread because it is created before the seccomp policy is
>> applied and SECCOMP_FILTER_FLAG_TSYNC isn't used.
>>
>> This can be verified with
>> for task in /proc/`pidof qemu`/task/*; do cat $task/status | grep Secc ;=
 done
>> Seccomp:      2
>> Seccomp:      0
>> Seccomp:      0
>> Seccomp:      2
>> Seccomp:      2
>> Seccomp:      2
>>
>> Starting with libseccomp 2.2.0 and kernel >=3D 3.17, we can use
>> seccomp_attr_set(ctx, > SCMP_FLTATR_CTL_TSYNC, 1) to update the policy
>> on all threads.
>>
>> Do it by default if possible, warn if not possible. Add an option to
>> set the tsync behaviour explicitly.
>>
>> Note: we can't bump libseccomp to 2.2.0 since it's not available in
>> Debian oldstable (2.1.0).
>>
>> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>> ---
>>  qemu-seccomp.c  | 65 +++++++++++++++++++++++++++++++++++++++++++++++--
>>  qemu-options.hx |  2 ++
>>  2 files changed, 65 insertions(+), 2 deletions(-)
>>
>> diff --git a/qemu-seccomp.c b/qemu-seccomp.c
>> index f0c833f3ca..aa23eae970 100644
>> --- a/qemu-seccomp.c
>> +++ b/qemu-seccomp.c
>> @@ -119,6 +119,45 @@ qemu_seccomp(unsigned int operation, unsigned int f=
lags, void *args)
>>  #endif
>>  }
>>
>> +static bool qemu_seccomp_syscall_check(void)
>> +{
>> +    int rc;
>> +
>> +    /*
>> +     * this is an invalid call because the second argument is non-zero,=
 but
>> +     * depending on the errno value of ENOSYS or EINVAL we can guess if=
 the
>> +     * seccomp() syscal is supported or not
>> +     */
>> +    rc =3D qemu_seccomp(SECCOMP_SET_MODE_STRICT, 1, NULL);
>> +    if (rc < 0 && errno =3D=3D EINVAL) {
>> +        return true;
>> +    }
>> +
>> +    return false;
>> +}
>> +
>> +static bool qemu_seccomp_get_default_tsync(void)
>> +{
>> +    bool tsync =3D true;
>> +
>> +    /* TSYNC support was added with the syscall */
>> +    if (!qemu_seccomp_syscall_check()) {
>> +        error_report("The host kernel doesn't support seccomp TSYNC!");
>> +        tsync =3D false;
>> +    }
>> +
>> +#if !(SCMP_VER_MAJOR >=3D 2 && SCMP_VER_MINOR >=3D 2)
>> +    error_report("libseccomp is too old to support TSYNC!");
>> +    tsync =3D false;
>> +#endif
>> +
>> +    if (!tsync) {
>> +        error_report("Only the main thread will be filtered by seccomp!=
");
>
> At this point you might as well not bother using seccomp at all. The
> thread that is confined merely needs to scribble something into the
> stack of the unconfined thread and now it can do whatever it wants.

Actually, that message is incorrect, it should rather be "not all
threads will be filtered" (as described in commit message).

> IMHO we need to find a way to get the policy to apply to those other
> threads.

That's what the patch is about ;)

> The RCU thread is tricky as it is spawned from a __constructor__
> function, which means it'll be active way before we setup seccomp.
>
> I think we need to figure out a way todo synchronization between
> the RCU thread and the seccomp setup code. Could we have a global
> variable 'int seccomp_initialized' that we check from the RCU
> thread loop - when that toggles to non-zero, the RCU thread can
> then call into the seccomp_start() method to activate policy in
> its thread. We'd need a synchronous feedback mechansim back to
> the main thread, as it must block startup until all the threads
> have activated the seccomp filter.

That's a bit like TSYNC, except we do it ourself with RCU thread. But
what about other threads? For examples one that could be created by
external libraries (like mesa)

>
>> diff --git a/qemu-options.hx b/qemu-options.hx
>> index 5515dfaba5..dafacb60c6 100644
>> --- a/qemu-options.hx
>> +++ b/qemu-options.hx
>> @@ -3864,6 +3864,8 @@ Disable set*uid|gid system calls
>>  Disable *fork and execve
>>  @item resourcecontrol=3D@var{string}
>>  Disable process affinity and schedular priority
>> +@item tsync=3D@var{bool}
>> +Apply seccomp filter to all threads (default is auto, and will warn if =
fail)
>
> IMHO this should never exist, as setting "tsync" to anything other
> than "yes", is akin to just running without any sandbox.

Then we should just fail -sandbox on those systems.

>
> Regards,
> Daniel
> --
> |: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
> |: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
> |: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
