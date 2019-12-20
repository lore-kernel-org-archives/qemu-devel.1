Return-Path: <SRS0=uEni=2K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CB1DC43603
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 22:16:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 13B79206DA
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 22:16:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13B79206DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=telegraphics.com.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34098 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iiQZN-00021Y-7h
	for qemu-devel@archiver.kernel.org; Fri, 20 Dec 2019 17:16:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55438)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <fthain@telegraphics.com.au>) id 1iiQYP-0001Og-Mb
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 17:15:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <fthain@telegraphics.com.au>) id 1iiQYO-0004Wr-HY
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 17:15:25 -0500
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:46948)
 by eggs.gnu.org with esmtp (Exim 4.71)
 (envelope-from <fthain@telegraphics.com.au>)
 id 1iiQYO-0004Tj-BV; Fri, 20 Dec 2019 17:15:24 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
 by kvm5.telegraphics.com.au (Postfix) with ESMTP id 7974828CC5;
 Fri, 20 Dec 2019 17:15:20 -0500 (EST)
Date: Sat, 21 Dec 2019 09:15:21 +1100 (AEDT)
From: Finn Thain <fthain@telegraphics.com.au>
To: Jason Wang <jasowang@redhat.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH v2 13/13] dp8393x: Correctly advance RRP
In-Reply-To: <05a689e082735b2ad972b3372ceeb7cfe47d4bd4.1576815466.git.fthain@telegraphics.com.au>
Message-ID: <alpine.LNX.2.21.1.1912210905360.8@nippy.intranet>
References: <cover.1576815466.git.fthain@telegraphics.com.au>
 <05a689e082735b2ad972b3372ceeb7cfe47d4bd4.1576815466.git.fthain@telegraphics.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [fuzzy]
X-Received-From: 98.124.60.144
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
Cc: Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 =?ISO-8859-15?Q?Herv=E9_Poussineau?= <hpoussin@reactos.org>,
 Laurent Vivier <laurent@vivier.eu>, qemu-stable@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Please disregard this patch. An off-by-one bug was found in one of my 
Linux sonic driver patches. When I fixed that bug, this patch (13/13) was 
shown to be incorrect.

The Linux sonic driver patches are being tested on actual SONIC hardware 
(Mac Centris 610). I will send v3 of this series after I've finished 
debugging the Linux sonic driver.

On Fri, 20 Dec 2019, Finn Thain wrote:

> The last entry in the RRA is at the address given by the REA register.
> The address wrap-around logic is off-by-one entry. The last resource
> never gets used and RRP can jump over the RWP. The guest driver fails
> badly because the SONIC starts re-using old buffer addresses. Fix this.
> 
> Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
> ---
>  hw/net/dp8393x.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/net/dp8393x.c b/hw/net/dp8393x.c
> index bd92fa28f6..92a30f9f69 100644
> --- a/hw/net/dp8393x.c
> +++ b/hw/net/dp8393x.c
> @@ -340,7 +340,7 @@ static void dp8393x_do_read_rra(dp8393xState *s)
>      s->regs[SONIC_RRP] += size;
>  
>      /* Handle wrap */
> -    if (s->regs[SONIC_RRP] == s->regs[SONIC_REA]) {
> +    if (s->regs[SONIC_RRP] == s->regs[SONIC_REA] + size) {
>          s->regs[SONIC_RRP] = s->regs[SONIC_RSA];
>      }
>  
> 

