Return-Path: <SRS0=FCxk=BI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CB16C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2020 17:36:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD2B22075F
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2020 17:36:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h1aw0CEW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD2B22075F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45436 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0q0M-0003CC-1k
	for qemu-devel@archiver.kernel.org; Wed, 29 Jul 2020 13:36:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51158)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlevitsk@redhat.com>)
 id 1k0pzl-0002iA-2I
 for qemu-devel@nongnu.org; Wed, 29 Jul 2020 13:36:01 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:56075
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mlevitsk@redhat.com>)
 id 1k0pzi-0005jm-92
 for qemu-devel@nongnu.org; Wed, 29 Jul 2020 13:36:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596044156;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ut0UoLKpYe7UINb6kE8487seeGMh9Boh9ZLjfYLLaWI=;
 b=h1aw0CEWUgQUToynQgBFW1HHULymVxoj+ROKb6mOnra764fgMt5fHxiZoHZ9Kvq7EfemuR
 8pqIfhNqzmW47m5zhAN8glkt2TVrFIqjtZYqulpDN1nz+Mho9abOM3NgJRX3ra90Y79czm
 SvEPRkruMljbxzL0hxT/j7hOThroy64=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-233-GSq_pT_WN-6EeAsKIU7q2A-1; Wed, 29 Jul 2020 13:35:54 -0400
X-MC-Unique: GSq_pT_WN-6EeAsKIU7q2A-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B1833800465;
 Wed, 29 Jul 2020 17:35:52 +0000 (UTC)
Received: from starship (unknown [10.35.206.108])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0E93C756AD;
 Wed, 29 Jul 2020 17:35:47 +0000 (UTC)
Message-ID: <ae04c5a7230a8debb5ae251b816cc1a0f44bd80e.camel@redhat.com>
Subject: Re: [PATCH 05/16] hw/block/nvme: refactor dma read/write
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Klaus Jensen <its@irrelevant.dk>, qemu-devel@nongnu.org
Date: Wed, 29 Jul 2020 20:35:46 +0300
In-Reply-To: <20200720113748.322965-6-its@irrelevant.dk>
References: <20200720113748.322965-1-its@irrelevant.dk>
 <20200720113748.322965-6-its@irrelevant.dk>
User-Agent: Evolution 3.36.3 (3.36.3-1.fc32)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
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
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
> Refactor the nvme_dma_{read,write}_prp functions into a common function
> taking a DMADirection parameter.
> 
> Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
> Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>
> ---
>  hw/block/nvme.c | 88 ++++++++++++++++++++++++-------------------------
>  1 file changed, 43 insertions(+), 45 deletions(-)
> 
> diff --git a/hw/block/nvme.c b/hw/block/nvme.c
> index 6a1a1626b87b..d314a604db81 100644
> --- a/hw/block/nvme.c
> +++ b/hw/block/nvme.c
> @@ -361,55 +361,50 @@ unmap:
>      return status;
>  }
>  
> -static uint16_t nvme_dma_write_prp(NvmeCtrl *n, uint8_t *ptr, uint32_t len,
> -                                   uint64_t prp1, uint64_t prp2)
> +static uint16_t nvme_dma_prp(NvmeCtrl *n, uint8_t *ptr, uint32_t len,
> +                             uint64_t prp1, uint64_t prp2, DMADirection dir)
>  {
>      QEMUSGList qsg;
>      QEMUIOVector iov;
>      uint16_t status = NVME_SUCCESS;
>  
> -    if (nvme_map_prp(&qsg, &iov, prp1, prp2, len, n)) {
> -        return NVME_INVALID_FIELD | NVME_DNR;
> +    status = nvme_map_prp(&qsg, &iov, prp1, prp2, len, n);
> +    if (status) {
> +        return status;
>      }
> +
>      if (qsg.nsg > 0) {
> -        if (dma_buf_write(ptr, len, &qsg)) {
> -            status = NVME_INVALID_FIELD | NVME_DNR;
> +        uint64_t residual;
> +
> +        if (dir == DMA_DIRECTION_TO_DEVICE) {
> +            residual = dma_buf_write(ptr, len, &qsg);
> +        } else {
> +            residual = dma_buf_read(ptr, len, &qsg);
>          }
> -        qemu_sglist_destroy(&qsg);
> -    } else {
> -        if (qemu_iovec_to_buf(&iov, 0, ptr, len) != len) {
> -            status = NVME_INVALID_FIELD | NVME_DNR;
> -        }
> -        qemu_iovec_destroy(&iov);
> -    }
> -    return status;
> -}
>  
> -static uint16_t nvme_dma_read_prp(NvmeCtrl *n, uint8_t *ptr, uint32_t len,
> -    uint64_t prp1, uint64_t prp2)
> -{
> -    QEMUSGList qsg;
> -    QEMUIOVector iov;
> -    uint16_t status = NVME_SUCCESS;
> -
> -    trace_pci_nvme_dma_read(prp1, prp2);
> -
> -    if (nvme_map_prp(&qsg, &iov, prp1, prp2, len, n)) {
> -        return NVME_INVALID_FIELD | NVME_DNR;
> -    }
> -    if (qsg.nsg > 0) {
> -        if (unlikely(dma_buf_read(ptr, len, &qsg))) {
> +        if (unlikely(residual)) {
>              trace_pci_nvme_err_invalid_dma();
>              status = NVME_INVALID_FIELD | NVME_DNR;
>          }
> +
>          qemu_sglist_destroy(&qsg);
>      } else {
> -        if (unlikely(qemu_iovec_from_buf(&iov, 0, ptr, len) != len)) {
> +        size_t bytes;
> +
> +        if (dir == DMA_DIRECTION_TO_DEVICE) {
> +            bytes = qemu_iovec_to_buf(&iov, 0, ptr, len);
> +        } else {
> +            bytes = qemu_iovec_from_buf(&iov, 0, ptr, len);
> +        }
> +
> +        if (unlikely(bytes != len)) {
>              trace_pci_nvme_err_invalid_dma();
>              status = NVME_INVALID_FIELD | NVME_DNR;
>          }
> +
>          qemu_iovec_destroy(&iov);
>      }
> +
I know I reviewed this, but thinking now, why not to add an assert here
that we don't have both iov and qsg with data.

Best regards,
	Maxim Levitsky

>      return status;
>  }
>  
> @@ -840,8 +835,8 @@ static uint16_t nvme_smart_info(NvmeCtrl *n, NvmeCmd *cmd, uint8_t rae,
>          nvme_clear_events(n, NVME_AER_TYPE_SMART);
>      }
>  
> -    return nvme_dma_read_prp(n, (uint8_t *) &smart + off, trans_len, prp1,
> -                             prp2);
> +    return nvme_dma_prp(n, (uint8_t *) &smart + off, trans_len, prp1, prp2,
> +                        DMA_DIRECTION_FROM_DEVICE);
>  }
>  
>  static uint16_t nvme_fw_log_info(NvmeCtrl *n, NvmeCmd *cmd, uint32_t buf_len,
> @@ -862,8 +857,8 @@ static uint16_t nvme_fw_log_info(NvmeCtrl *n, NvmeCmd *cmd, uint32_t buf_len,
>  
>      trans_len = MIN(sizeof(fw_log) - off, buf_len);
>  
> -    return nvme_dma_read_prp(n, (uint8_t *) &fw_log + off, trans_len, prp1,
> -                             prp2);
> +    return nvme_dma_prp(n, (uint8_t *) &fw_log + off, trans_len, prp1, prp2,
> +                        DMA_DIRECTION_FROM_DEVICE);
>  }
>  
>  static uint16_t nvme_error_info(NvmeCtrl *n, NvmeCmd *cmd, uint8_t rae,
> @@ -887,7 +882,8 @@ static uint16_t nvme_error_info(NvmeCtrl *n, NvmeCmd *cmd, uint8_t rae,
>  
>      trans_len = MIN(sizeof(errlog) - off, buf_len);
>  
> -    return nvme_dma_read_prp(n, (uint8_t *)&errlog, trans_len, prp1, prp2);
> +    return nvme_dma_prp(n, (uint8_t *)&errlog, trans_len, prp1, prp2,
> +                        DMA_DIRECTION_FROM_DEVICE);
>  }
>  
>  static uint16_t nvme_get_log(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req)
> @@ -1042,8 +1038,8 @@ static uint16_t nvme_identify_ctrl(NvmeCtrl *n, NvmeIdentify *c)
>  
>      trace_pci_nvme_identify_ctrl();
>  
> -    return nvme_dma_read_prp(n, (uint8_t *)&n->id_ctrl, sizeof(n->id_ctrl),
> -        prp1, prp2);
> +    return nvme_dma_prp(n, (uint8_t *)&n->id_ctrl, sizeof(n->id_ctrl), prp1,
> +                        prp2, DMA_DIRECTION_FROM_DEVICE);
>  }
>  
>  static uint16_t nvme_identify_ns(NvmeCtrl *n, NvmeIdentify *c)
> @@ -1062,8 +1058,8 @@ static uint16_t nvme_identify_ns(NvmeCtrl *n, NvmeIdentify *c)
>  
>      ns = &n->namespaces[nsid - 1];
>  
> -    return nvme_dma_read_prp(n, (uint8_t *)&ns->id_ns, sizeof(ns->id_ns),
> -        prp1, prp2);
> +    return nvme_dma_prp(n, (uint8_t *)&ns->id_ns, sizeof(ns->id_ns), prp1,
> +                        prp2, DMA_DIRECTION_FROM_DEVICE);
>  }
>  
>  static uint16_t nvme_identify_nslist(NvmeCtrl *n, NvmeIdentify *c)
> @@ -1098,7 +1094,8 @@ static uint16_t nvme_identify_nslist(NvmeCtrl *n, NvmeIdentify *c)
>              break;
>          }
>      }
> -    ret = nvme_dma_read_prp(n, (uint8_t *)list, data_len, prp1, prp2);
> +    ret = nvme_dma_prp(n, (uint8_t *)list, data_len, prp1, prp2,
> +                       DMA_DIRECTION_FROM_DEVICE);
>      g_free(list);
>      return ret;
>  }
> @@ -1139,7 +1136,8 @@ static uint16_t nvme_identify_ns_descr_list(NvmeCtrl *n, NvmeIdentify *c)
>      ns_descrs->uuid.hdr.nidl = NVME_NIDT_UUID_LEN;
>      stl_be_p(&ns_descrs->uuid.v, nsid);
>  
> -    return nvme_dma_read_prp(n, list, NVME_IDENTIFY_DATA_SIZE, prp1, prp2);
> +    return nvme_dma_prp(n, list, NVME_IDENTIFY_DATA_SIZE, prp1, prp2,
> +                        DMA_DIRECTION_FROM_DEVICE);
>  }
>  
>  static uint16_t nvme_identify(NvmeCtrl *n, NvmeCmd *cmd)
> @@ -1220,8 +1218,8 @@ static uint16_t nvme_get_feature_timestamp(NvmeCtrl *n, NvmeCmd *cmd)
>  
>      uint64_t timestamp = nvme_get_timestamp(n);
>  
> -    return nvme_dma_read_prp(n, (uint8_t *)&timestamp,
> -                                 sizeof(timestamp), prp1, prp2);
> +    return nvme_dma_prp(n, (uint8_t *)&timestamp, sizeof(timestamp), prp1,
> +                        prp2, DMA_DIRECTION_FROM_DEVICE);
>  }
>  
>  static uint16_t nvme_get_feature(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req)
> @@ -1352,8 +1350,8 @@ static uint16_t nvme_set_feature_timestamp(NvmeCtrl *n, NvmeCmd *cmd)
>      uint64_t prp1 = le64_to_cpu(cmd->dptr.prp1);
>      uint64_t prp2 = le64_to_cpu(cmd->dptr.prp2);
>  
> -    ret = nvme_dma_write_prp(n, (uint8_t *)&timestamp,
> -                                sizeof(timestamp), prp1, prp2);
> +    ret = nvme_dma_prp(n, (uint8_t *)&timestamp, sizeof(timestamp), prp1,
> +                       prp2, DMA_DIRECTION_TO_DEVICE);
>      if (ret != NVME_SUCCESS) {
>          return ret;
>      }



