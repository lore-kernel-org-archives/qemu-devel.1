Return-Path: <SRS0=MAm8=C6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AD0CC43468
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 15:21:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B94512085B
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 15:21:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="FEKBmaix"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B94512085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41504 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKNdR-0008P8-Ch
	for qemu-devel@archiver.kernel.org; Mon, 21 Sep 2020 11:21:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36390)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kbusch@kernel.org>)
 id 1kKNcD-0007HE-Fr; Mon, 21 Sep 2020 11:20:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:57254)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kbusch@kernel.org>)
 id 1kKNcB-0003n0-CH; Mon, 21 Sep 2020 11:20:28 -0400
Received: from dhcp-10-100-145-180.wdl.wdc.com (unknown [199.255.45.60])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id B2B8320756;
 Mon, 21 Sep 2020 15:20:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1600701623;
 bh=P0AfXvfZ0ej0+8hTkMUy/w6zrbZUFEdIjgq0q6enzBw=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=FEKBmaixCXO8J+tKQyfM31BfIiKHFhqGNSKd8Ktd28WtMX2q8USDjCA3/72rCBa4l
 +sU1XDlBru6fOJ5tEQGQMSRKZp7R4vjoxXOisiEzQlfvIBT7p3NG8B5oP8dEYLbB26
 dddaJ9cS9Bm/5UgMzwZYxAoTQfoxAo120IqaiWMw=
Date: Mon, 21 Sep 2020 08:20:15 -0700
From: Keith Busch <kbusch@kernel.org>
To: Klaus Jensen <its@irrelevant.dk>
Subject: Re: [PATCH v2 09/17] hw/block/nvme: refactor aio submission
Message-ID: <20200921152015.GB4034182@dhcp-10-100-145-180.wdl.wdc.com>
References: <20200918203621.602915-1-its@irrelevant.dk>
 <20200918203621.602915-10-its@irrelevant.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200918203621.602915-10-its@irrelevant.dk>
Received-SPF: pass client-ip=198.145.29.99; envelope-from=kbusch@kernel.org;
 helo=mail.kernel.org
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/21 11:20:23
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -85
X-Spam_score: -8.6
X-Spam_bar: --------
X-Spam_report: (-8.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.455,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_HI=-5, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Kevin Wolf <kwolf@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 qemu-block@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Klaus Jensen <k.jensen@samsung.com>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Sep 18, 2020 at 10:36:13PM +0200, Klaus Jensen wrote:
> +static inline bool nvme_req_is_write(NvmeRequest *req)
> +{
> +    switch (req->cmd.opcode) {
> +    case NVME_CMD_WRITE:
> +    case NVME_CMD_WRITE_ZEROES:
> +        return true;
> +    default:
> +        return false;
> +    }
> +}

It doesn't look like this is called for WRITE_ZEROES anywhere. It also
looks like this helper is a bit unnecessary. We can reorganize some of
the flow so that we're not checking the opcode twice:

> +static uint16_t nvme_do_aio(BlockBackend *blk, int64_t offset, size_t len,
> +                            NvmeRequest *req)
> +{
> +    BlockAcctCookie *acct = &req->acct;
> +    BlockAcctStats *stats = blk_get_stats(blk);
> +
> +    bool is_write;

    bool is_write = false;

> +    trace_pci_nvme_do_aio(nvme_cid(req), req->cmd.opcode,
> +                          nvme_io_opc_str(req->cmd.opcode), blk_name(blk),
> +                          offset, len);
> +
> +    switch (req->cmd.opcode) {
> +    case NVME_CMD_FLUSH:
> +        block_acct_start(stats, acct, 0, BLOCK_ACCT_FLUSH);
> +        req->aiocb = blk_aio_flush(blk, nvme_rw_cb, req);
> +        break;
> +
> +    case NVME_CMD_WRITE_ZEROES:
> +        block_acct_start(stats, acct, len, BLOCK_ACCT_WRITE);
> +        req->aiocb = blk_aio_pwrite_zeroes(blk, offset, len,
> +                                           BDRV_REQ_MAY_UNMAP, nvme_rw_cb,
> +                                           req);
> +        break;
> +
> +    case NVME_CMD_READ:
> +    case NVME_CMD_WRITE:
> +        is_write = nvme_req_is_write(req);

   case NVME_CMD_WRITE:
       is_write = true; /* fallthrough */
   case NVME_CMD_READ:
       ....

> +
> +        block_acct_start(stats, acct, len,
> +                         is_write ? BLOCK_ACCT_WRITE : BLOCK_ACCT_READ);
> +
> +        if (req->qsg.sg) {
> +            if (is_write) {
> +                req->aiocb = dma_blk_write(blk, &req->qsg, offset,
> +                                           BDRV_SECTOR_SIZE, nvme_rw_cb, req);
> +            } else {
> +                req->aiocb = dma_blk_read(blk, &req->qsg, offset,
> +                                          BDRV_SECTOR_SIZE, nvme_rw_cb, req);
> +            }
> +        } else {
> +            if (is_write) {
> +                req->aiocb = blk_aio_pwritev(blk, offset, &req->iov, 0,
> +                                             nvme_rw_cb, req);
> +            } else {
> +                req->aiocb = blk_aio_preadv(blk, offset, &req->iov, 0,
> +                                            nvme_rw_cb, req);
> +            }
> +        }
> +
> +        break;
> +    }
> +
> +    return NVME_NO_COMPLETE;
>  }

