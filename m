Return-Path: <SRS0=VgPO=WQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5294AC3A589
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2019 20:22:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1664720656
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2019 20:22:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MQGOJhxm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1664720656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41134 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0AeW-0003ix-3H
	for qemu-devel@archiver.kernel.org; Tue, 20 Aug 2019 16:22:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47365)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1i0Ado-0003GK-IM
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 16:22:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1i0Adn-0004gn-AM
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 16:22:04 -0400
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:41885)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1i0Adn-0004g5-2A
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 16:22:03 -0400
Received: by mail-pg1-x544.google.com with SMTP id x15so3847872pgg.8
 for <qemu-devel@nongnu.org>; Tue, 20 Aug 2019 13:22:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=qw9rSGk3vTZ3Vdf5mR691iEN/t8wlN6qDZ1nCHiADYU=;
 b=MQGOJhxmi7BBB8TxdV39I9CxsykmDmtv5R/8lyRU+ckwwUdDnv2ZR8I7k1lYxt84L3
 S3zv1gEg3oYt29U2q4m7jwoFyn8lQV3YOpJyySFY5DTW0AroK07zJRfL1AUDz+HAiLGk
 S5ML6hTqoKTDH0xAXvBwX/s8OENKZjHPpNTGYUgqDpJI5H0XPKNZTvgbSgEUDU4XPOMG
 OK9uP7mx2LvK3C121rjfl5iZ/dEqHt/x/pqUIhYeYodxxNSIX18PHJDiYY0PQY0dgt2r
 bxf/pklqo36Xq9gesmKqtouWg3sZt08+EMkmld9ma38f6CFSN1s6rvyQAguhRd2PY43J
 1J3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=qw9rSGk3vTZ3Vdf5mR691iEN/t8wlN6qDZ1nCHiADYU=;
 b=EA9jgscRZOuHzGGO8i5PbbZCbwLAfyqPnTA5ymp3hGUzlI+VVxDd/vPsF5ZCQKNoNU
 UAxNcwR6alc465Z3Fs3cF84YgsMn6+d/Jr5fl6TVjqUPJmHClZsQqTs/WDthFCejDhJZ
 uqpCR6jzCO3EeYnTqK3tLH0C//QC7POb8uEBtRBhLg/GPgAD6VmBP7oQky7UCZ7JRP9Q
 nbI7gIraLjRrHleLByfr1hL+KT7uln/+Z+Enpm+h1jjdoAoU44QkcSQFV2CWQK0zdq5I
 251OhDnx33IZ8hbYEICAEIs3Gfzb8bD/FJ2RUuRHNUz+e2Jc3JebSuQwHvAnrBwZinGt
 opzg==
X-Gm-Message-State: APjAAAWDb3C5W8SzdC6kegyrhdWouS9HOx+UMyYqgZ2CTdjFZ4eRwvlg
 AEytJ7acY/HLwo5qB9DU8ckr0A==
X-Google-Smtp-Source: APXvYqyAykS2iNKEtbWEtdBLIr14XVrpFPRhaooL2nokWWJ0nN0bkwsdp140aq+Gm9N3uFNL59TH2Q==
X-Received: by 2002:a65:62cd:: with SMTP id m13mr26089517pgv.437.1566332521964; 
 Tue, 20 Aug 2019 13:22:01 -0700 (PDT)
Received: from [192.168.1.11] (97-113-7-119.tukw.qwest.net. [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id a11sm726440pju.2.2019.08.20.13.22.00
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 20 Aug 2019 13:22:01 -0700 (PDT)
To: Jim Wilson <jimw@sifive.com>,
 Georg Kotheimer <georg.kotheimer@kernkonzept.com>, qemu-devel@nongnu.org
References: <20190820143942.17371-1-georg.kotheimer@kernkonzept.com>
 <79a82be5-38a2-edeb-66a6-25d34246aea3@sifive.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <cb6758b2-966f-2584-81db-8e4d499eabec@linaro.org>
Date: Tue, 20 Aug 2019 13:21:59 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <79a82be5-38a2-edeb-66a6-25d34246aea3@sifive.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::544
Subject: Re: [Qemu-devel] [PATCH v2] RISC-V: Select FPU gdb xml file based
 on the supported extensions
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
Cc: Alistair Francis <alistair.francis@wdc.com>,
 Palmer Dabbelt <palmer@sifive.com>, qemu-riscv@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/20/19 1:06 PM, Jim Wilson wrote:
> I don't see a need to remove the fp csr's from the csr list.  There are other
> extension dependent CSRs, like hypervisor ones. I think it makes more sense for
> the csr list to contain all of the csrs, and then disable access to them if
> that extension is not enabled.  If there is a good reason to require changes to
> the csr XML files, then it probably should be discussed with the gdb developers
> too, so that the gdb and qemu copies of the files remain consistent.

Another possibility is to generate the list of csr's at runtime and export that
to the connecting gdb.

We do this in target/arm/gdbstub.c, arm_gen_dynamic_xml.


r~

