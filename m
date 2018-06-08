Received: from eggs.gnu.org ([2001:4830:134:3::10]:48554)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fRCzg-0003GO-4n
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 04:43:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fRCzc-0003bl-WD
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 04:43:36 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:32970 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1fRCzc-0003aU-RL
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 04:43:32 -0400
Date: Fri, 8 Jun 2018 09:43:25 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180608084325.GE18233@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20180601162749.27406-1-marcandre.lureau@redhat.com>
	<20180601162749.27406-5-marcandre.lureau@redhat.com>
	<20180604093653.GC19749@redhat.com>
	<CAJ+F1C+dSJOZUR6nGVxBmonaqB5gREXut61=r2bGMhioYMvEHw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJ+F1C+dSJOZUR6nGVxBmonaqB5gREXut61=r2bGMhioYMvEHw@mail.gmail.com>
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
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>
Cc: QEMU <qemu-devel@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>

On Fri, Jun 08, 2018 at 12:34:15AM +0200, Marc-Andr=C3=A9 Lureau wrote:
> Hi
>=20
> On Mon, Jun 4, 2018 at 11:36 AM, Daniel P. Berrang=C3=A9 <berrange@redh=
at.com> wrote:
> > On Fri, Jun 01, 2018 at 06:27:41PM +0200, Marc-Andr=C3=A9 Lureau wrot=
e:
> >> Create a vhost-user-backend object that holds a connection to a
> >> vhost-user backend and can be referenced from virtio devices that
> >> support it. See later patches for input & gpu usage.
> >>
> >> A chardev can be specified to communicate with the vhost-user backen=
d,
> >> ex: -chardev socket,id=3Dchar0,path=3D/tmp/foo.sock -object
> >> vhost-user-backend,id=3Dvuid,chardev=3Dchar0.
> >>
> >> Alternatively, an executable with its arguments may be given as 'cmd=
'
> >> property, ex: -object
> >> vhost-user-backend,id=3Dvui,cmd=3D"./vhost-user-input /dev/input..".=
 The
> >> executable is then spawn and, by convention, the vhost-user socket i=
s
> >> passed as fd=3D3. It may be considered a security breach to allow
> >> creating processes that may execute arbitrary executables, so this m=
ay
> >> be restricted to some known executables (via signature etc) or
> >> directory.
> >
> > Passing a binary and args as a string blob.....
> >
> >> +static int
> >> +vhost_user_backend_spawn_cmd(VhostUserBackend *b, int vhostfd, Erro=
r **errp)
> >> +{
> >> +    int devnull =3D open("/dev/null", O_RDWR);
> >> +    pid_t pid;
> >> +
> >> +    assert(!b->child);
> >> +
> >> +    if (!b->cmd) {
> >> +        error_setg_errno(errp, errno, "Missing cmd property");
> >> +        return -1;
> >> +    }
> >> +    if (devnull < 0) {
> >> +        error_setg_errno(errp, errno, "Unable to open /dev/null");
> >> +        return -1;
> >> +    }
> >> +
> >> +    pid =3D qemu_fork(errp);
> >> +    if (pid < 0) {
> >> +        close(devnull);
> >> +        return -1;
> >> +    }
> >> +
> >> +    if (pid =3D=3D 0) { /* child */
> >> +        int fd, maxfd =3D sysconf(_SC_OPEN_MAX);
> >> +
> >> +        dup2(devnull, STDIN_FILENO);
> >> +        dup2(devnull, STDOUT_FILENO);
> >> +        dup2(vhostfd, 3);
> >> +
> >> +        signal(SIGINT, SIG_IGN);
> >
> > Why ignore SIGINT ?  Surely we want this extra process to be killed
> > someone ctrl-c's the parent QEMU.
>=20
> leftover, removed
>=20
> >
> >> +
> >> +        for (fd =3D 4; fd < maxfd; fd++) {
> >> +            close(fd);
> >> +        }
> >> +
> >> +        execlp("/bin/sh", "sh", "-c", b->cmd, NULL);
> >
> > ...which is then interpreted by the shell is a recipe for security
> > flaws. There needs to be a way to pass the command + arguments
> > to QEMU as an argv[] we can directly exec without involving the
> > shell.
> >
>=20
> For now, I use g_shell_parse_argv(). Do you have a better idea?

Accept individual args at the cli level is far preferrable - we don't
want anything to be parsing shell strings:

 vhost-user-backend,id=3Dvui,binary=3D/sbin/vhost-user-input,arg=3D/dev/i=
nput,arg=3Dfoo,arg=3Dbar



Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
