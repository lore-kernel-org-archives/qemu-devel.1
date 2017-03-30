Received: from eggs.gnu.org ([2001:4830:134:3::10]:50998)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ctPdg-00033Q-3D
	for qemu-devel@nongnu.org; Wed, 29 Mar 2017 22:16:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ctPdc-0005VJ-34
	for qemu-devel@nongnu.org; Wed, 29 Mar 2017 22:16:40 -0400
References: <CAO_EM_=wECMYRRaDyPtY8sKFZF8owp0u2sE4k_oeS=BLF9B2Mw@mail.gmail.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <67b441ce-ee18-c6d5-df5f-224439214ab8@redhat.com>
Date: Wed, 29 Mar 2017 21:16:26 -0500
MIME-Version: 1.0
In-Reply-To: <CAO_EM_=wECMYRRaDyPtY8sKFZF8owp0u2sE4k_oeS=BLF9B2Mw@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="1wkAGxe1nsnneQNs5wvhuvNuV9Dhv5KnG"
Subject: Re: [Qemu-devel] New iotest repros failures on virtio external
 snapshot with iothread
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ed Swierk <eswierk@skyportsystems.com>, Fam Zheng <famz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--1wkAGxe1nsnneQNs5wvhuvNuV9Dhv5KnG
From: Eric Blake <eblake@redhat.com>
To: Ed Swierk <eswierk@skyportsystems.com>, Fam Zheng <famz@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Message-ID: <67b441ce-ee18-c6d5-df5f-224439214ab8@redhat.com>
Subject: Re: [Qemu-devel] New iotest repros failures on virtio external
 snapshot with iothread
References: <CAO_EM_=wECMYRRaDyPtY8sKFZF8owp0u2sE4k_oeS=BLF9B2Mw@mail.gmail.com>
In-Reply-To: <CAO_EM_=wECMYRRaDyPtY8sKFZF8owp0u2sE4k_oeS=BLF9B2Mw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/29/2017 09:01 PM, Ed Swierk via Qemu-devel wrote:
> Parts of qemu's block code have changed a lot in recent months but are
> not well exercised by current tests.
>=20
> Subtle bugs have crept in causing assertion failures, hangs and other
> crashes in a variety of situations: immediately on start, on first
> guest activity, on external snapshot create or commit, on qmp quit
> command.
>=20
> Reproducing these bugs has proved tricky, as each may occur only with
> a specific combination of qemu version, block device type (virtio-blk
> or virtio-scsi) and iothread enabled or not. In some cases the bug
> occurs only after several external snapshot operations. And in some
> cases the bug only manifests when a guest is accessing the block
> device simultaneously.
>=20
> I've written an iotest (number 176, for now) that attempts to cover

At least one other thread has already proposed a test 176.  It's
somewhat straightforward to renumber things, but I'm wondering if there
is some even-more-efficient way of reserving test numbers, perhaps
through the wiki, since we are finding that test numbers get reserved
several weeks before actually getting merged into the tree.

> many of these configurations. Currently it only exercises the external
> snapshot create and commit lifted from iotest 118. The new iotest does
> this repeatedly in each of 16 combinations:
> - no guest / guest
> - virtio-blk / virtio-scsi
> - no iothread / iothread
> - single / repeated external snapshot create+commit
>=20
> I made some minor changes to the test infrastructure so the new iotest
> can deal gracefully with qemu hanging--the test script itself
> shouldn't hang. And in all failure modes the test needs to expose
> enough console output and other information to diagnose the problem.

Some of those changes sound like they are worth posting to the list
as-is, separate from the actual new test.

>=20
> The main departure from existing iotests is running a real guest. I
> used buildroot to generate a small (~4 MB) Linux kernel with built-in
> initrd containing a busybox-based userland. After the iotest launches
> qemu, the guest loops writing to the block device, while the test
> performs snapshot operations.
>=20
> I ran the new iotest on 3 qemu versions: 2.7.1, stable-2.8-staging and
> 2.9.0-rc2. The latter two fail several test cases, all
> iothread-enabled. Only 2.7.1 passes all the cases.
>=20
> Here is the code for the new iotest (I didn't dare email patches with
> a 4 MB blob):
> https://github.com/skyportsystems/qemu-1/commits/eswierk-iotests-2.7
> https://github.com/skyportsystems/qemu-1/commits/eswierk-iotests-2.8
> https://github.com/skyportsystems/qemu-1/commits/eswierk-iotests-2.9
>=20
> And here is the buildroot I used to generate the guest Linux kernel+ini=
trd:
> https://github.com/skyportsystems/buildroot-1/commits/qemu-iotests
>=20
> Please check out the code and try the new test--particularly anyone
> who can also help figure out these failures. (Note that since half the
> test cases use an iothread, /dev/kvm must be readable and writable.)
>=20
> * stable-2.8-staging
> - guest, virtio-blk, iothread, single snapshot create+commit: hang on
> quit (intermittent)
> - guest, virtio-blk, iothread, repeated snapshot create+commit: hang
> after 1 iteration
> - guest, virtio-scsi, iothread, single snapshot create+commit: hang on
> quit (intermittent)
> - guest, virtio-scsi, iothread, repeated snapshot create+commit: hang
> after 1 iteration
>=20
> * 2.9.0-rc2
> - guest, virtio-blk, iothread, single snapshot create+commit:
> "include/block/aio.h:457: aio_enable_external: Assertion
> `ctx->external_disable_cnt > 0' failed." after snapshot create

It would be nice if we could get to the root cause and squash that one
before 2.9.

> - guest, virtio-blk, iothread, repeated snapshot create+commit: same as=
 above
> - guest, virtio-scsi, iothread, single snapshot create+commit: same as =
above
> - guest, virtio-scsi, iothread, repeated snapshot create+commit: same a=
s above
> - no guest, virtio-blk, iothread, repeated snapshot create+commit: same=
 as above
> - no guest, virtio-scsi, iothread, single snapshot create+commit: same =
as above
> - no guest, virtio-scsi, iothread, repeated snapshot create+commit:
> same as above
>=20
> --Ed
>=20
>=20

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--1wkAGxe1nsnneQNs5wvhuvNuV9Dhv5KnG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJY3Gp7AAoJEKeha0olJ0Nqdo0IAJOnz68SkMOgRgktZvyZ5f2h
3cAXHzfp+pVEYvUlf2OYhR0BI5zuAND8JgUxycnez1FR0tDaADMU54r/1a7xskNr
dZTYxzcJSSMAdvyRTlOI067GDHvT4QE9asFAEJ/zYZjgYrs6u9ZYWAXZF4wLc189
TM758oNwlh/Vx2WGvtnwwAcs4cekrtRLTBI4PSWevrYVaucjJmOJS9L9B4DMMaIb
o7YYhs2xO2GqOvGSe9i9RZ1Pn93pBoULP+ZxaEOdcHtEk3vwqmivkq0rZSw1myfT
xL2hKTZmZix6UzkqqiRodBbpkKolkPcLxYIeSV7qI0dnsheQUcOMCVKP212Udck=
=4aqG
-----END PGP SIGNATURE-----

--1wkAGxe1nsnneQNs5wvhuvNuV9Dhv5KnG--
