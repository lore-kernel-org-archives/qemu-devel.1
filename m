Received: from eggs.gnu.org ([2001:4830:134:3::10]:54526)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1elciP-00032q-Ji
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 10:41:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1elciL-0004XT-MM
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 10:41:53 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:54410 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1elciL-0004X6-F3
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 10:41:49 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id EACBB40FB648
	for <qemu-devel@nongnu.org>; Tue, 13 Feb 2018 15:41:48 +0000 (UTC)
Date: Tue, 13 Feb 2018 15:41:45 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20180213154145.GJ2378@work-vm>
References: <1518531279-11966-1-git-send-email-thuth@redhat.com>
	<20180213150911.GG2378@work-vm> <20180213151125.GQ573@redhat.com>
	<20180213152529.GH2378@work-vm> <20180213152753.GR573@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20180213152753.GR573@redhat.com>
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
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, Juan Quintela <quintela@redhat.com>, =?utf-8?B?THVrw6HFoQ==?= Doktor <ldoktor@redhat.com>, Cornelia Huck <cohuck@redhat.com>

* Daniel P. Berrang=E9 (berrange@redhat.com) wrote:
> On Tue, Feb 13, 2018 at 03:25:30PM +0000, Dr. David Alan Gilbert wrote:
> > * Daniel P. Berrang=E9 (berrange@redhat.com) wrote:
> > > On Tue, Feb 13, 2018 at 03:09:12PM +0000, Dr. David Alan Gilbert wr=
ote:
> > > > * Thomas Huth (thuth@redhat.com) wrote:
> > > > > We are currently facing some migration failure on s390x when ru=
nning
> > > > > certain avocado tests, e.g. when running the test
> > > > > type_specific.io-github-autotest-qemu.migrate.with_reboot.exec.=
gzip_exec.
> > > > > This test is using 'migrate -d "exec:nc localhost 5200"' for th=
e migration.
> > > > > The problem is detected at the receiving side, where the migrat=
ion stream
> > > > > apparently ends too early. However, the cause for the problem i=
s the
> > > > > sending side: After writing the migration stream into the pipe =
to netcat,
> > > > > the source QEMU calls qio_channel_command_close() which closes =
the pipe
> > > > > and immediately (!) kills the child process afterwards. So if t=
he
> > > > > sending netcat did not read the final bytes from the pipe yet, =
or
> > > > > if it did not manage to send out all its buffers yet, it is kil=
led
> > > > > before the whole migration stream is passed to the destination =
side.
> > > >=20
> > > > Thanks for tracking that down!
> > > >=20
> > > > > To ease the situation at least a little bit, we should give the=
 child
> > > > > process at least some few more time slices before we kill it wi=
th
> > > > > SIGTERM and then with SIGKILL. With this change, the avocado te=
st now
> > > > > succeeds here in 10 out of 10 runs.
> > > > >=20
> > > > > Signed-off-by: Thomas Huth <thuth@redhat.com>
> > > > > ---
> > > > >  io/channel-command.c | 6 +++---
> > > > >  1 file changed, 3 insertions(+), 3 deletions(-)
> > > > >=20
> > > > > diff --git a/io/channel-command.c b/io/channel-command.c
> > > > > index 319c5ed..f64db3e 100644
> > > > > --- a/io/channel-command.c
> > > > > +++ b/io/channel-command.c
> > > > > @@ -177,11 +177,11 @@ static int qio_channel_command_abort(QIOC=
hannelCommand *ioc,
> > > > >              return -1;
> > > > >          }
> > > > >      } else if (ret =3D=3D 0) {
> > > > > -        if (step =3D=3D 0) {
> > > > > +        if (step =3D=3D 4) {
> > > > >              kill(ioc->pid, SIGTERM);
> > > > > -        } else if (step =3D=3D 1) {
> > > > > +        } else if (step =3D=3D 8) {
> > > > >              kill(ioc->pid, SIGKILL);
> > > > > -        } else {
> > > > > +        } else if (step >=3D 9) {
> > > >=20
> > > > Hmm.  This seems pretty arbitrary; if I understand correctly you'=
re
> > > > saying it'll get a SIGTERM after 4 (arbitrary) * 10ms (arbitrary)=
.
> > > >=20
> > > > Who is to say that's enough for a scp or gzip or the like?
> > >=20
> > > We could conceivably implement the  qio_channel_shutdown() operatio=
n
> > > for the QIOChannelCommand class. It would merely close the FD to th=
e
> > > child process, but leave it running. That would give it time to rea=
d
> > > any data still in the pipe from QEMU IIUC.
> >=20
> > Yeh that's better; although when would we call shutdown or close on i=
t?
>=20
> Doesn't QEMU alredy use  shutdown() during the right part of migration,
> or is that only wrt post-copy ?

We only use it for cancel and errors, not during the normal behaviour.

Dave

>=20
>=20
> Regards,
> Daniel
> --=20
> |: https://berrange.com      -o-    https://www.flickr.com/photos/dberr=
ange :|
> |: https://libvirt.org         -o-            https://fstop138.berrange=
.com :|
> |: https://entangle-photo.org    -o-    https://www.instagram.com/dberr=
ange :|
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
