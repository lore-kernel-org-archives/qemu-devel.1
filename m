Received: from eggs.gnu.org ([2001:4830:134:3::10]:47882)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <msuchanek@suse.de>) id 1fQVkR-0003qD-34
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 06:33:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <msuchanek@suse.de>) id 1fQVkP-0008Um-J5
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 06:32:59 -0400
Date: Wed, 6 Jun 2018 12:32:37 +0200
From: Michal =?UTF-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>
Message-ID: <20180606123237.2235ae4a@kitsune.suse.cz>
In-Reply-To: <2b3eef00-f326-c1e6-0e4b-b7602646eec4@redhat.com>
References: <20180518180440-mutt-send-email-mst@kernel.org>
	<20180524113251.GB4660@redhat.com>
	<d9bb2cb9-d9dc-8fe0-a767-10d9cbbab803@redhat.com>
	<20180528183058.GG2209@redhat.com>
	<20180528183833.GJ4580@localhost.localdomain>
	<20180528212054.GH2209@redhat.com>
	<20180528212510.GC4660@redhat.com>
	<20180529064415.GA4756@localhost.localdomain>
	<2b3eef00-f326-c1e6-0e4b-b7602646eec4@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	boundary="Sig_/9N9wat.8SzLbjz4CuG2Q2Ow";
	protocol="application/pgp-signature"
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
Cc: Kevin Wolf <kwolf@redhat.com>, "Richard W.M. Jones" <rjones@redhat.com>, qemu-devel@nongnu.org, stefanha@redhat.com, ehabkost@redhat.com, qemu-block@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>

--Sig_/9N9wat.8SzLbjz4CuG2Q2Ow
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Tue, 29 May 2018 12:14:15 +0200
Max Reitz <mreitz@redhat.com> wrote:

> On 2018-05-29 08:44, Kevin Wolf wrote:
> > Am 28.05.2018 um 23:25 hat Richard W.M. Jones geschrieben: =20
> >> On Mon, May 28, 2018 at 10:20:54PM +0100, Richard W.M. Jones
> >> wrote: =20
> >>> On Mon, May 28, 2018 at 08:38:33PM +0200, Kevin Wolf wrote: =20
> >>>> Just accessing the image file within a tar archive is possible
> >>>> and we could write a block driver for that (I actually think we
> >>>> should do this), but it restricts you because certain operations
> >>>> like resizing aren't really possible in tar. Unfortunately,
> >>>> resizing is a really common operation for non-raw image
> >>>> formats. =20
> >>>
> >>> We do this already in virt-v2v (using file.offset and file.size
> >>> parameters in the raw driver).
> >>>
> >>> For virt-v2v we only need to read the source so resizing isn't an
> >>> issue.  For most of the cases we're talking about the downloaded
> >>> image would also be a template / base image, so I suppose only
> >>> reading would be required too.
> >>>
> >>> I also wrote an nbdkit tar file driver (supports writes, but not
> >>> resizing).
> >>> https://manpages.debian.org/testing/nbdkit-plugin-perl/nbdkit-tar-plu=
gin.1.en.html =20
> >>
> >> I should add the other thorny issue with OVA files is that the
> >> metadata contains a checksum (SHA1 or SHA256) of the disk images.
> >> If you modify the disk images in-place in the tar file then you
> >> need to recalculate those. =20
> >=20
> > All of this means that OVA isn't really well suited to be used as a
> > native format for VM configuration + images. It's just for sharing
> > read-only images that are converted into another native format
> > before they are used.
> >=20
> > Which is probably fair for the use case it was made for, but means
> > that we need something else to solve our problem. =20
>=20
> Maybe we should first narrow down our problem.  Maybe you have done
> that already, but I'm quite in the dark still.
>=20
> The original problem was that you need to supply a machine type to
> qemu, and that multiple common architectures now have multiple
> machine types and not necessarily all work with a single image.  So
> far so good, but I have two issues here already:
>=20
> (1) How is qemu supposed to interpret that information?  If it's
> stored in the image file, I don't see a nice way of retrieving it
> before the machine is initialized, at least not with qemu's current
> architecture. Once we support configuring qemu solely through QMP,
> sure, you can do a blockdev-add and then build the machine
> accordingly.  But that is not here today, and I'm not sure this is a
> good idea either, because that would mean automagic defaults for the
> machine-building QMP commands derived from the blockdev-add earlier,
> which should get a plain "No". Also, having to use QMP to build your
> machine wouldn't make anything easier; at least not easier than just
> supplying a configuration file along with the image.
>=20
> (Building the magic into -blockdev might be less horrible, but such
> magic (adding block devices influences machine defaults) to me still
> doesn't seem worth not having to supply a config file along with the
> disk image.)
>=20
> (2) Again, I personally just really don't like saving such information
> in a disk image.  One actual argument I can bring up for that distaste
> is this: Suppose, you have multiple images attached to your VM.  Now
> the VM wants to store the machine type.  Where does it go?  Into all
> of them?  But some of those images may only contain data and might be
> intended to be shared between multiple VMs.  So those shouldn't
> receive the mark.  Only disks with binaries should receive them.
> But what if those binaries are just cross-compiled binaries for some
> other VM?  Oh no, so not even binaries are a sure indicator...  So I
> have no idea where the information is supposed to be stored.  In any
> case, "the first image" just gets an outright "no" from me, and "all
> images" gets an "I don't think this is a good idea".
>=20
> Loading is fun, too.  OK, so you attach multiple disk images to a VM.
> Oops, they have varying machine type information...  Now what?  Use
> the information from the first one?  Definitely no.  Just ignore all
> of the information in such a case and have the user supply the
> machine type again?  Possible, but it seems weird to me that qemu
> would usually guess the machine type, but once you attach some random
> other image to it, it suddenly fails to do that.  But maybe it's just
> me who thinks this is weird.
>=20
>=20
> OK, so let's go a step further.  We have stored the machine type
> information in order to not have to supply a config file with the
> qcow2 image -- because if we did, it could just contain the machine
> type and that would be it.
>=20
> So to me it follows naturally that just storing the machine type
> doesn't make much sense if we cannot also store more VM configuration
> in a qcow2 file, because I don't see why you should be able to ship
> an image without a config file only if all you need to supply is a
> machine type. Often, you also need to supply how much memory the VM
> needs (which depends on the OS on the image) or what storage
> controller to use (does the OS have virtio drivers? (to be fair, it
> usually does, because you're supplying a VM image in the first
> place)).
>=20
> So I think if we decide to store the machine type, that is kind of a
> slippery slope and then there are good arguments for storing even more
> configuration options in the file, too.  But I really, really don't
> like that.
>=20
> For one thing, I suspect it to get really ugly implementation-wise.
> Getting the machine type out of a disk image and actually interpreting
> it automatically is bad enough, but getting possibly everything out of
> it?  It's not going to be any better.
>=20
> For another, how do we store the data?  key-value seems wrong if we
> want to store everything.  JSON might be fine.  But eventually we
> just want basically a qemu configuration file in there, I would think
> (which may support JSON at some point?).   So basically we would
> store the data as a binary blob and let the rest of qemu do its thing
> with it.  But then please tell me why I fought so valiantly against
> storing random bitmaps in qcow2 files. =20

Yes, I wonder. Why did you?

> I hate the idea of making qcow2 a random archive format.

What's wrong with that?

> We have tar for that.

It does not support expanding the stored files.

>=20
>=20
> Unless I have got something terribly wrong (which is indeed a
> possibility!), to me this proposal means basically to turn qcow2 into
> (1) a VM description format for qemu, and (2) to turn it into an
> archive format on the way.

And if you go all the way you can store multiple disks along with the
VM definition so you can have the whole appliance in one file. It
conveniently solves the problem of synchronizing snapshots across
multiple disk images and the question where to store the machine state
if you want to suspend it.=20

Thanks

Michal

--Sig_/9N9wat.8SzLbjz4CuG2Q2Ow
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJbF7hQAAoJEFCz6i1PzvpbX5UH/ApKpRkXJC5UM0lsyxbhZ8vK
eQ7lqIp0IKExxYoPFDOvoCGKKtlnWi24s1Dm/3YcetbOQJNZYykEy87vXd3bBRsI
Zbj4uOvDRdqfdyoBxC0XKCf3yE/+B2/ET1W0r4deiLvp4+gOncNU9lCWs0/8h6RG
ywLSufqHDWqrySfKSBbONOikAz5Cyntco1td256dUAibfsBWieOhv4hyURstPOtw
Ebsm6m0EoMb01fFlwL37x164OWmYVKfwfGovZbFdjD7LNHIX4vFCYQLBmvlWViKt
vd93RgxD3LrVH7iuLaVkAxhdt7NBNZ1F1SRTJUwiHw58cwpHl2U8EsysgQ6AhQQ=
=MMH2
-----END PGP SIGNATURE-----

--Sig_/9N9wat.8SzLbjz4CuG2Q2Ow--
