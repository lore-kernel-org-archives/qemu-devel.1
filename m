Return-Path: <SRS0=PjAl=5K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21957C54FD0
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 10:41:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E5A9020772
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 10:41:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bfyw0yCa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5A9020772
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33900 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jH3Tk-00020W-2N
	for qemu-devel@archiver.kernel.org; Wed, 25 Mar 2020 06:41:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35344)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlevitsk@redhat.com>) id 1jH3SY-0008Ur-90
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 06:40:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlevitsk@redhat.com>) id 1jH3SW-00020Q-R1
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 06:40:30 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:56181)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlevitsk@redhat.com>) id 1jH3SW-00020H-Lc
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 06:40:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585132828;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Hp9w/wPafJwHU+Sf5P2vW+G4ELiVQqiunXtbIR2/7iw=;
 b=bfyw0yCaCCpSEP+oopUaPXBWfNuUShGHF95dT9Bn9AvDUhmSw6uAkoRkurNZr4uUbL+bIu
 FMCy327EEThQnT0khRQZKOoz1rnBQIQucpzO+sxzYvIdO9PFUHZX+Bie1NlshJfKN1JoF8
 7MHoJF81a4ul/9uADxKvoDl4Ajyjano=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-462-co__mUTWPTGzfQBnvaj53Q-1; Wed, 25 Mar 2020 06:40:26 -0400
X-MC-Unique: co__mUTWPTGzfQBnvaj53Q-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4E62D107ACCA;
 Wed, 25 Mar 2020 10:40:25 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.153])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 366115C1A2;
 Wed, 25 Mar 2020 10:40:23 +0000 (UTC)
Message-ID: <47ef3ec5800b5f74017df60e599f16ba905daab6.camel@redhat.com>
Subject: Re: [PATCH v6 11/42] nvme: add temperature threshold feature
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Klaus Jensen <its@irrelevant.dk>, qemu-block@nongnu.org
Date: Wed, 25 Mar 2020 12:40:22 +0200
In-Reply-To: <20200316142928.153431-12-its@irrelevant.dk>
References: <20200316142928.153431-1-its@irrelevant.dk>
 <20200316142928.153431-12-its@irrelevant.dk>
Mime-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 63.128.21.74
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

On Mon, 2020-03-16 at 07:28 -0700, Klaus Jensen wrote:
> From: Klaus Jensen <k.jensen@samsung.com>
> 
> It might seem wierd to implement this feature for an emulated device,
> but it is mandatory to support and the feature is useful for testing
> asynchronous event request support, which will be added in a later
> patch.
> 
> Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
> Acked-by: Keith Busch <kbusch@kernel.org>
> ---
>  hw/block/nvme.c      | 48 ++++++++++++++++++++++++++++++++++++++++++++
>  hw/block/nvme.h      |  2 ++
>  include/block/nvme.h |  8 +++++++-
>  3 files changed, 57 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/block/nvme.c b/hw/block/nvme.c
> index 665485045066..64c42101df5c 100644
> --- a/hw/block/nvme.c
> +++ b/hw/block/nvme.c
> @@ -45,6 +45,9 @@
>  #include "nvme.h"
>  
>  #define NVME_CMB_BIR 2
> +#define NVME_TEMPERATURE 0x143
> +#define NVME_TEMPERATURE_WARNING 0x157
> +#define NVME_TEMPERATURE_CRITICAL 0x175
>  
>  #define NVME_GUEST_ERR(trace, fmt, ...) \
>      do { \
> @@ -798,9 +801,31 @@ static uint16_t nvme_get_feature_timestamp(NvmeCtrl *n, NvmeCmd *cmd)
>  static uint16_t nvme_get_feature(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req)
>  {
>      uint32_t dw10 = le32_to_cpu(cmd->cdw10);
> +    uint32_t dw11 = le32_to_cpu(cmd->cdw11);
>      uint32_t result;
>  
>      switch (dw10) {
> +    case NVME_TEMPERATURE_THRESHOLD:
> +        result = 0;
> +
> +        /*
> +         * The controller only implements the Composite Temperature sensor, so
> +         * return 0 for all other sensors.
> +         */
> +        if (NVME_TEMP_TMPSEL(dw11)) {
> +            break;
> +        }
> +
> +        switch (NVME_TEMP_THSEL(dw11)) {
> +        case 0x0:
> +            result = cpu_to_le16(n->features.temp_thresh_hi);
> +            break;
> +        case 0x1:
> +            result = cpu_to_le16(n->features.temp_thresh_low);
> +            break;
> +        }
> +
> +        break;
>      case NVME_VOLATILE_WRITE_CACHE:
>          result = blk_enable_write_cache(n->conf.blk);
>          trace_nvme_dev_getfeat_vwcache(result ? "enabled" : "disabled");
> @@ -845,6 +870,23 @@ static uint16_t nvme_set_feature(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req)
>      uint32_t dw11 = le32_to_cpu(cmd->cdw11);
>  
>      switch (dw10) {
> +    case NVME_TEMPERATURE_THRESHOLD:
> +        if (NVME_TEMP_TMPSEL(dw11)) {
> +            break;
> +        }
> +
> +        switch (NVME_TEMP_THSEL(dw11)) {
> +        case 0x0:
> +            n->features.temp_thresh_hi = NVME_TEMP_TMPTH(dw11);
> +            break;
> +        case 0x1:
> +            n->features.temp_thresh_low = NVME_TEMP_TMPTH(dw11);
> +            break;
> +        default:
> +            return NVME_INVALID_FIELD | NVME_DNR;
> +        }
> +
> +        break;
>      case NVME_VOLATILE_WRITE_CACHE:
>          blk_set_enable_write_cache(n->conf.blk, dw11 & 1);
>          break;
> @@ -1374,6 +1416,7 @@ static void nvme_init_state(NvmeCtrl *n)
>      n->namespaces = g_new0(NvmeNamespace, n->num_namespaces);
>      n->sq = g_new0(NvmeSQueue *, n->params.max_ioqpairs + 1);
>      n->cq = g_new0(NvmeCQueue *, n->params.max_ioqpairs + 1);
> +    n->features.temp_thresh_hi = NVME_TEMPERATURE_WARNING;
>  }
>  
>  static void nvme_init_cmb(NvmeCtrl *n, PCIDevice *pci_dev)
> @@ -1451,6 +1494,11 @@ static void nvme_init_ctrl(NvmeCtrl *n)
>      id->acl = 3;
>      id->frmw = 7 << 1;
>      id->lpa = 1 << 0;
> +
> +    /* recommended default value (~70 C) */
> +    id->wctemp = cpu_to_le16(NVME_TEMPERATURE_WARNING);
> +    id->cctemp = cpu_to_le16(NVME_TEMPERATURE_CRITICAL);
> +
>      id->sqes = (0x6 << 4) | 0x6;
>      id->cqes = (0x4 << 4) | 0x4;
>      id->nn = cpu_to_le32(n->num_namespaces);
> diff --git a/hw/block/nvme.h b/hw/block/nvme.h
> index b7c465560eea..8cda5f02c622 100644
> --- a/hw/block/nvme.h
> +++ b/hw/block/nvme.h
> @@ -108,6 +108,7 @@ typedef struct NvmeCtrl {
>      uint64_t    irq_status;
>      uint64_t    host_timestamp;                 /* Timestamp sent by the host */
>      uint64_t    timestamp_set_qemu_clock_ms;    /* QEMU clock time */
> +    uint16_t    temperature;
You forgot to move this too.

>  
>      NvmeNamespace   *namespaces;
>      NvmeSQueue      **sq;
> @@ -115,6 +116,7 @@ typedef struct NvmeCtrl {
>      NvmeSQueue      admin_sq;
>      NvmeCQueue      admin_cq;
>      NvmeIdCtrl      id_ctrl;
> +    NvmeFeatureVal  features;
>  } NvmeCtrl;
>  
>  static inline uint64_t nvme_ns_nlbas(NvmeCtrl *n, NvmeNamespace *ns)
> diff --git a/include/block/nvme.h b/include/block/nvme.h
> index a083c1b3a613..91fc4738a3e0 100644
> --- a/include/block/nvme.h
> +++ b/include/block/nvme.h
> @@ -688,7 +688,13 @@ enum NvmeIdCtrlOncs {
>  typedef struct NvmeFeatureVal {
>      uint32_t    arbitration;
>      uint32_t    power_mgmt;
> -    uint32_t    temp_thresh;
> +    union {
> +        struct {
> +            uint16_t temp_thresh_hi;
> +            uint16_t temp_thresh_low;
> +        };
> +        uint32_t temp_thresh;
> +    };
>      uint32_t    err_rec;
>      uint32_t    volatile_wc;
>      uint32_t    num_queues;

With 'temperature' field removed from the header:

Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>

Best regards,
	Maxim Levitsky




