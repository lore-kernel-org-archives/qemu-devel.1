Return-Path: <SRS0=QiA4=7D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06E21C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 14:09:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B510B20826
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 14:09:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JOn39Jb2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B510B20826
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33182 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbltB-0003NH-Ud
	for qemu-devel@archiver.kernel.org; Thu, 21 May 2020 10:09:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60048)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jbls6-0001iA-JI
 for qemu-devel@nongnu.org; Thu, 21 May 2020 10:08:30 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:42615
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jbls5-0003t8-O4
 for qemu-devel@nongnu.org; Thu, 21 May 2020 10:08:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590070108;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jWHBb3oLbjCDWidhFKq+QmigY0VgmRV13r6ELObzerw=;
 b=JOn39Jb2D2FStyvUHVfqilNtcJTZLBeULrXBUckYs7KOJtkU/GGxNE46Lze8d05UQe4JFD
 NKy7Zuei30hGAHliq2S5YCKZuhA75N66z1cyVEQSr2U6KUCBqoE2Cg6r1WEhavTPE3Nf1o
 ssVazXaCUs+XtW1hWGUuPqQMilZolS0=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-390-mOfH5dLqMdSGM5gOC5U9ZA-1; Thu, 21 May 2020 10:08:26 -0400
X-MC-Unique: mOfH5dLqMdSGM5gOC5U9ZA-1
Received: by mail-wm1-f70.google.com with SMTP id v23so1908652wmj.0
 for <qemu-devel@nongnu.org>; Thu, 21 May 2020 07:08:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=jWHBb3oLbjCDWidhFKq+QmigY0VgmRV13r6ELObzerw=;
 b=IN52HRtLrouqjLDTsnD0iA6+GJu4Tm/YZ+r01y+mzscRfZPbgeDH0jXwy6D/je7qcn
 6qRy9eF59rz2yFhlTwaEy9XpSN8Ty0dtSCIjKRkpm+K4Q/RTA7DWeU6bmvitiMBbTkh6
 Gyws9XRKJTSB3h1dHfzgENq2I9oTnONYHGfZTKDwJ+9rmK5bDo370ddMHVUOE9G1M+VB
 PobCTtIaFMqaB3fkcEKiHunlWUyA6WjPDD1Xj9dvQOcIDh0umDacoE1Fs3zYL0bGD5yS
 r9cNUVhtv02rVY1jLHuJH8mEasybtED7ANqIcmPK6ss4XXqAS9sz+kiLxva1QvCJI5bm
 +hSg==
X-Gm-Message-State: AOAM533WDYhPnz9dDDkpwkHXNxsAEJzqoFUG4S3bgNfX0/ZzfmOa66cz
 T97xGLAsTczscc47GV1BNYB/5ZpjPX7ZJCzimNdEas0k4W0iU4zAtTECNPdsA5OdoSwtyFtUUwE
 BnTpPkYxF3mEvZfM=
X-Received: by 2002:a5d:6b83:: with SMTP id n3mr9410312wrx.213.1590070104751; 
 Thu, 21 May 2020 07:08:24 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxcA1F3tFUp5bo8U3p7Zyf+jXGKn8i7k+3qryOsnRc8/lisqeBP8ADcCiwlmEpU8b0vLDdhBQ==
X-Received: by 2002:a5d:6b83:: with SMTP id n3mr9410293wrx.213.1590070104571; 
 Thu, 21 May 2020 07:08:24 -0700 (PDT)
Received: from [192.168.1.40] (17.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.17])
 by smtp.gmail.com with ESMTPSA id g187sm6637393wmf.30.2020.05.21.07.08.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 21 May 2020 07:08:23 -0700 (PDT)
Subject: Re: [PATCH 6/6] sm501: Remove obsolete changelog and todo comment
To: BALATON Zoltan <balaton@eik.bme.hu>, qemu-devel@nongnu.org
References: <cover.1589981990.git.balaton@eik.bme.hu>
 <0edaadbc25f1eeb6eef648816770cbcd6a4efa2e.1589981990.git.balaton@eik.bme.hu>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <135ea132-61c5-1e43-901a-06d4fa9e1399@redhat.com>
Date: Thu, 21 May 2020 16:08:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <0edaadbc25f1eeb6eef648816770cbcd6a4efa2e.1589981990.git.balaton@eik.bme.hu>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/21 06:06:22
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Sebastian Bauer <mail@sebastianbauer.info>,
 Magnus Damm <magnus.damm@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/20/20 3:39 PM, BALATON Zoltan wrote:
> Also update copyright year for latest changes
> 
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> ---
>   hw/display/sm501.c | 19 +------------------
>   1 file changed, 1 insertion(+), 18 deletions(-)
> 
> diff --git a/hw/display/sm501.c b/hw/display/sm501.c
> index 13269cc9f4..b76b691674 100644
> --- a/hw/display/sm501.c
> +++ b/hw/display/sm501.c
> @@ -2,7 +2,7 @@
>    * QEMU SM501 Device
>    *
>    * Copyright (c) 2008 Shin-ichiro KAWASAKI
> - * Copyright (c) 2016 BALATON Zoltan
> + * Copyright (c) 2016-2020 BALATON Zoltan
>    *
>    * Permission is hereby granted, free of charge, to any person obtaining a copy
>    * of this software and associated documentation files (the "Software"), to deal
> @@ -40,23 +40,6 @@
>   #include "ui/pixel_ops.h"
>   #include "qemu/bswap.h"
>   
> -/*
> - * Status: 2010/05/07
> - *   - Minimum implementation for Linux console : mmio regs and CRT layer.
> - *   - 2D graphics acceleration partially supported : only fill rectangle.
> - *
> - * Status: 2016/12/04
> - *   - Misc fixes: endianness, hardware cursor
> - *   - Panel support
> - *
> - * TODO:
> - *   - Touch panel support
> - *   - USB support
> - *   - UART support
> - *   - More 2D graphics engine support
> - *   - Performance tuning
> - */
> -
>   /*#define DEBUG_SM501*/
>   /*#define DEBUG_BITBLT*/
>   
> 

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>


