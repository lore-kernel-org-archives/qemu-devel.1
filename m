Return-Path: <SRS0=LLOU=EL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0B2AC00A89
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2020 12:52:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E227420756
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2020 12:52:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iQcsOSxE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E227420756
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59034 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kaekF-0004UT-OJ
	for qemu-devel@archiver.kernel.org; Thu, 05 Nov 2020 07:52:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47544)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kaegM-0008Hc-Tg
 for qemu-devel@nongnu.org; Thu, 05 Nov 2020 07:48:02 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:31750)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kaegL-00028K-7u
 for qemu-devel@nongnu.org; Thu, 05 Nov 2020 07:48:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604580480;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NQCqmgTHEWa12dQII1/mmbS1cS4a68PprST7eAF/BDA=;
 b=iQcsOSxEW1WYSaaX+4YSqe+H8FosnfAUpzLcvjJVCFexiL/p4lD/pK2N6HWC4IpAV7HZgm
 ilQHiOOt30NJQF3AxpegK8+C1Ih0lFNbDCB85txwwJksV9d1IW2Nxdd99dedb01ggGEaK4
 9zsL89X3Bi585GHX6vVXvLcR+Z5owuM=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-221-C-pA_8aPMriaHh-9nEaRGw-1; Thu, 05 Nov 2020 07:47:56 -0500
X-MC-Unique: C-pA_8aPMriaHh-9nEaRGw-1
Received: by mail-wr1-f69.google.com with SMTP id t17so661405wrm.13
 for <qemu-devel@nongnu.org>; Thu, 05 Nov 2020 04:47:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=NQCqmgTHEWa12dQII1/mmbS1cS4a68PprST7eAF/BDA=;
 b=RIjY8De0SJaByHeMFpQeFn/1lKT9CjRovIv1TxXG2OEnAC9do8Y8eBW43G4yWDL0Px
 lgTiVqdC53dURqPJ0B5djE9iMaax2s4qfkF7L7qtZRIzjt3cH0TW8B7IrHJk9ctJoZ7s
 Njnxn41bITn8mdM6lOBQhKS4R8UUTK0J+zX3AJGPFwsT4qwZuDnVh4/75x7AxqLCnDI+
 R6PM/PZk3jageHrJbnJ7paInHq/51/zbQzHb82sRQh44GHy6U4rq0RwQ97W7LKqtXtu/
 uxWXjZYT0HfYaieqK1tqYgllu3qXdXSWAhvy1vzAfNmieanrmGiitMa65b/XXUFlIFY5
 pF5A==
X-Gm-Message-State: AOAM533ujfnL8mYqg3GQpSy6qtjl20dqELKmdXrXs2pW4u3QHXF5zGvi
 Qr2/TSbPwxtrsxz45XJOwpZzgB6huiGg4xArXvdi8DdSdHwGO2c9X4DTmsa8yaQmEofdH64nn8J
 EcJKmwKxDJJKMxXk=
X-Received: by 2002:a5d:63cb:: with SMTP id c11mr2588260wrw.243.1604580475610; 
 Thu, 05 Nov 2020 04:47:55 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy4jMD5kKgSW0rVfHnL4oTDKy/H6iLW2t3/LrIDfiSP8sZusJrpEBT5zkVF4W+ysU/c1GNtYQ==
X-Received: by 2002:a5d:63cb:: with SMTP id c11mr2588248wrw.243.1604580475452; 
 Thu, 05 Nov 2020 04:47:55 -0800 (PST)
Received: from [192.168.1.36] (234.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.234])
 by smtp.gmail.com with ESMTPSA id y11sm2145757wmj.36.2020.11.05.04.47.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Nov 2020 04:47:54 -0800 (PST)
Subject: Re: [PATCH] fix make clean/distclean
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20201105124534.620635-1-pbonzini@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <97b908b1-acfb-0fb1-e773-585d1ef13925@redhat.com>
Date: Thu, 5 Nov 2020 13:47:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201105124534.620635-1-pbonzini@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/05 01:14:53
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/5/20 1:45 PM, Paolo Bonzini wrote:
> A misplaced $(quiet-@) meant that "make clean" and "make distclean" did
> not work properly.
> 
> Reported-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  Makefile | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>

Thanks for the quick fix!


