Return-Path: <SRS0=D5YA=6O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52A9BC47247
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 19:55:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E1C420731
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 19:55:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gJQEli4Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E1C420731
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46576 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jUFHa-0006rQ-83
	for qemu-devel@archiver.kernel.org; Thu, 30 Apr 2020 15:55:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35386)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jUFFP-0004eP-VW
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 15:54:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jUFCm-0002aj-4m
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 15:53:27 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:34271)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jUFCl-0002Z5-Di
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 15:50:43 -0400
Received: by mail-pg1-x542.google.com with SMTP id s8so3379810pgq.1
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2020 12:50:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-language:content-transfer-encoding;
 bh=5CqyjSpeZqqR3LzV6LwSAhwRgLGWMCp1QYDDERvst6I=;
 b=gJQEli4QGptQ6J2JeDc39eTvoDX5/HNheIqbLIboWLx19KTwy+MrqfOAS++soWRDMK
 +Drnb1sDAvM53nMyXJzxjcUB9kMyiL0dhMVI7LtvQ0mX4GfhAXf+nI/n3vlNfxf5x84d
 OCM3f6R3S1VG7cPQundp66ivEOpEGzF/s3qKtGX589f1HNWb0Ey04ILzypvjKtJPCL96
 0ejx5tqvrjr3isK/UD/bRIT7Sqc8DxlF89NdWS2TMkyNn9fbPOwZ36MxWIPMKuDL4xot
 9CE3ie1/qWfSAjKd2UbhLaJjCLsutyqiJ0ur+WoLhOJSOF6zd6zSgKnetspT29ELoII9
 tRIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=5CqyjSpeZqqR3LzV6LwSAhwRgLGWMCp1QYDDERvst6I=;
 b=tt1cwrRbxJbyRaiXj/VxStX9ywDQXvPgza83aADSpoo7/7llxW5sXMF4giXU5+PVxX
 LgLYK36aLUqYogwQnvIFXNjx1HE1IxRO6N6Y29yRSIxafJ8R42ayraSht0m/n3xrhJqR
 AUSMpNULcRMs2/DA5+N1h/9XFFzsoTGBGFE2KtNeZrpXjjH5NPe41QtKX3nu6DBZQqms
 LU8CGyevUkPjVyc2ujVsktWNyqHRJEa3r4lNNxjQWeHIqI8euwhQlDlKnYcJnYxE7BWx
 xY1gU69U1m0pyaog3Q2EDDkaUzZJj6nb+1Xf24e8co0zg5jjIOayzDwyvry4PDT2JcVR
 eMuA==
X-Gm-Message-State: AGi0PuazELdh/PNGM1Nz34tTBd5wFsu2jz4jrVh1MsFQX4hdafd8ZFnz
 jdHvzb+03tch7n4xyfY9QJGSJCiFvhc=
X-Google-Smtp-Source: APiQypIJ4c3OpGxfQmvcal/8KMtQVGY5asn5c/rtA4nKMsA8YHOMXNsecWAe4SL+eOm5IcLn860PAg==
X-Received: by 2002:a62:e50f:: with SMTP id n15mr391862pff.22.1588276241557;
 Thu, 30 Apr 2020 12:50:41 -0700 (PDT)
Received: from [192.168.1.11] (174-21-149-226.tukw.qwest.net. [174.21.149.226])
 by smtp.gmail.com with ESMTPSA id y16sm522078pfp.45.2020.04.30.12.50.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 30 Apr 2020 12:50:40 -0700 (PDT)
Subject: Re: [PATCH 18/36] target/arm: Convert Neon 3-reg-same VQADD/VQSUB to
 decodetree
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20200430181003.21682-1-peter.maydell@linaro.org>
 <20200430181003.21682-19-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <fa8bd23b-cbc1-e8ab-e9e6-fcec45064ce5@linaro.org>
Date: Thu, 30 Apr 2020 12:50:38 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200430181003.21682-19-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::542;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x542.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2607:f8b0:4864:20::542
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
> Convert the Neon VQADD/VQSUB insns in the 3-reg-same grouping
> to decodetree.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/arm/translate-neon.inc.c | 15 +++++++++++++++
>  target/arm/translate.c          | 14 ++------------
>  target/arm/neon-dp.decode       |  6 ++++++
>  3 files changed, 23 insertions(+), 12 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

