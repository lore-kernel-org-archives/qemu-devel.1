Return-Path: <SRS0=xDnh=4A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09245C2BA83
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2020 09:24:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C704420661
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2020 09:24:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CO95DT+L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C704420661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34158 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1oGI-00076A-Vf
	for qemu-devel@archiver.kernel.org; Wed, 12 Feb 2020 04:24:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46655)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlevitsk@redhat.com>) id 1j1oFd-0006Ls-Sn
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 04:24:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlevitsk@redhat.com>) id 1j1oFc-0006ye-GR
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 04:24:09 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:59669
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlevitsk@redhat.com>) id 1j1oFc-0006wV-DI
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 04:24:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581499447;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=c//QhTYDb+lZxS4oEJlg9FTNf3g1nJSs9iur771QDOA=;
 b=CO95DT+LfvyWcwwlm5CvGCQjsbzfqGBHMej2Biz0+nTRp11+JU7f90btlVqiB0ONP3urIz
 Mkz8Wh9PqdzH9mSijV+Mlk+kw1cRfMTBkvatU1pGtUFu3V8cfCtdssIi22480yfQCVetFb
 UO4EVNi8XVP/y6h1jJCzEHYgrX/0DtE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-326-H3s_vuztOva5v8sT4dPlGg-1; Wed, 12 Feb 2020 04:24:03 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 17D5013F6;
 Wed, 12 Feb 2020 09:24:02 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.63])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C33BB10016DA;
 Wed, 12 Feb 2020 09:23:59 +0000 (UTC)
Message-ID: <21c547b8875794a804ab0f0228cd8cd5430f81cc.camel@redhat.com>
Subject: Re: [PATCH v5 06/26] nvme: refactor nvme_addr_read
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Klaus Jensen <k.jensen@samsung.com>, qemu-block@nongnu.org
Date: Wed, 12 Feb 2020 11:23:48 +0200
In-Reply-To: <20200204095208.269131-7-k.jensen@samsung.com>
References: <20200204095208.269131-1-k.jensen@samsung.com>
 <CGME20200204095219eucas1p1a7d44c741e119939c60ff60b96c7652e@eucas1p1.samsung.com>
 <20200204095208.269131-7-k.jensen@samsung.com>
Mime-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: H3s_vuztOva5v8sT4dPlGg-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
> Pull the controller memory buffer check to its own function. The check
> will be used on its own in later patches.
> 
> Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
> ---
>  hw/block/nvme.c | 18 +++++++++++++-----
>  1 file changed, 13 insertions(+), 5 deletions(-)
> 
> diff --git a/hw/block/nvme.c b/hw/block/nvme.c
> index 9abf74da20f2..ba5089df9ece 100644
> --- a/hw/block/nvme.c
> +++ b/hw/block/nvme.c
> @@ -54,14 +54,22 @@
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
> -        memcpy(buf, (void *)&n->cmbuf[addr - n->ctrl_mem.addr], size);
> -    } else {
> -        pci_dma_read(&n->parent_obj, addr, buf, size);
> +    if (n->cmbsz && nvme_addr_is_cmb(n, addr)) {
> +        memcpy(buf, (void *) &n->cmbuf[addr - n->ctrl_mem.addr], size);
Nitpick:
I am not an expert on qemu coding style but I suspect that there is extra space after that (void *).

Also note that in following patches you fix a serious bug in this function that it doesn't
check that the whole range is in CMB but only that the start of the area is.
I would move it here, or even to a separate patch.

> +        return;
>      }
> +
> +    pci_dma_read(&n->parent_obj, addr, buf, size);
>  }
>  
>  static int nvme_check_sqid(NvmeCtrl *n, uint16_t sqid)

Best regards,
	Maxim Levitsky



