Return-Path: <SRS0=HxLX=Y5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57E6DC5DF60
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2019 21:42:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 114A121882
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2019 21:42:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=reactos.org header.i=@reactos.org header.b="Y6witOGR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 114A121882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=reactos.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50534 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iS6ac-0004RS-SN
	for qemu-devel@archiver.kernel.org; Tue, 05 Nov 2019 16:42:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34170)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <hpoussin@reactos.org>) id 1iS62U-0000jP-Ct
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 16:06:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <hpoussin@reactos.org>) id 1iS62T-0001XV-28
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 16:06:58 -0500
Received: from iserv.reactos.org ([2a01:4f8:1c17:5ae1::1]:33874)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <hpoussin@reactos.org>)
 id 1iS62S-0001Ww-HH
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 16:06:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=reactos.org
 ; s=25047;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:
 Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=l5kQ8wFjTc8u/RT83N469UKvxsxuuW7khsU+cs3pgXw=; b=Y6witOGRbNrDWIjrZ2f9qckdA/
 TASQbI05UQZXhQq53CLssUCtIhMnc6U48vmUz4lqKNomQx40W2m736yrlhobSgQcxYWNqjhx9CB4m
 t2Ol3GGQhtR4iQ09WxqDlEjOnlClR4NepM8zdazTHPSCkUbz+vw0JzbHLCRoR2j6Y23Y=;
Received: from [2a01:e35:2e3e:3c40:810c:5dc0:a5b7:d589]
 by iserv.reactos.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.89) (envelope-from <hpoussin@reactos.org>)
 id 1iS62O-0004ah-NM; Tue, 05 Nov 2019 21:06:54 +0000
Subject: Re: [PATCH 2/3] dp8393x: fix dp8393x_receive()
To: Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org
References: <20191102171511.31881-1-laurent@vivier.eu>
 <20191102171511.31881-3-laurent@vivier.eu>
From: =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>
Message-ID: <b357fb5d-bae2-5ab0-7c63-4f7106fb8c4e@reactos.org>
Date: Tue, 5 Nov 2019 22:06:51 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191102171511.31881-3-laurent@vivier.eu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a01:4f8:1c17:5ae1::1
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
Cc: Jason Wang <jasowang@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 02/11/2019 à 18:15, Laurent Vivier a écrit :
> address_space_rw() access size must be multiplied by the width.
> 
> This fixes DHCP for Q800 guest.
> 
> Signed-off-by: Laurent Vivier <laurent@vivier.eu>
> ---
>   hw/net/dp8393x.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/net/dp8393x.c b/hw/net/dp8393x.c
> index 85d3f3788e..b8c4473f99 100644
> --- a/hw/net/dp8393x.c
> +++ b/hw/net/dp8393x.c
> @@ -833,7 +833,7 @@ static ssize_t dp8393x_receive(NetClientState *nc, const uint8_t * buf,
>       } else {
>           dp8393x_put(s, width, 0, 0); /* in_use */
>           address_space_rw(&s->as, dp8393x_crda(s) + sizeof(uint16_t) * 6 * width,
> -            MEMTXATTRS_UNSPECIFIED, (uint8_t *)s->data, sizeof(uint16_t), 1);
> +            MEMTXATTRS_UNSPECIFIED, (uint8_t *)s->data, size, 1);
>           s->regs[SONIC_CRDA] = s->regs[SONIC_LLFA];
>           s->regs[SONIC_ISR] |= SONIC_ISR_PKTRX;
>           s->regs[SONIC_RSC] = (s->regs[SONIC_RSC] & 0xff00) | (((s->regs[SONIC_RSC] & 0x00ff) + 1) & 0x00ff);
> 

This patch is problematic.
The code was initially created with "size".
It was changed in 409b52bfe199d8106dadf7c5ff3d88d2228e89b5 to fix networking in NetBSD 5.1.

To test with NetBSD 5.1
- boot the installer (arccd-5.1.iso)
- choose (S)hell option
- "ifconfig sn0 10.0.2.15 netmask 255.255.255.0"
- "route add default 10.0.2.2"
- networking should work (I test with "ftp 212.27.63.3")

Without this patch, I get the FTP banner.
With this patch, connection can't be established.

In datasheet page 17, you can see the "Receive Descriptor Format", which contains the in_use field.
It is clearly said that RXpkt.in_use is 16 bit wide, and that the bits 16-31 are not used in 32-bit mode.

So, I don't see why you need to clear 32 bits in 32-bit mode. Maybe you need to clear only the other
16 bits ? Maybe it depends of endianness ?

Regards,

Hervé

