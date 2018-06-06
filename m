Received: from eggs.gnu.org ([2001:4830:134:3::10]:52203)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fQZdQ-0000QX-21
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 10:42:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fQZdN-0006eo-Uz
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 10:42:00 -0400
Date: Wed, 6 Jun 2018 15:41:41 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20180606144140.GH2660@work-vm>
References: <20180606123237.2235ae4a@kitsune.suse.cz>
	<bc97cdc3-85ba-e053-0816-b6bc431064fb@redhat.com>
	<20180606131929.44d0fd6b@kitsune.suse.cz>
	<93233bff-604b-c891-90ce-64fe1eaaaab5@redhat.com>
	<20180606113720.GA2661@work-vm>
	<2c833e2c-f0bb-ea98-a703-54fb9447bd2f@redhat.com>
	<20180606121624.GD2661@work-vm>
	<2d572c2f-8dda-87db-ec26-6f2230375424@redhat.com>
	<20180606140233.GF2660@work-vm>
	<66366ae1-1db8-7121-bfcc-f2096d0c954f@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <66366ae1-1db8-7121-bfcc-f2096d0c954f@redhat.com>
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
> On 2018-06-06 16:02, Dr. David Alan Gilbert wrote:
> > * Max Reitz (mreitz@redhat.com) wrote:
> >> On 2018-06-06 14:16, Dr. David Alan Gilbert wrote:
> >>> * Max Reitz (mreitz@redhat.com) wrote:
> >>>> On 2018-06-06 13:37, Dr. David Alan Gilbert wrote:
> >>>>> * Max Reitz (mreitz@redhat.com) wrote:
> >>>>>> On 2018-06-06 13:19, Michal Such=E1nek wrote:
> >>>>>>> On Wed, 6 Jun 2018 13:02:53 +0200
> >>>>>>> Max Reitz <mreitz@redhat.com> wrote:
> >>>>>>>
> >>>>>>>> On 2018-06-06 12:32, Michal Such=E1nek wrote:
> >>>>>>>>> On Tue, 29 May 2018 12:14:15 +0200
> >>>>>>>>> Max Reitz <mreitz@redhat.com> wrote:
> >>>>
> >>>> [...]
> >>>>
> >>>>>>>>>> Unless I have got something terribly wrong (which is indeed =
a
> >>>>>>>>>> possibility!), to me this proposal means basically to turn q=
cow2
> >>>>>>>>>> into (1) a VM description format for qemu, and (2) to turn i=
t into
> >>>>>>>>>> an archive format on the way. =20
> >>>>>>>>>
> >>>>>>>>> And if you go all the way you can store multiple disks along =
with
> >>>>>>>>> the VM definition so you can have the whole appliance in one =
file.
> >>>>>>>>> It conveniently solves the problem of synchronizing snapshots=
 across
> >>>>>>>>> multiple disk images and the question where to store the mach=
ine
> >>>>>>>>> state if you want to suspend it.  =20
> >>>>>>>>
> >>>>>>>> Yeah, but why make qcow2 that format?  That's what I completel=
y fail
> >>>>>>>> to understand.
> >>>>>>>>
> >>>>>>>> If you want to have a single VM description file that contains=
 the VM
> >>>>>>>> configuration and some qcow2/raw/whatever files along with it =
for the
> >>>>>>>> guest disk data, sure, go ahead.  But why does the format of t=
he whole
> >>>>>>>> thing need to be qcow2?
> >>>>>>>
> >>>>>>> Because then qemu can access the disk data from the image direc=
tly
> >>>>>>> without any need for extraction, copying to different file, etc=
.
> >>>>>>
> >>>>>> This does not explain why it needs to be qcow2.  There is absolu=
tely no
> >>>>>> reason why you couldn't use qcow2 files in-place inside of anoth=
er file.
> >>>>>
> >>>>> Because then we'd have to change the whole stack to take advantag=
e of
> >>>>> that.  Adding a feature into qcow2 means nothing else changes.
> >>>>
> >>>> Because it's a hack, right.  Storing binary data in a qcow2 file,
> >>>> completely ignoring it in qemu (and being completely unusable to a=
ny
> >>>> potential other users of the qcow2 format[1]) and only interpretin=
g it
> >>>> somewhere up the stack is a hack.
> >>>
> >>> It's not a hack!
> >>> Seriously it's not.
> >>> There's nothing wrong with it being aimed higher up the stack than =
qemu,
> >>
> >> Not really, but storing that information in a disk image file is, fr=
om
> >> my perspective.  So far, qcow2 was always just for qemu.  (Hmm...  M=
aybe
> >> backing links weren't, but at least they were intended for qemu orig=
inally.)
> >>
> >> So this would mix information for different layers inside qcow2 whic=
h to
> >> me sounds weird.  Maybe I just have to get used to it.
> >=20
> > The important point is it's explicitly for a different layer; we're n=
ot
> > mixing it - the guest can never get to this information.
>=20
> Neither can it get to bitmaps, but bitmaps are still for qemu.
>=20
> >                                                           It also sav=
es
> > the higher level management layers ever having to look at the data th=
e
> > guest can get to, which is a security advantage.
>=20
> Er, well, yes, but guessing configuration options from the guest disk
> contents is definitely a bad idea, I agree on that anyway.
>=20
> > From my point of view, it really is the sticky label on the disc rath=
er
> > than the contents of it.
>=20
> Sure, which is why I wouldn't put it in qcow2.  Content and meta-conten=
t
> is what qcow2 currently stores, but not how to use it.
>=20
> >>> the problem we started off with was what happens when a user downlo=
ads
> >>> a VM image and tries to import it into their VM system;
> >>
> >> Well, the VM system should choke without a config file. O:-)
> >>
> >>>                                                         weve alread=
y
> >>> got 2+ layers of management stuff in there - I want the information=
 to
> >>> guide those layers, not form a complete set of configuration.
> >>
> >> But I do.
> >>
> >> If we store some information, I don't see why we don't store all of =
it.
> >=20
> > Hmm, now that generally I don't like:
>=20
> Me neither.
>=20
> >   a) That really would make it hypervisor specific
>=20
> Yes.
>=20
> >   b) It would be a lot of data
>=20
> Yes.
>=20
> >   c) Generally, the supplier of an image doesn't know how the end-use=
r
> >      wants it configured - although for some appliances they might.
>=20
> Well, yes.  But just storing very basic information limits the use case
> to a very basic case anyway, doesn't it?  So this wouldn't be worse.
>=20
> Everything beyond a very basic use case can expect the user to take 30
> seconds to download and pass a config file.
>=20
> >   d) Remember the only problem we had when we got here was how to sto=
p
> >      the user shooting themselves in the foot by connecting the wrong
> >      image to the wrong VM type.
>=20
> Hm.  How exactly is that shooting yourself in the foot?  Won't it just
> not work?
>=20
> >                                   So I'm expecting to use this to
> >      contain requirements, nothing more.
>=20
> I assumed you'd want to relieve users of having to specify config
> options in basic use cases.  This is why I believed it would be natural
> to expand that scope.
>=20
> So why is it so dangerous to connect a disk you just downloaded to e.g.
> the wrong machine type?  I assumed it just wouldn't work and you'd try
> again, until you realized that maybe you should read the download
> description and do as it says ("download this config file, pass it").

That's bad!  Stuff should just-work; it currently just works, things
should get better and easier for our users.  And anyway, not working for
EFI for exmaple can be just a blank screen.  Seriously - keep it easy
for the user!

And with 'pc' type VMs being all that's around it does just-work.

> >>>> That is not necessarily a negative point, hacks can work wonderful=
ly
> >>>> well, and they usually are simple, that is correct.  But the thing=
 is
> >>>> that I feel like people have grand visions of what to get out of t=
his.
> >>>> Imagine, a single file that can configure all and any VM!
> >>>>
> >>>> But hacks usually only solve a single issue.  Once you try to exte=
nd a
> >>>> hack, it breaks down and becomes insufficient.
> >>>>
> >>>> If we want a grand vision where a single file stores the whole VM,=
 why
> >>>> not invest the work and make it right from the start?
> >>>
> >>> Because we won't get it right; however much we bikeshed about it
> >>> we'll just end up with a mess.
> >>
> >> Sure, but the same thing applies to putting it into qcow2.  The
> >> difference is, for something outside of qcow2, throwing it away and
> >> starting over is simple.
> >>
> >> When putting it into qcow2, we can only do that if we really just pu=
t a
> >> binary blob there that isn't described in the specification.
> >=20
> > Well, it's why I'm going for defined key/values that are stored in th=
e
> > blob and only a few of them.  We've got a reasonable chance of being
> > able to define what we want from 3-4 key/values, it should be a lot
> > easier than trying to define a grand scheme.
>=20
> Yes, as long as we can agree on how we can justify to future generation=
s
> why we really only want these very few very specific values.
>=20
> >>>                                  The right thing is to put in somet=
hing
> >>> to hold configuration and then review the items of configuration we
> >>> add properly as we define them.
> >>
> >> OK, but review them on what terms?  Whether they are simple enough?
> >=20
> > Well, I'll take simple, make sense - whatever - feel free to be the
> > maintainer for that list!
>=20
> OK, none. :-P
>=20
> It would need to be a very strict requirement, in any case.  Just
> "simple" or "dense" do not suffice, because those can be stretched.
>=20
> >> As I said, I would want a whole configuration if we allow some
> >> configuration.
> >=20
> > Well then you could go for libvirt XML as the contents; but I think
> > that's crossing layers even more.
> > (I would have veered more to it being exactly the same as an OVA
> > description except for rjones dislike of it)
>=20
> Well, the format doesn't really matter for now, I think it's most
> important to first talk about what kind of scope we want.
>=20
> >> (More below)
> >>
> >>>> [1] Yes, I concede that there are probably no other users of qcow2=
.  But
> >>>> please forgive me for assuming that qcow2 was in a sense designed =
to be
> >>>> a rather general image format that not only qemu could use.
> >>>
> >>> What makes it QEMU specific?  It's basically just the same key/valu=
e
> >>> setup as OVA, except putting them inside the qcow2.
> >>
> >> Well, not necessarily qemu-specific, but
> >> ${management_software}-specific, which comes down to the same.  Or,
> >> well, I'd think that, but hold on.
> >>
> >>> We could use the same keys/value definitions as OVA in the blob,
> >>> although their definitions aren't very portable either.
> >>
> >> So you're proposing that we only add options that seem portable for =
any VM?
> >=20
> > Hmm.  We should probably split them, so there should be general optio=
ns
> > (e.g. minimum-ram) but also hypervisor specifics
> > (qemu.machine-class=3Dq35); but that doesn't mean you can't add keys
> > for multiple hypervisors into the one blob.  I mean
> > something like:
> >     minimum-ram =3D 1G
> >     qemu.machine-class =3D q35
> >     anothervm.machine-class =3D ....
>=20
> Well, and that's my issue.  Once you have application-specific info, yo=
u
> can go wild.  And I would go wild, without a reasonable and strict
> requirement that the information we want to store has to fulfill.
>=20
> For the record, I would've liked it if you'd said "only portable
> options".  But I would have replied that I would fear we'd still end up
> with someone saying "I'd like to store X and Y, let's just put them int=
o
> the specification, then they are portable [even if only this stack
> supports them]" and we wouldn't really have won anything.

I couldn't second guess every other hypervisor on the planet to know
whether specifying a machine class would work for them.

Dave

> Max
>=20



--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
