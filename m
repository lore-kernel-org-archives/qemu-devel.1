Received: from eggs.gnu.org ([2001:4830:134:3::10]:41748)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1eRiZu-0004JM-6j
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 12:54:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1eRiZq-0005LM-7C
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 12:54:50 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47824)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1eRiZp-0005K0-Qa
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 12:54:46 -0500
Date: Wed, 20 Dec 2017 19:54:43 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20171220195424-mutt-send-email-mst@kernel.org>
References: <1513132143-10758-1-git-send-email-changpeng.liu@intel.com>
	<1513132143-10758-5-git-send-email-changpeng.liu@intel.com>
	<CAJ+F1CJF6Gd+peZb7hJCax=-735-OD_QWPoURJQGZMxMKT2wYQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <CAJ+F1CJF6Gd+peZb7hJCax=-735-OD_QWPoURJQGZMxMKT2wYQ@mail.gmail.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v7 4/4] contrib/vhost-user-blk: introduce a
 vhost-user-blk sample application
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@gmail.com>
Cc: Changpeng Liu <changpeng.liu@intel.com>, QEMU <qemu-devel@nongnu.org>, james.r.harris@intel.com, Stefan Hajnoczi <stefanha@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Felipe Franciosi <felipe@nutanix.com>

On Wed, Dec 20, 2017 at 05:02:18PM +0100, Marc-Andr=E9 Lureau wrote:
> Hi
>=20
> On Wed, Dec 13, 2017 at 3:29 AM, Changpeng Liu <changpeng.liu@intel.com=
> wrote:
> > This commit introcudes a vhost-user-blk backend device, it uses UNIX
> > domain socket to communicate with QEMU. The vhost-user-blk sample
> > application should be used with QEMU vhost-user-blk-pci device.
> >
> > To use it, complie with:
> > make vhost-user-blk
> >
> > and start like this:
> > vhost-user-blk -b /dev/sdb -s /path/vhost.socket
> >
> > Signed-off-by: Changpeng Liu <changpeng.liu@intel.com>
>=20
> Looks ok overall, just a few code cleanups would be welcome,

I merged it by now, pls do cleanups by adding patches on top.

> > ---
> >  .gitignore                              |   1 +
> >  Makefile                                |   3 +
> >  Makefile.objs                           |   1 +
> >  contrib/vhost-user-blk/Makefile.objs    |   1 +
> >  contrib/vhost-user-blk/vhost-user-blk.c | 550 ++++++++++++++++++++++=
++++++++++
> >  5 files changed, 556 insertions(+)
> >  create mode 100644 contrib/vhost-user-blk/Makefile.objs
> >  create mode 100644 contrib/vhost-user-blk/vhost-user-blk.c
> >
> > diff --git a/.gitignore b/.gitignore
> > index 588769b..495f854 100644
> > --- a/.gitignore
> > +++ b/.gitignore
> > @@ -55,6 +55,7 @@
> >  /scsi/qemu-pr-helper
> >  /vscclient
> >  /vhost-user-scsi
> > +/vhost-user-blk
> >  /fsdev/virtfs-proxy-helper
> >  *.tmp
> >  *.[1-9]
> > diff --git a/Makefile b/Makefile
> > index ab0354c..3aad271 100644
> > --- a/Makefile
> > +++ b/Makefile
> > @@ -327,6 +327,7 @@ dummy :=3D $(call unnest-vars,, \
> >                  ivshmem-server-obj-y \
> >                  libvhost-user-obj-y \
> >                  vhost-user-scsi-obj-y \
> > +                vhost-user-blk-obj-y \
> >                  qga-vss-dll-obj-y \
> >                  block-obj-y \
> >                  block-obj-m \
> > @@ -558,6 +559,8 @@ ivshmem-server$(EXESUF): $(ivshmem-server-obj-y) =
$(COMMON_LDADDS)
> >  endif
> >  vhost-user-scsi$(EXESUF): $(vhost-user-scsi-obj-y) libvhost-user.a
> >         $(call LINK, $^)
> > +vhost-user-blk$(EXESUF): $(vhost-user-blk-obj-y) libvhost-user.a
> > +       $(call LINK, $^)
> >
> >  module_block.h: $(SRC_PATH)/scripts/modules/module_block.py config-h=
ost.mak
> >         $(call quiet-command,$(PYTHON) $< $@ \
> > diff --git a/Makefile.objs b/Makefile.objs
> > index 285c6f3..ae9aef7 100644
> > --- a/Makefile.objs
> > +++ b/Makefile.objs
> > @@ -115,6 +115,7 @@ libvhost-user-obj-y =3D contrib/libvhost-user/
> >  vhost-user-scsi.o-cflags :=3D $(LIBISCSI_CFLAGS)
> >  vhost-user-scsi.o-libs :=3D $(LIBISCSI_LIBS)
> >  vhost-user-scsi-obj-y =3D contrib/vhost-user-scsi/
> > +vhost-user-blk-obj-y =3D contrib/vhost-user-blk/
> >
> >  ####################################################################=
##
> >  trace-events-subdirs =3D
> > diff --git a/contrib/vhost-user-blk/Makefile.objs b/contrib/vhost-use=
r-blk/Makefile.objs
> > new file mode 100644
> > index 0000000..72e2cdc
> > --- /dev/null
> > +++ b/contrib/vhost-user-blk/Makefile.objs
> > @@ -0,0 +1 @@
> > +vhost-user-blk-obj-y =3D vhost-user-blk.o
> > diff --git a/contrib/vhost-user-blk/vhost-user-blk.c b/contrib/vhost-=
user-blk/vhost-user-blk.c
> > new file mode 100644
> > index 0000000..841c3c3
> > --- /dev/null
> > +++ b/contrib/vhost-user-blk/vhost-user-blk.c
> > @@ -0,0 +1,550 @@
> > +/*
> > + * vhost-user-blk sample application
> > + *
> > + * Copyright (c) 2017 Intel Corporation. All rights reserved.
> > + *
> > + * Author:
> > + *  Changpeng Liu <changpeng.liu@intel.com>
> > + *
> > + * This work is based on the "vhost-user-scsi" sample and "virtio-bl=
k" driver
> > + * implemention by:
> > + *  Felipe Franciosi <felipe@nutanix.com>
> > + *  Anthony Liguori <aliguori@us.ibm.com>
> > + *
> > + * This work is licensed under the terms of the GNU GPL, version 2 o=
nly.
> > + * See the COPYING file in the top-level directory.
> > + */
> > +
> > +#include "qemu/osdep.h"
> > +#include "standard-headers/linux/virtio_blk.h"
> > +#include "contrib/libvhost-user/libvhost-user-glib.h"
> > +#include "contrib/libvhost-user/libvhost-user.h"
> > +
> > +#include <glib.h>
> > +
> > +struct virtio_blk_inhdr {
> > +    unsigned char status;
> > +};
> > +
> > +/* vhost user block device */
> > +typedef struct VubDev {
> > +    VugDev parent;
> > +    int blk_fd;
> > +    struct virtio_blk_config blkcfg;
> > +    char *blk_name;
> > +    GMainLoop *loop;
> > +} VubDev;
> > +
> > +typedef struct VubReq {
> > +    VuVirtqElement *elem;
> > +    int64_t sector_num;
> > +    size_t size;
> > +    struct virtio_blk_inhdr *in;
> > +    struct virtio_blk_outhdr *out;
> > +    VubDev *vdev_blk;
> > +    struct VuVirtq *vq;
> > +} VubReq;
> > +
> > +/**  refer util/iov.c  **/
> > +static size_t vub_iov_size(const struct iovec *iov,
> > +                              const unsigned int iov_cnt)
> > +{
> > +    size_t len;
> > +    unsigned int i;
> > +
> > +    len =3D 0;
> > +    for (i =3D 0; i < iov_cnt; i++) {
> > +        len +=3D iov[i].iov_len;
> > +    }
> > +    return len;
> > +}
> > +
> > +static void vub_panic_cb(VuDev *vu_dev, const char *buf)
> > +{
> > +    VugDev *gdev;
> > +    VubDev *vdev_blk;
> > +
> > +    assert(vu_dev);
> > +
> > +    gdev =3D container_of(vu_dev, VugDev, parent);
> > +    vdev_blk =3D container_of(gdev, VubDev, parent);
> > +    if (buf) {
> > +        g_warning("vu_panic: %s", buf);
> > +    }
> > +
> > +    g_main_loop_quit(vdev_blk->loop);
> > +}
> > +
> > +static void vub_req_complete(VubReq *req)
> > +{
> > +    VugDev *gdev =3D &req->vdev_blk->parent;
> > +    VuDev *vu_dev =3D &gdev->parent;
> > +
> > +    /* IO size with 1 extra status byte */
> > +    vu_queue_push(vu_dev, req->vq, req->elem,
> > +                  req->size + 1);
> > +    vu_queue_notify(vu_dev, req->vq);
> > +
> > +    if (req->elem) {
> > +        free(req->elem);
> > +    }
> > +    g_free(req);
> > +}
> > +
> > +static int vub_open(const char *file_name, bool wce)
> > +{
> > +    int fd;
> > +    int flags =3D O_RDWR;
> > +
> > +    if (!wce) {
> > +        flags |=3D O_DIRECT;
> > +    }
> > +
> > +    fd =3D open(file_name, flags);
> > +    if (fd < 0) {
> > +        fprintf(stderr, "Cannot open file %s, %s\n", file_name,
> > +                strerror(errno));
> > +        return -1;
> > +    }
> > +
> > +    return fd;
> > +}
> > +
> > +static void vub_close(int fd)
> > +{
> > +    if (fd >=3D 0) {
> > +        close(fd);
> > +    }
> > +}
>=20
> Not sure that function is worth it, see below:
>=20
> > +
> > +static ssize_t
> > +vub_readv(VubReq *req, struct iovec *iov, uint32_t iovcnt)
> > +{
> > +    VubDev *vdev_blk =3D req->vdev_blk;
> > +    ssize_t rc;
> > +
> > +    if (!iovcnt) {
> > +        fprintf(stderr, "Invalid Read IOV count\n");
> > +        return -1;
> > +    }
> > +
> > +    req->size =3D vub_iov_size(iov, iovcnt);
> > +    rc =3D preadv(vdev_blk->blk_fd, iov, iovcnt, req->sector_num * 5=
12);
> > +    if (rc < 0) {
> > +        fprintf(stderr, "%s, Sector %"PRIu64", Size %lu failed with =
%s\n",
> > +                vdev_blk->blk_name, req->sector_num, req->size,
> > +                strerror(errno));
> > +        return -1;
> > +    }
> > +
> > +    return rc;
> > +}
> > +
> > +static ssize_t
> > +vub_writev(VubReq *req, struct iovec *iov, uint32_t iovcnt)
> > +{
> > +    VubDev *vdev_blk =3D req->vdev_blk;
> > +    ssize_t rc;
> > +
> > +    if (!iovcnt) {
> > +        fprintf(stderr, "Invalid Write IOV count\n");
> > +        return -1;
> > +    }
> > +
> > +    req->size =3D vub_iov_size(iov, iovcnt);
> > +    rc =3D pwritev(vdev_blk->blk_fd, iov, iovcnt, req->sector_num * =
512);
> > +    if (rc < 0) {
> > +        fprintf(stderr, "%s, Sector %"PRIu64", Size %lu failed with =
%s\n",
> > +                vdev_blk->blk_name, req->sector_num, req->size,
> > +                strerror(errno));
> > +        return -1;
> > +    }
> > +
> > +    return rc;
> > +}
> > +
> > +static void
> > +vub_flush(VubReq *req)
> > +{
> > +    VubDev *vdev_blk =3D req->vdev_blk;
> > +
> > +    fdatasync(vdev_blk->blk_fd);
> > +}
> > +
> > +
>=20
> 2 lines?
>=20
> > +static int vub_virtio_process_req(VubDev *vdev_blk,
> > +                                     VuVirtq *vq)
> > +{
> > +    VugDev *gdev =3D &vdev_blk->parent;
> > +    VuDev *vu_dev =3D &gdev->parent;
> > +    VuVirtqElement *elem;
> > +    uint32_t type;
> > +    unsigned in_num;
> > +    unsigned out_num;
> > +    VubReq *req;
> > +
> > +    elem =3D vu_queue_pop(vu_dev, vq, sizeof(VuVirtqElement));
> > +    if (!elem) {
> > +        return -1;
> > +    }
> > +
> > +    /* refer to hw/block/virtio_blk.c */
> > +    if (elem->out_num < 1 || elem->in_num < 1) {
> > +        fprintf(stderr, "virtio-blk request missing headers\n");
> > +        free(elem);
> > +        return -1;
> > +    }
> > +
> > +    req =3D g_new0(VubReq, 1);
> > +    req->vdev_blk =3D vdev_blk;
> > +    req->vq =3D vq;
> > +    req->elem =3D elem;
> > +
> > +    in_num =3D elem->in_num;
> > +    out_num =3D elem->out_num;
> > +
> > +    /* don't support VIRTIO_F_ANY_LAYOUT and virtio 1.0 only */
> > +    if (elem->out_sg[0].iov_len < sizeof(struct virtio_blk_outhdr)) =
{
> > +        fprintf(stderr, "Invalid outhdr size\n");
> > +        goto err;
> > +    }
> > +    req->out =3D (struct virtio_blk_outhdr *)elem->out_sg[0].iov_bas=
e;
> > +    out_num--;
> > +
> > +    if (elem->in_sg[in_num - 1].iov_len < sizeof(struct virtio_blk_i=
nhdr)) {
> > +        fprintf(stderr, "Invalid inhdr size\n");
> > +        goto err;
> > +    }
> > +    req->in =3D (struct virtio_blk_inhdr *)elem->in_sg[in_num - 1].i=
ov_base;
> > +    in_num--;
> > +
> > +    type =3D le32toh(req->out->type);
> > +    switch (type & ~(VIRTIO_BLK_T_OUT | VIRTIO_BLK_T_BARRIER)) {
> > +        case VIRTIO_BLK_T_IN: {
> > +            ssize_t ret =3D 0;
> > +            bool is_write =3D type & VIRTIO_BLK_T_OUT;
> > +            req->sector_num =3D le64toh(req->out->sector);
> > +            if (is_write) {
> > +                ret  =3D vub_writev(req, &elem->out_sg[1], out_num);
> > +            } else {
> > +                ret =3D vub_readv(req, &elem->in_sg[0], in_num);
> > +            }
> > +            if (ret >=3D 0) {
> > +                req->in->status =3D VIRTIO_BLK_S_OK;
> > +            } else {
> > +                req->in->status =3D VIRTIO_BLK_S_IOERR;
> > +            }
> > +            vub_req_complete(req);
> > +            break;
> > +        }
> > +        case VIRTIO_BLK_T_FLUSH: {
> > +            vub_flush(req);
> > +            req->in->status =3D VIRTIO_BLK_S_OK;
> > +            vub_req_complete(req);
> > +            break;
> > +        }
> > +        case VIRTIO_BLK_T_GET_ID: {
> > +            size_t size =3D MIN(vub_iov_size(&elem->in_sg[0], in_num=
),
> > +                              VIRTIO_BLK_ID_BYTES);
> > +            snprintf(elem->in_sg[0].iov_base, size, "%s", "vhost_use=
r_blk");
> > +            req->in->status =3D VIRTIO_BLK_S_OK;
> > +            req->size =3D elem->in_sg[0].iov_len;
> > +            vub_req_complete(req);
> > +            break;
> > +        }
> > +        default: {
> > +            req->in->status =3D VIRTIO_BLK_S_UNSUPP;
> > +            vub_req_complete(req);
> > +            break;
> > +        }
> > +    }
> > +
> > +    return 0;
> > +
> > +err:
> > +    free(elem);
> > +    g_free(req);
> > +    return -1;
> > +}
> > +
> > +static void vub_process_vq(VuDev *vu_dev, int idx)
> > +{
> > +    VugDev *gdev;
> > +    VubDev *vdev_blk;
> > +    VuVirtq *vq;
> > +    int ret;
> > +
> > +    if ((idx < 0) || (idx >=3D VHOST_MAX_NR_VIRTQUEUE)) {
> > +        fprintf(stderr, "VQ Index out of range: %d\n", idx);
> > +        vub_panic_cb(vu_dev, NULL);
> > +        return;
> > +    }
> > +
> > +    gdev =3D container_of(vu_dev, VugDev, parent);
> > +    vdev_blk =3D container_of(gdev, VubDev, parent);
> > +    assert(vdev_blk);
> > +
> > +    vq =3D vu_get_queue(vu_dev, idx);
> > +    assert(vq);
> > +
> > +    while (1) {
> > +        ret =3D vub_virtio_process_req(vdev_blk, vq);
> > +        if (ret) {
> > +            break;
> > +        }
> > +    }
> > +}
> > +
> > +static void vub_queue_set_started(VuDev *vu_dev, int idx, bool start=
ed)
> > +{
> > +    VuVirtq *vq;
> > +
> > +    assert(vu_dev);
> > +
> > +    vq =3D vu_get_queue(vu_dev, idx);
> > +    vu_set_queue_handler(vu_dev, vq, started ? vub_process_vq : NULL=
);
> > +}
> > +
> > +static uint64_t
> > +vub_get_features(VuDev *dev)
> > +{
> > +    return 1ull << VIRTIO_BLK_F_SIZE_MAX |
> > +           1ull << VIRTIO_BLK_F_SEG_MAX |
> > +           1ull << VIRTIO_BLK_F_TOPOLOGY |
> > +           1ull << VIRTIO_BLK_F_BLK_SIZE |
> > +           1ull << VIRTIO_BLK_F_FLUSH |
> > +           1ull << VIRTIO_BLK_F_CONFIG_WCE |
> > +           1ull << VIRTIO_F_VERSION_1 |
> > +           1ull << VHOST_USER_F_PROTOCOL_FEATURES;
> > +}
> > +
> > +static int
> > +vub_get_config(VuDev *vu_dev, uint8_t *config, uint32_t len)
> > +{
> > +    VugDev *gdev;
> > +    VubDev *vdev_blk;
> > +
> > +    gdev =3D container_of(vu_dev, VugDev, parent);
> > +    vdev_blk =3D container_of(gdev, VubDev, parent);
> > +    memcpy(config, &vdev_blk->blkcfg, len);
> > +
> > +    return 0;
> > +}
> > +
> > +static int
> > +vub_set_config(VuDev *vu_dev, const uint8_t *data,
> > +               uint32_t offset, uint32_t size, uint32_t flags)
> > +{
> > +    VugDev *gdev;
> > +    VubDev *vdev_blk;
> > +    uint8_t wce;
> > +    int fd;
> > +
> > +    /* don't support live migration */
> > +    if (flags !=3D VHOST_SET_CONFIG_TYPE_MASTER) {
> > +        return -1;
> > +    }
> > +
> > +    gdev =3D container_of(vu_dev, VugDev, parent);
> > +    vdev_blk =3D container_of(gdev, VubDev, parent);
> > +
> > +    if (offset !=3D offsetof(struct virtio_blk_config, wce) ||
> > +        size !=3D 1) {
> > +        return -1;
> > +    }
> > +
> > +    wce =3D *data;
> > +    if (wce =3D=3D vdev_blk->blkcfg.wce) {
> > +        /* Do nothing as same with old configuration */
> > +        return 0;
> > +    }
> > +
> > +    vdev_blk->blkcfg.wce =3D wce;
> > +    fprintf(stdout, "Write Cache Policy Changed\n");
> > +    vub_close(vdev_blk->blk_fd);
>=20
> if (vdev_blk->blk_fd >=3D 0)
>     close(vdev_blk->blk_fd);
> vdev_blk->blk_fd =3D -1;
>=20
> > +
> > +    fd =3D vub_open(vdev_blk->blk_name, wce);
> > +    if (fd < 0) {
> > +        fprintf(stderr, "Error to open block device %s\n", vdev_blk-=
>blk_name);
> > +        vdev_blk->blk_fd =3D -1;
> > +        return -1;
> > +    }
> > +    vdev_blk->blk_fd =3D fd;
> > +
> > +    return 0;
> > +}
> > +
> > +static const VuDevIface vub_iface =3D {
> > +    .get_features =3D vub_get_features,
> > +    .queue_set_started =3D vub_queue_set_started,
> > +    .get_config =3D vub_get_config,
> > +    .set_config =3D vub_set_config,
> > +};
> > +
> > +static int unix_sock_new(char *unix_fn)
> > +{
> > +    int sock;
> > +    struct sockaddr_un un;
> > +    size_t len;
> > +
> > +    assert(unix_fn);
> > +
> > +    sock =3D socket(AF_UNIX, SOCK_STREAM, 0);
> > +    if (sock <=3D 0) {
> > +        perror("socket");
> > +        return -1;
> > +    }
> > +
> > +    un.sun_family =3D AF_UNIX;
> > +    (void)snprintf(un.sun_path, sizeof(un.sun_path), "%s", unix_fn);
> > +    len =3D sizeof(un.sun_family) + strlen(un.sun_path);
> > +
> > +    (void)unlink(unix_fn);
> > +    if (bind(sock, (struct sockaddr *)&un, len) < 0) {
> > +        perror("bind");
> > +        goto fail;
> > +    }
> > +
> > +    if (listen(sock, 1) < 0) {
> > +        perror("listen");
> > +        goto fail;
> > +    }
> > +
> > +    return sock;
> > +
> > +fail:
> > +    (void)close(sock);
> > +
> > +    return -1;
> > +}
> > +
> > +static void vub_deinit(struct VubDev *vdev_blk)
> > +{
> > +    if (!vdev_blk) {
> > +        return;
> > +    }
>=20
> Make it vub_free() to remove the g_free() after the call below?
>=20
> > +
> > +    if (vdev_blk->blk_fd) {
> > +        vub_close(vdev_blk->blk_fd);
>=20
> if (vdev_blk->blk_fd >=3D 0)
>     close(vdev_blk->blk_fd)
>=20
> & remove vub_close()
>=20
> > +    }
> > +}
> > +
> > +static uint32_t
> > +vub_get_blocksize(int fd)
> > +{
> > +    uint32_t blocksize =3D 512;
> > +
> > +    #if defined(__linux__) && defined(BLKSSZGET)
> > +    if (ioctl(fd, BLKSSZGET, &blocksize) =3D=3D 0) {
> > +        return blocklen;
> > +    }
> > +    #endif
> > +
> > +    return blocksize;
> > +}
> > +
> > +static void
> > +vub_initialize_config(int fd, struct virtio_blk_config *config)
> > +{
> > +    off64_t capacity;
> > +
> > +    capacity =3D lseek64(fd, 0, SEEK_END);
> > +    config->capacity =3D capacity >> 9;
> > +    config->blk_size =3D vub_get_blocksize(fd);
> > +    config->size_max =3D 65536;
> > +    config->seg_max =3D 128 - 2;
> > +    config->min_io_size =3D 1;
> > +    config->opt_io_size =3D 1;
> > +    config->num_queues =3D 1;
> > +}
> > +
> > +static int
> > +vub_new_block(VubDev *vdev_blk, char *blk_file)
>=20
> Make it vub_new() instead?
>=20
> > +{
> > +    vdev_blk->blk_fd =3D vub_open(blk_file, 0);
> > +    if (vdev_blk->blk_fd  < 0) {
> > +        fprintf(stderr, "Error to open block device %s\n", blk_file)=
;
> > +        return -1;
> > +    }
> > +    vdev_blk->blkcfg.wce =3D 0;
> > +    vdev_blk->blk_name =3D blk_file;
> > +
> > +    /* fill virtio_blk_config with block parameters */
> > +    vub_initialize_config(vdev_blk->blk_fd, &vdev_blk->blkcfg);
> > +
> > +    return 0;
> > +}
> > +
> > +int main(int argc, char **argv)
> > +{
> > +    int opt;
> > +    char *unix_socket =3D NULL;
> > +    char *blk_file =3D NULL;
> > +    int lsock =3D -1, csock =3D -1, rc;
> > +    VubDev *vdev_blk =3D NULL;
> > +
> > +    while ((opt =3D getopt(argc, argv, "b:h:s:")) !=3D -1) {
> > +        switch (opt) {
> > +        case 'b':
> > +            blk_file =3D g_strdup(optarg);
> > +            break;
> > +        case 's':
> > +            unix_socket =3D g_strdup(optarg);
> > +            break;
> > +        case 'h':
> > +        default:
> > +            printf("Usage: %s [-b block device or file, -s UNIX doma=
in socket]"
> > +                   " | [ -h ]\n", argv[0]);
> > +            return -1;
> > +        }
> > +    }
> > +
> > +    if (!unix_socket || !blk_file) {
> > +        printf("Usage: %s [-b block device or file, -s UNIX domain s=
ocket] |"
> > +               " [ -h ]\n", argv[0]);
> > +        return -1;
> > +    }
> > +
> > +    lsock =3D unix_sock_new(unix_socket);
> > +    if (lsock < 0) {
> > +        goto err;
> > +    }
> > +
> > +    csock =3D accept(lsock, (void *)0, (void *)0);
> > +    if (csock < 0) {
> > +        fprintf(stderr, "Accept error %s\n", strerror(errno));
> > +        goto err;
> > +    }
> > +
> > +    vdev_blk =3D g_new0(VubDev, 1);
> > +    vdev_blk->loop =3D g_main_loop_new(NULL, FALSE);
> > +
> > +    rc =3D vub_new_block(vdev_blk, blk_file);
>=20
> The 3 lines above could be simplified to be:
>=20
> vub =3D vub_new(blk_file);
>=20
> > +    if (rc) {
> > +        goto err;
> > +    }
> > +
> > +    vug_init(&vdev_blk->parent, csock, vub_panic_cb, &vub_iface);
> > +
> > +    g_main_loop_run(vdev_blk->loop);
> > +
> > +    vug_deinit(&vdev_blk->parent);
> > +
> > +err:
> > +    if (vdev_blk) {
> > +        g_main_loop_unref(vdev_blk->loop);
> > +        vub_deinit(vdev_blk);
> > +        g_free(vdev_blk);
> > +    }
>=20
> And the above block could simply be:
>=20
> and this could simply be:
>=20
> vub_free(vub)
>=20
> > +    if (csock >=3D 0) {
> > +        close(csock);
> > +    }
> > +    if (lsock >=3D 0) {
> > +        close(lsock);
> > +    }
> > +    g_free(unix_socket);
> > +    g_free(blk_file);
> > +
> > +    return 0;
> > +}
> > +
>=20
> Please remove that extra empty line
>=20
>=20
>=20
> --=20
> Marc-Andr=E9 Lureau
