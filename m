Return-Path: <SRS0=f7ls=75=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20AE8C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 06:38:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A17E020734
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 06:38:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VrfQW08z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A17E020734
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34832 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jl5F8-0007dZ-Ml
	for qemu-devel@archiver.kernel.org; Tue, 16 Jun 2020 02:38:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39708)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1jl5AX-0001ul-SZ
 for qemu-devel@nongnu.org; Tue, 16 Jun 2020 02:34:01 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:38078
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1jl5AV-0003d5-RU
 for qemu-devel@nongnu.org; Tue, 16 Jun 2020 02:34:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592289238;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=w+qigBAd26wBH6LVDZstFvR2L9WPITwctEf6TnbGCzo=;
 b=VrfQW08zEqtGhXh5jrwvDDtl7ZgICQt0++qoMNPEf/pLBu3PhHKU/FEtWFQztyAXAoT13j
 zNiT4l+CkEE/tNSe7SiyJI8Wr3FD4J7XeueWiSNtXT8uZCyesP++qCWQcd0HImOfjcYbkB
 fZ3k+FZuEIYzm0naRe+xS27hpbPa0yI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-378-dCh6lNgSMA-YaGF_4N40oQ-1; Tue, 16 Jun 2020 02:33:56 -0400
X-MC-Unique: dCh6lNgSMA-YaGF_4N40oQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 579D819057DA;
 Tue, 16 Jun 2020 06:33:44 +0000 (UTC)
Received: from gondolin (ovpn-112-222.ams2.redhat.com [10.36.112.222])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4B7985C1BD;
 Tue, 16 Jun 2020 06:33:36 +0000 (UTC)
Date: Tue, 16 Jun 2020 08:33:33 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: [PATCH 1/2] virtio-ccw: fix virtio_set_ind_atomic
Message-ID: <20200616083333.2d4edfac.cohuck@redhat.com>
In-Reply-To: <11e8278e-23cc-1e7f-4086-10ecef75b96a@de.ibm.com>
References: <20200616045035.51641-1-pasic@linux.ibm.com>
 <20200616045035.51641-2-pasic@linux.ibm.com>
 <11e8278e-23cc-1e7f-4086-10ecef75b96a@de.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=cohuck@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/16 02:01:17
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
Cc: Thomas Huth <thuth@redhat.com>, Matthew Rosato <mjrosato@linux.ibm.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, David Hildenbrand <david@redhat.com>,
 qemu-devel@nongnu.org, Halil Pasic <pasic@linux.ibm.com>,
 qemu-s390x@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Andreas Krebbel <krebbel@linux.ibm.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 16 Jun 2020 07:58:53 +0200
Christian Borntraeger <borntraeger@de.ibm.com> wrote:

> On 16.06.20 06:50, Halil Pasic wrote:
> > The atomic_cmpxchg() loop is broken because we occasionally end up with
> > old and _old having different values (a legit compiler can generate code
> > that accessed *ind_addr again to pick up a value for _old instead of
> > using the value of old that was already fetched according to the
> > rules of the abstract machine). This means the underlying CS instruction
> > may use a different old (_old) than the one we intended to use if
> > atomic_cmpxchg() performed the xchg part.
> > 
> > Let us use volatile to force the rules of the abstract machine for
> > accesses to *ind_addr. Let us also rewrite the loop so, we that the
> > new old is used to compute the new desired value if the xchg part
> > is not performed.
> > 
> > Signed-off-by: Halil Pasic <pasic@linux.ibm.com>
> > Reported-by: Andre Wild <Andre.Wild1@ibm.com>
> > Fixes: 7e7494627f ("s390x/virtio-ccw: Adapter interrupt support.")
> > ---
> >  hw/s390x/virtio-ccw.c | 18 ++++++++++--------
> >  1 file changed, 10 insertions(+), 8 deletions(-)
> > 
> > diff --git a/hw/s390x/virtio-ccw.c b/hw/s390x/virtio-ccw.c
> > index c1f4bb1d33..3c988a000b 100644
> > --- a/hw/s390x/virtio-ccw.c
> > +++ b/hw/s390x/virtio-ccw.c
> > @@ -786,9 +786,10 @@ static inline VirtioCcwDevice *to_virtio_ccw_dev_fast(DeviceState *d)
> >  static uint8_t virtio_set_ind_atomic(SubchDev *sch, uint64_t ind_loc,
> >                                       uint8_t to_be_set)
> >  {
> > -    uint8_t ind_old, ind_new;
> > +    uint8_t expected, actual;
> >      hwaddr len = 1;
> > -    uint8_t *ind_addr;
> > +    /* avoid  multiple fetches */
> > +    uint8_t volatile *ind_addr;
> >  
> >      ind_addr = cpu_physical_memory_map(ind_loc, &len, true);
> >      if (!ind_addr) {
> > @@ -796,14 +797,15 @@ static uint8_t virtio_set_ind_atomic(SubchDev *sch, uint64_t ind_loc,
> >                       __func__, sch->cssid, sch->ssid, sch->schid);
> >          return -1;
> >      }
> > +    actual = *ind_addr;
> >      do {
> > -        ind_old = *ind_addr;  
> 
> to make things easier to understand. Adding a barrier in here also fixes the issue.
> Reasoning follows below:
> 
> > -        ind_new = ind_old | to_be_set;  
> 
> with an analysis from Andreas (cc)
> 
>  #define atomic_cmpxchg__nocheck(ptr, old, new)    ({                    \   
>  
>      typeof_strip_qual(*ptr) _old = (old);                               \   
>  
>      (void)__atomic_compare_exchange_n(ptr, &_old, new, false,           \   
>  
>                                __ATOMIC_SEQ_CST, __ATOMIC_SEQ_CST);      \   
>  
>      _old;                                                               \   
>  
>  })
>  
> ind_old is copied into _old in the macro. Instead of doing the copy from the
> register the compiler reloads the value from memory. The result is that _old
> and ind_old end up having different values. _old in r1 with the bits set
> already and ind_old in r10 with the bits cleared. _old gets updated by CS
> and matches ind_old afterwards - both with the bits being 0. So the !=
> compare is false and the loop is left without having set any bits.
> 
> 
> Paolo (to),
> I am asking myself if it would be safer to add a barrier or something like
> this in the macros in include/qemu/atomic.h. 

I'm also wondering whether this has been seen on other architectures as
well? There are also some callers in non-s390x code, and dealing with
this in common code would catch them as well.

> 
> 
> 
> 
> > -    } while (atomic_cmpxchg(ind_addr, ind_old, ind_new) != ind_old);
> > -    trace_virtio_ccw_set_ind(ind_loc, ind_old, ind_new);
> > -    cpu_physical_memory_unmap(ind_addr, len, 1, len);
> > +        expected = actual;
> > +        actual = atomic_cmpxchg(ind_addr, expected, expected | to_be_set);
> > +    } while (actual != expected);
> > +    trace_virtio_ccw_set_ind(ind_loc, actual, actual | to_be_set);
> > +    cpu_physical_memory_unmap((void *)ind_addr, len, 1, len);
> >  
> > -    return ind_old;
> > +    return actual;
> >  }
> >  
> >  static void virtio_ccw_notify(DeviceState *d, uint16_t vector)
> >   
> 
> 


