Return-Path: <SRS0=HxLX=Y5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45145C5DF60
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2019 20:47:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA93F206DF
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2019 20:47:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=reactos.org header.i=@reactos.org header.b="FOKmuQRI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA93F206DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=reactos.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49806 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iS5jI-0004Q1-RW
	for qemu-devel@archiver.kernel.org; Tue, 05 Nov 2019 15:47:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56866)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <hpoussin@reactos.org>) id 1iS5hv-0003gI-96
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 15:45:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <hpoussin@reactos.org>) id 1iS5ht-0007Po-Qb
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 15:45:43 -0500
Received: from iserv.reactos.org ([2a01:4f8:1c17:5ae1::1]:33302)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <hpoussin@reactos.org>)
 id 1iS5ht-0007PX-8k
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 15:45:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=reactos.org
 ; s=25047;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:
 Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=yc+g3s++QzbkOgwI5Yq+qHpCQdqGnZaz+TB41bk9DGs=; b=FOKmuQRIPvycgHu0JwdWMMU2LP
 dN63j+j8nmkFcfxFRbEg7PyUaxhPHfdJsiakDqXsGjLuzsluS3LRw0bejO+oyy61WC+4Ylzb/w1nv
 /a6VJnwuogvA/6kgpeORZCr0H1xnA95Sz/gzzMmEpWNfeJHM0G26FciSs6QaKyOG7Z0I=;
Received: from [2a01:e35:2e3e:3c40:810c:5dc0:a5b7:d589]
 by iserv.reactos.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.89) (envelope-from <hpoussin@reactos.org>)
 id 1iS5hp-0003vT-Tl; Tue, 05 Nov 2019 20:45:39 +0000
Subject: Re: [PATCH 3/3] dp8393x: fix receiving buffer exhaustion
To: Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org
References: <20191102171511.31881-1-laurent@vivier.eu>
 <20191102171511.31881-4-laurent@vivier.eu>
From: =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>
Message-ID: <c98e5cee-ee05-3b2b-894b-f0c9c829f644@reactos.org>
Date: Tue, 5 Nov 2019 21:45:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191102171511.31881-4-laurent@vivier.eu>
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
> The card is not able to exit from exhaustion state, because
> while the drive consumes the buffers, the RRP is incremented
> (when the driver clears the ISR RBE bit), so it stays equal
> to RWP, and while RRP == RWP, the card thinks it is always
> in exhaustion state. So the driver consumes all the buffers,
> but the card cannot receive new ones.
> 
> This patch fixes the problem by not incrementing RRP when
> the driver clears the ISR RBE bit.
> 
> Signed-off-by: Laurent Vivier <laurent@vivier.eu>
> ---
>   hw/net/dp8393x.c | 31 ++++++++++++++++---------------
>   1 file changed, 16 insertions(+), 15 deletions(-)

I checked the DP83932C specification, available at
https://www.eit.lth.se/fileadmin/eit/courses/datablad/Periphery/Communication/DP83932C.pdf

In the Buffer Resources Exhausted section (page 20):
"To continue reception after the last RBA is used, the system must supply
additional RRA descriptor(s), update the RWP register, and clear the RBE
bit in the ISR. The SONIC rereads the RRA after this bit is cleared."

If I understand correctly, if the OS updates first the RWP and then clear the RBE bit,
then RRP should be different of RWP in dp8393x_do_read_rra() ? Or did I miss something?

> 
> diff --git a/hw/net/dp8393x.c b/hw/net/dp8393x.c
> index b8c4473f99..21deb32456 100644
> --- a/hw/net/dp8393x.c
> +++ b/hw/net/dp8393x.c
> @@ -304,7 +304,7 @@ static void dp8393x_do_load_cam(dp8393xState *s)
>       dp8393x_update_irq(s);
>   }
>   
> -static void dp8393x_do_read_rra(dp8393xState *s)
> +static void dp8393x_do_read_rra(dp8393xState *s, int next)
>   {
>       int width, size;
>   
> @@ -323,19 +323,20 @@ static void dp8393x_do_read_rra(dp8393xState *s)
>           s->regs[SONIC_CRBA0], s->regs[SONIC_CRBA1],
>           s->regs[SONIC_RBWC0], s->regs[SONIC_RBWC1]);
>   
> -    /* Go to next entry */
> -    s->regs[SONIC_RRP] += size;
> +    if (next) {
> +        /* Go to next entry */
> +        s->regs[SONIC_RRP] += size;
>   
> -    /* Handle wrap */
> -    if (s->regs[SONIC_RRP] == s->regs[SONIC_REA]) {
> -        s->regs[SONIC_RRP] = s->regs[SONIC_RSA];
> -    }
> +        /* Handle wrap */
> +        if (s->regs[SONIC_RRP] == s->regs[SONIC_REA]) {
> +            s->regs[SONIC_RRP] = s->regs[SONIC_RSA];
> +        }
>   
> -    /* Check resource exhaustion */
> -    if (s->regs[SONIC_RRP] == s->regs[SONIC_RWP])
> -    {
> -        s->regs[SONIC_ISR] |= SONIC_ISR_RBE;
> -        dp8393x_update_irq(s);
> +        /* Check resource exhaustion */
> +        if (s->regs[SONIC_RRP] == s->regs[SONIC_RWP]) {
> +            s->regs[SONIC_ISR] |= SONIC_ISR_RBE;
> +            dp8393x_update_irq(s);
> +        }
>       }
>   
>       /* Done */
> @@ -549,7 +550,7 @@ static void dp8393x_do_command(dp8393xState *s, uint16_t command)
>       if (command & SONIC_CR_RST)
>           dp8393x_do_software_reset(s);
>       if (command & SONIC_CR_RRRA)
> -        dp8393x_do_read_rra(s);
> +        dp8393x_do_read_rra(s, 1);
>       if (command & SONIC_CR_LCAM)
>           dp8393x_do_load_cam(s);
>   }
> @@ -640,7 +641,7 @@ static void dp8393x_write(void *opaque, hwaddr addr, uint64_t data,
>               data &= s->regs[reg];
>               s->regs[reg] &= ~data;
>               if (data & SONIC_ISR_RBE) {
> -                dp8393x_do_read_rra(s);
> +                dp8393x_do_read_rra(s, 0);
>               }
>               dp8393x_update_irq(s);
>               if (dp8393x_can_receive(s->nic->ncs)) {
> @@ -840,7 +841,7 @@ static ssize_t dp8393x_receive(NetClientState *nc, const uint8_t * buf,
>   
>           if (s->regs[SONIC_RCR] & SONIC_RCR_LPKT) {
>               /* Read next RRA */
> -            dp8393x_do_read_rra(s);
> +            dp8393x_do_read_rra(s, 1);
>           }
>       }
>   
> 


