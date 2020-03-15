Return-Path: <SRS0=WIOf=5A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8637C10DCE
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Mar 2020 22:47:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6BA57206BE
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Mar 2020 22:47:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cyRthlqm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BA57206BE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59870 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDc2M-00051b-A0
	for qemu-devel@archiver.kernel.org; Sun, 15 Mar 2020 18:47:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53438)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jDbn6-0006sG-6e
 for qemu-devel@nongnu.org; Sun, 15 Mar 2020 18:31:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1jDbn5-0005MR-7a
 for qemu-devel@nongnu.org; Sun, 15 Mar 2020 18:31:28 -0400
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:47097)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1jDbn4-0005FT-W6
 for qemu-devel@nongnu.org; Sun, 15 Mar 2020 18:31:27 -0400
Received: by mail-pl1-x642.google.com with SMTP id w12so7047531pll.13
 for <qemu-devel@nongnu.org>; Sun, 15 Mar 2020 15:31:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=ATNLDsX1L+oBl0FY3ngsqmXqreZuQR3JonHh5XOCQ9Q=;
 b=cyRthlqmjo+dbk+M8uG+3FccYjctUzzevhd8SSfX/3KU5G54Sn5pL58x84l8L3yXAl
 ohSTg9ZsTNj2Hk/JDcPRA/Ds660wFQRp7Qwoo5FZKg6daklTwCYwWdGgnPbNoX+7Qys4
 8UDD6wxXB+RHDB7xMCZh2AXhGTXD5kfHSbSXG9+CAmd41JsgaUdGDEyz5l55DxuBvQ5a
 TspMJgC4OeyNE3mYbLnuPhLH4feBDD3jJdGhoXRl7Y51bXZ7DqcVD0GBSuVM8RKcjZPI
 OKzQJI8/PDNtkZQk32GNUSd51pTIiFKniGPudecOEJon1U0YQye2SXVdxnSfDwVmrjhz
 E0xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=ATNLDsX1L+oBl0FY3ngsqmXqreZuQR3JonHh5XOCQ9Q=;
 b=iewzNLBcSx9qeHDMlryXxswjbX9jm5XM/5U9n7ZX0S7d+RHd7l0cQ4e+EKyqiBqhBu
 IJgglQINmZUUc2cB2w85g3OOfYaABB47GlijeLaK0HWmC5kBKc/dwVq7K330YpuOK4JK
 +OPHNtLNvKw6aQbY8A0/0X3vLBPG84ayLkpsm8LWxA8w3jQpI5qCxx2Mr2kTK6UkaVW/
 3Md7ZD4jVlhcq+OULrp7+p3ILfFi1GAbjITeQai/MPyRhtqrHo710AEt6MhR8OdLENc+
 A5A9Yaiv4IbRs5sR1OPuf2KrV4XOe3P9BWhEYVdF7PxYZB+25bkNVkLPBhEeYgm3DADb
 X3fA==
X-Gm-Message-State: ANhLgQ39yD9Td2bV0oLhSH8dv9wWlLhxoOjC0Y9AQrL3NOApy+WFBib8
 HPaNgydc9H5whIoaxrQBFbjoexbRnJk=
X-Google-Smtp-Source: ADFU+vuvRLfVOd1sMcAD8j8ZikFoVtU80g2Ubp7BzcAybPXq3Rg7pAjyGMAiq+upmA0QE7E3QJYhpA==
X-Received: by 2002:a17:90a:a893:: with SMTP id
 h19mr22734751pjq.30.1584311485925; 
 Sun, 15 Mar 2020 15:31:25 -0700 (PDT)
Received: from [192.168.1.11] (97-126-123-70.tukw.qwest.net. [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id
 a75sm14268789pje.31.2020.03.15.15.31.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 15 Mar 2020 15:31:25 -0700 (PDT)
Subject: Re: [PATCH 9/9] qapi: Restrict code generated for user-mode
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20200313184607.11792-1-philmd@redhat.com>
 <20200313184607.11792-10-philmd@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <3c2544ac-bc03-bfb5-6fcd-185e15533a5b@linaro.org>
Date: Sun, 15 Mar 2020 15:31:23 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200313184607.11792-10-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
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
Cc: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Michael Roth <mdroth@linux.vnet.ibm.com>, Laurent Vivier <laurent@vivier.eu>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/13/20 11:46 AM, Philippe Mathieu-Daudé wrote:
> A lot of QAPI generated code is never used by user-mode.
> 
> Rewrite the QAPI_COMMON_MODULES variable one entry per line,
> and split it in 3 groups:
> - always used
> - use by system-mode or tools
> - only used by system-mode
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> ---
>  qapi/Makefile.objs | 37 +++++++++++++++++++++++++++++++++----
>  1 file changed, 33 insertions(+), 4 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

