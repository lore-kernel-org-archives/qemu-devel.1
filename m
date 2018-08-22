Received: from eggs.gnu.org ([2001:4830:134:3::10]:47244)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fsVRh-0001TX-Kn
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 11:53:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fsVKv-0002Jt-Bm
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 11:46:24 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:45978 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1fsVKv-0002Iz-4U
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 11:46:21 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id BA15D4023827
	for <qemu-devel@nongnu.org>; Wed, 22 Aug 2018 15:46:20 +0000 (UTC)
Date: Wed, 22 Aug 2018 16:46:11 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180822154611.GN12750@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20180822142956.6859-1-marcandre.lureau@redhat.com>
	<20180822142956.6859-4-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180822142956.6859-4-marcandre.lureau@redhat.com>
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
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, pmoore@redhat.com, Eduardo Otubo <otubo@redhat.com>

On Wed, Aug 22, 2018 at 04:29:56PM +0200, Marc-Andr=C3=A9 Lureau wrote:
> When using "-seccomp on", the seccomp policy is only applied to the
> main thread, the vcpu worker thread and other worker threads created
> after seccomp policy is applied; the seccomp policy is not applied to
> e.g. the RCU thread because it is created before the seccomp policy is
> applied and SECCOMP_FILTER_FLAG_TSYNC isn't used.
>=20
> This can be verified with
> for task in /proc/`pidof qemu`/task/*; do cat $task/status | grep Secc =
; done
> Seccomp:	2
> Seccomp:	0
> Seccomp:	0
> Seccomp:	2
> Seccomp:	2
> Seccomp:	2
>=20
> Starting with libseccomp 2.2.0 and kernel >=3D 3.17, we can use
> seccomp_attr_set(ctx, > SCMP_FLTATR_CTL_TSYNC, 1) to update the policy
> on all threads.
>=20
> Do it by default if possible, warn if not possible. Add an option to
> set the tsync behaviour explicitly.
>=20
> Note: we can't bump libseccomp to 2.2.0 since it's not available in
> Debian oldstable (2.1.0).
>=20
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  qemu-seccomp.c  | 65 +++++++++++++++++++++++++++++++++++++++++++++++--
>  qemu-options.hx |  2 ++
>  2 files changed, 65 insertions(+), 2 deletions(-)
>=20
> diff --git a/qemu-seccomp.c b/qemu-seccomp.c
> index f0c833f3ca..aa23eae970 100644
> --- a/qemu-seccomp.c
> +++ b/qemu-seccomp.c
> @@ -119,6 +119,45 @@ qemu_seccomp(unsigned int operation, unsigned int =
flags, void *args)
>  #endif
>  }
> =20
> +static bool qemu_seccomp_syscall_check(void)
> +{
> +    int rc;
> +
> +    /*
> +     * this is an invalid call because the second argument is non-zero=
, but
> +     * depending on the errno value of ENOSYS or EINVAL we can guess i=
f the
> +     * seccomp() syscal is supported or not
> +     */
> +    rc =3D qemu_seccomp(SECCOMP_SET_MODE_STRICT, 1, NULL);
> +    if (rc < 0 && errno =3D=3D EINVAL) {
> +        return true;
> +    }
> +
> +    return false;
> +}
> +
> +static bool qemu_seccomp_get_default_tsync(void)
> +{
> +    bool tsync =3D true;
> +
> +    /* TSYNC support was added with the syscall */
> +    if (!qemu_seccomp_syscall_check()) {
> +        error_report("The host kernel doesn't support seccomp TSYNC!")=
;
> +        tsync =3D false;
> +    }
> +
> +#if !(SCMP_VER_MAJOR >=3D 2 && SCMP_VER_MINOR >=3D 2)
> +    error_report("libseccomp is too old to support TSYNC!");
> +    tsync =3D false;
> +#endif
> +
> +    if (!tsync) {
> +        error_report("Only the main thread will be filtered by seccomp=
!");

At this point you might as well not bother using seccomp at all. The
thread that is confined merely needs to scribble something into the
stack of the unconfined thread and now it can do whatever it wants.

IMHO we need to find a way to get the policy to apply to those other
threads.

The RCU thread is tricky as it is spawned from a __constructor__
function, which means it'll be active way before we setup seccomp.

I think we need to figure out a way todo synchronization between
the RCU thread and the seccomp setup code. Could we have a global
variable 'int seccomp_initialized' that we check from the RCU
thread loop - when that toggles to non-zero, the RCU thread can
then call into the seccomp_start() method to activate policy in
its thread. We'd need a synchronous feedback mechansim back to
the main thread, as it must block startup until all the threads
have activated the seccomp filter.

> diff --git a/qemu-options.hx b/qemu-options.hx
> index 5515dfaba5..dafacb60c6 100644
> --- a/qemu-options.hx
> +++ b/qemu-options.hx
> @@ -3864,6 +3864,8 @@ Disable set*uid|gid system calls
>  Disable *fork and execve
>  @item resourcecontrol=3D@var{string}
>  Disable process affinity and schedular priority
> +@item tsync=3D@var{bool}
> +Apply seccomp filter to all threads (default is auto, and will warn if=
 fail)

IMHO this should never exist, as setting "tsync" to anything other
than "yes", is akin to just running without any sandbox.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
