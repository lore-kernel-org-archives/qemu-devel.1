Return-Path: <SRS0=xDnh=4A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6770C2BA83
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2020 09:32:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B24B72073C
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2020 09:32:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I9F7nq5H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B24B72073C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34304 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1oO5-0003cU-Tz
	for qemu-devel@archiver.kernel.org; Wed, 12 Feb 2020 04:32:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47911)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlevitsk@redhat.com>) id 1j1oNJ-00035v-MN
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 04:32:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlevitsk@redhat.com>) id 1j1oNI-0004MU-1t
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 04:32:05 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:31372
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlevitsk@redhat.com>) id 1j1oNH-0004Ly-Tr
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 04:32:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581499923;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DPEeJ3IGR+NI4Auob27Krdhp8DJKltuiV/XRPquYkfk=;
 b=I9F7nq5H5G1Dq1nkfV9lskb+4P4k0VinssCeF64sJ8fZwDOo7xFkuhzdDt1bdSPmVjISe+
 E8MsF3SSSfhZxNyyKnoxtqdcfyTfy6fmcTQOfr/y6+OEuEIdA6Cj60av9iB/vMjIs8LYVj
 CEPZFOs+W3ZpahCrUa+ND2vtsYC8crs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-411-FgwKGzDDPtOxLjHhQiyccg-1; Wed, 12 Feb 2020 04:31:59 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AFB5B1005516;
 Wed, 12 Feb 2020 09:31:57 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.63])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 22C765DA85;
 Wed, 12 Feb 2020 09:31:54 +0000 (UTC)
Message-ID: <9d2f45a97cce33a548ed98843e06b299b89b30e3.camel@redhat.com>
Subject: Re: [PATCH v5 09/26] nvme: add temperature threshold feature
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Klaus Jensen <k.jensen@samsung.com>, qemu-block@nongnu.org
Date: Wed, 12 Feb 2020 11:31:43 +0200
In-Reply-To: <20200204095208.269131-10-k.jensen@samsung.com>
References: <20200204095208.269131-1-k.jensen@samsung.com>
 <CGME20200204095221eucas1p1d5b1c9578d79e6bcc5714976bbe7dc11@eucas1p1.samsung.com>
 <20200204095208.269131-10-k.jensen@samsung.com>
Mime-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: FgwKGzDDPtOxLjHhQiyccg-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
 Keith Busch <kbusch@kernel.org>, Klaus Jensen <its@irrelevant.dk>,
 Javier Gonzalez <javier.gonz@samsung.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 2020-02-04 at 10:51 +0100, Klaus Jensen wrote:
> It might seem wierd to implement this feature for an emulated device,
> but it is mandatory to support and the feature is useful for testing
> asynchronous event request support, which will be added in a later
> patch.

Absolutely but as the old saying is, rules are rules.
At least, to the defense of the spec, making this mandatory
forced the vendors to actually report some statistics about
the device in neutral format as opposed to yet another
vendor proprietary thing (I am talking about SMART log page).

> 
> Signed-off-by: Klaus Jensen <k.jensen@samsung.com>

I noticed that you sign off some patches with your @samsung.com email,
and some with @cnexlabs.com
Is there a reason for that?


> ---
>  hw/block/nvme.c      | 50 ++++++++++++++++++++++++++++++++++++++++++++
>  hw/block/nvme.h      |  2 ++
>  include/block/nvme.h |  7 ++++++-
>  3 files changed, 58 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/block/nvme.c b/hw/block/nvme.c
> index 81514eaef63a..f72348344832 100644
> --- a/hw/block/nvme.c
> +++ b/hw/block/nvme.c
> @@ -45,6 +45,9 @@
>  
>  #define NVME_SPEC_VER 0x00010201
>  #define NVME_MAX_QS PCI_MSIX_FLAGS_QSIZE
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
> @@ -1366,6 +1408,9 @@ static void nvme_init_state(NvmeCtrl *n)
>      n->namespaces = g_new0(NvmeNamespace, n->num_namespaces);
>      n->sq = g_new0(NvmeSQueue *, n->params.num_queues);
>      n->cq = g_new0(NvmeCQueue *, n->params.num_queues);
> +
> +    n->temperature = NVME_TEMPERATURE;

This appears not to be used in the patch.
I think you should move that to the next patch that
adds the get log page support.

> +    n->features.temp_thresh_hi = NVME_TEMPERATURE_WARNING;
>  }
>  
>  static void nvme_init_cmb(NvmeCtrl *n, PCIDevice *pci_dev)
> @@ -1447,6 +1492,11 @@ static void nvme_init_ctrl(NvmeCtrl *n)
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
> index a867bdfabafd..1518f32557a3 100644
> --- a/hw/block/nvme.h
> +++ b/hw/block/nvme.h
> @@ -108,6 +108,7 @@ typedef struct NvmeCtrl {
>      uint64_t    irq_status;
>      uint64_t    host_timestamp;                 /* Timestamp sent by the host */
>      uint64_t    timestamp_set_qemu_clock_ms;    /* QEMU clock time */
> +    uint16_t    temperature;
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
> index d2f65e8fe496..ff31cb32117c 100644
> --- a/include/block/nvme.h
> +++ b/include/block/nvme.h
> @@ -616,7 +616,8 @@ enum NvmeIdCtrlOncs {
>  typedef struct NvmeFeatureVal {
>      uint32_t    arbitration;
>      uint32_t    power_mgmt;
> -    uint32_t    temp_thresh;
> +    uint16_t    temp_thresh_hi;
> +    uint16_t    temp_thresh_low;
>      uint32_t    err_rec;
>      uint32_t    volatile_wc;
>      uint32_t    num_queues;
> @@ -635,6 +636,10 @@ typedef struct NvmeFeatureVal {
>  #define NVME_INTC_THR(intc)     (intc & 0xff)
>  #define NVME_INTC_TIME(intc)    ((intc >> 8) & 0xff)
>  
> +#define NVME_TEMP_THSEL(temp)  ((temp >> 20) & 0x3)
> +#define NVME_TEMP_TMPSEL(temp) ((temp >> 16) & 0xf)
> +#define NVME_TEMP_TMPTH(temp)  (temp & 0xffff)
> +
>  enum NvmeFeatureIds {
>      NVME_ARBITRATION                = 0x1,
>      NVME_POWER_MANAGEMENT           = 0x2,


Best regards,
	Maxim Levitsky


