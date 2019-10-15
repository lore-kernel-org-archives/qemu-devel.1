Return-Path: <SRS0=6OCO=YI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15518ECE588
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2019 11:16:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D4E6C21835
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2019 11:16:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZjV7P2un"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4E6C21835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41304 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iKKor-0004bX-Un
	for qemu-devel@archiver.kernel.org; Tue, 15 Oct 2019 07:16:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54477)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iKKng-00048X-Nk
 for qemu-devel@nongnu.org; Tue, 15 Oct 2019 07:15:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iKKnf-0000Zb-Hu
 for qemu-devel@nongnu.org; Tue, 15 Oct 2019 07:15:36 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:53570)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iKKnf-0000Z8-Am
 for qemu-devel@nongnu.org; Tue, 15 Oct 2019 07:15:35 -0400
Received: by mail-wm1-x341.google.com with SMTP id i16so20409374wmd.3
 for <qemu-devel@nongnu.org>; Tue, 15 Oct 2019 04:15:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=CwKxY0sIZHpT7vnqE7rCLremCaSd/WFvL0xL/FY/kPE=;
 b=ZjV7P2unNnwc3uNxUsv/KPX077g3E0s3TBGre4UCPip9oyLg+ge7P8c8SIQkIPoaAx
 3ew6H11p23kzxO6A5Ljb6B2Mg67ZodL34MtS8t3x9wNFkK+dhAObFdwg8ZdmOwZrcKvU
 Da0jRsDwaA5UFo2bCaQ0w4WXMi5oGkDAPD5aSsyO7x9EraRPqEX2ROEalyStRwS/YSdf
 C4V36UYpyNTztywJoT7lvyllhQ+qBynCaJuaZNSPzwzUPQpYuv91mLpOX/WDSPAUu/oT
 rfUzEBPHv8hTQ64n9CdVALz9ZO7NgJ4qocgG3Dsjz4J4RaFStLzpn3R9q51cIFbk3dqX
 cDfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=CwKxY0sIZHpT7vnqE7rCLremCaSd/WFvL0xL/FY/kPE=;
 b=foTPHi7q7BF1V+zuoD8DNWoI25xKWj4djdtQBP3O3CHYg7vdl3LpNCllJLKKvVg+3/
 1oq8+9G5DbaNu2foSzad3bMepP8xWNFcNaS1U+CWJB7VoXMrfquLCN7WZq2vs5Rvt9hF
 O+A9BBwLeo0XxR86cyGXFyUZiXKfbiRN31HlFmvC5reJwHGiG7teXDZ09lRft6m8sq0Y
 4Im43dXFGEgwH7vaBpX8gNXxyB94hi5TOkNKtLdmFFjbhWDZLQbTDWm9qKXJrgeTyBfl
 l+voBTsSJseaAH59/dlAciP4RI7/0aUeQd2PYoradKoM4TtpRZ/4zvISwiXAfHLcvlBp
 tISw==
X-Gm-Message-State: APjAAAVtJZCxSl6i8l6ZcCoBRY8DjjvJy7siuTVVouwrfffGn2VDPNLH
 Wx3uq6RQ7szcNJxIyPreN2FmVg==
X-Google-Smtp-Source: APXvYqxTVAOBBirl+ygMVU4AVyeBF+gM/AjOHRmxmKAiYrzMspfVHatn+5EyCLdVWmt5o6q1Wq+l3Q==
X-Received: by 2002:a05:600c:c1:: with SMTP id
 u1mr17493421wmm.87.1571138133438; 
 Tue, 15 Oct 2019 04:15:33 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id a9sm32517479wmf.14.2019.10.15.04.15.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Oct 2019 04:15:32 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 989F01FF87;
 Tue, 15 Oct 2019 12:15:31 +0100 (BST)
References: <20191014104948.4291-1-alex.bennee@linaro.org>
 <20191014104948.4291-3-alex.bennee@linaro.org>
 <32a1628d-55a1-fd1a-31c2-56bef720855f@linaro.org>
User-agent: mu4e 1.3.5; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH v5 02/55] trace: add mmu_index to mem_info
In-reply-to: <32a1628d-55a1-fd1a-31c2-56bef720855f@linaro.org>
Date: Tue, 15 Oct 2019 12:15:31 +0100
Message-ID: <871rvemf8s.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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
Cc: robert.foley@futurewei.com, Riku Voipio <riku.voipio@iki.fi>,
 qemu-devel@nongnu.org, peter.puhov@futurewei.com, aaron@os.amperecomputing.com,
 cota@braap.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Richard Henderson <richard.henderson@linaro.org> writes:

> On 10/14/19 3:48 AM, Alex Benn=C3=A9e wrote:
>> diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
>> index defc8d5929..1210d8f243 100644
>> --- a/accel/tcg/cputlb.c
>> +++ b/accel/tcg/cputlb.c
>> @@ -1811,6 +1811,7 @@ void helper_be_stq_mmu(CPUArchState *env, target_u=
long addr, uint64_t val,
>>  #define ATOMIC_MMU_DECLS
>>  #define ATOMIC_MMU_LOOKUP atomic_mmu_lookup(env, addr, oi, retaddr)
>>  #define ATOMIC_MMU_CLEANUP
>> +#define ATOMIC_MMU_IDX oi
>
> That is not the mmu_idx.  That's the whole mmu_idx + MemOp combo.
> Use get_mmuidx(oi).

Oops I missed that from last time. Fixing it for real now!

>
>> --- a/accel/tcg/user-exec.c
>> +++ b/accel/tcg/user-exec.c
>> @@ -751,6 +751,7 @@ static void *atomic_mmu_lookup(CPUArchState *env, ta=
rget_ulong addr,
>>  #define ATOMIC_MMU_DECLS do {} while (0)
>>  #define ATOMIC_MMU_LOOKUP  atomic_mmu_lookup(env, addr, DATA_SIZE, GETP=
C())
>>  #define ATOMIC_MMU_CLEANUP do { clear_helper_retaddr(); } while (0)
>> +#define ATOMIC_MMU_IDX 0
>
> MMU_USER_IDX.  Best to be consistent, even if this is user-only and it is=
n't
> really used.
>
>> --- a/include/exec/cpu_ldst_useronly_template.h
>> +++ b/include/exec/cpu_ldst_useronly_template.h
>> @@ -73,7 +73,7 @@ glue(glue(cpu_ld, USUFFIX), MEMSUFFIX)(CPUArchState *e=
nv, abi_ptr ptr)
>>  #else
>>      trace_guest_mem_before_exec(
>>          env_cpu(env), ptr,
>> -        trace_mem_build_info(SHIFT, false, MO_TE, false));
>> +        trace_mem_build_info(SHIFT, false, MO_TE, false, 0));
>
> Likewise for the other uses in this file.

Fixed.

>
>
> r~


--
Alex Benn=C3=A9e

