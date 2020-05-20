Return-Path: <SRS0=CoOB=7C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8898C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 13:02:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A78CD207D3
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 13:02:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UdnTY1Ed"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A78CD207D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54858 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbOMR-0003Se-Pv
	for qemu-devel@archiver.kernel.org; Wed, 20 May 2020 09:02:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44044)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jbOKi-0001z3-Ie
 for qemu-devel@nongnu.org; Wed, 20 May 2020 09:00:28 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:38169
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jbOKh-0004kC-3i
 for qemu-devel@nongnu.org; Wed, 20 May 2020 09:00:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589979625;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vtwLpCcTit2OVWp8a2YL7RdmjJMudH8Vw35TudanvYM=;
 b=UdnTY1Edu55xq7KIvx6PesqFWtZsaWKtppV9cieLvmB+E7+31upjOMULbn7kFjcyf6TkYN
 bJzV0yrLmyUTR5kROPcJVDPM5KgcW874b1QGoss+T0lGUek+tf85o+UI/Ib65Gqmbod7Du
 6WtUOk8x058a7kOl+6UASsc2h4XtoX0=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-421-xPxsDtY3PRiceYgXeHCIhA-1; Wed, 20 May 2020 09:00:23 -0400
X-MC-Unique: xPxsDtY3PRiceYgXeHCIhA-1
Received: by mail-wr1-f70.google.com with SMTP id l12so1382383wrw.9
 for <qemu-devel@nongnu.org>; Wed, 20 May 2020 06:00:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=vtwLpCcTit2OVWp8a2YL7RdmjJMudH8Vw35TudanvYM=;
 b=mo8Q2+SFPpKdnMo5cneGQKzUa5CmXfE+cEIKGVnzilYDurDj1pKg9ZZHVwqWDVzwVl
 3RKmn7r45LX1x6f/2gbUOwg+hhGZICs0H6PcN32HuqYiRzFxlUfi1G6U2A/WcylnWFBy
 wX/Zf4oPrKyIc0Y3xz1s2MAUaS9sLcmjRSKOskZxSmlskAFRGL5vk2hY5SsVx9jDeBHY
 rbn6h+8IeuEBMLtODNwUK0olGj8Yty40t1LXIqZzkNWV0c/akAYHrqB+8rJvVK7Zg+Qt
 n4Y2wTZAL1sf7lY9ZlWkiryWuEQE02qkjpE2sa2q58utdVAzrjcuIX+V98G1npC/hZFx
 2fzw==
X-Gm-Message-State: AOAM5308NWi28FU5gucrYYRVURQmCsp8U5Y+qdTFcho2BV0yBJQWAfvT
 b1F6K916NuPbfY1uQsgkRjHCZPOaOCmeejHeaUNUpUjg/tSthoKdxd3JSQ7TYdxqBxtkS6R5+ss
 CRRZM6y5o8maJUsE=
X-Received: by 2002:adf:fdc1:: with SMTP id i1mr427299wrs.0.1589979622450;
 Wed, 20 May 2020 06:00:22 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxnCq355+z+Oz9c/gOb5+5MlQ9JUxVessq1Rh7cNA3NtprMxMbg2gM3QyYAFpW8QTa8yHSHNw==
X-Received: by 2002:adf:fdc1:: with SMTP id i1mr427275wrs.0.1589979622227;
 Wed, 20 May 2020 06:00:22 -0700 (PDT)
Received: from [192.168.1.38] (17.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.17])
 by smtp.gmail.com with ESMTPSA id h133sm3142083wmf.25.2020.05.20.06.00.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 20 May 2020 06:00:21 -0700 (PDT)
Subject: Re: [PATCH v2 03/19] accel/kvm: Convert to ram_block_discard_disable()
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
References: <20200520123152.60527-1-david@redhat.com>
 <20200520123152.60527-4-david@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <2b6f0c1a-a2fd-0ecb-846e-848948266f8a@redhat.com>
Date: Wed, 20 May 2020 15:00:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200520123152.60527-4-david@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/20 01:34:51
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, kvm@vger.kernel.org,
 "Michael S . Tsirkin" <mst@redhat.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>, qemu-s390x@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi David,

On 5/20/20 2:31 PM, David Hildenbrand wrote:
> Discarding memory does not work as expected. At the time this is called,
> we cannot have anyone active that relies on discards to work properly.
> 
> Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>   accel/kvm/kvm-all.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
> index d06cc04079..7a6158fb99 100644
> --- a/accel/kvm/kvm-all.c
> +++ b/accel/kvm/kvm-all.c
> @@ -40,7 +40,6 @@
>   #include "trace.h"
>   #include "hw/irq.h"
>   #include "sysemu/sev.h"
> -#include "sysemu/balloon.h"
>   #include "qapi/visitor.h"
>   #include "qapi/qapi-types-common.h"
>   #include "qapi/qapi-visit-common.h"
> @@ -2143,7 +2142,7 @@ static int kvm_init(MachineState *ms)
>   
>       s->sync_mmu = !!kvm_vm_check_extension(kvm_state, KVM_CAP_SYNC_MMU);
>       if (!s->sync_mmu) {
> -        qemu_balloon_inhibit(true);
> +        g_assert(ram_block_discard_disable(true));

Please do not evaluate code within an assert() call.

See the comment added to "qemu/osdep.h" in commit 262a69f4282:

/*
  * We have a lot of unaudited code that may fail in strange ways, or
  * even be a security risk during migration, if you disable assertions
  * at compile-time.  You may comment out these safety checks if you
  * absolutely want to disable assertion overhead, but it is not
  * supported upstream so the risk is all yours.  Meanwhile, please
  * submit patches to remove any side-effects inside an assertion, or
  * fixing error handling that should use Error instead of assert.
  */

>       }
>   
>       return 0;
> 


