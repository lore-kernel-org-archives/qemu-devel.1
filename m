Return-Path: <SRS0=URa6=5T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A1F3C2BA16
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2020 18:42:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6748F20737
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2020 18:42:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xUQWgmmA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6748F20737
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59672 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jKRGf-0002jW-Ga
	for qemu-devel@archiver.kernel.org; Fri, 03 Apr 2020 14:42:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55185)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jKREc-0001II-QG
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 14:40:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jKREb-0003YU-JB
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 14:40:06 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:42870)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jKREb-0003Us-5A
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 14:40:05 -0400
Received: by mail-ot1-x342.google.com with SMTP id z5so8300295oth.9
 for <qemu-devel@nongnu.org>; Fri, 03 Apr 2020 11:40:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=21IbM3UajX86HvbzjpQqc+UNfp75BVUQPThr9h3lp0k=;
 b=xUQWgmmAA4+X+RUYByPjTOkrrXkSTqMvo5HMy0aM4DqXG78OWBOSAVgVahRNmE0idx
 pUhcUUlgFQrP+gtcVtWR73vRO362hfWXbiFm7sUnIx+qc+b0RFo57/nEbGc4HLkohrJ5
 9GvajImseQAWsfvX31kAHNoeckBlSjAbada0VNuH4BGm3N1yYnKHT9ZnXh5Con20X7oi
 bLsfiukOAQ44HJGuHRhuI2OavSVCsMmcTe7J1Xu7FnDRG8CyEJBjANMFsCD+eeS9ADJR
 X41CzYlTguy01Y6iQm5ZOoaYxfDIdSi3KZ0QJ89VOClDOrWfP4i74MEMkvsYQo24uAQL
 2F3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=21IbM3UajX86HvbzjpQqc+UNfp75BVUQPThr9h3lp0k=;
 b=bFM/UR8DooHwm7KudxWURYvIBVVKdLAB670gp6UcuoqKzUMfzigrFRefUuQghv9awx
 7VHyYMHmhQTNJA9i4/78HbHRmQADS8FuMFnjTZ6RaqYqxGj9WKEVaK+S4j0UlI1HqrJC
 mzB4BKhcMratR/TQANQkRQ55L84ekyGPjuYjRbTAeyFT5JqdwAA+ImGdcRHq06fFHQvV
 BA2JdqFPUUmRfNQqBp/6DyS4qUqK7nyzgjhbHqt89rB/waDTRPjRMeEWoWhn4/Ghf24U
 i19tGnVcLTkTwFUV7xoNbjyfUaMLQhNgjy/AKD6IGmAkxchXmaualusoQf/vpwYSoNb8
 jQqg==
X-Gm-Message-State: AGi0PuaGw9C7Uac939xiuK8BACZZDBHQZMFKVOuPMjFrZl2su7D3jjQL
 CeigFHzfK6MEiPhb3/SqhdcTkWYBxbZDib0SmvdxxA==
X-Google-Smtp-Source: APiQypLeUiKCEPxjW9yxAP68jlej0weIyzA98vp5hffzdw8lLNl7VpQJK/Apl4X2SJ0H3HKkFgZLuEDsxEUBlFKbkHU=
X-Received: by 2002:a05:6830:11d5:: with SMTP id
 v21mr7696633otq.91.1585939204054; 
 Fri, 03 Apr 2020 11:40:04 -0700 (PDT)
MIME-Version: 1.0
References: <20200402134721.27863-1-edgar.iglesias@gmail.com>
 <20200402134721.27863-6-edgar.iglesias@gmail.com>
In-Reply-To: <20200402134721.27863-6-edgar.iglesias@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 3 Apr 2020 19:39:52 +0100
Message-ID: <CAFEAcA99fjZwYJzhypCxyqDMN9NR-BEd8Q21R-5Ge3tv1EwEkQ@mail.gmail.com>
Subject: Re: [PATCH v1 5/5] dma/xlnx-zdma: Reorg to fix CUR_DSCR
To: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::342
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
Cc: figlesia@xilinx.com, Edgar Iglesias <edgar.iglesias@xilinx.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>,
 Francisco Iglesias <frasse.iglesias@gmail.com>,
 Alistair Francis <alistair@alistair23.me>,
 Richard Henderson <richard.henderson@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>,
 KONRAD Frederic <frederic.konrad@adacore.com>, qemu-arm <qemu-arm@nongnu.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 Luc Michel <luc.michel@greensocs.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 2 Apr 2020 at 14:46, Edgar E. Iglesias <edgar.iglesias@gmail.com> wrote:
>
> From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>
>
> Reorganize the descriptor handling so that CUR_DSCR always
> points to the next descriptor to be processed.
>
> Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
> ---

This is just moved-code in this patch so I think it's
a separate issue, but it looks like you have an endianness
bug here:

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

This reads 8 bytes into the uint64_t 'next', which means
that the value from C's point of view will be different
for big-endian and little-endian hosts. You probably wanted
address_space_ldq_le(), assuming the h/w always does
little-endian reads and that these get_regaddr64 and
put_regaddr64 functions work with host-endian integers.

There's a similar problem elsewhere in the device where
it does this:
    address_space_read(s->dma_as, addr, s->attr, buf, sizeof(XlnxZDMADescr));
and assumes the guest structure is the same layout and
endianness as the host struct XlnxDMADescr.

I'm not a huge fan of defining host C structs to match
guest data structures, but if you want to go that way
you ought to (a) be byteswapping the contents appropriately
and (b) have a compile-time assert that the size of the
struct is what you think it is and the compiler hasn't
inserted any helpful extra padding.

thanks
-- PMM

