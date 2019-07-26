Return-Path: <SRS0=FTQm=VX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 308D1C7618B
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 14:14:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E9E0F21850
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 14:14:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Wq22dtUw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9E0F21850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40456 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hr0zk-0001Ue-7v
	for qemu-devel@archiver.kernel.org; Fri, 26 Jul 2019 10:14:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46196)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hr0zT-0000eq-Va
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 10:14:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hr0zS-0003vA-Q3
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 10:14:35 -0400
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:36433)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hr0zS-0003ts-H8
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 10:14:34 -0400
Received: by mail-pf1-x442.google.com with SMTP id r7so24597684pfl.3
 for <qemu-devel@nongnu.org>; Fri, 26 Jul 2019 07:14:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=i/DvQrYQ97Yl8oYvdth1hdR4PNbJOpdRc88CoWxTHyU=;
 b=Wq22dtUwz1A7TMF5HCdO/SyYzbc29Tl0JYbsG/psMJbG9xEKYBFeLPKMIV6q86OU5t
 tnnkgjrqp6V5WXxcDNm8hlWK79RJI8H362lbhAxUcf2e9cVioZlWmTXNCSkuqF3Eqlof
 7rml1TW1VevDsAG7SAhxu6bUmTXy17ytYaZbn8EAvg0+RGAjvY6qSrzraIhoOxpk6ZJw
 5BTMQnN1NrqYKsjx1bl2CNOaoQUXVHc/9mZJ3wzWl3nRy6qFIkXwB+J3f1MohgJTRt9x
 i9abbHwK4PAfvzcXmuWi/JhDV+T3MmebY5cjX10tLUk5y7WhO7+fQn07xtvBKnnyEBIB
 X45A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=i/DvQrYQ97Yl8oYvdth1hdR4PNbJOpdRc88CoWxTHyU=;
 b=SqiQBqsok7hin/sjqj1YxZeCdCW6FZs99AfMG2fd9qlKMcamq5GqDNFMjqIooqslgN
 xPzp1D6f7xj5Se5VbyAanOF4O9Gj6xNQdA/VnSo9+MOqwgCqEFAiiIGqY5ubXg7ih3jd
 9SKBckqRQWJQOdJK2UfQMH7Os+uVp001zbZ+0H0ULJLlvODsGuDxbRSiVkvHw8k7t2TO
 GvKutCaYJNZu1PKNBKs6lg9AMpDAToIXXzrZV28SSlBo+a6vaJLK5wiHitYKcyzED5yL
 /eAqnQa3Ra2G823fqJ0FCQSwaPm3osH2MEjoez4cboGGh/TYB3gjNKCIVsjEnREs3SlN
 awxw==
X-Gm-Message-State: APjAAAWAWewgFpmMIzJvoeKBw07DETEZzyCzkCCptNlaRJ7MvkHkoKVS
 PcBYlZcMtvx14hLAjJxgmhrWww==
X-Google-Smtp-Source: APXvYqxDQAwXwyxw7nkYt1JtGRrNBEaknYYcz3WpCna5A0OARV6Nwpwuz1lnUaab5n4jyZR8B8TXGQ==
X-Received: by 2002:a62:1597:: with SMTP id 145mr21675793pfv.180.1564150473241; 
 Fri, 26 Jul 2019 07:14:33 -0700 (PDT)
Received: from [192.168.1.11] (97-126-117-207.tukw.qwest.net. [97.126.117.207])
 by smtp.gmail.com with ESMTPSA id x13sm56422483pfn.6.2019.07.26.07.14.31
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 26 Jul 2019 07:14:32 -0700 (PDT)
To: tony.nguyen@bt.com, qemu-devel@nongnu.org
References: <3106a3c959c4498fad13a5799c89ba7b@tpw09926dag18e.domain1.systemhost.net>
 <1564123618147.19868@bt.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <b5309b86-edbb-2b23-78e4-7657f6b05da5@linaro.org>
Date: Fri, 26 Jul 2019 07:14:30 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1564123618147.19868@bt.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::442
Subject: Re: [Qemu-devel] [PATCH v5 09/15] cputlb: Access MemoryRegion with
 MemOp
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
Cc: peter.maydell@linaro.org, walling@linux.ibm.com, sagark@eecs.berkeley.edu,
 mst@redhat.com, palmer@sifive.com, mark.cave-ayland@ilande.co.uk,
 Alistair.Francis@wdc.com, edgar.iglesias@gmail.com, alex.williamson@redhat.com,
 arikalo@wavecomp.com, david@redhat.com, pasic@linux.ibm.com,
 borntraeger@de.ibm.com, rth@twiddle.net, atar4qemu@gmail.com,
 ehabkost@redhat.com, qemu-s390x@nongnu.org, qemu-arm@nongnu.org,
 stefanha@redhat.com, shorne@gmail.com, david@gibson.dropbear.id.au,
 qemu-riscv@nongnu.org, kbastian@mail.uni-paderborn.de, cohuck@redhat.com,
 laurent@vivier.eu, qemu-ppc@nongnu.org, amarkovic@wavecomp.com,
 pbonzini@redhat.com, aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/25/19 11:46 PM, tony.nguyen@bt.com wrote:
> No-op MEMOP_SIZE and SIZE_MEMOP macros allows us to later easily
> convert memory_region_dispatch_{read|write} paramter "unsigned size"
> into a size+sign+endianness encoded "MemOp op".
> 
> Being a no-op macro, this patch does not introduce any logical change.
> 
> Signed-off-by: Tony Nguyen <tony.nguyen@bt.com>
> ---
>  accel/tcg/cputlb.c | 21 ++++++++++-----------
>  1 file changed, 10 insertions(+), 11 deletions(-)
> 
> diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
> index 523be4c..5d88cec 100644
> --- a/accel/tcg/cputlb.c
> +++ b/accel/tcg/cputlb.c
> @@ -881,7 +881,7 @@ static void tlb_fill(CPUState *cpu, target_ulong addr, int size,
> 
>  static uint64_t io_readx(CPUArchState *env, CPUIOTLBEntry *iotlbentry,
>                           int mmu_idx, target_ulong addr, uintptr_t retaddr,
> -                         MMUAccessType access_type, int size)
> +                         MMUAccessType access_type, MemOp op)

As I mentioned for patch 2, don't change this now, wait until after patch 10.

> -    r = memory_region_dispatch_read(mr, mr_offset,
> -                                    &val, size, iotlbentry->attrs);
> +    r = memory_region_dispatch_read(mr, mr_offset, &val, op, iotlbentry->attrs);

So size_memop here,

> -        cpu_transaction_failed(cpu, physaddr, addr, size, access_type,
> +        cpu_transaction_failed(cpu, physaddr, addr, MEMOP_SIZE(op), access_type,
>                                 mmu_idx, iotlbentry->attrs, r, retaddr);

but no memop_size here.

>  static void io_writex(CPUArchState *env, CPUIOTLBEntry *iotlbentry,
>                        int mmu_idx, uint64_t val, target_ulong addr,
> -                      uintptr_t retaddr, int size)
> +                      uintptr_t retaddr, MemOp op)

Likewise.

>          res = io_readx(env, &env_tlb(env)->d[mmu_idx].iotlb[index],
> -                       mmu_idx, addr, retaddr, access_type, size);
> +                       mmu_idx, addr, retaddr, access_type, SIZE_MEMOP(size));

And when you do come back to change the types after patch 10, at the top of the
function:

-    unsigned a_bits = get_alignment_bits(get_memop(oi));
+    MemOp op = get_memop(oi);
+    unsigned a_bits = get_alignment_bits(op);

and then pass along op directly.  Which will fix some of the weirdness in patch 11.


r~

