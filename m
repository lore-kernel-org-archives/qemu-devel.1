Received: from eggs.gnu.org ([2001:4830:134:3::10]:41859)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fPlvA-0007j6-Lk
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 05:37:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fPlv7-0005B9-IR
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 05:37:00 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:48322 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1fPlv7-0005Au-D6
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 05:36:57 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 05AE9402A592
	for <qemu-devel@nongnu.org>; Mon,  4 Jun 2018 09:36:57 +0000 (UTC)
Date: Mon, 4 Jun 2018 10:36:53 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180604093653.GC19749@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20180601162749.27406-1-marcandre.lureau@redhat.com>
	<20180601162749.27406-5-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180601162749.27406-5-marcandre.lureau@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC v2 04/12] Add vhost-user-backend
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>

On Fri, Jun 01, 2018 at 06:27:41PM +0200, Marc-Andr=C3=A9 Lureau wrote:
> Create a vhost-user-backend object that holds a connection to a
> vhost-user backend and can be referenced from virtio devices that
> support it. See later patches for input & gpu usage.
>=20
> A chardev can be specified to communicate with the vhost-user backend,
> ex: -chardev socket,id=3Dchar0,path=3D/tmp/foo.sock -object
> vhost-user-backend,id=3Dvuid,chardev=3Dchar0.
>=20
> Alternatively, an executable with its arguments may be given as 'cmd'
> property, ex: -object
> vhost-user-backend,id=3Dvui,cmd=3D"./vhost-user-input /dev/input..". Th=
e
> executable is then spawn and, by convention, the vhost-user socket is
> passed as fd=3D3. It may be considered a security breach to allow
> creating processes that may execute arbitrary executables, so this may
> be restricted to some known executables (via signature etc) or
> directory.

Passing a binary and args as a string blob.....

> +static int
> +vhost_user_backend_spawn_cmd(VhostUserBackend *b, int vhostfd, Error *=
*errp)
> +{
> +    int devnull =3D open("/dev/null", O_RDWR);
> +    pid_t pid;
> +
> +    assert(!b->child);
> +
> +    if (!b->cmd) {
> +        error_setg_errno(errp, errno, "Missing cmd property");
> +        return -1;
> +    }
> +    if (devnull < 0) {
> +        error_setg_errno(errp, errno, "Unable to open /dev/null");
> +        return -1;
> +    }
> +
> +    pid =3D qemu_fork(errp);
> +    if (pid < 0) {
> +        close(devnull);
> +        return -1;
> +    }
> +
> +    if (pid =3D=3D 0) { /* child */
> +        int fd, maxfd =3D sysconf(_SC_OPEN_MAX);
> +
> +        dup2(devnull, STDIN_FILENO);
> +        dup2(devnull, STDOUT_FILENO);
> +        dup2(vhostfd, 3);
> +
> +        signal(SIGINT, SIG_IGN);

Why ignore SIGINT ?  Surely we want this extra process to be killed
someone ctrl-c's the parent QEMU.

> +
> +        for (fd =3D 4; fd < maxfd; fd++) {
> +            close(fd);
> +        }
> +
> +        execlp("/bin/sh", "sh", "-c", b->cmd, NULL);

...which is then interpreted by the shell is a recipe for security
flaws. There needs to be a way to pass the command + arguments
to QEMU as an argv[] we can directly exec without involving the
shell.

> +        _exit(1);
> +    }
> +
> +    b->child =3D QIO_CHANNEL(qio_channel_command_new_pid(devnull, devn=
ull, pid));

Overall this method overall duplicates much of the
qio_channel_command_new_argv(), though you do have a few differences.

I'd prefer if we could make qio_channel_command_new_argv more flexible to
handle these extra needs though.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
