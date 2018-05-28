Received: from eggs.gnu.org ([2001:4830:134:3::10]:39498)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fNMbU-0005Hl-Uc
	for qemu-devel@nongnu.org; Mon, 28 May 2018 14:10:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fNMbT-0006pT-Tg
	for qemu-devel@nongnu.org; Mon, 28 May 2018 14:10:44 -0400
References: <20180518180440-mutt-send-email-mst@kernel.org>
	<20180524113251.GB4660@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <d9bb2cb9-d9dc-8fe0-a767-10d9cbbab803@redhat.com>
Date: Mon, 28 May 2018 20:10:32 +0200
MIME-Version: 1.0
In-Reply-To: <20180524113251.GB4660@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="ZptIavVqAedT2Q5o4IL2MofYtSD4MmvnW"
Subject: Re: [Qemu-devel] storing machine data in qcow images?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Richard W.M. Jones" <rjones@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: ehabkost@redhat.com, stefanha@redhat.com, kwolf@redhat.com, qemu-devel@nongnu.org, qemu-block@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ZptIavVqAedT2Q5o4IL2MofYtSD4MmvnW
From: Max Reitz <mreitz@redhat.com>
To: "Richard W.M. Jones" <rjones@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
Cc: ehabkost@redhat.com, stefanha@redhat.com, kwolf@redhat.com,
 qemu-devel@nongnu.org, qemu-block@nongnu.org
Message-ID: <d9bb2cb9-d9dc-8fe0-a767-10d9cbbab803@redhat.com>
Subject: Re: [Qemu-devel] storing machine data in qcow images?
References: <20180518180440-mutt-send-email-mst@kernel.org>
 <20180524113251.GB4660@redhat.com>
In-Reply-To: <20180524113251.GB4660@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-05-24 13:32, Richard W.M. Jones wrote:
> I read the whole thread and the fundamental problem is that you're
> mixing layers.  Let qcow2 be a disk image format, and let management
> layers deal with metadata and how to run qemu.
>=20
> What's going to happen when you have (eg) an OVA file containing qcow2
> files, and the qcow2 files all have different metadata from each other
> and from the actual metadata in the OVA?  Even the case where you've
> got =E2=80=98-hda file1.qcow2 -hdb file2.qcow2=E2=80=99 is not properly=
 defined.  What
> happens if someone uses =E2=80=98-M mach1 -hda file.qcow2=E2=80=99 and =
the machine
> type in the qcow2 file conflicts with the command line?
>=20
> BTW we have a tooling (libguestfs) which can tell you what devices are
> supported by the guest.  virt-v2v already uses libguestfs to find out
> the full list of devices supported by guests, and uses that to drive
> conversion.  At some point we're going to extend virt-inspector to
> make this a bit easier (patches and other contributions welcome,
> there's a huge list of work to do on libguestfs and not enough
> developers to get through it).
>=20
> There is however a seed of a good idea in the thread:
>=20
>> I don't think QEMU needs to use this information automatically,
>> necessarily.  I think the first step is to simply make QEMU save
>> this information in the disk image, and making qemu-img able to
>> read and write this information.
>=20
> It would be nice if qcow2 added arbitrary data sections (which would
> always be ignored by qemu) for storing additional data.  This could be
> used to create a compact qcow2 + metadata format to rival OVA for
> management layers to use, and there are various other uses too.

As an extremist on the "qcow2 is an image data format and as such should
only store data that is relevant to the virtual disk" front, I don't see
the appeal.

As someone who is just naive and doesn't see the big picture, I don't
see what's wrong with using a tar file that contains the image and
additional data.  I shudder to imagine integrating the qcow2 driver so
deeply into qemu that various parts all over qemu just use it to store
some data.  I can't help but feel reminded of the HMP savevm command
that just randomly chooses some qcow2 image to store the VM state in.

At least you're talking about just storing data.  I imagine opening a
qcow2 image, then reading some VM configuration, and spreading the
gospel through the rest of the qemu process to initialize everything
would be anything but nice.

I personally don't see why it is so bad to split the information between
two files.  Honestly, if you want to put disk images and VM
configuration into a single file, I'd do it backwards: Put the disk
image into the configuration file.

Max


--ZptIavVqAedT2Q5o4IL2MofYtSD4MmvnW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlsMRhgACgkQ9AfbAGHV
z0C8OQf/Rrf2okkkWoqy/HZbUXs25Xl6dMfFmnVP0SoU6vvdUHLEdCw33xcemEMc
f1DisRYqfRiQUxo4BOsqdXAERVHox7fR4KB5zpTBt3CSXSSwLXQ+O0QJ+RcG1+ob
zxZf92y335+Z1Xn0ONuMt8TODGZYbE9DWF6Va+6I0hZSTFXh5c9k17Yuze/bVfPY
w9YROlKTmZ6KyNuugQKb0hJPBiITs+nRKQm4q1HuDzYrd1NuPtwWTCtjfHGcNAmZ
li+irFz7HWKRCnjCGF0u8quT1KZeGPuD14rrmk0j5FuTNL5mqOu+MYl3B0oudHk4
KZNE3rlPOMI/PDboORTn0eBxRxHP7Q==
=sbqK
-----END PGP SIGNATURE-----

--ZptIavVqAedT2Q5o4IL2MofYtSD4MmvnW--
