Return-Path: <SRS0=xfvu=ZV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19E89C432C3
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2019 11:37:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D6051208E4
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2019 11:37:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AZEGhcVV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6051208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57540 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iaeaK-0001oc-5o
	for qemu-devel@archiver.kernel.org; Fri, 29 Nov 2019 06:37:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39742)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1iaeLi-0000NG-Oe
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 06:22:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1iaeLf-0001vw-67
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 06:22:09 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:52084
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1iaeLc-0001mY-Pz
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 06:22:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575026521;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EqDsADfm3pPrGTWw3Pms9NNuRE1y9pUmzpW5YJGWdco=;
 b=AZEGhcVVMpsfaT4KQngHmDeo0sds73yVSqY5C5a1dgfr/Sxmv3fAL9nqmuSg+3JgIV6jmI
 m7n6HPFsSMHDSR/u5xVxa/aPMsgLMmm5tgrP1k5xQkq9NBh7aOt+XZphb5haMxsiEoqzha
 f+rf9t9l8kPCHc5wvbkjpW/ZxgBRX2g=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-275-aNVBdZIiMBuhR3rOcfbmFA-1; Fri, 29 Nov 2019 06:21:57 -0500
Received: by mail-wr1-f71.google.com with SMTP id w6so3678332wrm.16
 for <qemu-devel@nongnu.org>; Fri, 29 Nov 2019 03:21:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=EqDsADfm3pPrGTWw3Pms9NNuRE1y9pUmzpW5YJGWdco=;
 b=VaSclDK5HpEaOLnD69tC7BEZj0prjM+difOe+7hOAeTyEDyg+I/MXa0EZC94Suk18T
 znmEEoRb9INbZNg4NuyqaGBLDjWKAVk7HfV2dmqlU4Sw/J0Vmr429d88AnU4dyH81MI0
 FiC16RSvQbbNLLDpUxX/Aqs9AWLtmCJOais1wgY3Qt41+z6SoLUiUdR3ZbkRAQLhkt+f
 8PcIhSWwV7dTmJy/BQoFxtRjNR6NiB7XO/UpuHbZQ6SkBzqznGth6TBVGTQ1z1Ese47y
 i2GsD6VXB72QY4vPVkn5R1UxtlNYxk+fWT28wLa+j05QrO/m+cCWCnJzYUKUQNSAHh6p
 V5rA==
X-Gm-Message-State: APjAAAUy2e5LqU+d/aQG+ES9Ple9rizfQWdgeT4Bz09L6g1Dc+y1dSI6
 2EFcITuji6+I2Js4+AyxEF5yroWXWznBNHU15xtTexQGvFljF2WQuK+A8jYGV+9wtufaKCutAyR
 aIP10VSaX1VCut5E=
X-Received: by 2002:a05:6000:cf:: with SMTP id
 q15mr13010821wrx.393.1575026516337; 
 Fri, 29 Nov 2019 03:21:56 -0800 (PST)
X-Google-Smtp-Source: APXvYqxw4u/ShBJc7RODxFgTKpr+vN3TCVdMB6D90hOnFGJhhg0YnBOGtuFz+e8pEzLqIt6VO0moDg==
X-Received: by 2002:a05:6000:cf:: with SMTP id
 q15mr13010797wrx.393.1575026516062; 
 Fri, 29 Nov 2019 03:21:56 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:459f:99a9:39f1:65ba?
 ([2001:b07:6468:f312:459f:99a9:39f1:65ba])
 by smtp.gmail.com with ESMTPSA id e18sm5553433wrr.95.2019.11.29.03.21.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 29 Nov 2019 03:21:55 -0800 (PST)
Subject: Re: [PATCH 0/2] RFC: add -mem-shared option
To: Igor Mammedov <imammedo@redhat.com>
References: <20191128141518.628245-1-marcandre.lureau@redhat.com>
 <20191128161021.GA14595@habkost.net>
 <fb122bbe-3fc4-e3cd-899a-c3538237203a@redhat.com>
 <20191129112329.336582b7@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <9a6ff03b-6a94-d476-c5c3-f531ecccdb09@redhat.com>
Date: Fri, 29 Nov 2019 12:21:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191129112329.336582b7@redhat.com>
Content-Language: en-US
X-MC-Unique: aNVBdZIiMBuhR3rOcfbmFA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>,
 stefanha@redhat.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 29/11/19 11:23, Igor Mammedov wrote:
> [...]
>> Therefore, I think instead of -mem-shared we should add a "-m
>> memdev=..." option.  This option:
>>
>> * would be mutually exclusive with both -mem-path
>>
>> * would be handled from allocate_system_memory_nonnuma.
>>
>> * could be mutually exclusive "-numa node", or could just be mutually
>> exclusive with "-numa node,memdev=..." (the logical conclusion of that
>> however would be an undeprecation of "-numa node,mem=...", so that has
>> to be taken into account as well).
> the plan was/still is to have memdev for main ram and deprecate
> "-numa node,mem=..." for new machine types (can't be done for
> old ones due to migration breakages and old libvirt which uses
> it). So new machines will be forced to use "-numa memdev"
> For old machines '-m memdev' provided memory region will used to
> keep "-numa node,mem=..." working as it's now (however broken it is).

Ok, then "-m memdev=..." would only be mutually exclusive with
"-mem-path" and "-numa node,memdev=...".

Thanks!

Paolo


