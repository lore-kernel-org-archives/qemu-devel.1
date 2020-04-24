Return-Path: <SRS0=J7/p=6I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 846B1C54FCB
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2020 19:39:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4DA5B21569
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2020 19:39:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rw9xgINk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4DA5B21569
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50672 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jS4AP-0001aV-Cx
	for qemu-devel@archiver.kernel.org; Fri, 24 Apr 2020 15:39:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56910)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jS49f-00012D-Hr
 for qemu-devel@nongnu.org; Fri, 24 Apr 2020 15:38:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jS49e-0002wn-NT
 for qemu-devel@nongnu.org; Fri, 24 Apr 2020 15:38:31 -0400
Received: from mail-pj1-x1043.google.com ([2607:f8b0:4864:20::1043]:34803)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jS49e-0002ra-2w
 for qemu-devel@nongnu.org; Fri, 24 Apr 2020 15:38:30 -0400
Received: by mail-pj1-x1043.google.com with SMTP id h12so2909195pjz.1
 for <qemu-devel@nongnu.org>; Fri, 24 Apr 2020 12:38:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=ZARXF0KnDHHvqBwuSWiM8BftW8f2LeoSBuuJtLxjSh0=;
 b=rw9xgINkJF9WA8tl32a31lTSaZxPBu/EvSBW+11CWxfWOCWd2lOudXxXV1uh62zq/G
 e8/cKUmN58vurJpXNzPYTUFavmJwrNciHDCiXg4gYNuMoQ9oUku6mEEg4ZYuJ2gskkZc
 Sva7WnBobdEqE3QGdA9OlvIAbHyg12C7LQ404wC7SIp3LbErKwBdLlZjsjLBFrOIogux
 akY4UU9xJrAOsSzWJJR7+5rr2/UqG/xdrxVydWzznCSYhM7SBOUEnD3fsf82a+EWV49K
 e3AYOVhrVSabyGRQlPffyuBX7vRCNcx2wDXil9hASrn3WevSPIDIt3SSb9J5v7qXbESQ
 oQ4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=ZARXF0KnDHHvqBwuSWiM8BftW8f2LeoSBuuJtLxjSh0=;
 b=IRSLYQEPS+3wZRwBa2ylm73hBOroa6v4lgrBqfG9Pq8fSsFycuvoVr0dbG5eFrGlzI
 bntB3ydro+dSp+zmfbWPdUbumu5fKjK8yaPhlnTB4Yck+tkC8twIj5t1bBDhzvhmQffj
 W11VpaxPXNWKlkdvD9vyY+0LRxpkrY90SSqkefWy4pmoKA9qW0p+5JpXsnbP4tIZHu/j
 WPQlNVr8KM3tGJGDMogevR5vAy0H/iWy2ZQJTCgUKdCPPHrxQY99avjX5blSAl42fR3I
 9M8jiiC1OXkHN5Ns/tbBl5WV9u0OgIwteVubfUYupGsPl+AfpJJcN3UhaseFExPMjogf
 iseQ==
X-Gm-Message-State: AGi0PuaCnVho63fZR6/4SQMPMuKhQBRDnoXERc8VSDNa2DHzUU/dqZpc
 JfpYRjWs/3X3HMVRieLbbcQUdA==
X-Google-Smtp-Source: APiQypJSj00/OjJi0sSm7ThzsUtZFtqFWmJdmcEsOGpRpT771FU//LUkJPZAxovoEev20xQJleHsQQ==
X-Received: by 2002:a17:902:c281:: with SMTP id
 i1mr10992939pld.327.1587757108289; 
 Fri, 24 Apr 2020 12:38:28 -0700 (PDT)
Received: from [192.168.1.11] (174-21-149-226.tukw.qwest.net. [174.21.149.226])
 by smtp.gmail.com with ESMTPSA id b24sm6470295pfd.175.2020.04.24.12.38.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 24 Apr 2020 12:38:27 -0700 (PDT)
Subject: Re: [RFC PATCH] translate-all: include guest address in out_asm output
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20200424173914.2957-1-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <6b8a6ab1-d093-d54c-17ed-5221458c36df@linaro.org>
Date: Fri, 24 Apr 2020 12:38:25 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200424173914.2957-1-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1043;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1043.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2607:f8b0:4864:20::1043
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/24/20 10:39 AM, Alex Bennée wrote:
> +        /* first dump prologue */
> +        insn_start = tcg_ctx->gen_insn_end_off[0];
> +        if (insn_start > 0) {
> +            qemu_log("  prologue: [size=%ld]\n", insn_start);
> +            log_disas(tb->tc.ptr, insn_start);
> +        }
> +
> +        do {
> +            size_t insn_end;
> +            if (insn < (tb->icount - 1)) {
> +                insn_end = tcg_ctx->gen_insn_end_off[insn + 1];
> +            } else {
> +                insn_end = code_size;
> +            }
> +            qemu_log("  for guest addr: " TARGET_FMT_lx ":\n",
> +                     tcg_ctx->gen_insn_data[insn][0]);

The one thing you're missing here is when a given guest insn emits no host
insns.  E.g. an actual guest nop, or if two guest insns are optimized together.

So you need to search forward through empty insns til you find one that has
contents.  E.g. the very first TB that alpha-softmmu executes in its bios:

OP after optimization and liveness analysis:
 ld_i32 tmp0,env,$0xfffffffffffffff0      dead: 1  pref=0xffff
 movi_i32 tmp1,$0x0                       pref=0xffff
 brcond_i32 tmp0,tmp1,lt,$L0              dead: 0 1

 ---- fffffc0000000000

 ---- fffffc0000000004

 ---- fffffc0000000008
 movi_i64 gp,$0xfffffc0000012f50          sync: 0  pref=0xffff



OUT: [size=280]
  prologue: [size=11]
0x7fffa0000100:  8b 5d f0                 movl     -0x10(%rbp), %ebx
0x7fffa0000103:  85 db                    testl    %ebx, %ebx
0x7fffa0000105:  0f 8c d6 00 00 00        jl       0x7fffa00001e1
  for guest addr: fffffc0000000000:
  for guest addr: fffffc0000000004:
0x7fffa000010b:  48 bb 50 2f 01 00 00 fc  movabsq  $0xfffffc0000012f50, %rbx
0x7fffa0000113:  ff ff
0x7fffa0000115:  48 89 9d e8 00 00 00     movq     %rbx, 0xe8(%rbp)
  for guest addr: fffffc0000000008:

So you've attributed to ...04 what actually belongs to ...08.


But it's a good idea.


r~

