Return-Path: <SRS0=DsKm=5S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71BC3C43331
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2020 22:56:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A6D92072E
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2020 22:56:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l3WFS0Sh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A6D92072E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48112 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jK8lV-00013c-9w
	for qemu-devel@archiver.kernel.org; Thu, 02 Apr 2020 18:56:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38887)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alistair23@gmail.com>) id 1jK8kt-0000VJ-LZ
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 18:56:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1jK8ks-0007TC-Iz
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 18:56:11 -0400
Received: from mail-ua1-x942.google.com ([2607:f8b0:4864:20::942]:37718)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1jK8ks-0007SN-FG; Thu, 02 Apr 2020 18:56:10 -0400
Received: by mail-ua1-x942.google.com with SMTP id l18so2028758uak.4;
 Thu, 02 Apr 2020 15:56:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=1nkyQA9MCDPk2sT0OluSIvutSIHYXPNrx24fVKKyB8c=;
 b=l3WFS0ShdCI70o02BEnsIH4nHqW2TGTkgUgDct73lz4Ceo93NMgHKTfajiUSkltsKV
 0zyA2hKCi2izp/L/dj22tiIV7SYIlqaz6UWF8s8Ju1Cy8Xe7X+qHsCicc/GJXRf27SyP
 H0XNiUmuE8oBkQVCgzaLC6KJm36dbSSEQmO5Z9EAN/QvA820je9C69HXoyqT5/R8IG/k
 ByzjA0kiAwLIOmumFv6plIc5bs/YI7my6o5yTz6E0MxarGC52MuSR9JxVFXCRCDdlb5A
 DUlLn5bAejwlQtBQH7us9mTBMr7/a9XToRmflQl3oR6d4+nwhfOMYiN114a7ZBqK3YNX
 TWfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=1nkyQA9MCDPk2sT0OluSIvutSIHYXPNrx24fVKKyB8c=;
 b=LDNErjQH6+O+4c/1pfuvDRxrYDZ4F2+vFUbrYEP2xL4mJTVMCB0CD7WsvdsOEtdVeL
 62et4OUNrpg+W9BDrASuvzapblyuaHbpD5YdrRFHUA0L0g9hE2+VreKvGkeUyOUvOo0p
 eify9tviaFOLnGrslXrE7MsknMSp7lRbsxCbnmvh/Y+3XYg8hrVjLgWUD6fU0JnWF87H
 GE2H8/4CQ2fPqFDjddbswdL0zkuwUW06kbLG9Cjdic/jfQwX+tl3HCgIuy+t9SC6t1K/
 JNqFWkOt/LhoSjEBLOY0B3nq6IAG0NVAbBt7/GxEOaJvBizyT3CH++ogI6LZTD/QeOy9
 DXUA==
X-Gm-Message-State: AGi0PuYq9mGWx8MED6JtUGf8r5SDl0t7uDT0DjgpzMVlRnLC7ZmMAkoY
 I7r5ushU/pZAkhlexIG3/WHh1RFuag4MkPJOLv4=
X-Google-Smtp-Source: APiQypKx//hFud6VhFzgjiKTRsoAeJUPL2Zzmei88OVUzlOeyj3aGVFOlA3htj+Gwzv3EXJji6GNQG0Ttn69/kVGpbI=
X-Received: by 2002:a9f:2964:: with SMTP id t91mr4481268uat.21.1585868168528; 
 Thu, 02 Apr 2020 15:56:08 -0700 (PDT)
MIME-Version: 1.0
References: <20200402134721.27863-1-edgar.iglesias@gmail.com>
 <20200402134721.27863-6-edgar.iglesias@gmail.com>
In-Reply-To: <20200402134721.27863-6-edgar.iglesias@gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 2 Apr 2020 15:47:56 -0700
Message-ID: <CAKmqyKPjF8KQBEAkBJRTj02OuT3RutNHmA1BkZgbJ8tsztQ2EA@mail.gmail.com>
Subject: Re: [PATCH v1 5/5] dma/xlnx-zdma: Reorg to fix CUR_DSCR
To: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::942
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
Cc: figlesia@xilinx.com, Peter Maydell <peter.maydell@linaro.org>,
 Edgar Iglesias <edgar.iglesias@xilinx.com>,
 Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>,
 Francisco Iglesias <frasse.iglesias@gmail.com>,
 Alistair Francis <alistair@alistair23.me>,
 Richard Henderson <richard.henderson@linaro.org>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 KONRAD Frederic <frederic.konrad@adacore.com>,
 Stefano Stabellini <sstabellini@kernel.org>, qemu-arm <qemu-arm@nongnu.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 Luc Michel <luc.michel@greensocs.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Apr 2, 2020 at 6:50 AM Edgar E. Iglesias
<edgar.iglesias@gmail.com> wrote:
>
> From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>
>
> Reorganize the descriptor handling so that CUR_DSCR always
> points to the next descriptor to be processed.
>
> Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  hw/dma/xlnx-zdma.c | 47 ++++++++++++++++++++++------------------------
>  1 file changed, 22 insertions(+), 25 deletions(-)
>
> diff --git a/hw/dma/xlnx-zdma.c b/hw/dma/xlnx-zdma.c
> index e856d233f2..1c45367f3c 100644
> --- a/hw/dma/xlnx-zdma.c
> +++ b/hw/dma/xlnx-zdma.c
> @@ -333,10 +333,28 @@ static void zdma_load_src_descriptor(XlnxZDMA *s)
>      }
>  }
>
> +static void zdma_update_descr_addr(XlnxZDMA *s, bool type,
> +                                   unsigned int basereg)
> +{
> +    uint64_t addr, next;
> +
> +    if (type == DTYPE_LINEAR) {
> +        addr = zdma_get_regaddr64(s, basereg);
> +        next = addr + sizeof(s->dsc_dst);
> +    } else {
> +        addr = zdma_get_regaddr64(s, basereg);
> +        addr += sizeof(s->dsc_dst);
> +        address_space_read(s->dma_as, addr, s->attr, (void *) &next, 8);
> +    }
> +
> +    zdma_put_regaddr64(s, basereg, next);
> +}
> +
>  static void zdma_load_dst_descriptor(XlnxZDMA *s)
>  {
>      uint64_t dst_addr;
>      unsigned int ptype = ARRAY_FIELD_EX32(s->regs, ZDMA_CH_CTRL0, POINT_TYPE);
> +    bool dst_type;
>
>      if (ptype == PT_REG) {
>          memcpy(&s->dsc_dst, &s->regs[R_ZDMA_CH_DST_DSCR_WORD0],
> @@ -349,24 +367,10 @@ static void zdma_load_dst_descriptor(XlnxZDMA *s)
>      if (!zdma_load_descriptor(s, dst_addr, &s->dsc_dst)) {
>          ARRAY_FIELD_DP32(s->regs, ZDMA_CH_ISR, AXI_RD_DST_DSCR, true);
>      }
> -}
> -
> -static uint64_t zdma_update_descr_addr(XlnxZDMA *s, bool type,
> -                                       unsigned int basereg)
> -{
> -    uint64_t addr, next;
>
> -    if (type == DTYPE_LINEAR) {
> -        next = zdma_get_regaddr64(s, basereg);
> -        next += sizeof(s->dsc_dst);
> -        zdma_put_regaddr64(s, basereg, next);
> -    } else {
> -        addr = zdma_get_regaddr64(s, basereg);
> -        addr += sizeof(s->dsc_dst);
> -        address_space_read(s->dma_as, addr, s->attr, &next, 8);
> -        zdma_put_regaddr64(s, basereg, next);
> -    }
> -    return next;
> +    /* Advance the descriptor pointer.  */
> +    dst_type = FIELD_EX32(s->dsc_dst.words[3], ZDMA_CH_DST_DSCR_WORD3, TYPE);
> +    zdma_update_descr_addr(s, dst_type, R_ZDMA_CH_DST_CUR_DSCR_LSB);
>  }
>
>  static void zdma_write_dst(XlnxZDMA *s, uint8_t *buf, uint32_t len)
> @@ -387,14 +391,7 @@ static void zdma_write_dst(XlnxZDMA *s, uint8_t *buf, uint32_t len)
>          dst_size = FIELD_EX32(s->dsc_dst.words[2], ZDMA_CH_DST_DSCR_WORD2,
>                                SIZE);
>          if (dst_size == 0 && ptype == PT_MEM) {
> -            uint64_t next;
> -            bool dst_type = FIELD_EX32(s->dsc_dst.words[3],
> -                                       ZDMA_CH_DST_DSCR_WORD3,
> -                                       TYPE);
> -
> -            next = zdma_update_descr_addr(s, dst_type,
> -                                          R_ZDMA_CH_DST_CUR_DSCR_LSB);
> -            zdma_load_descriptor(s, next, &s->dsc_dst);
> +            zdma_load_dst_descriptor(s);
>              dst_size = FIELD_EX32(s->dsc_dst.words[2], ZDMA_CH_DST_DSCR_WORD2,
>                                    SIZE);
>          }
> --
> 2.20.1
>
>

