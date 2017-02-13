Received: from eggs.gnu.org ([2001:4830:134:3::10]:54766)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cdHNo-0003Qn-K2
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 09:13:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cdHNl-0000d2-C7
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 09:13:36 -0500
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:35249)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1cdHNl-0000cq-3x
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 09:13:33 -0500
Received: by mail-wm0-x242.google.com with SMTP id u63so19751467wmu.2
	for <qemu-devel@nongnu.org>; Mon, 13 Feb 2017 06:13:33 -0800 (PST)
Date: Mon, 13 Feb 2017 14:13:29 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170213141329.GG10361@stefanha-x1.localdomain>
References: <20170206024535.14624.3001.malonedeb@soybean.canonical.com>
	<20170209020554.6226.61390.malone@wampee.canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="z9ECzHErBrwFF8sy"
Content-Disposition: inline
In-Reply-To: <20170209020554.6226.61390.malone@wampee.canonical.com>
Subject: Re: [Qemu-devel] [Bug 1662050] Re: qemu-img convert a overlay qcow2
 image into a entire image
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: wayen <1662050@bugs.launchpad.net>
Cc: qemu-devel@nongnu.org


--z9ECzHErBrwFF8sy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 09, 2017 at 02:05:54AM -0000, wayen wrote:
> @Eric Blake, I used virt-sparsify to sparsify the qcow2 overlay image.
> As you said, the actual disk usage is minimized and the apparent file
> size is unchanged.It is very valuable for me, because it means that my
> disk can hold more files.
>=20
> But we need to be careful when transfer the sparse qcow2 overlays.
> Because some tools do not support sparse file and will convert it into a
> common file,for example, scp. And I doubt what will happen when transfer
> sparse files between different file systems.
>=20
> So I want to use qemu-img to convert the sparse qcow2 overlay into
> common file. If this was feasible, the holes in the sparse overlay will
> be removed and the above problems will disappear.

You can use the drive_mirror HMP command or drive-mirror QMP command on
a running QEMU instance to copy the data to a new file and switch to the
new file.

I'm curious what exactly is being optimized by copying out a fresh qcow2
image.

Please post the output of:

  $ stat delta.qcow2
  $ qemu-img map delta.qcow2
  $ stat new.qcow2
  $ qemu-img map new.qcow2

This will allow us to see the size and data layout differences.

Maybe a new command should be added to QEMU to do the optimization
in-place.  This would avoid the disk space overhead associated with
drive-mirror, cp, qemu-img convert, etc.

Stefan

--z9ECzHErBrwFF8sy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYob8JAAoJEJykq7OBq3PINIEIAJEnt+jbRbxK+r7GqE1/qMyM
4lKNKeRFk8P41KqJo7NIxHad0vIrC3FWJPAty/FTzXcPrda1NJlDI4/ADO4fqafD
UWYrJsNtgGfjyQ3ZNHUvZ9iw8OBNaVjpL3FTWJc8Uh4ITymUI5QlSUm4N5kgyqi/
KQ4ciIVUZHSBmbOkiWKc2PA6dpL0dpHoEDaBEoXSmJZQ/H0wRgWlpA8IGeiAlQf1
OEh1HVvVUBsn+3j3gckolqCDrgk5FEOpRrD0UX8cjlkHLvVfuZcC/1ge778CdW0h
una4NLT/P45Zzl9mrbAumokYUB3EeH6Dexksf8iEbUl4ukozAd3JHeq3pvfyIHg=
=O4na
-----END PGP SIGNATURE-----

--z9ECzHErBrwFF8sy--
