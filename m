Return-Path: <SRS0=hj7J=4C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4B69C35242
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 20:13:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F696222C4
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 20:13:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OfS4YDWc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F696222C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45192 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2hKe-0007FD-Nk
	for qemu-devel@archiver.kernel.org; Fri, 14 Feb 2020 15:13:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52403)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1j2hIS-0003xz-Vz
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 15:10:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1j2hIR-0000gP-Q6
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 15:10:44 -0500
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:34039)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1j2hIQ-0000eG-Sz
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 15:10:43 -0500
Received: by mail-pf1-x441.google.com with SMTP id i6so5405019pfc.1
 for <qemu-devel@nongnu.org>; Fri, 14 Feb 2020 12:10:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=TkrvTu49HwWJpVtG/5gPH62PDMKR29HZzdS6ge7jRuE=;
 b=OfS4YDWcIUhGTXPrB76n26aeF+1PDrNHzmWTXDbIkl4nIaDyrRs8omk8XV19JOt8C4
 ODXIJRQB8RSFLTk7MCoLUQwyUZ7/mpTDcoFwqEbDl3rWUMAIKXucnUs1GaVy7fRIvI8/
 iY3hkZe3NH9VYhhD+oog4fW3CNjP/qTB1UrZ6ZPF9xF0pgJTF5eOPOY1sVihS6hjDwxP
 5rbZzmj7QzK0QlrBCJ08ZcYQYph7S47oDJmAX6NtedBtrPO2c2VUvMnLTcj+Bq7sZn2y
 uJrPCiVZp6U3uGcd+SsduL6snrZGgLJp/uWEWn888EQiVrX9gluzj4Hl6Q2hN4VokbxV
 uXbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=TkrvTu49HwWJpVtG/5gPH62PDMKR29HZzdS6ge7jRuE=;
 b=Mz+m/gCd4y2zcJggQirNuPLnYC+0HTvLdU7IeQKcKlFvRjf/lc3AslKZDTgzSIzLPC
 frPEGO3yI9timQAZT7F2esoFDgQumRD9AwH/PHgVMrQ1c6zW0H6SfCunWCNF8qYm3K22
 59sowCJS+vl7a+8xh/ehj8cWJharFzTRsQGC+U9+9jhBhxHJifMERQ1T9xRteVQjyC7M
 n4Z+P5aLesqc2V14vblScsKPOBtIrK9w5eh5ixt6dqWC1aZXYOVCDhwcBr6IHbvfEniq
 etGzlNgST8Yf3wtXDZI2ya21KA1ve+hniuJisJ5sGpvKrrL+SLhE0rqL3qnWT1UGRPGR
 /9xw==
X-Gm-Message-State: APjAAAXqxMGKHfg+qor1RQwbR16PsCPk5UvlJV5ak9KfhW5hPopBEmrY
 ulvf5Gdp6XlEpxDv12spgk38HA==
X-Google-Smtp-Source: APXvYqweF027VZE8/g3sSOAhVDwyz5h4X+O5wApGO2+4dseqle6HY4y4IK4DuV7Gz0YiGOuGQUchQg==
X-Received: by 2002:aa7:8502:: with SMTP id v2mr4917249pfn.232.1581711041551; 
 Fri, 14 Feb 2020 12:10:41 -0800 (PST)
Received: from [192.168.1.11] (97-126-123-70.tukw.qwest.net. [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id
 a19sm7374576pju.11.2020.02.14.12.10.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 14 Feb 2020 12:10:40 -0800 (PST)
Subject: Re: [PATCH v2 02/21] target/arm: Check aa32_pan in
 take_aarch32_exception(), not aa64_pan
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20200214175116.9164-1-peter.maydell@linaro.org>
 <20200214175116.9164-3-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <384a16ff-1251-5ef7-bdba-5470a111665a@linaro.org>
Date: Fri, 14 Feb 2020 12:10:38 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200214175116.9164-3-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::441
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
Cc: Eric Auger <eric.auger@redhat.com>,
 Aaron Lindsay <aaron@os.amperecomputing.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/14/20 9:50 AM, Peter Maydell wrote:
> In take_aarch32_exception(), we know we are dealing with a CPU that
> has AArch32, so the right isar_feature test is aa32_pan, not aa64_pan.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/arm/helper.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

