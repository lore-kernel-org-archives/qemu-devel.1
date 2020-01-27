Return-Path: <SRS0=8p31=3Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB39AC32771
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2020 07:48:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 773F621569
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2020 07:48:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CIM4MjMn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 773F621569
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41241 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ivz8U-0005lU-N9
	for qemu-devel@archiver.kernel.org; Mon, 27 Jan 2020 02:48:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43247)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1ivz7j-0005I9-J5
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 02:47:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1ivz7h-0006WF-H4
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 02:47:54 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:37478
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1ivz7h-0006Ur-A6
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 02:47:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580111271;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GPO+7YdiV6OGCaXdiXg55FP50iM8kTEhgaEqlc4bbKU=;
 b=CIM4MjMnlb7A7Ak6/nyoNXgj708repL1QLtBIUy0LE56pp6hO9c4DKflthA1hb9V/I+kWt
 N2N2iUG1QbG+CRpZ5OBjlEEDziq97iKyRIyEYCL+uoHK1xS3bwM6IM+Vk+6aTaHu86BN5q
 UHXVoUHRC+XJPmodCWz6/2hs0Ojvydk=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-28-is7SkT0oMZmc3sc5n-AWEw-1; Mon, 27 Jan 2020 02:47:48 -0500
Received: by mail-wr1-f71.google.com with SMTP id i9so5698980wru.1
 for <qemu-devel@nongnu.org>; Sun, 26 Jan 2020 23:47:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=GPO+7YdiV6OGCaXdiXg55FP50iM8kTEhgaEqlc4bbKU=;
 b=Tl+FEPsqhnxAt0dePJRUWq0QvAbsbwIrWacUrvSz8RdeqFk/rrWfud4nTkaK0cEKih
 91wQUl0g0tlKycRQwJdCtYFn2Udrhhco7G4c0Yn58lpAlLhHsoKVaaF7BATfwwOIwhqB
 oglHIhujgjVMuNiIZfknG8/HjaZkvbLAZU0uOkxcgcQLrEQGLt6jITJB4qnU0rUEhLwG
 NV8R88YIrhmh87tjs4UFDG9qTiy3+zPMdLcAZSqkZgqs26YmplHXKzSq/yR8ncGx2Cfx
 vxV0OyzwafzFZnz4kOTt5EaVFhEANSaBIfN0dA5YNCQ7zgHRKCw2Hkp1YN147X748a3J
 +G1A==
X-Gm-Message-State: APjAAAXoCzmEm5bf4v3k858As2l/5sbOabPCHBzt/zDC5tC/I0dCkzva
 u1GYBAd9KMdKrDJ+kGC53Pat0mDhf3RNYeNzTREbNRLGvtG9umNVWpdkAcl/VmiakJEi0yWfl/8
 z4rgUiNs91VypKBs=
X-Received: by 2002:a1c:9c87:: with SMTP id f129mr12868541wme.26.1580111267343; 
 Sun, 26 Jan 2020 23:47:47 -0800 (PST)
X-Google-Smtp-Source: APXvYqy42mm0UrkfB/0xG4tKqWJnUvDiYLrpTNBCkWVwf9hagzaNtqEr2zWgqnLeYaNV47Fohi1osw==
X-Received: by 2002:a1c:9c87:: with SMTP id f129mr12868517wme.26.1580111267041; 
 Sun, 26 Jan 2020 23:47:47 -0800 (PST)
Received: from [192.168.1.35] (113.red-83-57-172.dynamicip.rima-tde.net.
 [83.57.172.113])
 by smtp.gmail.com with ESMTPSA id t12sm18876729wrs.96.2020.01.26.23.47.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 26 Jan 2020 23:47:46 -0800 (PST)
Subject: Re: Booting Debian in qemu-system-alpha
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 Richard Henderson <richard.henderson@linaro.org>
References: <b71832b2-8b2e-a49b-1bf9-6590056bbdbe@physik.fu-berlin.de>
 <f3843562-cd89-d1b1-19ed-6ae505a94148@linaro.org>
 <22dd1024-6dd1-81b1-1a91-8d2cbf31853c@physik.fu-berlin.de>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <775a62cd-8041-de5e-97c9-b1def80b3f58@redhat.com>
Date: Mon, 27 Jan 2020 08:47:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <22dd1024-6dd1-81b1-1a91-8d2cbf31853c@physik.fu-berlin.de>
Content-Language: en-US
X-MC-Unique: is7SkT0oMZmc3sc5n-AWEw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: debian-alpha@lists.debian.org, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/24/20 9:52 PM, John Paul Adrian Glaubitz wrote:
> On 1/24/20 9:19 PM, Richard Henderson wrote:
>> Oh.  Hah!  I just tried again, cutting and pasting your command-line.  You've
>> got unicode quotes, not ascii ' (\x27).  That gets passed through to the kernel
>> as-is and prevents console=ttyS0 from being parsed properly.
> 
> Good catch. That helped. Thanks.
> 
> I'm considering setting up two qemu-based buildds for alpha in the cloud now.

Nice!

Looking at cloud provider default plans, and problems with buildd on 
other archs (mipsel in particular) I recommend you to use at least 2GB 
instead of 512MB.


