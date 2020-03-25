Return-Path: <SRS0=PjAl=5K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0885C1975A
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 16:02:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9316C20409
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 16:02:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="osm5uKBH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9316C20409
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38992 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jH8UG-0003CG-MO
	for qemu-devel@archiver.kernel.org; Wed, 25 Mar 2020 12:02:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48146)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jH8Sv-0001RI-ST
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 12:01:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1jH8Su-0004Ac-Eu
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 12:01:13 -0400
Received: from mail-pj1-x1043.google.com ([2607:f8b0:4864:20::1043]:35067)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1jH8Su-0004A4-5F
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 12:01:12 -0400
Received: by mail-pj1-x1043.google.com with SMTP id g9so1187050pjp.0
 for <qemu-devel@nongnu.org>; Wed, 25 Mar 2020 09:01:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=ZKAcvvb5B5aLdrzFo3oqHkkxeclrBWldWm7xb2swpjs=;
 b=osm5uKBHOjPxozNgFpnU5hUv1t5bazt4eshWA2SoMT+x9jnj7tDjRhmxe39SkcQfBJ
 iuU3uf+bsUM9mMYGer1OqgSP5uFz014rjRIkS+4wRL+t+c3trPjmQZoaUHzwLm7cMELS
 TyhiYKJv5Eg2FoWnK+zR5RPHMo8jP2Bu94yFMUGJ682DzN/9OeurG3jPpd0C/atNPtR0
 uenZAtTzKWaa38LMjkO4DZjyw0jtCrO+J2S9nALa4ta3e5J6SyMHN3xv0hEcvpdHskDS
 ZNCh7mYAHVP9G/Blmf6k4C1jZSHW7mhN1qlsaoxUZioxvGlw0j/B9Wh6s++bpACNpbu6
 aG5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=ZKAcvvb5B5aLdrzFo3oqHkkxeclrBWldWm7xb2swpjs=;
 b=W7T6w/v0ANETWhvm1Xm+gvyf7Vnt0RpQruB4ekqiYm3DhhF/jVs5/HLgnlsw8dGR8p
 iSAQ23J8yT0bfHVCQPEgNpY35bpAaIQQvByd7RskxHC64vSjFXRfkAx1wqesDCrrwNAi
 5Giz5+gMB4HUFQHekqIlfSk/DFKNuLUBUqHqGhXYol+imf1MUMqSzNLw/wii9KHxpvW9
 8+PvN0VNlQjXx9I7jmuJW3tZmNRvfR1drevMVf5tjy8msiO10EHv1dhggMddLUQ94yG+
 0/ZthduwsZ1/uwNP3zrHChpJPtW3XmakSHO7LeamTBCf8t6cl+4u2CdbaofCx1R1V3c5
 V45g==
X-Gm-Message-State: ANhLgQ3brVOQuuycJ2wFIGNiMUyiAfhIH91sWtwn75/g3mY91UD7Ss79
 NxwflYCju0jTJOBFogzjRwbfBA==
X-Google-Smtp-Source: ADFU+vvBVLw6To2pR8n2biJRETI/k+/AVGQOzOLoTWn0301HoaHYhYIMzWvC1pp6lNrdmv9HpENyEw==
X-Received: by 2002:a17:90a:9408:: with SMTP id
 r8mr4608032pjo.15.1585152070907; 
 Wed, 25 Mar 2020 09:01:10 -0700 (PDT)
Received: from [192.168.1.11] (174-21-138-234.tukw.qwest.net. [174.21.138.234])
 by smtp.gmail.com with ESMTPSA id 189sm18703380pfg.170.2020.03.25.09.01.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 Mar 2020 09:01:09 -0700 (PDT)
Subject: Re: [PATCH] linux-user, configure: fix (again) syscall_nr.h
 dependencies cleanup
To: Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org
References: <20200325075757.1959961-1-laurent@vivier.eu>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <f0f1e6bf-155b-f5af-de22-5798fe82766e@linaro.org>
Date: Wed, 25 Mar 2020 09:01:07 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200325075757.1959961-1-laurent@vivier.eu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::1043
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
Cc: Peter Maydell <peter.maydell@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/25/20 12:57 AM, Laurent Vivier wrote:
> This patch fixes two problems:
> - it cleanups linux-user variants (for instance ppc64-linux-user
>   and ppc64le-linux-user)
> - it removes the .o file when it removes the .d file, otherwise the .o
>   file is never updated
> 
> Fixes: 5f29856b852d ("linux-user, configure: improve syscall_nr.h dependencies checking")
> Fixes: 4d6a835dea47 ("linux-user: introduce parameters to generate syscall_nr.h")
> Signed-off-by: Laurent Vivier <laurent@vivier.eu>
> ---
>  configure | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

I haven't been able to reproduce the same failure from master, but this looks
right.


r~

