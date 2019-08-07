Return-Path: <SRS0=g8gL=WD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9734C433FF
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 18:42:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A451F222FC
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 18:42:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Gdy3RGUq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A451F222FC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44432 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hvQt6-0002Vg-Vc
	for qemu-devel@archiver.kernel.org; Wed, 07 Aug 2019 14:42:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42284)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hvQry-0001Gx-45
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 14:41:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hvQrw-0004VE-3W
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 14:41:05 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636]:43771)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hvQrv-0004Ov-U2
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 14:41:04 -0400
Received: by mail-pl1-x636.google.com with SMTP id 4so35082699pld.10
 for <qemu-devel@nongnu.org>; Wed, 07 Aug 2019 11:41:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=qjI5AngRJ3zTaI4Biz6QiZbcNsTnnUQNauTz9Amv9eQ=;
 b=Gdy3RGUqpiD5yKGxS3PnsmKAXu7lTRYGrZwheawhOofTg8mxa7ndyHELLjHt/IPsAD
 wA/ceJrWwBdpXTpV1EoTwTQhDa1iyXBZvS5gsjvj/Yd4LbT/OGojhDmmfY5pL2ZDpDXm
 4SHRzyDlI043d1rAxWDSt5w67Joc+cnODpN8Bad9YoxdlXkx4n37xGvyVI4GlKbjed25
 T3tWvJvY3QOE3S7FRMsWfKE9T+eiiA7DcoyGqA1YFv7fV6yv4JxzpJmBpKvxxXTUIpFC
 eL/jQGvOXCFrRvIeTHjpIzD+NRfa+zb43a3w09eF1rxTS46hZVcNjqv4N0g3JBNf3T5W
 DRxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=qjI5AngRJ3zTaI4Biz6QiZbcNsTnnUQNauTz9Amv9eQ=;
 b=h+6IaDBXT/XfUwC7/t5kqrdolQoAT8H2sKH1XBZM59xr+Kpuhriby3PZPpc+EeQK5l
 8AEUevvpNeapqm0lslfqCCV3yp+9vEN9Lz6Iz4EUKzImDZ4xomefmZh/Tqa1oWL6MsaT
 IWhbvqLxAuIazncJ2AWMZ+OUWtKzH8/YtnOY0P89lifDD5rjXCmGTbQSNmY2gx71Hd8d
 kWTy9p/n2Tu9Ac0ACw4GwrP6HfFNXkmPQ48Lra3kedcoDTZdqc+1r4y4NvVP1D8kQZsk
 R1Vjf3nDiTc0eFZiGszBpoSkfO3/GMkeR9bKBC7zUGCQIA5/QXCy1zQkqWf8QwYxIEI0
 jeOw==
X-Gm-Message-State: APjAAAVsftSlIGnINXK2PzgwjIRg10KtahyvSI7uKsrmtYaiW44v2ToL
 zbDFOHfu+94bsTohcqNkrvuawSVqvNI=
X-Google-Smtp-Source: APXvYqw3Anlk3MPCpHHZ5upkpLeF9JmukAd8WjYgs5e6uRWRMSbnWrVEDFBqcNspmIkJLEMBCbufUQ==
X-Received: by 2002:a17:902:8d97:: with SMTP id
 v23mr9256604plo.157.1565203261548; 
 Wed, 07 Aug 2019 11:41:01 -0700 (PDT)
Received: from [192.168.1.11] (97-113-7-119.tukw.qwest.net. [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id f197sm90534932pfa.161.2019.08.07.11.41.00
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 07 Aug 2019 11:41:00 -0700 (PDT)
To: Maxim Blinov <maxim.blinov@embecosm.com>, qemu-riscv@nongnu.org
References: <20190806124857.GA18832@maxim-ThinkPad-T490>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <a8a896b6-09ff-8018-4ace-7b951826f6b7@linaro.org>
Date: Wed, 7 Aug 2019 11:40:58 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190806124857.GA18832@maxim-ThinkPad-T490>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::636
Subject: Re: [Qemu-devel] RISC-V: insn32.decode: Confusing encodings
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/6/19 5:48 AM, Maxim Blinov wrote:
> slli     00.... ......    ..... 001 ..... 0010011 @sh
> srli     00.... ......    ..... 101 ..... 0010011 @sh
> srai     01.... ......    ..... 101 ..... 0010011 @sh
> 
> First question: Why does the %sh10 field exist? There are no 10-bit
> shamt fields anywhere in the spec.
> 
> Second question: For rv32i, "SLLI" is defined as follows in the spec:
> 
> 0000000 shamt[4:0] rs1[4:0] 001 rd[4:0] 0010011  |  SLLI

Bits [9:5] of the field are checked against zero later, with

    if (a->shamt >= TARGET_LONG_BITS) {
        return false;
    }

It was done this way to be compatible between rv32, rv64, and a future rv128.
Which I admit would only need 7 bits not 10, but it didn't seem to matter
either way.

> Consider the case that we have a 32 bit cpu and we wanted to have a
> custom instruction encoded like so:
> 
>       |This bit set
>       v
> 0000001 shamt[4:0] rs1[4:0] 001 rd[4:0] 0010011  |  MY_INSN
> 
> In 64 bit risc-v, we can't have that instruction because that bit is
> used in the shift field for the SLLI instruction.  But it should be
> fine to use in 32-bit risc-v.

Ah, well, for that you would in fact need to adjust the decode files.

I do question why you'd want to define MY_INSN in such a way as to be
incompatible with an rv64 implementation.  Why not place your new bit higher in
the field?

> Why not have two separate insn32.decode and insn64.decode files?

To avoid unnecessary duplication, of course.


r~

