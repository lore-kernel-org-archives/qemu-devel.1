Return-Path: <SRS0=Ajie=DP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D744FC43467
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 06:59:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F1DBF2087D
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 06:59:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hEKIuPwp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1DBF2087D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49748 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQPtN-0006lE-1S
	for qemu-devel@archiver.kernel.org; Thu, 08 Oct 2020 02:59:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53038)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kQPrs-0005nO-6d
 for qemu-devel@nongnu.org; Thu, 08 Oct 2020 02:57:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:33440)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kQPrq-0002C0-J5
 for qemu-devel@nongnu.org; Thu, 08 Oct 2020 02:57:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602140252;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pmnFu4M88+QOrTGnDa4e8fEpP81Bw7vd+WjZ5eh+Rpo=;
 b=hEKIuPwp1k8GK1Yv7HJ/oxk4PKcxPGHqBjx8N7nOltZJWIxQhZ5PHB4ramLpTcxUdKLUXQ
 yAYx+Fz0zZpNu4bhaGmeiz+saerIhTw52J6mWohZ7bUtZNz9BZG42n51jIly0P+gevw6O2
 EUjCYFL4PdhCaI7dJ7IGcdUO8xGlYWE=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-181-lKeMjuxxMAGXF3HlG5dKlQ-1; Thu, 08 Oct 2020 02:57:30 -0400
X-MC-Unique: lKeMjuxxMAGXF3HlG5dKlQ-1
Received: by mail-wm1-f70.google.com with SMTP id 73so2795704wma.5
 for <qemu-devel@nongnu.org>; Wed, 07 Oct 2020 23:57:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=pmnFu4M88+QOrTGnDa4e8fEpP81Bw7vd+WjZ5eh+Rpo=;
 b=lIA6GFWHpIUC2m+kmICje97Ss/fNAl3a6gdP/jY2lsSOYrY+8Ipo0MqONfzbi7SNCe
 dlCaj1VSCbINEFU6YflW4XwV6nLKhiI6vYAX2L77NOSgIbe7k2USgTOHfVL+mmcK20j/
 If0kLERvsZtNXH73jDynf31cO4qOafEMeV+3Wuz11DW6Lflp10uw6jrkxXV2eDxM0sh8
 MhLAMx5sg9nDwDQHnB6NcZsq9IA3+I8yDrJXL7P4ixTJRUJkFYm4tpJ+AOjVO7v1vddJ
 G8A7tgelU7YKooSXh/AzWy5E7GnQhKC6/ZKPg5r8mGJIMUp1NUv0iorRrC1qsFiM6yyP
 /H7Q==
X-Gm-Message-State: AOAM531R3ULn7nx1WEAQoc8n1Rh8CahCbfZMMFpQi4mbXe4AXUrJ5oVA
 QL4I77si4vBGYvpDhduWvsqsRUrD4rrYK0hkzcqHYgS0UmafTm2w9lcdhMOARVfrbscbrKVQiQ9
 6AS3jYWUarkYmdlA=
X-Received: by 2002:a7b:c401:: with SMTP id k1mr6936829wmi.120.1602140248961; 
 Wed, 07 Oct 2020 23:57:28 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJywt86Xm3S00iYNeKf6KOmFjR1DwsBhB/vb1+IeeqkLiIwSMIYsJn4uF0cSOoMDalr9yiuQJQ==
X-Received: by 2002:a7b:c401:: with SMTP id k1mr6936811wmi.120.1602140248705; 
 Wed, 07 Oct 2020 23:57:28 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:bb8c:429c:6de1:f4ec?
 ([2001:b07:6468:f312:bb8c:429c:6de1:f4ec])
 by smtp.gmail.com with ESMTPSA id p21sm5585173wmc.28.2020.10.07.23.57.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 07 Oct 2020 23:57:28 -0700 (PDT)
Subject: Re: [PATCH v3 01/16] memory: Add FlatView foreach function
To: Alexander Bulekov <alxndr@bu.edu>, qemu-devel@nongnu.org
References: <20200921022506.873303-1-alxndr@bu.edu>
 <20200921022506.873303-2-alxndr@bu.edu>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <962ba8d5-e44a-8d0b-e5ba-003b6777585e@redhat.com>
Date: Thu, 8 Oct 2020 08:57:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200921022506.873303-2-alxndr@bu.edu>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/08 02:56:27
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.742,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: darren.kenny@oracle.com, bsd@redhat.com, philmd@redhat.com,
 stefanha@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 21/09/20 04:24, Alexander Bulekov wrote:
> Signed-off-by: Alexander Bulekov <alxndr@bu.edu>
> ---
>  include/exec/memory.h | 5 +++++
>  softmmu/memory.c      | 9 +++++++++
>  2 files changed, 14 insertions(+)
> 
> diff --git a/include/exec/memory.h b/include/exec/memory.h
> index f1bb2a7df5..975a90c871 100644
> --- a/include/exec/memory.h
> +++ b/include/exec/memory.h
> @@ -688,6 +688,11 @@ static inline FlatView *address_space_to_flatview(AddressSpace *as)
>      return atomic_rcu_read(&as->current_map);
>  }
>  
> +typedef int (*flatview_cb)(ram_addr_t start,
> +                           ram_addr_t len,
> +                           const MemoryRegion*, void*);
> +
> +void flatview_for_each_range(FlatView *fv, flatview_cb cb , void *opaque);
>  
>  /**
>   * MemoryRegionSection: describes a fragment of a #MemoryRegion
> diff --git a/softmmu/memory.c b/softmmu/memory.c
> index d030eb6f7c..9db5fbe43a 100644
> --- a/softmmu/memory.c
> +++ b/softmmu/memory.c
> @@ -655,6 +655,15 @@ static void render_memory_region(FlatView *view,
>      }
>  }
>  
> +void flatview_for_each_range(FlatView *fv, flatview_cb cb , void *opaque)
> +{
> +    FlatRange *fr;
> +    FOR_EACH_FLAT_RANGE(fr, fv) {
> +        if (cb(fr->addr.start, fr->addr.size, fr->mr, opaque))
> +            break;
> +    }
> +}

Acked-by: Paolo Bonzini <pbonzini@redhat.com>

>  static MemoryRegion *memory_region_get_flatview_root(MemoryRegion *mr)
>  {
>      while (mr->enabled) {
> 


