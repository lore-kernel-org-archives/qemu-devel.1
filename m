Return-Path: <SRS0=qJMs=D2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3735AC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 19:52:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E4B722314
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 19:52:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MpK6d4YL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E4B722314
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57338 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUbCV-0000mb-2v
	for qemu-devel@archiver.kernel.org; Mon, 19 Oct 2020 15:52:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52784)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kUbAk-00089n-Dj
 for qemu-devel@nongnu.org; Mon, 19 Oct 2020 15:50:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:34235)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kUbAi-0007HH-5Q
 for qemu-devel@nongnu.org; Mon, 19 Oct 2020 15:50:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603137018;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=seHlbI5CtTjdMVal1QJSYfwQkJ8X0lZXZy8KGXNJ3H8=;
 b=MpK6d4YL/r7K2sVL3Z/RAsew97Kwu+6eJJNxa6qlSao0t1GzUidC5T6tO3oA4ca0ije52U
 T3Poy4wqf6mXsagFyfWELsWg7WC1LvyLyTG4Csa+3Yjz38AK9sBUq6hd+fg0erYQQxgBWD
 gkpADFmiLyIr9f+5VM2LR/NJlWNH/kw=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-509-wVVl7JI-MdW44R4vxzdcmg-1; Mon, 19 Oct 2020 15:50:17 -0400
X-MC-Unique: wVVl7JI-MdW44R4vxzdcmg-1
Received: by mail-wr1-f71.google.com with SMTP id t11so288561wrv.10
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2020 12:50:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=seHlbI5CtTjdMVal1QJSYfwQkJ8X0lZXZy8KGXNJ3H8=;
 b=b8lOdJadTW1nbBf4wwVtq/PoclWuxXAykbEl0/MspPQ96BdqAgTF4sDs/c4Z7Ijz2p
 4Vr0cr8a/C2NvneL2idCThS/HT3z867xonc7ofOorDVpkK8957fQu2uAZtASwMC/KcxE
 NcrFZYJKJ/PwtxxH/RmPg4fmeJ9DpjIim09MpBwZURyxsMWjWvENGtz55pHZBx8qPHIr
 nH28VqUAc53D3rEVMH226oDSXX/bzwqkSrTDivxvyJi5Y5+bhA/CO89PcZR+MqdwX/Dj
 SZrCJVGglipo/YUxanaQKaHq1Qa1Bqd3tEPYushXw2H16hdLQGPu2D3jZGi3bfZRWaZc
 GBbw==
X-Gm-Message-State: AOAM5330re6SLBReKcqDhoJFVBV/K5E1F3QcEYTelJ8YHxf9esPvriTb
 wZD8s61FvgOiXCncHupQaeqm0ODBCCi3PlYPpR0hG8V3RUr7orEB9oUW9Eyk9aJ8RQD/8+t2zKv
 ouyUPdhaziQOQ4iQ=
X-Received: by 2002:a1c:9a46:: with SMTP id c67mr784666wme.115.1603137016057; 
 Mon, 19 Oct 2020 12:50:16 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxkQ8JTHOc9YZLOQY2uWEeoRYi65HpEH0+yeS0cIBJu2m3Gxvr1zqEOuGiP98edf5/qIYnD5g==
X-Received: by 2002:a1c:9a46:: with SMTP id c67mr784651wme.115.1603137015862; 
 Mon, 19 Oct 2020 12:50:15 -0700 (PDT)
Received: from [192.168.1.36] (237.red-88-18-140.staticip.rima-tde.net.
 [88.18.140.237])
 by smtp.gmail.com with ESMTPSA id a82sm722449wmc.44.2020.10.19.12.50.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 19 Oct 2020 12:50:15 -0700 (PDT)
Subject: Re: [PATCH] intel_iommu: Fix two misuse of "0x%u" prints
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
References: <20201019173922.100270-1-peterx@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <2dc1f79a-da6a-3d66-5b34-a462adcb0a7d@redhat.com>
Date: Mon, 19 Oct 2020 21:50:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201019173922.100270-1-peterx@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/19 15:28:27
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
Cc: Jason Wang <jasowang@redhat.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/19/20 7:39 PM, Peter Xu wrote:
> Dave magically found this.  Fix them with "0x%x".
> 
> Reported-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>   hw/i386/intel_iommu.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> index 749eb6ad63..70ac837733 100644
> --- a/hw/i386/intel_iommu.c
> +++ b/hw/i386/intel_iommu.c
> @@ -2665,7 +2665,7 @@ static uint64_t vtd_mem_read(void *opaque, hwaddr addr, unsigned size)
>   
>       if (addr + size > DMAR_REG_SIZE) {
>           error_report_once("%s: MMIO over range: addr=0x%" PRIx64
> -                          " size=0x%u", __func__, addr, size);
> +                          " size=0x%x", __func__, addr, size);

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>


