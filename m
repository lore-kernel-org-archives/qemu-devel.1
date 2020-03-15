Return-Path: <SRS0=WIOf=5A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D60C9C10DCE
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Mar 2020 20:29:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 51D1020578
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Mar 2020 20:29:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RucN+341"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51D1020578
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58248 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDZtN-0001Wz-04
	for qemu-devel@archiver.kernel.org; Sun, 15 Mar 2020 16:29:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45238)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jDZiK-0006T9-Ff
 for qemu-devel@nongnu.org; Sun, 15 Mar 2020 16:18:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1jDZiJ-0001lc-FT
 for qemu-devel@nongnu.org; Sun, 15 Mar 2020 16:18:24 -0400
Received: from mail-pj1-x1041.google.com ([2607:f8b0:4864:20::1041]:52648)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1jDZiJ-0001h4-7k
 for qemu-devel@nongnu.org; Sun, 15 Mar 2020 16:18:23 -0400
Received: by mail-pj1-x1041.google.com with SMTP id ng8so29660pjb.2
 for <qemu-devel@nongnu.org>; Sun, 15 Mar 2020 13:18:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=hUbgdJ8axJNBUNavUWRYwmcrmlXlzsQv8v+AhElMzek=;
 b=RucN+341Pl+98/KvSN2eY+qezA3vEcRqE3AjB/4Rf63S2hr0bM1rExlB/XwbFI90Me
 PLuAgBlYSqSlG+txsaNPVK3kQ2llL7+IN5V4DZmAaK+zMxftjvQnJW4pp0rHOingxnrg
 xMkbNgie2vhRQz5iSBV7JWSnzmifnS2fK5fV9olR3ZFWtsd+4ROSnoA6jAIiBaas7gUN
 PcNI3b9bk02PC94xkf35OjROnsQfuy8lVvjn3IRml69T3pk+ROUV7G67+4leH/IEnfHY
 wlKay4tNAuAXWtw0EcI/0jkPhih2eba287kF6byYGHOPcwqPT8V/51q6/O4mb5ZZmvlu
 pB7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=hUbgdJ8axJNBUNavUWRYwmcrmlXlzsQv8v+AhElMzek=;
 b=ozHYjcgXW65q3ldXZjWKslc9UyE/HxsrnQIjMbqyj1RuzSvcLgyktHkO17/MOD8IYz
 ZRyyOly3YAay5FI2DhUC6Cfp2Mt3Ha12NdzlkLjfRsOtX1jEG4CNXkfjml+0utqNOEdh
 zlNujdDHPB9lZwzOCy7ql2msaFABjDzPU8KjXGWpjB00oVwIfQgvkvra26W0DOI3tGzT
 z0GEbHejQwjxhDOoe33eiGT0xU//vdGcm3loYlDCYiyxM0OposPchoSfEOWVi/W9POrT
 dlvkqg9if6ZTXNqrKAI+l+zW2kXyernRa495H2CQQ3AcM9FXaJ7MSmVQ6kNGlbQUZhkZ
 iVlg==
X-Gm-Message-State: ANhLgQ1PtMpdV0CfefB8z/mUdCzzqrutQNZvu4pS15V4MgpFSW+R10nt
 ZxnrmB+2kzjEsCucX5tsdqUVrg==
X-Google-Smtp-Source: ADFU+vs/addkmQN34sUVbe/KT4pAtgwLGl2LIxE4JatwXayNepsIoE1ea57z4d0zFfseanAvIUJJ8A==
X-Received: by 2002:a17:90a:e2c4:: with SMTP id
 fr4mr21482382pjb.91.1584303502400; 
 Sun, 15 Mar 2020 13:18:22 -0700 (PDT)
Received: from [192.168.1.11] (97-126-123-70.tukw.qwest.net. [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id
 f17sm51074460pge.48.2020.03.15.13.18.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 15 Mar 2020 13:18:21 -0700 (PDT)
Subject: Re: [PATCH 06/14] util/Makefile: Reduce the user-mode object list
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20200313183652.10258-1-philmd@redhat.com>
 <20200313183652.10258-7-philmd@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <d20dc940-1d2d-eed8-3240-9cf28b55d6a7@linaro.org>
Date: Sun, 15 Mar 2020 13:18:19 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200313183652.10258-7-philmd@redhat.com>
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <Alistair.Francis@wdc.com>, qemu-riscv@nongnu.org,
 Eduardo Habkost <ehabkost@redhat.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 David Hildenbrand <david@redhat.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Cornelia Huck <cohuck@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 qemu-s390x@nongnu.org, qemu-arm@nongnu.org, qemu-ppc@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/13/20 11:36 AM, Philippe Mathieu-Daudé wrote:
> These stubs are not required when configured with --disable-system.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> ---
>  util/Makefile.objs | 59 +++++++++++++++++++++++++++++-----------------
>  1 file changed, 38 insertions(+), 21 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

