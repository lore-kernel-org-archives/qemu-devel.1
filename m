Return-Path: <SRS0=xDnh=4A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89314C2BA83
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2020 09:19:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5527120714
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2020 09:19:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ecr3hTY+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5527120714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34078 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1oBI-00052P-P3
	for qemu-devel@archiver.kernel.org; Wed, 12 Feb 2020 04:19:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45502)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlevitsk@redhat.com>) id 1j1oAU-00041r-KH
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 04:18:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlevitsk@redhat.com>) id 1j1oAT-0001uH-4k
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 04:18:50 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:41816
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlevitsk@redhat.com>) id 1j1oAS-0001t1-Vo
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 04:18:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581499128;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2hKol6aE/vi8AwPCrXvBD7u/0QQSXK0wbpCYS6ZrO9k=;
 b=ecr3hTY+0DqNnrccZvtGQusHspiQxe8998XovIKIi3hWZJq9jvxF4pvgw4rXfF25JFcOou
 6sadt86/hrllpn6LVQagjFp6jBhTouzYZatABpPt2lh2GVqoyQ8gNe4SQF6Q8sV+biUIeD
 SQkWSaEGpUjBLWt9Iyg3+sR35oeX1gw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-219-Y8VnK_VuPy2UXCZkXtgeOw-1; Wed, 12 Feb 2020 04:18:31 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C76A2802706;
 Wed, 12 Feb 2020 09:18:29 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.63])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9EF185C11E;
 Wed, 12 Feb 2020 09:18:27 +0000 (UTC)
Message-ID: <4a5632a7b85389a91da1e3462da16515b5910e5a.camel@redhat.com>
Subject: Re: [PATCH v5 05/26] nvme: populate the mandatory subnqn and ver
 fields
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Klaus Jensen <k.jensen@samsung.com>, qemu-block@nongnu.org
Date: Wed, 12 Feb 2020 11:18:16 +0200
In-Reply-To: <20200204095208.269131-6-k.jensen@samsung.com>
References: <20200204095208.269131-1-k.jensen@samsung.com>
 <CGME20200204095218eucas1p2400645e2400b3d4450386a46e71b9e9a@eucas1p2.samsung.com>
 <20200204095208.269131-6-k.jensen@samsung.com>
Mime-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: Y8VnK_VuPy2UXCZkXtgeOw-1
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
> Required for compliance with NVMe revision 1.2.1 or later. See NVM
> Express 1.2.1, Section 5.11 ("Identify command"), Figure 90 and Section
> 7.9 ("NVMe Qualified Names").
> 
> This also bumps the supported version to 1.2.1.
> 
> Signed-off-by: Klaus Jensen <klaus.jensen@cnexlabs.com>
> ---
>  hw/block/nvme.c | 13 ++++++++++---
>  1 file changed, 10 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/block/nvme.c b/hw/block/nvme.c
> index f05ebcce3f53..9abf74da20f2 100644
> --- a/hw/block/nvme.c
> +++ b/hw/block/nvme.c
> @@ -9,9 +9,9 @@
>   */
>  
>  /**
> - * Reference Specs: http://www.nvmexpress.org, 1.2, 1.1, 1.0e
> + * Reference Specification: NVM Express 1.2.1
>   *
> - *  http://www.nvmexpress.org/resources/
> + *   https://nvmexpress.org/resources/specifications/
To be honest that redirects to https://nvmexpress.org/specifications/
Not a problem though.
>   */
>  
>  /**
> @@ -43,6 +43,8 @@
>  #include "trace.h"
>  #include "nvme.h"
>  
> +#define NVME_SPEC_VER 0x00010201
> +
>  #define NVME_GUEST_ERR(trace, fmt, ...) \
>      do { \
>          (trace_##trace)(__VA_ARGS__); \
> @@ -1365,6 +1367,7 @@ static void nvme_realize(PCIDevice *pci_dev, Error **errp)
>      id->ieee[0] = 0x00;
>      id->ieee[1] = 0x02;
>      id->ieee[2] = 0xb3;
> +    id->ver = cpu_to_le32(NVME_SPEC_VER);
This is indeed 1.2 addition
>      id->oacs = cpu_to_le16(0);
>      id->frmw = 7 << 1;
>      id->lpa = 1 << 0;
> @@ -1372,6 +1375,10 @@ static void nvme_realize(PCIDevice *pci_dev, Error **errp)
>      id->cqes = (0x4 << 4) | 0x4;
>      id->nn = cpu_to_le32(n->num_namespaces);
>      id->oncs = cpu_to_le16(NVME_ONCS_WRITE_ZEROS | NVME_ONCS_TIMESTAMP);
> +
> +    strcpy((char *) id->subnqn, "nqn.2019-08.org.qemu:");
> +    pstrcat((char *) id->subnqn, sizeof(id->subnqn), n->params.serial);
Looks OK, this is first format according to the spec.
> +
>      id->psd[0].mp = cpu_to_le16(0x9c4);
>      id->psd[0].enlat = cpu_to_le32(0x10);
>      id->psd[0].exlat = cpu_to_le32(0x4);
> @@ -1386,7 +1393,7 @@ static void nvme_realize(PCIDevice *pci_dev, Error **errp)
>      NVME_CAP_SET_CSS(n->bar.cap, 1);
>      NVME_CAP_SET_MPSMAX(n->bar.cap, 4);
>  
> -    n->bar.vs = 0x00010200;
> +    n->bar.vs = NVME_SPEC_VER;
>      n->bar.intmc = n->bar.intms = 0;
>  
>      if (n->params.cmb_size_mb) {

To be really pedantic, the 1.2 spec also requires at least:
  * wctemp and cctemp to be nonzero in Identify Controller (yea, this is stupid to report temperature for virtual controller)
  * NVME_ADM_CMD_GET_LOG_PAGE, with some mandatory log pages
  * NVME_ADM_CMD_SET_FEATURES/NVME_ADM_CMD_GET_FEATURES - The device currently doesn't implement some mandatory features.

And there are probably more. This is what I can recall from my nvme-mdev.

However I see that you implmented these in following patches, so I suggest you first put patches that implement all that features,
and then bump the NVME version.
Most of these features I mentioned were mandatory even in version 1.0 of the spec, so current version is not even
compliant with 1.0 IMHO.

Best regards,
	Maxim Levitsky


