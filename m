Return-Path: <SRS0=QLzr=44=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05F7BC0044D
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 17:28:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6ADB620736
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 17:28:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nvEZnAE6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6ADB620736
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56310 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jC59G-0002Wu-VK
	for qemu-devel@archiver.kernel.org; Wed, 11 Mar 2020 13:28:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58847)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jC57y-0000k2-0R
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 13:26:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1jC57x-0006XF-17
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 13:26:41 -0400
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:39700)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1jC57w-0006Wr-Q9
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 13:26:40 -0400
Received: by mail-pf1-x441.google.com with SMTP id w65so1710491pfb.6
 for <qemu-devel@nongnu.org>; Wed, 11 Mar 2020 10:26:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=JA4h9WhweJSHFVdFBizsIQ6yGg6wS1/XfkARK3sz3Pw=;
 b=nvEZnAE6pwIakdKhFenTI5OmWNjW8EIoKvaWgdfkOE/8ZjnNMnzH2GYsD3ozGAV6pX
 L3dU0qPt5HKE+xXBNSHDEdDMtwM5rI+A2MyPGghoCdgbqwORRih93wFrmpPXtqibv7Ba
 uISZZaWMFySjl5QOLA2nu6lGXOskPkCZ+hi46oDs3RgSyfjtQXfvWVXW6mvcFLI87R5k
 /5ZfHMHFBCJtEcWs3qTO+cli9Y5QospMI9dT5QHO1VvsDoJuPiZ8z9/1MRCcS/hbNPqm
 hKOfjhDoXjAdCsqj+THO3ivh0ioJg1pqpYz+pWsX5F7wQQ7jhLPciZ584NcQhVtcXpuS
 u6fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=JA4h9WhweJSHFVdFBizsIQ6yGg6wS1/XfkARK3sz3Pw=;
 b=KSjdFtBXQ55cvDcgIKNwuLRSbx+sxQvS6KqaW91Syo2s6g1FTMLO1S92ZVvBiSYyxu
 JDIyII9wYyBRU6MOacXSPZi79HJuQDfkfn8sZjAL5di6u4f205jW8UZvoGRWEVATFN2y
 XPlB9fymF2mIRkC0kF9pTC4JV6X/XrW2ezI+jUKEKVNJVuqD7ZvE+CDj4ZGPZyvs9rII
 dlsGSKDOWzsdaKed7nQsQD5D1zD692pURosxVvTI1KCHUruPCKVdVKtrLF//xrWPp2ip
 VHhUGHaWmcanamyr+Xc/gdaTz0UV2ifll+O5TFrXEbzjrso7Gfk0xsts5ukwmdyeFGKK
 4HBw==
X-Gm-Message-State: ANhLgQ24cVFmp5lvqz9rpRXFbM8B8XZBViI1QHlV4FGyBzYKBS8t0cJB
 UxmuaJtl2q/F07QCBoFno8Xceg==
X-Google-Smtp-Source: ADFU+vseIpdvMS7RTCg9UwEbHg0cswa9U+2r8xoszBjk0X3cLDUzGINDSnV9bYjH9sbBAsXcbWyHpg==
X-Received: by 2002:a63:701b:: with SMTP id l27mr3847788pgc.57.1583947599601; 
 Wed, 11 Mar 2020 10:26:39 -0700 (PDT)
Received: from [192.168.1.11] (97-126-123-70.tukw.qwest.net. [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id
 s23sm6097429pjp.28.2020.03.11.10.26.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 11 Mar 2020 10:26:38 -0700 (PDT)
Subject: Re: [PATCH v4 08/21] linux-user,arm: add syscall table generation
 support
To: Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org
References: <20200310103403.3284090-1-laurent@vivier.eu>
 <20200310103403.3284090-9-laurent@vivier.eu>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <b7bd64cf-455c-d8b8-2b67-2ecff97ea72b@linaro.org>
Date: Wed, 11 Mar 2020 10:26:36 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200310103403.3284090-9-laurent@vivier.eu>
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
Cc: Cornelia Huck <cohuck@redhat.com>, Riku Voipio <riku.voipio@iki.fi>,
 Taylor Simpson <tsimpson@quicinc.com>, qemu-s390x@nongnu.org,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/10/20 3:33 AM, Laurent Vivier wrote:
> Copy syscall.tbl and syscallhdr.sh from linux/arch/arm/tools/syscalls v5.5
> Update syscallhdr.sh to generate QEMU syscall_nr.h
> 
> Update syscall.c to manage TARGET_NR_arm_sync_file_range as it has
> replaced TARGET_NR_sync_file_range2
> 
> Move existing stuff from linux-user/Makefile.objs to
> linux-user/arm/Makefile.objs
> 
> Signed-off-by: Laurent Vivier <laurent@vivier.eu>
> Reviewed-by: Taylor Simpson <tsimpson@quicinc.com>
> ---
>  configure                    |   3 +-
>  linux-user/Makefile.objs     |   3 +-
>  linux-user/arm/Makefile.objs |   8 +
>  linux-user/arm/syscall.tbl   | 451 +++++++++++++++++++++++++++++++++++
>  linux-user/arm/syscall_nr.h  | 447 ----------------------------------
>  linux-user/arm/syscallhdr.sh |  31 +++
>  linux-user/syscall.c         |   6 +
>  7 files changed, 499 insertions(+), 450 deletions(-)
>  create mode 100644 linux-user/arm/Makefile.objs
>  create mode 100644 linux-user/arm/syscall.tbl
>  delete mode 100644 linux-user/arm/syscall_nr.h
>  create mode 100644 linux-user/arm/syscallhdr.sh

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

