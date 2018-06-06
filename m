Received: from eggs.gnu.org ([2001:4830:134:3::10]:55163)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fQb1M-0006g7-P3
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 12:10:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fQb1L-0007M0-5I
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 12:10:48 -0400
Date: Wed, 6 Jun 2018 13:10:31 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180606161031.GT7451@localhost.localdomain>
References: <20180606123237.2235ae4a@kitsune.suse.cz>
	<bc97cdc3-85ba-e053-0816-b6bc431064fb@redhat.com>
	<20180606131929.44d0fd6b@kitsune.suse.cz>
	<93233bff-604b-c891-90ce-64fe1eaaaab5@redhat.com>
	<20180606134327.05de9616@kitsune.suse.cz>
	<94cea1d9-d934-85d1-66d4-dbfc82b8dd53@redhat.com>
	<20180606141356.0b86d6b4@kitsune.suse.cz>
	<95f92a95-6592-27a2-a822-d3a047cf8339@redhat.com>
	<20180606154510.24be6ceb@kitsune.suse.cz>
	<d2b5d074-4052-a5fb-4048-cc30ad092f0f@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <d2b5d074-4052-a5fb-4048-cc30ad092f0f@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] storing machine data in qcow images?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>, Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, "Richard W.M. Jones" <rjones@redhat.com>, qemu-devel@nongnu.org, stefanha@redhat.com

On Wed, Jun 06, 2018 at 04:17:14PM +0200, Max Reitz wrote:
> On 2018-06-06 15:45, Michal Such=E1nek wrote:
> > On Wed, 6 Jun 2018 15:14:03 +0200
> > Max Reitz <mreitz@redhat.com> wrote:
> >=20
> >> On 2018-06-06 14:13, Michal Such=E1nek wrote:
> >>> On Wed, 6 Jun 2018 13:52:35 +0200
> >>> Max Reitz <mreitz@redhat.com> wrote:
> >>>  =20
> >>>> On 2018-06-06 13:43, Michal Such=E1nek wrote: =20
> >>>>> On Wed, 6 Jun 2018 13:32:47 +0200
> >>>>> Max Reitz <mreitz@redhat.com> wrote:
> >>>>>    =20
> >>>>>> On 2018-06-06 13:19, Michal Such=E1nek wrote:   =20
> >>>>>>> On Wed, 6 Jun 2018 13:02:53 +0200
> >>>>>>> Max Reitz <mreitz@redhat.com> wrote: =20
> >>
> >> [...]
> >>
> >>>>>>>> What I'm trying to get at is that qcow2 was not designed to be
> >>>>>>>> a container format for arbitrary files.  If you want to make i=
t
> >>>>>>>> such, I'm sure there are existing formats that work
> >>>>>>>> better.     =20
> >>>>>>>
> >>>>>>> Such as?     =20
> >>>>>>
> >>>>>> ext2?   =20
> >>>>>
> >>>>> So you want an ext2 driver in qemu instead of expanding qcow2 to
> >>>>> work not only for a single disk but also for an appliance?   =20
> >>>>
> >>>> Yes, because ext2 was designed to be a proper filesystem.  I'm not
> >>>> an FS designer.  Well, not a good one anyway.  So I don't trust
> >>>> myself on extending qcow2 to be a good FS -- and why would I, when
> >>>> there are already numerous FS around. =20
> >>>
> >>> Do you expect that performance of qemu using qcow2 driver over ext2
> >>> driver will be better than using qcow driver directly with some par=
t
> >>> semi-permanently occupied by a configuration blob? My bet is not. =20
> >>
> >> If you want to store multiple disk images in a single file?  I would
> >> think so, yes.  With qcow2, I would assume it leads to
> >> fragmentation. =20
> >=20
> > How is that different from single disk divided into two partitions
> > internally (without any knowledge on the qcow2 level)?
>=20
> From how it's going to be fragmented, there is no difference.  If you
> have multiple partitions and write to them concurrently, thus allocatin=
g
> new areas, you get bad fragmentation.
>=20
> >> I would hope that proper filesystems can mitigate this.
> >=20
> > Not really. Not without much complexity and repeated maintenance.
>=20
> Yes, a proper filesystem.  Which we'd get for free with multiple files.
>=20
> >>> The ext* drivers are designed to work with kernel VM infrastructure
> >>> which must be tuned for different usage scenarios and you would
> >>> have to duplicate that tuning in qemu to get competitive
> >>> performance. Also you get qcow2 and ext2 metadata which must be
> >>> allocated, managed, etc. You get more storage and performance
> >>> overhead for no good reason. =20
> >>
> >> Yes, there is a good reason.  You can add arbitrary configuration
> >> options without having to worry about me.
> >=20
> > But I will not be able to use the images in qemu so it will be useles=
s.
>=20
> Neither can you with the current proposal because that is about adding
> management layer configuration options which are opaque to qemu.
>=20
> > Well, there is FUSE and that is certainly blazing fast and ubiquitous=
,
> > I am sure.
>=20
> If you want to use pre-existing drivers, you'd probably use a loop devi=
ce.
>=20
> Otherwise, you'd use the block layer for accessing the disk.
>=20
> If you want blazingly fast, you probably won't use qcow2 anyway.  Or,
> funnily enough, you'd want to probably split the qcow2 file into a
> metadata and a data file, so you get even more files.  (But that is a
> proposal for the future.)
>=20
> >> Seriously, though, a real FS would allow you to be more expressive a=
nd
> >> really do what you want without having to work around the quirks tha=
t
> >> adding a not-real-FS in the most simple way possible to qcow2 would
> >> bring with it.
> >>
> >> Because this is part of my fear, that we now add a very simple blob
> >> for just a sprinkle of data.  But over time it gets more and more
> >> complex because we want to store more and more data to make things
> >> ever more convenient[1], we notice that we need more features, the
> >> format gets more complex, and in the end we have an FS that is just
> >> worse than a real FS.
> >>
> >> [1] And note that if I'm convinced to store VM configuration data in
> >> qemu, I will agree that we can store any data in there and it would =
be
> >> nice if any VM could be provisioned and used that way.
> >>
> >>> On the other hand, qcow is designed for storing VM disk data and
> >>> hopefully was tuned to do that decently over the years. The primary
> >>> use case remains storing VM disk data. Adding a configuration blob
> >>> does not change that. =20
> >>
> >> True.  So the argument is that qcow2 may be worse for storing
> >> arbitrary data, but we don't have performance requirements for that;
> >> but we do have performance requirements for disk data and adding
> >> another format below qcow2 will not make it better.
> >>
> >> I do think it is possible to not make things worse with a format und=
er
> >> qcow2, but that may require additional complexity, that you think is
> >> pointless.
> >>
> >> I understand that you think that, but I still believe that putting t=
he
> >> configuration into qcow2 is just the wrong way around and will fall =
on
> >> our feet in the long run.
> >=20
> > I think that *if* we want an 'appliance' format that stores a whole V=
M
> > in a single file to ease VM distribution then the logical place to lo=
ok
> > in qemu is qcow. The reason have been explained at length.
>=20
> The reason being that it's the easiest place, yes.  That doesn't make i=
t
> the best place.
>=20
> > I understand that for some use cases simplifying the distribution of
> > VMs as much as possible is quite important.
>=20
> I don't because still nobody has explained it to me.
>=20
> The only explanation I got so far was "People are lazy and we have
> defaults for everything, so we don't throw an error if people forget to
> pass a configuration file."

People don't pass a configuration file today because there's no
standard for such a configuration file.  qcow2 is already used
today as an appliance file format because there's no better
option.  People download disk images from appliance and OS
providers, import them into a cloud system, and it works out of
the box because (luckily) "pc" is enough for most of them.

We can specify a true appliance file format, and ask people to
use it.  But then providers of single-disk appliances and OSes
will need to publish two appliance images: qcow2 disk image for
old systems that don't support the new format, and one in the new
appliance format, for systems that support it.


>=20
> Which to me still just makes it an inconvenience.

Well, there are small inconveniences and there are big
inconveniences that together make a system unnecessarily hard to
use.  I'd say this one falls somewhere in the middle.


[...]
> I'm noticing a pattern here, and that is that everybody has a different
> opinion on what we actually want in the end, and it's just by chance
> that we find ourselves in two camps ("put it in qcow2" vs. "put it
> somewhere else").
>=20
> Maybe we should first discuss what we actually want before we can
> discuss where to put it.

I'm inclined to agree.  Once we figure out a good VM description
format, we can justify a proposal to allow embedding the VM
description in qcow2 for convenience.

--=20
Eduardo
