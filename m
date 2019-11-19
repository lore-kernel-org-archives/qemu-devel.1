Return-Path: <SRS0=aBJE=ZL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC54BC432C0
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2019 07:34:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 862EA2230D
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2019 07:34:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Q/RqmEj2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 862EA2230D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42300 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iWy1v-0008QB-Mz
	for qemu-devel@archiver.kernel.org; Tue, 19 Nov 2019 02:34:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43826)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iWy0K-0007lm-7H
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 02:32:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iWy0J-0007Uw-4i
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 02:32:51 -0500
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431]:40263)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iWy0I-0007UX-RR
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 02:32:51 -0500
Received: by mail-wr1-x431.google.com with SMTP id q15so9708897wrw.7
 for <qemu-devel@nongnu.org>; Mon, 18 Nov 2019 23:32:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=idWxf4dr3x+QCd6oeTBf2ZP1ObTu2n2ly9xqb/SaAEo=;
 b=Q/RqmEj2BtN5RP8O9nWKk/MwfoxA/fnN3oUxLuB7Kq6OEvjCB29X2BRP+TTMBhWR5C
 NFpybgClQeTJXztLIVIGB/HoeGzRe3HhNaVkzmBKTh5f23KDPuFQJ6qze4VSKvtZfXPN
 PKT3vFFFwGXzcf3aXD9A5VYglsZQcAAQOVc2hfhoK2BYMfgBVuED9Aszma0n9kduoeoA
 3T6kFw6tlKBuL+DqmxvKHlT2wcNHsLZfKh9yf5EFYOXkfTp49cYD8zpHQmX/C/VMxsqf
 DJ14IkeXywuQ2hhupY2WeZXtGPBWIe/73fmOEqTic7QW0YPiIWHrN7YgmUr4d1OG3INB
 OgfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=idWxf4dr3x+QCd6oeTBf2ZP1ObTu2n2ly9xqb/SaAEo=;
 b=hn0WdfdkNDrbtvReZbfUBIgCE1227pAw/w0szLiebWKhueddgKe/WQjjP2zzggqIH3
 SJFXp8eDy0v23heMucknPx9Mtpj2PwqBzlxh3AxrsL10JdQ7D2YBOQ046xEoNTaKMslw
 tAUJnKr7WF9ceiospP9DmeOPQfdPQjSvqWU+8Fx8av0uKQxiyPKzG/fxiQigdOL3QZzm
 CB+2Tm+qmQ8dNMH3H5j7NUBePr7G6NUrgUPHu7XdTDlJCcHH0cB8kU1CCrCTAJnKFs9c
 q5b3EGcFZ2x8yOgZUTn8YBD6bDLYYIFbu781OIr+TIIPp4yayCCy3mBF7nIBW3UoWced
 JDuA==
X-Gm-Message-State: APjAAAWADS0d9/ELvgslmkrdutWaBSzKrOmrnOZygOwtw1XGmlO09cIn
 He4tpm1eZyqbNzpuL/PpLzh4yQ==
X-Google-Smtp-Source: APXvYqztTyMuOmvHlSjxVx8UaW9KmNIKzCc/Zn0sqrAmtQG/VkPN+wP67D0ngs9a/jj6DQkOyEHyeg==
X-Received: by 2002:a5d:6083:: with SMTP id w3mr17224312wrt.308.1574148769414; 
 Mon, 18 Nov 2019 23:32:49 -0800 (PST)
Received: from [192.168.8.102] (64.red-79-149-204.dynamicip.rima-tde.net.
 [79.149.204.64])
 by smtp.gmail.com with ESMTPSA id t134sm2129017wmt.24.2019.11.18.23.32.47
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 18 Nov 2019 23:32:48 -0800 (PST)
Subject: Re: [PATCH-for-4.2 v3 0/3] hw: Remove dynamic field width from trace
 events
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
References: <20191118210458.11959-1-philmd@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <98767bf6-7248-531c-f06a-17aae81acabe@linaro.org>
Date: Tue, 19 Nov 2019 08:32:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191118210458.11959-1-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::431
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
Cc: Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 qemu-block@nongnu.org, qemu-trivial@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/18/19 10:04 PM, Philippe Mathieu-Daudé wrote:
> Philippe Mathieu-Daudé (3):
>   hw/block/pflash: Remove dynamic field width from trace events
>   hw/mips/gt64xxx: Remove dynamic field width from trace events
>   trace: Forbid dynamic field width in event format

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

