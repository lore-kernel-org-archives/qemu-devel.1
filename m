Return-Path: <SRS0=Dj2y=5L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1120BC43331
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 16:58:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF1BB2073E
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 16:58:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aL8RnAzT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF1BB2073E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56640 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHVpg-0003wV-2I
	for qemu-devel@archiver.kernel.org; Thu, 26 Mar 2020 12:58:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37165)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jHVoD-0002cF-37
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 12:56:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1jHVoB-0008Hw-Rj
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 12:56:44 -0400
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:34982)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1jHVoB-0008HQ-HP
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 12:56:43 -0400
Received: by mail-pg1-x544.google.com with SMTP id k5so959587pga.2
 for <qemu-devel@nongnu.org>; Thu, 26 Mar 2020 09:56:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=6w5PVuHjOabKMom0hymU201CXbvUXXDaXz2WOjLRUZE=;
 b=aL8RnAzTcUXZfIUhInwGdanmIBVwMBQoSsw8jXbTs02TkDwXAbEHDpPJlSXEp8SP8i
 3iIUZd/Wz3KCfV+QNXf4eVu0Ti06e/aSAXPTQ7XQGChM6uV04BJofqnSeXN7eoGq41p4
 +8Ig89QP3e7R1/zdHn5tFoPLTzY3A5arNf1QOdm4WnIn+8lNpAw7wGOVsxUiJmYjrnYP
 Zytdc5M9IhuA5VRXxwiIHQGEGW+mpc+FlBpHRCAa6ZPIuNMXu80lJwqWIMQHZH4aIrA2
 S2B3HW5jqUWFQrAbQ5AEvRTBfrqB9IEPIk1jZOs8zEHyY1xpZryQQgu8Em47pCO0MiFV
 4a8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=6w5PVuHjOabKMom0hymU201CXbvUXXDaXz2WOjLRUZE=;
 b=lKobwO/BxJgbWpRdj6cagC+5DnWtfDUEwvG/LaadRibfDXqr1xVWExXPaxBXVJB8+U
 zxxeRcYTNdVvuwNCMC9E1EVfBPo0awl75t88lrZ/JCW6y8xwtkN4rfotDxjWsljexkKZ
 ol4rZHpFE78jwKIyNK+WSDIJxW0Yaqvetya8MhMckFAP1pt3hhiW3Sdc9jfalbFEmyDh
 Z4xweuMr3f4rMaNjevYGU1st4qeO6zTyi5J8rO5fFIZSrpOzXBkIn3HOXDzc/TGnEXB9
 pjrt5PLzsCqiaZP/sNc/2/rXfWoppF8pBDa0aC4+3DrajkD1tyADwg9AIzpEwEHv/+J4
 MrRw==
X-Gm-Message-State: ANhLgQ064sZKYG/ab3SckLpg4vEd2GRrayBUWN7OpwAVc39mJMGa40r2
 f6kGICFFJe0sAoOq/ZkfxuIM6A==
X-Google-Smtp-Source: ADFU+vvUK2Xmi80rgC59aymvy2cCyH6iodpTh0EQiqdkwrFwc52xjyGyB+JVC7c/AiBHJXbZYoTPxQ==
X-Received: by 2002:a65:680b:: with SMTP id l11mr9651609pgt.322.1585241801787; 
 Thu, 26 Mar 2020 09:56:41 -0700 (PDT)
Received: from [192.168.1.11] (174-21-138-234.tukw.qwest.net. [174.21.138.234])
 by smtp.gmail.com with ESMTPSA id h4sm2075054pfg.177.2020.03.26.09.56.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 26 Mar 2020 09:56:41 -0700 (PDT)
Subject: Re: [PATCH] qemu-user: fix build with LLVM lld 10
To: Roger Pau Monne <roger.pau@citrix.com>, qemu-devel@nongnu.org
References: <20200326134316.36059-1-roger.pau@citrix.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <f71f7cf8-af7d-7b45-a026-8ab87e106759@linaro.org>
Date: Thu, 26 Mar 2020 09:56:38 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200326134316.36059-1-roger.pau@citrix.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::544
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
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Dimitry Andric <dim@FreeBSD.org>, Laurent Vivier <laurent@vivier.eu>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/26/20 6:43 AM, Roger Pau Monne wrote:
> lld 10.0.0 introduced a new linker option --image-base equivalent to
> the GNU -Ttext-segment one, hence use it when available.
> 
> This fixes the build of QEMU on systems using lld 10 or greater.
> 
> Signed-off-by: Dimitry Andric <dim@FreeBSD.org>
> Signed-off-by: Roger Pau Monné <roger.pau@citrix.com>
> ---
> Cc: Laurent Vivier <laurent@vivier.eu>
> Cc: Richard Henderson <richard.henderson@linaro.org>
> Cc: "Philippe Mathieu-Daudé" <philmd@redhat.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: "Daniel P. Berrangé" <berrange@redhat.com>
> ---

The Plan is still to drop this whole section of code.

However, it's still blocked on getting the x86_64 vsyscall patches upstream.


r~

