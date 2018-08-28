Received: from eggs.gnu.org ([2001:4830:134:3::10]:51242)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fugAe-0000WF-63
	for qemu-devel@nongnu.org; Tue, 28 Aug 2018 11:44:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fugAZ-0000w2-AE
	for qemu-devel@nongnu.org; Tue, 28 Aug 2018 11:44:44 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:48458 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1fugAY-0000te-VJ
	for qemu-devel@nongnu.org; Tue, 28 Aug 2018 11:44:39 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 539964023ECC
	for <qemu-devel@nongnu.org>; Tue, 28 Aug 2018 15:44:38 +0000 (UTC)
Date: Tue, 28 Aug 2018 16:44:30 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180828154430.GD31005@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20180713130916.4153-1-marcandre.lureau@redhat.com>
	<20180713130916.4153-11-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180713130916.4153-11-marcandre.lureau@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4 10/29] HACK: vhost-user-backend: allow
 to specify binary to execute
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, airlied@redhat.com, kraxel@redhat.com

On Fri, Jul 13, 2018 at 03:08:57PM +0200, Marc-Andr=C3=A9 Lureau wrote:
> An executable with its arguments may be given as 'cmd' property, ex:
> -object vhost-user-backend,id=3Dvui,cmd=3D"./vhost-user-input
> /dev/input..". The executable is then spawn and, by convention, the
> vhost-user socket is passed as fd=3D3. It may be considered a security
> breach to allow creating processes that may execute arbitrary
> executables, so this may be restricted to some known executables (via
> signature etc) or directory.

NB, Libvirt runs all QEMU instances with a seccomp policy that forbids
any use of execve(), so libvirt won't use 'cmd' at all.

> To make the patch more acceptable, the command argument would have to
> be passed via an array (probably via -object json: syntax), instead of
> using g_shell_parse_argv().

I still think we should not allow args to be specified at all. Declare
a stable API contract for this script where QEMU defines what argv and
env will be provided, in the same way we do for TAP ifup scripts. Then
on the CLI we'd only need a binary path.

> diff --git a/backends/vhost-user.c b/backends/vhost-user.c
> index bf39c0751d..32d3ec0e8b 100644
> --- a/backends/vhost-user.c
> +++ b/backends/vhost-user.c
> @@ -136,31 +136,105 @@ vhost_user_backend_stop(VhostUserBackend *b)
>      b->started =3D false;
>  }
> =20
> +static void
> +pre_exec_cb(void *data)
> +{
> +    int *sv =3D data;
> +    int maxfd =3D sysconf(_SC_OPEN_MAX);
> +    int fd;
> +
> +    dup2(sv[1], 3);

error checking...

> +    for (fd =3D 4; fd < maxfd; fd++) {
> +        close(fd);

This shouldn't fail, but to be robust we should check
errors anyway.

> +    }
> +}
> +

> diff --git a/qemu-options.hx b/qemu-options.hx
> index 413b97d5e9..9243a5f8ab 100644
> --- a/qemu-options.hx
> +++ b/qemu-options.hx
> @@ -4292,16 +4292,20 @@ secondary:
>  If you want to know the detail of above command line, you can read
>  the colo-compare git log.
> =20
> -@item -object vhost-user-backend,id=3Did=3D@var{id},chardev=3D@var{cha=
rdevid}
> +@item -object vhost-user-backend,id=3Did=3D@var{id}[,chardev=3D@var{ch=
ardevid},cmd=3D@var{cmd}]
> =20
>  Create a vhost-user-backend object that holds a connection to a
>  vhost-user backend and can be referenced from virtio/vhost-user
>  devices that support it.
> =20
>  The @var{id} parameter is a unique ID that will be used to reference
> -this vhost-user backend from the @option{vhost-user} device. The
> -@var{chardev} parameter is the unique ID of a character device backend
> -that provides the connection to the vhost-user slave process. (Since 3=
.0)
> +this vhost-user backend from the @option{vhost-user} device.
> +
> +You must specify either @var{chardev} or @var{cmd}. The @var{chardev}
> +parameter is the unique ID of a character device backend that provides
> +the connection to the vhost-user slave process.  The @var{cmd}
> +parameter will simplify handling of the backend, by running the given
> +command and establishing the connection. (Since 3.1)

Should note that 'cmd' is not usable with seccomp policy that blocks
execve.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
