Return-Path: <SRS0=9X/F=UF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4B31C28CC5
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2019 02:58:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 92A27206B8
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2019 02:58:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=euphon.net header.i=fam@euphon.net header.b="dhGBVjd7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92A27206B8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=euphon.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:53366 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYibs-00056v-GL
	for qemu-devel@archiver.kernel.org; Wed, 05 Jun 2019 22:58:36 -0400
Received: from eggs.gnu.org ([209.51.188.92]:53665)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <fam@euphon.net>) id 1hYiaU-0004EE-DM
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 22:57:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <fam@euphon.net>) id 1hYiaT-0004a6-3u
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 22:57:10 -0400
Received: from sender2-op-o12.zoho.com.cn ([163.53.93.243]:17975
	helo=sender1.zoho.com.cn)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <fam@euphon.net>)
	id 1hYiaP-0003eb-0f; Wed, 05 Jun 2019 22:57:06 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1559789771; cv=none; d=zoho.com.cn; s=zohoarc; 
	b=OhHDFTUS2NjLx/IHK6X37vMuXyGU89Rc2jyYCjxPgMI7SkvEmTyR9c2rHGo8aD44Be6dNGq37u8vYBOKloMPKq0zIXu2oEKIhVzT//rSRHjTjOu/OchIQvsPPIC3fgWY6M8Qww9/nxTOXGfC65C2yacJXYLrKboMLd6kY6p40kk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com.cn;
	s=zohoarc; t=1559789771;
	h=Content-Type:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To:ARC-Authentication-Results;
	bh=N5Gt9lf7NSOHopBiVNrZmcklk2GqMXT6FFjwO8w0eko=; 
	b=P5pc6+VWq3m0i322fAz4tDHhdoLtXbv1wU34PG2i21rgysc/d5Xg+9Pgqf1yW5m7WTqxi1kfgvjT86ra7l5nUZu4WNHk7LtuOe9GRnZHJ9jbHYT4EMR/+alvVFxZAEsEhWocIQwA/Cihdhg41AKdtK++kEj/BwA1y55KRts7oDk=
ARC-Authentication-Results: i=1; mx.zoho.com.cn;
	dkim=pass  header.i=euphon.net;
	spf=pass  smtp.mailfrom=fam@euphon.net;
	dmarc=pass header.from=<fam@euphon.net> header.from=<fam@euphon.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1559789771; 
	s=zoho; d=euphon.net; i=fam@euphon.net;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To;
	l=6141; bh=N5Gt9lf7NSOHopBiVNrZmcklk2GqMXT6FFjwO8w0eko=;
	b=dhGBVjd7fRaA+XK8vlTG7Hz80lOl0qMGomtZ93SBjUM1wf+yjm4l46LpRnDI/HL9
	8Y4nWE/gOIhGO0YohGLx4hNROrYzzZ3QSs+uMf2OecKZNfXUOtluEll+NlRi5aVLm5m
	ci5rT5bPtFnK0moyvFkByaqKPopW+WX7yD4iYZ3Q=
Received: from localhost (120.52.147.48 [120.52.147.48]) by mx.zoho.com.cn
	with SMTPS id 155978976929953.92405126407823;
	Thu, 6 Jun 2019 10:56:09 +0800 (CST)
Date: Thu, 6 Jun 2019 10:56:07 +0800
From: Fam Zheng <fam@euphon.net>
To: Maxim Levitsky <mlevitsk@redhat.com>
Message-ID: <20190606025607.vly5f6j2pv7ymrdw@debian>
References: <20190417195355.16123-1-mlevitsk@redhat.com>
	<20190417195355.16123-5-mlevitsk@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190417195355.16123-5-mlevitsk@redhat.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-ZohoCNMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 163.53.93.243
Subject: Re: [Qemu-devel] [PATCH v2 4/5] block/nvme: add support for write
 zeros
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org,
	Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 04/17 22:53, Maxim Levitsky wrote:
> Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
> ---
>  block/nvme.c         | 69 +++++++++++++++++++++++++++++++++++++++++++-
>  block/trace-events   |  1 +
>  include/block/nvme.h | 19 +++++++++++-
>  3 files changed, 87 insertions(+), 2 deletions(-)
> 
> diff --git a/block/nvme.c b/block/nvme.c
> index 0b1da54574..35b925899f 100644
> --- a/block/nvme.c
> +++ b/block/nvme.c
> @@ -109,6 +109,8 @@ typedef struct {
>      uint64_t max_transfer;
>      bool plugged;
>  
> +    bool supports_write_zeros;
> +
>      CoMutex dma_map_lock;
>      CoQueue dma_flush_queue;
>  
> @@ -457,6 +459,10 @@ static void nvme_identify(BlockDriverState *bs, int namespace, Error **errp)
>      s->max_transfer = MIN_NON_ZERO(s->max_transfer,
>                            s->page_size / sizeof(uint64_t) * s->page_size);
>  
> +
> +

Too many blank lines here.

> +    s->supports_write_zeros = (idctrl->oncs & NVME_ONCS_WRITE_ZEROS) != 0;
> +
>      memset(resp, 0, 4096);
>  
>      cmd.cdw10 = 0;
> @@ -469,6 +475,11 @@ static void nvme_identify(BlockDriverState *bs, int namespace, Error **errp)
>      s->nsze = le64_to_cpu(idns->nsze);
>      lbaf = &idns->lbaf[NVME_ID_NS_FLBAS_INDEX(idns->flbas)];
>  
> +    if (NVME_ID_NS_DLFEAT_WRITE_ZEROS(idns->dlfeat) &&
> +            NVME_ID_NS_DLFEAT_READ_BEHAVIOR(idns->dlfeat) ==
> +                    NVME_ID_NS_DLFEAT_READ_BEHAVIOR_ZEROS)
> +        bs->supported_write_flags |= BDRV_REQ_MAY_UNMAP;
> +
>      if (lbaf->ms) {
>          error_setg(errp, "Namespaces with metadata are not yet supported");
>          goto out;
> @@ -763,6 +774,8 @@ static int nvme_file_open(BlockDriverState *bs, QDict *options, int flags,
>      int ret;
>      BDRVNVMeState *s = bs->opaque;
>  
> +    bs->supported_write_flags = BDRV_REQ_FUA;
> +
>      opts = qemu_opts_create(&runtime_opts, NULL, 0, &error_abort);
>      qemu_opts_absorb_qdict(opts, options, &error_abort);
>      device = qemu_opt_get(opts, NVME_BLOCK_OPT_DEVICE);
> @@ -791,7 +804,6 @@ static int nvme_file_open(BlockDriverState *bs, QDict *options, int flags,
>              goto fail;
>          }
>      }
> -    bs->supported_write_flags = BDRV_REQ_FUA;
>      return 0;
>  fail:
>      nvme_close(bs);
> @@ -1080,6 +1092,58 @@ static coroutine_fn int nvme_co_flush(BlockDriverState *bs)
>  }
>  
>  
> +static coroutine_fn int nvme_co_pwrite_zeroes(BlockDriverState *bs,
> +    int64_t offset, int bytes, BdrvRequestFlags flags)
> +{
> +    BDRVNVMeState *s = bs->opaque;
> +    NVMeQueuePair *ioq = s->queues[1];
> +    NVMeRequest *req;
> +
> +    if (!s->supports_write_zeros) {
> +        return -ENOTSUP;
> +    }

Local variables declaration below statements is not allowed as per coding style.

> +
> +    uint32_t cdw12 = ((bytes >> s->blkshift) - 1) & 0xFFFF;
> +
> +    NvmeCmd cmd = {
> +        .opcode = NVME_CMD_WRITE_ZEROS,
> +        .nsid = cpu_to_le32(s->nsid),
> +        .cdw10 = cpu_to_le32((offset >> s->blkshift) & 0xFFFFFFFF),
> +        .cdw11 = cpu_to_le32(((offset >> s->blkshift) >> 32) & 0xFFFFFFFF),
> +    };
> +
> +    NVMeCoData data = {
> +        .ctx = bdrv_get_aio_context(bs),
> +        .ret = -EINPROGRESS,
> +    };
> +
> +    if (flags & BDRV_REQ_MAY_UNMAP) {
> +        cdw12 |= (1 << 25);
> +    }
> +
> +    if (flags & BDRV_REQ_FUA) {
> +        cdw12 |= (1 << 30);
> +    }
> +
> +    cmd.cdw12 = cpu_to_le32(cdw12);
> +
> +    trace_nvme_write_zeros(s, offset, bytes, flags);
> +    assert(s->nr_queues > 1);
> +    req = nvme_get_free_req(ioq);
> +    assert(req);
> +
> +    nvme_submit_command(s, ioq, req, &cmd, nvme_rw_cb, &data);
> +
> +    data.co = qemu_coroutine_self();
> +    while (data.ret == -EINPROGRESS) {
> +        qemu_coroutine_yield();
> +    }
> +
> +    trace_nvme_rw_done(s, true, offset, bytes, data.ret);
> +    return data.ret;
> +}
> +
> +
>  static int nvme_reopen_prepare(BDRVReopenState *reopen_state,
>                                 BlockReopenQueue *queue, Error **errp)
>  {
> @@ -1184,6 +1248,9 @@ static BlockDriver bdrv_nvme = {
>  
>      .bdrv_co_preadv           = nvme_co_preadv,
>      .bdrv_co_pwritev          = nvme_co_pwritev,
> +
> +    .bdrv_co_pwrite_zeroes    = nvme_co_pwrite_zeroes,
> +
>      .bdrv_co_flush_to_disk    = nvme_co_flush,
>      .bdrv_reopen_prepare      = nvme_reopen_prepare,
>  
> diff --git a/block/trace-events b/block/trace-events
> index 7335a42540..943a58569f 100644
> --- a/block/trace-events
> +++ b/block/trace-events
> @@ -144,6 +144,7 @@ nvme_submit_command_raw(int c0, int c1, int c2, int c3, int c4, int c5, int c6,
>  nvme_handle_event(void *s) "s %p"
>  nvme_poll_cb(void *s) "s %p"
>  nvme_prw_aligned(void *s, int is_write, uint64_t offset, uint64_t bytes, int flags, int niov) "s %p is_write %d offset %"PRId64" bytes %"PRId64" flags %d niov %d"
> +nvme_write_zeros(void *s, uint64_t offset, uint64_t bytes, int flags) "s %p offset %"PRId64" bytes %"PRId64" flags %d"
>  nvme_qiov_unaligned(const void *qiov, int n, void *base, size_t size, int align) "qiov %p n %d base %p size 0x%zx align 0x%x"
>  nvme_prw_buffered(void *s, uint64_t offset, uint64_t bytes, int niov, int is_write) "s %p offset %"PRId64" bytes %"PRId64" niov %d is_write %d"
>  nvme_rw_done(void *s, int is_write, uint64_t offset, uint64_t bytes, int ret) "s %p is_write %d offset %"PRId64" bytes %"PRId64" ret %d"
> diff --git a/include/block/nvme.h b/include/block/nvme.h
> index 0eae6f9f15..edf8e90557 100644
> --- a/include/block/nvme.h
> +++ b/include/block/nvme.h
> @@ -653,12 +653,29 @@ typedef struct NvmeIdNs {
>      uint8_t     mc;
>      uint8_t     dpc;
>      uint8_t     dps;
> -    uint8_t     res30[98];
> +
> +    uint8_t     nmic;
> +    uint8_t     rescap;
> +    uint8_t     fpi;
> +    uint8_t     dlfeat;
> +
> +    uint8_t     res30[94];
>      NvmeLBAF    lbaf[16];
>      uint8_t     res192[192];
>      uint8_t     vs[3712];
>  } NvmeIdNs;
>  
> +
> +/*Deallocate Logical Block Features*/
> +#define NVME_ID_NS_DLFEAT_GUARD_CRC(dlfeat)       ((dlfeat) & 0x10)
> +#define NVME_ID_NS_DLFEAT_WRITE_ZEROS(dlfeat)     ((dlfeat) & 0x04)
> +
> +#define NVME_ID_NS_DLFEAT_READ_BEHAVIOR(dlfeat)     ((dlfeat) & 0x3)
> +#define NVME_ID_NS_DLFEAT_READ_BEHAVIOR_UNDEFINED   0
> +#define NVME_ID_NS_DLFEAT_READ_BEHAVIOR_ZEROS       1
> +#define NVME_ID_NS_DLFEAT_READ_BEHAVIOR_ONES        2
> +
> +
>  #define NVME_ID_NS_NSFEAT_THIN(nsfeat)      ((nsfeat & 0x1))
>  #define NVME_ID_NS_FLBAS_EXTENDED(flbas)    ((flbas >> 4) & 0x1)
>  #define NVME_ID_NS_FLBAS_INDEX(flbas)       ((flbas & 0xf))
> -- 
> 2.17.2
> 


