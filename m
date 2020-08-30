Return-Path: <SRS0=e36u=CI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 864C4C433E2
	for <qemu-devel@archiver.kernel.org>; Sun, 30 Aug 2020 01:40:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4605020838
	for <qemu-devel@archiver.kernel.org>; Sun, 30 Aug 2020 01:40:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bbFuTCvj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4605020838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50382 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kCCKX-0002hJ-A3
	for qemu-devel@archiver.kernel.org; Sat, 29 Aug 2020 21:40:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47230)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kCCJc-0001zg-LA
 for qemu-devel@nongnu.org; Sat, 29 Aug 2020 21:39:28 -0400
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:38698)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kCCJa-0005tP-Fw
 for qemu-devel@nongnu.org; Sat, 29 Aug 2020 21:39:28 -0400
Received: by mail-pf1-x441.google.com with SMTP id d22so2639092pfn.5
 for <qemu-devel@nongnu.org>; Sat, 29 Aug 2020 18:39:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=YczkYlI3oy3SZPtWvmqe898ZHYbKQgCth2fDz6LcfnY=;
 b=bbFuTCvjiRf2CIiQZDuguU2qrkYbE+f8Bz/9GzhICQS3fvLpMmvMjESWlGwbDD21Mb
 yURjP3EIVT6JqCyX1IGIPLWafZRAxUtUgEn1cZogjHpK3CfxO0WsTy30vTiBGREQWKwj
 iK4yVL0Qxdh0KnsHVS1+8Or2HKeGKwAIZqGS2KjVRMwGhe8Q+jgK0mJtl7nrl8Y6dTW5
 ThRemijkYZMQJasowF0I6pJiON9WDBOUVYAxoGjXrr6mOvX09VfrPpJ5OhMTP5d2tHmi
 x14x2G/EzQ4u7ktkPCq2kzU1t++EeMtCBj0VNzQYi9qVEgNI7xxkxY8n05QOhcsQqI37
 HumQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=YczkYlI3oy3SZPtWvmqe898ZHYbKQgCth2fDz6LcfnY=;
 b=pq9/X9k/9kQhcIT5v2P0E2JOjSjK2PwOrv5D6XTdLrlDgHScX+0UnFOvmd1yk1ssNH
 fwwLXrmNdIOCyjwknA9Xd0KLXbk8jYDd5WAbujop04U1mQ1SUW1NOZYAO013M5ZRi+PM
 R4Tb0JJU7rDLwEJowKfbLLhuCJqPRxPF8PwJApE2MF3TKEK0a2/zw5cGxghboP9QMFJI
 hL5RJJ4GQWXdvXMls5BHdC+QjqhZ2ERQBKt9+td58qRtHQ9Wqramv5NP/lE6QPHIJ4jX
 YQpZDsuj/wn/fRZMMSf3Zd+fzle28hYA4aXIkM1LVwgllu9wAgfvtxuotBYFASJYhlu+
 BTww==
X-Gm-Message-State: AOAM533x3j+Axi7X81zJwHw2RWGSzzBuZNpU9kpoSg/4sodWny/EkaLP
 c7asNK576Cc9pd/GkAiwAhSiJA==
X-Google-Smtp-Source: ABdhPJz9dPDzKzXnBQ2r+lr48X+9Ufz9wbLomXYmTAuxuN77i/sB8ZZUcxCygS6/XAZw2btkFuOtiA==
X-Received: by 2002:a63:f804:: with SMTP id n4mr3822831pgh.155.1598751564785; 
 Sat, 29 Aug 2020 18:39:24 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id d23sm3508751pgm.11.2020.08.29.18.39.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 29 Aug 2020 18:39:23 -0700 (PDT)
Subject: Re: [RFC v4 67/70] target/riscv: rvv-1.0: relax RV_VLEN_MAX to
 512-bits
To: frank.chang@sifive.com, qemu-devel@nongnu.org, qemu-riscv@nongnu.org
References: <20200817084955.28793-1-frank.chang@sifive.com>
 <20200817084955.28793-68-frank.chang@sifive.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <f56d303d-62ca-9ffb-56f4-2462efb947ab@linaro.org>
Date: Sat, 29 Aug 2020 18:39:21 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200817084955.28793-68-frank.chang@sifive.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::441;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x441.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.809,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/17/20 1:49 AM, frank.chang@sifive.com wrote:
> From: Frank Chang <frank.chang@sifive.com>
> 
> As GVEC only supports MAXSZ and OPRSZ in the range of: [8..256] bytes
> and LMUL could be a fractional number. The maximum vector size can be
> operated might be less than 8 bytes or larger than 256 bytes.
> Skip to use GVEC if maximum vector size <= 8 or >= 256 bytes.
> 
> Signed-off-by: Frank Chang <frank.chang@sifive.com>
> 
> --
> Maybe to relax the limitations of MAXSZ or OPRSZ would be a better
> approach.

I would definitely like to improve gvec to handle any actual vector length that
you need.  With VLEN=512 (bits) and LMUL=8, that gives you 512 byte vectors.
Is that the limit of what you need, or did you want to go higher?

There will have to be some maximum supported by tcg, though.
It's probably worth having an assert somewhere.

Perhaps something like

/*
 * RV_LEN_MAX (bits) / 8 (bits-per-byte) * 8 (LMUL)
 * = RV_LEN_MAX (bytes)
 *
 * should be less than the number of bytes supported by gvec.
 */
QEMU_BUILD_BUG_ON(RV_VLEN_MAX > (8 << SIMD_MAXSZ_BITS));

Perhaps placed in in vector_helper.c, so that cpu.h does not have to include
"tcg/tcg-gvec-desc.h".

However... simply increasing the number of bits in SIMD_MAXSZ_BITS and
SIMD_OPRSZ_BITS will break Arm SVE -- we need 20 bits in simd_data(), and
that's exactly what we have at present.

If we can come up with a more compact encoding of oprsz/maxsz, that would be
ideal.  Otherwise, I need to compress the data currently stored in simd_data().

-----

I suppose one point here is that for RISC-V, oprsz always equals maxsz.  So
we've effectively wasted 5 bits.  Moreover, that's also true for Arm SVE.

However, Arm AdvSIMD, the older vector isa, will have oprsz == 8 or oprsz ==
16.  Since the vector registers overlap, maxsz is the SVE vector length, and
the area in between oprsz and maxsz is cleared.

If we ever merge the x86_64 AVX2 patches from last year's GSoC, and then expand
on that to implement AVX512, then we would have oprsz == 16 or oprsz == 32,
with maxsz == 64.

Perhaps we could reduce the generality of oprsz, and compress it into 2 bits:

  0b00 -> 8
  0b01 -> 16
  0b10 -> 32
  0b11 -> maxsz

Now we have 3 bits we can move over to the maxsz field, which will let us
represent 8 * 256 or 2048 byte vectors.

Thoughts?


r~

