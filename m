Received: from eggs.gnu.org ([2001:4830:134:3::10]:47964)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cv5Ip-0002RH-0X
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 12:58:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cv5Il-0001Ds-OG
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 12:58:03 -0400
Date: Mon, 3 Apr 2017 17:57:55 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170403165755.GF3539@stefanha-x1.localdomain>
References: <CAO_EM_=wECMYRRaDyPtY8sKFZF8owp0u2sE4k_oeS=BLF9B2Mw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="mrJd9p1Ce66CJMxE"
Content-Disposition: inline
In-Reply-To: <CAO_EM_=wECMYRRaDyPtY8sKFZF8owp0u2sE4k_oeS=BLF9B2Mw@mail.gmail.com>
Subject: Re: [Qemu-devel] [Qemu-block] New iotest repros failures on virtio
 external snapshot with iothread
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ed Swierk <eswierk@skyportsystems.com>
Cc: Fam Zheng <famz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org, Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>


--mrJd9p1Ce66CJMxE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 29, 2017 at 07:01:38PM -0700, Ed Swierk wrote:
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
> many of these configurations. Currently it only exercises the external
> snapshot create and commit lifted from iotest 118. The new iotest does
> this repeatedly in each of 16 combinations:
> - no guest / guest
> - virtio-blk / virtio-scsi
> - no iothread / iothread
> - single / repeated external snapshot create+commit

Thanks Ed!  This is has a lot of potential.  I see three different
issues that can be discussed separately:

1. Urgent 2.9 bug fix for `ctx->external_disable_cnt > 0' failed
assertion.  I believe you've already started a separate email thread
about it called "Assertion failure taking external snapshot with virtio
drive + iothread".

2. QEMU 2.8 stable hang.  Less urgent but worth understanding, perhaps
via git-bisect against QEMU 2.9.

3. Minor iotest enhancements.  Please send a separate patch series.

4. How to automate tests with real Linux guests?  This is a complex
topic and probably what we should discuss in this email thread.

The buildroot + busybox approach is good for a small set of sanity
tests.  There was a similar attempt here:
https://github.com/stsquad/qemu-jeos

Building from source becomes a challenge when other people want to add
software to test other areas of QEMU.  The process also requires
attention to maintain the image over time (e.g. as host build
environments change).

There are image builder tools like virt-builder and mkosi for building
bootable virtual machine images based on standard Linux distros:
http://libguestfs.org/virt-builder.1.html
https://github.com/systemd/mkosi

This eliminates the build-from-source hassles and gives us a full Linux
guest environment.  Booting is very fast with mkosi so the advantage to
custom building a minimal image is negligible.

My suggestion is:

Let's pick an image builder tool like virt-builder and keep a single
build script per guest architecture (e.g.  build-test-os-x86_64.sh).
All tests for that architecture run against the same disk image.

It's easy to add additional software to the disk image by modifying the
build script.

A Makefile ensures that the image file gets rebuilt if the build script
has changed.

>=20
> I made some minor changes to the test infrastructure so the new iotest
> can deal gracefully with qemu hanging--the test script itself
> shouldn't hang. And in all failure modes the test needs to expose
> enough console output and other information to diagnose the problem.
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
> And here is the buildroot I used to generate the guest Linux kernel+initr=
d:
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
> - guest, virtio-blk, iothread, repeated snapshot create+commit: same as a=
bove
> - guest, virtio-scsi, iothread, single snapshot create+commit: same as ab=
ove
> - guest, virtio-scsi, iothread, repeated snapshot create+commit: same as =
above
> - no guest, virtio-blk, iothread, repeated snapshot create+commit: same a=
s above
> - no guest, virtio-scsi, iothread, single snapshot create+commit: same as=
 above
> - no guest, virtio-scsi, iothread, repeated snapshot create+commit:
> same as above
>=20
> --Ed
>=20

--mrJd9p1Ce66CJMxE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJY4n8TAAoJEJykq7OBq3PILekIALdkVbguPkR//Tuh/9KJAToc
GDlh/SgtWTWNdap3MfDDMbLev9rT22e4Ne4R/osx8FepajVig4hrtazyHiSNMiCz
dA0+4/w+5Ja6ErPcLcq+cg04q7b9YW6x7LrBHTQPge8vSm2fGDIymi0U6/XvwM6g
6PRNsB/tyQuHVVEGSTbydo397uL0ttrZtMXk05VOXdHBIukqZry1+V4yIyYa5jYW
O8rm5XqrHiNeOtxGFx9nE3Tw0jZVI/xF2+o+0sKkyqQ24Obiz1GuiBeDc4ZoHZ//
W/6DjZbo3ADVgjEvpt9YFQCkdktCC5MIR0zbOLLCBFQWQENdmLmjqM0u3tI2cAM=
=DzWM
-----END PGP SIGNATURE-----

--mrJd9p1Ce66CJMxE--
