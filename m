Return-Path: <SRS0=PjAl=5K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0F6AC1975A
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 10:41:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B6F7720772
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 10:41:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c13sa73m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6F7720772
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33884 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jH3TC-0001Bu-Tc
	for qemu-devel@archiver.kernel.org; Wed, 25 Mar 2020 06:41:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35083)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlevitsk@redhat.com>) id 1jH3R3-0005u1-HH
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 06:38:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlevitsk@redhat.com>) id 1jH3R2-0000tN-Bs
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 06:38:57 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:47380)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlevitsk@redhat.com>) id 1jH3R2-0000sa-6C
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 06:38:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585132735;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Bd0SuHEP0zCp3tHVbG1TTLurn+7BkvI0Xf/8wub6cug=;
 b=c13sa73moMi3vZIvycCVjURbfTTpJ424wKsoeaVMXLznw/pLtpx9Yb1TGUG9Raaf7fOcFq
 Rf2fxK0MgExD2EvBgrwcF5q9FPsTA3OktnIGGil2XwiMmjP4Y/aRpILak3o0lpUdpzGc1L
 xuvJjklXL3it+U/tdKBcfpb8EIQ8n2Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-350-rY4ugg86PHyIM7-hBM7Q7g-1; Wed, 25 Mar 2020 06:38:54 -0400
X-MC-Unique: rY4ugg86PHyIM7-hBM7Q7g-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 192511005509;
 Wed, 25 Mar 2020 10:38:53 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.153])
 by smtp.corp.redhat.com (Postfix) with ESMTP id F154A10027A4;
 Wed, 25 Mar 2020 10:38:50 +0000 (UTC)
Message-ID: <17cc742d163d1551ebbaadaa98503fa7c068115f.camel@redhat.com>
Subject: Re: [PATCH v6 08/42] nvme: add support for the abort command
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Klaus Jensen <its@irrelevant.dk>, qemu-block@nongnu.org
Date: Wed, 25 Mar 2020 12:38:49 +0200
In-Reply-To: <20200316142928.153431-9-its@irrelevant.dk>
References: <20200316142928.153431-1-its@irrelevant.dk>
 <20200316142928.153431-9-its@irrelevant.dk>
Mime-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
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
> Required for compliance with NVMe revision 1.2.1. See NVM Express 1.2.1,
> Section 5.1 ("Abort command").
> 
> The Abort command is a best effort command; for now, the device always
> fails to abort the given command.
> 
> Signed-off-by: Klaus Jensen <klaus.jensen@cnexlabs.com>
> Acked-by: Keith Busch <kbusch@kernel.org>
> ---
>  hw/block/nvme.c | 27 +++++++++++++++++++++++++++
>  1 file changed, 27 insertions(+)
> 
> diff --git a/hw/block/nvme.c b/hw/block/nvme.c
> index 08a83d449de3..7cf7cf55143e 100644
> --- a/hw/block/nvme.c
> +++ b/hw/block/nvme.c
> @@ -729,6 +729,18 @@ static uint16_t nvme_identify(NvmeCtrl *n, NvmeCmd *cmd)
>      }
>  }
>  
> +static uint16_t nvme_abort(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req)
> +{
> +    uint16_t sqid = le32_to_cpu(cmd->cdw10) & 0xffff;
> +
> +    req->cqe.result = 1;
> +    if (nvme_check_sqid(n, sqid)) {
> +        return NVME_INVALID_FIELD | NVME_DNR;
> +    }
> +
> +    return NVME_SUCCESS;
> +}
> +
>  static inline void nvme_set_timestamp(NvmeCtrl *n, uint64_t ts)
>  {
>      trace_nvme_dev_setfeat_timestamp(ts);
> @@ -863,6 +875,8 @@ static uint16_t nvme_admin_cmd(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req)
>          return nvme_create_cq(n, cmd);
>      case NVME_ADM_CMD_IDENTIFY:
>          return nvme_identify(n, cmd);
> +    case NVME_ADM_CMD_ABORT:
> +        return nvme_abort(n, cmd, req);
>      case NVME_ADM_CMD_SET_FEATURES:
>          return nvme_set_feature(n, cmd, req);
>      case NVME_ADM_CMD_GET_FEATURES:
> @@ -1375,6 +1389,19 @@ static void nvme_realize(PCIDevice *pci_dev, Error **errp)
>      id->ieee[1] = 0x02;
>      id->ieee[2] = 0xb3;
>      id->oacs = cpu_to_le16(0);
> +
> +    /*
> +     * Because the controller always completes the Abort command immediately,
> +     * there can never be more than one concurrently executing Abort command,
> +     * so this value is never used for anything. Note that there can easily be
> +     * many Abort commands in the queues, but they are not considered
> +     * "executing" until processed by nvme_abort.
> +     *
> +     * The specification recommends a value of 3 for Abort Command Limit (four
> +     * concurrently outstanding Abort commands), so lets use that though it is
> +     * inconsequential.
> +     */
> +    id->acl = 3;
>      id->frmw = 7 << 1;
>      id->lpa = 1 << 0;
>      id->sqes = (0x6 << 4) | 0x6;

You forgot to move my reviewed-by from the previous version
I see that you also fixed the white space problem, thanks!
So, 

Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>

Best regards,
	Maxim Levitsky





