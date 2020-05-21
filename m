Return-Path: <SRS0=QiA4=7D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 500D3C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 16:07:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E888120671
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 16:07:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X9m5KdB3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E888120671
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50648 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbnjK-0005FY-3t
	for qemu-devel@archiver.kernel.org; Thu, 21 May 2020 12:07:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44984)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jbng2-0007Oa-6O
 for qemu-devel@nongnu.org; Thu, 21 May 2020 12:04:10 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:53875
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jbng0-00059c-Vl
 for qemu-devel@nongnu.org; Thu, 21 May 2020 12:04:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590077047;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7fRAdvpkYL/K+UuvpLRHl1HwIWlR1Wrct49Rx7269Lk=;
 b=X9m5KdB396bTqFtEIVvqFZp3s7i407kyhWFai5OHmnrM6lWkDuIFgEx6JONAeqX67AgCfi
 I2qxzTCArv0fhy+YkN6f5BKjUwvK7aiEKlNnWXLaR69d8X7WWTD/1AAeokrbLpMNTG2V1n
 hv3FuMFgU0GhvVlUzfSli1rRmAKRcQM=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-269-Ruaalo6TMsKa5MV-b4J-rw-1; Thu, 21 May 2020 12:04:03 -0400
X-MC-Unique: Ruaalo6TMsKa5MV-b4J-rw-1
Received: by mail-wr1-f69.google.com with SMTP id q13so3114130wrn.14
 for <qemu-devel@nongnu.org>; Thu, 21 May 2020 09:04:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=7fRAdvpkYL/K+UuvpLRHl1HwIWlR1Wrct49Rx7269Lk=;
 b=BvObw2pXrd42MTXPYKtVTuNyXqmsuiVpT4tDYTT2UJ+PlX8Ci3JnWjDFztjWs2ReeX
 jHf/B2wKCyK6HSQZsERO3wu38ov055XwqC7x+QYgfOLOTxZ0B8a5z7fuXExz2uCk7wzC
 5JxYTw+GIL2FZ6Ixhf9bI9cYxKOiFzca+3wUnPVkXdDGCkd9Er3yf3qkaIUPrcOWQTLS
 gnxPFlv1xM3i2Lbhae7gq5DoF6yx51387b4vrbwDSyGgb+5qdZJFRt0pRnkE7GUnoN/q
 3uZW7HvRCRjrYCDAUmkdQpjwql5RGGjdoH6832TGvWi6qQZnHM/rwOJHkXK73cSxERsM
 BGAA==
X-Gm-Message-State: AOAM533HG57q7nCnrG6Z1GoO9I3Dd0hH1WoBVewDthDFS+lR59ZKZenu
 EhGxghLHiR+EGZagIEHypCSdYe4U46M7CjhdvQxd6CFhTJBpeFkudXP2abgG1EeN6n/vxUz2e8n
 Tc2rckEkogkKgu34=
X-Received: by 2002:a5d:56c6:: with SMTP id m6mr8923106wrw.78.1590077041757;
 Thu, 21 May 2020 09:04:01 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzgDEVyyPmcERRdSorm38P8EqKwd80xHUE60/BqJSalnzIzx9gUqQhpRk3T/Mzim0Itwsw3KA==
X-Received: by 2002:a5d:56c6:: with SMTP id m6mr8923089wrw.78.1590077041505;
 Thu, 21 May 2020 09:04:01 -0700 (PDT)
Received: from [192.168.178.58] ([151.21.160.154])
 by smtp.gmail.com with ESMTPSA id 89sm7083605wrj.37.2020.05.21.09.04.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 21 May 2020 09:04:01 -0700 (PDT)
Subject: Re: [v2 PATCH] target/i386: Fix the CPUID leaf CPUID_Fn80000008
To: Babu Moger <babu.moger@amd.com>, ehabkost@redhat.com, rth@twiddle.net
References: <20200417215345.64800.73351.stgit@localhost.localdomain>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <09b6454a-b621-4a03-a1e6-987c76108340@redhat.com>
Date: Thu, 21 May 2020 18:04:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200417215345.64800.73351.stgit@localhost.localdomain>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/21 04:44:45
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
Cc: imammedo@redhat.com, qemu-devel@nongnu.org, 1871842@bugs.launchpad.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 17/04/20 23:55, Babu Moger wrote:
> CPUID leaf CPUID_Fn80000008_ECX provides information about the
> number of threads supported by the processor. It was found that
> the field ApicIdSize(bits 15-12) was not set correctly.
> 
> ApicIdSize is defined as the number of bits required to represent
> all the ApicId values within a package.
> 
> Valid Values: Value Description
> 3h-0h		Reserved.
> 4h		up to 16 threads.
> 5h		up to 32 threads.
> 6h		up to 64 threads.
> 7h		up to 128 threads.
> Fh-8h		Reserved.
> 
> Fix the bit appropriately.
> 
> This came up during following thread.
> https://lore.kernel.org/qemu-devel/158643709116.17430.15995069125716778943.malonedeb@wampee.canonical.com/#t
> 
> Refer the Processor Programming Reference (PPR) for AMD Family 17h
> Model 01h, Revision B1 Processors. The documentation is available
> from the bugzilla Link below.
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=206537
> 
> Reported-by: Philipp Eppelt <1871842@bugs.launchpad.net>
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> ---
> v2: 
>   Used env->pkg_offset for bits 15:12 which is already available.
> 
>  target/i386/cpu.c |   15 ++++++++++++---
>  1 file changed, 12 insertions(+), 3 deletions(-)
> 
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index 90ffc5f..5e5a605 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -5830,11 +5830,20 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
>              *eax = cpu->phys_bits;
>          }
>          *ebx = env->features[FEAT_8000_0008_EBX];
> -        *ecx = 0;
> -        *edx = 0;
>          if (cs->nr_cores * cs->nr_threads > 1) {
> -            *ecx |= (cs->nr_cores * cs->nr_threads) - 1;
> +            /*
> +             * Bits 15:12 is "The number of bits in the initial
> +             * Core::X86::Apic::ApicId[ApicId] value that indicate
> +             * thread ID within a package". This is already stored at
> +             * CPUX86State::pkg_offset.
> +             * Bits 7:0 is "The number of threads in the package is NC+1"
> +             */
> +            *ecx = (env->pkg_offset << 12) |
> +                   ((cs->nr_cores * cs->nr_threads) - 1);
> +        } else {
> +            *ecx = 0;
>          }
> +        *edx = 0;
>          break;
>      case 0x8000000A:
>          if (env->features[FEAT_8000_0001_ECX] & CPUID_EXT3_SVM) {
> 

Queued, thanks.

Paolo


