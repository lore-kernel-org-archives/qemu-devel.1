Received: from eggs.gnu.org ([209.51.188.92]:46873)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1goKkj-0001sD-Ky
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 23:12:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1goKki-0001OW-NR
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 23:12:01 -0500
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:40342)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1goKki-0001OJ-H6
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 23:12:00 -0500
Received: by mail-pg1-x544.google.com with SMTP id z10so8186173pgp.7
	for <qemu-devel@nongnu.org>; Mon, 28 Jan 2019 20:12:00 -0800 (PST)
Date: Tue, 29 Jan 2019 12:11:55 +0800
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20190129041155.GG3264@stefanha-x1.localdomain>
References: <20190122083152.10705-1-xieyongji@baidu.com>
	<20190122083152.10705-2-xieyongji@baidu.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="RDS4xtyBfx+7DiaI"
Content-Disposition: inline
In-Reply-To: <20190122083152.10705-2-xieyongji@baidu.com>
Subject: Re: [Qemu-devel] [PATCH v5 1/6] vhost-user: Support transferring
 inflight buffer between qemu and backend
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: elohimes@gmail.com
Cc: mst@redhat.com, marcandre.lureau@redhat.com, berrange@redhat.com, jasowang@redhat.com, maxime.coquelin@redhat.com, yury-kotov@yandex-team.ru, wrfsh@yandex-team.ru, qemu-devel@nongnu.org, zhangyu31@baidu.com, chaiwen@baidu.com, nixun@baidu.com, lilin24@baidu.com, Xie Yongji <xieyongji@baidu.com>


--RDS4xtyBfx+7DiaI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jan 22, 2019 at 04:31:47PM +0800, elohimes@gmail.com wrote:
> +typedef struct DescState {
> +    uint8_t inuse;
> +    uint8_t version;
> +    uint16_t used_idx;
> +    uint16_t avail_idx;
> +    uint16_t reserved;
> +} DescState;
> +
> +typedef struct QueueRegion {
> +    uint8_t valid;
> +    uint16_t desc_num;
> +    DescState desc[0];
> +} QueueRegion;
> +
> +The struct DescState is used to describe one head-descriptor's state. The
> +fields have following meanings:
> +
> +    inuse: Indicate whether the descriptor is inuse or not.
> +
> +    version: Indicate whether we have an atomic update to used ring and
> +    inflight buffer when slave crash at that point. This field should be
> +    increased by one before and after this two updates. An odd version
> +    indicates an in-progress update.
> +
> +    used_idx: Store old index of used ring before we update used ring and
> +    inflight buffer so that slave can know whether an odd version inflight
> +    head-descriptor in inflight buffer is processed or not.
> +
> +    avail_idx: Used to preserve the descriptor's order in avail ring so that
> +    slave can resubmit descriptors in order.

Will a completely new "packed vring" inflight shm layout be necessary to
support the packed vring layout in VIRTIO 1.1?

https://docs.oasis-open.org/virtio/virtio/v1.1/csprd01/virtio-v1.1-csprd01.html#x1-610007

--RDS4xtyBfx+7DiaI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJcT9KLAAoJEJykq7OBq3PIwfYH/juTJ/LigROOCU1+guZL9qZd
gsQ9lZ1IZsFGM5TLsTS9CmWHgLWo1viu3Fu0oO/oO/tMvQQpAjz/rbeYLjd4bmIu
dCk+AjV2F9pN4EeEJ05IDjxR5OFUcKaaA/X7BtT5y5cjeBjJmzx5Iy36QH2TwVLG
29gbsZ3LZATaies9n5zZsJnMJvoEWdehCjvtjexgDvwdZZyEhahNBLQidhGTrvzG
zXNvvExPoHYfCUCiQxDPU1f/7LdSyjJMiaN32tySPTPGPe75uHO1nPxYRBwcp4x6
4nj8p/Wu0O/bbPIuXaj5bA5w5O/L6bJd+sBYjE8FkwO4mWNrwfYE+y9sE/KP/6w=
=o6ww
-----END PGP SIGNATURE-----

--RDS4xtyBfx+7DiaI--
