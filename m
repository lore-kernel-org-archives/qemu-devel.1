Received: from eggs.gnu.org ([2001:4830:134:3::10]:60149)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1elcyh-0001Ge-6V
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 10:58:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1elcye-0001W9-CD
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 10:58:43 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:47928 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1elcye-0001UZ-6b
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 10:58:40 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 204F7EAEB0
	for <qemu-devel@nongnu.org>; Tue, 13 Feb 2018 15:58:36 +0000 (UTC)
Date: Tue, 13 Feb 2018 15:58:27 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180213155827.GU573@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <1518531279-11966-1-git-send-email-thuth@redhat.com>
	<20180213150911.GG2378@work-vm> <20180213151125.GQ573@redhat.com>
	<20180213152529.GH2378@work-vm> <20180213152753.GR573@redhat.com>
	<20180213154145.GJ2378@work-vm> <20180213154512.GT573@redhat.com>
	<20180213154942.GL2378@work-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180213154942.GL2378@work-vm>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] io/channel-command: Delay the killing of
 the child after closing the pipe
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, Juan Quintela <quintela@redhat.com>, =?utf-8?B?THVrw6HFoQ==?= Doktor <ldoktor@redhat.com>, Cornelia Huck <cohuck@redhat.com>

On Tue, Feb 13, 2018 at 03:49:42PM +0000, Dr. David Alan Gilbert wrote:
> * Daniel P. Berrang=C3=A9 (berrange@redhat.com) wrote:
> > On Tue, Feb 13, 2018 at 03:41:45PM +0000, Dr. David Alan Gilbert wrot=
e:
> > > * Daniel P. Berrang=C3=A9 (berrange@redhat.com) wrote:
> > > > On Tue, Feb 13, 2018 at 03:25:30PM +0000, Dr. David Alan Gilbert =
wrote:
> > > > > * Daniel P. Berrang=C3=A9 (berrange@redhat.com) wrote:
> > > > > > On Tue, Feb 13, 2018 at 03:09:12PM +0000, Dr. David Alan Gilb=
ert wrote:
> > > > > > > * Thomas Huth (thuth@redhat.com) wrote:
> > > > > > > > We are currently facing some migration failure on s390x w=
hen running
> > > > > > > > certain avocado tests, e.g. when running the test
> > > > > > > > type_specific.io-github-autotest-qemu.migrate.with_reboot=
.exec.gzip_exec.
> > > > > > > > This test is using 'migrate -d "exec:nc localhost 5200"' =
for the migration.
> > > > > > > > The problem is detected at the receiving side, where the =
migration stream
> > > > > > > > apparently ends too early. However, the cause for the pro=
blem is the
> > > > > > > > sending side: After writing the migration stream into the=
 pipe to netcat,
> > > > > > > > the source QEMU calls qio_channel_command_close() which c=
loses the pipe
> > > > > > > > and immediately (!) kills the child process afterwards. S=
o if the
> > > > > > > > sending netcat did not read the final bytes from the pipe=
 yet, or
> > > > > > > > if it did not manage to send out all its buffers yet, it =
is killed
> > > > > > > > before the whole migration stream is passed to the destin=
ation side.
> > > > > > >=20
> > > > > > > Thanks for tracking that down!
> > > > > > >=20
> > > > > > > > To ease the situation at least a little bit, we should gi=
ve the child
> > > > > > > > process at least some few more time slices before we kill=
 it with
> > > > > > > > SIGTERM and then with SIGKILL. With this change, the avoc=
ado test now
> > > > > > > > succeeds here in 10 out of 10 runs.
> > > > > > > >=20
> > > > > > > > Signed-off-by: Thomas Huth <thuth@redhat.com>
> > > > > > > > ---
> > > > > > > >  io/channel-command.c | 6 +++---
> > > > > > > >  1 file changed, 3 insertions(+), 3 deletions(-)
> > > > > > > >=20
> > > > > > > > diff --git a/io/channel-command.c b/io/channel-command.c
> > > > > > > > index 319c5ed..f64db3e 100644
> > > > > > > > --- a/io/channel-command.c
> > > > > > > > +++ b/io/channel-command.c
> > > > > > > > @@ -177,11 +177,11 @@ static int qio_channel_command_abor=
t(QIOChannelCommand *ioc,
> > > > > > > >              return -1;
> > > > > > > >          }
> > > > > > > >      } else if (ret =3D=3D 0) {
> > > > > > > > -        if (step =3D=3D 0) {
> > > > > > > > +        if (step =3D=3D 4) {
> > > > > > > >              kill(ioc->pid, SIGTERM);
> > > > > > > > -        } else if (step =3D=3D 1) {
> > > > > > > > +        } else if (step =3D=3D 8) {
> > > > > > > >              kill(ioc->pid, SIGKILL);
> > > > > > > > -        } else {
> > > > > > > > +        } else if (step >=3D 9) {
> > > > > > >=20
> > > > > > > Hmm.  This seems pretty arbitrary; if I understand correctl=
y you're
> > > > > > > saying it'll get a SIGTERM after 4 (arbitrary) * 10ms (arbi=
trary).
> > > > > > >=20
> > > > > > > Who is to say that's enough for a scp or gzip or the like?
> > > > > >=20
> > > > > > We could conceivably implement the  qio_channel_shutdown() op=
eration
> > > > > > for the QIOChannelCommand class. It would merely close the FD=
 to the
> > > > > > child process, but leave it running. That would give it time =
to read
> > > > > > any data still in the pipe from QEMU IIUC.
> > > > >=20
> > > > > Yeh that's better; although when would we call shutdown or clos=
e on it?
> > > >=20
> > > > Doesn't QEMU alredy use  shutdown() during the right part of migr=
ation,
> > > > or is that only wrt post-copy ?
> > >=20
> > > We only use it for cancel and errors, not during the normal behavio=
ur.
> >=20
> > So we could do with shutdown() for sake of post-copy anyway, but for
> > normal behaviour maybe the right answer is for close() to just wait a
> > real long time for the child app to exit ?  If we close the pipes, an=
d
> > then wait 5 seconds or more before giving up ?
>=20
> Yes, I'm happier with a much longer arbitrary value than a short
> arbitrary value; but I do wonder if there's any real need to kill it.

If we don't kill it, then if it gets stuck for some reason it will live
forever. If we don't kill it but just close the FD, then we still need
to waitpid at some point otherwise we get a zombie - unless we decide
to daemonize the child instead ?

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
