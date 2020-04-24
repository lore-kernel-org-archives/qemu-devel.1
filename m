Return-Path: <SRS0=J7/p=6I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC273C54FD0
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2020 21:52:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B1D592168B
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2020 21:52:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="spUzlX8H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1D592168B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53688 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jS6Eu-0000m8-TQ
	for qemu-devel@archiver.kernel.org; Fri, 24 Apr 2020 17:52:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50294)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jS6DX-0008SW-PM
 for qemu-devel@nongnu.org; Fri, 24 Apr 2020 17:50:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jS6DX-0001E1-9u
 for qemu-devel@nongnu.org; Fri, 24 Apr 2020 17:50:39 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:37076)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jS6DW-00018K-Sq
 for qemu-devel@nongnu.org; Fri, 24 Apr 2020 17:50:38 -0400
Received: by mail-pf1-x444.google.com with SMTP id d184so5459408pfd.4
 for <qemu-devel@nongnu.org>; Fri, 24 Apr 2020 14:50:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-language:content-transfer-encoding;
 bh=FLj5+Vs3rr8r5/wssKn4ZLoBooiRpYDp48ov4gVCtZ4=;
 b=spUzlX8HhmYJfwA/eseJ2KGHwLr2cTxRbf5EBWvYLVd6JpuFjD3E0iAS5bBc73GdXd
 jsxRkTWevxsbvUVOJdL9659vaWaUb8ukYFXIH+thHcjvXNMYZwxGuqp8Zy2TWT4ScQiE
 1Sk/mMNXYsZC/YTdyuyGAUzhKkI0SPbBF6Grxwhxk5aJe0bbVGYctZE6dSmaEfVIDQjY
 jJ8r2eq2NtKhlbvL0Rbeq7qhXEN9Lrk71PdM8lmaL3cPult7cWWI36sZOsroOCTnvAuN
 7SjTHCf9UEc/eLUz+6+jdfxkzQlC/VFMOEQlWCnmYEWunDgZpHj2G3dLb1w7yNxDWo5E
 vvlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=FLj5+Vs3rr8r5/wssKn4ZLoBooiRpYDp48ov4gVCtZ4=;
 b=lMfHAXteZ1yo8nm51I5bjOGTpn/yzpnzUSHwQ2eWbgtmBKsPlKfIY8hOoD6n12tOXf
 z1gr3XEct9S6Xdt0ZR1ouUWd8OUAi+/96QLgl6FnRrl4G+Zs9U/n5L3O3wNyNAb7F5Uq
 3Bjlog6krp/GwIn+e5kshl59D7CQQ68QvaejWUa+AgToB2smsqVzVuVeVJkTYPkpU6Ee
 uZFBdiwTC6WxWZiw9UjowWRSOaHvW68wMqKbxr4oTK+kmrq92ROpA1jpNbUEHDp3FTEu
 1IvllbgtC7J8TP1Jht48lNS9hikUjy2GSLBL4NZBOveKJ8mVFI5vvt5mnmTvpEafORz/
 spTw==
X-Gm-Message-State: AGi0PuZ0HP2H9YyWe7H47xkeJGTjld5NHYbr5bnJnXbhlafakhKrxrX9
 O3hHijlMxK7CJih+91oJnymhJbWs59Y=
X-Google-Smtp-Source: APiQypL4hn5K/cVznrMjLv+EFKzKmMHFSeJeielHzN3wRVQFcf22YeWEcI3/n6FmJRBzq+IzeLnbVQ==
X-Received: by 2002:a63:1e5a:: with SMTP id p26mr11134535pgm.233.1587765035848; 
 Fri, 24 Apr 2020 14:50:35 -0700 (PDT)
Received: from [192.168.1.11] (174-21-149-226.tukw.qwest.net. [174.21.149.226])
 by smtp.gmail.com with ESMTPSA id b140sm6514959pfb.119.2020.04.24.14.50.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 24 Apr 2020 14:50:35 -0700 (PDT)
Subject: Re: [PATCH] linux-user: Add support for /proc/cpuinfo on hppa platform
To: Helge Deller <deller@gmx.de>, Riku Voipio <riku.voipio@iki.fi>,
 Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org
References: <20200424210648.GA26715@ls3530.fritz.box>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <8492cb36-d9b4-49e3-f54d-1771d8325709@linaro.org>
Date: Fri, 24 Apr 2020 14:50:33 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200424210648.GA26715@ls3530.fritz.box>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::444;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x444.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2607:f8b0:4864:20::444
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/24/20 2:06 PM, Helge Deller wrote:
> Provide an own /proc/cpuinfo file for the hppa (parisc) platform.

"our own" perhaps?

> Signed-off-by: Helge Deller <deller@gmx.de>

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

