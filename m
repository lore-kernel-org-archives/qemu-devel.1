Return-Path: <SRS0=5nOY=BY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 820C5C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2020 17:48:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E1FB20774
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2020 17:48:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dravQqvW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E1FB20774
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35738 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k6do8-0007Tb-FE
	for qemu-devel@archiver.kernel.org; Fri, 14 Aug 2020 13:48:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33616)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k6dnT-00070n-HD
 for qemu-devel@nongnu.org; Fri, 14 Aug 2020 13:47:19 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:57839
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k6dnR-0002B7-8B
 for qemu-devel@nongnu.org; Fri, 14 Aug 2020 13:47:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597427235;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tsMmE8gwr2pejzqNmws1oqjo2oBd50+Pbl4l9fehsd0=;
 b=dravQqvWwa9iK7gFZwzFSnQMjWGfRV/rRcvW+qiujCN8Xabiih79C7UECfXIcj08qJ2RDN
 VnKd1n6uQeo+At1YAVMDv64N3Y5mMmbb5JD8BbzEHhDgMRaSaTI5jeq2U8Wc2xXVl3nV5T
 ClRM5acO3Pq/n4st+9uzntg+Iqbepo8=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-256-hg3v14HUPKyGFXqfvoosSg-1; Fri, 14 Aug 2020 13:47:13 -0400
X-MC-Unique: hg3v14HUPKyGFXqfvoosSg-1
Received: by mail-wr1-f71.google.com with SMTP id 89so3607574wrr.15
 for <qemu-devel@nongnu.org>; Fri, 14 Aug 2020 10:47:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=tsMmE8gwr2pejzqNmws1oqjo2oBd50+Pbl4l9fehsd0=;
 b=J151jDRbYM8UW5DcR2zGY8w/fyOvM25IYWkUQt42qoI3AqvhRf1WGGMQTO4xVLzY6f
 8n0cKWQ70oWpwCSHncX/LEjIu8zfIJzVZHAkYbdd9k0kIEShr0DOGeDOlQ3AjpGVbia/
 BI0O8T3W1rIS8YkgPbehUdaRyhltCW9iAyUEZ2/DLvquROk3kpkkUMs67b8R46FdP//G
 +fDq/y48dqr0B8qmoyD2/LR4FLN2KZqWASxlcQNhUBtZ4AEwbQZaEwH6e19RbE0F5d7M
 WjOBMP4LON+DpuunN4TOArATMXjPsJkcXMVQtuDa9TK4axr/7oBf1XEVOQ2gxvehpoxD
 Gtig==
X-Gm-Message-State: AOAM532oMWdYtN6ks7JESdJVVGCTOVByOoiD4ZNEPRCd54ue5kCUlIuU
 /NLhsnefdgccnsz6iYofq5MKrb4xAcrDTDI5lQZZssgH/iX3zZNtcKVldIBvIa2blqEG3eE3HLo
 EzDM8U4xSeKFfxls=
X-Received: by 2002:a5d:5151:: with SMTP id u17mr3696103wrt.154.1597427232484; 
 Fri, 14 Aug 2020 10:47:12 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyKuNaeHT6HokzJqDJw+k7TsouToEO21aO7yqahyG6EI+cjm+sG92GW7GHOd5REibc/VgBiuA==
X-Received: by 2002:a5d:5151:: with SMTP id u17mr3696092wrt.154.1597427232250; 
 Fri, 14 Aug 2020 10:47:12 -0700 (PDT)
Received: from [192.168.1.36] (121.red-81-40-121.staticip.rima-tde.net.
 [81.40.121.121])
 by smtp.gmail.com with ESMTPSA id o2sm15440222wmh.5.2020.08.14.10.47.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 14 Aug 2020 10:47:11 -0700 (PDT)
Subject: Re: [PATCH 05/41] aspeed_timer: Fix ASPEED_TIMER macro definition
To: Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org
References: <20200813222625.243136-1-ehabkost@redhat.com>
 <20200813222625.243136-6-ehabkost@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <4c81cf5a-87e5-514d-92f0-7785f142fe58@redhat.com>
Date: Fri, 14 Aug 2020 19:47:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200813222625.243136-6-ehabkost@redhat.com>
Content-Language: en-US
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/14 13:47:15
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/14/20 12:25 AM, Eduardo Habkost wrote:
> The macro definition had an extra semicolon.  This was never
> noticed because the macro was only being used where it didn't
> make a difference.
> 
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> ---
>  include/hw/timer/aspeed_timer.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/hw/timer/aspeed_timer.h b/include/hw/timer/aspeed_timer.h
> index 948329893c..d7c7d8ad28 100644
> --- a/include/hw/timer/aspeed_timer.h
> +++ b/include/hw/timer/aspeed_timer.h
> @@ -26,7 +26,7 @@
>  #include "hw/misc/aspeed_scu.h"
>  
>  #define ASPEED_TIMER(obj) \
> -    OBJECT_CHECK(AspeedTimerCtrlState, (obj), TYPE_ASPEED_TIMER);
> +    OBJECT_CHECK(AspeedTimerCtrlState, (obj), TYPE_ASPEED_TIMER)
>  #define TYPE_ASPEED_TIMER "aspeed.timer"
>  #define TYPE_ASPEED_2400_TIMER TYPE_ASPEED_TIMER "-ast2400"
>  #define TYPE_ASPEED_2500_TIMER TYPE_ASPEED_TIMER "-ast2500"
> 

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>


