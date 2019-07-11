Return-Path: <SRS0=FHOf=VI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 274A2C74A4B
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2019 09:27:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E33FE208E4
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2019 09:27:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="K9ypB3um"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E33FE208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39760 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hlVMB-0002Bd-2f
	for qemu-devel@archiver.kernel.org; Thu, 11 Jul 2019 05:27:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43546)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hlVLe-0001mP-Di
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 05:26:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hlVLc-0007j9-SZ
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 05:26:41 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:52337)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hlVLc-0007i4-HS
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 05:26:40 -0400
Received: by mail-wm1-x341.google.com with SMTP id s3so4937454wms.2
 for <qemu-devel@nongnu.org>; Thu, 11 Jul 2019 02:26:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=ljmfOdEv00fldEefdiHBTYqfrJPCPbvA/qkK0XiyYsg=;
 b=K9ypB3um9AWi0aNdm8PSV7+LTKflRJCaqxEHqY4wqdUDvNoBatKyc0TebER3jm87h5
 blZXf4bavsqlBLycDR4+3SkF6XGFlnFfBCOIXw8K8sT3AC5zT+idzLG2dV9PUopu7+BU
 nxJ/wxmRE0RJ5IS3Tw1+OURdomn/MukembdsFNb2HiE0eBuPVXXNwU+FWIYqjhleIThA
 vCK6GsqLbKTXH2NSCzEl0Do+avd85AUQKhkHjrhUzJ7hEEAPMPdIKDs69bXO3UrsUWKO
 8RrNTamTmioQ4OOSdcGvh9Izf5lVLSTgN5CGasd5gC0K3vsoihjr+I2OYHT7OV24W+3r
 WlwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=ljmfOdEv00fldEefdiHBTYqfrJPCPbvA/qkK0XiyYsg=;
 b=Cy0siVYVy70xr1AFJ3dWU9tnl38ACyuQf5DlzNMX9Ga+d7jTscbyrX0t4cJJiisjWp
 RALp06aq/7pp708R41wEf0WQSh2qnzM3GY7J942021fWYWK0/UjALloKFa/oKFTpAdnz
 S/PFhILMrPYysRbRq2qQqmop/QP+++bEttlKEpXIJ3WehG3aCZD2MpF1Z3vIL7wngZrr
 Bh01PP1pMiy/uPJ15yE3q4wdnsltkdzZdYwFxxNpq/AhZ/tAG7Cs/ughXEuchNb5i5St
 ME2LjZ5NNck+B+StgtBrd2hR2PZk4qj6W8aROLTr/dC0mT1EvOc6/qHQNqOj79qsLM33
 AhKQ==
X-Gm-Message-State: APjAAAXIV3r7AWrKFytDbbfuQ0anVmNmf9NzQuZgweTu6fJHMJTAyJ2w
 VfjoHWgK4kRMOlb1bpDGZpCXQg==
X-Google-Smtp-Source: APXvYqxxXSo8j2FEWnJbWsZ+KpL4RI/i6ZeL8xh/mXECacL8v0UXmWbMA/uHg3BJvXVGs4UDkJecSA==
X-Received: by 2002:a7b:cbc6:: with SMTP id n6mr3274129wmi.14.1562837198642;
 Thu, 11 Jul 2019 02:26:38 -0700 (PDT)
Received: from [172.16.96.70] (mob-31-157-172-216.net.vodafone.it.
 [31.157.172.216])
 by smtp.gmail.com with ESMTPSA id h8sm4566504wmf.12.2019.07.11.02.26.37
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 11 Jul 2019 02:26:38 -0700 (PDT)
To: Jan Bobek <jan.bobek@gmail.com>, qemu-devel@nongnu.org
References: <20190701043536.26019-1-jan.bobek@gmail.com>
 <20190701043536.26019-5-jan.bobek@gmail.com>
 <67fbe51c-ab7c-11e9-ecbc-aa72ff430911@linaro.org>
 <5260d896-37e3-e6f0-1ed4-b5d09bf9fbcd@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <f7ece242-6455-d166-b711-9c9bfd349a7c@linaro.org>
Date: Thu, 11 Jul 2019 11:26:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <5260d896-37e3-e6f0-1ed4-b5d09bf9fbcd@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
Subject: Re: [Qemu-devel] [RISU RFC PATCH v2 04/14] risugen_x86: add module
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
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/10/19 8:21 PM, Jan Bobek wrote:
> Doesn't B8 (without REX.W) work for x86_64, too? It zeroes the upper
> part of the destination, so it's effectively zero-extending, and it's
> one byte shorter than C7 (no ModR/M byte needed).

Sorry, I shouldn't have been quite so terse.  What I meant is

  if (!$is_x86_64 || (0 <= $imm && $imm <= 0xffffffff))

so that 32-bit always uses the 5-byte encoding instead of the 6-byte.


> That being said, I moved most of this function to risugen_x86_asm and
> included a bunch of comments regarding different cases, so it should
> be easier to understand.

Great.


r~

