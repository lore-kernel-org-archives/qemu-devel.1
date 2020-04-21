Return-Path: <SRS0=H2wg=6F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19FB5C54FD0
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2020 15:08:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C8D332068F
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2020 15:08:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LaWlYdYh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8D332068F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59694 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jQuW6-0008UV-Kh
	for qemu-devel@archiver.kernel.org; Tue, 21 Apr 2020 11:08:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41156)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlevitsk@redhat.com>) id 1jQuRq-0003iE-AY
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 11:04:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <mlevitsk@redhat.com>) id 1jQuRo-0001hQ-3c
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 11:04:29 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:20590
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mlevitsk@redhat.com>)
 id 1jQuRn-0001bA-Jz
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 11:04:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587481464;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ShqvpiFeDSPZQSDJ2F20b+3BeH2l1HI8COtNhi7vaWM=;
 b=LaWlYdYhQNmn3UwNR6psAapAWROE+PkIIe5pM4tBmsS3FjFgJVy7yIXXwAh8KJNABDDqTP
 idz1w2kRyZy93Bp6UHHTsm0ByCtJGSk3ghox7ArMWb8oq9361IrfyDJXKKCUiVx6ifxwfe
 RaHk4MVsGI/MzV3abRdfzMYAkWFiRi8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-273-dINqWOhNMU2rbcMgI77nnQ-1; Tue, 21 Apr 2020 11:04:22 -0400
X-MC-Unique: dINqWOhNMU2rbcMgI77nnQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BDED18018A7;
 Tue, 21 Apr 2020 15:04:18 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.222])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3EC5E76E91;
 Tue, 21 Apr 2020 15:04:16 +0000 (UTC)
Message-ID: <ed0cdcd819e7d9f92fda6cf6f30d3bf44b8d1a0b.camel@redhat.com>
Subject: Re: [PATCH v2 11/16] nvme: factor out block backend setup
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Klaus Jensen <its@irrelevant.dk>, qemu-block@nongnu.org
Date: Tue, 21 Apr 2020 18:04:15 +0300
In-Reply-To: <20200415130159.611361-12-its@irrelevant.dk>
References: <20200415130159.611361-1-its@irrelevant.dk>
 <20200415130159.611361-12-its@irrelevant.dk>
Mime-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=mlevitsk@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/21 04:54:00
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Received-From: 207.211.31.120
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
 Klaus Jensen <k.jensen@samsung.com>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>, Keith Busch <kbusch@kernel.org>,
 Javier Gonzalez <javier.gonz@samsung.com>,
 Philippe =?ISO-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 2020-04-15 at 15:01 +0200, Klaus Jensen wrote:
> From: Klaus Jensen <k.jensen@samsung.com>
> 
> Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
> ---
>  hw/block/nvme.c | 13 ++++++++++---
>  1 file changed, 10 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/block/nvme.c b/hw/block/nvme.c
> index 45a352b63d89..80da0825d295 100644
> --- a/hw/block/nvme.c
> +++ b/hw/block/nvme.c
> @@ -1351,6 +1351,13 @@ static void nvme_init_state(NvmeCtrl *n)
>      n->cq = g_new0(NvmeCQueue *, n->params.max_ioqpairs + 1);
>  }
>  
> +static void nvme_init_blk(NvmeCtrl *n, Error **errp)
> +{
> +    blkconf_blocksizes(&n->conf);
> +    blkconf_apply_backend_options(&n->conf, blk_is_read_only(n->conf.blk),
> +                                  false, errp);
> +}
> +
>  static void nvme_realize(PCIDevice *pci_dev, Error **errp)
>  {
>      NvmeCtrl *n = NVME(pci_dev);
> @@ -1375,9 +1382,9 @@ static void nvme_realize(PCIDevice *pci_dev, Error **errp)
>          return;
>      }
>  
> -    blkconf_blocksizes(&n->conf);
> -    if (!blkconf_apply_backend_options(&n->conf, blk_is_read_only(n->conf.blk),
> -                                       false, errp)) {
> +    nvme_init_blk(n, &err);
> +    if (err) {
> +        error_propagate(errp, err);
>          return;
>      }
>  

Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>

Best regards,
	Maxim Levitsky


