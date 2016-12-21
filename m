Received: from eggs.gnu.org ([2001:4830:134:3::10]:38745)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cJfZ1-0003wD-RZ
	for qemu-devel@nongnu.org; Wed, 21 Dec 2016 07:00:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cJfYu-0007Vs-Dv
	for qemu-devel@nongnu.org; Wed, 21 Dec 2016 07:00:07 -0500
Date: Wed, 21 Dec 2016 11:59:56 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20161221115956.GF9482@stefanha-x1.localdomain>
References: <20161220163139.12016-1-famz@redhat.com>
	<20161220163139.12016-5-famz@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="0rSojgWGcpz+ezC3"
Content-Disposition: inline
In-Reply-To: <20161220163139.12016-5-famz@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 4/4] block: Add VFIO based
 NVMe driver
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, borntraeger@de.ibm.com, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Karl Rister <krister@redhat.com>


--0rSojgWGcpz+ezC3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 21, 2016 at 12:31:39AM +0800, Fam Zheng wrote:
> This is a new protocol driver that exclusively opens a host NVMe
> controller through VFIO. It achieves better latency than linux-aio.

This is an interesting block driver to have for performance comparisons.
Definitely something that is worth merging.

>                                          nvme://    linux-aio
> ------------------------------------------------------------------
>   fio bs=3D4k  iodepth=3D1 (IOPS)             30014      24009
>   fio bs=3D4k  iodepth=3D1 (IOPS)  +polling   45148      34689
>   fio bs=3D64k iodepth=3D1 (IOPS)             17801      14954
>   fio bs=3D64k iodepth=3D1 (IOPS)  +polling   17970      14564
>=20
>   fio bs=3D4k  iodepth=3D32 (IOPS)           110637     121480
>   fio bs=3D4k  iodepth=3D32 (IOPS) +polling  145533     166878
>   fio bs=3D64k iodepth=3D32 (IOPS)            50525      50596
>   fio bs=3D64k iodepth=3D32 (IOPS) +polling   50482      50534
>=20
>   (host) qemu-img bench -c 8000000 (sec)  15.00      43.13
>=20
> ("+polling" means poll-max-ns=3D18000 which is a rule of thumb value for
> the used NVMe device, otherwise it defaults to 0).
>=20
> For the rows where linux-aio is faster, a lot of evidence shows that the
> io queue is more likely to stay full if the request completions happen
> faster, as in the nvme:// case, hence less batch submission and request
> merging than linux-aio.

I'm not sure I understand this paragraph.  Sounds like you are saying
that nvme:// has lower latency and this defeats batch submission.
Higher numbers are still better at the end of the day so it's worth
studying this more closely and coming up with solutions.  Maybe at a
certain rate of submission it makes sense to favor throughput
(batching) even with nvme://.

Regarding merging: are you doing sequential I/O?  Please try random
instead.

> This patch is co-authored by Paolo and me.
>=20
> Signed-off-by: Fam Zheng <famz@redhat.com>
> ---
>  block/Makefile.objs |    1 +
>  block/nvme.c        | 1026 +++++++++++++++++++++++++++++++++++++++++++++=
++++++
>  2 files changed, 1027 insertions(+)
>  create mode 100644 block/nvme.c
>=20
> diff --git a/block/Makefile.objs b/block/Makefile.objs
> index 67a036a..fe975a6 100644
> --- a/block/Makefile.objs
> +++ b/block/Makefile.objs
> @@ -11,6 +11,7 @@ block-obj-$(CONFIG_POSIX) +=3D raw-posix.o
>  block-obj-$(CONFIG_LINUX_AIO) +=3D linux-aio.o
>  block-obj-y +=3D null.o mirror.o commit.o io.o
>  block-obj-y +=3D throttle-groups.o
> +block-obj-y +=3D nvme.o
> =20
>  block-obj-y +=3D nbd.o nbd-client.o sheepdog.o
>  block-obj-$(CONFIG_LIBISCSI) +=3D iscsi.o
> diff --git a/block/nvme.c b/block/nvme.c
> new file mode 100644
> index 0000000..5c9ffde
> --- /dev/null
> +++ b/block/nvme.c
> @@ -0,0 +1,1026 @@
> +/*
> + * NVMe block driver based on vfio
> + *
> + * Copyright 2016 Red Hat, Inc.
> + *
> + * Authors:
> + *   Fam Zheng <famz@redhat.com>
> + *   Paolo Bonzini <pbonzini@redhat.com>
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or la=
ter.
> + * See the COPYING file in the top-level directory.
> + */
> +
> +#include "qemu/osdep.h"
> +#include <linux/vfio.h>
> +#include "qapi/error.h"
> +#include "qapi/qmp/qdict.h"
> +#include "qapi/qmp/qstring.h"
> +#include "block/block_int.h"
> +#include "qemu/error-report.h"
> +#include "qemu/vfio-helpers.h"
> +
> +#define NVME_DEBUG 0
> +
> +#define DPRINTF(...) \
> +    if (NVME_DEBUG) { \
> +        printf(__VA_ARGS__); \
> +    }
> +
> +#define NVME_SQ_ENTRY_BYTES 64
> +#define NVME_CQ_ENTRY_BYTES 16
> +#define NVME_QUEUE_SIZE 128
> +
> +/* TODO: share definitions with hw/block/nvme.c? */

Sounds good.

> +enum NvmeAdminCommands {
> +    NVME_ADM_CMD_DELETE_SQ      =3D 0x00,
> +    NVME_ADM_CMD_CREATE_SQ      =3D 0x01,
> +    NVME_ADM_CMD_GET_LOG_PAGE   =3D 0x02,
> +    NVME_ADM_CMD_DELETE_CQ      =3D 0x04,
> +    NVME_ADM_CMD_CREATE_CQ      =3D 0x05,
> +    NVME_ADM_CMD_IDENTIFY       =3D 0x06,
> +    NVME_ADM_CMD_ABORT          =3D 0x08,
> +    NVME_ADM_CMD_SET_FEATURES   =3D 0x09,
> +    NVME_ADM_CMD_GET_FEATURES   =3D 0x0a,
> +    NVME_ADM_CMD_ASYNC_EV_REQ   =3D 0x0c,
> +    NVME_ADM_CMD_ACTIVATE_FW    =3D 0x10,
> +    NVME_ADM_CMD_DOWNLOAD_FW    =3D 0x11,
> +    NVME_ADM_CMD_FORMAT_NVM     =3D 0x80,
> +    NVME_ADM_CMD_SECURITY_SEND  =3D 0x81,
> +    NVME_ADM_CMD_SECURITY_RECV  =3D 0x82,
> +};
> +
> +enum NvmeIoCommands {
> +    NVME_CMD_FLUSH              =3D 0x00,
> +    NVME_CMD_WRITE              =3D 0x01,
> +    NVME_CMD_READ               =3D 0x02,
> +    NVME_CMD_WRITE_UNCOR        =3D 0x04,
> +    NVME_CMD_COMPARE            =3D 0x05,
> +    NVME_CMD_DSM                =3D 0x09,
> +};
> +
> +typedef struct {
> +    uint8_t  opcode;
> +    uint8_t  flags;
> +    uint16_t cid;
> +    uint32_t nsid;
> +    uint64_t reserved;
> +    uint64_t mptr;
> +    uint64_t prp1;
> +    uint64_t prp2;
> +    uint32_t cdw10;
> +    uint32_t cdw11;
> +    uint32_t cdw12;
> +    uint32_t cdw13;
> +    uint32_t cdw14;
> +    uint32_t cdw15;
> +} QEMU_PACKED NVMeCommand;
> +
> +typedef struct {
> +    uint32_t cmd_specific;
> +    uint32_t reserved;
> +    uint16_t sq_head;
> +    uint16_t sqid;
> +    uint16_t cid;
> +    uint16_t status;
> +} QEMU_PACKED NVMeCompletion;
> +
> +typedef struct {
> +    int32_t  head, tail;
> +    uint8_t  *queue;
> +    uint64_t iova;
> +    volatile uint32_t *doorbell;
> +} NVMeQueue;
> +
> +typedef struct {
> +    BlockCompletionFunc *cb;
> +    void *opaque;
> +    int cid;
> +    void *prp_list_page;
> +    uint64_t prp_list_iova;
> +} NVMeRequest;
> +
> +typedef struct {
> +    int         index;
> +    NVMeQueue   sq, cq;
> +    int         cq_phase;
> +    uint8_t     *prp_list_pages;
> +    uint64_t    prp_list_base_iova;
> +    NVMeRequest reqs[NVME_QUEUE_SIZE];
> +    CoQueue     wait_queue;

"free_req_queue" describes the purpose of this queue.

> +    bool        busy;
> +    int         need_kick;
> +    int         inflight;
> +} NVMeQueuePair;
> +
> +typedef volatile struct {
> +    uint64_t cap;
> +    uint32_t vs;
> +    uint32_t intms;
> +    uint32_t intmc;
> +    uint32_t cc;
> +    uint32_t reserved0;
> +    uint32_t csts;
> +    uint32_t nssr;
> +    uint32_t aqa;
> +    uint64_t asq;
> +    uint64_t acq;
> +    uint32_t cmbloc;
> +    uint32_t cmbsz;
> +    uint8_t  reserved1[0xec0];
> +    uint8_t  cmd_set_specfic[0x100];
> +    uint32_t doorbells[];
> +} QEMU_PACKED NVMeRegs;
> +
> +QEMU_BUILD_BUG_ON(offsetof(NVMeRegs, doorbells) !=3D 0x1000);
> +
> +typedef struct {
> +    QEMUVFIOState *vfio;
> +    NVMeRegs *regs;
> +    /* The submission/completion queue pairs.
> +     * [0]: admin queue.
> +     * [1..]: io queues.
> +     */
> +    NVMeQueuePair **queues;
> +    int nr_queues;
> +    size_t page_size;
> +    /* How many uint32_t elements does each doorbell entry take. */
> +    size_t doorbell_scale;
> +    bool write_cache;
> +    EventNotifier event_notifier;

"event_notifier" describes the type, not the purpose of the field.
"irq_notifier" is clearer.

> +    uint64_t nsze; /* Namespace size reported by identify command */
> +    int nsid;      /* The namespace id to read/write data. */
> +    uint64_t max_transfer;
> +    int plugged;
> +    Notifier vfree_notify;
> +} BDRVNVMeState;
> +
> +#define NVME_BLOCK_OPT_DEVICE "device"
> +#define NVME_BLOCK_OPT_NAMESPACE "namespace"
> +
> +static QemuOptsList runtime_opts =3D {
> +    .name =3D "nvme",
> +    .head =3D QTAILQ_HEAD_INITIALIZER(runtime_opts.head),
> +    .desc =3D {
> +        {
> +            .name =3D NVME_BLOCK_OPT_DEVICE,
> +            .type =3D QEMU_OPT_STRING,
> +            .help =3D "NVMe PCI device address",
> +        },
> +        {
> +            .name =3D NVME_BLOCK_OPT_NAMESPACE,
> +            .type =3D QEMU_OPT_NUMBER,
> +            .help =3D "NVMe namespace",
> +        },
> +        { /* end of list */ }
> +    },
> +};
> +
> +static void nvme_init_queue(BlockDriverState *bs, NVMeQueue *q,
> +                            int nentries, int entry_bytes, Error **errp)
> +{
> +    BDRVNVMeState *s =3D bs->opaque;
> +    size_t bytes;
> +    int r;
> +
> +    bytes =3D ROUND_UP(nentries * entry_bytes, s->page_size);
> +    q->head =3D q->tail =3D 0;
> +    q->queue =3D qemu_try_blockalign0(bs, bytes);
> +
> +    if (!q->queue) {
> +        error_setg(errp, "Cannot allocate queue");
> +        return;
> +    }
> +    r =3D qemu_vfio_dma_map(s->vfio, q->queue, bytes, true, &q->iova);
> +    if (r) {
> +        error_setg(errp, "Cannot map queue");
> +    }
> +}
> +
> +static void nvme_free_queue_pair(BlockDriverState *bs, NVMeQueuePair *q)
> +{
> +    qemu_vfree(q->prp_list_pages);
> +    qemu_vfree(q->sq.queue);
> +    qemu_vfree(q->cq.queue);
> +    g_free(q);
> +}
> +
> +static NVMeQueuePair *nvme_create_queue_pair(BlockDriverState *bs,
> +                                             int idx, int size,
> +                                             Error **errp)
> +{
> +    int i, r;
> +    BDRVNVMeState *s =3D bs->opaque;
> +    Error *local_err =3D NULL;
> +    NVMeQueuePair *q =3D g_new0(NVMeQueuePair, 1);
> +    uint64_t prp_list_iovas[NVME_QUEUE_SIZE];
> +
> +    q->index =3D idx;
> +    qemu_co_queue_init(&q->wait_queue);
> +    q->prp_list_pages =3D qemu_blockalign0(bs, s->page_size * NVME_QUEUE=
_SIZE);
> +    r =3D qemu_vfio_dma_map(s->vfio, q->prp_list_pages,
> +                          s->page_size * NVME_QUEUE_SIZE,
> +                          false, prp_list_iovas);
> +    if (r) {
> +        goto fail;
> +    }
> +    for (i =3D 0; i < NVME_QUEUE_SIZE; i++) {
> +        NVMeRequest *req =3D &q->reqs[i];
> +        req->cid =3D i + 1;
> +        req->prp_list_page =3D q->prp_list_pages + i * s->page_size;
> +        req->prp_list_iova =3D prp_list_iovas[i];
> +    }
> +    nvme_init_queue(bs, &q->sq, size, NVME_SQ_ENTRY_BYTES, &local_err);
> +    if (local_err) {
> +        error_propagate(errp, local_err);
> +        goto fail;
> +    }
> +    q->sq.doorbell =3D &s->regs->doorbells[idx * 2 * s->doorbell_scale];
> +
> +    nvme_init_queue(bs, &q->cq, size, NVME_CQ_ENTRY_BYTES, &local_err);
> +    if (local_err) {
> +        error_propagate(errp, local_err);
> +        goto fail;
> +    }
> +    q->cq.doorbell =3D &s->regs->doorbells[idx * 2 * s->doorbell_scale +=
 1];
> +
> +    return q;
> +fail:
> +    nvme_free_queue_pair(bs, q);
> +    return NULL;
> +}
> +
> +static void nvme_kick(BDRVNVMeState *s, NVMeQueuePair *q)
> +{
> +    if (s->plugged || !q->need_kick) {
> +        return;
> +    }
> +    DPRINTF("nvme kick queue %d\n", q->index);
> +    assert(!(q->sq.tail & 0xFF00));
> +    /* Fence the write to submission queue entry before notifying the gu=
est. */
> +    smp_wmb();
> +    *q->sq.doorbell =3D cpu_to_le32(q->sq.tail);
> +    q->inflight +=3D q->need_kick;
> +    q->need_kick =3D 0;
> +}
> +
> +static NVMeRequest *nvme_get_free_req(NVMeQueuePair *q)
> +{
> +    int i;
> +    if (q->inflight + q->need_kick > NVME_QUEUE_SIZE - 2) {
> +        /* We have to leave one slot empty as that is the full queue cas=
e (head
> +         * =3D=3D tail + 1). */
> +        return NULL;
> +    }
> +    for (i =3D 0; i < NVME_QUEUE_SIZE; i++) {
> +        if (!q->reqs[i].cb) {
> +            return &q->reqs[i];
> +        }
> +    }
> +    return NULL;
> +}
> +
> +static inline int nvme_translate_error(const NVMeCompletion *c)
> +{
> +    if ((le16_to_cpu(c->status) >> 1) & 0xFF) {
> +        DPRINTF("NVMe error cmd specific %x sq head %x sqid %x cid %x st=
atus %x\n",
> +                c->cmd_specific, c->sq_head, c->sqid, c->cid, c->status);
> +    }
> +    switch ((le16_to_cpu(c->status) >> 1) & 0xFF) {
> +    case 0:
> +        return 0;
> +    case 1:
> +        return -ENOSYS;
> +    case 2:
> +        return -EINVAL;
> +    default:
> +        return -EIO;
> +    }
> +}
> +
> +static bool nvme_process_completion(BDRVNVMeState *s, NVMeQueuePair *q)
> +{
> +    bool progress =3D false;
> +    NVMeRequest *req;
> +    NVMeCompletion *c;
> +
> +    DPRINTF("nvme process completion %d inflight %d\n", q->index, q->inf=
light);
> +    if (q->busy || s->plugged) {
> +        DPRINTF("queue busy\n");
> +        return false;
> +    }
> +    q->busy =3D true;
> +    assert(q->inflight >=3D 0);
> +    while (q->inflight) {
> +        c =3D (NVMeCompletion *)&q->cq.queue[q->cq.head * NVME_CQ_ENTRY_=
BYTES];
> +        if (!c->cid || (le16_to_cpu(c->status) & 0x1) =3D=3D q->cq_phase=
) {
> +            break;
> +        }
> +        q->cq.head =3D (q->cq.head + 1) % NVME_QUEUE_SIZE;
> +        if (!q->cq.head) {
> +            q->cq_phase =3D !q->cq_phase;
> +        }
> +        /* XXX: error handling instead of assert as it's from device? */
> +        assert(c->cid > 0);
> +        assert(c->cid <=3D NVME_QUEUE_SIZE);
> +        DPRINTF("nvme completing command %d\n", c->cid);
> +        req =3D &q->reqs[c->cid - 1];
> +        assert(req->cid =3D=3D c->cid);
> +        assert(req->cb);
> +        req->cb(req->opaque, nvme_translate_error(c));
> +        req->cb =3D req->opaque =3D NULL;
> +        qemu_co_enter_next(&q->wait_queue);
> +        c->cid =3D 0;
> +        q->inflight--;
> +        /* Flip Phase Tag bit. */
> +        c->status =3D cpu_to_le16(le16_to_cpu(c->status) ^ 0x1);
> +        progress =3D true;
> +    }
> +    if (progress) {
> +        /* Notify the device so it can post more completions. */
> +        smp_mb_release();
> +        *q->cq.doorbell =3D cpu_to_le32(q->cq.head);
> +    }
> +    q->busy =3D false;
> +    return progress;
> +}
> +
> +static void nvme_submit_command(BDRVNVMeState *s, NVMeQueuePair *q,
> +                                NVMeRequest *req,
> +                                NVMeCommand *cmd, BlockCompletionFunc cb,
> +                                void *opaque)
> +{
> +    req->cb =3D cb;
> +    req->opaque =3D opaque;
> +    cmd->cid =3D cpu_to_le32(req->cid);
> +    DPRINTF("nvme submit command %d to queue %d\n", req->cid, q->index);
> +    memcpy((uint8_t *)q->sq.queue +
> +           q->sq.tail * NVME_SQ_ENTRY_BYTES, cmd, sizeof(*cmd));
> +    q->sq.tail =3D (q->sq.tail + 1) % NVME_QUEUE_SIZE;
> +    q->need_kick++;
> +    nvme_kick(s, q);
> +    nvme_process_completion(s, q);
> +}
> +
> +static void nvme_cmd_sync_cb(void *opaque, int ret)
> +{
> +    int *pret =3D opaque;
> +    *pret =3D ret;
> +}
> +
> +static int nvme_cmd_sync(BlockDriverState *bs, NVMeQueuePair *q,
> +                         NVMeCommand *cmd)
> +{
> +    NVMeRequest *req;
> +    BDRVNVMeState *s =3D bs->opaque;
> +    int ret =3D -EINPROGRESS;
> +    req =3D nvme_get_free_req(q);
> +    if (!req) {
> +        return -EBUSY;
> +    }
> +    nvme_submit_command(s, q, req, cmd, nvme_cmd_sync_cb, &ret);
> +
> +    BDRV_POLL_WHILE(bs, ret =3D=3D -EINPROGRESS);
> +    return ret;
> +}
> +
> +static bool nvme_identify(BlockDriverState *bs, int namespace, Error **e=
rrp)
> +{
> +    BDRVNVMeState *s =3D bs->opaque;
> +    uint8_t *resp;
> +    int r;
> +    uint64_t iova;
> +    NVMeCommand cmd =3D {
> +        .opcode =3D NVME_ADM_CMD_IDENTIFY,
> +        .cdw10 =3D cpu_to_le32(0x1),
> +    };
> +
> +    resp =3D qemu_try_blockalign0(bs, 4096);
> +    if (!resp) {
> +        error_setg(errp, "Cannot allocate buffer for identify response");
> +        return false;
> +    }
> +    r =3D qemu_vfio_dma_map(s->vfio, resp, 4096, true, &iova);
> +    if (r) {
> +        error_setg(errp, "Cannot map buffer for DMA");
> +        goto fail;
> +    }
> +    cmd.prp1 =3D cpu_to_le64(iova);
> +
> +    if (nvme_cmd_sync(bs, s->queues[0], &cmd)) {
> +        error_setg(errp, "Failed to identify controller");
> +        goto fail;
> +    }
> +
> +    if (le32_to_cpu(*(uint32_t *)&resp[516]) < namespace) {
> +        error_setg(errp, "Invalid namespace");
> +        goto fail;
> +    }
> +    s->write_cache =3D le32_to_cpu(resp[525]) & 0x1;
> +    s->max_transfer =3D (resp[77] ? 1 << resp[77] : 0) * s->page_size;
> +    /* For now the page list buffer per command is one page, to hold at =
most
> +     * s->page_size / sizeof(uint64_t) entries. */
> +    s->max_transfer =3D MIN_NON_ZERO(s->max_transfer,
> +                          s->page_size / sizeof(uint64_t) * s->page_size=
);
> +
> +    memset((char *)resp, 0, 4096);
> +
> +    cmd.cdw10 =3D 0;
> +    cmd.nsid =3D namespace;
> +    if (nvme_cmd_sync(bs, s->queues[0], &cmd)) {
> +        error_setg(errp, "Failed to identify namespace");
> +        goto fail;
> +    }
> +
> +    /*qemu_hexdump((const char *)resp, stdout, "NS", 4096);*/
> +    s->nsze =3D le64_to_cpu(*(uint64_t *)&resp[0]);
> +
> +    qemu_vfree(resp);
> +    return true;
> +fail:
> +    qemu_vfree(resp);
> +    return false;
> +}
> +
> +static void nvme_handle_event(EventNotifier *n)
> +{
> +    int i;
> +    BDRVNVMeState *s =3D container_of(n, BDRVNVMeState, event_notifier);
> +
> +    DPRINTF("nvme handle event\n");
> +    event_notifier_test_and_clear(n);
> +    for (i =3D 0; i < s->nr_queues; i++) {
> +        while (nvme_process_completion(s, s->queues[i])) {
> +            /* Keep polling until no progress. */
> +        }
> +    }
> +}
> +
> +static bool nvme_add_io_queue(BlockDriverState *bs, Error **errp)
> +{
> +    BDRVNVMeState *s =3D bs->opaque;
> +    int n =3D s->nr_queues;
> +    NVMeQueuePair *q;
> +    NVMeCommand cmd;
> +    int queue_size =3D NVME_QUEUE_SIZE;
> +
> +    q =3D nvme_create_queue_pair(bs, n, queue_size, errp);
> +    if (!q) {
> +        return false;
> +    }
> +    cmd =3D (NVMeCommand) {
> +        .opcode =3D NVME_ADM_CMD_CREATE_CQ,
> +        .prp1 =3D cpu_to_le64(q->cq.iova),
> +        .cdw10 =3D cpu_to_le32(((queue_size - 1) << 16) | (n & 0xFFFF)),
> +        .cdw11 =3D cpu_to_le32(0x3),
> +    };
> +    if (nvme_cmd_sync(bs, s->queues[0], &cmd)) {
> +        error_setg(errp, "Failed to create io queue [%d]", n);
> +        nvme_free_queue_pair(bs, q);
> +        return false;
> +    }
> +    cmd =3D (NVMeCommand) {
> +        .opcode =3D NVME_ADM_CMD_CREATE_SQ,
> +        .prp1 =3D cpu_to_le64(q->sq.iova),
> +        .cdw10 =3D cpu_to_le32(((queue_size - 1) << 16) | (n & 0xFFFF)),
> +        .cdw11 =3D cpu_to_le32(0x1 | (n << 16)),
> +    };
> +    if (nvme_cmd_sync(bs, s->queues[0], &cmd)) {
> +        error_setg(errp, "Failed to create io queue [%d]", n);
> +        nvme_free_queue_pair(bs, q);
> +        return false;
> +    }
> +    s->queues =3D g_renew(NVMeQueuePair *, s->queues, n + 1);
> +    s->queues[n] =3D q;
> +    s->nr_queues++;
> +    return true;
> +}
> +
> +static bool nvme_poll_cb(void *opaque)
> +{
> +    int i;
> +    EventNotifier *e =3D opaque;
> +    BDRVNVMeState *s =3D container_of(e, BDRVNVMeState, event_notifier);
> +    bool progress =3D false;
> +
> +    DPRINTF("nvme poll cb\n");
> +    for (i =3D 0; i < s->nr_queues; i++) {
> +        while (nvme_process_completion(s, s->queues[i])) {
> +            progress =3D true;
> +        }
> +    }
> +    return progress;
> +}
> +
> +static void nvme_vfree_cb(Notifier *n, void *p)
> +{
> +    BDRVNVMeState *s =3D container_of(n, BDRVNVMeState, vfree_notify);
> +    qemu_vfio_dma_unmap(s->vfio, p);
> +}
> +
> +static int nvme_init(BlockDriverState *bs, const char *device, int names=
pace,
> +                     Error **errp)
> +{
> +    BDRVNVMeState *s =3D bs->opaque;
> +    int ret;
> +    uint64_t cap;
> +    uint64_t timeout_ms;
> +    uint64_t deadline, now;
> +
> +    s->nsid =3D namespace;
> +    ret =3D event_notifier_init(&s->event_notifier, 0);
> +    if (ret) {
> +        error_setg(errp, "Failed to init event notifier");
> +        return ret;
> +    }
> +
> +    s->vfree_notify.notify =3D nvme_vfree_cb;
> +    qemu_vfree_add_notifier(&s->vfree_notify);
> +
> +    s->vfio =3D qemu_vfio_open_pci(device, errp);
> +    if (!s->vfio) {
> +        ret =3D -EINVAL;
> +        goto fail;
> +    }
> +
> +    s->regs =3D qemu_vfio_pci_map_bar(s->vfio, 0, errp);
> +    if (!s->regs) {
> +        ret =3D -EINVAL;
> +        goto fail;
> +    }
> +
> +    /* Perform initialize sequence as described in NVMe spec "7.6.1
> +     * Initialization". */
> +
> +    cap =3D le64_to_cpu(s->regs->cap);
> +    if (!(cap & (1ULL << 37))) {
> +        error_setg(errp, "Device doesn't support NVMe command set");
> +        ret =3D -EINVAL;
> +        goto fail;
> +    }
> +
> +    s->page_size =3D MAX(4096, 1 << (12 + ((cap >> 48) & 0xF)));
> +    s->doorbell_scale =3D (4 << (((cap >> 32) & 0xF))) / sizeof(uint32_t=
);
> +    bs->bl.opt_mem_alignment =3D s->page_size;
> +    timeout_ms =3D MIN(500 * ((cap >> 24) & 0xFF), 30000);
> +
> +    /* Reset device to get a clean state. */
> +    s->regs->cc =3D cpu_to_le32(le32_to_cpu(s->regs->cc) & 0xFE);
> +    /* Wait for CSTS.RDY =3D 0. */
> +    deadline =3D qemu_clock_get_ns(QEMU_CLOCK_REALTIME) + timeout_ms * 1=
000000ULL;
> +    while (le32_to_cpu(s->regs->csts) & 0x1) {
> +        if (qemu_clock_get_ns(QEMU_CLOCK_REALTIME) > deadline) {
> +            error_setg(errp, "Timeout while waiting for device to reset =
(%ld ms)",
> +                       timeout_ms);
> +            ret =3D -ETIMEDOUT;
> +            goto fail;
> +        }
> +    }
> +
> +    /* Set up admin queue. */
> +    s->queues =3D g_new(NVMeQueuePair *, 1);
> +    s->nr_queues =3D 1;
> +    s->queues[0] =3D nvme_create_queue_pair(bs, 0, NVME_QUEUE_SIZE, errp=
);
> +    if (!s->queues[0]) {
> +        ret =3D -EINVAL;
> +        goto fail;
> +    }
> +    QEMU_BUILD_BUG_ON(NVME_QUEUE_SIZE & 0xF000);
> +    s->regs->aqa =3D cpu_to_le32((NVME_QUEUE_SIZE << 16) | NVME_QUEUE_SI=
ZE);
> +    s->regs->asq =3D cpu_to_le64(s->queues[0]->sq.iova);
> +    s->regs->acq =3D cpu_to_le64(s->queues[0]->cq.iova);
> +
> +    /* After setting up all control registers we can enable device now. =
*/
> +    s->regs->cc =3D cpu_to_le32((ctz32(NVME_CQ_ENTRY_BYTES) << 20) |
> +                              (ctz32(NVME_SQ_ENTRY_BYTES) << 16) |
> +                              0x1);
> +    /* Wait for CSTS.RDY =3D 1. */
> +    now =3D qemu_clock_get_ns(QEMU_CLOCK_REALTIME);
> +    deadline =3D now + timeout_ms * 1000000;
> +    while (!(le32_to_cpu(s->regs->csts) & 0x1)) {
> +        if (qemu_clock_get_ns(QEMU_CLOCK_REALTIME) > deadline) {
> +            error_setg(errp, "Timeout while waiting for device to start =
(%ld ms)",
> +                       timeout_ms);
> +            ret =3D -ETIMEDOUT;
> +            goto fail_queue;
> +        }
> +    }
> +
> +    ret =3D qemu_vfio_pci_init_irq(s->vfio, &s->event_notifier,
> +                                 VFIO_PCI_MSIX_IRQ_INDEX, errp);
> +    if (ret) {
> +        goto fail_queue;
> +    }
> +    aio_set_event_notifier(bdrv_get_aio_context(bs), &s->event_notifier,
> +                           false, nvme_handle_event, nvme_poll_cb);
> +
> +    if (!nvme_identify(bs, namespace, errp)) {
> +        ret =3D -EIO;
> +        goto fail_handler;
> +    }
> +
> +    /* Set up command queues. */
> +    /* XXX: multiple io queues? */
> +    if (!nvme_add_io_queue(bs, errp)) {
> +        ret =3D -EIO;
> +        goto fail_handler;
> +    }
> +    return 0;
> +
> +fail_handler:
> +    aio_set_event_notifier(bdrv_get_aio_context(bs), &s->event_notifier,
> +                           false, NULL, NULL);
> +fail_queue:
> +    nvme_free_queue_pair(bs, s->queues[0]);
> +fail:
> +    qemu_vfio_pci_unmap_bar(s->vfio, 0, (void *)s->regs);
> +    qemu_vfio_close(s->vfio);
> +    event_notifier_cleanup(&s->event_notifier);
> +    return ret;
> +}
> +
> +static void nvme_parse_filename(const char *filename, QDict *options,
> +                                Error **errp)
> +{
> +    int pref =3D strlen("nvme://");
> +
> +    /* XXX: support namespace in URI like nvme://0000:00:00.0/1 ? */
> +    if (strlen(filename) > pref && !strncmp(filename, "nvme://", pref)) {
> +        qdict_put(options, NVME_BLOCK_OPT_DEVICE,
> +                  qstring_from_str(filename + pref));
> +    }
> +}
> +
> +static int nvme_file_open(BlockDriverState *bs, QDict *options, int flag=
s,
> +                          Error **errp)
> +{
> +    const char *device;
> +    QemuOpts *opts;
> +    int namespace;
> +
> +    opts =3D qemu_opts_create(&runtime_opts, NULL, 0, &error_abort);
> +    qemu_opts_absorb_qdict(opts, options, &error_abort);
> +    device =3D qemu_opt_get(opts, NVME_BLOCK_OPT_DEVICE);
> +    if (!device) {
> +        error_setg(errp, "'" NVME_BLOCK_OPT_DEVICE "' option is required=
");
> +        return -EINVAL;
> +    }
> +
> +    namespace =3D qemu_opt_get_number(opts, NVME_BLOCK_OPT_NAMESPACE, 1);
> +    nvme_init(bs, device, namespace, errp);
> +
> +    qemu_opts_del(opts);
> +    return 0;
> +}
> +
> +static void nvme_close(BlockDriverState *bs)
> +{
> +    int i;
> +    BDRVNVMeState *s =3D bs->opaque;
> +
> +    for (i =3D 0; i < s->nr_queues; ++i) {
> +        nvme_free_queue_pair(bs, s->queues[i]);
> +    }
> +    aio_set_event_notifier(bdrv_get_aio_context(bs), &s->event_notifier,
> +                           false, NULL, NULL);
> +    notifier_remove(&s->vfree_notify);
> +    qemu_vfio_pci_unmap_bar(s->vfio, 0, (void *)s->regs);
> +    qemu_vfio_close(s->vfio);
> +}
> +
> +static int64_t nvme_getlength(BlockDriverState *bs)
> +{
> +    BDRVNVMeState *s =3D bs->opaque;
> +
> +    return s->nsze << BDRV_SECTOR_BITS;
> +}
> +
> +static inline int nvme_cmd_map_qiov(BlockDriverState *bs, NVMeCommand *c=
md,
> +                                    NVMeRequest *req, QEMUIOVector *qiov)
> +{
> +    BDRVNVMeState *s =3D bs->opaque;
> +    uint64_t *pagelist =3D req->prp_list_page;
> +    int i, r;
> +    unsigned int entries =3D 0;
> +
> +    assert(qiov->size);
> +    assert(QEMU_IS_ALIGNED(qiov->size, s->page_size));
> +    assert(qiov->size / s->page_size <=3D s->page_size / sizeof(uint64_t=
));
> +    for (i =3D 0; i < qiov->niov; ++i) {
> +        r =3D qemu_vfio_dma_map(s->vfio,
> +                              qiov->iov[i].iov_base,
> +                              qiov->iov[i].iov_len,
> +                              false, &pagelist[entries]);
> +        if (r) {
> +            return r;
> +        }
> +
> +        entries +=3D qiov->iov[i].iov_len / s->page_size;
> +        assert(entries <=3D s->page_size / sizeof(uint64_t));
> +    }
> +
> +    switch (entries) {
> +    case 0:
> +        abort();
> +    case 1:
> +        cmd->prp1 =3D cpu_to_le64(pagelist[0]);
> +        cmd->prp2 =3D 0;
> +        break;
> +    case 2:
> +        cmd->prp1 =3D cpu_to_le64(pagelist[0]);
> +        cmd->prp2 =3D cpu_to_le64(pagelist[1]);;
> +        break;
> +    default:
> +        cmd->prp1 =3D cpu_to_le64(pagelist[0]);
> +        cmd->prp2 =3D cpu_to_le64(req->prp_list_iova);
> +        for (i =3D 0; i < entries - 1; ++i) {
> +            pagelist[i] =3D cpu_to_le64(pagelist[i + 1]);
> +        }
> +        pagelist[entries] =3D 0;
> +        break;
> +    }
> +    return 0;
> +}
> +
> +typedef struct {
> +    Coroutine *co;
> +    int ret;
> +    AioContext *ctx;
> +} NVMeCoData;
> +
> +static void nvme_rw_cb_bh(void *opaque)
> +{
> +    NVMeCoData *data =3D opaque;
> +    qemu_coroutine_enter(data->co);
> +}
> +
> +static void nvme_rw_cb(void *opaque, int ret)
> +{
> +    NVMeCoData *data =3D opaque;
> +    data->ret =3D ret;
> +    if (!data->co) {
> +        /* The rw coroutine hasn't yielded, don't try to enter. */
> +        return;
> +    }
> +    if (qemu_coroutine_self() !=3D data->co) {
> +        qemu_coroutine_enter(data->co);
> +    } else {
> +        aio_bh_schedule_oneshot(data->ctx, nvme_rw_cb_bh, data);
> +    }
> +}
> +
> +static coroutine_fn int nvme_co_prw_aligned(BlockDriverState *bs,
> +                                            uint64_t offset, uint64_t by=
tes,
> +                                            QEMUIOVector *qiov,
> +                                            bool is_write)
> +{
> +    int r;
> +    BDRVNVMeState *s =3D bs->opaque;
> +    NVMeQueuePair *ioq =3D s->queues[1];
> +    NVMeRequest *req;
> +    NVMeCommand cmd =3D {
> +        .opcode =3D is_write ? NVME_CMD_WRITE : NVME_CMD_READ,
> +        .nsid =3D cpu_to_le32(s->nsid),
> +        .cdw10 =3D cpu_to_le32((offset >> BDRV_SECTOR_BITS) & 0xFFFFFFFF=
),
> +        .cdw11 =3D cpu_to_le32(((offset >> BDRV_SECTOR_BITS) >> 32) & 0x=
FFFFFFFF),
> +        .cdw12 =3D cpu_to_le32(((bytes >> BDRV_SECTOR_BITS) - 1) & 0xFFF=
F),
> +    };
> +    NVMeCoData data =3D {
> +        .ctx =3D bdrv_get_aio_context(bs),
> +        .ret =3D -EINPROGRESS,
> +    };
> +
> +    DPRINTF(">>> NVMe %s offset %lx bytes %lx qiov[%d]\n",
> +            is_write ? "write" : "read",
> +            offset, bytes, qiov->niov);
> +    assert(s->nr_queues > 1);
> +    while (true) {
> +        req =3D nvme_get_free_req(ioq);
> +        if (req) {
> +            break;
> +        }
> +        DPRINTF("nvme wait req\n");
> +        qemu_co_queue_wait(&ioq->wait_queue);
> +        DPRINTF("nvme wait req done\n");
> +    }
> +
> +    r =3D nvme_cmd_map_qiov(bs, &cmd, req, qiov);
> +    if (r) {
> +        return r;

Is req leaked?

> +    }
> +    nvme_submit_command(s, ioq, req, &cmd, nvme_rw_cb, &data);
> +
> +    data.co =3D qemu_coroutine_self();
> +    while (data.ret =3D=3D -EINPROGRESS) {
> +        qemu_coroutine_yield();
> +    }
> +
> +    DPRINTF("<<< NVMe %s offset %lx bytes %lx ret %d\n",
> +            is_write ? "write" : "read",
> +            offset, bytes, data.ret);
> +    return data.ret;
> +}
> +
> +static inline bool nvme_qiov_aligned(BlockDriverState *bs,
> +                                     const QEMUIOVector *qiov)
> +{
> +    int i;
> +    BDRVNVMeState *s =3D bs->opaque;
> +
> +    for (i =3D 0; i < qiov->niov; ++i) {
> +        if (!QEMU_PTR_IS_ALIGNED(qiov->iov[i].iov_base, s->page_size) ||
> +            !QEMU_IS_ALIGNED(qiov->iov[i].iov_len, s->page_size)) {
> +            return false;
> +        }
> +    }
> +    return true;
> +}
> +
> +static inline coroutine_fn
> +int nvme_co_prw(BlockDriverState *bs, uint64_t offset, uint64_t bytes,
> +                QEMUIOVector *qiov, bool is_write)
> +{
> +    int r;
> +    uint8_t *buf;
> +    QEMUIOVector local_qiov;
> +
> +    assert(offset % BDRV_SECTOR_SIZE =3D=3D 0);
> +    assert(bytes % BDRV_SECTOR_SIZE =3D=3D 0);
> +    if (nvme_qiov_aligned(bs, qiov)) {
> +        return nvme_co_prw_aligned(bs, offset, bytes, qiov, is_write);
> +    }
> +    buf =3D qemu_try_blockalign(bs, bytes);
> +
> +    if (!buf) {
> +        return -ENOMEM;
> +    }
> +    qemu_iovec_init(&local_qiov, 1);
> +    qemu_iovec_add(&local_qiov, buf, bytes);
> +    r =3D nvme_co_prw_aligned(bs, offset, bytes, &local_qiov, is_write);
> +    qemu_iovec_destroy(&local_qiov);
> +    if (!r) {
> +        qemu_iovec_from_buf(qiov, 0, buf, bytes);
> +    }
> +    qemu_vfree(buf);
> +    return r;
> +}
> +
> +static coroutine_fn int nvme_co_preadv(BlockDriverState *bs,
> +                                       uint64_t offset, uint64_t bytes,
> +                                       QEMUIOVector *qiov, int flags)
> +{
> +    return nvme_co_prw(bs, offset, bytes, qiov, false);
> +}
> +
> +static coroutine_fn int nvme_co_pwritev(BlockDriverState *bs,
> +                                        uint64_t offset, uint64_t bytes,
> +                                        QEMUIOVector *qiov, int flags)
> +{
> +    return nvme_co_prw(bs, offset, bytes, qiov, true);
> +}
> +
> +static coroutine_fn int nvme_co_flush(BlockDriverState *bs)
> +{
> +    BDRVNVMeState *s =3D bs->opaque;
> +    NVMeQueuePair *ioq =3D s->queues[1];
> +    NVMeRequest *req;
> +    NVMeCommand cmd =3D {
> +        .opcode =3D NVME_CMD_FLUSH,
> +        .nsid =3D cpu_to_le32(s->nsid),
> +    };
> +    NVMeCoData data =3D {
> +        .ctx =3D bdrv_get_aio_context(bs),
> +        .ret =3D -EINPROGRESS,
> +    };
> +
> +    assert(s->nr_queues > 1);
> +    while (true) {
> +        req =3D nvme_get_free_req(ioq);
> +        if (req) {
> +            break;
> +        }
> +        qemu_co_queue_wait(&ioq->wait_queue);
> +    }
> +
> +    nvme_submit_command(s, ioq, req, &cmd, nvme_rw_cb, &data);
> +
> +    data.co =3D qemu_coroutine_self();
> +    if (data.ret =3D=3D -EINPROGRESS) {
> +        qemu_coroutine_yield();
> +    }
> +
> +    return data.ret;
> +}
> +
> +
> +static int nvme_reopen_prepare(BDRVReopenState *reopen_state,
> +                               BlockReopenQueue *queue, Error **errp)
> +{
> +    return 0;
> +}
> +
> +static int64_t coroutine_fn nvme_co_get_block_status(BlockDriverState *b=
s,
> +                                                     int64_t sector_num,
> +                                                     int nb_sectors, int=
 *pnum,
> +                                                     BlockDriverState **=
file)
> +{
> +    *pnum =3D nb_sectors;
> +    *file =3D bs;
> +
> +    return BDRV_BLOCK_OFFSET_VALID | (sector_num << BDRV_SECTOR_BITS);
> +}
> +
> +static void nvme_refresh_filename(BlockDriverState *bs, QDict *opts)
> +{
> +    QINCREF(opts);
> +    qdict_del(opts, "filename");
> +
> +    if (!qdict_size(opts)) {
> +        snprintf(bs->exact_filename, sizeof(bs->exact_filename), "%s://",
> +                 bs->drv->format_name);
> +    }
> +
> +    qdict_put(opts, "driver", qstring_from_str(bs->drv->format_name));
> +    bs->full_open_options =3D opts;
> +}
> +
> +static void nvme_refresh_limits(BlockDriverState *bs, Error **errp)
> +{
> +    BDRVNVMeState *s =3D bs->opaque;
> +
> +    /* XXX: other fields from identify command/controller capacity? */
> +    bs->bl.opt_mem_alignment =3D s->page_size;
> +    /* XXX: are there other limits? */
> +    bs->bl.request_alignment =3D s->page_size;
> +    bs->bl.max_transfer =3D s->max_transfer;
> +}
> +
> +static void nvme_detach_aio_context(BlockDriverState *bs)
> +{
> +    BDRVNVMeState *s =3D bs->opaque;
> +
> +    aio_set_event_notifier(bdrv_get_aio_context(bs), &s->event_notifier,
> +                           false, NULL, NULL);
> +}
> +
> +static void nvme_attach_aio_context(BlockDriverState *bs,
> +                                    AioContext *new_context)
> +{
> +    BDRVNVMeState *s =3D bs->opaque;
> +
> +    aio_set_event_notifier(new_context, &s->event_notifier,
> +                           false, nvme_handle_event, nvme_poll_cb);
> +}
> +
> +static void nvme_aio_plug(BlockDriverState *bs)
> +{
> +    BDRVNVMeState *s =3D bs->opaque;
> +    s->plugged++;
> +}
> +
> +static void nvme_aio_unplug(BlockDriverState *bs)
> +{
> +    int i;
> +    BDRVNVMeState *s =3D bs->opaque;
> +    assert(s->plugged);
> +    if (!--s->plugged) {
> +        for (i =3D 1; i < s->nr_queues; i++) {
> +            nvme_kick(s, s->queues[i]);
> +            nvme_process_completion(s, s->queues[i]);
> +        }
> +    }
> +}
> +
> +static BlockDriver bdrv_nvme =3D {
> +    .format_name              =3D "nvme",
> +    .protocol_name            =3D "nvme",
> +    .instance_size            =3D sizeof(BDRVNVMeState),
> +
> +    .bdrv_parse_filename      =3D nvme_parse_filename,
> +    .bdrv_file_open           =3D nvme_file_open,
> +    .bdrv_close               =3D nvme_close,
> +    .bdrv_getlength           =3D nvme_getlength,
> +
> +    .bdrv_co_preadv           =3D nvme_co_preadv,
> +    .bdrv_co_pwritev          =3D nvme_co_pwritev,
> +    .bdrv_co_flush_to_disk    =3D nvme_co_flush,
> +    .bdrv_reopen_prepare      =3D nvme_reopen_prepare,
> +
> +    .bdrv_co_get_block_status =3D nvme_co_get_block_status,
> +
> +    .bdrv_refresh_filename    =3D nvme_refresh_filename,
> +    .bdrv_refresh_limits      =3D nvme_refresh_limits,
> +
> +    .bdrv_detach_aio_context  =3D nvme_detach_aio_context,
> +    .bdrv_attach_aio_context  =3D nvme_attach_aio_context,
> +
> +    .bdrv_io_plug             =3D nvme_aio_plug,
> +    .bdrv_io_unplug           =3D nvme_aio_unplug,
> +};
> +
> +static void bdrv_nvme_init(void)
> +{
> +    bdrv_register(&bdrv_nvme);
> +}
> +
> +block_init(bdrv_nvme_init);
> --=20
> 2.9.3
>=20
>=20

--0rSojgWGcpz+ezC3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYWm68AAoJEJykq7OBq3PIH3sH/39QaEdAj5EOBqlqnTgNvXIl
BEIj2/kRs9nHLpSQfy6tLyDo4XMCfmfVBPKPVkWli14vMjHtsmI50Ur226nWLWJ3
J0EbkTfoWn+2YseMIQGN4CsFkx/LwuNMZQqLyD0Jq8r9oWMxdg0EJ5/GfJSgfiZB
l8CiJbe4gJSayaHr1NIkGE6s6we0dYfgnSo6dbgjYelkvVO2clTfzwe2Eccw5nym
4eHJ/+WkhJ8MrzQG3LYA5C8PO5OC6IWMNnacbhvP2wN+NPA/F5MddOfIpoTJq+r9
qZ1surYONxxwTsBP12/e5SGiQJjK6QFbccj6i+uWqLNpboTiKG5S+858TU3BbbI=
=I9N7
-----END PGP SIGNATURE-----

--0rSojgWGcpz+ezC3--
