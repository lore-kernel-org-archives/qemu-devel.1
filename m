Received: from eggs.gnu.org ([2001:4830:134:3::10]:43796)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dUa68-0004gc-HH
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 10:55:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dUa67-0003MB-CQ
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 10:55:40 -0400
Date: Mon, 10 Jul 2017 15:55:26 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170710145526.GG14195@stefanha-x1.localdomain>
References: <20170705133635.11850-1-famz@redhat.com>
	<20170705133635.11850-3-famz@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="IuhbYIxU28t+Kd57"
Content-Disposition: inline
In-Reply-To: <20170705133635.11850-3-famz@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 2/6] block: Add VFIO based NVMe driver
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Keith Busch <keith.busch@intel.com>, qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Karl Rister <krister@redhat.com>


--IuhbYIxU28t+Kd57
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jul 05, 2017 at 09:36:31PM +0800, Fam Zheng wrote:
> +static bool nvme_identify(BlockDriverState *bs, int namespace, Error **errp)
> +{
> +    BDRVNVMeState *s = bs->opaque;
> +    uint8_t *resp;
> +    int r;
> +    uint64_t iova;
> +    NvmeCmd cmd = {
> +        .opcode = NVME_ADM_CMD_IDENTIFY,
> +        .cdw10 = cpu_to_le32(0x1),
> +    };
> +
> +    resp = qemu_try_blockalign0(bs, 4096);

Is it possible to use struct NvmeIdCtrl to make this code clearer and
eliminate the hardcoded sizes/offsets?

> +    if (!resp) {
> +        error_setg(errp, "Cannot allocate buffer for identify response");
> +        return false;
> +    }
> +    r = nvme_vfio_dma_map(s->vfio, resp, 4096, true, &iova);
> +    if (r) {
> +        error_setg(errp, "Cannot map buffer for DMA");
> +        goto fail;
> +    }
> +    cmd.prp1 = cpu_to_le64(iova);
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
> +    s->write_cache = le32_to_cpu(resp[525]) & 0x1;
> +    s->max_transfer = (resp[77] ? 1 << resp[77] : 0) * s->page_size;
> +    /* For now the page list buffer per command is one page, to hold at most
> +     * s->page_size / sizeof(uint64_t) entries. */
> +    s->max_transfer = MIN_NON_ZERO(s->max_transfer,
> +                          s->page_size / sizeof(uint64_t) * s->page_size);
> +
> +    memset((char *)resp, 0, 4096);
> +
> +    cmd.cdw10 = 0;
> +    cmd.nsid = namespace;
> +    if (nvme_cmd_sync(bs, s->queues[0], &cmd)) {
> +        error_setg(errp, "Failed to identify namespace");
> +        goto fail;
> +    }
> +
> +    s->nsze = le64_to_cpu(*(uint64_t *)&resp[0]);
> +
> +    nvme_vfio_dma_unmap(s->vfio, resp);
> +    qemu_vfree(resp);
> +    return true;
> +fail:
> +    qemu_vfree(resp);
> +    return false;

nvme_vfio_dma_unmap() is not called in the error path.

> +static coroutine_fn int nvme_cmd_map_qiov(BlockDriverState *bs, NvmeCmd *cmd,
> +                                          NVMeRequest *req, QEMUIOVector *qiov)
> +{
> +    BDRVNVMeState *s = bs->opaque;
> +    uint64_t *pagelist = req->prp_list_page;
> +    int i, j, r;
> +    int entries = 0;
> +
> +    assert(qiov->size);
> +    assert(QEMU_IS_ALIGNED(qiov->size, s->page_size));
> +    assert(qiov->size / s->page_size <= s->page_size / sizeof(uint64_t));
> +    for (i = 0; i < qiov->niov; ++i) {
> +        bool retry = true;
> +        uint64_t iova;
> +        qemu_co_mutex_lock(&s->dma_map_lock);
> +try_map:
> +        r = nvme_vfio_dma_map(s->vfio,
> +                              qiov->iov[i].iov_base,
> +                              qiov->iov[i].iov_len,
> +                              true, &iova);
> +        if (r == -ENOMEM && retry) {
> +            retry = false;
> +            trace_nvme_dma_flush_queue_wait(s);
> +            if (s->inflight) {
> +                trace_nvme_dma_map_flush(s);
> +                qemu_co_queue_wait(&s->dma_flush_queue, &s->dma_map_lock);
> +            } else {
> +                r = nvme_vfio_dma_reset_temporary(s->vfio);
> +                if (r) {
> +                    return r;

dma_map_lock is held here!

> +static int nvme_co_prw(BlockDriverState *bs, uint64_t offset, uint64_t bytes,
> +                       QEMUIOVector *qiov, bool is_write, int flags)
> +{
> +    BDRVNVMeState *s = bs->opaque;
> +    int r;
> +    uint8_t *buf = NULL;
> +    QEMUIOVector local_qiov;
> +
> +    assert(QEMU_IS_ALIGNED(offset, s->page_size));
> +    assert(QEMU_IS_ALIGNED(bytes, s->page_size));
> +    assert(bytes <= s->max_transfer);

Who guarantees max_transfer?  I think request alignment is enforced by
block/io.c but there is no generic max_transfer handling code, so this
assertion can be triggered by the guest.  Please handle it as a genuine
request error instead of using an assertion.

> +static int nvme_reopen_prepare(BDRVReopenState *reopen_state,
> +                               BlockReopenQueue *queue, Error **errp)
> +{
> +    return 0;
> +}

What is the purpose of this dummy .bdrv_reopen_prepare() implementation?

--IuhbYIxU28t+Kd57
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZY5VeAAoJEJykq7OBq3PI7jQH/1NVfnL6mS2ZHOIWmUTa1qEx
tYMR04xpQ5p+9K3DVJfMedgHnleEyd2GS8o/0IBj1mWWdc9NHfW+pt64zq8v57Lq
WMyPNc4LytzVYmVfgYmmsVgKnZDscC0hN+oX6VHin5UivRdoCsCrz+1xrl7M/MDw
cbmPiXNrDQ1OBg7Ryo7Ltckm2DF4TZW2R6UJo2wf1UWU6vjEwUWAImB8iaSayopn
2jpFjpp8AZlBExreW7NhLx5wOgo3jojJzbtBRE1X03ZzGJTI17tDRkT4pFdCkFeS
OCQRxE/65HdgFjekyMb8U2KG8yR7wAwTzI6XUYGmWtiiNCw19WGCUb3V3RvQKS0=
=cD9V
-----END PGP SIGNATURE-----

--IuhbYIxU28t+Kd57--
