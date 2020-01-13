Return-Path: <SRS0=PCRa=3C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CF5DC33CA9
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jan 2020 19:55:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 655EE2080D
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jan 2020 19:55:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gQLXOLn8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 655EE2080D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55136 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ir5oF-0001nI-6F
	for qemu-devel@archiver.kernel.org; Mon, 13 Jan 2020 14:55:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43116)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1ir5mj-0007zk-Ar
 for qemu-devel@nongnu.org; Mon, 13 Jan 2020 14:54:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1ir5mg-0008By-NO
 for qemu-devel@nongnu.org; Mon, 13 Jan 2020 14:54:00 -0500
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:35086)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1ir5mg-0008AN-Fv
 for qemu-devel@nongnu.org; Mon, 13 Jan 2020 14:53:58 -0500
Received: by mail-pf1-x444.google.com with SMTP id i23so5376729pfo.2
 for <qemu-devel@nongnu.org>; Mon, 13 Jan 2020 11:53:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=jsBmnwYTKDEm1rL2oc5bwMC0OishNQDVPWSB0rTU5kc=;
 b=gQLXOLn8623DZ2sNHHCDZV26QkQx7tAAdbEHImb0UdvXc45LFhVhk1Fh8k4K4C6g8O
 uY9/WlJZ/dQJ2Hx2NMJMcFAPuMOlXmizMTmN4jhQsVnXYt5uaUjR6XMYKKMiSsfOLG74
 Bzlgcx0dxng1/QCO4AqiwvnNUzhyDp6ZfBFNy5kexoUqJefeEt0VPf//6404WRy43S5H
 fuYLHC0tv2Hj5utL/dmPelGV6COCbzS0K0DR863NcnFM8CeyqtHMohxLtrWvEGOn60m2
 C2fM6zn00wsof9YBSWBWrlr5WpTKHgfLG9jgxUQYztHMgFjli9HOY75TF06FPZH4wZsy
 DVFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=jsBmnwYTKDEm1rL2oc5bwMC0OishNQDVPWSB0rTU5kc=;
 b=KOJpXb0WcyNBHJBAE5xGWPBnnBIkTy4NTpD9T2pB9Q3ipPDoUqFkh7qSAlIkxqO1FV
 sbQroY7WXnT2oDi8XGB1+/Q+mtO15X5veJKsmxCMFzfHRj6Kg5B8WHgb5GLhzhFh0x5Y
 YzPXgxlNtEkHi/006OhzSK1X90UFDUocyFBG2xeSM5IXICnhfiocoNSrLzfH+ekHbrsh
 NBrq10wCS74uzQ3cx0H1eWRRp0wjBscbz/GxgD4tWyh1yY26ewN0Ml7pSstvJXJNMZmD
 +xfyQD9+fMycZnBe9uPCJhfhrPxzAzJm8UXQQXFLw6tnCV+fjoS7BYP1vOc9S9QGSZfl
 ++lQ==
X-Gm-Message-State: APjAAAVnf6+osq0t/t/ZbcAM72XMIuDIlqdFZrvDXD/KizozySxxKrUy
 Epc7IQxwvRsxbvICCCJrWdqISP/svwY=
X-Google-Smtp-Source: APXvYqxOObOhpIwGPDUODQBb1ISG8ejJNl1S6GRFMJsTqDUAcutMxCGF6DGHfARxX/lTBc/GJ0FgcQ==
X-Received: by 2002:a63:b64a:: with SMTP id v10mr23110908pgt.145.1578945236322; 
 Mon, 13 Jan 2020 11:53:56 -0800 (PST)
Received: from [192.168.3.43] (rrcs-66-91-136-155.west.biz.rr.com.
 [66.91.136.155])
 by smtp.gmail.com with ESMTPSA id j17sm14934357pfa.28.2020.01.13.11.53.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 13 Jan 2020 11:53:55 -0800 (PST)
Subject: Re: [PULL 0/3] capstone update
To: Peter Maydell <peter.maydell@linaro.org>
References: <20200108042338.9082-1-richard.henderson@linaro.org>
 <CAFEAcA-AYKxnTW6w1xnbP0sbk-_8pV3UdfOotPmSHqNmj_Kjkg@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <100c3aab-a198-f1fd-6ae2-7671c3039d8d@linaro.org>
Date: Mon, 13 Jan 2020 09:53:52 -1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-AYKxnTW6w1xnbP0sbk-_8pV3UdfOotPmSHqNmj_Kjkg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/10/20 6:07 AM, Peter Maydell wrote:
> On Wed, 8 Jan 2020 at 04:23, Richard Henderson
> <richard.henderson@linaro.org> wrote:
>>
>> The following changes since commit 035eed4c0d257c905a556fa0f4865a0c077b4e7f:
>>
>>   Merge remote-tracking branch 'remotes/vivier/tags/q800-for-5.0-pull-request' into staging (2020-01-07 17:08:21 +0000)
>>
>> are available in the Git repository at:
>>
>>   https://github.com/rth7680/qemu.git tags/pull-cap-20200108
>>
>> for you to fetch changes up to 7cc3836eac04a3e358b2496fbca704b3ee5197ae:
>>
>>   capstone: Add skipdata hook for s390x (2020-01-08 14:53:54 +1100)
>>
>> ----------------------------------------------------------------
>> Update capstone to next
>>
>> ----------------------------------------------------------------
>> Richard Henderson (3):
>>       capstone: Update to next
>>       capstone: Enable disassembly for s390x
>>       capstone: Add skipdata hook for s390x
> 
> Build failures:
> 
>   CC      aarch64-linux-user/disas.o
> In file included from
> /home/ubuntu/qemu/capstone/include/capstone/capstone.h:302:0,
>                  from /home/ubuntu/qemu/include/disas/capstone.h:6,
>                  from /home/ubuntu/qemu/disas.c:9:
> /home/ubuntu/qemu/capstone/include/capstone/riscv.h:16:10: fatal
> error: capstone/platform.h: No such file or directory
>  #include "capstone/platform.h"
>           ^~~~~~~~~~~~~~~~~~~~~
> compilation terminated.
> 
> (same on most hosts)

This comes from not re-running configure, which changes the CFLAGS for the
build of capstone from git.  Given that the source tree for capstone got
rearranged between 3.x and 4.0, I don't see how I can avoid this.

> aarch64 host had this complaint instead:
> 
> /home/pm/qemu/disas.c:187:1: error: expected ‘=’, ‘,’, ‘;’, ‘asm’ or
> ‘__attribute__’ before ‘cap_skipdata_s390x_cb’
>  cap_skipdata_s390x_cb(const uint8_t *code, size_t code_size,
>  ^~~~~~~~~~~~~~~~~~~~~
> /home/pm/qemu/disas.c:211:17: error: ‘cap_skipdata_s390x_cb’
> undeclared here (not in a function); did you mean
> ‘cap_skipdata_s390x’?
>      .callback = cap_skipdata_s390x_cb
>                  ^~~~~~~~~~~~~~~~~~~~~
>                  cap_skipdata_s390x

Hmm.  Replicated on qemu-test.  There seems to have been an api change within
the 3.x series.


r~


