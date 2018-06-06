Received: from eggs.gnu.org ([2001:4830:134:3::10]:60863)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fQWkv-0005u1-PB
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 07:37:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fQWkt-0004u7-Ol
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 07:37:33 -0400
Date: Wed, 6 Jun 2018 12:37:21 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20180606113720.GA2661@work-vm>
References: <20180528183058.GG2209@redhat.com>
	<20180528183833.GJ4580@localhost.localdomain>
	<20180528212054.GH2209@redhat.com>
	<20180528212510.GC4660@redhat.com>
	<20180529064415.GA4756@localhost.localdomain>
	<2b3eef00-f326-c1e6-0e4b-b7602646eec4@redhat.com>
	<20180606123237.2235ae4a@kitsune.suse.cz>
	<bc97cdc3-85ba-e053-0816-b6bc431064fb@redhat.com>
	<20180606131929.44d0fd6b@kitsune.suse.cz>
	<93233bff-604b-c891-90ce-64fe1eaaaab5@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <93233bff-604b-c891-90ce-64fe1eaaaab5@redhat.com>
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
Cc: Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>, Kevin Wolf <kwolf@redhat.com>, ehabkost@redhat.com, qemu-block@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, "Richard W.M. Jones" <rjones@redhat.com>, qemu-devel@nongnu.org, stefanha@redhat.com

* Max Reitz (mreitz@redhat.com) wrote:
> On 2018-06-06 13:19, Michal Such=E1nek wrote:
> > On Wed, 6 Jun 2018 13:02:53 +0200
> > Max Reitz <mreitz@redhat.com> wrote:
> >=20
> >> On 2018-06-06 12:32, Michal Such=E1nek wrote:
> >>> On Tue, 29 May 2018 12:14:15 +0200
> >>> Max Reitz <mreitz@redhat.com> wrote:
> >>>  =20
> >>>> On 2018-05-29 08:44, Kevin Wolf wrote: =20
> >>>>> Am 28.05.2018 um 23:25 hat Richard W.M. Jones geschrieben:   =20
> >>>>>> On Mon, May 28, 2018 at 10:20:54PM +0100, Richard W.M. Jones
> >>>>>> wrote:   =20
> >>>>>>> On Mon, May 28, 2018 at 08:38:33PM +0200, Kevin Wolf wrote:   =20
> >>>>>>>> Just accessing the image file within a tar archive is possible
> >>>>>>>> and we could write a block driver for that (I actually think w=
e
> >>>>>>>> should do this), but it restricts you because certain
> >>>>>>>> operations like resizing aren't really possible in tar.
> >>>>>>>> Unfortunately, resizing is a really common operation for
> >>>>>>>> non-raw image formats.   =20
> >>>>>>>
> >>>>>>> We do this already in virt-v2v (using file.offset and file.size
> >>>>>>> parameters in the raw driver).
> >>>>>>>
> >>>>>>> For virt-v2v we only need to read the source so resizing isn't
> >>>>>>> an issue.  For most of the cases we're talking about the
> >>>>>>> downloaded image would also be a template / base image, so I
> >>>>>>> suppose only reading would be required too.
> >>>>>>>
> >>>>>>> I also wrote an nbdkit tar file driver (supports writes, but no=
t
> >>>>>>> resizing).
> >>>>>>> https://manpages.debian.org/testing/nbdkit-plugin-perl/nbdkit-t=
ar-plugin.1.en.html   =20
> >>>>>>
> >>>>>> I should add the other thorny issue with OVA files is that the
> >>>>>> metadata contains a checksum (SHA1 or SHA256) of the disk images=
.
> >>>>>> If you modify the disk images in-place in the tar file then you
> >>>>>> need to recalculate those.   =20
> >>>>>
> >>>>> All of this means that OVA isn't really well suited to be used as
> >>>>> a native format for VM configuration + images. It's just for
> >>>>> sharing read-only images that are converted into another native
> >>>>> format before they are used.
> >>>>>
> >>>>> Which is probably fair for the use case it was made for, but mean=
s
> >>>>> that we need something else to solve our problem.   =20
> >>>>
> >>>> Maybe we should first narrow down our problem.  Maybe you have don=
e
> >>>> that already, but I'm quite in the dark still.
> >>>>
> >>>> The original problem was that you need to supply a machine type to
> >>>> qemu, and that multiple common architectures now have multiple
> >>>> machine types and not necessarily all work with a single image.  S=
o
> >>>> far so good, but I have two issues here already:
> >>>>
> >>>> (1) How is qemu supposed to interpret that information?  If it's
> >>>> stored in the image file, I don't see a nice way of retrieving it
> >>>> before the machine is initialized, at least not with qemu's curren=
t
> >>>> architecture. Once we support configuring qemu solely through QMP,
> >>>> sure, you can do a blockdev-add and then build the machine
> >>>> accordingly.  But that is not here today, and I'm not sure this is
> >>>> a good idea either, because that would mean automagic defaults for
> >>>> the machine-building QMP commands derived from the blockdev-add
> >>>> earlier, which should get a plain "No". Also, having to use QMP to
> >>>> build your machine wouldn't make anything easier; at least not
> >>>> easier than just supplying a configuration file along with the
> >>>> image.
> >>>>
> >>>> (Building the magic into -blockdev might be less horrible, but suc=
h
> >>>> magic (adding block devices influences machine defaults) to me
> >>>> still doesn't seem worth not having to supply a config file along
> >>>> with the disk image.)
> >>>>
> >>>> (2) Again, I personally just really don't like saving such
> >>>> information in a disk image.  One actual argument I can bring up
> >>>> for that distaste is this: Suppose, you have multiple images
> >>>> attached to your VM.  Now the VM wants to store the machine type.
> >>>> Where does it go?  Into all of them?  But some of those images may
> >>>> only contain data and might be intended to be shared between
> >>>> multiple VMs.  So those shouldn't receive the mark.  Only disks
> >>>> with binaries should receive them. But what if those binaries are
> >>>> just cross-compiled binaries for some other VM?  Oh no, so not
> >>>> even binaries are a sure indicator...  So I have no idea where the
> >>>> information is supposed to be stored.  In any case, "the first
> >>>> image" just gets an outright "no" from me, and "all images" gets
> >>>> an "I don't think this is a good idea".
> >>>>
> >>>> Loading is fun, too.  OK, so you attach multiple disk images to a
> >>>> VM. Oops, they have varying machine type information...  Now
> >>>> what?  Use the information from the first one?  Definitely no.
> >>>> Just ignore all of the information in such a case and have the
> >>>> user supply the machine type again?  Possible, but it seems weird
> >>>> to me that qemu would usually guess the machine type, but once you
> >>>> attach some random other image to it, it suddenly fails to do
> >>>> that.  But maybe it's just me who thinks this is weird.
> >>>>
> >>>>
> >>>> OK, so let's go a step further.  We have stored the machine type
> >>>> information in order to not have to supply a config file with the
> >>>> qcow2 image -- because if we did, it could just contain the machin=
e
> >>>> type and that would be it.
> >>>>
> >>>> So to me it follows naturally that just storing the machine type
> >>>> doesn't make much sense if we cannot also store more VM
> >>>> configuration in a qcow2 file, because I don't see why you should
> >>>> be able to ship an image without a config file only if all you
> >>>> need to supply is a machine type. Often, you also need to supply
> >>>> how much memory the VM needs (which depends on the OS on the
> >>>> image) or what storage controller to use (does the OS have virtio
> >>>> drivers? (to be fair, it usually does, because you're supplying a
> >>>> VM image in the first place)).
> >>>>
> >>>> So I think if we decide to store the machine type, that is kind of
> >>>> a slippery slope and then there are good arguments for storing
> >>>> even more configuration options in the file, too.  But I really,
> >>>> really don't like that.
> >>>>
> >>>> For one thing, I suspect it to get really ugly implementation-wise=
.
> >>>> Getting the machine type out of a disk image and actually
> >>>> interpreting it automatically is bad enough, but getting possibly
> >>>> everything out of it?  It's not going to be any better.
> >>>>
> >>>> For another, how do we store the data?  key-value seems wrong if w=
e
> >>>> want to store everything.  JSON might be fine.  But eventually we
> >>>> just want basically a qemu configuration file in there, I would
> >>>> think (which may support JSON at some point?).   So basically we
> >>>> would store the data as a binary blob and let the rest of qemu do
> >>>> its thing with it.  But then please tell me why I fought so
> >>>> valiantly against storing random bitmaps in qcow2 files.   =20
> >>>
> >>> Yes, I wonder. Why did you? =20
> >>
> >> That was mostly directed at Kevin.
> >>
> >> My reasoning was that a qcow2 file is a disk image.  All data stored
> >> therein should be immediately associated with the stored data.
> >> Another reason was that from the perspective of qcow2 you don't lose
> >> anything by tying the bitmaps directly to that data; all we lost was
> >> the capability of storing bitmaps for unrelated raw files.
> >>
> >> (And the reasoning for that is "if you want features, use qcow2" --
> >> although R/W backing files may loosen that phrase.)
> >>
> >>>> I hate the idea of making qcow2 a random archive format. =20
> >>>
> >>> What's wrong with that? =20
> >>
> >> The fact that qcow2 isn't.
> >>
> >> From my perspective it would increase the format's complexity to a
> >> point where you could just create a new format altogether.  Well,
> >> actually, all you do is design a filesystem (or reuse an existing
> >> one).
> >>
> >>>> We have tar for that. =20
> >>>
> >>> It does not support expanding the stored files. =20
> >>
> >> Nor does qcow2, because it does not support storing files at all.
> >=20
> > AFAICT from the previous discussion it already does allow storing
> > multiple data streams that can be changed independently so it basical=
ly
> > is an archive format or filesystem except the streams are not named n=
or
> > easily accessible separately outside of qemu.
>=20
> I don't quite understand what you are referring to.  We have snapshots,
> we have bitmaps, yes, but all of that are related directly to the store=
d
> guest disk data.
>=20
> The only thing we currently have in qcow2 that is opaque is the VM stat=
e
> that can be stored in snapshots (and don't hold me responsible for that=
).
>=20
> >> Secondly, that completely depends on how you use it.  You can freely
> >> expand the last file in the archive, for instance.  Also I've seen
> >> people store files in chunks so they can indeed resize it.
> >>
> >> (I'm wondering if we could write a block driver that could provide
> >> such a chunk allocation transparently to qcow2...  Note that a qcow2
> >> file does not need to be continuous, so you could in theory indeed
> >> store the qcow2 file and its data in completely separate places in a
> >> tar file.)
> >=20
> > Which basically invents another new filesystem on top of tar for no
> > good reason. Especially when we have already support for storage form=
at
> > that is capable enough.
>=20
> No different from inventing a filesystem on top of qcow2.
>=20
> I don't think qcow2 is any more capable than tar.
>=20
> >> What I'm trying to get at is that qcow2 was not designed to be a
> >> container format for arbitrary files.  If you want to make it such,
> >> I'm sure there are existing formats that work better.
> >=20
> > Such as?
>=20
> ext2?
>=20
> It seems to me that you want to make qcow2 a filesystem.  Sure, the FS
> we'd end up with would probably be simpler than ext2, but I assume
> thanks to feature creep we'd eventually end up with a qcow2 format that
> is a worse FS than real FS (especially performance-wise), but that is
> similarly complex.
>=20
> >>>> Unless I have got something terribly wrong (which is indeed a
> >>>> possibility!), to me this proposal means basically to turn qcow2
> >>>> into (1) a VM description format for qemu, and (2) to turn it into
> >>>> an archive format on the way. =20
> >>>
> >>> And if you go all the way you can store multiple disks along with
> >>> the VM definition so you can have the whole appliance in one file.
> >>> It conveniently solves the problem of synchronizing snapshots acros=
s
> >>> multiple disk images and the question where to store the machine
> >>> state if you want to suspend it.  =20
> >>
> >> Yeah, but why make qcow2 that format?  That's what I completely fail
> >> to understand.
> >>
> >> If you want to have a single VM description file that contains the V=
M
> >> configuration and some qcow2/raw/whatever files along with it for th=
e
> >> guest disk data, sure, go ahead.  But why does the format of the who=
le
> >> thing need to be qcow2?
> >=20
> > Because then qemu can access the disk data from the image directly
> > without any need for extraction, copying to different file, etc.
>=20
> This does not explain why it needs to be qcow2.  There is absolutely no
> reason why you couldn't use qcow2 files in-place inside of another file=
.

Because then we'd have to change the whole stack to take advantage of
that.  Adding a feature into qcow2 means nothing else changes.

Dave

> Max
>=20


--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
