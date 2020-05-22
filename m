Return-Path: <SRS0=muh1=7E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 943D6C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2020 03:02:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4CCFC207D8
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2020 03:02:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XYIx1ir2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CCFC207D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59492 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbxwi-0001qw-Eb
	for qemu-devel@archiver.kernel.org; Thu, 21 May 2020 23:02:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49694)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jbxw1-0000HI-8q
 for qemu-devel@nongnu.org; Thu, 21 May 2020 23:01:21 -0400
Received: from mail-pj1-x1042.google.com ([2607:f8b0:4864:20::1042]:35128)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jbxvz-0002nI-Jh
 for qemu-devel@nongnu.org; Thu, 21 May 2020 23:01:20 -0400
Received: by mail-pj1-x1042.google.com with SMTP id 5so4371600pjd.0
 for <qemu-devel@nongnu.org>; Thu, 21 May 2020 20:01:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=LbddS7ryjP0xw44sdVz4E/WV10fQdQ5H2rAbC0COCz0=;
 b=XYIx1ir2b1gxqPYcXnO5g5Z1m338IbY0Oc8hAGevoHTnSwJcbM3s41bF75TXPMyjF6
 vGueMMKZlCxMnA4WSw0py3ig8lVJGLDyMw3PvfObAoO9rO4PYscHmqmzLGdBFAB+2zhw
 7C02zh6NuBM8nvnOimFhJ2Nxrt6YGuoPghuvj8bvPrDOm4ped/QaEbeC1VCgPMPzb/DX
 gyFNl4f1AhswYh550qnyygmLj7hgWlMF6HUfJeoBe7IQsj3ROrjFxjm3iV7FKqssZ2aQ
 rq1u7zOSFuD0UQgZSnDB4Ho0G3EfL+6flg8WyTNzgjpOFakCJyOtEtg2SwVfpQkA/fB3
 Vkxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=LbddS7ryjP0xw44sdVz4E/WV10fQdQ5H2rAbC0COCz0=;
 b=akQQB0nNUDh5glVqKggdaZ7E2gx/DNT0w28VLfitkurEn2LYLPfDiFaMvB8YJ/6yS9
 CgudDIwWpdbvWren/A522o1/EXDftsu7VIBypYzfxRBfTQCN+BnABuLrGmOKJ85YjHYX
 YbML6qhSSdxY1qLdXJIxtmwNBS/wvKJIWwJ9bkJdYWVERb14omZYuygvUkLL3vlwVJXc
 6aacnIDN0x+J1cAimSrc+R1g6m7VsQpEnqS7HvGCThVha+YZiqq85Z2bl6eNymTw59/9
 zJknm92yrgIakth/EMuAvEqgzRw0wz4cGCB8P8911pZlSrHtW+RaCQmNCBleQB/fGk1a
 gvmw==
X-Gm-Message-State: AOAM533wtvVVqWUvy3Q4JDtKhxFY4QL3NnIohWbuR35Otg0pQt7kxWSC
 0OBvbhkyP4tIRjYISFgPAaWg6Q==
X-Google-Smtp-Source: ABdhPJwgAe5k/xsAJwr3uJrnnlVJ7AYq3FiAeMPAgXAXC5ijmIoZ0Dg4MS22eS7x5Nge2JR6p8hC2Q==
X-Received: by 2002:a17:90a:a60a:: with SMTP id
 c10mr1829161pjq.143.1590116478162; 
 Thu, 21 May 2020 20:01:18 -0700 (PDT)
Received: from [192.168.1.11] (174-21-143-238.tukw.qwest.net. [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id mg9sm5413170pjb.10.2020.05.21.20.01.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 21 May 2020 20:01:17 -0700 (PDT)
Subject: Re: [PATCH v1 08/15] tests/docker: bump fedora to 32
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20200520140541.30256-1-alex.bennee@linaro.org>
 <20200520140541.30256-9-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <a559fb88-b7de-672f-c754-87bfd9092e68@linaro.org>
Date: Thu, 21 May 2020 20:01:15 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200520140541.30256-9-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1042;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1042.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Fam Zheng <fam@euphon.net>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/20/20 7:05 AM, Alex Bennée wrote:
> We should be keeping this up to date as Fedora goes out of support
> quite quickly.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>  tests/docker/dockerfiles/fedora.docker | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


