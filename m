Received: from eggs.gnu.org ([2001:4830:134:3::10]:35496)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eX3nL-0001F6-HA
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 06:34:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eX3nJ-00015V-AA
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 06:34:47 -0500
Date: Thu, 4 Jan 2018 11:34:35 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20180104113435.GD10106@stefanha-x1.localdomain>
References: <1513595351-5899-1-git-send-email-den@openvz.org>
	<1513595351-5899-2-git-send-email-den@openvz.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="NklN7DEeGtkPCoo3"
Content-Disposition: inline
In-Reply-To: <1513595351-5899-2-git-send-email-den@openvz.org>
Subject: Re: [Qemu-devel] [PATCH 1/5] docs/interop/prl-xml: description of
 Parallels Disk format
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Denis V. Lunev" <den@openvz.org>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, Klim Kireev <klim.kireev@virtuozzo.com>, Edgar Kaziakhmedov <edgar.kaziakhmedov@virtuozzo.com>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>


--NklN7DEeGtkPCoo3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 18, 2017 at 02:09:07PM +0300, Denis V. Lunev wrote:
> From: Klim Kireev <klim.kireev@virtuozzo.com>
>=20
> This patch adds main information about Parallels Disk
> format, which consists of DiskDescriptor.xml and other files.
>=20
> Signed-off-by: Edgar Kaziakhmedov <edgar.kaziakhmedov@virtuozzo.com>
> Signed-off-by: Klim Kireev <klim.kireev@virtuozzo.com>
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> Signed-off-by: Denis V. Lunev <den@openvz.org>
> CC: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  docs/interop/prl-xml.txt | 155 +++++++++++++++++++++++++++++++++++++++++=
++++++
>  1 file changed, 155 insertions(+)
>  create mode 100644 docs/interop/prl-xml.txt
>=20
> diff --git a/docs/interop/prl-xml.txt b/docs/interop/prl-xml.txt
> new file mode 100644
> index 0000000..8ccb91a
> --- /dev/null
> +++ b/docs/interop/prl-xml.txt
> @@ -0,0 +1,155 @@
> +=3D License =3D
> +
> +Copyright (c) 2015 Denis Lunev
> +Copyright (c) 2015 Vladimir Sementsov-Ogievskiy
> +Copyright (c) 2016-2017 Klim Kireev
> +Copyright (c) 2016-2017 Edgar Kaziakhmedov
> +
> +This work is licensed under the terms of the GNU GPL, version 2 or later.
> +See the COPYING file in the top-level directory.
> +
> +This specification contains minimal information about Parallels Disk For=
mat,
> +which is enough to proper work with QEMU. Nevertheless, Parallels Cloud =
Server
> +and Parallels Desktop are able to add some unspecified nodes to xml and =
use
> +them, but they are for internal work and don't affect functionality. Als=
o it
> +uses auxiliary xml "Snapshot.xml", which allows to store optional snapsh=
ot
> +information, but it doesn't influence open/read/write functionality. QEM=
U and
> +other software should not use unspecified here fields and Snapshot.xml f=
ile

s/unspecified here fields/fields not covered in this document/

> +and must leave them as is.
> +
> +=3D Parallels Disk Format =3D
> +
> +Parallels disk consists of two parts: the set of snapshots and the disk
> +descriptor file, which stores information about all files and snapshots.
> +
> +=3D=3D Definitions =3D=3D
> +    Snapshot       a record of the contents captured at a particular tim=
e,
> +                   capable of storing current state. A snapshot has UUID=
 and
> +                   parent UUID.
> +
> + Snapshot image    an overlay representing the difference between this
> +                   snapshot and some earlier snapshot
> +
> +    Overlay        an image storing the different sectors between two ca=
ptured
> +                   states.
> +
> +   Root image      snapshot image without parent, the root of snapshot t=
ree.

s/without parent/with no parent/

> +
> +    Storage        a special conception of data, which consists of disk
> +                   parameters and a list of images. One of this image is=
 root,
> +                   others are overlays. Images must be expandable (paral=
lels
> +                   image file), however root image could be expandable or
> +                   plain. There may be more then one storage in the Para=
llels

s/then/than/

> +                   disk and it is defined as a split image.

I was having trouble understanding this paragraph.  At this point I can
begin to see that split images consist of multiple storages.  That makes
the concept of storage clearer.

Perhaps rephrase this paragraph as:

the backing storage for a subset of the virtual disk.  When there is
more than one storage in a Parallels disk then that is referred to as a
split image.  Each storage consists of disk parameters and a list of
images.  The list of images always contains a root image and may also
contain overlays.  The root image can be an expandable Parallels image
file or plain.  Overlays must be expandable.

> +                   In this case every storage covers specific address
> +                   space area of the disk and has its particular root im=
age.
> +                   Split images are not considered here and isn't suppor=
ted

s/isn't/aren't/

> +                   in QEMU.
> +
> +  Description      DiskDescriptor.xml stores information about disk para=
meters,
> +     file          snapshots, storages.
> +
> +     Top           The overlay between actual state and some previous sn=
apshot.
> +   Snapshot        It is not a snapshot in classical meaning.

To make this clearer the last line could be:

  It is not a snapshot in the classical sense because it serves as the
  active image that the guest writes to.

> +
> +    Sector         a 512-byte data chunk.
> +
> +=3D=3D Description file =3D=3D
> +All information is placed in single XML section Parallels_disk_image.
> +The section has only one attribute "Version", that must be 1.0.
> +General structure of DiskDescriptor.xml:
> +
> +<Parallels_disk_image Version=3D"1.0">
> +    <Disk_Parameters>
> +        ...
> +    </Disk_Parameters>
> +    <StorageData>
> +        ...
> +    </StorageData>
> +    <Snapshots>
> +        ...
> +    </Snapshots>
> +</Parallels_disk_image>
> +
> +=3D=3D Disk_Parameters section =3D=3D
> +The Disk_Parameters section describes the physical layout of the virtual=
 disk
> +and some general settings.
> +
> +The Disk_Parameters section MUST contain the following subsections:
> +    * Disk_size - number of sectors in the disk,
> +                  desired size of the disk
> +    * Cylinders - number of the disk cylinders
> +    * Heads     - number of the disk heads
> +    * Sectors   - number of the disk sectors per cylinder
> +                  (sector size is 512 bytes)
> +                  Limitation: Product of the Heads, Sectors and Cylinders
> +                  values MUST be equal to the value of the Disk_size par=
ameter.
> +    * Padding   - must be 0. Parallels Cloud Server and Parallels Deskto=
p may
> +                  use padding set to 1, however this case is not covered
> +                  by this spec, QEMU and other software should not open
> +                  such disks and should not create them.
> +                  Attention: this field affects the read/write functiona=
lity.

What does "Attention: this field affects the read/write functionality" mean?

> +
> +=3D=3D StorageData section =3D=3D
> +This section of the file describes root image and all snapshot images.

s/root image/the root image/

> +
> +The StorageData section consists of the Storage subsection, as shown bel=
ow:
> +<StorageData>
> +    <Storage>
> +        ...
> +    </Storage>
> +</StorageData>
> +
> +A Storage descriptor consists of the following subsections:
> +    * Start     - start sector of the storage, equals to 0.
> +    * End       - number of sectors in storage, equals to Disk_size.

Just to be clear, if Start > 0 then End is still Disk_size and not Start
+ Disk_size?  Please tweak the wording to make this clear.

> +    * Blocksize - storage cluster size, number of sectors per one cluste=
r.
> +                  Cluster size for each "Compressed" (see below) image in
> +                  parallels disk must be equal to this field. Note: clus=
ter
> +                  size for Parallels Expandable Image is in 'tracks' fie=
ld of
> +                  its header (see docs/interop/parallels.txt).

What is the purpose of this field if the Parallels Expandable Image
header also has the same value?

> +    * Several Image subsections.
> +
> +Each Image section consists of the following subsections:

I'm confused by the use of "section" and "subsections" here.  This spec
is ambiguous and does not describe the XML clearly.  Is a "section"
always an XML tag and a "subsection" is a child XML tag?

In other words, are we talking about:

  <Image>
      <GUID>{12345678-9abc-def1-2345-6789abcdef12}</GUID>
      <Type>Plain</Type>
      <File>my_file</File>
  </Image>

Or could it be:

  <Image GUID=3D"{12345678-9abc-def1-2345-6789abcdef12}"
         Type=3D"Plain"
	 File=3D"my_file" />

?

Please use XML terminology ("tag", "attribute", etc) instead of
"section"/"subsection".

> +    * GUID - image identifier, UUID in curly brackets.
> +             For instance, {12345678-9abc-def1-2345-6789abcdef12}.

How is the GUID used?  Does it need to be validated against the GUID in
the image file?

> +    * Type - image type of the element. It can be:
> +             "Plain" for plain disks.

What is a plain disk?  Is this a raw file or a Parallels Expandable
Image file?

> +             "Compressed" for expanding disks.
> +    * File - path to image file. Path can be relative to DiskDecriptor.x=
ml or
> +             absolute.
> +
> +=3D=3D Snapshots section =3D=3D
> +The Snapshots section describes the snapshot relations with the snapshot=
 tree.
> +
> +The section contains the set of Shot subsections, as shown below:
> +<Snapshots>
> +    <TopGUID> ... </TopGUID> //Optional subsection
> +    <Shot>
> +        ...
> +    </Shot>
> +    <Shot>
> +        ...
> +    </Shot>
> +    ...
> +</Snapshots>
> +
> +Each Shot section contains the following subsections:
> +    * GUID       - an image GUID.
> +    * ParentGUID - GUID of the image of the parent snapshot.
> +
> +The software may traverse snapshots from child to parent using <ParentGU=
ID>
> +field as reference. ParentGUID of root snapshot is
> +{00000000-0000-0000-0000-000000000000}. There should be only one one root
> +snapshot. Top snapshot could be described via two ways: via TopGUID subs=
ection
> +in the Snapshots section or via predefined GUID
> +{5fbaabe3-6958-40ff-92a7-860e329aab41} If TopGUID is defined, predefined=
 GUID is
> +interpreted as usual GUID. All snapshot images (except Top Snapshot) sou=
ld be

s/sould/should/

> +opened read-only.
> +There is another predefined GIUD,

s/GIUD/GUID/

> +BackupID =3D {704718e1-2314-44c8-9087-d78ed36b0f4e}, which is used by or=
iginal and
> +some third-party software for backup, QEMU and other software may operat=
e with
> +images with GUID =3D BackupID as usual, however, it is not recommended t=
o use this
> +GUID for new disks. Top snapshot cannot have this GUID.

> +NOTE: To address top snapshot QEMU supports only predefined GUID mode.

This sounds like an implementation limitation and a spec violation
(since the spec says <TopGUID> may be used).  Please implement <TopGUID>
support unless it's really hard to do, or drop <TopGUID> from this spec
so that it's clear this feature doesn't need to be supported by QEMU and
other open source software.

--NklN7DEeGtkPCoo3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJaThFKAAoJEJykq7OBq3PI0vsH/iTv5TppLTAmBpz2jcXMReHu
ujVDbtpP0Q5rukaXf3XGa0b7/aLE0NRDviBlXFyLOpOONXJiXhovPiZD07cDt97N
w8WE1g3FlALva4xLjnngWDnnMM9WofeRWND/dZtxEuKb0PPX2Y/T5+sCRlbdDCIi
rcXbjibhvtxPr7Uqg6Owom2H9HKFkhDgrdIs6MeBh9q3USEli/hl04kNh2lRCyK8
tJCw4c+61zriL61EddIlEEpkOw4hhWyNchGWOXMfxPsPzfE68mVdkR/Vrp+eIbLt
SI2Xgz3TBumOSA7sTraIe/UCHpf/KFgmGShojx6XHExpaMGZXAa09f9RYPf7djU=
=iWYx
-----END PGP SIGNATURE-----

--NklN7DEeGtkPCoo3--
