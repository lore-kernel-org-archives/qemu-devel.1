Return-Path: <SRS0=5yua=6H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76CD9C54FD0
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 23:14:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 46A6621556
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 23:14:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EdbmF4tk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46A6621556
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44620 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRl3C-0006Ml-Bk
	for qemu-devel@archiver.kernel.org; Thu, 23 Apr 2020 19:14:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43092)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jRl2D-0005aw-Cy
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 19:13:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jRl2C-00015o-Ff
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 19:13:33 -0400
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643]:38863)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jRl2B-00012P-So
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 19:13:32 -0400
Received: by mail-pl1-x643.google.com with SMTP id w3so3021055plz.5
 for <qemu-devel@nongnu.org>; Thu, 23 Apr 2020 16:13:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=OX4b+QNcL22+ozwOoFSapKccX6ob5fxurJmJf+QKPjI=;
 b=EdbmF4tkSxpqf37l0+m9l/lC44aWzLB1PPQZPCd6GyPYtkno6ackCslv+VGfPxC+3o
 V7TUjp7fBr9ibr4iFbM5sNiXdI2e4TYmAv0/2Y3t4L6kvx+H0zQhS7xp4MhoPtSxHJvR
 mmRcM5cobLXFNoeNbahhqB71xsBQAGY+/CiiiOApTDZMUZI/lTiRHA0YICLii6b6hg+Q
 7B+I9/JiKWH64HJ+Tbw1WLVr/TjrrHt015mBCRDPIMISQsI/P4VO3T9qsFovyXTwOzFP
 da9Xxw3ZjMEdfuYLG4ZJHMYSPbpSkIjO8cvBkyp9DVaaO9L++hL3x8nytJ1ySqd2VcjK
 CVbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=OX4b+QNcL22+ozwOoFSapKccX6ob5fxurJmJf+QKPjI=;
 b=BZrBlYLnWffljt6Vez+8OcnsZYSFxGwOBs0uu64TwP3lXBhWKuj9sYvZqzoYILS1j/
 LPVzXBKn51ZjaSK903HZwL5fhDTcAbNTOHQKcVZ4/II7r6YRDlTMovAoCaAGoYRPESz3
 SYbN3nB+jtAgnARyvRBnRM3LPfaMl73UatWYZLpt9f7wZukRvHTdz3kJFRLKIwdJxLD+
 mI31AVlSi0xhtBCNEWDgBXch3cPFu+K0W/d17IJUVIbW7S6wcIP+yy8TkjivP8ubM9Gh
 WMKbNaeNy6elvJ2Ctk466yvG5DgL/RUum9yImuWJt7Sz7XM/pZRsoMcIFIYfkLBtk+2G
 b4OA==
X-Gm-Message-State: AGi0PuZwI29f4vbG2mVkzBvbtS8JHkchs6Ay5tQnfE+xTGqV8mG5SYSN
 omRYlR+QI7Cwv4fNQi5V1Z1jFhxBcIQ=
X-Google-Smtp-Source: APiQypIFWntDssHP3Q7yQH5dACFu4SAutOgZ6p5tIb455lL04SuoPT/JZ4rfKTFimf7Jry2FdKkUdQ==
X-Received: by 2002:a17:902:d203:: with SMTP id
 t3mr6040976ply.136.1587683610076; 
 Thu, 23 Apr 2020 16:13:30 -0700 (PDT)
Received: from [192.168.1.11] (174-21-149-226.tukw.qwest.net. [174.21.149.226])
 by smtp.gmail.com with ESMTPSA id v127sm3572197pfv.77.2020.04.23.16.13.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 23 Apr 2020 16:13:29 -0700 (PDT)
Subject: Re: [PATCH v2 13/36] tcg: Use tcg_constant_{i32,i64} with tcg int
 expanders
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
References: <20200422011722.13287-1-richard.henderson@linaro.org>
 <20200422011722.13287-14-richard.henderson@linaro.org>
 <87ftcvb82k.fsf@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <df8292e5-5b27-31eb-1e4a-3e8f835481fc@linaro.org>
Date: Thu, 23 Apr 2020 16:13:27 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <87ftcvb82k.fsf@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::643;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x643.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2607:f8b0:4864:20::643
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/22/20 1:04 PM, Alex Bennée wrote:
> 
> Richard Henderson <richard.henderson@linaro.org> writes:
> 
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> 
> We have a regression. Setting up a build dir with:
> 
>   ../../configure --disable-tools --disable-docs --target-list=sparc-softmmu,sparc64-softmmu
>   make -j30 && make check-acceptance
> 
> And then running a bisect between HEAD and master:
> 
>   git bisect run /bin/sh -c "cd builds/bisect && make -j30 && ./tests/venv/bin/avocado run ./tests/acceptance/boot_linux_console.py:BootLinuxConsole.test_sparc_ss20"
> 
> Fingers:
> 
>   a4d42b76dd29818e4f393c4c3eb59601b0015b2f is the first bad commit
>   commit a4d42b76dd29818e4f393c4c3eb59601b0015b2f
>   Author: Richard Henderson <richard.henderson@linaro.org>
>   Date:   Tue Apr 21 18:16:59 2020 -0700
> 
>       tcg: Use tcg_constant_{i32,i64} with tcg int expanders
> 
>       Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>       Message-Id: <20200422011722.13287-14-richard.henderson@linaro.org>

Ho hum.  I can reproduce this, but after a day of debugging I'm no closer to
figuring out what's wrong than when I started.

I'm going to put this whole section of TEMP_CONST to the side for now.


r~

