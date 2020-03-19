Return-Path: <SRS0=/hVT=5E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29692C4332B
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2020 10:00:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E8DBE2070A
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2020 10:00:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NJLHMjJT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8DBE2070A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35610 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEryV-0006yi-Vg
	for qemu-devel@archiver.kernel.org; Thu, 19 Mar 2020 06:00:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50203)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1jErxO-0006DC-EF
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 05:59:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1jErxN-0005ss-E8
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 05:59:18 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:58660)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1jErxN-0005rk-9s
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 05:59:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584611957;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hg6xiXsyt2G5qWjLQhubwzMIa1N9Eg9U0DhDi0LP56Y=;
 b=NJLHMjJT/ncXY47pvP2oEpUU8ZPT9qQkyIodYIF1OATZ6dqDnTEMHt1MfURPy/4XF2Hlid
 RYvpF/51lHcQxhHLysuTXZH7rWLOe6MO3Y7J4ibWjTwwbcUablk4Dn7j8XYl0bOHmUAM0O
 WTbDefR6XRBfp0Dl0MkGHVvI/P2cBho=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-301-dWEfYzwFOLmsRybQdazDjw-1; Thu, 19 Mar 2020 05:59:15 -0400
X-MC-Unique: dWEfYzwFOLmsRybQdazDjw-1
Received: by mail-wr1-f71.google.com with SMTP id f13so731480wro.23
 for <qemu-devel@nongnu.org>; Thu, 19 Mar 2020 02:59:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=hg6xiXsyt2G5qWjLQhubwzMIa1N9Eg9U0DhDi0LP56Y=;
 b=ckiqgHioWXn24j8sD1stCPo1yvQpwdJ9Lpx5XmqdiyKehXt3L69e5dDExgEULNzFnH
 HcprVBgle+8Y1L6QrKjzAeNQ1ai5Ho2gw5EZGjNmAv6A/efawVh8ubqWibTKdJfc6q/W
 56xFeK6XQp7SDc8v5aenm8zu9YiqUxUwoh0vpgv2ca8e656xl99EvrUwpOak8M9gImut
 OXe7mz2kwz/gniJt3A9ckFvegKdmxt0q858GFk2RPOL7tHOGidolHRTTkLlADwNNjcnI
 p2VpScaNOnxHHQKgH+/IfL+nPG54FcX5Ms7vAZrlFPcuJNJz8gXE5v6MwIztsXaFhi5f
 lT2w==
X-Gm-Message-State: ANhLgQ2e98hVJIJfjQ8iqgxqv6Eny0mwU268BftpMeZCHG2zyfmCy2pl
 Ij3Q5tmctod8SmF9xWr4epDN5nBbplYFnzPA6srfY1uAbghMlGmXWua1igW2YbssTP4TwBejQ2z
 KZDSFvh3obo4wpuI=
X-Received: by 2002:adf:8341:: with SMTP id 59mr3166499wrd.314.1584611954533; 
 Thu, 19 Mar 2020 02:59:14 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vsIPCU4CBTFF9g0gao1YT5KDT1sJSMSxIUqU0GrU+H9qPXRr/jLvDKpJuMATeFZHCMkEI3fJQ==
X-Received: by 2002:adf:8341:: with SMTP id 59mr3166468wrd.314.1584611954298; 
 Thu, 19 Mar 2020 02:59:14 -0700 (PDT)
Received: from [192.168.178.58] ([151.21.15.43])
 by smtp.gmail.com with ESMTPSA id c4sm2437472wml.7.2020.03.19.02.59.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 Mar 2020 02:59:13 -0700 (PDT)
Subject: Re: [PATCH 00/13] microvm: add acpi support
To: Gerd Hoffmann <kraxel@redhat.com>
References: <20200319080117.7725-1-kraxel@redhat.com>
 <2ed586e7-d7a1-77b2-ecc6-01b6fb38d72e@redhat.com>
 <20200319093342.m6fppq4y2qoqefpa@sirius.home.kraxel.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <c93e28a0-80ec-a986-cb8f-426b84947844@redhat.com>
Date: Thu, 19 Mar 2020 10:59:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200319093342.m6fppq4y2qoqefpa@sirius.home.kraxel.org>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 216.205.24.74
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, Sergio Lopez <slp@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
 Igor Mammedov <imammedo@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 19/03/20 10:33, Gerd Hoffmann wrote:
> On Thu, Mar 19, 2020 at 09:49:55AM +0100, Paolo Bonzini wrote:
>> On 19/03/20 09:01, Gerd Hoffmann wrote:
>>> I know that not supporting ACPI in microvm is intentional.  If you still
>>> don't want ACPI this is perfectly fine, you can use the usual -no-acpi
>>> switch to toggle ACPI support.
>>
>> Could we change -no-acpi into a "-machine acpi=..." property?  Then it
>> can have type OnOffAuto and we can decide whether to enable it by
>> default or not for microvm.
> 
> For all machine types not just microvm I guess?

Yes, please.  Strange that no one has noticed it for all this time!

The main reason for not having ACPI was the time that it took to start;
this is also why I preferred having device tree, but indeed that would
mean no distro kernels (we could probably use U-Boot as the firmware,
but still with a custom kernel).

Paolo

>> Also, can you confirm that it builds without CONFIG_I440FX and
>> CONFIG_Q35?  You probably need to add "imply ACPI" and possibly some
>> '#include "config-devices.h"' and '#ifdef CONFIG_ACPI' here and there.
> 
> Didn't try that yet, will do.
> 
> cheers,
>   Gerd
> 


