Received: from eggs.gnu.org ([2001:4830:134:3::10]:34214)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1eOP8w-0002Hv-Mx
	for qemu-devel@nongnu.org; Mon, 11 Dec 2017 09:33:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1eOP8r-0003wR-MG
	for qemu-devel@nongnu.org; Mon, 11 Dec 2017 09:33:18 -0500
Received: from mail-wr0-x242.google.com ([2a00:1450:400c:c0c::242]:46818)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1eOP8r-0003vn-FB
	for qemu-devel@nongnu.org; Mon, 11 Dec 2017 09:33:13 -0500
Received: by mail-wr0-x242.google.com with SMTP id x49so17768660wrb.13
	for <qemu-devel@nongnu.org>; Mon, 11 Dec 2017 06:33:13 -0800 (PST)
Date: Mon, 11 Dec 2017 14:33:10 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20171211143310.GD5962@stefanha-x1.localdomain>
References: <1512455239-8296-1-git-send-email-changpeng.liu@intel.com>
	<1512455239-8296-5-git-send-email-changpeng.liu@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="IMjqdzrDRly81ofr"
Content-Disposition: inline
In-Reply-To: <1512455239-8296-5-git-send-email-changpeng.liu@intel.com>
Subject: Re: [Qemu-devel] [PATCH v6 4/4] contrib/vhost-user-blk: introduce a
 vhost-user-blk sample application
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Changpeng Liu <changpeng.liu@intel.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, mst@redhat.com, marcandre.lureau@redhat.com, felipe@nutanix.com, james.r.harris@intel.com


--IMjqdzrDRly81ofr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

> +static int vub_virtio_process_req(VubDev *vdev_blk,
> +                                     VuVirtq *vq)
> +{
> +    VugDev *gdev = &vdev_blk->parent;
> +    VuDev *vu_dev = &gdev->parent;
> +    VuVirtqElement *elem;
> +    uint32_t type;
> +    unsigned in_num;
> +    unsigned out_num;
> +    VubReq *req;
> +
> +    elem = vu_queue_pop(vu_dev, vq, sizeof(VuVirtqElement));
> +    if (!elem) {
> +        return -1;
> +    }
> +
> +    /* refer to hw/block/virtio_blk.c */
> +    if (elem->out_num < 1 || elem->in_num < 1) {
> +        fprintf(stderr, "virtio-blk request missing headers\n");
> +        free(elem);
> +        return -1;
> +    }
> +
> +    req = g_new0(VubReq, 1);
> +    req->vdev_blk = vdev_blk;
> +    req->vq = vq;
> +    req->elem = elem;
> +
> +    in_num = elem->in_num;
> +    out_num = elem->out_num;
> +
> +    /* don't support VIRTIO_F_ANY_LAYOUT and virtio 1.0 only */
> +    if (elem->out_sg[0].iov_len < sizeof(struct virtio_blk_outhdr)) {
> +        fprintf(stderr, "Invalid outhdr size\n");
> +        goto err;
> +    }

QEMU has iov_discard_front() and iov_discard_back().  They make it
pretty easy to support VIRTIO_F_ANY_LAYOUT.  If you have time, please
consider adding it to libvhost-user, but it's not a requirement for this
patch series.

> +    req->out = (struct virtio_blk_outhdr *)elem->out_sg[0].iov_base;
> +    out_num--;
> +
> +    if (elem->in_sg[in_num - 1].iov_len < sizeof(struct virtio_blk_inhdr)) {
> +        fprintf(stderr, "Invalid inhdr size\n");
> +        goto err;
> +    }
> +    req->in = (struct virtio_blk_inhdr *)elem->in_sg[in_num - 1].iov_base;
> +    in_num--;
> +
> +    type = le32toh(req->out->type);

Endianness is more complicated if you want to support both VIRTIO 1.0
and Legacy (0.9.7).  I guess it's okay to make libvhost-user code only
support VIRTIO 1.0.
> +static void vub_queue_set_started(VuDev *vu_dev, int idx, bool started)
> +{
> +    VuVirtq *vq;
> +
> +    assert(vu_dev);
> +
> +    if ((idx < 0) || (idx >= VHOST_MAX_NR_VIRTQUEUE)) {
> +        fprintf(stderr, "VQ Index out of range: %d\n", idx);
> +        vub_panic_cb(vu_dev, NULL);
> +        return;
> +    }

Is it necessary to check num_queues?  The vhost-user master should not
be able to enable idx >= num_queues.

--IMjqdzrDRly81ofr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJaLpcmAAoJEJykq7OBq3PIxvAH/idj7v52obJ54TdxICMdy7wO
G0HaEXGSXG5RvMiQwSEphW2QsyXIpath7ftOMmbP9MuzUgpT6zqMbvfP0q4orHQf
MIBhPeysy5MdTIQbl+a3KfH7g0aZjbuzhzidxG1OcLONkNzyY/8ZBx06sd2/1mHi
SgMhmn5p9PnJrp0gGCHVg2DXbaBMPJpSv/O4ueLjnORopCrwbm4MntciB0q3wvPW
AZq0+SHoYv2ZXBPeeoqmJQxqXj8sJDKHpR/T+2nFM6eP4Qdat3PjSBRNEhFnXRV8
HZ2lvMrpi8MhyUzku7PFMumw5pERPf8PcWyhkcACX0VAb6yT9Sf8I7LZQ4HAvpE=
=+pR+
-----END PGP SIGNATURE-----

--IMjqdzrDRly81ofr--
