Return-Path: <SRS0=ZEKs=WJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BE99C433FF
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2019 13:17:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4603E20840
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2019 13:17:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZkG/J5o/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4603E20840
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52372 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hxWfx-0002CZ-Fg
	for qemu-devel@archiver.kernel.org; Tue, 13 Aug 2019 09:17:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58052)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hxWeP-0000P3-Cn
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 09:15:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hxWeO-0003DX-Ez
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 09:15:45 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:42653)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hxWeO-0003Cg-42
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 09:15:44 -0400
Received: by mail-wr1-x442.google.com with SMTP id b16so11010337wrq.9
 for <qemu-devel@nongnu.org>; Tue, 13 Aug 2019 06:15:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=FYYeO8b4lS8sQ4b+4lHlFWjcUBq9refOmokKXuJKbqU=;
 b=ZkG/J5o/bSfSdR3C8R036aQZm8xKCkBUxDFZZ9VU4xljViXVKSIfT2d/jumzSDLLOI
 zisCc2SrA5JyUpXJpcpw4ATGkeFRugWFxzIdBxu3XiIPoiGilHYDoj1qoZX2Vrz/MrFA
 juLfXdMqZcqDwKpGK3czuXhoHlP8C9mbOihDfTQzC3WEHB+ZnsZy1kfUuj9ZSFLVsWrW
 6Hq4Csv0pxEiS8o4TFFMwyeK6E9gzdE1No7E7m+useaPy/sg/PSWKl/5pmdjUqtaj0Wd
 69yYs82cNsVpM+oVYbTansPTgMa/ErfUwRoPE8gjmy39cjZaofBgRcJu+ohFy25qkll4
 8IFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=FYYeO8b4lS8sQ4b+4lHlFWjcUBq9refOmokKXuJKbqU=;
 b=Z5s9GnHmEq0QH5u+jQaAP4UrupZ+VaYl9DmwNhi3X7ehxKQbjQVE+dmBU0sp5RFdn1
 +cgAzoaiQQ8NFvuwKSrZWAiQuzwHHCGJ9SCinNSQ6mLiYaEQMBwCNUryZ/eGT7Dl/e6i
 0QMvuM8/IocjQF2CRikYKkSLSGBvstEWDTDqvPlZhvKuw8ZQ0O9GqS6bSTtz/x35Iqgm
 MUOToFMntPkL7joESrxZUhCS1u6VZXTfenvGWSugi7ZewugOfzJifpgRwf2lKT/VMY3Y
 pO3SFyPldXtm6bkiromtcit+klRH2E2Myz9o/PMnuzsx4/NjAp2D1h4Z7jH0uj6bhIz2
 dteg==
X-Gm-Message-State: APjAAAUMgZft3cKYYtRtA6QjZBV5Jb9njMG3yKs4JlagqCmxAiix0fVH
 5SfmfaI0hRmqWLZwZHh7Pbbyig==
X-Google-Smtp-Source: APXvYqz59FrOoDE72kItKh+UNoGwRr5De4UDv1QyBLlAPP15E9OUM/DtLLnwYjvgLTk9iRYOt8aO2g==
X-Received: by 2002:a5d:424a:: with SMTP id s10mr16298766wrr.55.1565702143045; 
 Tue, 13 Aug 2019 06:15:43 -0700 (PDT)
Received: from ?IPv6:2a02:c7f:a69:1700:8897:9507:94c2:b98d?
 ([2a02:c7f:a69:1700:8897:9507:94c2:b98d])
 by smtp.gmail.com with ESMTPSA id c65sm2204144wma.44.2019.08.13.06.15.42
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 13 Aug 2019 06:15:42 -0700 (PDT)
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20190813124946.25322-1-alex.bennee@linaro.org>
 <20190813124946.25322-8-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <c8079562-f999-2a7e-1aca-fae2456274ae@linaro.org>
Date: Tue, 13 Aug 2019 14:15:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190813124946.25322-8-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
Subject: Re: [Qemu-devel] [PATCH v3 07/13] fpu: remove the LIT64 macro
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
Cc: Peter Maydell <peter.maydell@linaro.org>, armbru@redhat.com,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/13/19 1:49 PM, Alex Bennée wrote:
> Now the rest of the code has been cleaned up we can remove this.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>  include/fpu/softfloat.h | 2 --
>  1 file changed, 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


