Return-Path: <SRS0=3Wv1=4U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A584C3F2C6
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2020 10:48:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 14AE020637
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2020 10:48:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BZr24ZZA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14AE020637
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45270 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j956O-0003Nm-9k
	for qemu-devel@archiver.kernel.org; Tue, 03 Mar 2020 05:48:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58940)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1j955i-0002sA-Ex
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 05:47:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1j955h-0003AF-F1
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 05:47:58 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:33331
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1j955h-00039n-AY
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 05:47:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583232477;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aFJjO3UnXVF3Co+ygtuv2sFeTJ2dkpMZTNWugLuGLUg=;
 b=BZr24ZZA7QyMEHLGYeuPQW3hxXVx3C3GTsmoOiCgEuIN6hqRRB60qRsIK2rz/xohB+QVhN
 oXfRc6uaIFD2CwfuIxfD7Stsh8Yuz50sxAmAr+qTTv/hiy9KSD8WYsA3ZSxO1SMvJRxJd1
 R6ZMH2/DqSYgooDcFRBIwoTkrx2R5mw=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-286-7KkJJTNDOuGeJb8TLSb-4A-1; Tue, 03 Mar 2020 05:47:55 -0500
X-MC-Unique: 7KkJJTNDOuGeJb8TLSb-4A-1
Received: by mail-wr1-f70.google.com with SMTP id w8so248560wrn.7
 for <qemu-devel@nongnu.org>; Tue, 03 Mar 2020 02:47:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=aFJjO3UnXVF3Co+ygtuv2sFeTJ2dkpMZTNWugLuGLUg=;
 b=aKIdhz/jquhvfi5wC3O4XvcAgpvmKTFD6Z6wv8im+FrT2xP7NKb0P/zK3Gq+bXRuXD
 Sg6ypdN6eJcb20FDoUm7eOuEugB7wvWjMtYMk+w9+ibTyyddjZ/WsWIQ5TiwNF/zS33N
 33xh9dweo6Ur+mUDuD1gPIbHX26Dgc6EO2aT74bv0XaEfQ0QJ2ifPPBBqAM7GX42V3HD
 H0Isf+AoUyJTcBJie8TlX4FBD4FVs/KGQ9lItUcSA1dvn9+4MUKhg6jssgCSHXLoincv
 c6A+z2d29+Ax2xA+riB6JUBjhCejSHbqRhx37pYxfxwi559EepLplP7EuPDynr5cjYlX
 8SJw==
X-Gm-Message-State: ANhLgQ2WcX3Fdj8me/Duj9VHfrnnGk+5DXhRmL8s1Y5s2SS9UOVg56U9
 mm5pGEJyZ7EUtm19zd3ztX9FPzNEVQ8YlXHehWerYyobr0WqiYmkGJgjTaA7MwiFtOLI8LnyhzG
 1Dv6NVqiGAD5Ddh4=
X-Received: by 2002:adf:dd05:: with SMTP id a5mr4926464wrm.108.1583232474315; 
 Tue, 03 Mar 2020 02:47:54 -0800 (PST)
X-Google-Smtp-Source: ADFU+vt/x54kIF9e78cpVM4FARmhf8GV5XDs/mpU2UKd0yahcX6ZWYUhi7tvNEHOQidNaOWPjZsyhw==
X-Received: by 2002:adf:dd05:: with SMTP id a5mr4926449wrm.108.1583232474023; 
 Tue, 03 Mar 2020 02:47:54 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:9def:34a0:b68d:9993?
 ([2001:b07:6468:f312:9def:34a0:b68d:9993])
 by smtp.gmail.com with ESMTPSA id z135sm889900wmc.20.2020.03.03.02.47.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Mar 2020 02:47:53 -0800 (PST)
Subject: Re: [PATCH] target/i386/hax-posix: fix two 'format-truncation'
 compile warnings
To: pannengyuan@huawei.com, rth@twiddle.net, ehabkost@redhat.com
References: <20200224065139.19567-1-pannengyuan@huawei.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <a6e307a4-a66d-2297-5d62-6be910353d67@redhat.com>
Date: Tue, 3 Mar 2020 11:47:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200224065139.19567-1-pannengyuan@huawei.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
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
Cc: qemu-trivial@nongnu.org, euler.robot@huawei.com, qemu-devel@nongnu.org,
 zhang.zhanghailiang@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 24/02/20 07:51, pannengyuan@huawei.com wrote:
> diff --git a/target/i386/hax-posix.c b/target/i386/hax-posix.c
> index a5426a6dac..197d5bc0f9 100644
> --- a/target/i386/hax-posix.c
> +++ b/target/i386/hax-posix.c
> @@ -121,7 +121,8 @@ static char *hax_vm_devfs_string(int vm_id)
>          return NULL;
>      }
>  
> -    snprintf(name, sizeof HAX_VM_DEVFS, "/dev/hax_vm/vm%02d", vm_id);
> +    int len = snprintf(name, sizeof HAX_VM_DEVFS, "/dev/hax_vm/vm%02d", vm_id);
> +    assert(len < sizeof HAX_VM_DEVFS);
>      return name;
>  }
>  
> @@ -140,8 +141,9 @@ static char *hax_vcpu_devfs_string(int vm_id, int vcpu_id)
>          return NULL;
>      }
>  
> -    snprintf(name, sizeof HAX_VCPU_DEVFS, "/dev/hax_vm%02d/vcpu%02d",
> -             vm_id, vcpu_id);
> +    int len = snprintf(name, sizeof HAX_VCPU_DEVFS, "/dev/hax_vm%02d/vcpu%02d",
> +                       vm_id, vcpu_id);
> +    assert(len < sizeof HAX_VCPU_DEVFS);
>      return name;
>  }
>  
> 

Julio Faracco has posted a fix for the same bug.  The best change is
actually to switch to g_strdup_printf.

Paolo


