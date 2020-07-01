Return-Path: <SRS0=qPFU=AM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E4BAC433E0
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 15:17:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 52502206C3
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 15:17:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TTNbYFdh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52502206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32952 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqeUL-0006uo-Gj
	for qemu-devel@archiver.kernel.org; Wed, 01 Jul 2020 11:17:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51676)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jqeNP-0003up-J2
 for qemu-devel@nongnu.org; Wed, 01 Jul 2020 11:10:19 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:20784
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jqeNM-00022x-6d
 for qemu-devel@nongnu.org; Wed, 01 Jul 2020 11:10:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593616215;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lNBOVmdq64jNWaBExD3uZji3von1/MX0qCpf6H6a7Qs=;
 b=TTNbYFdhXVCEbPrrZIOdtDC1NNUmcAL7j0uobivxXNf86CVtrCMWNiz4uj3URpvI6MGiBp
 YkiC6cIwyxsBg1LQ08oV/41aBFwY6weiDk0GEmsN/8xHIzKt2+fJRYzmG+0HmozHaweK1+
 Wmcy8K1xyvRKqtCbrqWFRuDaBrUDJUg=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-31-UFgKcqI9OkyZM2U7egYyWw-1; Wed, 01 Jul 2020 11:10:13 -0400
X-MC-Unique: UFgKcqI9OkyZM2U7egYyWw-1
Received: by mail-wr1-f71.google.com with SMTP id w4so19185158wrm.5
 for <qemu-devel@nongnu.org>; Wed, 01 Jul 2020 08:10:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=lNBOVmdq64jNWaBExD3uZji3von1/MX0qCpf6H6a7Qs=;
 b=NdDvSf9Bf5W8k5QZENpNLzfA1MFpPf/WenY/ZivG3h/dOWeJAyrm+mAKobTCxofKDg
 d0LoztHAEr2ouauQucTYoF+xxJgGRQTMFIw/YU5TfD0s3a6zdxRj+qI/tkGhXa/XehmK
 64utN67geC0IvLNsv2273qq9mgVMnoRooAzN+OYXok6rOAigPAUhJFHpzFFn590NVmv0
 oyTicM5aOMYG0MZVBIbSlcLgMhHqJGbX7A+s90gkQG6RoKwJNMaKS/2lm00ZPM/QewcP
 xu6wX6paObss/xZrbX8pJKC8WzJ5BS3CmgSr1uV8/6P2ewbhLwkZQlmmmnwCoVgv0cwd
 gxOg==
X-Gm-Message-State: AOAM532AP/ihYMeRxNkd4uATrK1QZ46iEVmAYmLyMcZnbn8sJDTMMXEF
 8cqLXSy7V92bZ++uVTgMcVt9FAPGjHo8LcwAd6QyNueZAx5lSRh0r93/4XAvXxBRN49ix3WEwaG
 yaqE45wMbjXJra+w=
X-Received: by 2002:a1c:7d55:: with SMTP id y82mr24066637wmc.72.1593616212151; 
 Wed, 01 Jul 2020 08:10:12 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz95WrCKQ64yzAK1YneRHWbBbgim42siIvzKrKhAx/iXsXokqvK0PDamPFfJn81DY4ILHNQAg==
X-Received: by 2002:a1c:7d55:: with SMTP id y82mr24066611wmc.72.1593616211892; 
 Wed, 01 Jul 2020 08:10:11 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:9d66:2ca3:22cf:9fa9?
 ([2001:b07:6468:f312:9d66:2ca3:22cf:9fa9])
 by smtp.gmail.com with ESMTPSA id q1sm7611891wro.82.2020.07.01.08.10.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 01 Jul 2020 08:10:11 -0700 (PDT)
Subject: Re: [PATCH v2] pc: fix leak in pc_system_flash_cleanup_unused
To: Alexander Bulekov <alxndr@bu.edu>, qemu-devel@nongnu.org
References: <20200701145231.19531-1-alxndr@bu.edu>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <d4f325e4-57ad-5934-a341-70b55127db96@redhat.com>
Date: Wed, 1 Jul 2020 17:10:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200701145231.19531-1-alxndr@bu.edu>
Content-Language: en-US
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/01 00:56:58
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Eduardo Habkost <ehabkost@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, armbru@redhat.com, philmd@redhat.com,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 01/07/20 16:52, Alexander Bulekov wrote:
> tries to fix a leak detected when building with --enable-sanitizers:
> ./i386-softmmu/qemu-system-i386
> Upon exit:
> ==13576==ERROR: LeakSanitizer: detected memory leaks
> 
> Direct leak of 1216 byte(s) in 1 object(s) allocated from:
>     #0 0x7f9d2ed5c628 in malloc (/usr/lib/x86_64-linux-gnu/libasan.so.5)
>     #1 0x7f9d2e963500 in g_malloc (/usr/lib/x86_64-linux-gnu/libglib-2.0.so.)
>     #2 0x55fa646d25cc in object_new_with_type /tmp/qemu/qom/object.c:686
>     #3 0x55fa63dbaa88 in qdev_new /tmp/qemu/hw/core/qdev.c:140
>     #4 0x55fa638a533f in pc_pflash_create /tmp/qemu/hw/i386/pc_sysfw.c:88
>     #5 0x55fa638a54c4 in pc_system_flash_create /tmp/qemu/hw/i386/pc_sysfw.c:106
>     #6 0x55fa646caa1d in object_init_with_type /tmp/qemu/qom/object.c:369
>     #7 0x55fa646d20b5 in object_initialize_with_type /tmp/qemu/qom/object.c:511
>     #8 0x55fa646d2606 in object_new_with_type /tmp/qemu/qom/object.c:687
>     #9 0x55fa639431e9 in qemu_init /tmp/qemu/softmmu/vl.c:3878
>     #10 0x55fa6335c1b8 in main /tmp/qemu/softmmu/main.c:48
>     #11 0x7f9d2cf06e0a in __libc_start_main ../csu/libc-start.c:308
>     #12 0x55fa6335f8e9 in _start (/tmp/qemu/build/i386-softmmu/qemu-system-i386)
> 
> Signed-off-by: Alexander Bulekov <alxndr@bu.edu>
> ---
> v2: move unref to pc_pflash_create, per Paolo's suggestion
> 
>  hw/i386/pc_sysfw.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/hw/i386/pc_sysfw.c b/hw/i386/pc_sysfw.c
> index ec2a3b3e7e..60a83c53ab 100644
> --- a/hw/i386/pc_sysfw.c
> +++ b/hw/i386/pc_sysfw.c
> @@ -93,6 +93,7 @@ static PFlashCFI01 *pc_pflash_create(PCMachineState *pcms,
>      object_property_add_child(OBJECT(pcms), name, OBJECT(dev));
>      object_property_add_alias(OBJECT(pcms), alias_prop_name,
>                                OBJECT(dev), "drive");
> +    object_unref(OBJECT(dev));
>      return PFLASH_CFI01(dev);
>  }
>  
> 

Queued, with a small comment above.

Paolo


