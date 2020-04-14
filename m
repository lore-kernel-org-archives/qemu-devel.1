Return-Path: <SRS0=m554=56=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 709EDC2BB1D
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2020 21:21:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A95C206A2
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2020 21:21:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cjVVBVgP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A95C206A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39332 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jOSzq-0001up-ES
	for qemu-devel@archiver.kernel.org; Tue, 14 Apr 2020 17:21:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60360)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jOSzB-0001Mr-El
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 17:20:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1jOSzA-0002nC-Fe
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 17:20:49 -0400
Received: from mail-pj1-x1041.google.com ([2607:f8b0:4864:20::1041]:39001)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1jOSzA-0002mr-4m
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 17:20:48 -0400
Received: by mail-pj1-x1041.google.com with SMTP id o1so4925539pjs.4
 for <qemu-devel@nongnu.org>; Tue, 14 Apr 2020 14:20:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=wCDnKHJEvYw1F/Pd7OIgf9Q61Env5JN6az7yyA+VYeQ=;
 b=cjVVBVgPVXuxXfxgBFLHcp/K2Bb1mmZLO1GTAGxQZGXZzu6FsINkKpjQf4Tq5m0NWo
 he647+y3aODW1ziPhJr0wXlmrwumU+8b6nsQjNguKdchfhxxr/oXEK6VQnWkZ7WwVtT+
 9Xv51IG9h1zR1mQNly+53/TU07zkcy6EdSp7mr6j744n19710HGYCkoQsemC54EWB6tj
 L7e3/xUSVbw8i0gMSgDJR2N9zaUtzm2IpsnFu0+3dpbd68dgm4RDnVIzpPx+aaDcc+/L
 gp13syfTphTkonrS5cnW9wgQU6ANPXCHyCeA55bdS2+cG+sQo0WrMCWS07AdKv0PPILv
 w1dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=wCDnKHJEvYw1F/Pd7OIgf9Q61Env5JN6az7yyA+VYeQ=;
 b=TVKYnhIcAETbQ4usPPJoBB10xmB/Xu0ajyzlqDpjs8kW+lN6R02Ax7InbjwRtfG/OW
 /HhZVPNmJ2Uoi3RDzUwBYH3wl6w6tBrvLHyx/cwJpBU/PmiyGum2AhRkTwvlTIyA6dRM
 jbdJ6Wn6WzanO86+81M2K2H/QNgt9x2o++V1WIT1gLqgmRobfpyYJKijtSRP02q2xRvi
 NI7ksV4I9jKcIFSO0YvFOK5D+z6tefFCWNX2dQHUHT2FMYJEMkOIyOYFhOMFXKXAY09F
 Am+np5asNPgYs1WsZTbZoZc909hp/nSLE7del2d43cw9jKbuHaH0QiywUmSUVJavDnTv
 JEAQ==
X-Gm-Message-State: AGi0PuaZsWWpLsXqOo4avL27GOHKAcnU3e9LBSejIkpUT1h6ns8N1J0K
 7HL29jJ5AP7gyOdC6dyVVeZjQg==
X-Google-Smtp-Source: APiQypKJljmAf7p41ZiqBYsjDBDL+VXIqZcQoywiFuJ9lsBCZbcSv7kuY7s0xVsW2q68HT36PCXyxA==
X-Received: by 2002:a17:902:8682:: with SMTP id
 g2mr1795585plo.93.1586899246658; 
 Tue, 14 Apr 2020 14:20:46 -0700 (PDT)
Received: from [192.168.1.11] (174-21-149-226.tukw.qwest.net. [174.21.149.226])
 by smtp.gmail.com with ESMTPSA id o12sm10777341pgl.87.2020.04.14.14.20.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 Apr 2020 14:20:45 -0700 (PDT)
Subject: Re: [PATCH v2 13/17] gdbstub: Introduce gdb_get_float32() to get
 32-bit float registers
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20200414200631.12799-1-alex.bennee@linaro.org>
 <20200414200631.12799-14-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <ecbaf916-e1cc-e8d3-f549-3bdcd8215c5b@linaro.org>
Date: Tue, 14 Apr 2020 14:20:43 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200414200631.12799-14-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::1041
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
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/14/20 1:06 PM, Alex Bennée wrote:
> From: Philippe Mathieu-Daudé <philmd@redhat.com>
> 
> Since we now use a GByteArray, we can not use stfl_p() directly.
> Introduce the gdb_get_float32() helper to load a float32 register.
> 
> Fixes: a010bdbe719 ("extend GByteArray to read register helpers")
> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> Message-Id: <20200414163853.12164-2-philmd@redhat.com>
> ---
>  include/exec/gdbstub.h | 9 +++++++++
>  target/sh4/gdbstub.c   | 6 ++----
>  2 files changed, 11 insertions(+), 4 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


