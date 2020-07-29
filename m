Return-Path: <SRS0=FCxk=BI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F215C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2020 17:40:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D24592075F
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2020 17:40:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RcvXgG3G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D24592075F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54356 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0q45-0006r0-3c
	for qemu-devel@archiver.kernel.org; Wed, 29 Jul 2020 13:40:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52388)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlevitsk@redhat.com>)
 id 1k0q3M-0006IS-Id
 for qemu-devel@nongnu.org; Wed, 29 Jul 2020 13:39:44 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:60737
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mlevitsk@redhat.com>)
 id 1k0q3K-0006OP-Gp
 for qemu-devel@nongnu.org; Wed, 29 Jul 2020 13:39:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596044381;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=orwZpaevPq/T16l5FcqoaZvrIK5NvR/feZzBXcWzkAQ=;
 b=RcvXgG3GIhd8ovXb+ZLTy+8epCrEpYhmSE1OIUT7+eu4wREBbsHsWulaX13o306sVM0MGL
 H9i4Lmatm0gM4r2Sfn8avwRNdbMKHude3jizeFfYIcCnZue4XW3fSbtIAxkQXpU4ae1abC
 /TIk2p/VS6BWQYoCUzNIgp4E7Ar+Wjw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-152-N_MydTWjMH6S8b3XBhYLhg-1; Wed, 29 Jul 2020 13:39:37 -0400
X-MC-Unique: N_MydTWjMH6S8b3XBhYLhg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2B45E1005510;
 Wed, 29 Jul 2020 17:39:36 +0000 (UTC)
Received: from starship (unknown [10.35.206.108])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 160BD5DA77;
 Wed, 29 Jul 2020 17:39:30 +0000 (UTC)
Message-ID: <1185f7acd9f1d2171c8e09448d6ec94f19ba99f0.camel@redhat.com>
Subject: Re: [PATCH 11/16] hw/block/nvme: be consistent about zeros vs zeroes
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Klaus Jensen <its@irrelevant.dk>, qemu-devel@nongnu.org
Date: Wed, 29 Jul 2020 20:39:29 +0300
In-Reply-To: <20200720113748.322965-12-its@irrelevant.dk>
References: <20200720113748.322965-1-its@irrelevant.dk>
 <20200720113748.322965-12-its@irrelevant.dk>
User-Agent: Evolution 3.36.3 (3.36.3-1.fc32)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=mlevitsk@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/29 09:17:30
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 qemu-block@nongnu.org, Klaus Jensen <k.jensen@samsung.com>,
 Max Reitz <mreitz@redhat.com>, Keith Busch <kbusch@kernel.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 2020-07-20 at 13:37 +0200, Klaus Jensen wrote:
> From: Klaus Jensen <k.jensen@samsung.com>
> 
> The NVM Express specification generally uses 'zeroes' and not 'zeros',
> so let us align with it.
> 
> Cc: Fam Zheng <fam@euphon.net>
> Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
> ---
>  block/nvme.c         | 4 ++--
>  hw/block/nvme.c      | 8 ++++----
>  include/block/nvme.h | 4 ++--
>  3 files changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/block/nvme.c b/block/nvme.c
> index c1c4c07ac6cc..05485fdd1189 100644
> --- a/block/nvme.c
> +++ b/block/nvme.c
> @@ -537,7 +537,7 @@ static void nvme_identify(BlockDriverState *bs, int namespace, Error **errp)
>                            s->page_size / sizeof(uint64_t) * s->page_size);
>  
>      oncs = le16_to_cpu(idctrl->oncs);
> -    s->supports_write_zeroes = !!(oncs & NVME_ONCS_WRITE_ZEROS);
> +    s->supports_write_zeroes = !!(oncs & NVME_ONCS_WRITE_ZEROES);
>      s->supports_discard = !!(oncs & NVME_ONCS_DSM);
>  
>      memset(resp, 0, 4096);
> @@ -1201,7 +1201,7 @@ static coroutine_fn int nvme_co_pwrite_zeroes(BlockDriverState *bs,
>      }
>  
>      NvmeCmd cmd = {
> -        .opcode = NVME_CMD_WRITE_ZEROS,
> +        .opcode = NVME_CMD_WRITE_ZEROES,
>          .nsid = cpu_to_le32(s->nsid),
>          .cdw10 = cpu_to_le32((offset >> s->blkshift) & 0xFFFFFFFF),
>          .cdw11 = cpu_to_le32(((offset >> s->blkshift) >> 32) & 0xFFFFFFFF),
> diff --git a/hw/block/nvme.c b/hw/block/nvme.c
> index 10fe53873ae9..e2932239c661 100644
> --- a/hw/block/nvme.c
> +++ b/hw/block/nvme.c
> @@ -614,7 +614,7 @@ static uint16_t nvme_flush(NvmeCtrl *n, NvmeNamespace *ns, NvmeCmd *cmd,
>      return NVME_NO_COMPLETE;
>  }
>  
> -static uint16_t nvme_write_zeros(NvmeCtrl *n, NvmeNamespace *ns, NvmeCmd *cmd,
> +static uint16_t nvme_write_zeroes(NvmeCtrl *n, NvmeNamespace *ns, NvmeCmd *cmd,
>      NvmeRequest *req)
>  {
>      NvmeRwCmd *rw = (NvmeRwCmd *)cmd;
> @@ -714,8 +714,8 @@ static uint16_t nvme_io_cmd(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req)
>      switch (cmd->opcode) {
>      case NVME_CMD_FLUSH:
>          return nvme_flush(n, ns, cmd, req);
> -    case NVME_CMD_WRITE_ZEROS:
> -        return nvme_write_zeros(n, ns, cmd, req);
> +    case NVME_CMD_WRITE_ZEROES:
> +        return nvme_write_zeroes(n, ns, cmd, req);
>      case NVME_CMD_WRITE:
>      case NVME_CMD_READ:
>          return nvme_rw(n, ns, cmd, req);
> @@ -2328,7 +2328,7 @@ static void nvme_init_ctrl(NvmeCtrl *n, PCIDevice *pci_dev)
>      id->sqes = (0x6 << 4) | 0x6;
>      id->cqes = (0x4 << 4) | 0x4;
>      id->nn = cpu_to_le32(n->num_namespaces);
> -    id->oncs = cpu_to_le16(NVME_ONCS_WRITE_ZEROS | NVME_ONCS_TIMESTAMP |
> +    id->oncs = cpu_to_le16(NVME_ONCS_WRITE_ZEROES | NVME_ONCS_TIMESTAMP |
>                             NVME_ONCS_FEATURES);
>  
>      subnqn = g_strdup_printf("nqn.2019-08.org.qemu:%s", n->params.serial);
> diff --git a/include/block/nvme.h b/include/block/nvme.h
> index 370df7fc0570..65e68a82c897 100644
> --- a/include/block/nvme.h
> +++ b/include/block/nvme.h
> @@ -460,7 +460,7 @@ enum NvmeIoCommands {
>      NVME_CMD_READ               = 0x02,
>      NVME_CMD_WRITE_UNCOR        = 0x04,
>      NVME_CMD_COMPARE            = 0x05,
> -    NVME_CMD_WRITE_ZEROS        = 0x08,
> +    NVME_CMD_WRITE_ZEROES       = 0x08,
>      NVME_CMD_DSM                = 0x09,
>  };
>  
> @@ -838,7 +838,7 @@ enum NvmeIdCtrlOncs {
>      NVME_ONCS_COMPARE       = 1 << 0,
>      NVME_ONCS_WRITE_UNCORR  = 1 << 1,
>      NVME_ONCS_DSM           = 1 << 2,
> -    NVME_ONCS_WRITE_ZEROS   = 1 << 3,
> +    NVME_ONCS_WRITE_ZEROES  = 1 << 3,
>      NVME_ONCS_FEATURES      = 1 << 4,
>      NVME_ONCS_RESRVATIONS   = 1 << 5,
>      NVME_ONCS_TIMESTAMP     = 1 << 6,

Nothing against this.

Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>
Best regards,
	Maxim Levitsky


