Return-Path: <SRS0=sZ1e=65=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 111F0C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 14:56:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CC2FC2076A
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 14:56:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dT/YDbW0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC2FC2076A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54530 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZbl8-0003Xy-30
	for qemu-devel@archiver.kernel.org; Fri, 15 May 2020 10:56:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46578)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1jZbk5-0002bW-2H
 for qemu-devel@nongnu.org; Fri, 15 May 2020 10:55:20 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:41037
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1jZbk3-0003Dr-17
 for qemu-devel@nongnu.org; Fri, 15 May 2020 10:55:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589554514;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=x2C1LTXgRodL7MD8BAdmR4DJ7nYvn5rUoJyzNq68mBw=;
 b=dT/YDbW0DJ7XIU1o1ci/YAjt7kkyjSeluu375f7r/C84W5tv+Ongd00g01++0z3VFEe3m0
 7UtNrY6NkPagpVTcMX9VOoiOJhlDwJyRXrTK3q5rtkHpRqUXyryJe3y20ZNayjDNpnHY1K
 xAS0cAdLQK++PafP0/nVb0P40A+vW0g=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-101-kt-1HhUqOHyBMCgfx-YdpQ-1; Fri, 15 May 2020 10:55:10 -0400
X-MC-Unique: kt-1HhUqOHyBMCgfx-YdpQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 571BAC7441;
 Fri, 15 May 2020 14:55:09 +0000 (UTC)
Received: from [10.36.114.77] (ovpn-114-77.ams2.redhat.com [10.36.114.77])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A37EE6E9F0;
 Fri, 15 May 2020 14:54:47 +0000 (UTC)
Subject: Re: [PATCH v1 01/17] exec: Introduce
 ram_block_discard_set_(unreliable|required)()
To: qemu-devel@nongnu.org
References: <20200506094948.76388-1-david@redhat.com>
 <20200506094948.76388-2-david@redhat.com>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; prefer-encrypt=mutual; keydata=
 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
Organization: Red Hat GmbH
Message-ID: <8dc6cefb-63ee-9310-ce18-abf558a08b39@redhat.com>
Date: Fri, 15 May 2020 16:54:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200506094948.76388-2-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Received-SPF: pass client-ip=207.211.31.120; envelope-from=david@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/14 22:56:02
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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

On 06.05.20 11:49, David Hildenbrand wrote:
> We want to replace qemu_balloon_inhibit() by something more generic.
> Especially, we want to make sure that technologies that really rely on
> RAM block discards to work reliably to run mutual exclusive with
> technologies that break it.
> 
> E.g., vfio will usually pin all guest memory, turning the virtio-balloon
> basically useless and make the VM consume more memory than reported via
> the balloon. While the balloon is special already (=> no guarantees, same
> behavior possible afer reboots and with huge pages), this will be
> different, especially, with virtio-mem.
> 
> Let's implement a way such that we can make both types of technology run
> mutually exclusive. We'll convert existing balloon inhibitors in successive
> patches and add some new ones. Add the check to
> qemu_balloon_is_inhibited() for now. We might want to make
> virtio-balloon an acutal inhibitor in the future - however, that
> requires more thought to not break existing setups.
> 
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Cc: Richard Henderson <rth@twiddle.net>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  balloon.c             |  3 ++-
>  exec.c                | 48 +++++++++++++++++++++++++++++++++++++++++++
>  include/exec/memory.h | 41 ++++++++++++++++++++++++++++++++++++
>  3 files changed, 91 insertions(+), 1 deletion(-)
> 
> diff --git a/balloon.c b/balloon.c
> index f104b42961..c49f57c27b 100644
> --- a/balloon.c
> +++ b/balloon.c
> @@ -40,7 +40,8 @@ static int balloon_inhibit_count;
>  
>  bool qemu_balloon_is_inhibited(void)
>  {
> -    return atomic_read(&balloon_inhibit_count) > 0;
> +    return atomic_read(&balloon_inhibit_count) > 0 ||
> +           ram_block_discard_is_broken();
>  }
>  
>  void qemu_balloon_inhibit(bool state)
> diff --git a/exec.c b/exec.c
> index 2874bb5088..52a6e40e99 100644
> --- a/exec.c
> +++ b/exec.c
> @@ -4049,4 +4049,52 @@ void mtree_print_dispatch(AddressSpaceDispatch *d, MemoryRegion *root)
>      }
>  }
>  
> +static int ram_block_discard_broken;
> +
> +int ram_block_discard_set_broken(bool state)
> +{
> +    int old;
> +
> +    if (!state) {
> +        atomic_dec(&ram_block_discard_broken);
> +        return 0;
> +    }
> +
> +    do {
> +        old = atomic_read(&ram_block_discard_broken);
> +        if (old < 0) {
> +            return -EBUSY;
> +        }
> +    } while (atomic_cmpxchg(&ram_block_discard_broken, old, old + 1) != old);
> +    return 0;
> +}
> +
> +int ram_block_discard_set_required(bool state)
> +{
> +    int old;
> +
> +    if (!state) {
> +        atomic_inc(&ram_block_discard_broken);
> +        return 0;
> +    }
> +
> +    do {
> +        old = atomic_read(&ram_block_discard_broken);
> +        if (old > 0) {
> +            return -EBUSY;
> +        }
> +    } while (atomic_cmpxchg(&ram_block_discard_broken, old, old - 1) != old);
> +    return 0;
> +}
> +
> +bool ram_block_discard_is_broken(void)
> +{
> +    return atomic_read(&ram_block_discard_broken) > 0;
> +}
> +
> +bool ram_block_discard_is_required(void)
> +{
> +    return atomic_read(&ram_block_discard_broken) < 0;
> +}
> +
>  #endif
> diff --git a/include/exec/memory.h b/include/exec/memory.h
> index e000bd2f97..9bb5ced38d 100644
> --- a/include/exec/memory.h
> +++ b/include/exec/memory.h
> @@ -2463,6 +2463,47 @@ static inline MemOp devend_memop(enum device_endian end)
>  }
>  #endif
>  
> +/*
> + * Inhibit technologies that rely on discarding of parts of RAM blocks to work
> + * reliably, e.g., to manage the actual amount of memory consumed by the VM
> + * (then, the memory provided by RAM blocks might be bigger than the desired
> + * memory consumption). This *must* be set if:
> + * - Discarding parts of a RAM blocks does not result in the change being
> + *   reflected in the VM and the pages getting freed.
> + * - All memory in RAM blocks is pinned or duplicated, invaldiating any previous
> + *   discards blindly.
> + * - Discarding parts of a RAM blocks will result in integrity issues (e.g.,
> + *   encrypted VMs).
> + * Technologies that only temporarily pin the current working set of a
> + * driver are fine, because we don't expect such pages to be discarded
> + * (esp. based on guest action like balloon inflation).
> + *
> + * This is *not* to be used to protect from concurrent discards (esp.,
> + * postcopy).
> + *
> + * Returns 0 if successful. Returns -EBUSY if a technology that relies on
> + * discards to work reliably is active.
> + */
> +int ram_block_discard_set_broken(bool state);
> +
> +/*
> + * Inhibit technologies that will break discarding of pages in RAM blocks.
> + *
> + * Returns 0 if successful. Returns -EBUSY if discards are already set to
> + * broken.
> + */
> +int ram_block_discard_set_required(bool state);
> +
> +/*
> + * Test if discarding of memory in ram blocks is broken.
> + */
> +bool ram_block_discard_is_broken(void);
> +
> +/*
> + * Test if discarding of memory in ram blocks is required to work reliably.
> + */
> +bool ram_block_discard_is_required(void);
> +
>  #endif
>  
>  #endif
> 

I'm wondering if I'll just call these functions

ram_block_discard_disable()

and

ram_block_discard_require()

-- 
Thanks,

David / dhildenb


