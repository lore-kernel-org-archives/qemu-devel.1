Return-Path: <SRS0=SZz4=XU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F7F5C432C1
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 11:52:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F79D21D7A
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 11:52:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F79D21D7A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48468 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iD5q1-0004Bm-Jz
	for qemu-devel@archiver.kernel.org; Wed, 25 Sep 2019 07:52:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49615)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1iD5pF-0003i0-73
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 07:51:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1iD5pD-0005IU-8X
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 07:51:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34384)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>)
 id 1iD5pD-0005Hq-2j; Wed, 25 Sep 2019 07:51:15 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 83B30305FC56;
 Wed, 25 Sep 2019 11:51:12 +0000 (UTC)
Received: from localhost (unknown [10.43.2.182])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CA746196B2;
 Wed, 25 Sep 2019 11:51:06 +0000 (UTC)
Date: Wed, 25 Sep 2019 13:51:05 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Peter Xu <peterx@redhat.com>
Subject: Re: [PATCH v7 4/4] s390: do not call
 memory_region_allocate_system_memory() multiple times
Message-ID: <20190925135105.6e5f249a@redhat.com>
In-Reply-To: <20190925032700.GI28074@xz-x1>
References: <20190924144751.24149-1-imammedo@redhat.com>
 <20190924144751.24149-5-imammedo@redhat.com>
 <20190925032700.GI28074@xz-x1>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.49]); Wed, 25 Sep 2019 11:51:12 +0000 (UTC)
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
 qemu-devel@nongnu.org, borntraeger@de.ibm.com, qemu-s390x@nongnu.org,
 pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 25 Sep 2019 11:27:00 +0800
Peter Xu <peterx@redhat.com> wrote:

> On Tue, Sep 24, 2019 at 10:47:51AM -0400, Igor Mammedov wrote:
> > s390 was trying to solve limited KVM memslot size issue by abusing
> > memory_region_allocate_system_memory(), which breaks API contract
> > where the function might be called only once.
> > 
> > Beside an invalid use of API, the approach also introduced migration
> > issue, since RAM chunks for each KVM_SLOT_MAX_BYTES are transferred in
> > migration stream as separate RAMBlocks.
> > 
> > After discussion [1], it was agreed to break migration from older
> > QEMU for guest with RAM >8Tb (as it was relatively new (since 2.12)
> > and considered to be not actually used downstream).
> > Migration should keep working for guests with less than 8TB and for
> > more than 8TB with QEMU 4.2 and newer binary.
> > In case user tries to migrate more than 8TB guest, between incompatible
> > QEMU versions, migration should fail gracefully due to non-exiting
> > RAMBlock ID or RAMBlock size mismatch.
> > 
> > Taking in account above and that now KVM code is able to split too
> > big MemorySection into several memslots, partially revert commit
> >  (bb223055b s390-ccw-virtio: allow for systems larger that 7.999TB)
> > and use kvm_set_max_memslot_size() to set KVMSlot size to
> > KVM_SLOT_MAX_BYTES.
> > 
> > 1) [PATCH RFC v2 4/4] s390: do not call  memory_region_allocate_system_memory() multiple times
> > 
> > Signed-off-by: Igor Mammedov <imammedo@redhat.com>  
> 
> Acked-by: Peter Xu <peterx@redhat.com>
> 
> IMHO it would be good to at least mention bb223055b9 in the commit
> message even if not with a "Fixed:" tag.  May be amended during commit
> if anyone prefers.

/me confused, bb223055b9 is mentioned in commit message
 
> Also, this only applies the split limitation to s390.  Would that be a
> good thing to some other archs as well?

Don't we have the similar bitmap size issue in KVM for other archs?

> 
> Thanks,
> 


