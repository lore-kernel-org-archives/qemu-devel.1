Return-Path: <SRS0=LaQQ=XZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBC22C4360C
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2019 09:35:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9102D218DE
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2019 09:35:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9102D218DE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47938 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iEs5T-0001pa-IS
	for qemu-devel@archiver.kernel.org; Mon, 30 Sep 2019 05:35:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33852)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1iEs3q-00016F-Er
 for qemu-devel@nongnu.org; Mon, 30 Sep 2019 05:33:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1iEs3o-0004pT-KN
 for qemu-devel@nongnu.org; Mon, 30 Sep 2019 05:33:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35372)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>)
 id 1iEs3o-0004ob-Bx; Mon, 30 Sep 2019 05:33:40 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 17C49A44AD8;
 Mon, 30 Sep 2019 09:33:38 +0000 (UTC)
Received: from localhost (unknown [10.43.2.182])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6440119C70;
 Mon, 30 Sep 2019 09:33:31 +0000 (UTC)
Date: Mon, 30 Sep 2019 11:33:29 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: [PATCH v7 4/4] s390: do not call
 memory_region_allocate_system_memory() multiple times
Message-ID: <20190930113329.71cab280@redhat.com>
In-Reply-To: <63e706b4-4a6a-3be5-6bb7-9c744d269d98@de.ibm.com>
References: <20190924144751.24149-1-imammedo@redhat.com>
 <20190924144751.24149-5-imammedo@redhat.com>
 <20190925032700.GI28074@xz-x1> <20190925135105.6e5f249a@redhat.com>
 <20190925235235.GV28074@xz-x1> <20190927153320.2edc683c@redhat.com>
 <20190928012808.GA31218@xz-x1>
 <63e706b4-4a6a-3be5-6bb7-9c744d269d98@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.68]); Mon, 30 Sep 2019 09:33:38 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: thuth@redhat.com, david@redhat.com, cohuck@redhat.com,
 qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>, qemu-s390x@nongnu.org,
 pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 30 Sep 2019 09:09:59 +0200
Christian Borntraeger <borntraeger@de.ibm.com> wrote:

> On 28.09.19 03:28, Peter Xu wrote:
> > On Fri, Sep 27, 2019 at 03:33:20PM +0200, Igor Mammedov wrote:  
> >> On Thu, 26 Sep 2019 07:52:35 +0800
> >> Peter Xu <peterx@redhat.com> wrote:
> >>  
> >>> On Wed, Sep 25, 2019 at 01:51:05PM +0200, Igor Mammedov wrote:  
> >>>> On Wed, 25 Sep 2019 11:27:00 +0800
> >>>> Peter Xu <peterx@redhat.com> wrote:
> >>>>     
> >>>>> On Tue, Sep 24, 2019 at 10:47:51AM -0400, Igor Mammedov wrote:    
> >>>>>> s390 was trying to solve limited KVM memslot size issue by abusing
> >>>>>> memory_region_allocate_system_memory(), which breaks API contract
> >>>>>> where the function might be called only once.
> >>>>>>
> >>>>>> Beside an invalid use of API, the approach also introduced migration
> >>>>>> issue, since RAM chunks for each KVM_SLOT_MAX_BYTES are transferred in
> >>>>>> migration stream as separate RAMBlocks.
> >>>>>>
> >>>>>> After discussion [1], it was agreed to break migration from older
> >>>>>> QEMU for guest with RAM >8Tb (as it was relatively new (since 2.12)
> >>>>>> and considered to be not actually used downstream).
> >>>>>> Migration should keep working for guests with less than 8TB and for
> >>>>>> more than 8TB with QEMU 4.2 and newer binary.
> >>>>>> In case user tries to migrate more than 8TB guest, between incompatible
> >>>>>> QEMU versions, migration should fail gracefully due to non-exiting
> >>>>>> RAMBlock ID or RAMBlock size mismatch.
> >>>>>>
> >>>>>> Taking in account above and that now KVM code is able to split too
> >>>>>> big MemorySection into several memslots, partially revert commit
> >>>>>>  (bb223055b s390-ccw-virtio: allow for systems larger that 7.999TB)
> >>>>>> and use kvm_set_max_memslot_size() to set KVMSlot size to
> >>>>>> KVM_SLOT_MAX_BYTES.
> >>>>>>
> >>>>>> 1) [PATCH RFC v2 4/4] s390: do not call  memory_region_allocate_system_memory() multiple times
> >>>>>>
> >>>>>> Signed-off-by: Igor Mammedov <imammedo@redhat.com>      
> >>>>>
> >>>>> Acked-by: Peter Xu <peterx@redhat.com>
> >>>>>
> >>>>> IMHO it would be good to at least mention bb223055b9 in the commit
> >>>>> message even if not with a "Fixed:" tag.  May be amended during commit
> >>>>> if anyone prefers.    
> >>>>
> >>>> /me confused, bb223055b9 is mentioned in commit message    
> >>>
> >>> I'm sorry, I overlooked that.
> >>>  
> >>>>      
> >>>>> Also, this only applies the split limitation to s390.  Would that be a
> >>>>> good thing to some other archs as well?    
> >>>>
> >>>> Don't we have the similar bitmap size issue in KVM for other archs?    
> >>>
> >>> Yes I thought we had.  So I feel like it would be good to also allow
> >>> other archs to support >8TB mem as well.  Thanks,  
> >> Another question, Is there another archs with that much RAM that are
> >> available/used in real life (if not I'd wait for demand to arise first)?  
> > 
> > I don't know, so it was a pure question besides the series.  Sorry if
> > that holds your series somehow, it was not my intention.
> >   
> >>
> >> If we are to generalize it to other targets, then instead of using
> >> arbitrary memslot max size per target, we could just hardcode or get
> >> from KVM, max supported size of bitmap and use that to calculate
> >> kvm_max_slot_size depending on target page size.  
> > 
> > Right, I think if so hard code would be fine for now, and probably can
> > with a smallest one across all archs (should depend on the smallest
> > page size, I guess).
> >   
> >>
> >> Then there wouldn't be need for having machine specific code
> >> to care about it and pick/set arbitrary values.
> >>
> >> Another aspect to think about if we are to enable it for
> >> other targets is memslot accounting. It doesn't affect s390
> >> but other targets that support memory hotplug now assume 1:1
> >> relation between memoryregion:memslot, which currently holds
> >> true but would need to amended in case split is enabled there.  
> > 
> > I didn't know this.  So maybe it makes more sense to have s390 only
> > here.  Thanks,  
> 
> OK. So shall I take the series as is via the s390 tree?
Yes, I'd appreciate it.

> I would like to add the following patch on top if nobody minds:
> 
> Subject: [PATCH 1/1] s390/kvm: split kvm mem slots at 4TB
> 
> Instead of splitting at an unaligned address, we can simply split at
> 4TB.
> 
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>

Looks fine to me

Acked-by: Igor Mammedov <imammedo@redhat.com>

> ---
>  target/s390x/kvm.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/target/s390x/kvm.c b/target/s390x/kvm.c
> index ad2dd14f7e78..611f56f4b5ac 100644
> --- a/target/s390x/kvm.c
> +++ b/target/s390x/kvm.c
> @@ -126,12 +126,11 @@
>  /*
>   * KVM does only support memory slots up to KVM_MEM_MAX_NR_PAGES pages
>   * as the dirty bitmap must be managed by bitops that take an int as
> - * position indicator. If we have a guest beyond that we will split off
> - * new subregions. The split must happen on a segment boundary (1MB).
> + * position indicator. This would end at an unaligned  address
> + * (0x7fffff00000). As future variants might provide larger pages
> + * and to make all addresses properly aligned, let us split at 4TB.
>   */
> -#define KVM_MEM_MAX_NR_PAGES ((1ULL << 31) - 1)
> -#define SEG_MSK (~0xfffffULL)
> -#define KVM_SLOT_MAX_BYTES ((KVM_MEM_MAX_NR_PAGES * TARGET_PAGE_SIZE) & SEG_MSK)
> +#define KVM_SLOT_MAX_BYTES 4096UL*1024*1024*1024

I'd use TiB instead of 1024*1024*1024

>  
>  static CPUWatchpoint hw_watchpoint;
>  /*


