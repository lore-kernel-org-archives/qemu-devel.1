Return-Path: <SRS0=wUMn=VC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC9CDC4649B
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2019 14:18:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B03CA20828
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2019 14:18:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="brtCIiZ1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B03CA20828
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53626 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hjP3C-0001lL-Ki
	for qemu-devel@archiver.kernel.org; Fri, 05 Jul 2019 10:18:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47759)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <frasse.iglesias@gmail.com>) id 1hjOyd-0007Hl-2e
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 10:14:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <frasse.iglesias@gmail.com>) id 1hjOyZ-0006ki-T6
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 10:14:14 -0400
Received: from mail-lf1-x143.google.com ([2a00:1450:4864:20::143]:47101)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <frasse.iglesias@gmail.com>)
 id 1hjOyY-0006RP-KT; Fri, 05 Jul 2019 10:14:11 -0400
Received: by mail-lf1-x143.google.com with SMTP id z15so6406384lfh.13;
 Fri, 05 Jul 2019 07:14:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to
 :user-agent; bh=cTjQuAiD+25YZq/P1/SkkzETHTlAtPOe/XGlBxCRBX8=;
 b=brtCIiZ1yevmiUisQmVYtqWA1QsMQb4353wAAmYMGnRPQ9svCzrMOAvpXo/nksgGWh
 ue6AVK2SBwFMqAI1ciEVqv0JAdOEMmsls2pTJ0sihhVfqPv0Yf200k9Ra/5jql4M96vh
 82Gpwyc8xidE5Lc/6dqWcTLZS1xgVIqT/dsBQmd0JNobBEPDozIHgT0JNZ0MOSjRLP7E
 1PQtHBv28BspFcLmkv4okH1bCzH3Mwcy4gBbhzj+PgSWDzLNzb38p8ghDRhk95JznoHh
 lgnsjLAycqRnW4mi/B7HlChXvAqHotMjzT8gDcTQ85HKEw2b6pqfDpAiB1nPY3fP4CL9
 jqWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to:user-agent;
 bh=cTjQuAiD+25YZq/P1/SkkzETHTlAtPOe/XGlBxCRBX8=;
 b=JvooEFjI2kLmtptf5405HhNrGGkclKEctFcaq6xKe1JOuqWWmM8T6yKgW1ezK4wxTj
 EdMGTveXm4me+xxvtQY7vOVdO7TOP7WWmEdhQLehVWfTpYUQ74w0pn3dj+vdd1IVXnua
 L4GXmvzKvJrkzY965VSUp3OfrgNQQZnrFT+WufnZxAxNyWfc7+kJYsBwOPPPxyyC2D56
 i+GHv8SFGSaeNCdyJixvkmJ1KZlYz5DpSxKJbgtd4BCbgxTV1AJ0KxDMMVL+V6ziLFHQ
 Q4yGKnGJvne67OdAUd/XsLnTd7TyUG+D93X39oe0/MieDk578KXRnFMgbQvlgZo4lCPR
 eaOw==
X-Gm-Message-State: APjAAAVE4SNYD4zVpiQNzK5X2pJbipynaZI2zXZkS5XtXV1RsYsVLa/n
 UBis6cL2T/ZroVi8wvobX7M=
X-Google-Smtp-Source: APXvYqzC3hCCfaWA5gXhH1GSh6AZmnW5AsetxG28tGJFItdunG+KeMplNiIsK+I5VRvAh6JZGi+2FQ==
X-Received: by 2002:ac2:5a44:: with SMTP id r4mr2149766lfn.118.1562336047265; 
 Fri, 05 Jul 2019 07:14:07 -0700 (PDT)
Received: from fralle-msi (31-208-27-151.cust.bredband2.com. [31.208.27.151])
 by smtp.gmail.com with ESMTPSA id
 u22sm1983515ljd.18.2019.07.05.07.14.06
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 05 Jul 2019 07:14:06 -0700 (PDT)
Date: Fri, 5 Jul 2019 16:14:04 +0200
From: Francisco Iglesias <frasse.iglesias@gmail.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Message-ID: <20190705141403.zdipi3ewigihm6tl@fralle-msi>
References: <20190705104255.24027-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190705104255.24027-1-philmd@redhat.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::143
Subject: Re: [Qemu-devel] [PATCH-for-4.1 v2] hw/ssi/xilinx_spips: Avoid AXI
 writes to the LQSPI linear memory
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair@alistair23.me>, qemu-devel@nongnu.org,
 Prasad J Pandit <ppandit@redhat.com>, Lei Sun <slei.casper@gmail.com>,
 qemu-arm@nongnu.org, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Philippe,

On [2019 Jul 05] Fri 12:42:55, Philippe Mathieu-Daudé wrote:
> Lei Sun found while auditing the code than a CPU write would
> trigger a NULL pointer deference.
> 
> From UG1085 datasheet [*] AXI writes in this region are ignored
> and generates an External Slave Error (SLVERR).
> 
> Fix by checking the access is a READ before calling the region
> callback.
> 
> [*] https://www.xilinx.com/support/documentation/user_guides/ug1085-zynq-ultrascale-trm.pdf
> 
> Reported-by: Lei Sun <slei.casper@gmail.com>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> ---
> v1: https://lists.gnu.org/archive/html/qemu-devel/2019-07/msg01238.html
> ---
>  hw/ssi/xilinx_spips.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/hw/ssi/xilinx_spips.c b/hw/ssi/xilinx_spips.c
> index 8115bb6d46..0c9ccd12bf 100644
> --- a/hw/ssi/xilinx_spips.c
> +++ b/hw/ssi/xilinx_spips.c
> @@ -1202,6 +1202,18 @@ static void lqspi_load_cache(void *opaque, hwaddr addr)
>      }
>  }
>  
> +static bool lqspi_accepts(void *opaque, hwaddr addr,
> +                          unsigned size, bool is_write,
> +                          MemTxAttrs attrs)
> +{
> +    /*
> +     * From UG1085, Chapter 24 (Quad-SPI controllers):
> +     * - Writes are ignored
> +     * - AXI writes generate an external AXI slave error (SLVERR)
> +     */
> +    return !is_write;

What I can see above generates an AXI Decode error (MEMTX_DECODE_ERROR),
MEMTX_ERROR is the one that maps to AXI slave error. What about swapping to the
solution you proposed yesterday? (but changing return value of the write
function to be MEMTX_ERROR)

Best regards,
Francisco Iglesias

> +}
> +
>  static uint64_t
>  lqspi_read(void *opaque, hwaddr addr, unsigned int size)
>  {
> @@ -1225,6 +1237,7 @@ static const MemoryRegionOps lqspi_ops = {
>      .read = lqspi_read,
>      .endianness = DEVICE_NATIVE_ENDIAN,
>      .valid = {
> +        .accepts = lqspi_accepts,
>          .min_access_size = 1,
>          .max_access_size = 4
>      }
> -- 
> 2.20.1
> 

