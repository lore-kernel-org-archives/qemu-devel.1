Return-Path: <SRS0=FCxk=BI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75E83C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2020 18:21:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 462722075F
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2020 18:21:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F+afkpSM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 462722075F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44882 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0qhh-00013J-FK
	for qemu-devel@archiver.kernel.org; Wed, 29 Jul 2020 14:21:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33814)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlevitsk@redhat.com>)
 id 1k0qfM-0000Aw-8c
 for qemu-devel@nongnu.org; Wed, 29 Jul 2020 14:19:00 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:45022
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mlevitsk@redhat.com>)
 id 1k0qfK-0003Gf-Ja
 for qemu-devel@nongnu.org; Wed, 29 Jul 2020 14:18:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596046737;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=I+MmWjDDHwnrzRNT+k7a9PNzKiqTRRyULIrdJ/bTOV8=;
 b=F+afkpSMgrdQqyu773p56NJA1yFWOXylBEhnHnpdBUQ4Zjbn7uQ13sOwrPc59PpFTkyX4a
 swXAmh+i4T0r0l08r+53oFkLSLwCQvmPxNINCHHfqYD3fsTiLQQ1esnG3aNV17/d+aUR4o
 /dAHrTwBdgOJhnmPrV3sW3azhT5P+fQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-401-8i80hzftMpepd3f_HHTVzA-1; Wed, 29 Jul 2020 14:18:52 -0400
X-MC-Unique: 8i80hzftMpepd3f_HHTVzA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6B593100A8D8;
 Wed, 29 Jul 2020 18:18:35 +0000 (UTC)
Received: from starship (unknown [10.35.206.108])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 727BE75570;
 Wed, 29 Jul 2020 18:18:25 +0000 (UTC)
Message-ID: <c0b8260ac277f6a3ec5ef21c10abcf9a47e146e1.camel@redhat.com>
Subject: Re: [PATCH 14/16] hw/block/nvme: consolidate qsg/iov clearing
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Klaus Jensen <its@irrelevant.dk>, qemu-devel@nongnu.org
Date: Wed, 29 Jul 2020 21:18:24 +0300
In-Reply-To: <20200720113748.322965-15-its@irrelevant.dk>
References: <20200720113748.322965-1-its@irrelevant.dk>
 <20200720113748.322965-15-its@irrelevant.dk>
User-Agent: Evolution 3.36.3 (3.36.3-1.fc32)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=mlevitsk@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/29 09:27:47
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>, Klaus Jensen <k.jensen@samsung.com>,
 Keith Busch <kbusch@kernel.org>, qemu-block@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 2020-07-20 at 13:37 +0200, Klaus Jensen wrote:
> From: Klaus Jensen <k.jensen@samsung.com>
> 
> Always destroy the request qsg/iov at the end of request use.
> 
> Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
> ---
>  hw/block/nvme.c | 48 +++++++++++++++++-------------------------------
>  1 file changed, 17 insertions(+), 31 deletions(-)
> 
> diff --git a/hw/block/nvme.c b/hw/block/nvme.c
> index 54cd20f1ce22..b53afdeb3fb6 100644
> --- a/hw/block/nvme.c
> +++ b/hw/block/nvme.c
> @@ -213,6 +213,14 @@ static void nvme_req_clear(NvmeRequest *req)
>  {
>      req->ns = NULL;
>      memset(&req->cqe, 0x0, sizeof(req->cqe));
> +
> +    if (req->qsg.sg) {
> +        qemu_sglist_destroy(&req->qsg);
> +    }
> +
> +    if (req->iov.iov) {
> +        qemu_iovec_destroy(&req->iov);
> +    }
>  }
>  
>  static uint16_t nvme_map_addr_cmb(NvmeCtrl *n, QEMUIOVector *iov, hwaddr addr,
> @@ -297,15 +305,14 @@ static uint16_t nvme_map_prp(NvmeCtrl *n, QEMUSGList *qsg, QEMUIOVector *iov,
>  
>      status = nvme_map_addr(n, qsg, iov, prp1, trans_len);
>      if (status) {
> -        goto unmap;
> +        return status;
>      }
>  
>      len -= trans_len;
>      if (len) {
>          if (unlikely(!prp2)) {
>              trace_pci_nvme_err_invalid_prp2_missing();
> -            status = NVME_INVALID_FIELD | NVME_DNR;
> -            goto unmap;
> +            return NVME_INVALID_FIELD | NVME_DNR;
>          }
>  
>          if (len > n->page_size) {
> @@ -326,13 +333,11 @@ static uint16_t nvme_map_prp(NvmeCtrl *n, QEMUSGList *qsg, QEMUIOVector *iov,
>                  if (i == n->max_prp_ents - 1 && len > n->page_size) {
>                      if (unlikely(!prp_ent || prp_ent & (n->page_size - 1))) {
>                          trace_pci_nvme_err_invalid_prplist_ent(prp_ent);
> -                        status = NVME_INVALID_FIELD | NVME_DNR;
> -                        goto unmap;
> +                        return NVME_INVALID_FIELD | NVME_DNR;
>                      }
>  
>                      if (prp_list_in_cmb != nvme_addr_is_cmb(n, prp_ent)) {
> -                        status = NVME_INVALID_USE_OF_CMB | NVME_DNR;
> -                        goto unmap;
> +                        return NVME_INVALID_USE_OF_CMB | NVME_DNR;
>                      }
>  
>                      i = 0;
> @@ -345,14 +350,13 @@ static uint16_t nvme_map_prp(NvmeCtrl *n, QEMUSGList *qsg, QEMUIOVector *iov,
>  
>                  if (unlikely(!prp_ent || prp_ent & (n->page_size - 1))) {
>                      trace_pci_nvme_err_invalid_prplist_ent(prp_ent);
> -                    status = NVME_INVALID_FIELD | NVME_DNR;
> -                    goto unmap;
> +                    return NVME_INVALID_FIELD | NVME_DNR;
>                  }
>  
>                  trans_len = MIN(len, n->page_size);
>                  status = nvme_map_addr(n, qsg, iov, prp_ent, trans_len);
>                  if (status) {
> -                    goto unmap;
> +                    return status;
>                  }
>  
>                  len -= trans_len;
> @@ -361,27 +365,16 @@ static uint16_t nvme_map_prp(NvmeCtrl *n, QEMUSGList *qsg, QEMUIOVector *iov,
>          } else {
>              if (unlikely(prp2 & (n->page_size - 1))) {
>                  trace_pci_nvme_err_invalid_prp2_align(prp2);
> -                status = NVME_INVALID_FIELD | NVME_DNR;
> -                goto unmap;
> +                return NVME_INVALID_FIELD | NVME_DNR;
>              }
>              status = nvme_map_addr(n, qsg, iov, prp2, len);
>              if (status) {
> -                goto unmap;
> +                return status;
>              }
>          }
>      }
> +
>      return NVME_SUCCESS;
> -
> -unmap:
> -    if (iov && iov->iov) {
> -        qemu_iovec_destroy(iov);
> -    }
> -
> -    if (qsg && qsg->sg) {
> -        qemu_sglist_destroy(qsg);
> -    }
> -
> -    return status;
>  }
>  
>  static uint16_t nvme_dma_prp(NvmeCtrl *n, uint8_t *ptr, uint32_t len,
> @@ -601,13 +594,6 @@ static void nvme_rw_cb(void *opaque, int ret)
>          req->status = NVME_INTERNAL_DEV_ERROR;
>      }
>  
> -    if (req->qsg.nalloc) {
> -        qemu_sglist_destroy(&req->qsg);
> -    }
> -    if (req->iov.nalloc) {
> -        qemu_iovec_destroy(&req->iov);
> -    }
> -
>      nvme_enqueue_req_completion(cq, req);
>  }
>  

This and former patch I guess answer my own question about why to clear the request after its cqe got posted.

Looks reasonable.

Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>

Best regards,
	Maxim Levitsky


