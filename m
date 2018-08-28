Received: from eggs.gnu.org ([2001:4830:134:3::10]:53030)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fugIf-0005Bv-NH
	for qemu-devel@nongnu.org; Tue, 28 Aug 2018 11:53:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fugIc-0002Lz-ED
	for qemu-devel@nongnu.org; Tue, 28 Aug 2018 11:53:01 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:48652 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1fugIc-0002L9-6J
	for qemu-devel@nongnu.org; Tue, 28 Aug 2018 11:52:58 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B9C2A4023ECC
	for <qemu-devel@nongnu.org>; Tue, 28 Aug 2018 15:52:57 +0000 (UTC)
Date: Tue, 28 Aug 2018 16:52:50 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180828155250.GF31005@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20180713130916.4153-1-marcandre.lureau@redhat.com>
	<20180713130916.4153-21-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180713130916.4153-21-marcandre.lureau@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4 20/29] util: add qemu_write_pidfile()
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

On Fri, Jul 13, 2018 at 03:09:07PM +0200, Marc-Andr=C3=A9 Lureau wrote:
> There are variants of qemu_create_pidfile() in qemu-pr-helper and
> qemu-ga. Let's have a common implementation in libqemuutil.
>=20
> The code is based from pr-helper write_pidfile(), but allows the
> caller to deal with error reporting and behaviour.
>=20
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  include/qemu/osdep.h  |  3 ++-
>  os-posix.c            | 24 -------------------
>  os-win32.c            | 25 --------------------
>  qga/main.c            | 54 ++++++++-----------------------------------
>  scsi/qemu-pr-helper.c | 40 ++++----------------------------
>  util/oslib-posix.c    | 33 ++++++++++++++++++++++++++
>  util/oslib-win32.c    | 27 ++++++++++++++++++++++
>  vl.c                  |  4 ++--
>  8 files changed, 79 insertions(+), 131 deletions(-)



> diff --git a/util/oslib-posix.c b/util/oslib-posix.c
> index 13b6f8d776..da1d4a3201 100644
> --- a/util/oslib-posix.c
> +++ b/util/oslib-posix.c
> @@ -88,6 +88,39 @@ int qemu_daemon(int nochdir, int noclose)
>      return daemon(nochdir, noclose);
>  }
> =20
> +bool qemu_write_pidfile(const char *pidfile, Error **errp)
> +{
> +    int pidfd;
> +    char pidstr[32];
> +
> +    pidfd =3D qemu_open(pidfile, O_CREAT | O_WRONLY, S_IRUSR | S_IWUSR=
);
> +    if (pidfd =3D=3D -1) {
> +        error_setg_errno(errp, errno, "Cannot open pid file");
> +        return false;
> +    }
> +
> +    if (lockf(pidfd, F_TLOCK, 0)) {
> +        error_setg_errno(errp, errno, "Cannot lock pid file");
> +        goto fail;
> +    }
> +    if (ftruncate(pidfd, 0)) {
> +        error_setg_errno(errp, errno, "Failed to truncate pid file");
> +        goto fail;
> +    }
> +
> +    snprintf(pidstr, sizeof(pidstr), "%d\n", getpid());
> +    if (write(pidfd, pidstr, strlen(pidstr)) !=3D strlen(pidstr)) {
> +        error_setg(errp, "Failed to write pid file");
> +        goto fail;
> +    }
> +    return true;
> +
> +fail:
> +    unlink(pidfile);

Danger,  Will Robinson !

We can get to this fail: label if we were unable to lockf() the
pidfile. ie someone else owns the pidfile, and we've now unlinked
the pidfile they own.


> +    close(pidfd);
> +    return false;
> +}
> +
>  void *qemu_oom_check(void *ptr)
>  {
>      if (ptr =3D=3D NULL) {


Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
