Received: from eggs.gnu.org ([2001:4830:134:3::10]:58230)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fNbe8-0000Qv-Hj
	for qemu-devel@nongnu.org; Tue, 29 May 2018 06:14:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fNbe6-00044R-M3
	for qemu-devel@nongnu.org; Tue, 29 May 2018 06:14:28 -0400
References: <20180518180440-mutt-send-email-mst@kernel.org>
	<20180524113251.GB4660@redhat.com>
	<d9bb2cb9-d9dc-8fe0-a767-10d9cbbab803@redhat.com>
	<20180528183058.GG2209@redhat.com>
	<20180528183833.GJ4580@localhost.localdomain>
	<20180528212054.GH2209@redhat.com> <20180528212510.GC4660@redhat.com>
	<20180529064415.GA4756@localhost.localdomain>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <2b3eef00-f326-c1e6-0e4b-b7602646eec4@redhat.com>
Date: Tue, 29 May 2018 12:14:15 +0200
MIME-Version: 1.0
In-Reply-To: <20180529064415.GA4756@localhost.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="I9sRc29YoERn9EnHfCfTWCPiumGzCNhuf"
Subject: Re: [Qemu-devel] storing machine data in qcow images?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, "Richard W.M. Jones" <rjones@redhat.com>
Cc: ehabkost@redhat.com, qemu-block@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org, stefanha@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--I9sRc29YoERn9EnHfCfTWCPiumGzCNhuf
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, "Richard W.M. Jones" <rjones@redhat.com>
Cc: ehabkost@redhat.com, qemu-block@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
 stefanha@redhat.com
Message-ID: <2b3eef00-f326-c1e6-0e4b-b7602646eec4@redhat.com>
Subject: Re: [Qemu-devel] storing machine data in qcow images?
References: <20180518180440-mutt-send-email-mst@kernel.org>
 <20180524113251.GB4660@redhat.com>
 <d9bb2cb9-d9dc-8fe0-a767-10d9cbbab803@redhat.com>
 <20180528183058.GG2209@redhat.com>
 <20180528183833.GJ4580@localhost.localdomain>
 <20180528212054.GH2209@redhat.com> <20180528212510.GC4660@redhat.com>
 <20180529064415.GA4756@localhost.localdomain>
In-Reply-To: <20180529064415.GA4756@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-05-29 08:44, Kevin Wolf wrote:
> Am 28.05.2018 um 23:25 hat Richard W.M. Jones geschrieben:
>> On Mon, May 28, 2018 at 10:20:54PM +0100, Richard W.M. Jones wrote:
>>> On Mon, May 28, 2018 at 08:38:33PM +0200, Kevin Wolf wrote:
>>>> Just accessing the image file within a tar archive is possible and w=
e
>>>> could write a block driver for that (I actually think we should do
>>>> this), but it restricts you because certain operations like resizing=

>>>> aren't really possible in tar. Unfortunately, resizing is a really
>>>> common operation for non-raw image formats.
>>>
>>> We do this already in virt-v2v (using file.offset and file.size
>>> parameters in the raw driver).
>>>
>>> For virt-v2v we only need to read the source so resizing isn't an
>>> issue.  For most of the cases we're talking about the downloaded imag=
e
>>> would also be a template / base image, so I suppose only reading woul=
d
>>> be required too.
>>>
>>> I also wrote an nbdkit tar file driver (supports writes, but not
>>> resizing).
>>> https://manpages.debian.org/testing/nbdkit-plugin-perl/nbdkit-tar-plu=
gin.1.en.html
>>
>> I should add the other thorny issue with OVA files is that the
>> metadata contains a checksum (SHA1 or SHA256) of the disk images.  If
>> you modify the disk images in-place in the tar file then you need to
>> recalculate those.
>=20
> All of this means that OVA isn't really well suited to be used as a
> native format for VM configuration + images. It's just for sharing
> read-only images that are converted into another native format before
> they are used.
>=20
> Which is probably fair for the use case it was made for, but means that=

> we need something else to solve our problem.

Maybe we should first narrow down our problem.  Maybe you have done that
already, but I'm quite in the dark still.

The original problem was that you need to supply a machine type to qemu,
and that multiple common architectures now have multiple machine types
and not necessarily all work with a single image.  So far so good, but I
have two issues here already:

(1) How is qemu supposed to interpret that information?  If it's stored
in the image file, I don't see a nice way of retrieving it before the
machine is initialized, at least not with qemu's current architecture.
Once we support configuring qemu solely through QMP, sure, you can do a
blockdev-add and then build the machine accordingly.  But that is not
here today, and I'm not sure this is a good idea either, because that
would mean automagic defaults for the machine-building QMP commands
derived from the blockdev-add earlier, which should get a plain "No".
Also, having to use QMP to build your machine wouldn't make anything
easier; at least not easier than just supplying a configuration file
along with the image.

(Building the magic into -blockdev might be less horrible, but such
magic (adding block devices influences machine defaults) to me still
doesn't seem worth not having to supply a config file along with the
disk image.)

(2) Again, I personally just really don't like saving such information
in a disk image.  One actual argument I can bring up for that distaste
is this: Suppose, you have multiple images attached to your VM.  Now the
VM wants to store the machine type.  Where does it go?  Into all of
them?  But some of those images may only contain data and might be
intended to be shared between multiple VMs.  So those shouldn't receive
the mark.  Only disks with binaries should receive them.
But what if those binaries are just cross-compiled binaries for some
other VM?  Oh no, so not even binaries are a sure indicator...  So I
have no idea where the information is supposed to be stored.  In any
case, "the first image" just gets an outright "no" from me, and "all
images" gets an "I don't think this is a good idea".

Loading is fun, too.  OK, so you attach multiple disk images to a VM.
Oops, they have varying machine type information...  Now what?  Use the
information from the first one?  Definitely no.  Just ignore all of the
information in such a case and have the user supply the machine type
again?  Possible, but it seems weird to me that qemu would usually guess
the machine type, but once you attach some random other image to it, it
suddenly fails to do that.  But maybe it's just me who thinks this is wei=
rd.


OK, so let's go a step further.  We have stored the machine type
information in order to not have to supply a config file with the qcow2
image -- because if we did, it could just contain the machine type and
that would be it.

So to me it follows naturally that just storing the machine type doesn't
make much sense if we cannot also store more VM configuration in a qcow2
file, because I don't see why you should be able to ship an image
without a config file only if all you need to supply is a machine type.
Often, you also need to supply how much memory the VM needs (which
depends on the OS on the image) or what storage controller to use (does
the OS have virtio drivers? (to be fair, it usually does, because you're
supplying a VM image in the first place)).

So I think if we decide to store the machine type, that is kind of a
slippery slope and then there are good arguments for storing even more
configuration options in the file, too.  But I really, really don't like
that.

For one thing, I suspect it to get really ugly implementation-wise.
Getting the machine type out of a disk image and actually interpreting
it automatically is bad enough, but getting possibly everything out of
it?  It's not going to be any better.

For another, how do we store the data?  key-value seems wrong if we want
to store everything.  JSON might be fine.  But eventually we just want
basically a qemu configuration file in there, I would think (which may
support JSON at some point?).   So basically we would store the data as
a binary blob and let the rest of qemu do its thing with it.  But then
please tell me why I fought so valiantly against storing random bitmaps
in qcow2 files.  I hate the idea of making qcow2 a random archive
format.  We have tar for that.


Unless I have got something terribly wrong (which is indeed a
possibility!), to me this proposal means basically to turn qcow2 into
(1) a VM description format for qemu, and (2) to turn it into an archive
format on the way.

As explained, I don't like (2), but it would be necessary for (1), so yea=
h.

As for (1), just why?  I mean, if we want to do that, fine, but on one
hand that is absolutely not what qcow2 is right now (it is a VM-agnostic
disk image format), and on the other I simply don't see any good reason
to.  We have config files for that, they just lack the disk data.  I
don't see the difficulty in having to deal with two files.  And even if
it were too difficult for some people in some cases (to me this is
really hypothetically speaking), I'd rather integrate qcow2 (or any disk
image) into some other descriptive format than adding descriptive
capabilities to qcow2.[1]


tl;dr: I really don't get why it's so hard to supply a config file along
with a qcow2 image.  Is it so hard for people to realize that a VM does
not only consist of a disk?

Max


[1] It isn't like I think integrating disk images into a VM description
format (like config files) is worth doing.  I think having to deal with
multiple files is not an issue whatsoever (but again, this may be
because I haven't understood the problem).  I just think that (1) it
doesn't concern me as someone working on the block layer, because it
wouldn't change anything about qcow2 or the block layer in general, so
go ahead if you want to do anything in an area that doesn't concern me,
and (2) it just seems intuitively more natural to me and I think it
would be much nicer to implement.  So if someone has time to spare to
implement this, I wouldn't oppose it.  But I'm not that someone.


--I9sRc29YoERn9EnHfCfTWCPiumGzCNhuf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlsNJ/cACgkQ9AfbAGHV
z0CdGAf7BvcBhSOaWEafW4ueR0IsT04m4oSGOUB4lY+ZKFJ46vizyZp59yHIVfqg
ynqi53Q35I9Sktov1qhFWkSnbvo5dU7+JAmpOduPikDGcxFQ8hUCcJwXTK+8vsS/
Y1fIlsV4/eMfind/u2wtb3UCUvlGoc1QSigh976Xosi+bYQTnXZfc+pckaKuhzvR
H23wmPvbqftQIncE2a7bwC/V5ggjptmGETcmgGBPY6a7gYbUfQTxR6JOX9vPNu/q
moLOLYbH28yRLFHSvKaqbT08o9F1Te31Wn7IZjqYPqG3VndfPh6vJi/xrQsChnaW
DTG+njkLq0/1iGFqoMC1KFcgZyollA==
=IMMK
-----END PGP SIGNATURE-----

--I9sRc29YoERn9EnHfCfTWCPiumGzCNhuf--
