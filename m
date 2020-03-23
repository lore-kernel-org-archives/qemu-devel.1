Return-Path: <SRS0=WkHy=5I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5986EC54EEB
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2020 18:21:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 181F42051A
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2020 18:21:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="peYtgGM1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 181F42051A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38130 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGRhf-0006vW-0Q
	for qemu-devel@archiver.kernel.org; Mon, 23 Mar 2020 14:21:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60614)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jGRfy-0005ym-VB
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 14:19:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1jGRfx-00007k-Qy
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 14:19:50 -0400
Received: from mail-pg1-x52a.google.com ([2607:f8b0:4864:20::52a]:37039)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1jGRfx-00007W-DC
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 14:19:49 -0400
Received: by mail-pg1-x52a.google.com with SMTP id a32so7605347pga.4
 for <qemu-devel@nongnu.org>; Mon, 23 Mar 2020 11:19:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=7aQ9HV5f8qln/nyAe5i1wAhyAs0ZxuwxKagqp6qwae4=;
 b=peYtgGM1J6fY4ckqH8Ca5gRvr4FbBaA1bn6Il2t/sGvbvqUEv5hDnOk5iVWvjXO2tq
 nhx2aFRFKb4TyHay69vd6YEWf38RZnUm7alPODGjla7EYCgoz+d86KrZFlna/MUmz9jj
 gVXBdaVqV/mo6/R+szCaPQaVAbJAMr36EPnyswqAm2iYIwxA2FiNXyAGpAL3Uph56Ghz
 fnoA4s8OaRK/C37GdIYs7X3IG1jGt2q+4eBVnSWd4EhBcPvbLhYZPhnVlmrTPD2RGVOm
 youyttYpGm+HW3RD+jx5653LkkXxLOLJgtmxhKfPYk5mqrPibp87MHFkajW9Xq6MjFL9
 RraA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=7aQ9HV5f8qln/nyAe5i1wAhyAs0ZxuwxKagqp6qwae4=;
 b=twquWM+STvtNanzborSvzapdhG6nKKTaGyhwog8htizO+Grcp3hAW9WjJKgeF91qYN
 SYK7O9yGkY4EuYk8X2J7dbe/PpP1v46hh1dteqBTUGh9aiNh6i2VCMkLb3UI9t4Rhhaj
 HYcY2hx5+I2hMeGGaPFJqEcpdAHZiUZhkMu8FFsHLT1zQDfo6yhRQurWh8mVdaZZ2oQk
 pCDHZHvehWymNYAn55wfA0dCZcTCF75uwcmTb6JEDZk9bBtBK1uvsewBGiuNg6IEH7eZ
 TQhNizEA5YDqd/Y3EgNlvvfuyCDSGtFc26MQgC+pr7Ifqx+eovXQiQ1h+zyzeJbsur2z
 GJfg==
X-Gm-Message-State: ANhLgQ0A9Qyz5HU1yRnEhhf6iJTWjduH0xPs69JIyvhJaiKaaIA1PAkn
 lXXI4Zy171RkWULFTr/4yJx/0w==
X-Google-Smtp-Source: ADFU+vujqDH8FbdHsP0Y3/1uml+OBX4aK3p0r8jj4HOtAb0A09GDPy7EAenB668gGhXhz1ICxadYlQ==
X-Received: by 2002:a62:502:: with SMTP id 2mr25756827pff.324.1584987588361;
 Mon, 23 Mar 2020 11:19:48 -0700 (PDT)
Received: from [192.168.1.11] (97-126-123-70.tukw.qwest.net. [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id
 l6sm13320343pff.173.2020.03.23.11.19.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 23 Mar 2020 11:19:47 -0700 (PDT)
Subject: Re: [PATCH v1 09/11] tests/docker: Use Python3 PyYAML in the Fedora
 image
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20200323161514.23952-1-alex.bennee@linaro.org>
 <20200323161514.23952-10-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <1b9e07c4-f354-3ff5-0d82-93e0ac77f4a2@linaro.org>
Date: Mon, 23 Mar 2020 11:19:45 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200323161514.23952-10-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::52a
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

On 3/23/20 9:15 AM, Alex Bennée wrote:
> From: Philippe Mathieu-Daudé <philmd@redhat.com>
> 
> The Python2 PyYAML is now pointless, switch to the Python3 version.
> 
> Fixes: bcbf27947 (docker: move tests from python2 to python3)
> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> Message-Id: <20200322120104.21267-4-philmd@redhat.com>
> ---
>  tests/docker/dockerfiles/fedora.docker | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


