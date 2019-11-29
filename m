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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77142C432C0
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2019 09:18:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F0ED215A5
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2019 09:18:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NFTJsd/U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F0ED215A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56262 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iacQH-00005j-Er
	for qemu-devel@archiver.kernel.org; Fri, 29 Nov 2019 04:18:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51344)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <edgar.iglesias@gmail.com>) id 1iacLQ-00070w-Vn
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 04:13:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <edgar.iglesias@gmail.com>) id 1iacLL-0007CK-Up
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 04:13:41 -0500
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:41292)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <edgar.iglesias@gmail.com>)
 id 1iacLJ-0006sm-QH; Fri, 29 Nov 2019 04:13:39 -0500
Received: by mail-wr1-x442.google.com with SMTP id b18so34182463wrj.8;
 Fri, 29 Nov 2019 01:13:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=Bp9gaspLvU/mO035Ihq1cpxL/KjxYzr3ENlPjxRPucE=;
 b=NFTJsd/UQxD6zQ7MxLy3+MPARlkaGo33I7lcrkcJufZ5LzJWj4LWNy00tnHSaRTwc1
 mFUeDRzd1rfV285fCuqVeK/neWQrFEG2dujDF0kzsuQjFmc3f2XPRnapAxTKeKt74Zen
 DcJHgBH+gu8cqHDfIqZm+n/DSXuTHyhaalQc3u0CB0xZdlqd7t2ML3hwlmDaBD4Aw1xI
 T90sgcgfyZjTTMnHbhaPUZyhDZD9iSU/CVoZnQcARxfS45wKWxCtzpkqus3OZoIgxxT2
 I+q/7pc8Kp5W0in4/b/eIF5U1gsByQcX7dNjiGwPv2AFFhBPyJqC0RJiUfLSbiroyDYM
 nm4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=Bp9gaspLvU/mO035Ihq1cpxL/KjxYzr3ENlPjxRPucE=;
 b=WK1X9PHcBGApE3VTGIzJivWvtIM+UKP3sS8A64w/3MPYubbCOioDvVv11naGhxQ7i7
 ABs+yvrCPh89Sdklm+irwlDiwMypQkRrMyAkNRxlC3nDj+bkCwLFuE8I3PuTDds/cUz+
 K1kZXGPvStEEEXQal+jweEBDxSFHIME59VMybz4Y/pZd/NCgC6hzXmPcktaaiBky31n1
 86GC4GvDIU7KoY8cAFhw9c8KPHA3VBRis0GAPNrqWRtnjbCbkmeGCyGjaOBVimVQOHoG
 8oMme4yVZp0xPl828lWOaIpBvZ9pccpiCOUryS6Rejr6X+9mPt6xJtLPEnXFgGTaU0yq
 n97A==
X-Gm-Message-State: APjAAAXnLtJoyfVM2ztJO1+jeLDzpvEggPI8nn8Xeq01tJregMGR73ti
 YrQDvhHHC0Umo0rh19Q58a8=
X-Google-Smtp-Source: APXvYqyLMAim2hKOjYo6wVPDRBqER26eaA8LFbT47A0bRQqIY8V6+KbixhjMTksXUKy3m22wssLloQ==
X-Received: by 2002:a5d:5452:: with SMTP id w18mr3661719wrv.333.1575018810016; 
 Fri, 29 Nov 2019 01:13:30 -0800 (PST)
Received: from localhost (ec2-34-244-242-0.eu-west-1.compute.amazonaws.com.
 [34.244.242.0])
 by smtp.gmail.com with ESMTPSA id u22sm8108414wru.30.2019.11.29.01.13.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Nov 2019 01:13:29 -0800 (PST)
Date: Fri, 29 Nov 2019 10:13:32 +0100
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: bilalwasim676@gmail.com
Subject: Re: [PATCH v2] net/cadence_gem: Updating the GEM MAC IP to properly
 filter out multicast addresses.
Message-ID: <20191129091332.GA25295@toto>
References: <20191129085216.5108-1-bilalwasim676@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191129085216.5108-1-bilalwasim676@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
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

On Fri, Nov 29, 2019 at 01:52:16PM +0500, bilalwasim676@gmail.com wrote:
> From: bwasim <bilal_wasim@mentor.com>
> 
> The current code makes a bad assumption that the most-significant byte
> of the MAC address is used to determine if the address is multicast or
> unicast, but in reality only a single bit is used to determine this.
> This caused IPv6 to not work.. Fix is now in place and has been tested
> with ZCU102-A53 / IPv6 on a TAP interface. Works well..

Thanks Bilal,

Sorry, just one more thing I had missed, we need to update
gem_transmit_updatestats() aswell, in a similar way as we did with
gem_receive_updatestats().

Cheers,
Edgar


> 
> Signed-off-by: Bilal Wasim <bilal_wasim@mentor.com>
> ---
>  hw/net/cadence_gem.c | 19 ++++++++++++-------
>  1 file changed, 12 insertions(+), 7 deletions(-)
> 
> diff --git a/hw/net/cadence_gem.c b/hw/net/cadence_gem.c
> index b8be73dc55..042188c1ba 100644
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
> -- 
> 2.19.1.windows.1
> 

