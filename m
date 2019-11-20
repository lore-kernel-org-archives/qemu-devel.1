Return-Path: <SRS0=6hMH=ZM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D8CAC432C0
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 08:07:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 681B5219FA
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 08:07:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MEZPtfLZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 681B5219FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54528 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXL1Q-0006bm-Jh
	for qemu-devel@archiver.kernel.org; Wed, 20 Nov 2019 03:07:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43809)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iXL0a-00069w-WE
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 03:06:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iXL0Y-0004K0-UT
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 03:06:40 -0500
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:33445)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iXL0Y-0004I8-LW
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 03:06:38 -0500
Received: by mail-wr1-x443.google.com with SMTP id w9so26958622wrr.0
 for <qemu-devel@nongnu.org>; Wed, 20 Nov 2019 00:06:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=rPh3Jc/7A2awgQ/1rLSfczKNYcD0wLjmWo1XVsrZNyQ=;
 b=MEZPtfLZncGo8o/ux+RXb5+PN9yRD1oQfBlYrZv0JlO5q93nfmLveKBKZVt11HTAUy
 P5UZjnZiTlg4Q7mqOwBw/nt5zy6w5SDHHIXZf23bBbgOKNfZNm5P236h0iS7Q7gzgVWT
 aOd7uxK8vX52NqK/tmaq7PLhNZ6i0/iRoSR2pNDachWcA5Bg7SlGsKEBipT8jO7zHr1U
 BogdX2SpZE7mW5ohcOi0Nl+XPKO8tvg6I8KxiIXLRe/JwrNFzls+nGR67CqGg9B/OiD7
 47n1PyLLzNh+Cs/VH211i3RgW7eWfOVWHVz16AuJnhN0jZvoQ9zv/1uhTdAvEhfhr3GL
 481w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=rPh3Jc/7A2awgQ/1rLSfczKNYcD0wLjmWo1XVsrZNyQ=;
 b=EjjwEnc4Txk9w4wFN9ar9Yfm3Wn663mSgUcdlEGuqTa9TDsbkU84mUzz9Z5XPwqGF9
 NhbHIePRZ1bZsRfSOULznC9s+FLNCr4x84GgZgfSlFRIjCQFf8K7RjioRNSajOxyHpSb
 jYYL3f8TyQqO+fYQ5SOBiChP2EhzCs3dZXzQxdSK+a/JrX9i6Axf+HVOsTbDK9VWDvjT
 fwSM5kCURW8lpGpkt4BV2NRASllE8kDLuWv279Mh+1fiS/jYv0MudGHh4s94w8DELq55
 Glhm9TJBNmHF6xjgROn+AlRGrhcUL+7K09kvPFQACIaRFHRVxRX2nPbvaZXItQlQr5T6
 Ui+w==
X-Gm-Message-State: APjAAAWOw4ZxUJ+BNSPAFKD/DBGLIYSG+MuG6JHVfG2NZcFoH0uEmvDE
 v3sidM3OcUH9fQQsfJRprkzoePt2lSqHcQ==
X-Google-Smtp-Source: APXvYqyKPKWSSKr6XVEPeL+buczWe15eG9WzgANsQz3ZQ/BCwG2KE7isF89CnQr0qC+IEuf6FPtuMA==
X-Received: by 2002:adf:ec44:: with SMTP id w4mr1649553wrn.274.1574237197182; 
 Wed, 20 Nov 2019 00:06:37 -0800 (PST)
Received: from [192.168.8.102] (253.red-37-10-245.dynamicip.rima-tde.net.
 [37.10.245.253])
 by smtp.gmail.com with ESMTPSA id m3sm29708036wrw.20.2019.11.20.00.06.35
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 20 Nov 2019 00:06:36 -0800 (PST)
Subject: Re: [PATCH] Add minimal Hexagon target - First in a series of patches
 - linux-user changes + linux-user/hexagon + skeleton of
 target/hexagon -
 Files in target/hexagon/imported are from another project and therefore do
 not conform to qemu coding standards
To: Taylor Simpson <tsimpson@quicinc.com>,
 "laurent@vivier.eu" <laurent@vivier.eu>,
 "riku.voipio@iki.fi" <riku.voipio@iki.fi>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
References: <1574121497-2433-1-git-send-email-tsimpson@quicinc.com>
 <41e0e646-f595-be14-fc31-12a5ec090dcb@linaro.org>
 <BYAPR02MB4886DFE6DB0E6400B9409154DE4F0@BYAPR02MB4886.namprd02.prod.outlook.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <4b0ce6f3-f9a2-68a6-910c-f9830c34585c@linaro.org>
Date: Wed, 20 Nov 2019 09:06:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <BYAPR02MB4886DFE6DB0E6400B9409154DE4F0@BYAPR02MB4886.namprd02.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/20/19 6:15 AM, Taylor Simpson wrote:
>> +const char * const hexagon_prednames[] = {
>> +  "p0 ", "p1 ", "p2 ", "p3 "
>> +};
> 
> Inter-string spacing probably belongs to the format not the name.
> [Taylor] Could you elaborate?  Should I put spacing  after the commas?

"p0" not "p0 ".  Typo on my part for "inter-"; sorry for the confusion.

>> +static inline target_ulong hack_stack_ptrs(CPUHexagonState *env,
>> +                                           target_ulong addr) {
>> +    target_ulong stack_start = env->stack_start;
>> +    target_ulong stack_size = 0x10000;
>> +    target_ulong stack_adjust = env->stack_adjust;
>> +
>> +    if (stack_start + 0x1000 >= addr && addr >= (stack_start - stack_size)) {
>> +        return addr - stack_adjust;
>> +    }
>> +    return addr;
>> +}
> 
> An explanation would be welcome here.
> [Taylor]  I will add a comment.  One of the main debugging techniques is to use "-d cpu" and compare against LLDB output when single stepping.  However, the target and qemu put the stacks in different locations.  This is used to compensate so the diff is cleaner.

Ug.  I understand why you want this, but... ug.


>> +static void hexagon_dump(CPUHexagonState *env, FILE *f) {
>> +    static target_ulong last_pc;
>> +    int i;
>> +
>> +    /*
>> +     * When comparing with LLDB, it doesn't step through single-cycle
>> +     * hardware loops the same way.  So, we just skip them here
>> +     */
>> +    if (env->gpr[HEX_REG_PC] == last_pc) {
>> +        return;
>> +    }
> 
> This seems mis-placed.
> [Taylor] Hexagon has hardware controlled loops, so we can have a single packet that executes multiple times.  We don't want the dump to print every time.

Certainly I do.  If I'm single-stepping, I want every packet present.  Just as
if this were written as a traditional loop, with a branch back to the single
packet in the loop body.

Also, you cannot expect a static variable to work in multi-threaded mode, and
you cannot expect a __thread variable to work in single-threaded round-robin mode.

>> +static void decode_packet(CPUHexagonState *env, DisasContext *ctx) {
>> +    size4u_t words[4];
>> +    int i;
>> +    /* Brute force way to make sure current PC is set */
>> +    tcg_gen_movi_tl(hex_gpr[HEX_REG_PC], ctx->base.pc_next);
> 
> What's this for?
> [Taylor] Honestly, I'm not sure.  If I remove it, nothing works - not even "hello world".

Weird.  I would have expected that the update you do within hexagon_tr_tb_stop
would be sufficient.  I guess I'll have to peek at it.

I presume your minimal test case is a bit of hand-crafted assembly that issues
a write syscall and exit?

>> +
>> +    for (i = 0; i < 4; i++) {
>> +        words[i] = cpu_ldl_code(env, ctx->base.pc_next + i * sizeof(size4u_t));
>> +    }
> 
> And this?
> [Taylor] It's reading from the instruction memory.  The switch statement below uses it.

I thought packets are variable length and ended by a bit set.  Therefore why
the fixed iteration to 4?  Also...

> 
>> +    /*
>> +     * Brute force just enough to get the first program to execute.
>> +     */
>> +    switch (words[0]) {

... you only use 1 word, but you read 4.

>> +static void hexagon_tr_init_disas_context(DisasContextBase *dcbase,
>> +                                          CPUState *cs) {
>> +    DisasContext *ctx = container_of(dcbase, DisasContext, base);
>> +
>> +    ctx->mem_idx = ctx->base.tb->flags & TB_FLAGS_MMU_MASK;
> 
> Since you're not initializing this in cpu_get_tb_cpu_state, you might as well just use
> 
>     ctx->mem_idx = MMU_USER_IDX;
> [Taylor] Should I be initialize this in cpu_get_bt_cpu_state?

Not until there's something more interesting to put there, when you implement
system state.  The constant initialization should be fine.


r~

