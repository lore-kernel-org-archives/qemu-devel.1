Return-Path: <SRS0=LLOU=EL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F23DC388F7
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2020 19:22:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 81CB62078E
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2020 19:22:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AXb22Ero"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81CB62078E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49894 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kakpq-0007Al-7P
	for qemu-devel@archiver.kernel.org; Thu, 05 Nov 2020 14:22:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56068)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kaknq-0006Ev-BV
 for qemu-devel@nongnu.org; Thu, 05 Nov 2020 14:20:10 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:31204)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kakno-0007Ko-Cr
 for qemu-devel@nongnu.org; Thu, 05 Nov 2020 14:20:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604604007;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wPUgjqaNXtymxlf9iwoyhzdAiVmjShyhmkwdqKM2PxU=;
 b=AXb22EroueUyJNssIDYa8wZsdgHiRCj9HpAdsWWd6oYa8o9rUcUXoAoVEAu6NChB1XEe9E
 HDXKaFSkH3PSbd8dVAWcfHE2FGZ1Mxi5WGru+pmJmhAyaq1rmoWzGA8p9zh79QQtxDKcCT
 8Niq87p7RBiMiwTE6YomLjj7v5rbh+c=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-336-x8Lu5obIPNGctd0S1sf2WA-1; Thu, 05 Nov 2020 14:20:05 -0500
X-MC-Unique: x8Lu5obIPNGctd0S1sf2WA-1
Received: by mail-wm1-f71.google.com with SMTP id y187so1004299wmy.3
 for <qemu-devel@nongnu.org>; Thu, 05 Nov 2020 11:20:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=wPUgjqaNXtymxlf9iwoyhzdAiVmjShyhmkwdqKM2PxU=;
 b=RLPHVRSLi10Y9yYmbe+jpCFoezZc31fx/ldHbZbUe9z7aW0LPgCJurBxUTbtq9U07A
 ok0drqYBGWawZrvxbqddFgqDEtDZN15UcGC1VMv6uaQRQkSZ8YViZpPraZN7JXGmNmMM
 yvtfpAizU5qBmE8CvqkA/IJDodahmMJ/Fy/kDm3znJ62zH/dTwzz+PQDsSbdy5InQHhk
 0zG5G0GsaUEHOzwZP7iuUwNY2ChLgCUPI3l8Y7x20nL0ze9USYrxwz/Ts+vpbXhXd3SE
 bucUKRk1lDJSXGls5/8hfe8orhfwXJG9eiStUkK/qOKTWgaes0l/RKRLZfVqidSpPjoR
 F3EQ==
X-Gm-Message-State: AOAM532wQIcZAueDL5JK1ngdv4QH2DNObYbakxhakBTHmmxuc/3ZkTDa
 ZG9prmEBi8m7sgFm+PM63ywFobkOhFBwRSVKTzAENL3e+QX4vOgVeWB5VfLwWumHPLeRMic4Xs8
 Ii9K+54w0EppTtXw=
X-Received: by 2002:adf:fdc7:: with SMTP id i7mr5113129wrs.198.1604604003778; 
 Thu, 05 Nov 2020 11:20:03 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx6AqeaQNElqhuMF+A5YAtRgxx2ExbJf92kxIDaCjH5t2qx4qZclDeMeBM1iCvyk2Wtwmx0Pg==
X-Received: by 2002:adf:fdc7:: with SMTP id i7mr5113102wrs.198.1604604003606; 
 Thu, 05 Nov 2020 11:20:03 -0800 (PST)
Received: from [192.168.1.36] (234.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.234])
 by smtp.gmail.com with ESMTPSA id z2sm3604747wmf.45.2020.11.05.11.20.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Nov 2020 11:20:02 -0800 (PST)
Subject: Re: [RFC PATCH 12/15] stubs/xen-hw-stub: drop
 xenstore_store_pv_console_info stub
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20201105175153.30489-1-alex.bennee@linaro.org>
 <20201105175153.30489-13-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <11afa6f8-ec49-ab2b-2011-ef22665cd0c3@redhat.com>
Date: Thu, 5 Nov 2020 20:20:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201105175153.30489-13-alex.bennee@linaro.org>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/04 22:46:30
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
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
Cc: Stefano Stabellini <sstabellini@kernel.org>, julien@xen.org,
 masami.hiramatsu@linaro.org, Paul Durrant <paul@xen.org>,
 andre.przywara@arm.com, stefano.stabellini@linaro.org,
 takahiro.akashi@linaro.org, Paolo Bonzini <pbonzini@redhat.com>,
 Anthony Perard <anthony.perard@citrix.com>,
 "open list:X86 Xen CPUs" <xen-devel@lists.xenproject.org>,
 stefano.stabellini@xilinx.com, stratos-dev@op-lists.linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/5/20 6:51 PM, Alex Bennée wrote:
> We should never build something that calls this without having it.

"because ..."?

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>  stubs/xen-hw-stub.c | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/stubs/xen-hw-stub.c b/stubs/xen-hw-stub.c
> index 2ea8190921..15f3921a76 100644
> --- a/stubs/xen-hw-stub.c
> +++ b/stubs/xen-hw-stub.c
> @@ -10,10 +10,6 @@
>  #include "hw/xen/xen.h"
>  #include "hw/xen/xen-x86.h"
>  
> -void xenstore_store_pv_console_info(int i, Chardev *chr)
> -{
> -}
> -
>  int xen_pci_slot_get_pirq(PCIDevice *pci_dev, int irq_num)
>  {
>      return -1;
> 


