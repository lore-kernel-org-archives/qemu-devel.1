Return-Path: <SRS0=WIOf=5A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D4D9C10F29
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Mar 2020 23:19:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB37320409
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Mar 2020 23:19:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zkZwhAlQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB37320409
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60118 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDcXK-0003lS-Ru
	for qemu-devel@archiver.kernel.org; Sun, 15 Mar 2020 19:19:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45476)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jDcT3-0002mU-Go
 for qemu-devel@nongnu.org; Sun, 15 Mar 2020 19:14:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1jDcT2-0003gX-Hh
 for qemu-devel@nongnu.org; Sun, 15 Mar 2020 19:14:49 -0400
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:43712)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1jDcT2-0003e2-9m
 for qemu-devel@nongnu.org; Sun, 15 Mar 2020 19:14:48 -0400
Received: by mail-pl1-x644.google.com with SMTP id f8so7095408plt.10
 for <qemu-devel@nongnu.org>; Sun, 15 Mar 2020 16:14:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=A24RYbZfJqYq+DvziFDtfUMo+XMHPskiMeh3KVdHAF0=;
 b=zkZwhAlQNyNFm/jDUBRWCn16ceFRmyPfjsPKsotPv2Gu7QYK4LZATPOXEHvDe/q3bg
 SWQXZvRAEoZZf0Tjm26WoChzVtPRtaYgHGowCEq1DaJVqqukTEyN2ReJmq3UQTYe2mYh
 PySJDPb0wJjNI3xTfVoD/NskUsflrtZ7GF/IXeDBvuHVT3JuSd3BkBLUj0bPFOec1aVW
 BEvo1mTJ0EdIkflcIYgSq3pTtkDpL0AeR48NKjv1p9ADUoSmztrpO9nqa/xipoRtWA0y
 cysvOZ5oBXY4dzfPgj8hiqOSQ4k9bON0guOPs328yMALdlfC02NP1O2+fvQLVg8D6XDi
 hp/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=A24RYbZfJqYq+DvziFDtfUMo+XMHPskiMeh3KVdHAF0=;
 b=bWDtnMDS9GW1M4g5+/c0k/ySToeo3kGFjBl535EhJhR/9sr/LY32atlg5LEu6Cv13b
 OB+xPBH0zEvroWajRg9ItOTKxUmEBXCBdR5f0+MNnh8mXKzG7dG+0BH3PxtxGHj4bx1o
 cWw0Qh/SwItokvCcbgPLoV4MkiBw1j1p03mLUTji6jQJfav978Y1DqKNiGBHC8cFlxa7
 kyt7+kmqhx8Muj2paTSjvJn4cg7/FLZApjKw7PnuU+97lc+fKA8OhwUA6MsuVECSWp4K
 r2oLCoiEeian5m7GOnj/TDDp0HYvl2TR5XmtG60ScG5LwMa5QUw7ndo7i63u7MsuM6Qp
 Zi9w==
X-Gm-Message-State: ANhLgQ3C5nBGlfvBBa6Ov0XS0PzTdQjQJoFVMEyquN+GgpG7F0DKpyDM
 n9boMYAoaJSQp1Gyek3zAArSWw==
X-Google-Smtp-Source: ADFU+vsnWhHFfL//kyNL/2EOjDG9uNd5fHX5tF1L4auXZGErwV0p5bHCDSqm5yoHXDXE+hZdBRNdTw==
X-Received: by 2002:a17:902:d201:: with SMTP id
 t1mr12161284ply.312.1584314087377; 
 Sun, 15 Mar 2020 16:14:47 -0700 (PDT)
Received: from [192.168.1.11] (97-126-123-70.tukw.qwest.net. [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id
 g7sm17625710pjl.17.2020.03.15.16.14.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 15 Mar 2020 16:14:46 -0700 (PDT)
Subject: Re: [PATCH v2 4/4] linux-user, openrisc: sync syscall numbers with
 kernel v5.5
To: Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org
References: <20200314113922.233353-1-laurent@vivier.eu>
 <20200314113922.233353-5-laurent@vivier.eu>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <e681ba48-2657-c876-82f1-c27779748124@linaro.org>
Date: Sun, 15 Mar 2020 16:14:44 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200314113922.233353-5-laurent@vivier.eu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::644
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
Cc: Taylor Simpson <tsimpson@quicinc.com>, Riku Voipio <riku.voipio@iki.fi>,
 Alistair Francis <alistair.francis@wdc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/14/20 4:39 AM, Laurent Vivier wrote:
> Use helper script scripts/gensyscalls.sh to generate the file.
> 
> Add TARGET_NR_or1k_atomic
> Remove useless comments and blank lines.
> Define diretly the __NR_XXX64 syscalls rather than using the
> intermediate __NR3264 definition.
> 
> Remove wrong cut'n'paste (like "#ifdef __ARCH_WANT_SYNC_FILE_RANGE2")
> 
> Add new syscalls from 286 (preadv) to 434 (pidfd_open).
> 
> Remove obsolete syscalls 1204 (open) to 1079 (fork).
> 
> Signed-off-by: Laurent Vivier <laurent@vivier.eu>
> Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
> ---
> 
> Notes:
>     v2: add comments suggested by Taylor

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

