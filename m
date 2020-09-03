Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0E58C433E2
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 16:53:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A81DC206A5
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 16:53:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Gvj4jEQg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A81DC206A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34960 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDsTu-00046h-UQ
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 12:53:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46300)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kDsSq-0002YR-Cr
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 12:51:56 -0400
Received: from mail-pj1-x1041.google.com ([2607:f8b0:4864:20::1041]:54775)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kDsSo-000612-QC
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 12:51:56 -0400
Received: by mail-pj1-x1041.google.com with SMTP id mm21so1823643pjb.4
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2020 09:51:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=gKyStVPMR11wiBdEUXGdXWnGyu4TOXsMnAw+i7Tnooc=;
 b=Gvj4jEQgPTaiQyJIc2kSydxkz+b6CMq882b6QaftXVwxxdi7VbU9AMVGydyIen/47C
 8JYlVUeF74F33YzEDPF5DXERVG3oPI9bm2JuqyEFelAiUC5x6fHSwv+amlPOR5vJCGI/
 XmGNWzUlQacZzHi6QUGKMgN4tyS9wFE2Avc/YSSb7sgiJoBVjX8mcJyCSuJb6yaiUaDC
 U/x5dp6Ti40bZlvB9ol/A74nLsTc9Dyvf0nkJKUcC15677XY4N68OUj0q7ogzjHgCayz
 mtcSZz4M+DO8o9RUp25rYdJ4NXuGImwaNjGP0uMDmC7SlKG9+v0PppJRBfnLmXz69NV7
 NTtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=gKyStVPMR11wiBdEUXGdXWnGyu4TOXsMnAw+i7Tnooc=;
 b=JkRtAevNv7uEpHFg9F8ylKPlxpPJ0WZ1vVtaEXU49F9nc8F+FD7MYcYESUXNeZpkHE
 GVI3mDrA5lW2NeUs1/WbLwi4XxI1FCkwHoPDa7/SLRdXkoo784FsVyx6ydgQp6JP+/0i
 R0pNBb1KLMx1SU2jg+8IwicwSRCby+qjMgI8ddxfCUsLvpi3lZj1Ao27o5jbnXpP2j6+
 rQyIEuOaQbQoKvnJBfQwjeuzpStaU0fBWjO5QQXiEtq3Ib/cSHxJI/3qb0KzF/ZNlueD
 D7jCNDKnZwZCh53WVJaw+Ip2+03MavGzjsHvH+KskGYD7b9LAVjk8LpoVzmaFNyMntLT
 wokQ==
X-Gm-Message-State: AOAM532thNjcDEAeWJjtM/kianbo5+QFURGBlKA8J/qO+6xO2/8mje37
 kxB2Tq5P8hgG3fC6oXStFKTAdoRPoD023w==
X-Google-Smtp-Source: ABdhPJyVQUAYDc0Cvl6RQ20ZTbS+nZWtrgEFNOXFnGFENgmQtuC65Oa8y7KVenV284pX1WydU+phQw==
X-Received: by 2002:a17:90a:65ca:: with SMTP id
 i10mr4187096pjs.137.1599151913493; 
 Thu, 03 Sep 2020 09:51:53 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id y1sm3307630pgr.3.2020.09.03.09.51.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 03 Sep 2020 09:51:52 -0700 (PDT)
Subject: Re: [PATCH v6 3/8] util: rename qemu_open() to qemu_open_old()
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
References: <20200903152210.1917355-1-berrange@redhat.com>
 <20200903152210.1917355-4-berrange@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <7c0e6516-67ba-1a98-1705-9d79104e2c96@linaro.org>
Date: Thu, 3 Sep 2020 09:51:50 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200903152210.1917355-4-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1041;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1041.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-2.403,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/3/20 8:22 AM, Daniel P. Berrangé wrote:
> We want to introduce a new version of qemu_open() that uses an Error
> object for reporting problems and make this it the preferred interface.
> Rename the existing method to release the namespace for the new impl.
> 
> Reviewed-by: Eric Blake <eblake@redhat.com>
> Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> Reviewed-by: Markus Armbruster <armbru@redhat.com>
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~


