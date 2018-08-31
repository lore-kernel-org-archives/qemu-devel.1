Received: from eggs.gnu.org ([2001:4830:134:3::10]:47242)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fvgtT-0008AX-Sh
	for qemu-devel@nongnu.org; Fri, 31 Aug 2018 06:43:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fvgtN-0006FJ-Hn
	for qemu-devel@nongnu.org; Fri, 31 Aug 2018 06:43:10 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:43362 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1fvgtN-0006Et-6f
	for qemu-devel@nongnu.org; Fri, 31 Aug 2018 06:43:05 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id ADFFE807689A
	for <qemu-devel@nongnu.org>; Fri, 31 Aug 2018 10:43:04 +0000 (UTC)
Date: Fri, 31 Aug 2018 11:42:58 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180831104258.GA5088@redhat.com>
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
> +    close(pidfd);
> +    return false;
> +}

Thinking about this again, I think it is not robust enough.

QEMU will leave the pidfile existing on disk when it exits which
initially made me think it avoids the deletion race. The app
managing QEMU, however, may well delete the pidfile after it has
seen QEMU exit, and even if the app locks the pidfile before
deleting it, there is still a race.

eg consider the following sequence

      QEMU 1        libvirtd        QEMU 2

1.    lock(pidfile)

2.    exit()

3.                 open(pidfile)

4.                 lock(pidfile)

5.                                  open(pidfile)

6.                 unlink(pidfile)

7.                 close(pidfile)

8.                                  lock(pidfile)


IOW, at step 8 the new QEMU has successfully acquired the lock, but the
pidfile no longer exists on disk because it was deleted after the origina=
l
QEMU exited.

While we could just say no external app should ever delete the pidfile,
I don't think that is satisfactory as people don't read docs, and admins
don't like stale pidfiles being left around on disk.

To make this robust, I think we might want to copy libvirt's approach to
pidfile acquisition which runs in a loop and checks that the file on
disk /after/ acquiring the lock matches the file that was locked. Then
we could in fact safely let QEMU delete its own pidfiles on clean exit.

    while (1) {
        struct stat a, b;
        if ((fd =3D open(path, O_WRONLY|O_CREAT, 0644)) < 0) {
            return -1;
        }

        if (fstat(fd, &b) < 0) {
            close(fd);
            return -1;
        }

        if (lockf(fd, F_TLOCK, 0) < 0) {
            close(fd);
            return -1;
        }

        /* Now make sure the pidfile we locked is the same
         * one that now exists on the filesystem
         */
        if (stat(path, &a) < 0) {
	    close(fd);
            /* Someone else must be racing with us, so try again */
            continue;
        }
=09
        if (a.st_ino =3D=3D b.st_ino)
            break;

        close(fd);
        /* Someone else must be racing with us, so try again */
    }


    if (ftruncate(fd, 0)) {
        close(fd);
	return -1;
    }

    snprintf(pidstr, sizeof(pidstr), "%d\n", getpid());
    if (write(fd, pidstr, strlen(pidstr)) !=3D strlen(pidstr)) {
        close(fd);
	return -1;
    }

    return fd;


Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
