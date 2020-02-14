Return-Path: <SRS0=hj7J=4C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AAB2C35242
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 20:16:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E661E206B6
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 20:16:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XVd3ipzZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E661E206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45258 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2hNs-0003Ip-6w
	for qemu-devel@archiver.kernel.org; Fri, 14 Feb 2020 15:16:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53113)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1j2hN1-0002XM-Rg
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 15:15:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1j2hN0-0006zq-KL
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 15:15:27 -0500
Received: from mail-pj1-x1044.google.com ([2607:f8b0:4864:20::1044]:38478)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1j2hN0-0006yR-CS
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 15:15:26 -0500
Received: by mail-pj1-x1044.google.com with SMTP id j17so4369896pjz.3
 for <qemu-devel@nongnu.org>; Fri, 14 Feb 2020 12:15:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=v5A8/WwtRpqCRFFnJaduKvXrVT6yYRPQfe/LQc8wy8k=;
 b=XVd3ipzZVb29X4+EP0HhGGSn8Wjq2wxzDFZQFULgJL7GQR8COs4rCe5bzP08wtc+Fx
 L7lcpy3PdZRRcu8M+sdd6retlginuFSbq+8xaAaQXsUHM7/F6Qm5NK4Usr7PKynKwV2H
 qo8Mg77awLuveVMfpoLb0TYem38dpMiaB9Cx/xC4i6F9MiGfrQR98z4psYRXkXfiaMWj
 AhcipoJsECSSjk1BUiXxOJiLxtsL7yMppTaSymlvLtdJtmXk5bs2LJVYcJe2Od7AY9L1
 eyqnev+b0WHYNWExw8DwLvxE2RTS2kVtgNImut4qaf20NrW8KjAbNWubxfXytJpA2ReK
 Zitw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=v5A8/WwtRpqCRFFnJaduKvXrVT6yYRPQfe/LQc8wy8k=;
 b=XQrKphcHfdSbCXMKvxG/IX/cssycL8fjDo7AOzqzSYj8z7q6iLwQeuckwIfIdYa3pe
 2FjpJ6jx3fqwamq4WQXhJ/c4B+q5OUZl/oIyPSwGCkv5V1iH6xz7ZJ77O2Ur4ZXlUxd1
 lODOpJgqBG+FIs78UtHg0Ni+FY/nE+T6jRKAMl/jJV5utkS6ulAvZjRzBx9Lz+vCqcUG
 7EanHnNCYPZSBaUjXrwsCVbOYmm7eGbJ2V9fnpvnFZxsKX06y/rSWvRJN2HmyPYldZ+s
 /oqKH2MwnkIuQo95DfHi0KnoqYej8nTYMtgDaS+37FebbXdijowu5tmD+rpWMfAxWPwE
 OuwA==
X-Gm-Message-State: APjAAAUxo7KZEzUwLDSbIDB5k663bRbqTCT19DMsWlNMeI4GTPBwZ9mS
 cR8fegnTJbVXF+tUj3xlwjf/Fw==
X-Google-Smtp-Source: APXvYqyUv8mPJj7I+qy6W89xBP5RJiue2/uoX3bI7ST9GJeOp/cvoOgmbQhLQYVmK9vSTIdW21n2Qg==
X-Received: by 2002:a17:902:8a83:: with SMTP id
 p3mr5210422plo.56.1581711325136; 
 Fri, 14 Feb 2020 12:15:25 -0800 (PST)
Received: from [192.168.1.11] (97-126-123-70.tukw.qwest.net. [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id
 p3sm8110059pfg.184.2020.02.14.12.15.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 14 Feb 2020 12:15:23 -0800 (PST)
Subject: Re: [PATCH v2 10/21] target/arm: Stop assuming DBGDIDR always exists
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20200214175116.9164-1-peter.maydell@linaro.org>
 <20200214175116.9164-11-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <4d592ed0-10c3-683b-84d8-cf17a2d491dc@linaro.org>
Date: Fri, 14 Feb 2020 12:15:21 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200214175116.9164-11-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::1044
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

On 2/14/20 9:51 AM, Peter Maydell wrote:
> The AArch32 DBGDIDR defines properties like the number of
> breakpoints, watchpoints and context-matching comparators.  On an
> AArch64 CPU, the register may not even exist if AArch32 is not
> supported at EL1.
> 
> Currently we hard-code use of DBGDIDR to identify the number of
> breakpoints etc; this works for all our TCG CPUs, but will break if
> we ever add an AArch64-only CPU.  We also have an assert() that the
> AArch32 and AArch64 registers match, which currently works only by
> luck for KVM because we don't populate either of these ID registers
> from the KVM vCPU and so they are both zero.
> 
> Clean this up so we have functions for finding the number
> of breakpoints, watchpoints and context comparators which look
> in the appropriate ID register.
> 
> This allows us to drop the "check that AArch64 and AArch32 agree
> on the number of breakpoints etc" asserts:
>  * we no longer look at the AArch32 versions unless that's the
>    right place to be looking
>  * it's valid to have a CPU (eg AArch64-only) where they don't match
>  * we shouldn't have been asserting the validity of ID registers
>    in a codepath used with KVM anyway
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/arm/cpu.h          |  7 +++++++
>  target/arm/internals.h    | 42 +++++++++++++++++++++++++++++++++++++++
>  target/arm/debug_helper.c |  6 +++---
>  target/arm/helper.c       | 21 +++++---------------
>  4 files changed, 57 insertions(+), 19 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~


