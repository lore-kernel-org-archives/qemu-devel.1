Return-Path: <SRS0=xDnh=4A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DCE9C2BA83
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2020 09:26:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD19420873
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2020 09:26:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G0sly2LV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD19420873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34206 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1oHn-0000zv-3B
	for qemu-devel@archiver.kernel.org; Wed, 12 Feb 2020 04:26:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46962)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlevitsk@redhat.com>) id 1j1oHA-0000GM-0s
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 04:25:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlevitsk@redhat.com>) id 1j1oH8-0008Q8-Nd
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 04:25:43 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:36912
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlevitsk@redhat.com>) id 1j1oH8-0008Pf-JG
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 04:25:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581499542;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LJ1hVtLfzTNfO/Tfveu2DGk1tH4AdkrgqduIY9Cd384=;
 b=G0sly2LVehmf+8C8P3fx0IpK1lyUNB13G8Tmf/HfKSmRYl2bX+0cCIVu5pDt7uCcL5fBQp
 sNotFpM6sL8nqnmgO7kDdU+3WT1b0y9AdTaQnoDUgtsWpCjKe88M3QFAWx9pE/zAHLhLKn
 d/jxBr54IxsRx1Ctt9fkYwwnvvHgOcU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-425-lsqadGPZO8O5aS7mkdLnbg-1; Wed, 12 Feb 2020 04:25:37 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6AED08017CC;
 Wed, 12 Feb 2020 09:25:35 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.63])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3ED575D9E2;
 Wed, 12 Feb 2020 09:25:33 +0000 (UTC)
Message-ID: <94a2e5242bdc3158bdee58da611cf0c49aa4a582.camel@redhat.com>
Subject: Re: [PATCH v5 07/26] nvme: add support for the abort command
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Klaus Jensen <k.jensen@samsung.com>, qemu-block@nongnu.org
Date: Wed, 12 Feb 2020 11:25:22 +0200
In-Reply-To: <20200204095208.269131-8-k.jensen@samsung.com>
References: <20200204095208.269131-1-k.jensen@samsung.com>
 <CGME20200204095219eucas1p1a7e88f8f4090988b3dee34d4d4bcc239@eucas1p1.samsung.com>
 <20200204095208.269131-8-k.jensen@samsung.com>
Mime-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: lsqadGPZO8O5aS7mkdLnbg-1
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
> Required for compliance with NVMe revision 1.2.1. See NVM Express 1.2.1,
> Section 5.1 ("Abort command").
> 
> The Abort command is a best effort command; for now, the device always
> fails to abort the given command.
> 
> Signed-off-by: Klaus Jensen <klaus.jensen@cnexlabs.com>
> ---
>  hw/block/nvme.c | 28 ++++++++++++++++++++++++++++
>  1 file changed, 28 insertions(+)
> 
> diff --git a/hw/block/nvme.c b/hw/block/nvme.c
> index ba5089df9ece..e1810260d40b 100644
> --- a/hw/block/nvme.c
> +++ b/hw/block/nvme.c
> @@ -731,6 +731,18 @@ static uint16_t nvme_identify(NvmeCtrl *n, NvmeCmd *cmd)
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

Looks 100% up to spec.

In my nvme-mdev it looks like I implemented this wrongly by failing this with
NVME_SC_ABORT_MISSING (which is defined in the kernel sources, but looks like a reserved
error code in the spec. Not that it matters that much.

Also unrelated to this but something I would like to point out 
(this applies not only to this command but to all admin and IO commands) the device
should check for various reserved fields in the command descriptor, which it doesn't currently.

This is what I do:
https://gitlab.com/maximlevitsky/linux/blob/mdev-work-5.2/drivers/nvme/mdev/adm.c#L783

> +
>  static inline void nvme_set_timestamp(NvmeCtrl *n, uint64_t ts)
>  {
>      trace_nvme_dev_setfeat_timestamp(ts);
> @@ -848,6 +860,7 @@ static uint16_t nvme_set_feature(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req)
>          trace_nvme_dev_err_invalid_setfeat(dw10);
>          return NVME_INVALID_FIELD | NVME_DNR;
>      }
> +
Nitpick: Unrelated whitespace change.
>      return NVME_SUCCESS;
>  }
>  
> @@ -864,6 +877,8 @@ static uint16_t nvme_admin_cmd(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req)
>          return nvme_create_cq(n, cmd);
>      case NVME_ADM_CMD_IDENTIFY:
>          return nvme_identify(n, cmd);
> +    case NVME_ADM_CMD_ABORT:
> +        return nvme_abort(n, cmd, req);
>      case NVME_ADM_CMD_SET_FEATURES:
>          return nvme_set_feature(n, cmd, req);
>      case NVME_ADM_CMD_GET_FEATURES:
> @@ -1377,6 +1392,19 @@ static void nvme_realize(PCIDevice *pci_dev, Error **errp)
>      id->ieee[2] = 0xb3;
>      id->ver = cpu_to_le32(NVME_SPEC_VER);
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
Yep.
>      id->frmw = 7 << 1;
>      id->lpa = 1 << 0;
>      id->sqes = (0x6 << 4) | 0x6;


Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>

Best regards,
	Maxim Levitsky


