Received: from eggs.gnu.org ([2001:4830:134:3::10]:42405)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eZLBj-0003fG-RK
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 13:33:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eZLBi-0007XP-31
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 13:33:23 -0500
Date: Wed, 10 Jan 2018 18:33:05 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20180110183304.GE24212@stefanha-x1.localdomain>
References: <20180110091846.10699-1-famz@redhat.com>
	<20180110091846.10699-4-famz@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="SNIs70sCzqvszXB4"
Content-Disposition: inline
In-Reply-To: <20180110091846.10699-4-famz@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v4 3/9] block: Add VFIO based NVMe driver
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Keith Busch <keith.busch@intel.com>, qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, Karl Rister <krister@redhat.com>


--SNIs70sCzqvszXB4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jan 10, 2018 at 05:18:40PM +0800, Fam Zheng wrote:

There are several memory and lock leaks in this patch.  Please work with
Paolo to get the __attribute__((cleanup(...))) patch series merged so
this class of bugs can be eliminated:
https://lists.gnu.org/archive/html/qemu-devel/2017-12/msg01648.html

> +typedef struct {
> +    CoQueue     free_req_queue;
> +    QemuMutex   lock;
> +
> +    /* Fields protected by BQL */
> +    int         index;
> +    uint8_t     *prp_list_pages;
> +
> +    /* Fields protected by @lock */

Does this lock serve any purpose?  I didn't see a place where these
fields is accessed from multiple threads.  Perhaps you're trying to
prepare for multiqueue, but then other things like the
BDRVNVMeState->inflight counter aren't protected so it doesn't make
sense.

> +static NVMeRequest *nvme_get_free_req(NVMeQueuePair *q)
> +{
> +    int i;
> +    NVMeRequest *req = NULL;
> +
> +    qemu_mutex_lock(&q->lock);
> +    while (q->inflight + q->need_kick > NVME_QUEUE_SIZE - 2) {
> +        /* We have to leave one slot empty as that is the full queue case (head
> +         * == tail + 1). */
> +        if (qemu_in_coroutine()) {
> +            trace_nvme_free_req_queue_wait(q);
> +            qemu_mutex_unlock(&q->lock);
> +            qemu_co_queue_wait(&q->free_req_queue, NULL);
> +            qemu_mutex_lock(&q->lock);
> +        } else {
> +            return NULL;

q->lock is held.

> +static void nvme_identify(BlockDriverState *bs, int namespace, Error **errp)
> +{
> +    BDRVNVMeState *s = bs->opaque;
> +    NvmeIdCtrl *idctrl;
> +    NvmeIdNs *idns;
> +    uint8_t *resp;
> +    int r;
> +    uint64_t iova;
> +    NvmeCmd cmd = {
> +        .opcode = NVME_ADM_CMD_IDENTIFY,
> +        .cdw10 = cpu_to_le32(0x1),
> +    };
> +
> +    resp = qemu_try_blockalign0(bs, sizeof(NvmeIdCtrl));
> +    if (!resp) {
> +        error_setg(errp, "Cannot allocate buffer for identify response");
> +        goto out;
> +    }
> +    idctrl = (NvmeIdCtrl *)resp;
> +    idns = (NvmeIdNs *)resp;
> +    r = qemu_vfio_dma_map(s->vfio, resp, sizeof(NvmeIdCtrl), true, &iova);
> +    if (r) {
> +        error_setg(errp, "Cannot map buffer for DMA");
> +        goto out;
> +    }
> +    cmd.prp1 = cpu_to_le64(iova);
> +
> +    if (nvme_cmd_sync(bs, s->queues[0], &cmd)) {
> +        error_setg(errp, "Failed to identify controller");
> +        goto out;
> +    }
> +
> +    if (le32_to_cpu(idctrl->nn) < namespace) {
> +        error_setg(errp, "Invalid namespace");
> +        goto out;
> +    }
> +    s->write_cache = le32_to_cpu(idctrl->vwc) & 0x1;
> +    s->max_transfer = (idctrl->mdts ? 1 << idctrl->mdts : 0) * s->page_size;
> +    /* For now the page list buffer per command is one page, to hold at most
> +     * s->page_size / sizeof(uint64_t) entries. */
> +    s->max_transfer = MIN_NON_ZERO(s->max_transfer,
> +                          s->page_size / sizeof(uint64_t) * s->page_size);
> +
> +    memset(resp, 0, 4096);
> +
> +    cmd.cdw10 = 0;
> +    cmd.nsid = namespace;

Missing cpu_to_le32().

> +static int nvme_init(BlockDriverState *bs, const char *device, int namespace,
> +                     Error **errp)
> +{
> +    BDRVNVMeState *s = bs->opaque;
> +    int ret;
> +    uint64_t cap;
> +    uint64_t timeout_ms;
> +    uint64_t deadline, now;
> +    Error *local_err = NULL;
> +
> +    qemu_co_mutex_init(&s->dma_map_lock);
> +    qemu_co_queue_init(&s->dma_flush_queue);
> +    s->nsid = namespace;
> +    s->aio_context = qemu_get_current_aio_context();

Why not bdrv_get_aio_context(bs)?

> +    ret = event_notifier_init(&s->irq_notifier, 0);
> +    if (ret) {
> +        error_setg(errp, "Failed to init event notifier");
> +        return ret;

dma_map_lock should be destroyed.

> +    }
> +
> +    s->vfio = qemu_vfio_open_pci(device, errp);
> +    if (!s->vfio) {
> +        ret = -EINVAL;
> +        goto fail;
> +    }
> +
> +    s->regs = qemu_vfio_pci_map_bar(s->vfio, 0, errp);
> +    if (!s->regs) {
> +        ret = -EINVAL;
> +        goto fail;
> +    }
> +
> +    /* Perform initialize sequence as described in NVMe spec "7.6.1
> +     * Initialization". */
> +
> +    cap = le64_to_cpu(s->regs->cap);
> +    if (!(cap & (1ULL << 37))) {
> +        error_setg(errp, "Device doesn't support NVMe command set");
> +        ret = -EINVAL;
> +        goto fail;
> +    }
> +
> +    s->page_size = MAX(4096, 1 << (12 + ((cap >> 48) & 0xF)));
> +    s->doorbell_scale = (4 << (((cap >> 32) & 0xF))) / sizeof(uint32_t);
> +    bs->bl.opt_mem_alignment = s->page_size;
> +    timeout_ms = MIN(500 * ((cap >> 24) & 0xFF), 30000);
> +
> +    /* Reset device to get a clean state. */
> +    s->regs->cc = cpu_to_le32(le32_to_cpu(s->regs->cc) & 0xFE);
> +    /* Wait for CSTS.RDY = 0. */
> +    deadline = qemu_clock_get_ns(QEMU_CLOCK_REALTIME) + timeout_ms * 1000000ULL;
> +    while (le32_to_cpu(s->regs->csts) & 0x1) {
> +        if (qemu_clock_get_ns(QEMU_CLOCK_REALTIME) > deadline) {
> +            error_setg(errp, "Timeout while waiting for device to reset (%ld ms)",
> +                       timeout_ms);
> +            ret = -ETIMEDOUT;
> +            goto fail;
> +        }
> +    }
> +
> +    /* Set up admin queue. */
> +    s->queues = g_new(NVMeQueuePair *, 1);
> +    s->nr_queues = 1;
> +    s->queues[0] = nvme_create_queue_pair(bs, 0, NVME_QUEUE_SIZE, errp);
> +    if (!s->queues[0]) {
> +        ret = -EINVAL;
> +        goto fail;
> +    }
> +    QEMU_BUILD_BUG_ON(NVME_QUEUE_SIZE & 0xF000);
> +    s->regs->aqa = cpu_to_le32((NVME_QUEUE_SIZE << 16) | NVME_QUEUE_SIZE);
> +    s->regs->asq = cpu_to_le64(s->queues[0]->sq.iova);
> +    s->regs->acq = cpu_to_le64(s->queues[0]->cq.iova);
> +
> +    /* After setting up all control registers we can enable device now. */
> +    s->regs->cc = cpu_to_le32((ctz32(NVME_CQ_ENTRY_BYTES) << 20) |
> +                              (ctz32(NVME_SQ_ENTRY_BYTES) << 16) |
> +                              0x1);
> +    /* Wait for CSTS.RDY = 1. */
> +    now = qemu_clock_get_ns(QEMU_CLOCK_REALTIME);
> +    deadline = now + timeout_ms * 1000000;
> +    while (!(le32_to_cpu(s->regs->csts) & 0x1)) {
> +        if (qemu_clock_get_ns(QEMU_CLOCK_REALTIME) > deadline) {
> +            error_setg(errp, "Timeout while waiting for device to start (%ld ms)",
> +                       timeout_ms);
> +            ret = -ETIMEDOUT;
> +            goto fail_queue;
> +        }
> +    }
> +
> +    ret = qemu_vfio_pci_init_irq(s->vfio, &s->irq_notifier,
> +                                 VFIO_PCI_MSIX_IRQ_INDEX, errp);
> +    if (ret) {
> +        goto fail_queue;
> +    }
> +    aio_set_event_notifier(bdrv_get_aio_context(bs), &s->irq_notifier,
> +                           false, nvme_handle_event, nvme_poll_cb);
> +
> +    nvme_identify(bs, namespace, errp);
> +    if (local_err) {
> +        error_propagate(errp, local_err);
> +        ret = -EIO;
> +        goto fail_handler;
> +    }
> +
> +    /* Set up command queues. */
> +    if (!nvme_add_io_queue(bs, errp)) {
> +        ret = -EIO;
> +        goto fail_handler;
> +    }
> +    return 0;
> +
> +fail_handler:
> +    aio_set_event_notifier(bdrv_get_aio_context(bs), &s->irq_notifier,
> +                           false, NULL, NULL);
> +fail_queue:
> +    nvme_free_queue_pair(bs, s->queues[0]);
> +fail:

s->queues is not freed.

> +    qemu_vfio_pci_unmap_bar(s->vfio, 0, (void *)s->regs);
> +    qemu_vfio_close(s->vfio);
> +    event_notifier_cleanup(&s->irq_notifier);

dma_map_lock should be destroyed.

> +static int nvme_file_open(BlockDriverState *bs, QDict *options, int flags,
> +                          Error **errp)
> +{
> +    const char *device;
> +    QemuOpts *opts;
> +    int namespace;
> +
> +    opts = qemu_opts_create(&runtime_opts, NULL, 0, &error_abort);
> +    qemu_opts_absorb_qdict(opts, options, &error_abort);
> +    device = qemu_opt_get(opts, NVME_BLOCK_OPT_DEVICE);
> +    if (!device) {
> +        error_setg(errp, "'" NVME_BLOCK_OPT_DEVICE "' option is required");
> +        return -EINVAL;

opts is leaked.

--SNIs70sCzqvszXB4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJaVlxgAAoJEJykq7OBq3PI1iAH/0VNUhEElnP0P9C3CJrJ5iha
8G2U3WG6SS8kUpeVMNv2jhBSQV717/tBWYyq4yjGIQV7crh6aQvM8xJ/0gFBuz/O
TYySW6G6mUSd99EZCJ/iM+G8EdQjw56Qvt7U2rafEZXdRaCBnKL0SWRfY5RAeq+L
diLCaC17xkqzgjvkR2Gjq2e7Xpmb2IJCNGUGGARuYugd6RqaKuwDrsPl+j1FdYn3
J/ECugftiNyej3+BpQNJPRT1HCIzEJYPTt18W9CC8UCcqWxG0ZtZtnGg37CC7c2U
5NHh4fnTVi8/wBUSA0sskKbGCrCA/4x+EoYcPC8jBfrzH+tTmY9YS6mv/Jpyg24=
=XXNQ
-----END PGP SIGNATURE-----

--SNIs70sCzqvszXB4--
