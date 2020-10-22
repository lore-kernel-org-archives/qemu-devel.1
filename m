Return-Path: <SRS0=9x1+=D5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAD3AC388F7
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2020 14:25:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 168B424171
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2020 14:25:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y/QUqJ3Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 168B424171
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56270 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVbWY-0003I2-Uw
	for qemu-devel@archiver.kernel.org; Thu, 22 Oct 2020 10:25:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47260)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kVbSG-000667-SW
 for qemu-devel@nongnu.org; Thu, 22 Oct 2020 10:20:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:38624)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kVbSF-0002Q3-0z
 for qemu-devel@nongnu.org; Thu, 22 Oct 2020 10:20:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603376434;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2TWaegd2S7RBLRDF0Ip4AR0g6uaYiOMGs1Uzg9tJfec=;
 b=Y/QUqJ3ZhxKZlntK6pM6Qow/u8AdGiqnanu6jhXWrkZ1BzbOBVuxxduHxM6JeNxQUDIvRn
 97sNmazlAcDoCmbG710A3eeqnxyVelqiZ0SY+rvcYubn6/o4pxJT5lQzxvlCY7jtCDZKV/
 1kEqYovQS1+0a3impLVNyeTpVL1Gw+I=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-318-FFph0V3mO8mdPg-kPf9eig-1; Thu, 22 Oct 2020 10:20:31 -0400
X-MC-Unique: FFph0V3mO8mdPg-kPf9eig-1
Received: by mail-wm1-f70.google.com with SMTP id r19so641011wmh.9
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2020 07:20:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=2TWaegd2S7RBLRDF0Ip4AR0g6uaYiOMGs1Uzg9tJfec=;
 b=nxLlDp0r+eGmBV51MN2MDaz76DqLXcaan+f7z3US5ah+/MgKvTR48761rTZmTBOWea
 quPRFKBrsGvnLuGSRM4Ds4zjtQkVd7cFSU4jZ90iKvvsVzItLfy0nyukHEBI/duf5spq
 W4f/HNRBi/9hmBYZhbdCdL1kXwrWLkxG5ZTJZ0tepeRaOpFvETq9msxv5agdJUE5Y9+/
 n/rhuuKnK3jh0/kSlwZkeXrl5+vnKPQgG9zqrNITjlb4cJ7qc3AFw+jsxRE550rS4MF5
 s/25Ijr092JtyYZLPf603a61n/izVgKuARnaxy+WFEeFvgUWBT9fqlthYRcnzPrf+gg0
 ruxA==
X-Gm-Message-State: AOAM530H63Ohr7EGrWAQyDYBoLo2ppbRkRWBgBosRGgBt4zmf5rqrl6y
 ME00UBsVds9SjxnlhJ3qDrKKC0WTB1x4XjX4RB6b5499CDCpN8LVM3umtUpfmPamOMb4d7pBfog
 VBT8qVkBrgKTxdHI=
X-Received: by 2002:a1c:5545:: with SMTP id j66mr2901458wmb.31.1603376430090; 
 Thu, 22 Oct 2020 07:20:30 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxmHePokSeOQBoNLL1nZJrY+OBOrH7XZ40IuNWZ5uYmuNfLg+/CelWbLm4ox+uodeiQBFp1vg==
X-Received: by 2002:a1c:5545:: with SMTP id j66mr2901423wmb.31.1603376429840; 
 Thu, 22 Oct 2020 07:20:29 -0700 (PDT)
Received: from [192.168.1.36] (237.red-88-18-140.staticip.rima-tde.net.
 [88.18.140.237])
 by smtp.gmail.com with ESMTPSA id f8sm4321641wrw.85.2020.10.22.07.20.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 22 Oct 2020 07:20:28 -0700 (PDT)
Subject: Re: [PATCH] MAINTAINERS: Cover "block/nvme.h" file
To: qemu-devel@nongnu.org, QEMU Trivial <qemu-trivial@nongnu.org>
References: <20200701140634.25994-1-philmd@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <ccdce593-67fc-1ed5-c05c-c64d45cf5515@redhat.com>
Date: Thu, 22 Oct 2020 16:20:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20200701140634.25994-1-philmd@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/22 08:09:01
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.107, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org, Niklas Cassel <Niklas.Cassel@wdc.com>,
 Dmitry Fomichev <Dmitry.Fomichev@wdc.com>, Klaus Jensen <k.jensen@samsung.com>,
 Max Reitz <mreitz@redhat.com>, Klaus Jensen <its@irrelevant.dk>,
 Andrzej Jakowski <andrzej.jakowski@linux.intel.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Keith Busch <kbusch@kernel.org>,
 Maxim Levitsky <mlevitsk@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Cc'ing qemu-trivial@

On 7/1/20 4:06 PM, Philippe Mathieu-Daudé wrote:
> The "block/nvme.h" header is shared by both the NVMe block
> driver and the NVMe emulated device. Add the 'F:' entry on
> both sections, so all maintainers/reviewers are notified
> when it is changed.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> ---
> Cc: Fam Zheng <fam@euphon.net>
> Cc: Keith Busch <kbusch@kernel.org>
> Cc: Kevin Wolf <kwolf@redhat.com>
> Cc: Max Reitz <mreitz@redhat.com>
> Cc: Niklas Cassel <Niklas.Cassel@wdc.com>
> Cc: Klaus Jensen <its@irrelevant.dk>
> Cc: Klaus Jensen <k.jensen@samsung.com>
> Cc: Maxim Levitsky <mlevitsk@redhat.com>
> Cc: Dmitry Fomichev <Dmitry.Fomichev@wdc.com>
> Cc: Andrzej Jakowski <andrzej.jakowski@linux.intel.com>
> ---
>   MAINTAINERS | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index dec252f38b..9995cdc805 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1795,6 +1795,7 @@ M: Keith Busch <kbusch@kernel.org>
>   L: qemu-block@nongnu.org
>   S: Supported
>   F: hw/block/nvme*
> +F: include/block/nvme.h
>   F: tests/qtest/nvme-test.c
>   
>   megasas
> @@ -2804,6 +2805,7 @@ M: Fam Zheng <fam@euphon.net>
>   L: qemu-block@nongnu.org
>   S: Supported
>   F: block/nvme*
> +F: include/block/nvme.h
>   
>   Bootdevice
>   M: Gonglei <arei.gonglei@huawei.com>
> 


