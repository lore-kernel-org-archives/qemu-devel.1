Return-Path: <SRS0=D5YA=6O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7333BC4724C
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 19:08:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 423DF2054F
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 19:08:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Cm0J8cvY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 423DF2054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42006 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jUEXs-0001JW-AL
	for qemu-devel@archiver.kernel.org; Thu, 30 Apr 2020 15:08:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43136)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jUEQS-0005XN-Vi
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 15:00:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jUEQS-0002pt-D9
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 15:00:48 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:38556)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jUEQR-0002oq-KT
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 15:00:47 -0400
Received: by mail-pg1-x541.google.com with SMTP id l25so914176pgc.5
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2020 12:00:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-language:content-transfer-encoding;
 bh=oqn7TtR/TYqwfVJ6q6iqVey21vFfB9UmMm0+Nyk9+N8=;
 b=Cm0J8cvYGtjFHqnYtl27MIUrudtcHM2IC6BfHDrDs0jRxuhMTql/8/AqaXFhFd6Pw7
 yMIPT4pt0BLf4FzX1I6dczLvzCIeTGUYlgb0lqQOyFhxjTHUK1gCJZPOOgGnXFB0cwRj
 cOuAulXqu1lLkO0cxHVTewVPW8XjzxtbrcAUfs2vgNUSwW5+YiFoH42G6NlI1yVwQ0uD
 yBOjKULeb2vqVcHMmjHduvO51ndmVt4ViNXYG+3BCZ5ebIgSnwATmQKvBA3DnS8Go+Ps
 9N7Kei3a1OkOhxvQMSkSMCTy8Qf8hUWYE7t/fUR5yIl4DmPAmHxUM7cYKiymHKLDX5zL
 UVxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=oqn7TtR/TYqwfVJ6q6iqVey21vFfB9UmMm0+Nyk9+N8=;
 b=tzkzFdyDitwTFm2OGl2xCceGwXhyP66GH7mkCXxEa5tpM+SDjPljzuRyA8dlYdjn3P
 L4xt1A4HFASHk1iGU/oNA49hKTsLvNPkpAK3CbSvf6dig09SaCX4rQVdVsTDUPeIm2xH
 hudZzwIYNWlJPUNfkgABRJ2W+byjv0brgOK70tw4CrW2KBjBZHU0YXGAyZQVCHZYx88j
 9O4b9YNZjbKDQRy8QdbwddMIWaF6HBDLntnSXbK74ryq1FofXNBm4IVBTq+rk0i1sEXi
 orFAAxYhs2WnSUXjc5SXeYDaNaj2vTWLRNVeesz7yYZU4wUH05YgqnIVAPgPE3MfPbR9
 9vUw==
X-Gm-Message-State: AGi0PuaKAu+M0FARrM2ue+SC36QDmSMBnOBqGxQFc32lpXDCVs9vniLW
 CGcrbmH6CilwBMnvmlF/3+qeGZIUjkk=
X-Google-Smtp-Source: APiQypKf+je42jwSnHXjSDOcaN6WSgJkhUOqjiS7mRsg3UAkwucgGrTJMceRrYg/h4Qd3lJ5/akCfw==
X-Received: by 2002:a63:e050:: with SMTP id n16mr374362pgj.93.1588273245392;
 Thu, 30 Apr 2020 12:00:45 -0700 (PDT)
Received: from [192.168.1.11] (174-21-149-226.tukw.qwest.net. [174.21.149.226])
 by smtp.gmail.com with ESMTPSA id r17sm433871pgn.35.2020.04.30.12.00.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 30 Apr 2020 12:00:44 -0700 (PDT)
Subject: Re: [PATCH 08/36] target/arm: Convert VCMLA (scalar) to decodetree
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20200430181003.21682-1-peter.maydell@linaro.org>
 <20200430181003.21682-9-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <1b85806b-0fad-a2b8-2e89-18124bc34dff@linaro.org>
Date: Thu, 30 Apr 2020 12:00:42 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200430181003.21682-9-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::541;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x541.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2607:f8b0:4864:20::541
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

On 4/30/20 11:09 AM, Peter Maydell wrote:
> Convert VCMLA (scalar) in the 2reg-scalar-ext group to decodetree.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/arm/translate-neon.inc.c | 40 +++++++++++++++++++++++++++++++++
>  target/arm/translate.c          | 26 +--------------------
>  target/arm/neon-shared.decode   |  5 +++++
>  3 files changed, 46 insertions(+), 25 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

