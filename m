Return-Path: <SRS0=eeqW=XH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A16E6C4CEC5
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2019 14:59:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 69C252081B
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2019 14:59:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WiEV1GI8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69C252081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35534 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i8QZU-0003D4-J6
	for qemu-devel@archiver.kernel.org; Thu, 12 Sep 2019 10:59:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34723)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1i8QXh-00026P-SJ
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 10:57:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1i8QXg-0004xC-EK
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 10:57:53 -0400
Received: from mail-qk1-x743.google.com ([2607:f8b0:4864:20::743]:33998)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1i8QXg-0004wA-6F
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 10:57:52 -0400
Received: by mail-qk1-x743.google.com with SMTP id q203so24767891qke.1
 for <qemu-devel@nongnu.org>; Thu, 12 Sep 2019 07:57:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=xsy2kOVTD167AQ683WKVJW7gRRAg7eLJFgC+5Fhug4A=;
 b=WiEV1GI8i1a6XEstQK6iiS+7fC12W33ErCpruiK6IbEbUICsL4U/fya0xle1R7G1bu
 7/Jn0zFNd06NRh8S9mafLIn1SmwVn0dc2lhkniznniD+Ru6YJgfuca38b/1+8Ku8LJTG
 DnbNqu7HlO3mZR9z6v1xS9evYLhsi65/BGhyRNP6B2MWxnq0QQXLmR2nV09ARTCj67KQ
 cM93PFCYwBvd8lvZiXrzA0FHZWFbYAAtw6rEpTS7nKJyvQw+fL70ybrzGiK0FWi+qL7E
 5dQXzDAAOH3VGuFcIZinplkQalJ+p6x1wB/4Ot6QWC0I3/MuuMBneppg4Y4I55nCMUQm
 7NdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=xsy2kOVTD167AQ683WKVJW7gRRAg7eLJFgC+5Fhug4A=;
 b=YGKzgKAVqhsKUaDf+2t6s5TDkgRSsJDE0zGsCw+QrTDBtMTCluu457HDd80QEwQRpB
 B+NzC1HaNC/gpPArlQhk9QlhcYv2pdkf0NTWQJuUx4Vmsh/cLXSny6/+Xf7FxSP0aeE/
 Ll10kW22cRZb+ayqp2A/8RMSzg2lJfV9KQtDOkUxSOZKHL5gjb12faIU2ptzHCaZwChT
 zyJLYW6JREeAEbc9kzIvWLSOjlyqmMoBNwJFuPCLevuLgBSWypKPfPkuOjXwrrfgpMSd
 w/DzBO7CZ9iNUazipEwGTFDQnini02eRghS2JtoyZFcWYx4ULCl2u88dcDKXb9s0lE/j
 yGwg==
X-Gm-Message-State: APjAAAWOp6yTl6/LoSJLYbjxleN/va0WUr+hmcN3e9vvw3h1rOBP39CF
 d3BfXGdnwQCRHuTHBbfg/K6dJw==
X-Google-Smtp-Source: APXvYqyPtC5uLDt5tEspaCxPCLb/waHvYMe8mqW8tiNl5QwFXLWRGvRV4eyn+4gYLomUku9+RlEsmQ==
X-Received: by 2002:a37:4b02:: with SMTP id y2mr41251379qka.493.1568300271069; 
 Thu, 12 Sep 2019 07:57:51 -0700 (PDT)
Received: from [172.20.5.51] ([67.69.50.154])
 by smtp.gmail.com with ESMTPSA id m14sm1449496qki.27.2019.09.12.07.57.49
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 12 Sep 2019 07:57:50 -0700 (PDT)
To: liuzhiwei <zhiwei_liu@c-sky.com>, Alistair.Francis@wdc.com,
 palmer@sifive.com, sagark@eecs.berkeley.edu, kbastian@mail.uni-paderborn.de,
 riku.voipio@iki.fi, laurent@vivier.eu, wenmeng_zhang@c-sky.com
References: <1568183141-67641-1-git-send-email-zhiwei_liu@c-sky.com>
 <1568183141-67641-8-git-send-email-zhiwei_liu@c-sky.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <5807ed99-e8a8-b845-2eb8-e8c5ae6176a4@linaro.org>
Date: Thu, 12 Sep 2019 10:57:47 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1568183141-67641-8-git-send-email-zhiwei_liu@c-sky.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::743
Subject: Re: [Qemu-devel] [PATCH v2 07/17] RISC-V: add vector extension
 atomic instructions
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
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org, wxy194768@alibaba-inc.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/11/19 2:25 AM, liuzhiwei wrote:
> +            case 64:
> +                if (vector_elem_mask(env, vm, width, lmul, i)) {
> +                    int64_t tmp;
> +                    idx    = (target_long)env->vfp.vreg[src2].s64[j];
> +                    addr   = idx + env->gpr[rs1];
> +
> +#ifdef CONFIG_SOFTMMU
> +                    tmp = (int64_t)(int32_t)helper_atomic_xchgl_le(env, addr,
> +                        env->vfp.vreg[src3].s64[j],
> +                        make_memop_idx(memop & ~MO_SIGN, mem_idx));
> +#else
> +                    tmp = (int64_t)(int32_t)helper_atomic_xchgl_le(env, addr,
> +                        env->vfp.vreg[src3].s64[j]);
> +#endif
> +                    if (wd) {
> +                        env->vfp.vreg[src3].s64[j] = tmp;
> +                    }
> +                    env->vfp.vstart++;
> +                }
> +                break;

This will not link if !defined(CONFIG_ATOMIC64).

That's pretty rare these days, admittedly.  I think you'd need to compile for
ppc32 or mips32 (or riscv32!) host to see this.  You can force this condition
for i686 host with --extra-cflags='-march=i486', just to see if you've got it
right.

There should be two different versions of this helper: one that performs actual
atomic operations, as above, and a second that performs the same operation with
non-atomic operations.

The version of the helper that you call should be based on the translation time
setting of "tb_cflags(s->base.tb) & CF_PARALLEL":  If PARALLEL is set, call the
atomic helper otherwise the non-atomic helper.

If you arrive at a situation in which the host cannot handle any atomic
operation, then you must raise the EXCP_ATOMIC exception.  This will halt all
other cpus and run one instruction on this cpu while holding the exclusive lock.

If you cannot detect this condition any earlier than here at runtime, use
cpu_loop_exit_atomic(), but you must do so before altering any cpu state.
However, as per my comments for normal loads, you should be able to detect this
condition at translation time and call gen_helper_exit_atomic().


r~

