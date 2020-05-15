Return-Path: <SRS0=sZ1e=65=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FD23C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 16:16:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CC8062070A
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 16:16:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ebzh8CDD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC8062070A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57118 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZd0S-0007EX-VL
	for qemu-devel@archiver.kernel.org; Fri, 15 May 2020 12:16:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33876)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1jZczp-0006mt-JV
 for qemu-devel@nongnu.org; Fri, 15 May 2020 12:15:37 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:56234
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1jZczn-0006Lc-9Z
 for qemu-devel@nongnu.org; Fri, 15 May 2020 12:15:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589559333;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=w6Dw3im+AeacAMiZvf8yC0F13GvlTYhUl8LjrRcL1a8=;
 b=ebzh8CDDHsQtcgrsIo82Nk4gRq3mxhLQPoXfNFMJ7HthA2tTDNzJn8Q9m86TtTrRXdZaDe
 2D7XXWrwCzjDjMkEr+kbtM5t7BL4HOzgoYYZsl+DizxK+mm55NPJniEYQz9IMkIEq7iavB
 XP6KLVtJDkbk8xbw/0eSYiNsi/Xjr3g=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-378-kNmdEkAePo-izissdMEJ0g-1; Fri, 15 May 2020 12:15:32 -0400
X-MC-Unique: kNmdEkAePo-izissdMEJ0g-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1229F83DB37;
 Fri, 15 May 2020 16:15:31 +0000 (UTC)
Received: from work-vm (ovpn-114-149.ams2.redhat.com [10.36.114.149])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9F91262491;
 Fri, 15 May 2020 16:15:23 +0000 (UTC)
Date: Fri, 15 May 2020 17:15:21 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v1 01/17] exec: Introduce
 ram_block_discard_set_(unreliable|required)()
Message-ID: <20200515161521.GJ2954@work-vm>
References: <20200506094948.76388-1-david@redhat.com>
 <20200506094948.76388-2-david@redhat.com>
 <8dc6cefb-63ee-9310-ce18-abf558a08b39@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8dc6cefb-63ee-9310-ce18-abf558a08b39@redhat.com>
User-Agent: Mutt/1.13.4 (2020-02-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Received-SPF: pass client-ip=205.139.110.120; envelope-from=dgilbert@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/14 23:27:07
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 T_HK_NAME_DR=0.01, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
 "Michael S . Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
 qemu-s390x@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* David Hildenbrand (david@redhat.com) wrote:
> On 06.05.20 11:49, David Hildenbrand wrote:
> > We want to replace qemu_balloon_inhibit() by something more generic.
> > Especially, we want to make sure that technologies that really rely on
> > RAM block discards to work reliably to run mutual exclusive with
> > technologies that break it.
> > 
> > E.g., vfio will usually pin all guest memory, turning the virtio-balloon
> > basically useless and make the VM consume more memory than reported via
> > the balloon. While the balloon is special already (=> no guarantees, same
> > behavior possible afer reboots and with huge pages), this will be
> > different, especially, with virtio-mem.
> > 
> > Let's implement a way such that we can make both types of technology run
> > mutually exclusive. We'll convert existing balloon inhibitors in successive
> > patches and add some new ones. Add the check to
> > qemu_balloon_is_inhibited() for now. We might want to make
> > virtio-balloon an acutal inhibitor in the future - however, that
> > requires more thought to not break existing setups.
> > 
> > Cc: "Michael S. Tsirkin" <mst@redhat.com>
> > Cc: Richard Henderson <rth@twiddle.net>
> > Cc: Paolo Bonzini <pbonzini@redhat.com>
> > Signed-off-by: David Hildenbrand <david@redhat.com>
> > ---
> >  balloon.c             |  3 ++-
> >  exec.c                | 48 +++++++++++++++++++++++++++++++++++++++++++
> >  include/exec/memory.h | 41 ++++++++++++++++++++++++++++++++++++
> >  3 files changed, 91 insertions(+), 1 deletion(-)
> > 
> > diff --git a/balloon.c b/balloon.c
> > index f104b42961..c49f57c27b 100644
> > --- a/balloon.c
> > +++ b/balloon.c
> > @@ -40,7 +40,8 @@ static int balloon_inhibit_count;
> >  
> >  bool qemu_balloon_is_inhibited(void)
> >  {
> > -    return atomic_read(&balloon_inhibit_count) > 0;
> > +    return atomic_read(&balloon_inhibit_count) > 0 ||
> > +           ram_block_discard_is_broken();
> >  }
> >  
> >  void qemu_balloon_inhibit(bool state)
> > diff --git a/exec.c b/exec.c
> > index 2874bb5088..52a6e40e99 100644
> > --- a/exec.c
> > +++ b/exec.c
> > @@ -4049,4 +4049,52 @@ void mtree_print_dispatch(AddressSpaceDispatch *d, MemoryRegion *root)
> >      }
> >  }
> >  
> > +static int ram_block_discard_broken;
> > +
> > +int ram_block_discard_set_broken(bool state)
> > +{
> > +    int old;
> > +
> > +    if (!state) {
> > +        atomic_dec(&ram_block_discard_broken);
> > +        return 0;
> > +    }
> > +
> > +    do {
> > +        old = atomic_read(&ram_block_discard_broken);
> > +        if (old < 0) {
> > +            return -EBUSY;
> > +        }
> > +    } while (atomic_cmpxchg(&ram_block_discard_broken, old, old + 1) != old);
> > +    return 0;
> > +}
> > +
> > +int ram_block_discard_set_required(bool state)
> > +{
> > +    int old;
> > +
> > +    if (!state) {
> > +        atomic_inc(&ram_block_discard_broken);
> > +        return 0;
> > +    }
> > +
> > +    do {
> > +        old = atomic_read(&ram_block_discard_broken);
> > +        if (old > 0) {
> > +            return -EBUSY;
> > +        }
> > +    } while (atomic_cmpxchg(&ram_block_discard_broken, old, old - 1) != old);
> > +    return 0;
> > +}
> > +
> > +bool ram_block_discard_is_broken(void)
> > +{
> > +    return atomic_read(&ram_block_discard_broken) > 0;
> > +}
> > +
> > +bool ram_block_discard_is_required(void)
> > +{
> > +    return atomic_read(&ram_block_discard_broken) < 0;
> > +}
> > +
> >  #endif
> > diff --git a/include/exec/memory.h b/include/exec/memory.h
> > index e000bd2f97..9bb5ced38d 100644
> > --- a/include/exec/memory.h
> > +++ b/include/exec/memory.h
> > @@ -2463,6 +2463,47 @@ static inline MemOp devend_memop(enum device_endian end)
> >  }
> >  #endif
> >  
> > +/*
> > + * Inhibit technologies that rely on discarding of parts of RAM blocks to work
> > + * reliably, e.g., to manage the actual amount of memory consumed by the VM
> > + * (then, the memory provided by RAM blocks might be bigger than the desired
> > + * memory consumption). This *must* be set if:
> > + * - Discarding parts of a RAM blocks does not result in the change being
> > + *   reflected in the VM and the pages getting freed.
> > + * - All memory in RAM blocks is pinned or duplicated, invaldiating any previous
> > + *   discards blindly.
> > + * - Discarding parts of a RAM blocks will result in integrity issues (e.g.,
> > + *   encrypted VMs).
> > + * Technologies that only temporarily pin the current working set of a
> > + * driver are fine, because we don't expect such pages to be discarded
> > + * (esp. based on guest action like balloon inflation).
> > + *
> > + * This is *not* to be used to protect from concurrent discards (esp.,
> > + * postcopy).
> > + *
> > + * Returns 0 if successful. Returns -EBUSY if a technology that relies on
> > + * discards to work reliably is active.
> > + */
> > +int ram_block_discard_set_broken(bool state);
> > +
> > +/*
> > + * Inhibit technologies that will break discarding of pages in RAM blocks.
> > + *
> > + * Returns 0 if successful. Returns -EBUSY if discards are already set to
> > + * broken.
> > + */
> > +int ram_block_discard_set_required(bool state);
> > +
> > +/*
> > + * Test if discarding of memory in ram blocks is broken.
> > + */
> > +bool ram_block_discard_is_broken(void);
> > +
> > +/*
> > + * Test if discarding of memory in ram blocks is required to work reliably.
> > + */
> > +bool ram_block_discard_is_required(void);
> > +
> >  #endif
> >  
> >  #endif
> > 
> 
> I'm wondering if I'll just call these functions
> 
> ram_block_discard_disable()
> 
> and
> 
> ram_block_discard_require()

Yeh I prefer that.

Dave

> -- 
> Thanks,
> 
> David / dhildenb
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


