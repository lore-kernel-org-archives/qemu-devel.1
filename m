Return-Path: <SRS0=1N+K=7M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A114C433E0
	for <qemu-devel@archiver.kernel.org>; Sat, 30 May 2020 12:48:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C685320723
	for <qemu-devel@archiver.kernel.org>; Sat, 30 May 2020 12:48:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BfDj4G6a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C685320723
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57448 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jf0uJ-0006Hh-T7
	for qemu-devel@archiver.kernel.org; Sat, 30 May 2020 08:48:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47108)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jf0sI-0005JI-6V; Sat, 30 May 2020 08:46:07 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:37536)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jf0sG-0002pO-HK; Sat, 30 May 2020 08:46:05 -0400
Received: by mail-wm1-x341.google.com with SMTP id f5so6813500wmh.2;
 Sat, 30 May 2020 05:46:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:autocrypt:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=qXNVEHRGOjFobUatZvY5eXZg+tMvmK+MWcCn4qfVLQg=;
 b=BfDj4G6anjzdaLa1rfikxqvEsqVgCG5sHUjBzC0nrLdgn6nkq784S9ChuX2b1kyUyd
 gaGRoLaHpureXPyvfhluyMOIpDef+JFBvs7rMr/GvlNvGxKf4BCuMcjxoCKc1rZvYnjJ
 kmS4RNs14HVRtk/KMTp00ZopNMRCiT3C0fgp0gBkjSl2LQyKcqZp+mjFOFeGSB7pWTL7
 rYMj2vvEdU5TZtJV7NHBubyuZPHLuiqj7PrAUirCOvFQvSwC3tcxqUvxxEqanDIEOHQu
 9Hrb6Dx7z9dBy9EKTOBiMlI2/GPgAypbDFSbQ7r+v9U+ZoMTeUKKT/tWK5Pgcne0ZcsX
 Ahhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=qXNVEHRGOjFobUatZvY5eXZg+tMvmK+MWcCn4qfVLQg=;
 b=Xd/TY5y1JSiAsltzYkoRpxIWDK5vB4RdSVoWXugv6Ao3esA70/k9vCicb4ekZTvin/
 z2L+tfLUGKS8e0UEABXFNvX8XUFNNwG3cLlv+iGsl6nmlLZtPAAKYIIWTro7tLV1TOUz
 MdvbQx269E4DhEvNHZ9ckuSKJz7Yw8H9siSNauRbrkg9ndRNRDEuwz66OcEhoTYteqXW
 n5kKjB7L+sha6SxBqsjS1fMGZEDunQnu4hWPA03EDJRWBNzA9FOYeaU92lMDUjqZnRlG
 N7xMWDE3i95gUEVZhYRoxhW3wZv4EyTZmBcT08r6CLiMLzdGt4rfhq5CeC2hWRohzCRn
 XnRQ==
X-Gm-Message-State: AOAM530VPQ/YxXbhegKAa6kOxbtqKL/Fo6EtESvDSFjPlznlJjZSx6v+
 KAAVo11NkhY4EbmkPt2KZnb7RbX0
X-Google-Smtp-Source: ABdhPJw/Dcm07QBSpnE4VLeKNlgvRGe8gIxEdGTWyP7rnZsb9oi5t99w94sJgYms2trIejOQTa1TyQ==
X-Received: by 2002:a05:600c:1084:: with SMTP id
 e4mr13679097wmd.144.1590842762034; 
 Sat, 30 May 2020 05:46:02 -0700 (PDT)
Received: from [192.168.1.34] (43.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.43])
 by smtp.gmail.com with ESMTPSA id 88sm14712556wre.45.2020.05.30.05.45.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 30 May 2020 05:46:01 -0700 (PDT)
Subject: Re: [PATCH v3] hw/net/imx_fec.c: Convert debug fprintf() to trace
 event
To: Jean-Christophe Dubois <jcd@tribudubois.net>, qemu-arm@nongnu.org
References: <20200530102707.195131-1-jcd@tribudubois.net>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Autocrypt: addr=philmd@redhat.com; keydata=
 mQINBDXML8YBEADXCtUkDBKQvNsQA7sDpw6YLE/1tKHwm24A1au9Hfy/OFmkpzo+MD+dYc+7
 bvnqWAeGweq2SDq8zbzFZ1gJBd6+e5v1a/UrTxvwBk51yEkadrpRbi+r2bDpTJwXc/uEtYAB
 GvsTZMtiQVA4kRID1KCdgLa3zztPLCj5H1VZhqZsiGvXa/nMIlhvacRXdbgllPPJ72cLUkXf
 z1Zu4AkEKpccZaJspmLWGSzGu6UTZ7UfVeR2Hcc2KI9oZB1qthmZ1+PZyGZ/Dy+z+zklC0xl
 XIpQPmnfy9+/1hj1LzJ+pe3HzEodtlVA+rdttSvA6nmHKIt8Ul6b/h1DFTmUT1lN1WbAGxmg
 CH1O26cz5nTrzdjoqC/b8PpZiT0kO5MKKgiu5S4PRIxW2+RA4H9nq7nztNZ1Y39bDpzwE5Sp
 bDHzd5owmLxMLZAINtCtQuRbSOcMjZlg4zohA9TQP9krGIk+qTR+H4CV22sWldSkVtsoTaA2
 qNeSJhfHQY0TyQvFbqRsSNIe2gTDzzEQ8itsmdHHE/yzhcCVvlUzXhAT6pIN0OT+cdsTTfif
 MIcDboys92auTuJ7U+4jWF1+WUaJ8gDL69ThAsu7mGDBbm80P3vvUZ4fQM14NkxOnuGRrJxO
 qjWNJ2ZUxgyHAh5TCxMLKWZoL5hpnvx3dF3Ti9HW2dsUUWICSQARAQABtDJQaGlsaXBwZSBN
 YXRoaWV1LURhdWTDqSAoUGhpbCkgPHBoaWxtZEByZWRoYXQuY29tPokCVQQTAQgAPwIbDwYL
 CQgHAwIGFQgCCQoLBBYCAwECHgECF4AWIQSJweePYB7obIZ0lcuio/1u3q3A3gUCXsfWwAUJ
 KtymWgAKCRCio/1u3q3A3ircD/9Vjh3aFNJ3uF3hddeoFg1H038wZr/xi8/rX27M1Vj2j9VH
 0B8Olp4KUQw/hyO6kUxqkoojmzRpmzvlpZ0cUiZJo2bQIWnvScyHxFCv33kHe+YEIqoJlaQc
 JfKYlbCoubz+02E2A6bFD9+BvCY0LBbEj5POwyKGiDMjHKCGuzSuDRbCn0Mz4kCa7nFMF5Jv
 piC+JemRdiBd6102ThqgIsyGEBXuf1sy0QIVyXgaqr9O2b/0VoXpQId7yY7OJuYYxs7kQoXI
 6WzSMpmuXGkmfxOgbc/L6YbzB0JOriX0iRClxu4dEUg8Bs2pNnr6huY2Ft+qb41RzCJvvMyu
 gS32LfN0bTZ6Qm2A8ayMtUQgnwZDSO23OKgQWZVglGliY3ezHZ6lVwC24Vjkmq/2yBSLakZE
 6DZUjZzCW1nvtRK05ebyK6tofRsx8xB8pL/kcBb9nCuh70aLR+5cmE41X4O+MVJbwfP5s/RW
 9BFSL3qgXuXso/3XuWTQjJJGgKhB6xXjMmb1J4q/h5IuVV4juv1Fem9sfmyrh+Wi5V1IzKI7
 RPJ3KVb937eBgSENk53P0gUorwzUcO+ASEo3Z1cBKkJSPigDbeEjVfXQMzNt0oDRzpQqH2vp
 apo2jHnidWt8BsckuWZpxcZ9+/9obQ55DyVQHGiTN39hkETy3Emdnz1JVHTU0Q==
Message-ID: <347442c4-e1f4-57eb-937f-c551e36b7cb8@amsat.org>
Date: Sat, 30 May 2020 14:45:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200530102707.195131-1-jcd@tribudubois.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x341.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
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
Cc: peter.maydell@linaro.org, peter.chubb@nicta.com.au, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/30/20 12:27 PM, Jean-Christophe Dubois wrote:
> Signed-off-by: Jean-Christophe Dubois <jcd@tribudubois.net>
> ---
> 
>  v2: fix coding style issues.
>  v3: improve tracing code based on feedback
>      * change some tracing function names
>      * remove unnecessary cast
>      * add register index in addition to name

Thanks for the changes!

> 
>  hw/net/imx_fec.c    | 106 +++++++++++++++++++-------------------------
>  hw/net/trace-events |  18 ++++++++
>  2 files changed, 63 insertions(+), 61 deletions(-)
> 
> diff --git a/hw/net/imx_fec.c b/hw/net/imx_fec.c
> index 7adcc9df654..eefedc252de 100644
> --- a/hw/net/imx_fec.c
> +++ b/hw/net/imx_fec.c
> @@ -31,34 +31,11 @@
>  #include "qemu/module.h"
>  #include "net/checksum.h"
>  #include "net/eth.h"
> +#include "trace.h"
>  
>  /* For crc32 */
>  #include <zlib.h>
>  
> -#ifndef DEBUG_IMX_FEC
> -#define DEBUG_IMX_FEC 0
> -#endif
> -
> -#define FEC_PRINTF(fmt, args...) \
> -    do { \
> -        if (DEBUG_IMX_FEC) { \
> -            fprintf(stderr, "[%s]%s: " fmt , TYPE_IMX_FEC, \
> -                                             __func__, ##args); \
> -        } \
> -    } while (0)
> -
> -#ifndef DEBUG_IMX_PHY
> -#define DEBUG_IMX_PHY 0
> -#endif
> -
> -#define PHY_PRINTF(fmt, args...) \
> -    do { \
> -        if (DEBUG_IMX_PHY) { \
> -            fprintf(stderr, "[%s.phy]%s: " fmt , TYPE_IMX_FEC, \
> -                                                 __func__, ##args); \
> -        } \
> -    } while (0)
> -
>  #define IMX_MAX_DESC    1024
>  
>  static const char *imx_default_reg_name(IMXFECState *s, uint32_t index)
> @@ -262,43 +239,45 @@ static void imx_eth_update(IMXFECState *s);
>   * For now we don't handle any GPIO/interrupt line, so the OS will
>   * have to poll for the PHY status.
>   */
> -static void phy_update_irq(IMXFECState *s)
> +static void imx_phy_update_irq(IMXFECState *s)
>  {
>      imx_eth_update(s);
>  }
>  
> -static void phy_update_link(IMXFECState *s)
> +static void imx_phy_update_link(IMXFECState *s)
>  {
>      /* Autonegotiation status mirrors link status.  */
>      if (qemu_get_queue(s->nic)->link_down) {
> -        PHY_PRINTF("link is down\n");
> +        trace_imx_phy_update_link("down");
>          s->phy_status &= ~0x0024;
>          s->phy_int |= PHY_INT_DOWN;
>      } else {
> -        PHY_PRINTF("link is up\n");
> +        trace_imx_phy_update_link("up");
>          s->phy_status |= 0x0024;
>          s->phy_int |= PHY_INT_ENERGYON;
>          s->phy_int |= PHY_INT_AUTONEG_COMPLETE;
>      }
> -    phy_update_irq(s);
> +    imx_phy_update_irq(s);
>  }
>  
>  static void imx_eth_set_link(NetClientState *nc)
>  {
> -    phy_update_link(IMX_FEC(qemu_get_nic_opaque(nc)));
> +    imx_phy_update_link(IMX_FEC(qemu_get_nic_opaque(nc)));
>  }
>  
> -static void phy_reset(IMXFECState *s)
> +static void imx_phy_reset(IMXFECState *s)
>  {
> +    trace_imx_phy_reset();
> +
>      s->phy_status = 0x7809;
>      s->phy_control = 0x3000;
>      s->phy_advertise = 0x01e1;
>      s->phy_int_mask = 0;
>      s->phy_int = 0;
> -    phy_update_link(s);
> +    imx_phy_update_link(s);
>  }
>  
> -static uint32_t do_phy_read(IMXFECState *s, int reg)
> +static uint32_t imx_phy_read(IMXFECState *s, int reg)
>  {
>      uint32_t val;
>  
> @@ -332,7 +311,7 @@ static uint32_t do_phy_read(IMXFECState *s, int reg)
>      case 29:    /* Interrupt source.  */
>          val = s->phy_int;
>          s->phy_int = 0;
> -        phy_update_irq(s);
> +        imx_phy_update_irq(s);
>          break;
>      case 30:    /* Interrupt mask */
>          val = s->phy_int_mask;
> @@ -352,14 +331,14 @@ static uint32_t do_phy_read(IMXFECState *s, int reg)
>          break;
>      }
>  
> -    PHY_PRINTF("read 0x%04x @ %d\n", val, reg);
> +    trace_imx_phy_read(val, reg);
>  
>      return val;
>  }
>  
> -static void do_phy_write(IMXFECState *s, int reg, uint32_t val)
> +static void imx_phy_write(IMXFECState *s, int reg, uint32_t val)
>  {
> -    PHY_PRINTF("write 0x%04x @ %d\n", val, reg);
> +    trace_imx_phy_write(val, reg);
>  
>      if (reg > 31) {
>          /* we only advertise one phy */
> @@ -369,7 +348,7 @@ static void do_phy_write(IMXFECState *s, int reg, uint32_t val)
>      switch (reg) {
>      case 0:     /* Basic Control */
>          if (val & 0x8000) {
> -            phy_reset(s);
> +            imx_phy_reset(s);
>          } else {
>              s->phy_control = val & 0x7980;
>              /* Complete autonegotiation immediately.  */
> @@ -383,7 +362,7 @@ static void do_phy_write(IMXFECState *s, int reg, uint32_t val)
>          break;
>      case 30:    /* Interrupt mask */
>          s->phy_int_mask = val & 0xff;
> -        phy_update_irq(s);
> +        imx_phy_update_irq(s);
>          break;
>      case 17:
>      case 18:
> @@ -402,6 +381,8 @@ static void do_phy_write(IMXFECState *s, int reg, uint32_t val)
>  static void imx_fec_read_bd(IMXFECBufDesc *bd, dma_addr_t addr)
>  {
>      dma_memory_read(&address_space_memory, addr, bd, sizeof(*bd));
> +
> +    trace_imx_fec_read_bd(addr, bd->flags, bd->length, bd->data);
>  }
>  
>  static void imx_fec_write_bd(IMXFECBufDesc *bd, dma_addr_t addr)
> @@ -412,6 +393,9 @@ static void imx_fec_write_bd(IMXFECBufDesc *bd, dma_addr_t addr)
>  static void imx_enet_read_bd(IMXENETBufDesc *bd, dma_addr_t addr)
>  {
>      dma_memory_read(&address_space_memory, addr, bd, sizeof(*bd));
> +
> +    trace_imx_enet_read_bd(addr, bd->flags, bd->length, bd->data,
> +                   bd->option, bd->status);
>  }
>  
>  static void imx_enet_write_bd(IMXENETBufDesc *bd, dma_addr_t addr)
> @@ -471,11 +455,11 @@ static void imx_fec_do_tx(IMXFECState *s)
>          int len;
>  
>          imx_fec_read_bd(&bd, addr);
> -        FEC_PRINTF("tx_bd %x flags %04x len %d data %08x\n",
> -                   addr, bd.flags, bd.length, bd.data);
>          if ((bd.flags & ENET_BD_R) == 0) {
> +
>              /* Run out of descriptors to transmit.  */
> -            FEC_PRINTF("tx_bd ran out of descriptors to transmit\n");
> +            trace_imx_eth_tx_bd_busy();
> +
>              break;
>          }
>          len = bd.length;
> @@ -552,11 +536,11 @@ static void imx_enet_do_tx(IMXFECState *s, uint32_t index)
>          int len;
>  
>          imx_enet_read_bd(&bd, addr);
> -        FEC_PRINTF("tx_bd %x flags %04x len %d data %08x option %04x "
> -                   "status %04x\n", addr, bd.flags, bd.length, bd.data,
> -                   bd.option, bd.status);
>          if ((bd.flags & ENET_BD_R) == 0) {
>              /* Run out of descriptors to transmit.  */
> +
> +            trace_imx_eth_tx_bd_busy();
> +
>              break;
>          }
>          len = bd.length;
> @@ -633,7 +617,7 @@ static void imx_eth_enable_rx(IMXFECState *s, bool flush)
>      s->regs[ENET_RDAR] = (bd.flags & ENET_BD_E) ? ENET_RDAR_RDAR : 0;
>  
>      if (!s->regs[ENET_RDAR]) {
> -        FEC_PRINTF("RX buffer full\n");
> +        trace_imx_eth_rx_bd_full();
>      } else if (flush) {
>          qemu_flush_queued_packets(qemu_get_queue(s->nic));
>      }
> @@ -676,7 +660,7 @@ static void imx_eth_reset(DeviceState *d)
>      memset(s->tx_descriptor, 0, sizeof(s->tx_descriptor));
>  
>      /* We also reset the PHY */
> -    phy_reset(s);
> +    imx_phy_reset(s);
>  }
>  
>  static uint32_t imx_default_read(IMXFECState *s, uint32_t index)
> @@ -774,8 +758,7 @@ static uint64_t imx_eth_read(void *opaque, hwaddr offset, unsigned size)
>          break;
>      }
>  
> -    FEC_PRINTF("reg[%s] => 0x%" PRIx32 "\n", imx_eth_reg_name(s, index),
> -                                              value);
> +    trace_imx_eth_read(index, imx_eth_reg_name(s, index), value);
>  
>      return value;
>  }
> @@ -884,8 +867,7 @@ static void imx_eth_write(void *opaque, hwaddr offset, uint64_t value,
>      const bool single_tx_ring = !imx_eth_is_multi_tx_ring(s);
>      uint32_t index = offset >> 2;
>  
> -    FEC_PRINTF("reg[%s] <= 0x%" PRIx32 "\n", imx_eth_reg_name(s, index),
> -                (uint32_t)value);
> +    trace_imx_eth_write(index, imx_eth_reg_name(s, index), value);
>  
>      switch (index) {
>      case ENET_EIR:
> @@ -940,12 +922,12 @@ static void imx_eth_write(void *opaque, hwaddr offset, uint64_t value,
>          if (extract32(value, 29, 1)) {
>              /* This is a read operation */
>              s->regs[ENET_MMFR] = deposit32(s->regs[ENET_MMFR], 0, 16,
> -                                           do_phy_read(s,
> +                                           imx_phy_read(s,
>                                                         extract32(value,
>                                                                   18, 10)));
>          } else {
>              /* This a write operation */
> -            do_phy_write(s, extract32(value, 18, 10), extract32(value, 0, 16));
> +            imx_phy_write(s, extract32(value, 18, 10), extract32(value, 0, 16));
>          }
>          /* raise the interrupt as the PHY operation is done */
>          s->regs[ENET_EIR] |= ENET_INT_MII;
> @@ -1053,8 +1035,6 @@ static bool imx_eth_can_receive(NetClientState *nc)
>  {
>      IMXFECState *s = IMX_FEC(qemu_get_nic_opaque(nc));
>  
> -    FEC_PRINTF("\n");
> -
>      return !!s->regs[ENET_RDAR];
>  }
>  
> @@ -1071,7 +1051,7 @@ static ssize_t imx_fec_receive(NetClientState *nc, const uint8_t *buf,
>      unsigned int buf_len;
>      size_t size = len;
>  
> -    FEC_PRINTF("len %d\n", (int)size);
> +    trace_imx_fec_receive(size);
>  
>      if (!s->regs[ENET_RDAR]) {
>          qemu_log_mask(LOG_GUEST_ERROR, "[%s]%s: Unexpected packet\n",
> @@ -1113,7 +1093,7 @@ static ssize_t imx_fec_receive(NetClientState *nc, const uint8_t *buf,
>          bd.length = buf_len;
>          size -= buf_len;
>  
> -        FEC_PRINTF("rx_bd 0x%x length %d\n", addr, bd.length);
> +        trace_imx_fec_receive_len(addr, bd.length);
>  
>          /* The last 4 bytes are the CRC.  */
>          if (size < 4) {
> @@ -1131,7 +1111,9 @@ static ssize_t imx_fec_receive(NetClientState *nc, const uint8_t *buf,
>          if (size == 0) {
>              /* Last buffer in frame.  */
>              bd.flags |= flags | ENET_BD_L;
> -            FEC_PRINTF("rx frame flags %04x\n", bd.flags);
> +
> +            trace_imx_fec_receive_last(bd.flags);
> +
>              s->regs[ENET_EIR] |= ENET_INT_RXF;
>          } else {
>              s->regs[ENET_EIR] |= ENET_INT_RXB;
> @@ -1164,7 +1146,7 @@ static ssize_t imx_enet_receive(NetClientState *nc, const uint8_t *buf,
>      size_t size = len;
>      bool shift16 = s->regs[ENET_RACC] & ENET_RACC_SHIFT16;
>  
> -    FEC_PRINTF("len %d\n", (int)size);
> +    trace_imx_enet_receive(size);
>  
>      if (!s->regs[ENET_RDAR]) {
>          qemu_log_mask(LOG_GUEST_ERROR, "[%s]%s: Unexpected packet\n",
> @@ -1210,7 +1192,7 @@ static ssize_t imx_enet_receive(NetClientState *nc, const uint8_t *buf,
>          bd.length = buf_len;
>          size -= buf_len;
>  
> -        FEC_PRINTF("rx_bd 0x%x length %d\n", addr, bd.length);
> +        trace_imx_enet_receive_len(addr, bd.length);
>  
>          /* The last 4 bytes are the CRC.  */
>          if (size < 4) {
> @@ -1246,7 +1228,9 @@ static ssize_t imx_enet_receive(NetClientState *nc, const uint8_t *buf,
>          if (size == 0) {
>              /* Last buffer in frame.  */
>              bd.flags |= flags | ENET_BD_L;
> -            FEC_PRINTF("rx frame flags %04x\n", bd.flags);
> +
> +            trace_imx_enet_receive_last(bd.flags);
> +
>              /* Indicate that we've updated the last buffer descriptor. */
>              bd.last_buffer = ENET_BD_BDU;
>              if (bd.option & ENET_BD_RX_INT) {
> diff --git a/hw/net/trace-events b/hw/net/trace-events
> index e18f883cfd4..430ee36b257 100644
> --- a/hw/net/trace-events
> +++ b/hw/net/trace-events
> @@ -408,3 +408,21 @@ i82596_receive_packet(size_t sz) "len=%zu"
>  i82596_new_mac(const char *id_with_mac) "New MAC for: %s"
>  i82596_set_multicast(uint16_t count) "Added %d multicast entries"
>  i82596_channel_attention(void *s) "%p: Received CHANNEL ATTENTION"
> +
> +# imx_fec.c
> +imx_phy_read(uint32_t val, int reg) "0x%04x <= reg[%d]"
> +imx_phy_write(uint32_t val, int reg) "0x%04x => reg[%d]"
> +imx_phy_update_link(const char *s) "%s"
> +imx_phy_reset(void) ""
> +imx_fec_read_bd(uint64_t addr, int flags, int len, int data) "tx_bd 0x%lx flags 0x%04x len %d data 0x%08x"
> +imx_enet_read_bd(uint64_t addr, int flags, int len, int data, int options, int status) "tx_bd 0x%lx flags 0x%04x len %d data 0x%08x option 0x%04x status 0x%04x"
> +imx_eth_tx_bd_busy(void) "tx_bd ran out of descriptors to transmit"
> +imx_eth_rx_bd_full(void) "RX buffer is full"
> +imx_eth_read(int reg, const char *reg_name, uint32_t value) "reg[%d:%s] => 0x%08x"
> +imx_eth_write(int reg, const char *reg_name, uint64_t value) "reg[%d:%s] <= 0x%08lx"
> +imx_fec_receive(size_t size) "len %ld"
> +imx_fec_receive_len(uint64_t addr, int len) "rx_bd 0x%lx length %d"
> +imx_fec_receive_last(int last) "rx frame flags 0x%04x"
> +imx_enet_receive(size_t size) "len %ld"
> +imx_enet_receive_len(uint64_t addr, int len) "rx_bd 0x%lx length %d"
> +imx_enet_receive_last(int last) "rx frame flags 0x%04x"
> 

Format string is incorrect on 32-bit host:

  CC      hw/net/imx_fec.o
In file included from hw/net/imx_fec.c:34:0:
hw/net/trace.h: In function '_nocheck__trace_imx_fec_read_bd':
hw/net/trace.h:9208:18: error: format '%lx' expects argument of type
'long unsigned int', but argument 5 has type 'uint64_t {aka long long
unsigned int}' [-Werror=format=]
         qemu_log("%d@%zu.%06zu:imx_fec_read_bd " "tx_bd 0x%lx flags
0x%04x len %d data 0x%08x" "\n",
                  ^
hw/net/trace.h: In function '_nocheck__trace_imx_enet_read_bd':
hw/net/trace.h:9231:18: error: format '%lx' expects argument of type
'long unsigned int', but argument 5 has type 'uint64_t {aka long long
unsigned int}' [-Werror=format=]
         qemu_log("%d@%zu.%06zu:imx_enet_read_bd " "tx_bd 0x%lx flags
0x%04x len %d data 0x%08x option 0x%04x status 0x%04x" "\n",
                  ^
hw/net/trace.h: In function '_nocheck__trace_imx_eth_write':
hw/net/trace.h:9323:18: error: format '%lx' expects argument of type
'long unsigned int', but argument 7 has type 'uint64_t {aka long long
unsigned int}' [-Werror=format=]
         qemu_log("%d@%zu.%06zu:imx_eth_write " "reg[%d:%s] <= 0x%08lx"
"\n",
                  ^
hw/net/trace.h: In function '_nocheck__trace_imx_fec_receive':
hw/net/trace.h:9346:18: error: format '%ld' expects argument of type
'long int', but argument 5 has type 'size_t {aka unsigned int}'
[-Werror=format=]
         qemu_log("%d@%zu.%06zu:imx_fec_receive " "len %ld" "\n",
                  ^
hw/net/trace.h: In function '_nocheck__trace_imx_fec_receive_len':
hw/net/trace.h:9369:18: error: format '%lx' expects argument of type
'long unsigned int', but argument 5 has type 'uint64_t {aka long long
unsigned int}' [-Werror=format=]
         qemu_log("%d@%zu.%06zu:imx_fec_receive_len " "rx_bd 0x%lx
length %d" "\n",
                  ^
hw/net/trace.h: In function '_nocheck__trace_imx_enet_receive':
hw/net/trace.h:9415:18: error: format '%ld' expects argument of type
'long int', but argument 5 has type 'size_t {aka unsigned int}'
[-Werror=format=]
         qemu_log("%d@%zu.%06zu:imx_enet_receive " "len %ld" "\n",
                  ^
hw/net/trace.h: In function '_nocheck__trace_imx_enet_receive_len':
hw/net/trace.h:9438:18: error: format '%lx' expects argument of type
'long unsigned int', but argument 5 has type 'uint64_t {aka long long
unsigned int}' [-Werror=format=]
         qemu_log("%d@%zu.%06zu:imx_enet_receive_len " "rx_bd 0x%lx
length %d" "\n",
                  ^

This build using:

-- >8 --
--- a/hw/net/trace-events
+++ b/hw/net/trace-events
@@ -410,19 +410,19 @@ i82596_set_multicast(uint16_t count) "Added %d
multicast entries"
 i82596_channel_attention(void *s) "%p: Received CHANNEL ATTENTION"

 # imx_fec.c
-imx_phy_read(uint32_t val, int reg) "0x%04x <= reg[%d]"
-imx_phy_write(uint32_t val, int reg) "0x%04x => reg[%d]"
+imx_phy_read(uint32_t val, int reg) "0x%04"PRIx32" <= reg[%d]"
+imx_phy_write(uint32_t val, int reg) "0x%04"PRIx32" => reg[%d]"
 imx_phy_update_link(const char *s) "%s"
 imx_phy_reset(void) ""
-imx_fec_read_bd(uint64_t addr, int flags, int len, int data) "tx_bd
0x%lx flags 0x%04x len %d data 0x%08x"
-imx_enet_read_bd(uint64_t addr, int flags, int len, int data, int
options, int status) "tx_bd 0x%lx flags 0x%04x len %d data 0x%08x option
0x%04x status 0x%04x"
+imx_fec_read_bd(uint64_t addr, int flags, int len, int data) "tx_bd
0x%"PRIx64" flags 0x%04x len %d data 0x%08x"
+imx_enet_read_bd(uint64_t addr, int flags, int len, int data, int
options, int status) "tx_bd 0x%"PRIx64" flags 0x%04x len %d data 0x%08x
option 0x%04x status 0x%04x"
 imx_eth_tx_bd_busy(void) "tx_bd ran out of descriptors to transmit"
 imx_eth_rx_bd_full(void) "RX buffer is full"
-imx_eth_read(int reg, const char *reg_name, uint32_t value) "reg[%d:%s]
=> 0x%08x"
-imx_eth_write(int reg, const char *reg_name, uint64_t value)
"reg[%d:%s] <= 0x%08lx"
-imx_fec_receive(size_t size) "len %ld"
-imx_fec_receive_len(uint64_t addr, int len) "rx_bd 0x%lx length %d"
+imx_eth_read(int reg, const char *reg_name, uint32_t value) "reg[%d:%s]
=> 0x%08"PRIx32
+imx_eth_write(int reg, const char *reg_name, uint64_t value)
"reg[%d:%s] <= 0x%08"PRIx64
+imx_fec_receive(size_t size) "len %zu"
+imx_fec_receive_len(uint64_t addr, int len) "rx_bd 0x%"PRIx64" length %d"
 imx_fec_receive_last(int last) "rx frame flags 0x%04x"
-imx_enet_receive(size_t size) "len %ld"
-imx_enet_receive_len(uint64_t addr, int len) "rx_bd 0x%lx length %d"
+imx_enet_receive(size_t size) "len %zu"
+imx_enet_receive_len(uint64_t addr, int len) "rx_bd 0x%"PRIx64" length %d"
 imx_enet_receive_last(int last) "rx frame flags 0x%04x"
---

So:
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Tested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

I changed
 "x" -> PRIx32
 "lx" -> PRIx64
 "ld" -> "zu" for size_t type.

Since the patch is already done locally, I'll simply post it as v4.

Regards,

Phil.

