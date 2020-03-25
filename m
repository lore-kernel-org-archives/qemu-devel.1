Return-Path: <SRS0=PjAl=5K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF1C5C1975A
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 11:01:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B5C1520714
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 11:01:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fn9YhQZR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5C1520714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34340 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jH3mm-0003Lh-SC
	for qemu-devel@archiver.kernel.org; Wed, 25 Mar 2020 07:01:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36276)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlevitsk@redhat.com>) id 1jH3YC-0001SF-08
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 06:46:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlevitsk@redhat.com>) id 1jH3Y7-0005LZ-As
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 06:46:19 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:46142)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlevitsk@redhat.com>) id 1jH3Y7-0005L2-5T
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 06:46:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585133174;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+eY+FYy2gFAaVgdYsNIfWfpD1ewVfii1Gi5FkDBQjpM=;
 b=fn9YhQZR5TyljDEdAM/TABs1KfvCByD5Bc0RLq8O+RvOzA0mXTvaH+Wgz5QD1zNYla/fb/
 aXjgqHbo3u4dBEUv1rGPVJZ5O3AEzVQkRZG+9uBj4sNnPKDWWAvP6c39BF0L1yu2d3n0s3
 aIf+sWc4JNXlXBsMYzovi5YwYLs9mGk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-455-Z4TO4VPHMJ6wSGMH5Wi2GQ-1; Wed, 25 Mar 2020 06:46:13 -0400
X-MC-Unique: Z4TO4VPHMJ6wSGMH5Wi2GQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F0EBFA1360;
 Wed, 25 Mar 2020 10:46:11 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.153])
 by smtp.corp.redhat.com (Postfix) with ESMTP id AF91660BE1;
 Wed, 25 Mar 2020 10:46:09 +0000 (UTC)
Message-ID: <3ad9c437587ff82d4ebc455b2bffed1a413c7347.camel@redhat.com>
Subject: Re: [PATCH v6 25/42] nvme: refactor dma read/write
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Klaus Jensen <its@irrelevant.dk>, qemu-block@nongnu.org
Date: Wed, 25 Mar 2020 12:46:08 +0200
In-Reply-To: <20200316142928.153431-26-its@irrelevant.dk>
References: <20200316142928.153431-1-its@irrelevant.dk>
 <20200316142928.153431-26-its@irrelevant.dk>
Mime-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 216.205.24.74
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
Cc: Kevin Wolf <kwolf@redhat.com>, Beata Michalska <beata.michalska@linaro.org>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Keith Busch <kbusch@kernel.org>, Javier Gonzalez <javier.gonz@samsung.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 2020-03-16 at 07:29 -0700, Klaus Jensen wrote:
> From: Klaus Jensen <k.jensen@samsung.com>
> 
> Refactor the nvme_dma_{read,write}_prp functions into a common function
> taking a DMADirection parameter.
> 
> Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
> ---
>  hw/block/nvme.c | 89 ++++++++++++++++++++++++-------------------------
>  1 file changed, 43 insertions(+), 46 deletions(-)
> 
> diff --git a/hw/block/nvme.c b/hw/block/nvme.c
> index e40c080c3b48..809d00443369 100644
> --- a/hw/block/nvme.c
> +++ b/hw/block/nvme.c
> @@ -299,55 +299,50 @@ unmap:
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
> -    if (qsg.nsg > 0) {
> -        if (dma_buf_write(ptr, len, &qsg)) {
> -            status = NVME_INVALID_FIELD | NVME_DNR;
> -        }
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
> +    if (qsg.nsg > 0) {
> +        uint64_t residual;
>  
> -    trace_nvme_dev_dma_read(prp1, prp2);
> +        if (dir == DMA_DIRECTION_TO_DEVICE) {
> +            residual = dma_buf_write(ptr, len, &qsg);
> +        } else {
> +            residual = dma_buf_read(ptr, len, &qsg);
> +        }
>  
> -    if (nvme_map_prp(&qsg, &iov, prp1, prp2, len, n)) {
> -        return NVME_INVALID_FIELD | NVME_DNR;
> -    }
> -    if (qsg.nsg > 0) {
> -        if (unlikely(dma_buf_read(ptr, len, &qsg))) {
> +        if (unlikely(residual)) {
>              trace_nvme_dev_err_invalid_dma();
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
>              trace_nvme_dev_err_invalid_dma();
>              status = NVME_INVALID_FIELD | NVME_DNR;
>          }
> +
>          qemu_iovec_destroy(&iov);
>      }
> +
>      return status;
>  }
>  
> @@ -775,8 +770,8 @@ static uint16_t nvme_smart_info(NvmeCtrl *n, NvmeCmd *cmd, uint8_t rae,
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
> @@ -795,8 +790,8 @@ static uint16_t nvme_fw_log_info(NvmeCtrl *n, NvmeCmd *cmd, uint32_t buf_len,
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
> @@ -820,7 +815,8 @@ static uint16_t nvme_error_info(NvmeCtrl *n, NvmeCmd *cmd, uint8_t rae,
>  
>      trans_len = MIN(sizeof(errlog) - off, buf_len);
>  
> -    return nvme_dma_read_prp(n, errlog, trans_len, prp1, prp2);
> +    return nvme_dma_prp(n, errlog, trans_len, prp1, prp2,
> +                        DMA_DIRECTION_FROM_DEVICE);
>  }
>  
>  static uint16_t nvme_get_log(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req)
> @@ -963,8 +959,8 @@ static uint16_t nvme_identify_ctrl(NvmeCtrl *n, NvmeIdentify *c)
>  
>      trace_nvme_dev_identify_ctrl();
>  
> -    return nvme_dma_read_prp(n, (uint8_t *)&n->id_ctrl, sizeof(n->id_ctrl),
> -        prp1, prp2);
> +    return nvme_dma_prp(n, (uint8_t *)&n->id_ctrl, sizeof(n->id_ctrl), prp1,
> +                        prp2, DMA_DIRECTION_FROM_DEVICE);
>  }
>  
>  static uint16_t nvme_identify_ns(NvmeCtrl *n, NvmeIdentify *c)
> @@ -983,8 +979,8 @@ static uint16_t nvme_identify_ns(NvmeCtrl *n, NvmeIdentify *c)
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
> @@ -1009,7 +1005,8 @@ static uint16_t nvme_identify_nslist(NvmeCtrl *n, NvmeIdentify *c)
>              break;
>          }
>      }
> -    ret = nvme_dma_read_prp(n, (uint8_t *)list, data_len, prp1, prp2);
> +    ret = nvme_dma_prp(n, (uint8_t *)list, data_len, prp1, prp2,
> +                       DMA_DIRECTION_FROM_DEVICE);
>      g_free(list);
>      return ret;
>  }
> @@ -1044,8 +1041,8 @@ static uint16_t nvme_identify_ns_descr_list(NvmeCtrl *n, NvmeIdentify *c)
>      ns_descr->nidl = NVME_NIDT_UUID_LEN;
>      stl_be_p(ns_descr + sizeof(*ns_descr), nsid);
>  
> -    ret = nvme_dma_read_prp(n, (uint8_t *) list, NVME_IDENTIFY_DATA_SIZE, prp1,
> -                            prp2);
> +    ret = nvme_dma_prp(n, (uint8_t *) list, NVME_IDENTIFY_DATA_SIZE, prp1,
> +                       prp2, DMA_DIRECTION_FROM_DEVICE);
>      g_free(list);
>      return ret;
>  }
> @@ -1128,8 +1125,8 @@ static uint16_t nvme_get_feature_timestamp(NvmeCtrl *n, NvmeCmd *cmd)
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
> @@ -1214,8 +1211,8 @@ static uint16_t nvme_set_feature_timestamp(NvmeCtrl *n, NvmeCmd *cmd)
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


Looks OK to me.
It was a bit difficult to read the diff, so I also read the code after it was applied.
I hope I didn't miss anything.


Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>

Best regards,
	Maxim Levitsky




