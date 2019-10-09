Return-Path: <SRS0=qKtL=YC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 180A8C4360C
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2019 01:38:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D77B52070B
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2019 01:38:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XdZbuszp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D77B52070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38558 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iI0vZ-0003NF-Hz
	for qemu-devel@archiver.kernel.org; Tue, 08 Oct 2019 21:38:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41583)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iI0ul-0002rs-Ip
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 21:37:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iI0uk-0005Ir-7o
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 21:37:19 -0400
Received: from mail-yb1-xb43.google.com ([2607:f8b0:4864:20::b43]:33898)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iI0uk-0005Id-2A
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 21:37:18 -0400
Received: by mail-yb1-xb43.google.com with SMTP id m1so210322ybm.1
 for <qemu-devel@nongnu.org>; Tue, 08 Oct 2019 18:37:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=2M0QElxVB/CyxdHrHz7p+BbYVSSnjE2w4SAIhBUcbv8=;
 b=XdZbuszpfeGTL8m/FRsqcqg1/ojxuja8/TdUl8oUztciGqycjlzMmCE0brSa5+eUJU
 XRpQ/KarU+I3LnASVWGLLVB90Dx4Qhn0j54ld08LN87ncCtTGv+bTH+c/yirMlGyYcd6
 7uqEtU3YejDOMy0MYfquYh3SVWrIG/Whc+TPJZGYUd673om5HzEAAX+Sh8FyhndQZj1+
 +k3ZdLztGX23vCT69JTduhxxO4KgoUzKKF1hN+aybD7YyZVzq/rYt8FEMad3pP4LErv+
 IzoPbj/U/SO++6ExFqjJ+oGhXeStDlMTCINgCh+xfNYdQ9SmZJxhHf+fQ5ZVIjaX2JQ+
 3zmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=2M0QElxVB/CyxdHrHz7p+BbYVSSnjE2w4SAIhBUcbv8=;
 b=mb8t6tCENtk5MqRRhtNtc4r2qg2dfWZEHRJUgv6J3NCu3xIUn1NLTOUv90EO0xNP9v
 CJ03UQVsaPiZ4eszk53Qpb+ss5cwnqC1HBTErHuadih4qMnFk3hkqWO9PGTrRZMsnyzl
 7wlmDR+9tIuCTmxSp3CJ8hNdqfABMkZn3UdcAj0afhDcLyCZosUpzWNV6To1ngHvcxdq
 V3xEmK1qx1AJ5dcWYnCuOhgGLhzQ3JveQ4oG7VfKO4m8sebNxUQ/cs6bIQQYZ/oTDKt5
 r04IIZRW/OoRHzc68HSIC/M7z7X77J7oXVb5mvQIvAPbFDtL6cGPXbyM9QWcguZ37xZ+
 Iy/g==
X-Gm-Message-State: APjAAAV7LyOJsEiwXw2Bsu69QRzK9PrceQtneP1HnscVvjxMnTpbz5DG
 EW/lEQWVtg2/cLXWxuMjnRC+SQ==
X-Google-Smtp-Source: APXvYqy78dDh8EifhxNIrXkqOIu2sFt9YcO71AwoqqWF0wd9nePaFu9g61vYxTTK7VKuYmIBw1LTng==
X-Received: by 2002:a25:824c:: with SMTP id d12mr473415ybn.217.1570585036957; 
 Tue, 08 Oct 2019 18:37:16 -0700 (PDT)
Received: from [192.168.1.44] (67.216.144.16.pool.hargray.net. [67.216.144.16])
 by smtp.gmail.com with ESMTPSA id h65sm220235ywa.62.2019.10.08.18.37.15
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 08 Oct 2019 18:37:16 -0700 (PDT)
Subject: Re: [PATCH v1 1/1] target/riscv: Remove atomic accesses to MIP CSR
To: Alistair Francis <alistair.francis@wdc.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
References: <34350af3b53fadc50bfe4f1fbc452c7d3a8fe8f7.1570572202.git.alistair.francis@wdc.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <8b816d13-0243-562c-7fa9-96f350935895@linaro.org>
Date: Tue, 8 Oct 2019 21:37:11 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <34350af3b53fadc50bfe4f1fbc452c7d3a8fe8f7.1570572202.git.alistair.francis@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::b43
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
Cc: alistair23@gmail.com, palmer@sifive.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/8/19 6:04 PM, Alistair Francis wrote:
> Instead of relying on atomics to access the MIP register let's update
> our helper function to instead just lock the IO mutex thread before
> writing. This follows the same concept as used in PPC for handling
> interrupts
> 
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> ---
>  target/riscv/cpu.c        |  5 ++--
>  target/riscv/cpu.h        |  9 --------
>  target/riscv/cpu_helper.c | 48 +++++++++++++++------------------------
>  target/riscv/csr.c        |  2 +-
>  4 files changed, 21 insertions(+), 43 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

