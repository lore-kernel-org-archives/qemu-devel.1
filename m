Return-Path: <SRS0=Sgwn=4D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2807C4741C
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Feb 2020 09:26:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F57A2072D
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Feb 2020 09:26:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=duncanthrax.net header.i=@duncanthrax.net header.b="itq3m9tQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F57A2072D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=stackframe.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49588 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2tiW-00039u-KR
	for qemu-devel@archiver.kernel.org; Sat, 15 Feb 2020 04:26:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38946)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <svens@stackframe.org>) id 1j2tdq-0004U5-Im
 for qemu-devel@nongnu.org; Sat, 15 Feb 2020 04:21:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <svens@stackframe.org>) id 1j2tdp-0006I9-Jt
 for qemu-devel@nongnu.org; Sat, 15 Feb 2020 04:21:38 -0500
Received: from propper.duncanthrax.net ([91.207.61.48]:53876
 helo=smtp.duncanthrax.net)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <svens@stackframe.org>)
 id 1j2tdp-0006Gl-Bn
 for qemu-devel@nongnu.org; Sat, 15 Feb 2020 04:21:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=duncanthrax.net; s=dkim; h=In-Reply-To:Content-Type:MIME-Version:References
 :Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding
 :Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=bNAfLYkcKL9H5LiRDTLGx90qNaiH7WEfYcscbTnMiHc=; b=itq3m9tQufrcH3eHCS3gI90v1y
 KKu6hutUuJUhUhXjIyF1b5fi+gFFFJdmuy47d9Rsrddgy+Fv+PXhmRVdIEt3LVMkW1ylud1WxEAyu
 zvuqaUkU0Q7YpwHkuU7HUUovMBh9WOyo2g+5XW3cJl6uqh7+uDYIfZfoWnkYPe2H5fkU=;
Received: from [134.3.47.90] (helo=t470p.stackframe.org)
 by smtp.duncanthrax.net with esmtpa (Exim 4.90_1)
 (envelope-from <svens@stackframe.org>)
 id 1j2tdl-0003wm-0F; Sat, 15 Feb 2020 10:21:33 +0100
Date: Sat, 15 Feb 2020 10:21:32 +0100
From: Sven Schnelle <svens@stackframe.org>
To: P J P <ppandit@redhat.com>
Subject: Re: [PATCH] net: tulip: check frame size and r/w data length
Message-ID: <20200215092132.GE18657@t470p.stackframe.org>
References: <20200211073930.224024-1-ppandit@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200211073930.224024-1-ppandit@redhat.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 91.207.61.48
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
Cc: Li Qiang <pangpei.lq@antfin.com>, Jason Wang <jasowang@redhat.com>,
 Qemu Developers <qemu-devel@nongnu.org>, Ziming Zhang <ezrakiez@gmail.com>,
 Prasad J Pandit <pjp@fedoraproject.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi,

thanks for your patch.

On Tue, Feb 11, 2020 at 01:09:30PM +0530, P J P wrote:
> From: Prasad J Pandit <pjp@fedoraproject.org>
> diff --git a/hw/net/tulip.c b/hw/net/tulip.c
> index cfac2719d3..aca2a3f17f 100644
> --- a/hw/net/tulip.c
> +++ b/hw/net/tulip.c
> @@ -164,27 +164,35 @@ static void tulip_copy_rx_bytes(TULIPState *s, struct tulip_descriptor *desc)
>      int len2 = (desc->control >> RDES1_BUF2_SIZE_SHIFT) & RDES1_BUF2_SIZE_MASK;
>      int len;
>  
> -    if (s->rx_frame_len && len1) {
> -        if (s->rx_frame_len > len1) {
> -            len = len1;
> -        } else {
> -            len = s->rx_frame_len;
> -        }
> -        pci_dma_write(&s->dev, desc->buf_addr1, s->rx_frame +
> -            (s->rx_frame_size - s->rx_frame_len), len);
> -        s->rx_frame_len -= len;
> +    if (!len1 || !len2 || !s->rx_frame_len) {
> +        return;

I haven't tested the patch yet, but would that work if the guest OS passes
only one buffer to the card? I.e. len1 = x, and len2 = 0 because only
buffer 1 is available?

Regards
Sven

