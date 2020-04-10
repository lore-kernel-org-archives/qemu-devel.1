Return-Path: <SRS0=FIxb=52=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B88F9C2BA2B
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Apr 2020 10:51:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7C9AD20787
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Apr 2020 10:51:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EGFPZxnR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C9AD20787
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60772 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jMrGD-0002mW-J4
	for qemu-devel@archiver.kernel.org; Fri, 10 Apr 2020 06:51:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56454)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1jMrFC-0002MQ-Hp
 for qemu-devel@nongnu.org; Fri, 10 Apr 2020 06:50:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1jMrFA-0007OK-Vo
 for qemu-devel@nongnu.org; Fri, 10 Apr 2020 06:50:42 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:28193
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1jMrFA-0007NR-Q6
 for qemu-devel@nongnu.org; Fri, 10 Apr 2020 06:50:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1586515839;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Y/lhn1NBHmj6LkbzLBNu5LkK/0CkeR9NKLSHbRfGCmY=;
 b=EGFPZxnRw81FpTpMxA/+4CdCD7VKZ7jj4RHhL9SRk4SsqQeuGjEKOSCfqz0BS9M6C0ywUK
 PE//qrfWppVLkgUtD1znDHAvWvRR1W+zz5WMIK/C9giBGISgA/bJa4oNFepY/DRIYQSwZ1
 /TlHgZJXGcdB5W6lvE/9BaZiq9aQOvw=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-218-FsTeSozrO7ao1ReB0xtHBA-1; Fri, 10 Apr 2020 06:50:38 -0400
X-MC-Unique: FsTeSozrO7ao1ReB0xtHBA-1
Received: by mail-wm1-f69.google.com with SMTP id d134so3103785wmd.0
 for <qemu-devel@nongnu.org>; Fri, 10 Apr 2020 03:50:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Y/lhn1NBHmj6LkbzLBNu5LkK/0CkeR9NKLSHbRfGCmY=;
 b=iFGZgppT/Uo8cSuM5U8P9+tZuAhJfBBmO7aax+de94X1ICYjIbotFgYfnYJq4iDHzT
 kuEwdt7WtlU2JxT3xMT4lB+y3SwLuNgIipk3hZAvQaUwJhZ2khBUerfoMtxR2g1POUjF
 pQBk7WuOzYFAm8tvyTKEYeQguHrsStRgZCkPLBJfz7ohwy5QYSvTGsgEERwyJc0tnAWz
 Y11usJ7avI65ev2BvETF/pzpiwihpNV1lplUslFFSbUJsh0gczkA549WDfIGXD0Nx5uG
 /K+KNon+bBBk+cEtkHxALzKbI7i+/dLg5UZ42xTRN3GHoDy7u21BFUGafR/nCl0qAdP5
 ArYw==
X-Gm-Message-State: AGi0PuYDlSAX9jrH2kPkYI7IR388i8bCsdOa7nM9rUUIEyzf/sRkSCoR
 rspHTQBnOHlfT/0+N0uQlqumeLuD74CvKwSf4zg5jpIj8h+4u5HQ//mzE34xsz/wFCwMfXhkINU
 Ze8eNnRSAodZEw0w=
X-Received: by 2002:a05:600c:2255:: with SMTP id
 a21mr4645628wmm.150.1586515836793; 
 Fri, 10 Apr 2020 03:50:36 -0700 (PDT)
X-Google-Smtp-Source: APiQypLP4myDoXcGmOxP+F1NgRPCvdAiSwqtbpGgEDEbPps2C8Y3mXf/mpcx+NtCXxqvWuJ9QyV4fg==
X-Received: by 2002:a05:600c:2255:: with SMTP id
 a21mr4645615wmm.150.1586515836571; 
 Fri, 10 Apr 2020 03:50:36 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:e8a3:73c:c711:b995?
 ([2001:b07:6468:f312:e8a3:73c:c711:b995])
 by smtp.gmail.com with ESMTPSA id o9sm2301351wrx.48.2020.04.10.03.50.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 10 Apr 2020 03:50:36 -0700 (PDT)
Subject: Re: [PATCH v19 QEMU 4/4] memory: Do not allow direct write access to
 rom_device regions
To: Alexander Duyck <alexander.duyck@gmail.com>, david@redhat.com,
 mst@redhat.com
References: <20200410033729.24738.22879.stgit@localhost.localdomain>
 <20200410034150.24738.98143.stgit@localhost.localdomain>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <c9b60224-e280-7351-33df-bbb3e25f6cfd@redhat.com>
Date: Fri, 10 Apr 2020 12:50:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200410034150.24738.98143.stgit@localhost.localdomain>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: virtio-dev@lists.oasis-open.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/04/20 05:41, Alexander Duyck wrote:
> From: Alexander Duyck <alexander.h.duyck@linux.intel.com>
> 
> According to the documentation in memory.h a ROM memory region will be
> backed by RAM for reads, but is supposed to go through a callback for
> writes. Currently we were not checking for the existence of the rom_device
> flag when determining if we could perform a direct write or not.
> 
> To correct that add a check to memory_region_is_direct so that if the
> memory region has the rom_device flag set we will return false for all
> checks where is_write is set.
> 
> Signed-off-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>
> ---
>  include/exec/memory.h |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/include/exec/memory.h b/include/exec/memory.h
> index 1614d9a02c0c..e000bd2f97b2 100644
> --- a/include/exec/memory.h
> +++ b/include/exec/memory.h
> @@ -2351,8 +2351,8 @@ void address_space_write_cached_slow(MemoryRegionCache *cache,
>  static inline bool memory_access_is_direct(MemoryRegion *mr, bool is_write)
>  {
>      if (is_write) {
> -        return memory_region_is_ram(mr) &&
> -               !mr->readonly && !memory_region_is_ram_device(mr);
> +        return memory_region_is_ram(mr) && !mr->readonly &&
> +               !mr->rom_device && !memory_region_is_ram_device(mr);
>      } else {
>          return (memory_region_is_ram(mr) && !memory_region_is_ram_device(mr)) ||
>                 memory_region_is_romd(mr);
> 

Good catch.  I queued this up for 5.0.

Thanks,

Paolo


