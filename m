Return-Path: <SRS0=MAm8=C6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4E09C43468
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 16:52:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A5DB206DC
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 16:52:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yw0SC7Dt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A5DB206DC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45992 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKP2w-0005UP-6Y
	for qemu-devel@archiver.kernel.org; Mon, 21 Sep 2020 12:52:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34122)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kbusch@kernel.org>)
 id 1kKP1C-0004NW-SH; Mon, 21 Sep 2020 12:50:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:42026)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kbusch@kernel.org>)
 id 1kKP1B-0002HG-1W; Mon, 21 Sep 2020 12:50:22 -0400
Received: from dhcp-10-100-145-180.wdl.wdc.com (unknown [199.255.45.60])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 532A9238A1;
 Mon, 21 Sep 2020 16:50:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1600707019;
 bh=8DomK8kCSfP0dnTDmFDqVqZd/fEUAA3w4+vTGo2xl9E=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Yw0SC7Dtinq1AdhpKtj+Mz3eSpR6NZM6PsiCE7l715oebzYNX484v2Y07FSI5tsmX
 DolAnn7COs9fDBBGO5WT1lJLuSj1pnepo5zEWLhfYY2LUplCRirTq2QR3ee9RhS0wh
 2drGzmbHhRSmGWyJznhpKkR0HYW6sQCwKoz0Q0to=
Date: Mon, 21 Sep 2020 09:50:06 -0700
From: Keith Busch <kbusch@kernel.org>
To: Klaus Jensen <its@irrelevant.dk>
Subject: Re: [PATCH v2 03/17] hw/block/nvme: handle dma errors
Message-ID: <20200921165006.GB4034241@dhcp-10-100-145-180.wdl.wdc.com>
References: <20200918203621.602915-1-its@irrelevant.dk>
 <20200918203621.602915-4-its@irrelevant.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200918203621.602915-4-its@irrelevant.dk>
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
 Max Reitz <mreitz@redhat.com>, Maxim Levitsky <mlevitsk@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Sep 18, 2020 at 10:36:07PM +0200, Klaus Jensen wrote:
> @@ -466,15 +476,21 @@ static void nvme_post_cqes(void *opaque)
>              break;
>          }
>  
> -        QTAILQ_REMOVE(&cq->req_list, req, entry);
>          sq = req->sq;
>          req->cqe.status = cpu_to_le16((req->status << 1) | cq->phase);
>          req->cqe.sq_id = cpu_to_le16(sq->sqid);
>          req->cqe.sq_head = cpu_to_le16(sq->head);
>          addr = cq->dma_addr + cq->tail * n->cqe_size;
> +        ret = pci_dma_write(&n->parent_obj, addr, (void *)&req->cqe,
> +                            sizeof(req->cqe));
> +        if (ret) {
> +            trace_pci_nvme_err_addr_write(addr);
> +            timer_mod(cq->timer, qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) +
> +                      500 * SCALE_MS);
> +            break;
> +        }
> +        QTAILQ_REMOVE(&cq->req_list, req, entry);

Is this error really ever transient such that a retry later may be
successful? I didn't find a way that appeared that it could be. If not,
this probably deserves a CFS condition rather than a retry.

