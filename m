Return-Path: <SRS0=QiA4=7D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1175C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 16:19:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF696206B6
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 16:19:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="alaosoJ+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF696206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49428 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbnue-00050r-1E
	for qemu-devel@archiver.kernel.org; Thu, 21 May 2020 12:19:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47048)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jbnu5-0004Zi-EK
 for qemu-devel@nongnu.org; Thu, 21 May 2020 12:18:41 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:45235
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jbnu3-0001F5-SB
 for qemu-devel@nongnu.org; Thu, 21 May 2020 12:18:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590077918;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4PhvKRNqPvsZ5rafBZ7UrgmS8crBgnAhUo76TScARgY=;
 b=alaosoJ+gz4lUzrFfjPXQ991oB5FG0gS/PSM/gOmuOIoSPOFlFZop1vxXhlRLBapcakTte
 kg80KmS1AbDc9erdyIfHGZVUnna28u644yNfvkzoV2FzQnZ3U3iYGDFk/CfdMfObrCIja3
 ISBm44lmQLVvMSVNkkxNeQy8ZYNrV6g=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-470-Ht0FoFWWMmya86BPMb4huA-1; Thu, 21 May 2020 12:18:36 -0400
X-MC-Unique: Ht0FoFWWMmya86BPMb4huA-1
Received: by mail-wm1-f72.google.com with SMTP id b142so1294245wmb.6
 for <qemu-devel@nongnu.org>; Thu, 21 May 2020 09:18:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=4PhvKRNqPvsZ5rafBZ7UrgmS8crBgnAhUo76TScARgY=;
 b=nouVEwrxdmM/IqdyuLYzPwclpxNkoEDB5+xVi0PZvCIWiawIv+sPau/oESCHIWMjyB
 gwOBXwzptzGciUkVtK/bqWrJ32f5WB+WByK1ht7Iy8UZYWupJG6s1QaRqEZZ1r7BjRPT
 0MxVfUEDFufnHl00nyCZD9hutMrgeJLAllArzmlnxN/B5sP+D28ryTWesb1a44dnhkMh
 duUuO1paG4mDF1TXGr9uve9OwPtGS9A+lwRgu5288WgCQKiF0gTpLaDQIw3MFON9sbc9
 My+hhKp7ivCxKQghnMJb/rJyS5wDE+bDi2tGKH9LgS9vMdmPFXNycEUKGwDbYbfPkX8r
 6gkg==
X-Gm-Message-State: AOAM530Ajqc8H82o5XF1HMmo7l4kC7qTgOU6S5OCuu5ZIOFDaUzTSJtX
 EIy4zeIeIMaQn9z7Y8rMO7+NGpfFvaaSmTokQb0fqWGrVdrz+0wH0y3hZgjHElCGVYqq27QeA8w
 7wOXbtsSfEMXD2sk=
X-Received: by 2002:adf:f783:: with SMTP id q3mr8979313wrp.348.1590077914998; 
 Thu, 21 May 2020 09:18:34 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzMrH6xWVKgZJ5XyLN4eIgeaUSZV5KGMy6vwBZjdRCBBMVdwoe7+jh7A25fEs7WJqvL3mKwMQ==
X-Received: by 2002:adf:f783:: with SMTP id q3mr8979303wrp.348.1590077914810; 
 Thu, 21 May 2020 09:18:34 -0700 (PDT)
Received: from [192.168.178.58] ([151.21.160.154])
 by smtp.gmail.com with ESMTPSA id d18sm4695081wrn.34.2020.05.21.09.18.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 21 May 2020 09:18:34 -0700 (PDT)
Subject: Re: [PATCH] i386: Remove unused define's from hax and hvf
To: Julio Faracco <jcfaracco@gmail.com>, qemu-devel@nongnu.org
References: <20200323200538.202164-1-jcfaracco@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <33b6988d-23d6-68f5-a1bc-d97bb5300133@redhat.com>
Date: Thu, 21 May 2020 18:18:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200323200538.202164-1-jcfaracco@gmail.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/21 01:47:40
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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
Cc: wenchao.wang@intel.com, colin.xu@intel.com, ehabkost@redhat.com,
 rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 23/03/20 21:05, Julio Faracco wrote:
> Commit acb9f95a removed boundary checks for ID and VCPU ID. After that,
> the max definitions of that boundaries are not required anymore. This
> commit is only a code cleanup.
> 
> Signed-off-by: Julio Faracco <jcfaracco@gmail.com>
> ---
>  target/i386/hax-i386.h     | 2 --
>  target/i386/hvf/hvf-i386.h | 2 --
>  2 files changed, 4 deletions(-)
> 
> diff --git a/target/i386/hax-i386.h b/target/i386/hax-i386.h
> index 54e9d8b057..70fe5cefeb 100644
> --- a/target/i386/hax-i386.h
> +++ b/target/i386/hax-i386.h
> @@ -41,8 +41,6 @@ struct hax_state {
>  };
>  
>  #define HAX_MAX_VCPU 0x10
> -#define MAX_VM_ID 0x40
> -#define MAX_VCPU_ID 0x40
>  
>  struct hax_vm {
>      hax_fd fd;
> diff --git a/target/i386/hvf/hvf-i386.h b/target/i386/hvf/hvf-i386.h
> index 15ee4835cf..fbe4a350c5 100644
> --- a/target/i386/hvf/hvf-i386.h
> +++ b/target/i386/hvf/hvf-i386.h
> @@ -21,8 +21,6 @@
>  #include "x86.h"
>  
>  #define HVF_MAX_VCPU 0x10
> -#define MAX_VM_ID 0x40
> -#define MAX_VCPU_ID 0x40
>  
>  extern struct hvf_state hvf_global;
>  
> 

Queued, thanks.

Paolo


