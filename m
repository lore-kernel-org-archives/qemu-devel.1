Return-Path: <SRS0=0Zkw=4R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3043BC3F2D7
	for <qemu-devel@archiver.kernel.org>; Sat, 29 Feb 2020 04:45:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E5E29246AE
	for <qemu-devel@archiver.kernel.org>; Sat, 29 Feb 2020 04:45:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yULm5WRF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5E29246AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57200 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7u06-0000dc-2z
	for qemu-devel@archiver.kernel.org; Fri, 28 Feb 2020 23:45:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52400)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1j7tzU-00009h-IV
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 23:44:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1j7tzT-0000Gv-AO
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 23:44:40 -0500
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:39779)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1j7tzT-0000Gk-2N
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 23:44:39 -0500
Received: by mail-pf1-x442.google.com with SMTP id l7so2767053pff.6
 for <qemu-devel@nongnu.org>; Fri, 28 Feb 2020 20:44:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=LS/eu7IS/eXR3p70fucER5A7DEzOY90OyqceOPXaSJo=;
 b=yULm5WRFB7hX2QNyzHFcqcI0OSn1Tyopz2ZWydxFsQfrH+/WUDpzBnlLGxWHA56FZE
 3BWQE0PrRP/HAgZYluou4Q6EfB2TceyS/sUwNAaFjwnvMp8Zs9T+oL9dlFYRFS20+ePf
 pq0bm8YIR13QBUAPYlbgWWsYXAFWy0FLI3KRev129u9TIZ9pKHlM+TGSOw+eW5+TJYey
 QTNJOm8OnNwSTd3SJ2wsPyoVoJ9bI4dHMlVVzL5FG8QVYnhc6/Rfw7g/j9biEKIPJJNO
 Q4sAZh7SdaT0uIO7uRPOfORiPkORyoCIqLu+lArASHMI3O8FwRqCvFirKWfrZ6Yrn1Nt
 41lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=LS/eu7IS/eXR3p70fucER5A7DEzOY90OyqceOPXaSJo=;
 b=qfbRfIWS4HFWiPx7maaoNV+c0eW8HZ8SDYDJtVL4qmZOX74m4CCviBkOfbeBX9eL6n
 R//lIMtvwkAfvzSPEifA4chxKs/IMB366rxkuY7d82npE5xwAwod/jjwCjeLrf4Y2k0C
 jQkLTUWeCeITn44FLLChMWQmZf9437qS9pGnJlR3FPxLOpdu9kP/3r9WXbLhjBbWd2WK
 0bKEwavtrD2GB2MxPPfOV2lanaI4o81N3h7oiaEqfbnj+BENdvfmlkqh/HmrHAGI9pOv
 E/J1BB2hr7rfMG57RIvfIE9Xn21dyiT5xNjI3Ak2LSA20xW+GHaM7+Ueq9mWlhg0FP/k
 pV1A==
X-Gm-Message-State: APjAAAUrXESowruJuK3u1VsyZGNFd4H7mRJ+eYxK6WrK0Z9j1Qdots6f
 z31jy56a+yp2YxZnGj7ER3cgMQ==
X-Google-Smtp-Source: APXvYqyOWmg5gr5bem7XosqDKUXp2cwov0NCupuB9YMEjZI1M67iO+1kO33Y3QaiOUTV0okaZWwSgA==
X-Received: by 2002:aa7:979a:: with SMTP id o26mr7805036pfp.257.1582951477621; 
 Fri, 28 Feb 2020 20:44:37 -0800 (PST)
Received: from [192.168.1.11] (97-126-123-70.tukw.qwest.net. [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id
 a9sm12551547pfo.35.2020.02.28.20.44.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 28 Feb 2020 20:44:36 -0800 (PST)
Subject: Re: [PATCH v3 02/21] linux-user, alpha: add syscall table generation
 support
To: Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org
References: <20200225121553.2191597-1-laurent@vivier.eu>
 <20200225121553.2191597-3-laurent@vivier.eu>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <ce6a0317-91ae-8ed5-a599-32d9e77c9726@linaro.org>
Date: Fri, 28 Feb 2020 20:44:34 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200225121553.2191597-3-laurent@vivier.eu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::442
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
 qemu-s390x@nongnu.org, Aleksandar Markovic <amarkovic@wavecomp.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/25/20 4:15 AM, Laurent Vivier wrote:
> Copy syscall.tbl and syscallhdr.sh from linux/arch/alpha/kernel/syscalls v5.5
> Update syscallhdr.sh to generate QEMU syscall_nr.h
> 
> Signed-off-by: Laurent Vivier <laurent@vivier.eu>
> ---
>  configure                      |   3 +-
>  linux-user/Makefile.objs       |   2 +
>  linux-user/alpha/Makefile.objs |   5 +
>  linux-user/alpha/syscall.tbl   | 479 ++++++++++++++++++++++++++++++++
>  linux-user/alpha/syscall_nr.h  | 492 ---------------------------------
>  linux-user/alpha/syscallhdr.sh |  32 +++
>  6 files changed, 520 insertions(+), 493 deletions(-)
>  create mode 100644 linux-user/alpha/Makefile.objs
>  create mode 100644 linux-user/alpha/syscall.tbl
>  delete mode 100644 linux-user/alpha/syscall_nr.h
>  create mode 100644 linux-user/alpha/syscallhdr.sh


Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

> +++ b/linux-user/alpha/syscallhdr.sh
> @@ -0,0 +1,32 @@
> +#!/bin/sh
> +# SPDX-License-Identifier: GPL-2.0
> +
> +in="$1"
> +out="$2"
> +my_abis=`echo "($3)" | tr ',' '|'`
> +prefix="$4"
> +offset="$5"
> +
> +fileguard=LINUX_USER_ALPHA_`basename "$out" | sed \
> +    -e 'y/abcdefghijklmnopqrstuvwxyz/ABCDEFGHIJKLMNOPQRSTUVWXYZ/' \
> +    -e 's/[^A-Z0-9_]/_/g' -e 's/__/_/g'`
> +grep -E "^[0-9A-Fa-fXx]+[[:space:]]+${my_abis}" "$in" | sort -n | (
> +    printf "#ifndef %s\n" "${fileguard}"
> +    printf "#define %s\n" "${fileguard}"
> +    printf "\n"
> +
> +    nxt=0
> +    while read nr abi name entry ; do
> +        if [ -z "$offset" ]; then
> +            printf "#define TARGET_NR_%s%s\t%s\n" \
> +                "${prefix}" "${name}" "${nr}"
> +        else
> +            printf "#define TARGET_NR_%s%s\t(%s + %s)\n" \
> +                "${prefix}" "${name}" "${offset}" "${nr}"
> +        fi
> +        nxt=$((nr+1))
> +    done
> +
> +    printf "\n"
> +    printf "#endif /* %s */" "${fileguard}"
> +) > "$out"
> 

Not an objection per-se, but why does every target need its own copy of this
script?  There appears to be only the fileguard that differs between these.

Could we have a common script for the common cases?


r~

