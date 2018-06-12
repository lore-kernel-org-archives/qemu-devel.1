Received: from eggs.gnu.org ([2001:4830:134:3::10]:52149)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1fSkgI-0005ob-At
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 10:53:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1fSkgH-0006zO-BR
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 10:53:58 -0400
Received: from mail-wr0-x242.google.com ([2a00:1450:400c:c0c::242]:40521)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1fSkgH-0006vo-4Z
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 10:53:57 -0400
Received: by mail-wr0-x242.google.com with SMTP id l41-v6so24415584wre.7
	for <qemu-devel@nongnu.org>; Tue, 12 Jun 2018 07:53:56 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180608084325.GE18233@redhat.com>
References: <20180601162749.27406-1-marcandre.lureau@redhat.com>
	<20180601162749.27406-5-marcandre.lureau@redhat.com>
	<20180604093653.GC19749@redhat.com>
	<CAJ+F1C+dSJOZUR6nGVxBmonaqB5gREXut61=r2bGMhioYMvEHw@mail.gmail.com>
	<20180608084325.GE18233@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 12 Jun 2018 16:53:54 +0200
Message-ID: <CAJ+F1CLFJGhWVzPWGjQX78qSOQK8BZ7W0rkO6s-SsGpLqc-ObA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: QEMU <qemu-devel@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>, Markus Armbruster <armbru@redhat.com>

Hi

On Fri, Jun 8, 2018 at 10:43 AM, Daniel P. Berrang=C3=A9 <berrange@redhat.c=
om> wrote:
> On Fri, Jun 08, 2018 at 12:34:15AM +0200, Marc-Andr=C3=A9 Lureau wrote:
>> Hi
>>
>> On Mon, Jun 4, 2018 at 11:36 AM, Daniel P. Berrang=C3=A9 <berrange@redha=
t.com> wrote:
>> > On Fri, Jun 01, 2018 at 06:27:41PM +0200, Marc-Andr=C3=A9 Lureau wrote=
:
>> >> Create a vhost-user-backend object that holds a connection to a
>> >> vhost-user backend and can be referenced from virtio devices that
>> >> support it. See later patches for input & gpu usage.
>> >>
>> >> A chardev can be specified to communicate with the vhost-user backend=
,
>> >> ex: -chardev socket,id=3Dchar0,path=3D/tmp/foo.sock -object
>> >> vhost-user-backend,id=3Dvuid,chardev=3Dchar0.
>> >>
>> >> Alternatively, an executable with its arguments may be given as 'cmd'
>> >> property, ex: -object
>> >> vhost-user-backend,id=3Dvui,cmd=3D"./vhost-user-input /dev/input..". =
The
>> >> executable is then spawn and, by convention, the vhost-user socket is
>> >> passed as fd=3D3. It may be considered a security breach to allow
>> >> creating processes that may execute arbitrary executables, so this ma=
y
>> >> be restricted to some known executables (via signature etc) or
>> >> directory.
>> >
>> > Passing a binary and args as a string blob.....
>> >
>> >> +static int
>> >> +vhost_user_backend_spawn_cmd(VhostUserBackend *b, int vhostfd, Error=
 **errp)
>> >> +{
>> >> +    int devnull =3D open("/dev/null", O_RDWR);
>> >> +    pid_t pid;
>> >> +
>> >> +    assert(!b->child);
>> >> +
>> >> +    if (!b->cmd) {
>> >> +        error_setg_errno(errp, errno, "Missing cmd property");
>> >> +        return -1;
>> >> +    }
>> >> +    if (devnull < 0) {
>> >> +        error_setg_errno(errp, errno, "Unable to open /dev/null");
>> >> +        return -1;
>> >> +    }
>> >> +
>> >> +    pid =3D qemu_fork(errp);
>> >> +    if (pid < 0) {
>> >> +        close(devnull);
>> >> +        return -1;
>> >> +    }
>> >> +
>> >> +    if (pid =3D=3D 0) { /* child */
>> >> +        int fd, maxfd =3D sysconf(_SC_OPEN_MAX);
>> >> +
>> >> +        dup2(devnull, STDIN_FILENO);
>> >> +        dup2(devnull, STDOUT_FILENO);
>> >> +        dup2(vhostfd, 3);
>> >> +
>> >> +        signal(SIGINT, SIG_IGN);
>> >
>> > Why ignore SIGINT ?  Surely we want this extra process to be killed
>> > someone ctrl-c's the parent QEMU.
>>
>> leftover, removed
>>
>> >
>> >> +
>> >> +        for (fd =3D 4; fd < maxfd; fd++) {
>> >> +            close(fd);
>> >> +        }
>> >> +
>> >> +        execlp("/bin/sh", "sh", "-c", b->cmd, NULL);
>> >
>> > ...which is then interpreted by the shell is a recipe for security
>> > flaws. There needs to be a way to pass the command + arguments
>> > to QEMU as an argv[] we can directly exec without involving the
>> > shell.
>> >
>>
>> For now, I use g_shell_parse_argv(). Do you have a better idea?
>
> Accept individual args at the cli level is far preferrable - we don't
> want anything to be parsing shell strings:
>
>  vhost-user-backend,id=3Dvui,binary=3D/sbin/vhost-user-input,arg=3D/dev/i=
nput,arg=3Dfoo,arg=3Dbar

Object arguments are populated in a dictionary. Only the last value
specified is used.

g_shell_parse_argv() isn't that scary imho. But if there is a
blacklist of functions, it would be worth to have them listed
somewhere.
