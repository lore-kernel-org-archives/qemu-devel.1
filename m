Received: from eggs.gnu.org ([2001:4830:134:3::10]:41542)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fQZ1n-00056g-PF
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 10:03:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fQZ1f-0004Jf-GT
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 10:03:07 -0400
Date: Wed, 6 Jun 2018 15:02:33 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20180606140233.GF2660@work-vm>
References: <20180529064415.GA4756@localhost.localdomain>
	<2b3eef00-f326-c1e6-0e4b-b7602646eec4@redhat.com>
	<20180606123237.2235ae4a@kitsune.suse.cz>
	<bc97cdc3-85ba-e053-0816-b6bc431064fb@redhat.com>
	<20180606131929.44d0fd6b@kitsune.suse.cz>
	<93233bff-604b-c891-90ce-64fe1eaaaab5@redhat.com>
	<20180606113720.GA2661@work-vm>
	<2c833e2c-f0bb-ea98-a703-54fb9447bd2f@redhat.com>
	<20180606121624.GD2661@work-vm>
	<2d572c2f-8dda-87db-ec26-6f2230375424@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <2d572c2f-8dda-87db-ec26-6f2230375424@redhat.com>
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
> On 2018-06-06 14:16, Dr. David Alan Gilbert wrote:
> > * Max Reitz (mreitz@redhat.com) wrote:
> >> On 2018-06-06 13:37, Dr. David Alan Gilbert wrote:
> >>> * Max Reitz (mreitz@redhat.com) wrote:
> >>>> On 2018-06-06 13:19, Michal Such=E1nek wrote:
> >>>>> On Wed, 6 Jun 2018 13:02:53 +0200
> >>>>> Max Reitz <mreitz@redhat.com> wrote:
> >>>>>
> >>>>>> On 2018-06-06 12:32, Michal Such=E1nek wrote:
> >>>>>>> On Tue, 29 May 2018 12:14:15 +0200
> >>>>>>> Max Reitz <mreitz@redhat.com> wrote:
> >>
> >> [...]
> >>
> >>>>>>>> Unless I have got something terribly wrong (which is indeed a
> >>>>>>>> possibility!), to me this proposal means basically to turn qcow2
> >>>>>>>> into (1) a VM description format for qemu, and (2) to turn it in=
to
> >>>>>>>> an archive format on the way. =20
> >>>>>>>
> >>>>>>> And if you go all the way you can store multiple disks along with
> >>>>>>> the VM definition so you can have the whole appliance in one file.
> >>>>>>> It conveniently solves the problem of synchronizing snapshots acr=
oss
> >>>>>>> multiple disk images and the question where to store the machine
> >>>>>>> state if you want to suspend it.  =20
> >>>>>>
> >>>>>> Yeah, but why make qcow2 that format?  That's what I completely fa=
il
> >>>>>> to understand.
> >>>>>>
> >>>>>> If you want to have a single VM description file that contains the=
 VM
> >>>>>> configuration and some qcow2/raw/whatever files along with it for =
the
> >>>>>> guest disk data, sure, go ahead.  But why does the format of the w=
hole
> >>>>>> thing need to be qcow2?
> >>>>>
> >>>>> Because then qemu can access the disk data from the image directly
> >>>>> without any need for extraction, copying to different file, etc.
> >>>>
> >>>> This does not explain why it needs to be qcow2.  There is absolutely=
 no
> >>>> reason why you couldn't use qcow2 files in-place inside of another f=
ile.
> >>>
> >>> Because then we'd have to change the whole stack to take advantage of
> >>> that.  Adding a feature into qcow2 means nothing else changes.
> >>
> >> Because it's a hack, right.  Storing binary data in a qcow2 file,
> >> completely ignoring it in qemu (and being completely unusable to any
> >> potential other users of the qcow2 format[1]) and only interpreting it
> >> somewhere up the stack is a hack.
> >=20
> > It's not a hack!
> > Seriously it's not.
> > There's nothing wrong with it being aimed higher up the stack than qemu,
>=20
> Not really, but storing that information in a disk image file is, from
> my perspective.  So far, qcow2 was always just for qemu.  (Hmm...  Maybe
> backing links weren't, but at least they were intended for qemu originall=
y.)
>=20
> So this would mix information for different layers inside qcow2 which to
> me sounds weird.  Maybe I just have to get used to it.

The important point is it's explicitly for a different layer; we're not
mixing it - the guest can never get to this information.  It also saves
the higher level management layers ever having to look at the data the
guest can get to, which is a security advantage.

=46rom my point of view, it really is the sticky label on the disc rather
than the contents of it.

> > the problem we started off with was what happens when a user downloads
> > a VM image and tries to import it into their VM system;
>=20
> Well, the VM system should choke without a config file. O:-)
>=20
> >                                                         weve already
> > got 2+ layers of management stuff in there - I want the information to
> > guide those layers, not form a complete set of configuration.
>=20
> But I do.
>=20
> If we store some information, I don't see why we don't store all of it.

Hmm, now that generally I don't like:
  a) That really would make it hypervisor specific
  b) It would be a lot of data
  c) Generally, the supplier of an image doesn't know how the end-user
     wants it configured - although for some appliances they might.
  d) Remember the only problem we had when we got here was how to stop
     the user shooting themselves in the foot by connecting the wrong
     image to the wrong VM type.  So I'm expecting to use this to
     contain requirements, nothing more.


> >> That is not necessarily a negative point, hacks can work wonderfully
> >> well, and they usually are simple, that is correct.  But the thing is
> >> that I feel like people have grand visions of what to get out of this.
> >> Imagine, a single file that can configure all and any VM!
> >>
> >> But hacks usually only solve a single issue.  Once you try to extend a
> >> hack, it breaks down and becomes insufficient.
> >>
> >> If we want a grand vision where a single file stores the whole VM, why
> >> not invest the work and make it right from the start?
> >=20
> > Because we won't get it right; however much we bikeshed about it
> > we'll just end up with a mess.
>=20
> Sure, but the same thing applies to putting it into qcow2.  The
> difference is, for something outside of qcow2, throwing it away and
> starting over is simple.
>=20
> When putting it into qcow2, we can only do that if we really just put a
> binary blob there that isn't described in the specification.

Well, it's why I'm going for defined key/values that are stored in the
blob and only a few of them.  We've got a reasonable chance of being
able to define what we want from 3-4 key/values, it should be a lot
easier than trying to define a grand scheme.

> >                                  The right thing is to put in something
> > to hold configuration and then review the items of configuration we
> > add properly as we define them.
>=20
> OK, but review them on what terms?  Whether they are simple enough?

Well, I'll take simple, make sense - whatever - feel free to be the
maintainer for that list!

> As I said, I would want a whole configuration if we allow some
> configuration.

Well then you could go for libvirt XML as the contents; but I think
that's crossing layers even more.
(I would have veered more to it being exactly the same as an OVA
description except for rjones dislike of it)

> (More below)
>=20
> >> [1] Yes, I concede that there are probably no other users of qcow2.  B=
ut
> >> please forgive me for assuming that qcow2 was in a sense designed to be
> >> a rather general image format that not only qemu could use.
> >=20
> > What makes it QEMU specific?  It's basically just the same key/value
> > setup as OVA, except putting them inside the qcow2.
>=20
> Well, not necessarily qemu-specific, but
> ${management_software}-specific, which comes down to the same.  Or,
> well, I'd think that, but hold on.
>=20
> > We could use the same keys/value definitions as OVA in the blob,
> > although their definitions aren't very portable either.
>=20
> So you're proposing that we only add options that seem portable for any V=
M?

Hmm.  We should probably split them, so there should be general options
(e.g. minimum-ram) but also hypervisor specifics
(qemu.machine-class=3Dq35); but that doesn't mean you can't add keys
for multiple hypervisors into the one blob.  I mean
something like:
    minimum-ram =3D 1G
    qemu.machine-class =3D q35
    anothervm.machine-class =3D ....

Dave

> Max
>=20



--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
