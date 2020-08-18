Return-Path: <SRS0=kYy5=B4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6351BC433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2020 06:33:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2EF992067C
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2020 06:33:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ga/JBpx3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2EF992067C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40974 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k7vBf-0002zb-G8
	for qemu-devel@archiver.kernel.org; Tue, 18 Aug 2020 02:33:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47602)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k7vB7-0002Z5-W4
 for qemu-devel@nongnu.org; Tue, 18 Aug 2020 02:33:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:38094)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k7vB6-0005MK-By
 for qemu-devel@nongnu.org; Tue, 18 Aug 2020 02:33:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597732379;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CgCVW+aP6T+VZYlL/et5dnH6cWH0VRDDUO7YfH1Tetk=;
 b=Ga/JBpx3FXE2CPCPF1abAA1mgJJAKd+5+kR6TjfY5mfH4JwtEgPg3SHI2Fj0L/9mqjrx/w
 enCH3X8coJNAen8xbciDETH5x+WMjxLCdSC2pma6VZRZmc3a4xXDD12NQOd3Jky9mJR5me
 f6qqEbt4uM88tCrx4QD9yLC5HP8RvxI=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-350-6IJrQk-CN5KwKYiDykCnoQ-1; Tue, 18 Aug 2020 02:32:57 -0400
X-MC-Unique: 6IJrQk-CN5KwKYiDykCnoQ-1
Received: by mail-wr1-f71.google.com with SMTP id 89so7823274wrr.15
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2020 23:32:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=CgCVW+aP6T+VZYlL/et5dnH6cWH0VRDDUO7YfH1Tetk=;
 b=IrQDo5GpIBQN5TabDrrGHHsWl2vywRxo7rGekMshCGMxR0Pw2LH6TKTlfm73NKbiYq
 SlcYUWCu1kCWVbbzy5lvGO4X4rBxpNabX2KJKKTojSz2fj0rG86upbGpWtrZe+j9T5i7
 T9zsDloSDwyQRlobRJK1kNGp7Iqk1TKi8BDSh8LMPI4fD8sTRkQHbdgvojnRtgxmwOFE
 MkCAhaTjV3TtO66lUtz5d4ODVNuLSlPuZUuVsj5tPr6FKJPoFYE6YvxyNmQ8Do1/YnYf
 nPo+UMAkbOiNhrZrmbbRsAlsVTrLyJwHiQ2ASun3OJ+qfZNi2yiEoAKHQQHE3iDRFuDn
 ZX7Q==
X-Gm-Message-State: AOAM532OVjHldykq/cp/hGWZ2j4ACRazLzwhQjUmjZrSGqSZui5JhLOV
 Hp0ffhR56b33ezlLIb0OX/VjAaX5mXVop8ape/vi6SwDd3jk83sPApQIEieP65cp74mmv0iSJRa
 G5+SWP76duvkE+H4=
X-Received: by 2002:a1c:ab8b:: with SMTP id
 u133mr17077492wme.108.1597732375622; 
 Mon, 17 Aug 2020 23:32:55 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyh+ToEanpplzTYjuZWadsQnPQXEfKj6Y6bZoljDgO7eQve7n7Ac0vXZZVpJQExMhGi8Q8oag==
X-Received: by 2002:a1c:ab8b:: with SMTP id
 u133mr17077474wme.108.1597732375340; 
 Mon, 17 Aug 2020 23:32:55 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:a0d1:fc42:c610:f977?
 ([2001:b07:6468:f312:a0d1:fc42:c610:f977])
 by smtp.gmail.com with ESMTPSA id o7sm33537478wrv.50.2020.08.17.23.32.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Aug 2020 23:32:54 -0700 (PDT)
Subject: Re: [PATCH-for-5.2] memory: Add trace events to audit MemoryRegionOps
 fields
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20200806152613.18523-1-philmd@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <d87db8e9-40b1-334d-22b0-90674ddf8177@redhat.com>
Date: Tue, 18 Aug 2020 08:32:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200806152613.18523-1-philmd@redhat.com>
Content-Language: en-US
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=63.128.21.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/18 02:02:19
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 06/08/20 17:26, Philippe Mathieu-Daudé wrote:
> Add trace events to audit MemoryRegionOps field such:
>  - are all the valid/impl fields provided?
>  - is the region a power of two?
> 
> These cases are accepted, but it is interesting to list them.
> 
> Example:
> 
>   $ qemu-system-i386 -S -trace memory_region_io_check\*
>   memory_region_io_check_odd_size mr name:'dma-page' size:0x3
>   memory_region_io_check_access_size_incomplete mr name:'acpi-tmr' min/max:[valid:1/4 impl:4/0]
>   memory_region_io_check_access_size_incomplete mr name:'acpi-evt' min/max:[valid:1/2 impl:2/0]
>   memory_region_io_check_access_size_incomplete mr name:'acpi-cnt' min/max:[valid:1/2 impl:2/0]

Can they be detected using Coccinelle instead?

Paolo

> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> ---
> Based-on: <20200805130221.24487-1-philmd@redhat.com>
>           "softmmu: Add missing trace-events file"
> ---
>  softmmu/memory.c     | 11 +++++++++++
>  softmmu/trace-events |  2 ++
>  2 files changed, 13 insertions(+)
> 
> diff --git a/softmmu/memory.c b/softmmu/memory.c
> index d030eb6f7c..daa0daf2a8 100644
> --- a/softmmu/memory.c
> +++ b/softmmu/memory.c
> @@ -1488,6 +1488,17 @@ void memory_region_init_io(MemoryRegion *mr,
>      mr->ops = ops ? ops : &unassigned_mem_ops;
>      mr->opaque = opaque;
>      mr->terminates = true;
> +    if (size != UINT64_MAX && !is_power_of_2(size)) {
> +        trace_memory_region_io_check_odd_size(name, size);
> +    }
> +    if (ops && (!ops->impl.min_access_size || !ops->impl.max_access_size ||
> +                !ops->valid.min_access_size || !ops->valid.max_access_size)) {
> +        trace_memory_region_io_check_access_size_incomplete(name,
> +                mr->ops->valid.min_access_size,
> +                mr->ops->valid.max_access_size,
> +                mr->ops->impl.min_access_size,
> +                mr->ops->impl.max_access_size);
> +    }
>  }
>  
>  void memory_region_init_ram_nomigrate(MemoryRegion *mr,
> diff --git a/softmmu/trace-events b/softmmu/trace-events
> index b80ca042e1..00eb316aef 100644
> --- a/softmmu/trace-events
> +++ b/softmmu/trace-events
> @@ -18,6 +18,8 @@ memory_region_ram_device_write(int cpu_index, void *mr, uint64_t addr, uint64_t
>  flatview_new(void *view, void *root) "%p (root %p)"
>  flatview_destroy(void *view, void *root) "%p (root %p)"
>  flatview_destroy_rcu(void *view, void *root) "%p (root %p)"
> +memory_region_io_check_odd_size(const char *name, uint64_t size) "mr name:'%s' size:0x%"PRIx64
> +memory_region_io_check_access_size_incomplete(const char *name, unsigned vmin, unsigned vmax, unsigned imin, unsigned imax) "mr name:'%s' min/max:[valid:%u/%u impl:%u/%u]"
>  
>  # vl.c
>  vm_state_notify(int running, int reason, const char *reason_str) "running %d reason %d (%s)"
> 


