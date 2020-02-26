Return-Path: <SRS0=zj/5=4O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72A02C4BA10
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 14:16:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 410692467B
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 14:16:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HqTl5J/u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 410692467B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45006 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6xU0-0002nW-GJ
	for qemu-devel@archiver.kernel.org; Wed, 26 Feb 2020 09:16:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39253)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <frasse.iglesias@gmail.com>) id 1j6xT2-0002GI-LI
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 09:15:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <frasse.iglesias@gmail.com>) id 1j6xT1-0006Pq-LQ
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 09:15:16 -0500
Received: from mail-lj1-x242.google.com ([2a00:1450:4864:20::242]:39256)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <frasse.iglesias@gmail.com>)
 id 1j6xT1-0006M7-Ck; Wed, 26 Feb 2020 09:15:15 -0500
Received: by mail-lj1-x242.google.com with SMTP id o15so3269726ljg.6;
 Wed, 26 Feb 2020 06:15:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to
 :user-agent; bh=NoslDEA1NYRcm1J+wN+Jn1HI8r/5R/eVtS142rhhQFs=;
 b=HqTl5J/uPPcs0qaM5njuye4hzxOdSC1vWGrvpjs0BhvN5EWTxf3R10eK8PcouY19Yv
 gdTYtsNHZBoB+EQy++X8VbK05yJkPd2jgptcG1Lz/N+OzvIwF8RMwQFvB8hpy7Sy2oK7
 QS7y4eg7KxaKWPfTgKxdFA5ra+t2tTTBUOyfc8YYhG7BPOHsbioGpCESwPBF75Zj/Sfv
 RoTP0AqCbK5K11y214nwpwMsGnQzkwaO0w2kPTkuefYAugs9T/X9OQXKM4ttYcyWK5Tz
 mgThrUsGTMDkuVqCbJ5g7WOqnvVG5jQ6GElfquwPY+52nZQb2jlkHOUIahHFJaa1oHWn
 o9/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to:user-agent;
 bh=NoslDEA1NYRcm1J+wN+Jn1HI8r/5R/eVtS142rhhQFs=;
 b=lbInv0OOtpGuPs8l8QssE1d9BAjmTqmmdqBiTVV5ho6dh4iBHY3aAhk7rPidNVzVKa
 K1FmgfT7vN/wYsKpAFix3Yt4a8T72UvmryV6w8gBH2rpzcGRE/KyFSj5hO8K93jB52xq
 U6JG4pvU5F0pdzYy7aF0izENevGrbuWzaeiXSfaOO52jzrPkx3bNKbut4AdjheoaxmFR
 pdSXlgQDukujOl/xbOLTeVCUsTZK1ClJl8qGu3G3IljwLF2ZhqUpJS35Tf4+Inb/C/Sr
 yHkWo7ncn4nNbm2pTlsS9Cwe5n7SSx4vS2iTd1V7U3PVCKqE2K75iheT7Ca/sKrdsa02
 j+Xg==
X-Gm-Message-State: ANhLgQ3Ih163Ovk73ZEK/flwl5dioveMHCAwoRRR5R8pTzY8P9tZ/LM6
 33210sdDL+MHcj8Nrvaq2UM=
X-Google-Smtp-Source: ADFU+vtljQR17EBpwj1G4m2tKaU9Ndw06+2ySLjKbkAE/iEcWtDTkn468EwTzGv445HNY9AkcZBGEw==
X-Received: by 2002:a2e:9e55:: with SMTP id g21mr3218379ljk.245.1582726513738; 
 Wed, 26 Feb 2020 06:15:13 -0800 (PST)
Received: from fralle-msi (31-208-27-151.cust.bredband2.com. [31.208.27.151])
 by smtp.gmail.com with ESMTPSA id
 l7sm1068670lfc.80.2020.02.26.06.15.11
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 26 Feb 2020 06:15:12 -0800 (PST)
Date: Wed, 26 Feb 2020 15:15:10 +0100
From: Francisco Iglesias <frasse.iglesias@gmail.com>
To: kuhn.chenqun@huawei.com
Subject: Re: [PATCH v2 09/13] dma/xlnx-zdma: Remove redundant statement in
 zdma_write_dst()
Message-ID: <20200226141509.6kg3eyrexv73mgop@fralle-msi>
References: <20200226084647.20636-1-kuhn.chenqun@huawei.com>
 <20200226084647.20636-10-kuhn.chenqun@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200226084647.20636-10-kuhn.chenqun@huawei.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::242
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
Cc: peter.maydell@linaro.org, zhang.zhanghailiang@huawei.com,
 qemu-trivial@nongnu.org, Alistair Francis <alistair@alistair23.me>,
 qemu-devel@nongnu.org, Euler Robot <euler.robot@huawei.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On [2020 Feb 26] Wed 16:46:43, kuhn.chenqun@huawei.com wrote:
> From: Chen Qun <kuhn.chenqun@huawei.com>
> 
> Clang static code analyzer show warning:
> hw/dma/xlnx-zdma.c:399:13: warning: Value stored to 'dst_type' is never read
>             dst_type = FIELD_EX32(s->dsc_dst.words[3], ZDMA_CH_DST_DSCR_WORD3,
>             ^          ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> Reported-by: Euler Robot <euler.robot@huawei.com>
> Signed-off-by: Chen Qun <kuhn.chenqun@huawei.com>

Reviewed-by: Francisco Iglesias <frasse.iglesias@gmail.com>

> ---
> Cc: Alistair Francis <alistair@alistair23.me>
> Cc: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
> Cc: Peter Maydell <peter.maydell@linaro.org>
> Cc: Philippe Mathieu-Daudé <philmd@redhat.com>
> 
> v1->v2: move the 'dst_type' declaration.(Base on Philippe's suggestion).
> ---
>  hw/dma/xlnx-zdma.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/hw/dma/xlnx-zdma.c b/hw/dma/xlnx-zdma.c
> index 8fb83f5b07..eeacad59ce 100644
> --- a/hw/dma/xlnx-zdma.c
> +++ b/hw/dma/xlnx-zdma.c
> @@ -373,7 +373,7 @@ static uint64_t zdma_update_descr_addr(XlnxZDMA *s, bool type,
>  static void zdma_write_dst(XlnxZDMA *s, uint8_t *buf, uint32_t len)
>  {
>      uint32_t dst_size, dlen;
> -    bool dst_intr, dst_type;
> +    bool dst_intr;
>      unsigned int ptype = ARRAY_FIELD_EX32(s->regs, ZDMA_CH_CTRL0, POINT_TYPE);
>      unsigned int rw_mode = ARRAY_FIELD_EX32(s->regs, ZDMA_CH_CTRL0, MODE);
>      unsigned int burst_type = ARRAY_FIELD_EX32(s->regs, ZDMA_CH_DATA_ATTR,
> @@ -387,17 +387,17 @@ static void zdma_write_dst(XlnxZDMA *s, uint8_t *buf, uint32_t len)
>      while (len) {
>          dst_size = FIELD_EX32(s->dsc_dst.words[2], ZDMA_CH_DST_DSCR_WORD2,
>                                SIZE);
> -        dst_type = FIELD_EX32(s->dsc_dst.words[3], ZDMA_CH_DST_DSCR_WORD3,
> -                              TYPE);
>          if (dst_size == 0 && ptype == PT_MEM) {
>              uint64_t next;
> +            bool dst_type = FIELD_EX32(s->dsc_dst.words[3],
> +                                       ZDMA_CH_DST_DSCR_WORD3,
> +                                       TYPE);
> +
>              next = zdma_update_descr_addr(s, dst_type,
>                                            R_ZDMA_CH_DST_CUR_DSCR_LSB);
>              zdma_load_descriptor(s, next, &s->dsc_dst);
>              dst_size = FIELD_EX32(s->dsc_dst.words[2], ZDMA_CH_DST_DSCR_WORD2,
>                                    SIZE);
> -            dst_type = FIELD_EX32(s->dsc_dst.words[3], ZDMA_CH_DST_DSCR_WORD3,
> -                                  TYPE);
>          }
>  
>          /* Match what hardware does by ignoring the dst_size and only using
> -- 
> 2.23.0
> 
> 
> 

