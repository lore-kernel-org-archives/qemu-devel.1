Return-Path: <SRS0=VgPO=WQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C3D9C3A589
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2019 16:02:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 66F122070B
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2019 16:02:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ImxOm+/O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66F122070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39044 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i06aX-0003tz-TM
	for qemu-devel@archiver.kernel.org; Tue, 20 Aug 2019 12:02:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40674)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1i06Y8-0001bt-Ac
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 11:59:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1i06Y7-00065O-4B
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 11:59:56 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:41515)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1i06Y6-00064g-S9
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 11:59:55 -0400
Received: by mail-pg1-x542.google.com with SMTP id x15so3489901pgg.8
 for <qemu-devel@nongnu.org>; Tue, 20 Aug 2019 08:59:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=GjDE62/c3Wz3dk2WQ/hznAktymAzoNipjn6QtKQK/mk=;
 b=ImxOm+/OznSmsWW+Wb9YGCQ99TBDDic8kSIdh6GbDgvZhzx/Fis33V0cadGpwYywxV
 mteseV+9/DqXxgnWqmgNKberIo4qbxgUHSGODOFGZjEXK4rZsnzQn2P+pI7+8LH20uyB
 tK8d1UxyxDg/FoLXFICb8AMxZMycmj4fEWR4oN+c/mjI3VGtpRJ2424DNfJMu0QjBph0
 elhaeehY+rtkGiJk8FIAibHDZlgo5+UfoizC/wGirXSxfgEU1J17AEWSq6VvnotNKZha
 A4ezBlZTT15mcjZlzhN+0Gn/F3CdofWbJpW6hUjyCfUJ7jU6MrQu8DFA9549mftYr9ME
 2UaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=GjDE62/c3Wz3dk2WQ/hznAktymAzoNipjn6QtKQK/mk=;
 b=iRpGL+7l4X/ehRG9Oid5I/et5upT+duko7zzcVP22I0Rsv+WbY+Gz7kTNUN1QSn5Sq
 j0r9ub4GpRjC7iU/roh7E5kQk60roj9HErfjIt4ykV9HyQSVXGdwDSfmfVSmWfJu7X1S
 0bVisKtii2xLc4hXLBz8+INF+UXqrksUEn9RNBvsKRh4jvFP8vBLBoUieQgxjrpeXvfe
 xwJCCMJltvIumoJ+GYSO1sVzR7YeJlzlTt7m4NKbsSRanTCbyrUAfbS04jH2THtRVe/+
 5jGqhex9pe0ccf9Bf5uRfjTq8A3MJxWCF0/7uTmJFrqcqhyqNLYLCg4Rx74SwnWDbjFu
 vkzQ==
X-Gm-Message-State: APjAAAUadAYMJrOT9nwbGfsQmtkHLYppiOjtOH+W9Ri2JXGyR0gOwrgG
 z5oYOUMnDn9ptJOvnT3bQi0wyQ==
X-Google-Smtp-Source: APXvYqzkJ+BnHRFqVHJtwG/wmCSQGCiQFuIDGJSqIfQiWEV2Gw39r28XG5GOF6ckWAdumkM578+Udg==
X-Received: by 2002:a17:90a:8591:: with SMTP id
 m17mr733884pjn.100.1566316793536; 
 Tue, 20 Aug 2019 08:59:53 -0700 (PDT)
Received: from [192.168.1.11] (97-113-7-119.tukw.qwest.net. [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id v145sm22283043pfc.31.2019.08.20.08.59.51
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 20 Aug 2019 08:59:52 -0700 (PDT)
To: Peter Maydell <peter.maydell@linaro.org>
References: <20190803210803.5701-1-richard.henderson@linaro.org>
 <20190803210803.5701-5-richard.henderson@linaro.org>
 <CAFEAcA-_gMkE-0kA=xyUyNKxeqX0n6B-9i_7132xfFXQNRqb6w@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <7c739082-c1d5-ad03-0020-9776cf08694a@linaro.org>
Date: Tue, 20 Aug 2019 08:59:50 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-_gMkE-0kA=xyUyNKxeqX0n6B-9i_7132xfFXQNRqb6w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::542
Subject: Re: [Qemu-devel] [PATCH v7 4/6] include/elf: Add defines related to
 GNU property notes for AArch64
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
Cc: qemu-arm <qemu-arm@nongnu.org>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Dave P Martin <Dave.Martin@arm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/20/19 8:39 AM, Peter Maydell wrote:
> On Sat, 3 Aug 2019 at 22:08, Richard Henderson
> <richard.henderson@linaro.org> wrote:
>>
>> These are all of the defines required to parse
>> GNU_PROPERTY_AARCH64_FEATURE_1_AND, copied from binutils.
>> Other missing defines related to other GNU program headers
>> and notes are elided for now.
>>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> 
> What's the authoritative source for these definitions? I
> tried looking in glibc, binutils and the kernel without
> any luck.

Presumably the true "authoritative" source is an ARM document, but I don't have
that handy.

For binutils, the defines are in include/elf/common.h:

https://sourceware.org/git/?p=binutils-gdb.git;a=blob_plain;f=include/elf/common.h;hb=HEAD

The upstream kernel is also lacking the defines, as they're part of the ARM
patch set that is still in flight.  The defines are still not present in glibc
as of today.


r~

