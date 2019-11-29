Return-Path: <SRS0=xfvu=ZV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 783DAC432C0
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2019 11:42:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 31D73208E4
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2019 11:42:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZpG9FT6B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31D73208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57632 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iaef5-0005xK-Cq
	for qemu-devel@archiver.kernel.org; Fri, 29 Nov 2019 06:42:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40626)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <edgar.iglesias@gmail.com>) id 1iaeM8-0000iK-SR
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 06:22:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <edgar.iglesias@gmail.com>) id 1iaeM4-0003EH-Ao
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 06:22:34 -0500
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:37612)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <edgar.iglesias@gmail.com>)
 id 1iaeM4-0002sO-2w; Fri, 29 Nov 2019 06:22:32 -0500
Received: by mail-wr1-x441.google.com with SMTP id w15so3758505wru.4;
 Fri, 29 Nov 2019 03:22:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=TdIehHzq+Y4vqV0PwyzEM2+xR/h9WqArJUVh23XUysA=;
 b=ZpG9FT6B/oronXjzN27TUDS590BCPC+S5JmfY8QNDx5K0Q/pziKAnD5ziL5Pvh+vch
 2asMF/BUsK5pfm7Lx/XRo4Bqr55BiaAfTjGouw12L7CwkrqS2B/HCtsebbWowfjhur5H
 0SZBd2KAA7a8qu6ZTI7uhLWE4Dk5KfldijTWZjYccIs6/4fDeFne/9U1cP3jF4kj0UhV
 94D3hLmMuZNqz5Od0O+ZeyqpYbc0rsxfl2NvlPomvXGKiWjBHAndUG5tsPLKKYLDCkDZ
 FvT0xuIOrJej8auy3SAk7gpk5937y8fdtlDrhgXrm63CEZrn8tgnG5tZji9CK1cJs1yM
 sWAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=TdIehHzq+Y4vqV0PwyzEM2+xR/h9WqArJUVh23XUysA=;
 b=j7q+VaxfdPoeXZ1mCXdz23eWij0SqR2iKCmcUPTFE6rAEsAMUNK6BSjrvRBOPysf9A
 6SxUQOmCm8xzQUd9Y3jGWTqDfa0sGhMfoUlNREulWBsKqwhPtCPvujGPSpS425EP9DiR
 ox7XYtcpIivr9jhOMFo7Bf5fHEb+9xWRT8xoH6A+ItS76HvhvFAkjLgPGGpJTpKh4Kac
 EuUHybDo4RoF82kTrlh+EeZHLihzIrEj6k6KABuZnTrrvtlrafcF+qJWRaaITBb6bqdl
 abAUVwH3EydyiB8T9BU60zrh2dxfaO6cFZo9/kJ4Oka/xYaTu72Y9dbyKLmyXpzXqskZ
 LliA==
X-Gm-Message-State: APjAAAWkvHvVkt+8G8sa3aeGxHlWt28iA+k6v62wlfNr67JTJUQVfwSZ
 8Ap68OWlFr9DCjvgaqdteWHxszolnKg=
X-Google-Smtp-Source: APXvYqyNaA14cwyaXav7z9HaHRkk/oeRZ9ERRC7eCj5euciOhKRZH2Vso0nAAVvoWqjpzMdiRsNfOw==
X-Received: by 2002:adf:f606:: with SMTP id t6mr36724053wrp.85.1575026545826; 
 Fri, 29 Nov 2019 03:22:25 -0800 (PST)
Received: from localhost (ec2-34-244-242-0.eu-west-1.compute.amazonaws.com.
 [34.244.242.0])
 by smtp.gmail.com with ESMTPSA id c17sm231270wrr.87.2019.11.29.03.22.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Nov 2019 03:22:25 -0800 (PST)
Date: Fri, 29 Nov 2019 12:22:27 +0100
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: bilalwasim676@gmail.com
Subject: Re: [PATCH v3] net/cadence_gem: Updating the GEM MAC IP to properly
 filter out multicast addresses.
Message-ID: <20191129112227.GC25295@toto>
References: <20191129102414.14060-1-bilalwasim676@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191129102414.14060-1-bilalwasim676@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org, bilal_wasim@mentor.com,
 qemu-devel@nongnu.org, alistair@alistair23.me
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Nov 29, 2019 at 03:24:14PM +0500, bilalwasim676@gmail.com wrote:
> From: bwasim <bilal_wasim@mentor.com>
> 
> The current code makes a bad assumption that the most-significant byte
> of the MAC address is used to determine if the address is multicast or
> unicast, but in reality only a single bit is used to determine this.
> This caused IPv6 to not work.. Fix is now in place and has been tested
> with ZCU102-A53 / IPv6 on a TAP interface. Works well..


Thanks Bilal,

I ran this through our internal test-suite, looks good.

Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Tested-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>

Cheers,
Edgar


> 
> Signed-off-by: Bilal Wasim <bilal_wasim@mentor.com>
> ---
>  hw/net/cadence_gem.c | 21 +++++++++++++--------
>  1 file changed, 13 insertions(+), 8 deletions(-)
> 
> diff --git a/hw/net/cadence_gem.c b/hw/net/cadence_gem.c
> index b8be73dc55..6400b3653b 100644
> --- a/hw/net/cadence_gem.c
> +++ b/hw/net/cadence_gem.c
> @@ -34,6 +34,7 @@
>  #include "qemu/module.h"
>  #include "sysemu/dma.h"
>  #include "net/checksum.h"
> +#include "net/eth.h"
>  
>  #ifdef CADENCE_GEM_ERR_DEBUG
>  #define DB_PRINT(...) do { \
> @@ -601,7 +602,7 @@ static void gem_receive_updatestats(CadenceGEMState *s, const uint8_t *packet,
>      }
>  
>      /* Error-free Multicast Frames counter */
> -    if (packet[0] == 0x01) {
> +    if (is_multicast_ether_addr(packet)) {
>          s->regs[GEM_RXMULTICNT]++;
>      }
>  
> @@ -690,21 +691,25 @@ static int gem_mac_address_filter(CadenceGEMState *s, const uint8_t *packet)
>      }
>  
>      /* Accept packets -w- hash match? */
> -    if ((packet[0] == 0x01 && (s->regs[GEM_NWCFG] & GEM_NWCFG_MCAST_HASH)) ||
> -        (packet[0] != 0x01 && (s->regs[GEM_NWCFG] & GEM_NWCFG_UCAST_HASH))) {
> +    if ((is_multicast_ether_addr(packet)
> +        && (s->regs[GEM_NWCFG] & GEM_NWCFG_MCAST_HASH)) ||
> +        (is_unicast_ether_addr(packet)
> +        && (s->regs[GEM_NWCFG] & GEM_NWCFG_UCAST_HASH))) {
>          unsigned hash_index;
>  
>          hash_index = calc_mac_hash(packet);
>          if (hash_index < 32) {
>              if (s->regs[GEM_HASHLO] & (1<<hash_index)) {
> -                return packet[0] == 0x01 ? GEM_RX_MULTICAST_HASH_ACCEPT :
> -                                           GEM_RX_UNICAST_HASH_ACCEPT;
> +                return is_multicast_ether_addr(packet) ?
> +                       GEM_RX_MULTICAST_HASH_ACCEPT :
> +                       GEM_RX_UNICAST_HASH_ACCEPT;
>              }
>          } else {
>              hash_index -= 32;
>              if (s->regs[GEM_HASHHI] & (1<<hash_index)) {
> -                return packet[0] == 0x01 ? GEM_RX_MULTICAST_HASH_ACCEPT :
> -                                           GEM_RX_UNICAST_HASH_ACCEPT;
> +                return is_multicast_ether_addr(packet) ?
> +                       GEM_RX_MULTICAST_HASH_ACCEPT :
> +                       GEM_RX_UNICAST_HASH_ACCEPT;
>              }
>          }
>      }
> @@ -1083,7 +1088,7 @@ static void gem_transmit_updatestats(CadenceGEMState *s, const uint8_t *packet,
>      }
>  
>      /* Error-free Multicast Frames counter */
> -    if (packet[0] == 0x01) {
> +    if (is_multicast_ether_addr(packet)) {
>          s->regs[GEM_TXMCNT]++;
>      }
>  
> -- 
> 2.19.1.windows.1
> 

