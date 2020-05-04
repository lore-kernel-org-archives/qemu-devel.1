Return-Path: <SRS0=Vgkn=6S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8ADCAC3A5A9
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 15:47:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 539BA2063A
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 15:47:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HuVtTNzu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 539BA2063A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49004 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVdK1-0003wQ-DL
	for qemu-devel@archiver.kernel.org; Mon, 04 May 2020 11:47:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60998)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1jVd6D-0002XK-Dc; Mon, 04 May 2020 11:33:41 -0400
Received: from mail-lj1-x242.google.com ([2a00:1450:4864:20::242]:45132)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1jVd6C-0000NY-AT; Mon, 04 May 2020 11:33:41 -0400
Received: by mail-lj1-x242.google.com with SMTP id h4so10093906ljg.12;
 Mon, 04 May 2020 08:33:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=Mmsxnx3sLFnb7ifma6tJvRbX0iKMzwxA9neai4apcBM=;
 b=HuVtTNzulah/SOU4QPIK5hJ+V0rvpzd/oBi3KlmJ7CgAM4cCFeOClla2AgdfDmM5Ry
 jYFRIsPOSh4jgH14vYKqJLDG4PBK3UW5DnzYmqzkQetrs2uWZp70XgYndEqhwyyRwnic
 pE6/WJeXpiE2ngGdjdYH4mCdf1WHVUfl6m/aHLa6Y5LLr0Gt2FV3K5T20OFqel3NEJiN
 LCQi2PiPX07XP35V+RR4cwOLT+upOSu6cZHEQyBYHwZEqa9Emgrjb+0DP306qsEyezMz
 23pHx2YwYLwQ/XM2XF5YnLZkV7ZfE3JITQxvkwDLhJXHaKRGgPMkU9T/yB0+JK/dVUCv
 JZ1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=Mmsxnx3sLFnb7ifma6tJvRbX0iKMzwxA9neai4apcBM=;
 b=sDWNDuc0C8I0YERnbs3Oe3NVb6fpxHynyorrK+FmLDLHtn9zO66IdVzZI6R5T4UhRM
 zgjpIJo3ZLq7i8aLxpKX0kg9nhouzr9YA3Mzq+R2FE5B3Lz5m+TWcifz5GfM7+Kol9mH
 UWtovv7k/cDMTCeqime6tI+/6GGQyzC/+Cm++4iFINB4447F3Sawu5/svzop7rsO1exG
 +NJqRgXb43U+8p8Gkb1S/sQTLvY51dZ0A5wByP8uPPmGIULkv2xlxc7IYNNq4ey2wEh9
 utEiEUwBG88B1ui71hJr6s40MSQnWFx5rIfiXmaCo4l8Z5n0FYPMjgnzFRonrTKC3yDX
 zkoA==
X-Gm-Message-State: AGi0PuZEr96w43gFV0DvuBv36INPLXcCgoxcTEJOW+aDudQcoVefYZ84
 5A1BdmR+93scrPKpX7VsXKGqJVUR+sc=
X-Google-Smtp-Source: APiQypJit61ZkB86QI/bRvGwV9WjqqVKHYmgKmDXb/nEjgPmAhnnxirOKmM3tHNRuI7uaqTYkeO6/Q==
X-Received: by 2002:a05:651c:1104:: with SMTP id
 d4mr10561276ljo.128.1588606416986; 
 Mon, 04 May 2020 08:33:36 -0700 (PDT)
Received: from localhost (81-231-232-130-no39.tbcn.telia.com. [81.231.232.130])
 by smtp.gmail.com with ESMTPSA id q6sm8640679ljg.67.2020.05.04.08.33.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 May 2020 08:33:35 -0700 (PDT)
Date: Mon, 4 May 2020 17:33:34 +0200
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>
Subject: Re: [PATCH v2 10/10] net: cadence_gem: Fix RX address filtering
Message-ID: <20200504153334.GJ5519@toto>
References: <1588601168-27576-1-git-send-email-sai.pavan.boddu@xilinx.com>
 <1588601168-27576-11-git-send-email-sai.pavan.boddu@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1588601168-27576-11-git-send-email-sai.pavan.boddu@xilinx.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Received-SPF: pass client-ip=2a00:1450:4864:20::242;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-lj1-x242.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Jason Wang <jasowang@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, Tong Ho <tong.ho@xilinx.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>,
 Ramon Fried <rfried.dev@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, May 04, 2020 at 07:36:08PM +0530, Sai Pavan Boddu wrote:
> From: Tong Ho <tong.ho@xilinx.com>
> 
> Two defects are fixed:
> 
> 1/ Detection of multicast frames
> 2/ Treating drop of mis-addressed frames as non-error


Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>


> 
> Signed-off-by: Tong Ho <tong.ho@xilinx.com>
> Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
> Signed-off-by: Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>
> ---
>  hw/net/cadence_gem.c | 26 +++++++++++---------------
>  1 file changed, 11 insertions(+), 15 deletions(-)
> 
> diff --git a/hw/net/cadence_gem.c b/hw/net/cadence_gem.c
> index f0bf2e7..112794a 100644
> --- a/hw/net/cadence_gem.c
> +++ b/hw/net/cadence_gem.c
> @@ -34,6 +34,7 @@
>  #include "qemu/module.h"
>  #include "sysemu/dma.h"
>  #include "net/checksum.h"
> +#include "net/eth.h"
>  
>  #define CADENCE_GEM_ERR_DEBUG 0
>  #define DB_PRINT(...) do {\
> @@ -669,7 +670,7 @@ static unsigned calc_mac_hash(const uint8_t *mac)
>  static int gem_mac_address_filter(CadenceGEMState *s, const uint8_t *packet)
>  {
>      uint8_t *gem_spaddr;
> -    int i;
> +    int i, is_mc;
>  
>      /* Promiscuous mode? */
>      if (s->regs[GEM_NWCFG] & GEM_NWCFG_PROMISC) {
> @@ -685,22 +686,17 @@ static int gem_mac_address_filter(CadenceGEMState *s, const uint8_t *packet)
>      }
>  
>      /* Accept packets -w- hash match? */
> -    if ((packet[0] == 0x01 && (s->regs[GEM_NWCFG] & GEM_NWCFG_MCAST_HASH)) ||
> -        (packet[0] != 0x01 && (s->regs[GEM_NWCFG] & GEM_NWCFG_UCAST_HASH))) {
> +    is_mc = is_multicast_ether_addr(packet);
> +    if ((is_mc && (s->regs[GEM_NWCFG] & GEM_NWCFG_MCAST_HASH)) ||
> +        (!is_mc && (s->regs[GEM_NWCFG] & GEM_NWCFG_UCAST_HASH))) {
> +        uint64_t buckets;
>          unsigned hash_index;
>  
>          hash_index = calc_mac_hash(packet);
> -        if (hash_index < 32) {
> -            if (s->regs[GEM_HASHLO] & (1<<hash_index)) {
> -                return packet[0] == 0x01 ? GEM_RX_MULTICAST_HASH_ACCEPT :
> -                                           GEM_RX_UNICAST_HASH_ACCEPT;
> -            }
> -        } else {
> -            hash_index -= 32;
> -            if (s->regs[GEM_HASHHI] & (1<<hash_index)) {
> -                return packet[0] == 0x01 ? GEM_RX_MULTICAST_HASH_ACCEPT :
> -                                           GEM_RX_UNICAST_HASH_ACCEPT;
> -            }
> +        buckets = ((uint64_t)s->regs[GEM_HASHHI] << 32) | s->regs[GEM_HASHLO];
> +        if ((buckets >> hash_index) & 1) {
> +            return is_mc ? GEM_RX_MULTICAST_HASH_ACCEPT
> +                         : GEM_RX_UNICAST_HASH_ACCEPT;
>          }
>      }
>  
> @@ -924,7 +920,7 @@ static ssize_t gem_receive(NetClientState *nc, const uint8_t *buf, size_t size)
>      /* Is this destination MAC address "for us" ? */
>      maf = gem_mac_address_filter(s, buf);
>      if (maf == GEM_RX_REJECT) {
> -        return -1;
> +        return size;  /* no, drop siliently b/c it's not an error */
>      }
>  
>      /* Discard packets with receive length error enabled ? */
> -- 
> 2.7.4
> 

