Received: from eggs.gnu.org ([2001:4830:134:3::10]:42974)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fQXMo-0003Bk-O9
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 08:16:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fQXMn-0000Pv-Du
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 08:16:42 -0400
Date: Wed, 6 Jun 2018 13:16:25 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20180606121624.GD2661@work-vm>
References: <20180528212054.GH2209@redhat.com>
	<20180528212510.GC4660@redhat.com>
	<20180529064415.GA4756@localhost.localdomain>
	<2b3eef00-f326-c1e6-0e4b-b7602646eec4@redhat.com>
	<20180606123237.2235ae4a@kitsune.suse.cz>
	<bc97cdc3-85ba-e053-0816-b6bc431064fb@redhat.com>
	<20180606131929.44d0fd6b@kitsune.suse.cz>
	<93233bff-604b-c891-90ce-64fe1eaaaab5@redhat.com>
	<20180606113720.GA2661@work-vm>
	<2c833e2c-f0bb-ea98-a703-54fb9447bd2f@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <2c833e2c-f0bb-ea98-a703-54fb9447bd2f@redhat.com>
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
Cc: Kevin Wolf <kwolf@redhat.com>, ehabkost@redhat.com, qemu-block@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, "Richard W.M. Jones" <rjones@redhat.com>, qemu-devel@nongnu.org, stefanha@redhat.com, Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>

* Max Reitz (mreitz@redhat.com) wrote:
> On 2018-06-06 13:37, Dr. David Alan Gilbert wrote:
> > * Max Reitz (mreitz@redhat.com) wrote:
> >> On 2018-06-06 13:19, Michal Such=E1nek wrote:
> >>> On Wed, 6 Jun 2018 13:02:53 +0200
> >>> Max Reitz <mreitz@redhat.com> wrote:
> >>>
> >>>> On 2018-06-06 12:32, Michal Such=E1nek wrote:
> >>>>> On Tue, 29 May 2018 12:14:15 +0200
> >>>>> Max Reitz <mreitz@redhat.com> wrote:
>=20
> [...]
>=20
> >>>>>> Unless I have got something terribly wrong (which is indeed a
> >>>>>> possibility!), to me this proposal means basically to turn qcow2
> >>>>>> into (1) a VM description format for qemu, and (2) to turn it in=
to
> >>>>>> an archive format on the way. =20
> >>>>>
> >>>>> And if you go all the way you can store multiple disks along with
> >>>>> the VM definition so you can have the whole appliance in one file=
.
> >>>>> It conveniently solves the problem of synchronizing snapshots acr=
oss
> >>>>> multiple disk images and the question where to store the machine
> >>>>> state if you want to suspend it.  =20
> >>>>
> >>>> Yeah, but why make qcow2 that format?  That's what I completely fa=
il
> >>>> to understand.
> >>>>
> >>>> If you want to have a single VM description file that contains the=
 VM
> >>>> configuration and some qcow2/raw/whatever files along with it for =
the
> >>>> guest disk data, sure, go ahead.  But why does the format of the w=
hole
> >>>> thing need to be qcow2?
> >>>
> >>> Because then qemu can access the disk data from the image directly
> >>> without any need for extraction, copying to different file, etc.
> >>
> >> This does not explain why it needs to be qcow2.  There is absolutely=
 no
> >> reason why you couldn't use qcow2 files in-place inside of another f=
ile.
> >=20
> > Because then we'd have to change the whole stack to take advantage of
> > that.  Adding a feature into qcow2 means nothing else changes.
>=20
> Because it's a hack, right.  Storing binary data in a qcow2 file,
> completely ignoring it in qemu (and being completely unusable to any
> potential other users of the qcow2 format[1]) and only interpreting it
> somewhere up the stack is a hack.

It's not a hack!
Seriously it's not.
There's nothing wrong with it being aimed higher up the stack than qemu,
the problem we started off with was what happens when a user downloads
a VM image and tries to import it into their VM system; weve already
got 2+ layers of management stuff in there - I want the information to
guide those layers, not form a complete set of configuration.

> That is not necessarily a negative point, hacks can work wonderfully
> well, and they usually are simple, that is correct.  But the thing is
> that I feel like people have grand visions of what to get out of this.
> Imagine, a single file that can configure all and any VM!
>=20
> But hacks usually only solve a single issue.  Once you try to extend a
> hack, it breaks down and becomes insufficient.
>=20
> If we want a grand vision where a single file stores the whole VM, why
> not invest the work and make it right from the start?

Because we won't get it right; however much we bikeshed about it
we'll just end up with a mess.   The right thing is to put in something
to hold configuration and then review the items of configuration we
add properly as we define them.

> Max
>=20
> [1] Yes, I concede that there are probably no other users of qcow2.  Bu=
t
> please forgive me for assuming that qcow2 was in a sense designed to be
> a rather general image format that not only qemu could use.

What makes it QEMU specific?  It's basically just the same key/value
setup as OVA, except putting them inside the qcow2.
We could use the same keys/value definitions as OVA in the blob,
although their definitions aren't very portable either.

Dave



--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
