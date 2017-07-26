Received: from eggs.gnu.org ([2001:4830:134:3::10]:56481)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1daK6l-0008So-5h
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 07:04:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1daK6h-0006QA-Ud
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 07:04:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48062)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1daK6h-0006Ps-Lb
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 07:03:59 -0400
Date: Wed, 26 Jul 2017 12:03:50 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170726110350.GC18489@stefanha-x1.localdomain>
References: <1501120851-4314-1-git-send-email-changpeng.liu@intel.com>
	<1501120851-4314-3-git-send-email-changpeng.liu@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="GPJrCs/72TxItFYR"
Content-Disposition: inline
In-Reply-To: <1501120851-4314-3-git-send-email-changpeng.liu@intel.com>
Subject: Re: [Qemu-devel] [PATCH 2/2] vhost-user-blk: introduce a
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
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, felipe@nutanix.com, mst@redhat.com


--GPJrCs/72TxItFYR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jul 27, 2017 at 10:00:51AM +0800, Changpeng Liu wrote:
> diff --git a/contrib/vhost-user-blk/vhost-user-blk.c b/contrib/vhost-user-blk/vhost-user-blk.c
> new file mode 100644
> index 0000000..00826f5
> --- /dev/null
> +++ b/contrib/vhost-user-blk/vhost-user-blk.c
> @@ -0,0 +1,695 @@
> +/*
> + * vhost-user-blk sample application
> + *
> + * Copyright IBM, Corp. 2007
> + * Copyright (c) 2016 Nutanix Inc. All rights reserved.
> + * Copyright (c) 2017 Intel Corporation. All rights reserved.
> + *
> + * Author:
> + *  Anthony Liguori <aliguori@us.ibm.com>
> + *  Felipe Franciosi <felipe@nutanix.com>
> + *  Changpeng Liu <changpeng.liu@intel.com>
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 only.
> + * See the COPYING file in the top-level directory.
> + */
> +
> +#include "qemu/osdep.h"
> +#include "hw/virtio/virtio-blk.h"
> +#include "contrib/libvhost-user/libvhost-user.h"
> +
> +#include <glib.h>
> +
> +/* Small compat shim from glib 2.32 */
> +#ifndef G_SOURCE_CONTINUE
> +#define G_SOURCE_CONTINUE TRUE
> +#endif
> +#ifndef G_SOURCE_REMOVE
> +#define G_SOURCE_REMOVE FALSE
> +#endif
> +
> +/* 1 IO queue with 128 entries */
> +#define VIRTIO_BLK_QUEUE_NUM 128

This is unused, please drop it.

> +/* And this is the final byte of request*/
> +#define VIRTIO_BLK_S_OK 0
> +#define VIRTIO_BLK_S_IOERR 1
> +#define VIRTIO_BLK_S_UNSUPP 2
> +
> +struct vhost_blk_dev {

Please follow QEMU coding style.

> +static int vu_virtio_blk_process_req(struct vhost_blk_dev *vdev_blk,
> +                                     VuVirtq *vq)
> +{
> +    VuVirtqElement *elem;
> +    uint32_t type;
> +    unsigned in_num;
> +    unsigned out_num;
> +    struct vhost_blk_request *req;
> +
> +    elem = vu_queue_pop(&vdev_blk->vu_dev, vq, sizeof(VuVirtqElement));
> +    if (!elem) {
> +        return -1;
> +    }
> +
> +    /* refer virtio_blk.c */
> +    if (elem->out_num < 1 || elem->in_num < 1) {
> +        fprintf(stderr, "Invalid descriptor\n");
> +        return -1;

elem is leaked.

> +    }
> +
> +    req = calloc(1, sizeof(*req));

Can you make VuVirtqElement the first field of req to avoid the calloc()
call?  This would also fix the elem memory leaks below.

> +    assert(req);
> +    req->vdev_blk = vdev_blk;
> +    req->vq = vq;
> +    req->elem = elem;
> +
> +    in_num = elem->in_num;
> +    out_num = elem->out_num;
> +
> +    if (elem->out_sg[0].iov_len < sizeof(struct virtio_blk_outhdr)) {

This violates the virtio specification.  Please see 2.4.4 Message Framing.

The device cannot assume any particular framing (iovec layout).

> +        fprintf(stderr, "Invalid outhdr size\n");
> +        free(req);
> +        return -1;
> +    }
> +    req->out = (struct virtio_blk_outhdr *)elem->out_sg[0].iov_base;
> +    out_num--;
> +
> +    if (elem->in_sg[in_num - 1].iov_len < sizeof(struct virtio_blk_inhdr)) {
> +        fprintf(stderr, "Invalid inhdr size\n");
> +        free(req);
> +        return -1;
> +    }
> +    req->in = (struct virtio_blk_inhdr *)elem->in_sg[in_num - 1].iov_base;
> +    in_num--;
> +
> +    type = le32_to_cpu(req->out->type);

Is this a VIRTIO 1.0-only device?  I'm not sure le32_to_cpu() is correct
for all VIRTIO versions and all guest/host architectures.

> +    switch (type & ~(VIRTIO_BLK_T_OUT | VIRTIO_BLK_T_BARRIER)) {
> +        case VIRTIO_BLK_T_IN: {
> +            ssize_t ret = 0;
> +            bool is_write = type & VIRTIO_BLK_T_OUT;
> +            req->sector_num = le64_to_cpu(req->out->sector);
> +            if (is_write) {
> +                assert(out_num != 0);

The guest must not be able to SIGABRT the process.  Please implement
real error handling.

> +                ret  = vu_blk_writev(req, &elem->out_sg[1], out_num);
> +            } else {
> +                assert(in_num != 0);
> +                ret = vu_blk_readv(req, &elem->in_sg[0], in_num);
> +            }
> +            if (ret >= 0) {
> +                req->in->status = VIRTIO_BLK_S_OK;
> +            } else {
> +                req->in->status = VIRTIO_BLK_S_IOERR;
> +            }
> +            vu_blk_req_complete(req);
> +            break;
> +        }
> +        case VIRTIO_BLK_T_FLUSH: {
> +            vu_blk_flush(req);
> +            req->in->status = VIRTIO_BLK_S_OK;
> +            vu_blk_req_complete(req);
> +            break;
> +        }
> +        case VIRTIO_BLK_T_GET_ID: {
> +            size_t size = MIN(vu_blk_iov_size(&elem->in_sg[0], in_num),
> +                              VIRTIO_BLK_ID_BYTES);
> +            snprintf(elem->in_sg[0].iov_base, size, "%s", "vhost_user_blk");
> +            req->in->status = VIRTIO_BLK_S_OK;
> +            req->size = elem->in_sg[0].iov_len;
> +            vu_blk_req_complete(req);
> +            break;
> +        }
> +        default: {
> +            req->in->status = VIRTIO_BLK_S_UNSUPP;
> +            vu_blk_req_complete(req);
> +            break;
> +        }
> +    }
> +
> +    return 0;
> +}
> +
> +static void vu_blk_process_vq(VuDev *vu_dev, int idx)
> +{
> +    struct vhost_blk_dev *vdev_blk;
> +    VuVirtq *vq;
> +    int ret;
> +
> +    if ((idx < 0) || (idx >= VHOST_MAX_NR_VIRTQUEUE)) {
> +        fprintf(stderr, "VQ Index out of range: %d\n", idx);
> +        vu_blk_panic_cb(vu_dev, NULL);
> +        return;
> +    }
> +
> +
> +    vdev_blk = (struct vhost_blk_dev *)((uintptr_t)vu_dev -
> +                offsetof(struct vhost_blk_dev, vu_dev));

qemu/osdep.h includes compiler.h, so container_of() should be available.
Several other places in the patch duplicate this.


--GPJrCs/72TxItFYR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZeHcWAAoJEJykq7OBq3PI8U4H/iEwR3VO8dJuq2exntbGI07+
pavz1o74+LqWK7Og3ESRSdU5v6shO6yXcbA0Udz11Iz70RHX/Dtrdxz9VQgDFBgA
WzxEVWEViiTmFBser8wJAZc244rczqTeCCCYb/uL3uV26p8RkUNrTdPJhWXgyKhp
H2HZq/GZs34zqPZ9Pvgt25ftOpldJaq4XrGMnZEoNh2xPr9h64QZkgQZ/nhR/JDb
7qBMGWmQ7/qFdJ/U3qYgeGDLFBLBs82yWtOO4T+kGM6qsp0I07bXMcI84rlFLX0A
R0fY6PUaeY+kZg6qfPY9EGu/p7rHQiYhYTBsmZ4rUv0jDRNyQ7QVgpsABtuoxyo=
=otNN
-----END PGP SIGNATURE-----

--GPJrCs/72TxItFYR--
