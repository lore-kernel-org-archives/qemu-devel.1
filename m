Received: from eggs.gnu.org ([2001:4830:134:3::10]:42632)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1elaaR-0001ui-7z
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 08:25:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1elaaP-0006cn-Rm
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 08:25:31 -0500
Date: Tue, 13 Feb 2018 13:25:11 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180213132511.GL573@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20180107122336.29333-1-richiejp@f-m.fm>
	<fd5f5f12-e081-6f19-54af-3b560139bb78@redhat.com>
	<5cf19623-72ac-fb8b-2054-a60d42419ec6@redhat.com>
	<20180111130427.GG8326@redhat.com>
	<20180213105024.GC5083@localhost.localdomain>
	<20180213114355.GC2378@work-vm> <20180213115102.GF573@redhat.com>
	<20180213132000.GG5083@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180213132000.GG5083@localhost.localdomain>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu-block]  [PATCH 1/2] Add save-snapshot,
 load-snapshot and delete-snapshot to QAPI
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Max Reitz <mreitz@redhat.com>, Richard Palethorpe <richiejp@f-m.fm>, Qemu-block <qemu-block@nongnu.org>, quintela@redhat.com, armbru@redhat.com, qemu-devel@nongnu.org, rpalethorpe@suse.com

On Tue, Feb 13, 2018 at 02:20:00PM +0100, Kevin Wolf wrote:
> Am 13.02.2018 um 12:51 hat Daniel P. Berrang=C3=A9 geschrieben:
> > On Tue, Feb 13, 2018 at 11:43:55AM +0000, Dr. David Alan Gilbert wrot=
e:
> > > * Kevin Wolf (kwolf@redhat.com) wrote:
> > > > Am 11.01.2018 um 14:04 hat Daniel P. Berrange geschrieben:
> > > > > On Thu, Jan 11, 2018 at 01:46:38PM +0100, Max Reitz wrote:
> > > > > > On 2018-01-08 14:52, Eric Blake wrote:
> > > > > > > On 01/07/2018 06:23 AM, Richard Palethorpe wrote:
> > > > > > >> Add QAPI wrapper functions for the existing snapshot funct=
ionality. These
> > > > > > >> functions behave the same way as the HMP savevm, loadvm an=
d delvm
> > > > > > >> commands. This will allow applications, such as OpenQA, to=
 programmatically
> > > > > > >> revert the VM to a previous state with no dependence on HM=
P or qemu-img.
> > > > > > >=20
> > > > > > > That's already possible; libvirt uses QMP's human-monitor-c=
ommand to
> > > > > > > access these HMP commands programmatically.
> > > > > > >=20
> > > > > > > We've had discussions in the past about what it would take =
to have
> > > > > > > specific QMP commands for these operations; the biggest pro=
blem is that
> > > > > > > these commands promote the use of internal snapshots, and t=
here are
> > > > > > > enough performance and other issues with internal snapshots=
 that we are
> > > > > > > not yet ready to commit to a long-term interface for making=
 their use
> > > > > > > easier.  At this point, our recommendation is to prefer ext=
ernal snapshots.
> > > > > >=20
> > > > > > We already have QMP commands for internal snapshots, though. =
 Isn't the
> > > > > > biggest issue that savevm takes too much time to be a synchro=
nous QMP
> > > > > > command?
> > > > >=20
> > > > > Ultimately savevm/loadvm are using much of the migration code i=
nternally,
> > > > > but are not exposed as URI schemes. Could we perhaps take advan=
tage of
> > > > > the internal common layer and define a migration URI scheme
> > > > >=20
> > > > >    snapshot:<name>
> > > > >=20
> > > > > where '<name>' is the name of the internal snapshot in the qcow=
2 file.
> > > >=20
> > > > Let's include a node-name there, please. QEMU automagically decid=
ing
> > > > where to store the VM state is one of the major problems of the H=
MP
> > > > interface.
> > > >=20
> > > > And while we're at it, we can make it more future-proof by allowi=
ng to
> > > > specify arbitrary options:
> > > >=20
> > > >     snapshot:node=3D<node-name>,name=3D<snapshot-name>
> > > >=20
> > > > That would allow us to add something like compressed=3Don|off lat=
er.
> > > > Actually, compressed VM state sounds pretty nice. Why don't we ha=
ve this
> > > > yet? The qcow2 format already provides everything you need for it=
.
> > > >=20
> > > > > Then you could just use the regular migrate QMP commands for lo=
ading
> > > > > and saving snapshots.
> > > >=20
> > > > Yes, you could. I think for a proper implementation you would wan=
t to do
> > > > better, though. Live migration provides just a stream, but that's=
 not
> > > > really well suited for snapshots. When a RAM page is dirtied, you=
 just
> > > > want to overwrite the old version of it in a snapshot, you don't =
want to
> > > > waste space by keeping both the old and the current version of th=
e page
> > > > content in the file.
> > >=20
> > > The current snapshots are run with the CPU paused aren't they?  The=
y
> > > share exactly the same RAM saving code as migration.
> >=20
> > The commands block the monitor too, so I always assumed they were non=
-live
>=20
> Yes, they are non-live, so RAM simply doesn't change and we that's the
> reason why we currently don't get duplicate pages in the snapshot.
>=20
> But as I understand it, the whole point of migrate snapshot:... would b=
e
> to make it live, so the potential duplication is something that we need
> to consider for it.

Yeah, true. Re-writing ram pages in-place could be doable if I added a
feature flag QIO_CHANNEL_FEATURE_SEEKABLE, so the migration code  can
tell if it will just append forever, or can seek back to rewrite.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
