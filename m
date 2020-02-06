Return-Path: <SRS0=rlpO=32=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51C71C33CAC
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 15:36:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E0C121D7D
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 15:36:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JI5jxbqd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E0C121D7D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=twiddle.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41200 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izjCg-0005Iq-AX
	for qemu-devel@archiver.kernel.org; Thu, 06 Feb 2020 10:36:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41401)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <rth7680@gmail.com>) id 1izjBR-0004Im-Pn
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 10:35:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <rth7680@gmail.com>) id 1izjBQ-0004tq-MJ
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 10:35:13 -0500
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:39348)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1izjBQ-0004rg-Cx
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 10:35:12 -0500
Received: by mail-wm1-x341.google.com with SMTP id c84so488312wme.4
 for <qemu-devel@nongnu.org>; Thu, 06 Feb 2020 07:35:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:autocrypt:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=mV7uYq1oqmIlF3X5Mfu5iK6IMFjhIVCm9XciNp+tL+k=;
 b=JI5jxbqdgwWXBD9N0M4xHpHfKw/W+i9xicw5o9e4gIZPfKf23chu961GU67x4KywBF
 BniF3EbKhrBFWqvwIoWuALB0JKsA8O85Nf4mRLJcg+8tlTK91jvF2/pj/gINqRVSZVMf
 xrPaWd9PNMT1zgUN/JAVJgt5CYlr8flN5TpsTzgmPdesolyLivalN3oXJNDxD2Ai45OK
 5HMYmUJ0ARr2PZNova+GdFmOYG/L1zQO38Uk5zjvi3wvbjyxJt0uvgP8sWjqvCuH5RE8
 QtlY9WA2raIq4xvxsTCz3RuKFnPaDF9VyHlIdojjumOG5KARu3rnox3jYyqXuH0ymT8A
 RmzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=mV7uYq1oqmIlF3X5Mfu5iK6IMFjhIVCm9XciNp+tL+k=;
 b=q8IL2QmLmqQCN2srEFV2oETP+RJa1gvNVJP11EiGPUVN3VeQxA5tb7+IkaPluma/2F
 S8ogH5pibDdbRuz494YVl+AekyZ4OlOkOZLhSO3t4hXm2VRQ0zr5dN2RzE/2X2SYfzCH
 Vcn/ltEYDunLbWU+ED4SSeJMyVZoxX5JsfE3Gs2xCicMDEugGtJkm5QJkwNz6sO0ORRy
 t3zQ02FID6piJZHnvLFm1gn8JQgzeRQyumfNERnJkk3dTaLazLULm1g79QFqoh4QPbNJ
 jyvd6BVhY7A0VkYwkmASMw/ceggdyaONCQ4/JfxHThabDxgTEsf6UpCBw0Mq7GvAfeG6
 Md5Q==
X-Gm-Message-State: APjAAAVKPugakmp3/5MjnIebPVeWGuBBHHPHIL2pqkQoIrkff4wKsX25
 s37XGAj1/OUtGG87bipGrXs=
X-Google-Smtp-Source: APXvYqzokR0zj/PxmT9v250VX2+zYvMb7kQ6iNgJQ5deHFXdDGqyKacX/xB0ZziP2EttB7pf7LeHYg==
X-Received: by 2002:a7b:c3c9:: with SMTP id t9mr5103973wmj.18.1581003311344;
 Thu, 06 Feb 2020 07:35:11 -0800 (PST)
Received: from [10.43.13.93] ([135.196.99.211])
 by smtp.googlemail.com with ESMTPSA id c9sm3933234wmc.47.2020.02.06.07.35.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 06 Feb 2020 07:35:10 -0800 (PST)
Subject: Re: [PATCH] Add support for a helper with 7 arguments
To: Taylor Simpson <tsimpson@quicinc.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
References: <1580942510-2820-1-git-send-email-tsimpson@quicinc.com>
 <09def3cf-6833-ccf5-457e-1755a7fd0e04@twiddle.net>
 <640ffa37-a70b-dfa9-55ef-cde5c7f0dfcb@twiddle.net>
 <BYAPR02MB48863BDFCB4CB26717467579DE1D0@BYAPR02MB4886.namprd02.prod.outlook.com>
From: Richard Henderson <rth@twiddle.net>
Autocrypt: addr=rth@twiddle.net; prefer-encrypt=mutual; keydata=
 mQENBFGuLC8BCADcAoWcnW9lTsDMzbO3MBU+KbiGaj5JPatEUscRDkQYM2fyNjJp2tIWDK5a
 n4yngeXB3eX61WbYR3QraRK8mlYLGxyAdHMEQfPipbqf3TmN043fssT2bc82ApJcs1zvLYgI
 rhMht7Dck7A0wNC1jo+ZjVVFig5gDTN7gOzaAdBtV8tVNUddwkLzzaGpfihhSD6U46NdqKOG
 Wlnn6TrkMy0QGdQ5NaXHkRlUjnnUTSW/nKfoxD+EI+A9V4sYOd8mc/TL4aJh/i/AiU57eLbo
 n17uQI6/VTWDUWl8USiz4x9c8vmqlywLx00tAFxxoRWqk4KVJlj+Sh0up/D/sJ+vPpgBABEB
 AAG0I1JpY2hhcmQgSGVuZGVyc29uIDxydGhAdHdpZGRsZS5uZXQ+iQFYBBMBAgBCAhsDBgsJ
 CAcDAgYVCAIJCgsEFgIDAQIeAQIXgAIZARYhBJyxjdr46EmtKvwWpK0ScMxN0CebBQJdweUY
 BQkP1h/pAAoJEK0ScMxN0CebqDsH/0YyfnXk+Dc++H37VCEKgRet2i1ATFzxRnifkvmdxha0
 V+PVptQ2fwSe+w3KxoFecD8W75nysmUjrU/FicW9yU5YRlGONPZjruG02/KzmhA5PzWJdYO3
 i/t0qRayvWIcX2qA/flsXEbmb/BbAFM05LQIdcOu74eiBFe5CBCOWBDJeneE1urIE0hSYxoh
 nCcG60ULrNj13ohZ4zAEluoY32qIo7/OPWmtR88cPrEbZT8k+RqgZbsotzaPT1/RlL74fL8k
 ofYfTgKAFH7eEy6fF2nzDp2GThVn+3sA62xtpSXUf/X1m75B40KOcq1EQbHypNTmBc1wt13e
 ibhPNEVX2am5AQ0EUa4sLwEIALITHfH3gciRNfQIe7awDTDvn6H3C6gDyCAnv5LiuLTLZiyK
 NZp3lNO3rPowyKrGT2RIDlumlqPgdeHzqEEX91YK0yk2vdFvwU04rJ4D+qRgdUPoeICLD1zo
 PwOv2FaY6Tf8dKYas1RHF5QU5yQNey8j7IYYoE2yGPn2PtBmvtmK4iLataUEvx0U385Zr+jf
 HscqwTiToryeDC8Io/9BsMvAssE5Yf5URS2nJ7LFOvc4njsQJPF1i9egBXaIloqv7p2hVCKJ
 Hl5UWIxitQ9QQIl6iU4LCpz8mVYTXwv48IAVpbUf7+ak9V9Kk3jCeQnlxCJBUHjUhoIzinbS
 JHPHtkkAEQEAAYkBPAQYAQIAJgIbDBYhBJyxjdr46EmtKvwWpK0ScMxN0CebBQJdweVIBQkP
 1iAZAAoJEK0ScMxN0CebGHUH/RtouOlWl6To97tQsTJUq/2YwmRpFOsvV0/zCX4fKBGAbeZi
 VaELSt2+3UEErA+n8HwbQmjJ6IrdhA9GustOpOyCcbLVSMwql/OlAwBtDzCcC8dTU4zcuY2a
 rGG2A8i5krU85G9r1wowVcWZBsdmW7/dKiNoadLQiig4bHNiSaV4ograas5efyEjqTxiY+yG
 hzPw5DK2kbp2co8iDF1vW0LWPeLFBinCgItcI9LvgHWaB3rwjOfvNpMn5m64SoQYHB8wbnid
 erAjOzkBzmqnfS1tAUr8mtESStEwrEmNv0ZoA6S0Wt+c9pyTr+BpG4OFlhj7ZI+Eh7zOrr33
 q9OBIdA=
Message-ID: <3614849d-12a5-fa43-fb10-801e9648b40e@twiddle.net>
Date: Thu, 6 Feb 2020 15:35:08 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <BYAPR02MB48863BDFCB4CB26717467579DE1D0@BYAPR02MB4886.namprd02.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
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
Cc: Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/6/20 2:03 PM, Taylor Simpson wrote:
> Some of the more complex instructions need a lot of operands.  Here's an example
>     if (Pv4) memb(Rs32 + Ru32 << #u2) = Rt32
> This is a predicated store with 5 operands:
>     Pv4predicate
>     Rs32, Ru32, u2used to compute the effective address
>     Rt32value to store
> In addition, every helper gets an env argument, and predicated instructions get a "slot" argument.  The slot argument refers to the VLIW slot where the instruction is located within the packet.  It is used for predicated instructions to communicate to the end-of-packet handling to determine whether the instruction should commit.
> 
> So, the signature for the helper for this instruction is
>     void HELPER(S4_pstorerbt_rr)(CPUHexagonState *env, int32_t PvV, int32_t RsV, int32_t RuV, int32_t RtV, int32_t uiV, uint32_t slot)


I think this is quite ugly.  I know you've been talking about auto-generating
everything but we ought to do better than this.

You should be passing values not regnos if you can possibly do so.  You should
be passing full virtual addresses not N separate components of an address.
Predicates should be evaluated earlier so that the helper isn't even called if
it's false.

Combine that with 3.3.1 Packet execution semantics, "dual stores, new-value
stores, and slot1 store with slot0 loads have non-parallel execution
semantics", and you need no special helper at all:

	and	t0, pv, 1
	brcondi	t0, 0, over

	shli	t0, ru, u2
	add	t0, t0, rs
	qemu_st	rt, t0, mmu_idx, MO_UB
 over:

But suppose this were something more complicated than a bare store, and the
point still stands about pre-computing full addresses.


r~

