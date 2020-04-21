Return-Path: <SRS0=H2wg=6F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3812CC54FC9
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2020 17:43:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ED945206D9
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2020 17:43:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Y9m4CD85"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED945206D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33782 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jQwvW-00055k-Jr
	for qemu-devel@archiver.kernel.org; Tue, 21 Apr 2020 13:43:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37492)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jQwuS-0003zH-PU
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 13:42:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jQwuQ-0002zD-Vt
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 13:42:12 -0400
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643]:39676)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jQwuQ-0002x2-IZ
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 13:42:10 -0400
Received: by mail-pl1-x643.google.com with SMTP id k18so5509995pll.6
 for <qemu-devel@nongnu.org>; Tue, 21 Apr 2020 10:42:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=X4z+AKfq0+UWGtv24j1yk/qNn7FI9ECJ0STdJw3q7/A=;
 b=Y9m4CD85qkEBHqmbO1B0mBiSArURI9ZbKBK3l5zKht0ufkbANdwHjELxI8PwY0vTmh
 bIh8uUkDYsZCEiXDPBWkCQFqFlKq3QmhoY1emmxflWvc4IKFawmhVP8HR2nd/d1i1O2k
 ozKxIcJCfF0S5/FGX8G6zxHvCS32Nxg35d3jqKqfSG6gud9nYeG0QgOlUvQYFx+IvqT6
 HXlOFdlNxXv2Pnl5f0pYeqkK4fgNpLQ5L/s8zD/Iv04gJOMhrnJZsv3xhmYy0w5jCtVC
 WpAZz3402lkfzVRTIDGMX0VUK5Kk82H72Rh7weZJqs8gXKM1IZr38y6I82yzOcuGwD3d
 V3jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=X4z+AKfq0+UWGtv24j1yk/qNn7FI9ECJ0STdJw3q7/A=;
 b=Rse4co/LsRf4LvCTaHCC+oEcsr+DRauBRLX1OzOAXBct9H+D3EobINae9Yg/0iZvjT
 AoB3MoghLYYkBcBQftpCM07AXk5dxSgkh+UwhEsonySy/fQcNL2LAHkUuM8xVicGLHHf
 khQ/FetFFN2oXUm5sulKC59ZMc+1w0EUyt3tNR3fZmYcHgoqGz5a8ShzjcKAEMcW7LmA
 2hJOX1Oxj+ymLWCX9ZrdxfH+htLc8EgNvr5jSoE+3abqSgFPucqaPG5OQcKIy4Np+/eC
 z1rtcRWi2XbAgHDDuxOSYORkaQbjKxpb5Yt4TgbomUWSOZxZcnQyMG0QxLY4o6YGD9Ki
 01mQ==
X-Gm-Message-State: AGi0PuZRAVlLuqis0O0w7206gGaUt45PKddPNLNJmngw0lXf4fW56GRZ
 pBoh0KJizkLH0LD1+/0MjrXJJA==
X-Google-Smtp-Source: APiQypIepJ0vb23WkPJq+rcMOpZSBWVyORcjmyFMw5Z4CByHFf4EGbbocnBShuDiDmqPxlUJ2LQfQg==
X-Received: by 2002:a17:90a:f418:: with SMTP id
 ch24mr6873878pjb.68.1587490928509; 
 Tue, 21 Apr 2020 10:42:08 -0700 (PDT)
Received: from [192.168.1.11] (174-21-149-226.tukw.qwest.net. [174.21.149.226])
 by smtp.gmail.com with ESMTPSA id e66sm2930152pfa.69.2020.04.21.10.42.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 Apr 2020 10:42:07 -0700 (PDT)
Subject: Re: [PATCH] tests/tcg: use EXTRA_RUNS to run gdbtests
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20200420133455.25401-1-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <96764801-30e7-ccd7-2387-643a2703d335@linaro.org>
Date: Tue, 21 Apr 2020 10:42:05 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200420133455.25401-1-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::643;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x643.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2607:f8b0:4864:20::643
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 "open list:ARM TCG CPUs" <qemu-arm@nongnu.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/20/20 6:34 AM, Alex Bennée wrote:
> With --enable-plugins the gdb tests confuse things somewhat as the
> plugin code attempts to enumerate tests with non-existent binaries.
> Fortunately we already have a mechanism for these extra tests that
> don't automatically include their own binaries. Use that mechanism and
> drop the unneeded .PHONY declarations.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>  tests/tcg/aarch64/Makefile.target   | 5 ++---
>  tests/tcg/cris/Makefile.target      | 1 +
>  tests/tcg/multiarch/Makefile.target | 5 ++---
>  3 files changed, 5 insertions(+), 6 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

