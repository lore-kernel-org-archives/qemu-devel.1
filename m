Return-Path: <SRS0=Yszf=AA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09E39C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 07:15:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C91A42078D
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 07:15:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iOXhDHwz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C91A42078D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56488 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jmBFe-0006RO-2d
	for qemu-devel@archiver.kernel.org; Fri, 19 Jun 2020 03:15:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36776)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1jmBEy-0005xw-8m
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 03:15:08 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:54335
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1jmBEw-00006J-Mv
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 03:15:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592550905;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=01RUEMiAvnbBl9pCur+jEs4VVkkDkv+uATGXpWmTvt0=;
 b=iOXhDHwzVNGkRctBJhs9gBKE/b0WNzEAOMklS9I/Y3kCNTxk7ziixMgBpRpgBSKummL6sv
 A19RbAc+Ws7+mYSHCsmwWtSAypI2Awuvlnn5neDQnuxbV1onGCRdk9bM4CU6O2mpqccfxQ
 G4ORmhGcCpL3zH6YsUFh6vK1bnRhMTo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-271-aj0BqIftMLCG-XXInpi0pw-1; Fri, 19 Jun 2020 03:15:01 -0400
X-MC-Unique: aj0BqIftMLCG-XXInpi0pw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 45FFE1005513;
 Fri, 19 Jun 2020 07:15:00 +0000 (UTC)
Received: from gondolin (ovpn-112-224.ams2.redhat.com [10.36.112.224])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7AFEE19C4F;
 Fri, 19 Jun 2020 07:14:52 +0000 (UTC)
Date: Fri, 19 Jun 2020 09:14:49 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: [PATCH 1/2] virtio-ccw: fix virtio_set_ind_atomic
Message-ID: <20200619091449.4a0cff9f.cohuck@redhat.com>
In-Reply-To: <8b0e5564-fd2b-a54c-1b32-6d9ea5de7d3c@de.ibm.com>
References: <20200616045035.51641-1-pasic@linux.ibm.com>
 <20200616045035.51641-2-pasic@linux.ibm.com>
 <11e8278e-23cc-1e7f-4086-10ecef75b96a@de.ibm.com>
 <20200616083333.2d4edfac.cohuck@redhat.com>
 <8b0e5564-fd2b-a54c-1b32-6d9ea5de7d3c@de.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=cohuck@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/19 03:15:03
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

On Tue, 16 Jun 2020 08:45:14 +0200
Christian Borntraeger <borntraeger@de.ibm.com> wrote:

> On 16.06.20 08:33, Cornelia Huck wrote:
> > On Tue, 16 Jun 2020 07:58:53 +0200
> > Christian Borntraeger <borntraeger@de.ibm.com> wrote:
> >   
> >> On 16.06.20 06:50, Halil Pasic wrote:  
> >>> The atomic_cmpxchg() loop is broken because we occasionally end up with
> >>> old and _old having different values (a legit compiler can generate code
> >>> that accessed *ind_addr again to pick up a value for _old instead of
> >>> using the value of old that was already fetched according to the
> >>> rules of the abstract machine). This means the underlying CS instruction
> >>> may use a different old (_old) than the one we intended to use if
> >>> atomic_cmpxchg() performed the xchg part.
> >>>
> >>> Let us use volatile to force the rules of the abstract machine for
> >>> accesses to *ind_addr. Let us also rewrite the loop so, we that the
> >>> new old is used to compute the new desired value if the xchg part
> >>> is not performed.
> >>>
> >>> Signed-off-by: Halil Pasic <pasic@linux.ibm.com>
> >>> Reported-by: Andre Wild <Andre.Wild1@ibm.com>
> >>> Fixes: 7e7494627f ("s390x/virtio-ccw: Adapter interrupt support.")
> >>> ---
> >>>  hw/s390x/virtio-ccw.c | 18 ++++++++++--------
> >>>  1 file changed, 10 insertions(+), 8 deletions(-)
> >>>
> >>> diff --git a/hw/s390x/virtio-ccw.c b/hw/s390x/virtio-ccw.c
> >>> index c1f4bb1d33..3c988a000b 100644
> >>> --- a/hw/s390x/virtio-ccw.c
> >>> +++ b/hw/s390x/virtio-ccw.c
> >>> @@ -786,9 +786,10 @@ static inline VirtioCcwDevice *to_virtio_ccw_dev_fast(DeviceState *d)
> >>>  static uint8_t virtio_set_ind_atomic(SubchDev *sch, uint64_t ind_loc,
> >>>                                       uint8_t to_be_set)
> >>>  {
> >>> -    uint8_t ind_old, ind_new;
> >>> +    uint8_t expected, actual;
> >>>      hwaddr len = 1;
> >>> -    uint8_t *ind_addr;
> >>> +    /* avoid  multiple fetches */
> >>> +    uint8_t volatile *ind_addr;
> >>>  
> >>>      ind_addr = cpu_physical_memory_map(ind_loc, &len, true);
> >>>      if (!ind_addr) {
> >>> @@ -796,14 +797,15 @@ static uint8_t virtio_set_ind_atomic(SubchDev *sch, uint64_t ind_loc,
> >>>                       __func__, sch->cssid, sch->ssid, sch->schid);
> >>>          return -1;
> >>>      }
> >>> +    actual = *ind_addr;
> >>>      do {
> >>> -        ind_old = *ind_addr;    
> >>
> >> to make things easier to understand. Adding a barrier in here also fixes the issue.
> >> Reasoning follows below:
> >>  
> >>> -        ind_new = ind_old | to_be_set;    
> >>
> >> with an analysis from Andreas (cc)
> >>
> >>  #define atomic_cmpxchg__nocheck(ptr, old, new)    ({                    \   
> >>  
> >>      typeof_strip_qual(*ptr) _old = (old);                               \   
> >>  
> >>      (void)__atomic_compare_exchange_n(ptr, &_old, new, false,           \   
> >>  
> >>                                __ATOMIC_SEQ_CST, __ATOMIC_SEQ_CST);      \   
> >>  
> >>      _old;                                                               \   
> >>  
> >>  })
> >>  
> >> ind_old is copied into _old in the macro. Instead of doing the copy from the
> >> register the compiler reloads the value from memory. The result is that _old
> >> and ind_old end up having different values. _old in r1 with the bits set
> >> already and ind_old in r10 with the bits cleared. _old gets updated by CS
> >> and matches ind_old afterwards - both with the bits being 0. So the !=
> >> compare is false and the loop is left without having set any bits.
> >>
> >>
> >> Paolo (to),
> >> I am asking myself if it would be safer to add a barrier or something like
> >> this in the macros in include/qemu/atomic.h.   
> 
> Having said this, I think that the refactoring from Halil (to re-use actual) 
> also makes sense independent of the fix. 

What about adding a barrier instead, as you suggested?

(Still wondering about other users of atomic_cmpxchg(), though.)


