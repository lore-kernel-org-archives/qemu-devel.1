Return-Path: <SRS0=PjAl=5K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0789EC43331
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 10:39:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C4DAB20772
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 10:39:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BaUEiAa6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4DAB20772
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33834 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jH3Rl-0006nH-0K
	for qemu-devel@archiver.kernel.org; Wed, 25 Mar 2020 06:39:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35001)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlevitsk@redhat.com>) id 1jH3Qi-00057c-8X
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 06:38:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlevitsk@redhat.com>) id 1jH3Qh-0000f6-7J
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 06:38:36 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:37036)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlevitsk@redhat.com>) id 1jH3Qh-0000et-2p
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 06:38:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585132714;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hXV7YjyIHCpklxIXpmt5AxzGn9l3l3uS6j+SSQ20KE0=;
 b=BaUEiAa6CInZR1TCj1NY8hmuIIxuEBKNQb5jhA7BNNehYrPgoSW2xiVZd8yj/lDV2v0+qe
 lGl1pGrEQKFzJ8/dbeBiI2H8eTOtw0b51qPaDmbm7M1cCYBtsryLUTXpa3IgCynt7LrQtd
 vn3l/gKDZMGw3jmeJ7urr8IURf+lnUI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-31-pNcTt1uXNKuA9lHMDLdsnA-1; Wed, 25 Mar 2020 06:38:33 -0400
X-MC-Unique: pNcTt1uXNKuA9lHMDLdsnA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C1107DBA5;
 Wed, 25 Mar 2020 10:38:31 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.153])
 by smtp.corp.redhat.com (Postfix) with ESMTP id AA22E60BE1;
 Wed, 25 Mar 2020 10:38:29 +0000 (UTC)
Message-ID: <1fb18481dfcfa17c2395f3bcded0aef787badfc7.camel@redhat.com>
Subject: Re: [PATCH v6 07/42] nvme: refactor nvme_addr_read
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Klaus Jensen <its@irrelevant.dk>, qemu-block@nongnu.org
Date: Wed, 25 Mar 2020 12:38:28 +0200
In-Reply-To: <20200316142928.153431-8-its@irrelevant.dk>
References: <20200316142928.153431-1-its@irrelevant.dk>
 <20200316142928.153431-8-its@irrelevant.dk>
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

On Mon, 2020-03-16 at 07:28 -0700, Klaus Jensen wrote:
> From: Klaus Jensen <k.jensen@samsung.com>
> 
> Pull the controller memory buffer check to its own function. The check
> will be used on its own in later patches.
> 
> Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
> Acked-by: Keith Busch <kbusch@kernel.org>
> ---
>  hw/block/nvme.c | 16 ++++++++++++----
>  1 file changed, 12 insertions(+), 4 deletions(-)
> 
> diff --git a/hw/block/nvme.c b/hw/block/nvme.c
> index b38d7e548a60..08a83d449de3 100644
> --- a/hw/block/nvme.c
> +++ b/hw/block/nvme.c
> @@ -52,14 +52,22 @@
>  
>  static void nvme_process_sq(void *opaque);
>  
> +static inline bool nvme_addr_is_cmb(NvmeCtrl *n, hwaddr addr)
> +{
> +    hwaddr low = n->ctrl_mem.addr;
> +    hwaddr hi  = n->ctrl_mem.addr + int128_get64(n->ctrl_mem.size);
> +
> +    return addr >= low && addr < hi;
> +}
> +
>  static void nvme_addr_read(NvmeCtrl *n, hwaddr addr, void *buf, int size)
>  {
> -    if (n->cmbsz && addr >= n->ctrl_mem.addr &&
> -                addr < (n->ctrl_mem.addr + int128_get64(n->ctrl_mem.size))) {
> +    if (n->cmbsz && nvme_addr_is_cmb(n, addr)) {
>          memcpy(buf, (void *)&n->cmbuf[addr - n->ctrl_mem.addr], size);
> -    } else {
> -        pci_dma_read(&n->parent_obj, addr, buf, size);
> +        return;
>      }
> +
> +    pci_dma_read(&n->parent_obj, addr, buf, size);
>  }
>  
>  static int nvme_check_sqid(NvmeCtrl *n, uint16_t sqid)

Note that this patch still contains a bug that it removes the check against the accessed
size, which you fix in later patch.
I prefer to not add a bug in first place
However if you have a reason for this, I won't mind.

Best regards,
	Maxim Levitsky






