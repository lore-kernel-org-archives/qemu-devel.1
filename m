Return-Path: <SRS0=ht5U=YL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6BAECA9EA9
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 18:33:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 87E9520869
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 18:33:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="lwfcWTFW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87E9520869
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45000 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iLX3o-0003Nn-Oy
	for qemu-devel@archiver.kernel.org; Fri, 18 Oct 2019 14:33:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36915)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <palmer@sifive.com>) id 1iLX36-0002jX-G9
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 14:32:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <palmer@sifive.com>) id 1iLX35-0001NF-CT
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 14:32:28 -0400
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:46670)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <palmer@sifive.com>) id 1iLX35-0001MW-4J
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 14:32:27 -0400
Received: by mail-pl1-x642.google.com with SMTP id q24so3229532plr.13
 for <qemu-devel@nongnu.org>; Fri, 18 Oct 2019 11:32:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com; s=google;
 h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
 :content-transfer-encoding;
 bh=HAUmOseX66QM1+mqec9EYCYFOyrXvIYQaZDTqVpKx6I=;
 b=lwfcWTFWSws9MY8EpIVt7eX7/8JvOCW7NBaVld2Lky7pNKlghNybFWioHXgQSKl6jO
 GB+cwHa5MeL6kp1nYTjb9thNb7TXOXGExnZC7zaD3rF7R60px0GVpuR5mosx89dKDiOI
 ctaF7BsVmYkp/tqxtGjCc0WMUE0kFmuTxlf9xAKtJ/m3pCmtYaZrhdH2LCzdQQgjrImz
 ol6ME/spF7QBzbJPsn54rUG5SheQ+4clIsb9yP0G8tJdjzJxWTHhMyZX1aCijSYxpBBW
 vh8teXjyafgUdrDi2pp1wmznIsOJLaSYaUkecjU0hH7ZxP358mMbCowBV7asewT8mEGB
 k5JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
 :mime-version:content-transfer-encoding;
 bh=HAUmOseX66QM1+mqec9EYCYFOyrXvIYQaZDTqVpKx6I=;
 b=VQoUV8kxwi8yO40Ji+yWPIJ6ugb7jZp3m75ElxcKGoFca1o9jUdMIBrHfSGmvYNQ+0
 /meBqMyNclhZgLz1AerfcDP6lJUBxzCIU6FYFrsPMBqTf9dwVy3wz/GonvmmAXYyzAoq
 3VTqFSyhwLGv/WsK30YJWUiVJJDt9hUxV6XQ9wh7EbCeObY8bHEP1Xa9z0GUOA5cVb9J
 mlEW9ny7EmMklBooC5c8Nma0zQbqD3q+GD+nSuDcTCE/Hf1R5GKhsnBNO59SNsCg6P+S
 OlAtGqnQB9x2DIauZgh8VhJl5+JlHbXeQUotplg4u+WthBV2KzsoRt5kmoSCk+frHMkd
 Mn1A==
X-Gm-Message-State: APjAAAXyMvoluY1FJWM9RJLfP17cvENw5MzmdFzU/z+gUmiwL4FpJlbu
 r2NKvvgXmTzMmzDzl4thTAIYIg==
X-Google-Smtp-Source: APXvYqxOknLzfIuZFLrgLbHtpStrxp2BeyZT9CBVMRRxVCPXe8hEfT/jagwj1NT/YQaZY60NLNOCFQ==
X-Received: by 2002:a17:902:209:: with SMTP id 9mr11896441plc.25.1571423546046; 
 Fri, 18 Oct 2019 11:32:26 -0700 (PDT)
Received: from localhost ([152.179.112.46])
 by smtp.gmail.com with ESMTPSA id v1sm11626338pfg.26.2019.10.18.11.32.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Oct 2019 11:32:25 -0700 (PDT)
Date: Fri, 18 Oct 2019 11:32:25 -0700 (PDT)
X-Google-Original-Date: Fri, 18 Oct 2019 11:31:52 PDT (-0700)
Subject: Re: [PATCH v5 31/55] target/riscv: fetch code with translator_ld
In-Reply-To: <CAKmqyKPCYwYvD3hqJ1OW0KH3SjGpG7cypJw9V5sCg6bZ9ueUfw@mail.gmail.com>
From: Palmer Dabbelt <palmer@sifive.com>
To: alex.bennee@linaro.org, alistair23@gmail.com
Message-ID: <mhng-50bafce3-ff74-4a1a-b3fe-cdc21a85e7af@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::642
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
Cc: qemu-riscv@nongnu.org, sagark@eecs.berkeley.edu,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 robert.foley@futurewei.com, richard.henderson@linaro.org,
 qemu-devel@nongnu.org, peter.puhov@futurewei.com, aaron@os.amperecomputing.com,
 cota@braap.org, Alistair Francis <Alistair.Francis@wdc.com>,
 alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 14 Oct 2019 10:59:07 PDT (-0700), alistair23@gmail.com wrote:
> On Mon, Oct 14, 2019 at 4:20 AM Alex Bennée <alex.bennee@linaro.org> wrote:
>>
>> From: "Emilio G. Cota" <cota@braap.org>
>>
>> Signed-off-by: Emilio G. Cota <cota@braap.org>
>> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
>> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
>
> Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

and

Acked-by: Palmer Dabbelt <palmer@sifive.com>

as I'm assuming this will go in with the rest of the patch set.

>
> Alistair
>
>> ---
>>  target/riscv/translate.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/target/riscv/translate.c b/target/riscv/translate.c
>> index adeddb85f6..b26533d4fd 100644
>> --- a/target/riscv/translate.c
>> +++ b/target/riscv/translate.c
>> @@ -779,7 +779,7 @@ static void riscv_tr_translate_insn(DisasContextBase *dcbase, CPUState *cpu)
>>      DisasContext *ctx = container_of(dcbase, DisasContext, base);
>>      CPURISCVState *env = cpu->env_ptr;
>>
>> -    ctx->opcode = cpu_ldl_code(env, ctx->base.pc_next);
>> +    ctx->opcode = translator_ldl(env, ctx->base.pc_next);
>>      decode_opc(ctx);
>>      ctx->base.pc_next = ctx->pc_succ_insn;
>>
>> --
>> 2.20.1
>>
>>

