Return-Path: <SRS0=QE2o=ZK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA8C5C432C0
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2019 08:07:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 739212071B
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2019 08:07:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JCpykGOZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 739212071B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58998 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iWc4B-0004Gq-L9
	for qemu-devel@archiver.kernel.org; Mon, 18 Nov 2019 03:07:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47977)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iWc3E-0003rg-1H
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 03:06:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iWc3C-0004VC-Qd
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 03:06:23 -0500
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:36123)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iWc3A-0004QW-RF
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 03:06:22 -0500
Received: by mail-wr1-x444.google.com with SMTP id r10so18229100wrx.3
 for <qemu-devel@nongnu.org>; Mon, 18 Nov 2019 00:06:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=IURVVXMHzuOc+Z1lb51+QpgFklzswLBrOtOfIuDs66U=;
 b=JCpykGOZKvf+8EPTt4LVo1mWKgeVRv8FbpUE0BJvCSLUwIEed7B8xC+DOy+Op1gNI/
 A+Tt7AE2QY2y2Vejj88KxJieuJdanSaAjQXXCmT05ZGceVlX8PGFtE7KyXc6ZUd71CsF
 eAKVoIxqXmy5sY5RZQ3+N69QHHjbpQtuRpoKfsoSkGZ3OsPkMtcHPvp+3O2I6NIw5e6x
 rPu8ciyUEl0it93b9/WtXolB3e8+Vt7f6b+4689agzHGiaj7O27I3Z4HcnevSWhLyZdd
 vyReXkwEVvLmYIijZSFefHiRk1xpPc417Xu48d7hm2CS67L+kVATSqJs0WR3R2c6Emzp
 58gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=IURVVXMHzuOc+Z1lb51+QpgFklzswLBrOtOfIuDs66U=;
 b=HH48g6nQcSOrAiFhNlvUTH0x4YtpFi5zERnIzpLGnDW8jmnahikWVDFluU7u0CmvU4
 knO4E8KOyri6sgL6nvNaim9Jj8JzPlaVMv7mbohHrAjZTOLcYKds5e3ccHkTeSDxFgPy
 Yx/ckI0h525G/LNYdGRNN5G/7ebDvG/AF3jlzZ9kIVPWs1CSVX7/eMRj1uY6x8J8WhGC
 a+B2F6pe9Z0Aw6EPb3VOpbgWWkXpECBeBA3Atzjj7Zl+VFWQ6iq3pBrtLLqBuJK+n53f
 Z3jo96cpKqaXcjBvy3EE003aaJkfRT0KR7Qnmy6g43rWb3tNBnUS7ciwLKhLAYJLZhAi
 pJlg==
X-Gm-Message-State: APjAAAUVm/oPJmuaPtRNF1iaEoVqjt0hEVrhh5aidEWRvuAbEF+tbmoI
 LYRg9/bMQTzPjjV7zLG+qOmagg==
X-Google-Smtp-Source: APXvYqyTQ6pzPJw4x0Xz4axFXqgwUrh6nK51AHEcudvCrU7OVZbWCPRnoL9SDB++0XEyhU363gtu/Q==
X-Received: by 2002:adf:f9c4:: with SMTP id w4mr27566844wrr.88.1574064378266; 
 Mon, 18 Nov 2019 00:06:18 -0800 (PST)
Received: from [192.168.8.102] (65.red-79-149-41.dynamicip.rima-tde.net.
 [79.149.41.65])
 by smtp.gmail.com with ESMTPSA id 4sm20635891wmd.33.2019.11.18.00.06.15
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 18 Nov 2019 00:06:17 -0800 (PST)
Subject: Re: [RFC PATCH 03/11] gdbstub: move str_buf to GDBState and use
 GString
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20191115173000.21891-1-alex.bennee@linaro.org>
 <20191115173000.21891-4-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <4bacc5d3-d706-17c9-8171-6e2e5460ea09@linaro.org>
Date: Mon, 18 Nov 2019 09:06:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191115173000.21891-4-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
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
Cc: damien.hedde@greensocs.com,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 luis.machado@linaro.org, alan.hayward@arm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/15/19 6:29 PM, Alex Bennée wrote:
> Rather than having a static buffer replace str_buf with a GString
> which we know can grow on demand. Convert the internal functions to
> take a GString instead of a char * and length.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>  gdbstub.c | 194 ++++++++++++++++++++++++------------------------------
>  1 file changed, 85 insertions(+), 109 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

