Received: from eggs.gnu.org ([2001:4830:134:3::10]:40358)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cT7QI-00045K-IV
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 08:34:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cT7QE-00027l-IS
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 08:34:10 -0500
Received: from mail-wm0-x243.google.com ([2a00:1450:400c:c09::243]:36600)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1cT7QE-000273-BZ
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 08:34:06 -0500
Received: by mail-wm0-x243.google.com with SMTP id r126so30889276wmr.3
	for <qemu-devel@nongnu.org>; Mon, 16 Jan 2017 05:34:06 -0800 (PST)
Date: Mon, 16 Jan 2017 13:34:01 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170116133401.GE14681@stefanha-x1.localdomain>
References: <5878435d.54b31c0a.39a7b.4e93@mx.google.com>
	<011014c2-1129-cd48-f13d-66d7951d3e3c@linux.intel.com>
	<CAKXe6SJXWzu2pTZz_vRGic4ZomPcVGVOfOvig43=8ZoZet0cRQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="JBi0ZxuS5uaEhkUZ"
Content-Disposition: inline
In-Reply-To: <CAKXe6SJXWzu2pTZz_vRGic4ZomPcVGVOfOvig43=8ZoZet0cRQ@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCH] nvdimm: allow read/write zero-size
 namespace label
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Li Qiang <liq3ea@gmail.com>
Cc: Xiao Guangrong <guangrong.xiao@linux.intel.com>, Li Qiang <liqiang6-s@360.cn>, qemu-devel@nongnu.org


--JBi0ZxuS5uaEhkUZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 14, 2017 at 07:22:28PM +0800, Li Qiang wrote:
> Hello Guangrong,
>=20
>=20
> 2017-01-13 17:00 GMT+08:00 Xiao Guangrong <guangrong.xiao@linux.intel.com=
>:
>=20
> >
> >
> > On 01/13/2017 11:02 AM, Li Qiang wrote:
> >
> >> From: Li Qiang <liqiang6-s@360.cn>
> >>
> >> The spec doesn't say the namespace label can't be zero
> >> when read/write it. As this is no harmful, just allow
> >> it.
> >>
> >>
> > WHY?
> >
> > The spec said that the label should be at least 128K.
> >
>=20
> Yes, the label size has a limit, but in NVDIMM_DSM_Interface_Example.pdf
> section 4.5.1
> When the guest get namespace label data, the 'Length' is not limited, if =
it
> is 0, it will trigger
> this assert.
>=20
> static void nvdimm_validate_rw_label_data(NVDIMMDevice *nvdimm, uint64_t
> size,
>                                         uint64_t offset)
> {
>     assert((nvdimm->label_size >=3D size + offset) && (offset + size >
> offset));
> }
>=20
> Though I don't know what the exact behavior of this action in real
> hardware. I just think it should not
> trigger assert and exit when the guest get 0-size label data.
>=20
> Anyway, this is just a suggestion, If my understand is wrong, just ignore
> this.

QEMU must prevent guests from triggering assertions.  If the assertion
causes a core dump then host resources are consumed and this could be a
denial-of-service.  An assertion failure in nested virtualization can
kill sibling VMs and is therefore also a denial-of-service.

The size=3D0 case must be handled in some way (either an error or a nop).

Stefan

--JBi0ZxuS5uaEhkUZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYfMvJAAoJEJykq7OBq3PI1L4IAIbXP3vNbh+B5R3DdkiSocuN
HTAKtRaFnKSIEEBp9pBWxsMiKUlZ25hmKYJus8IksPiGxQYeQT+CHxtxwACKiDke
GdFqLP9N0yio8jXvjk2XWKaZaf88KJuY0pNO3LXFMmFhsreRJF3P7hsAo4dpIVST
Rs1aHHN4rr+E1Xmkh/WrLg5iBHJKHoi7VVbABvi50qdEQWkYXDAR5Kjt6Zkv2bEF
Rnu74JEkdBtrx5ucdbz6WAnfNtDR7IWIVYB66lmZ4NZnEoG2a1nhEMA20jMfEuk2
Hj39K9TZPs6cfqBLlhfygkMwUwjvIq7cwDnSahxXPDvvsDVA7k+WZ8Ox676o8Rk=
=SABe
-----END PGP SIGNATURE-----

--JBi0ZxuS5uaEhkUZ--
