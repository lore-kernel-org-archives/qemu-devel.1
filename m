Return-Path: <SRS0=WkHy=5I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E089C54EEB
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2020 18:23:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 31B6E2051A
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2020 18:23:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dV65+W2R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31B6E2051A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38170 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGRj4-0000JH-A7
	for qemu-devel@archiver.kernel.org; Mon, 23 Mar 2020 14:23:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60818)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jGRgx-0006u7-QV
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 14:20:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1jGRgw-00011P-Ue
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 14:20:51 -0400
Received: from mail-pj1-x1029.google.com ([2607:f8b0:4864:20::1029]:55370)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1jGRgw-0000yJ-OQ
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 14:20:50 -0400
Received: by mail-pj1-x1029.google.com with SMTP id mj6so209117pjb.5
 for <qemu-devel@nongnu.org>; Mon, 23 Mar 2020 11:20:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=VKGjYs3oXHPnIkYWT1PFSmhGP9elsjAncbxy++ukncI=;
 b=dV65+W2R7lxUorvXgJlNSkR0Rk83q6bKvRZdvnPfBDaX1BPTvCvMkDMO/ZPe+mFLGs
 HxYEbWa5MppeDJ+wsrV2PW74e/FxoqagnBEoC0vNf2G129hcuegluSpEuHWxJUDXm6Md
 2JQ8eD3s7Ex9UU1bxL6E4iur/gWDJF51gA+XuCFFL2xAtYCiFJ3OXdQAAoxKDoNdv/fg
 x/i0LtBYWgpj9VxHLc1gyXbr+f0XKu8yxDQ90Aoi5W1+OWyhSHWsgojFuFr3O1AWVsl+
 S7zkcn8kY5yflh3ut82FO8I3xaVe1Au6iW+t2GbHv98r0n0DPnrpAZbjwMuIYkfbPlcL
 7ldw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=VKGjYs3oXHPnIkYWT1PFSmhGP9elsjAncbxy++ukncI=;
 b=qiNoz5TUa9Klep2jaLMJ1kTexPNsIbZmlSeDbxHoBxhpVlaF00E9FYYQ79gXu02P6O
 tr7RJpZmgf5O9uuDIRo8vswMP1RcQ5NyO2E+O2o0z9TIG3G6e4+K4K2kmQGZTEGGg915
 WhJULV4OMU8PB2C9/DMNNUgJnR05nYgFjlV6tXLzOUThjVf36cJ83XKlC2/4W5nAlCa7
 tMgx4jDpFrDswGwvsT8JjjgXQeiVz62waU8zjm6o1UAFELlurfYpcrTIheED6z9dcfcd
 hP/UJsD+CSTwE2XQDVquKL2+cUTuabh6vAnrav1b7m1uZ+9UoKIB6LIfHiA7Y6vEV9i9
 XIWQ==
X-Gm-Message-State: ANhLgQ2wCzlQQ7uhnIHF3ZR7NHJfj8eSluGIpjaS0BHGZ5hbAla6UvWF
 ilns7ZEjOnmKh7Jd9ovjAxv9BA==
X-Google-Smtp-Source: ADFU+vs0tV5NKYmV6zfFk6GDBwRXeGycMgUWD+ipSAV2oq9T+qbgF7ltdJzNjVjiR/7quS5Yt0Wduw==
X-Received: by 2002:a17:90b:292:: with SMTP id
 az18mr687530pjb.126.1584987647709; 
 Mon, 23 Mar 2020 11:20:47 -0700 (PDT)
Received: from [192.168.1.11] (97-126-123-70.tukw.qwest.net. [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id
 v59sm248760pjb.26.2020.03.23.11.20.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 23 Mar 2020 11:20:46 -0700 (PDT)
Subject: Re: [PATCH v1 10/11] tests/docker: Add libepoxy and libudev packages
 to the Fedora image
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20200323161514.23952-1-alex.bennee@linaro.org>
 <20200323161514.23952-11-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <0cfedaef-2578-cbd4-5edf-4ca73c93f05e@linaro.org>
Date: Mon, 23 Mar 2020 11:20:44 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200323161514.23952-11-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::1029
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
Cc: Fam Zheng <fam@euphon.net>, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/23/20 9:15 AM, Alex Bennée wrote:
> From: Philippe Mathieu-Daudé <philmd@redhat.com>
> 
> Install optional dependencies of QEMU to get better coverage.
> 
> Suggested-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> Message-Id: <20200322120104.21267-5-philmd@redhat.com>
> ---
>  tests/docker/dockerfiles/fedora.docker | 2 ++
>  1 file changed, 2 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


