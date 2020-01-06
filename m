Return-Path: <SRS0=kvq2=23=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDB3DC33C8C
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2020 22:03:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 97B652072A
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2020 22:03:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="UPTvqpgQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97B652072A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40384 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ioaSj-0007tk-OX
	for qemu-devel@archiver.kernel.org; Mon, 06 Jan 2020 17:03:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42775)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jimw@sifive.com>) id 1ioaR6-0006i6-8M
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 17:01:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jimw@sifive.com>) id 1ioaR4-0000rr-HI
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 17:01:19 -0500
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:39496)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <jimw@sifive.com>) id 1ioaQy-0000WA-W2
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 17:01:14 -0500
Received: by mail-pf1-x444.google.com with SMTP id q10so27552161pfs.6
 for <qemu-devel@nongnu.org>; Mon, 06 Jan 2020 14:01:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=eIXY5MB6DFXwDUd8nfBhLukv4Uq83GqZqYlWJpk0xAI=;
 b=UPTvqpgQIfl9fkVSraGzLtyJH6ItVx5az0MwIAp6PBBro6EVzYj/1Vh/PE9i5aF/wO
 5UhdG96xsM66sIupfy4rQMupc+62QymxM3qVaCRcoI7xv1m8z7TAyWWsYPO1NHJZ93fT
 mUSGvxiRlZe9FagiL/3PGPQBI9Zsq6Hvzm2CyJoqI6yegY+0AKLgvsTwiNdMTZjL/Cux
 HlOqLEPWONJ7DjnC/Ro4RBVLNsUzIxYIinfCE52BWFRkiqyjgkxqdea9wVTb0ToVURII
 l6EAX4g2H9n+XNKqWHLMLf2mswQAXsRXUK3En+/tJdLvIt4w9gkRpfbFJGEFIoIcjdtC
 L4wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=eIXY5MB6DFXwDUd8nfBhLukv4Uq83GqZqYlWJpk0xAI=;
 b=YpGc2GLOOC/2speWevNGtFt3IloxZKC62QwKwPpW+w6HoCKLo8YJFYYcRAW76z/1XC
 ApzVLdp1Tf4bmFELgyHdFJ4ROYVrNQHIDB8LVTSAi6sf4RV1lrwUCjOENTk4M8mixjIO
 uHe33ifIzoYQWRUZjxh2LzLtwrDZ235tqpqSThAEHcWN6YyfCEU6ZxQy9qYlKFyoenlK
 C5XqNJ1ashv1ygsVdila6CJYVqsiS2o8KVTXij3RE+1TwvAPFgLjZsE54g4b2mQCPFLg
 QtYYZ3t70GUUC/jyHtSuOGkzKJg7O4VfGqCdzwnT/xyFl3TW1yVC1BZtKkkmKG9GgDIf
 n9Dg==
X-Gm-Message-State: APjAAAV0BP2QsMUQYlHJd6lX435feBlR8VbxgpOmQp7r6vORyd17/1V7
 6Hcy/ABKcn8RMIejXEMD9ZpGzg==
X-Google-Smtp-Source: APXvYqyxoR4WIR8JmRtKdxPWt8naeEf++uK7y/zkpeah9zErjZTFFfSLGTYPhqUcckUnSllYLnGCFg==
X-Received: by 2002:a63:4e22:: with SMTP id
 c34mr111151422pgb.214.1578348061357; 
 Mon, 06 Jan 2020 14:01:01 -0800 (PST)
Received: from [10.17.0.74] ([12.206.222.5])
 by smtp.gmail.com with ESMTPSA id j10sm25558164pjb.14.2020.01.06.14.01.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 Jan 2020 14:01:00 -0800 (PST)
Subject: Re: [PATCH v3 3/4] RISC-V: support vector extension csr
To: LIU Zhiwei <zhiwei_liu@c-sky.com>, alistair23@gmail.com,
 richard.henderson@linaro.org, chihmin.chao@sifive.com, palmer@dabbelt.com
References: <20200103033347.20909-1-zhiwei_liu@c-sky.com>
 <20200103033347.20909-4-zhiwei_liu@c-sky.com>
From: Jim Wilson <jimw@sifive.com>
Message-ID: <ec0fe07a-ae3d-6502-18fa-d89547d918aa@sifive.com>
Date: Mon, 6 Jan 2020 14:00:59 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200103033347.20909-4-zhiwei_liu@c-sky.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::444
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
Cc: wenmeng_zhang@c-sky.com, qemu-riscv@nongnu.org, qemu-devel@nongnu.org,
 wxy194768@alibaba-inc.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/2/20 7:33 PM, LIU Zhiwei wrote:
> Until v0.7.1 specification, vector status is still not defined for
> mstatus.

The v0.8 spec does define a VS bit in mstatus.

> @@ -107,11 +112,6 @@ static int pmp(CPURISCVState *env, int csrno)
>   /* User Floating-Point CSRs */
>   static int read_fflags(CPURISCVState *env, int csrno, target_ulong *val)
>   {
> -#if !defined(CONFIG_USER_ONLY)
> -    if (!env->debugger && !(env->mstatus & MSTATUS_FS)) {
> -        return -1;
> -    }
> -#endif
>       *val = riscv_cpu_get_fflags(env);
>       return 0;
>   }

This allows reads of fflags when it doesn't exist, and hence does not 
make much sense.  Instead of removing the code, you should add a check 
for the vector extension, since the vector extension requires that fcsr 
exist even if the base architecture doesn't include FP support.  Ideally 
this should use the VS bit, but if you don't have it then you can just 
check to see if the vector extension was enabled as a command line option.

While the vector spec says that fcsr must exist, it doesn't specify that 
the FP fields in fcsr are necessarily readable or writable when there is 
no FP.  It also doesn't specify whether the other FP related shadows of 
fcsr exist, like fflags.  This appears to have been left unspecified.  I 
don't think that you should be making fflags reads and writes work for a 
target with vector but without float.  I think it would make more sense 
to have fcsr behave 3 different ways depending on whether we have only 
F, only V, or both F and V.  And then we can support reads and writes of 
only the valid fields.

Jim

