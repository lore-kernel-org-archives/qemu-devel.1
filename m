Return-Path: <SRS0=CoOB=7C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D2E8C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 16:42:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 167242065F
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 16:42:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O9NrYeqe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 167242065F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47964 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbRnL-0007Yj-8E
	for qemu-devel@archiver.kernel.org; Wed, 20 May 2020 12:42:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48534)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jbRmB-0005rB-Q5
 for qemu-devel@nongnu.org; Wed, 20 May 2020 12:41:03 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:39544
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jbRmA-0003ok-TN
 for qemu-devel@nongnu.org; Wed, 20 May 2020 12:41:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589992862;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mRer0sE3L0jRUSIwVXZzo2zE4/1b8ierFGMCqXybenc=;
 b=O9NrYeqelf/6gIhIUvT/pAOm6WeeoxL4F48O8JSkMJJGSO4rNhI8qk9+jpkinmXFdp4kL1
 kfAwGX5ArEaXBAaeMHZjoyWdwso5v079IdxcVNaKMapU+W3oM5wpwTyfunU/hFTdRdp4di
 9fKDn1FCGJvVYPbJHFQg0IEoL6kmjN0=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-335-99IigDYENqyx1Xxi94HkrQ-1; Wed, 20 May 2020 12:40:45 -0400
X-MC-Unique: 99IigDYENqyx1Xxi94HkrQ-1
Received: by mail-ed1-f72.google.com with SMTP id c10so1476997edw.17
 for <qemu-devel@nongnu.org>; Wed, 20 May 2020 09:40:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=mRer0sE3L0jRUSIwVXZzo2zE4/1b8ierFGMCqXybenc=;
 b=ZH4NMjzjAjWdK4Zy/zfBZCiQhwuS6dFUHazJUOwqr/w7fLPgSgN3IDu3N1/ewg2LzG
 HcgATuB2Yk6uiPSyQIGX2xgUxluJ9YVqamaoPOg1wV1IujT9+9aG4GAxIF3S042ttz5U
 RP40/J5GlgzUdr2LtbpsJc9nDl+oLtnn1wM2Cp1z8ATdLYQH0ZXrLLGhRwPGM4mEPh2Y
 JBvB+9UqbbCo/shrP3sKMIyKezFXse+9h81oPdhpyTpR6zKbY9GyAkv2hsW7hcpfwqUX
 UY9Y7+lJsyFLqVVuQ1u81t22f46rVUgqDzLJY8paYV6Be4nsZNGX/TlGXjUSUR1fMMOw
 BmCA==
X-Gm-Message-State: AOAM5320e3M5rP11U/iN3JfJNlOEk6K33DOEhbqoXlW0/wk9iI2HkGfo
 6Uul1QeDdAWbC/ONrbJXvAqjdFjg7C1cKfD67ONqGEA9E1zVy7CZY/c+xI5sIRV6jXSrz8HZnX1
 CSjLge+Q0q8KBBkI=
X-Received: by 2002:a17:906:a417:: with SMTP id
 l23mr4339552ejz.213.1589992842702; 
 Wed, 20 May 2020 09:40:42 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzEfz6kG8cMxtKKwYb5vx1I5NhFUtNrCRnINJqmYxKcFDxdXuDyNDdYANAgKtRo15OfAAiZxA==
X-Received: by 2002:a17:906:a417:: with SMTP id
 l23mr4339539ejz.213.1589992842475; 
 Wed, 20 May 2020 09:40:42 -0700 (PDT)
Received: from [192.168.1.38] (17.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.17])
 by smtp.gmail.com with ESMTPSA id x5sm2242351eds.8.2020.05.20.09.40.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 20 May 2020 09:40:41 -0700 (PDT)
Subject: Re: [PATCH 1/2] sd: check bit number before setting card_status flag
To: P J P <ppandit@redhat.com>
References: <20200520152450.200362-1-ppandit@redhat.com>
 <20200520152450.200362-2-ppandit@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <1da5a868-5ad4-28ee-143e-46b3f2e8da6d@redhat.com>
Date: Wed, 20 May 2020 18:40:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200520152450.200362-2-ppandit@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/20 04:09:34
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
Cc: Alexander Bulekov <alxndr@bu.edu>, QEMU Developers <qemu-devel@nongnu.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, Prasad J Pandit <pjp@fedoraproject.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Prasad,

On 5/20/20 5:24 PM, P J P wrote:
> From: Prasad J Pandit <pjp@fedoraproject.org>
> 
> SD card emulator sets 'sd->card_status' while performing block
> write commands. While doing so, it tests the corresponding bit
> derived from 's->data_start' address. This may lead to OOB access.
> Add check to avoid it.

Ah, this is different that the one reported recently:
https://bugs.launchpad.net/qemu/+bug/1878054

Do you have a reproducer?

Is this a CVE?

> 
> Reported-by: Alex <alxndr@bu.edu>

This is not Alexander complete name.

> Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>
> ---
>   hw/sd/sd.c | 7 ++++++-
>   1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/sd/sd.c b/hw/sd/sd.c
> index 71a9af09ab..916e9fff58 100644
> --- a/hw/sd/sd.c
> +++ b/hw/sd/sd.c
> @@ -802,7 +802,12 @@ static void sd_function_switch(SDState *sd, uint32_t arg)
>   
>   static inline bool sd_wp_addr(SDState *sd, uint64_t addr)
>   {
> -    return test_bit(sd_addr_to_wpnum(addr), sd->wp_groups);
> +    uint64_t bit = sd_addr_to_wpnum(addr);
> +
> +    if (bit < sd->wpgrps_size) {

This should never be called with a such address, so I'd simply use an 
assertion here.

The problem is earlier where the address should be validated and a 
protocol error returned.

> +        return test_bit(bit, sd->wp_groups);
> +    }
> +    return true;
>   }
>   
>   static void sd_lock_command(SDState *sd)
> 


