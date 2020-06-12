Return-Path: <SRS0=+PsZ=7Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D723BC433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jun 2020 16:52:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A142920801
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jun 2020 16:52:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cMgPSrW9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A142920801
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42704 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jjmud-0005iu-R7
	for qemu-devel@archiver.kernel.org; Fri, 12 Jun 2020 12:52:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52382)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jjmtq-0004hp-15
 for qemu-devel@nongnu.org; Fri, 12 Jun 2020 12:51:26 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:46440
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jjmto-0001FF-1S
 for qemu-devel@nongnu.org; Fri, 12 Jun 2020 12:51:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591980683;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=inZkYgaoyW3isg+zSESEgM4W8P7O5dxBLvKh1IPGeGM=;
 b=cMgPSrW9642AUEsmupL4sw4ZMaSnpWSkjJUqaY5UQesdS8OCCsjjduKRbDysB3ytxHFAPK
 nJykV0ANOS1fjY01qClwSrQXQB2KrYRLlfeOjhVdUxIah4QykDZFowUa8XEXi8eMEB7Fkl
 cca05tRWUd0P9DZ7HUsvQ8MxROXkWq0=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-171-ES8qEk4HMICbvOC7sTV3TQ-1; Fri, 12 Jun 2020 12:51:21 -0400
X-MC-Unique: ES8qEk4HMICbvOC7sTV3TQ-1
Received: by mail-wr1-f70.google.com with SMTP id w16so4222633wru.18
 for <qemu-devel@nongnu.org>; Fri, 12 Jun 2020 09:51:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=inZkYgaoyW3isg+zSESEgM4W8P7O5dxBLvKh1IPGeGM=;
 b=QjoLZ1aX8hX8xHTl5R/NZS5XvFDcFwZ9PuaxMBYzIUi25jjKVJig1NGxkO2Q2EpCfd
 0AcUnEzNZBS447FNOi7QaKBO/NhDUoKVlMpguqB6QPJIicwzuJ6N8piTghtLU7KwNAIm
 uodNoff6ZK1yvIOpQKSDLgzNb1QIOCe09bd6/KgBueQh47SKlQE0xvpmWX39Y+EtMM4J
 /NRHd4p/usfibK4E0jp9ELHvFIsygQFoEL0j+mLZjOwgHoReI+nnT8H7+ebgxOxR9a/e
 DKYSoRvEUp3sYg5c+ivobiLZoJzY5jVi8R0ufpHG6ZBocRCrmYzsi2wCdSLhwqqIiQOq
 0Lxg==
X-Gm-Message-State: AOAM530SS5AOt0G0NKfBS0y7H+n/RBoj9dTNpBU6ze7w0Q7eBeKB+L1Z
 g/ztO4U8c1JzleOvkKnPixLSS1I8bmvnckcNnKSjjeafZZwp0b2xXSRvAKlcrLSUfHOcpRTwwuw
 /FzpKHs9gmovqXec=
X-Received: by 2002:a1c:4e17:: with SMTP id g23mr13771297wmh.38.1591980680446; 
 Fri, 12 Jun 2020 09:51:20 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzRzJOWhgoDnzbmGb+RFa85zesvOTwsW6hY6BxbwZGdzhiXhsqHnU+cJXJGNpxemDl/KgB8yA==
X-Received: by 2002:a1c:4e17:: with SMTP id g23mr13771277wmh.38.1591980680176; 
 Fri, 12 Jun 2020 09:51:20 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:29ed:810e:962c:aa0d?
 ([2001:b07:6468:f312:29ed:810e:962c:aa0d])
 by smtp.gmail.com with ESMTPSA id x18sm9252844wmi.35.2020.06.12.09.51.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 12 Jun 2020 09:51:19 -0700 (PDT)
Subject: Re: [PATCH] memory: Revert "memory: accept mismatching sizes in
 memory_region_access_valid"
To: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org
References: <20200610134731.1514409-1-mst@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <3c7ba098-b059-c825-a46d-8ba1c7896eab@redhat.com>
Date: Fri, 12 Jun 2020 18:51:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200610134731.1514409-1-mst@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/12 08:07:17
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: qemu-stable@nongnu.org, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/06/20 15:47, Michael S. Tsirkin wrote:
> Memory API documentation documents valid .min_access_size and .max_access_size
> fields and explains that any access outside these boundaries is blocked.
> 
> This is what devices seem to assume.
> 
> However this is not what the implementation does: it simply
> ignores the boundaries unless there's an "accepts" callback.
> 
> Naturally, this breaks a bunch of devices.
> 
> Revert to the documented behaviour.
> 
> Devices that want to allow any access can just drop the valid field,
> or add the impl field to have accesses converted to appropriate
> length.
> 
> Cc: qemu-stable@nongnu.org
> Reviewed-by: Richard Henderson <rth@twiddle.net>
> Fixes: CVE-2020-13754
> Fixes: https://bugzilla.redhat.com/show_bug.cgi?id=1842363
> Fixes: a014ed07bd5a ("memory: accept mismatching sizes in memory_region_access_valid")
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  memory.c | 29 +++++++++--------------------
>  1 file changed, 9 insertions(+), 20 deletions(-)
> 
> diff --git a/memory.c b/memory.c
> index 91ceaf9fcf..3e9388fb74 100644
> --- a/memory.c
> +++ b/memory.c
> @@ -1352,35 +1352,24 @@ bool memory_region_access_valid(MemoryRegion *mr,
>                                  bool is_write,
>                                  MemTxAttrs attrs)
>  {
> -    int access_size_min, access_size_max;
> -    int access_size, i;
> +    if (mr->ops->valid.accepts
> +        && !mr->ops->valid.accepts(mr->opaque, addr, size, is_write, attrs)) {
> +        return false;
> +    }
>  
>      if (!mr->ops->valid.unaligned && (addr & (size - 1))) {
>          return false;
>      }
>  
> -    if (!mr->ops->valid.accepts) {
> +    /* Treat zero as compatibility all valid */
> +    if (!mr->ops->valid.max_access_size) {
>          return true;
>      }
>  
> -    access_size_min = mr->ops->valid.min_access_size;
> -    if (!mr->ops->valid.min_access_size) {
> -        access_size_min = 1;
> +    if (size > mr->ops->valid.max_access_size
> +        || size < mr->ops->valid.min_access_size) {
> +        return false;
>      }
> -
> -    access_size_max = mr->ops->valid.max_access_size;
> -    if (!mr->ops->valid.max_access_size) {
> -        access_size_max = 4;
> -    }
> -
> -    access_size = MAX(MIN(size, access_size_max), access_size_min);
> -    for (i = 0; i < size; i += access_size) {
> -        if (!mr->ops->valid.accepts(mr->opaque, addr + i, access_size,
> -                                    is_write, attrs)) {
> -            return false;
> -        }
> -    }
> -
>      return true;
>  }
>  
> 

Queued, thanks.

Paolo


