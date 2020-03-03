Return-Path: <SRS0=3Wv1=4U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0BA2C3F2C6
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2020 18:45:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8DF5A2072D
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2020 18:45:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qbYkKp3w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DF5A2072D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51950 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9CXi-00068I-Iv
	for qemu-devel@archiver.kernel.org; Tue, 03 Mar 2020 13:45:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51041)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1j9CWy-0005eF-O3
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 13:44:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1j9CWx-0005a9-O6
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 13:44:36 -0500
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:36452)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1j9CWx-0005Zn-HX
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 13:44:35 -0500
Received: by mail-pf1-x443.google.com with SMTP id i13so1921033pfe.3
 for <qemu-devel@nongnu.org>; Tue, 03 Mar 2020 10:44:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=Ct84NUv5+Ex0rgicVWRWYttFqrOSVkRo3ivL92T4r9k=;
 b=qbYkKp3wUQ3ZuprHBWppEdvLyRtqYbqkxoZiUzW/0NuObOteD7N7YgLly/inZnfjzg
 Nk2b67HJhUYSb9X2ni8DadHpVhPmEeltqGNecbFmI5uEEACGzvXTgtyM8r5DB+oWwXO2
 6L8Xy6hOjpv/NZV8R3wTED8Xbcl/uWyPNrvLLMJvOrpsVqc6cZhcHT+g0b4V1OHaAYSI
 /GM4d+1QxuR5QpUo6S9Tjb4S9cUyHTvDXLWlycJSM5FxZpEWuPMhCEg4o2UHspGrDrv4
 doKYD/et6bmw7HBJC9nXK1EUCzPjcn9SoWTXYeAhy3SuKa1ZfKrPQp5PNtri5IllbEQV
 5ggA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Ct84NUv5+Ex0rgicVWRWYttFqrOSVkRo3ivL92T4r9k=;
 b=nN1Eb1KGUZTyPouHKPS5j6wsUCkSgobPXSoQKSFm0QTHzVpAOAlSsoUdyV7fiBrE9C
 8UCfIV5QdQCTHmYG0KUtiu6iY0vgYB28jEZwk5BuRWXLQN7qbLJ6fBgVSLdYZgKAUVAN
 fyyE+rbtDRfS4RoXsWMx3wbCZvplVNO2FbOq/IsXjo/1efHHNfbKTB4ouc4GD9mqyXJN
 Hi8zlxonY0F1VMUNYESAsGHtV4ioHQvr1lSPV4wRCEXWNLH32DRZo/jM8D7cGNEot1V0
 9RREdkkh0IB1dw49XNcZeERK5xb3oxOHDMxwI0Vkqi2WHaaGRMd3qvQd83TX/yqler7p
 RxAQ==
X-Gm-Message-State: ANhLgQ3Ts1ZYhNG7yGmEHw/kGy2ye1J9Zhk87aICsentQIrO3dqqMMla
 2jfyUk5afQce5XzhVCuF7xFN6s88o3A=
X-Google-Smtp-Source: ADFU+vtXrFTGsgs2ZcHt2ERr+gxmFOe6CJoVrUFlVvLy3H+j8DoiD9XuHtr4ja72KErT1OpQ4qY4Fg==
X-Received: by 2002:aa7:99c5:: with SMTP id v5mr4274908pfi.198.1583261074712; 
 Tue, 03 Mar 2020 10:44:34 -0800 (PST)
Received: from [192.168.1.11] (97-126-123-70.tukw.qwest.net. [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id
 g9sm16470291pfi.37.2020.03.03.10.44.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Mar 2020 10:44:33 -0800 (PST)
Subject: Re: [PATCH v2 7/9] configure: detect and report genisoimage
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20200303150622.20133-1-alex.bennee@linaro.org>
 <20200303150622.20133-8-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <91d8ebdd-2e2f-8ceb-c0ec-063a9b88ef8c@linaro.org>
Date: Tue, 3 Mar 2020 10:44:31 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200303150622.20133-8-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::443
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
Cc: Fam Zheng <fam@euphon.net>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/3/20 7:06 AM, Alex Bennée wrote:
> This is used for some of the vm-build tests so lets detect it and
> behave sanely when it is not installed.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>  configure                 | 13 +++++++++++++
>  tests/vm/Makefile.include | 14 +++++++++++---
>  2 files changed, 24 insertions(+), 3 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

