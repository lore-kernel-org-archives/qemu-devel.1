Received: from eggs.gnu.org ([2001:4830:134:3::10]:51795)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cT828-0008Nt-Ez
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 09:13:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cT824-0005so-A7
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 09:13:16 -0500
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:34891)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1cT824-0005rV-2x
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 09:13:12 -0500
Received: by mail-wm0-x242.google.com with SMTP id d140so14708066wmd.2
	for <qemu-devel@nongnu.org>; Mon, 16 Jan 2017 06:13:12 -0800 (PST)
Date: Mon, 16 Jan 2017 14:13:07 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170116141307.GG14681@stefanha-x1.localdomain>
References: <1484387976-167704-1-git-send-email-longpeng2@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="MiFvc8Vo6wRSORdP"
Content-Disposition: inline
In-Reply-To: <1484387976-167704-1-git-send-email-longpeng2@huawei.com>
Subject: Re: [Qemu-devel] [PATCH] qtest: virtio: zeroed last VRingDesc after
 allocate
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Longpeng(Mike)" <longpeng2@huawei.com>
Cc: stefanha@redhat.com, lvivier@redhat.com, eblake@redhat.com, peter.maydell@linaro.org, groug@kaod.org, arei.gonglei@huawei.com, qemu-devel@nongnu.org


--MiFvc8Vo6wRSORdP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 14, 2017 at 05:59:36PM +0800, Longpeng(Mike) wrote:
> As qvring_indirect_desc_setup() wouldn't initialize last VRingDesc,
> so it's filled with dirty data, this might cause virtio backend broken.
>=20
> For example, the last bit of this VRingDesc's flags might be 1, so
> virtqueue_read_next_desc() would report "Desc next is ***".
>=20
> This patch zeored the last VRingDesc in qvring_indirect_desc_setup().
>=20
> Signed-off-by: Longpeng(Mike) <longpeng2@huawei.com>
> ---
>  tests/libqos/virtio.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>=20
> diff --git a/tests/libqos/virtio.c b/tests/libqos/virtio.c
> index ec30cb9..b29c69e 100644
> --- a/tests/libqos/virtio.c
> +++ b/tests/libqos/virtio.c
> @@ -171,12 +171,20 @@ QVRingIndirectDesc *qvring_indirect_desc_setup(QVir=
tioDevice *d,
>      for (i =3D 0; i < elem - 1; ++i) {
>          /* indirect->desc[i].addr */
>          writeq(indirect->desc + (16 * i), 0);
> +        /* indirect->desc[i].len */
> +        writeq(indirect->desc + (16 * i) + 8, 0);

The len field is 32 bits long.  Please use writel().

>          /* indirect->desc[i].flags */
>          writew(indirect->desc + (16 * i) + 12, VRING_DESC_F_NEXT);
>          /* indirect->desc[i].next */
>          writew(indirect->desc + (16 * i) + 14, i + 1);
>      }
> =20
> +    /* zeroed last element */
> +    writeq(indirect->desc + (16 * i), 0); /* addr */
> +    writeq(indirect->desc + (16 * i) + 8, 0); /*len*/

Same here.

--MiFvc8Vo6wRSORdP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYfNTzAAoJEJykq7OBq3PIwFIIAMco9kTAAlrDK5XVBX04xEhm
aKb+3M+TBPJq/LHSsu6CMhjLM0IgCIBlj0hoXhsBrCEUyCmNvTjsrVNiSEnZmAM8
oIx3uE1l0vLiQEiZlemkSlGNvjXCHANNnfgo5l4uHvaspBW5a5260cdteyacOEco
0Qc0C40/2kDqygLYASX2gRxcDtwYEi5mWBQj/vP53oddin3YpGV9/TTe+MFQLJya
Nu3XTGjUcBXoLsXe7DoSNRd/P09iFkvZmn9kyYoag32Zvb/sqYuhjayTfz5D0Lgn
RoqqkGyuAdHgi3TSAidx74uhdwuwz6m/0oTHb4M+hGUq6saJgwxDaymfK1xHMBA=
=NbBW
-----END PGP SIGNATURE-----

--MiFvc8Vo6wRSORdP--
