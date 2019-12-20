Return-Path: <SRS0=uEni=2K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DA1DC43603
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 15:26:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 551342146E
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 15:26:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CUm0vUm5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 551342146E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57968 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iiKB6-0003bo-GB
	for qemu-devel@archiver.kernel.org; Fri, 20 Dec 2019 10:26:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41123)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.williamson@redhat.com>) id 1iiKAM-000316-8W
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 10:26:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.williamson@redhat.com>) id 1iiKAJ-0005yf-W6
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 10:26:09 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:49102
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
 id 1iiKAJ-0005wj-Ig
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 10:26:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576855566;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gQpEdr0kUnB88BOXWfeLZ68KniGGWxl9+xjrqXwINhw=;
 b=CUm0vUm5JhnJiysnKwR9reliKMdBoK2VjItg4UMdEvRLvXdHUjRE8RuhB2Pavf6jIbHzHd
 Ei7B6qiVITAGsvNXvswxn/iXCcQOwCPaoBObY8AKXHfbP6N/9TkodusnLpdN3mKE5aumBY
 2aXyVyBL9czyk4rELqFMboA0WC5ICjE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-232-cdf4pC_xPMiQEhIsVkzSkA-1; Fri, 20 Dec 2019 10:26:04 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3A2C5DC20;
 Fri, 20 Dec 2019 15:26:02 +0000 (UTC)
Received: from x1.home (ovpn-116-26.phx2.redhat.com [10.3.116.26])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8E8B7100194E;
 Fri, 20 Dec 2019 15:25:54 +0000 (UTC)
Date: Fri, 20 Dec 2019 08:25:54 -0700
From: Alex Williamson <alex.williamson@redhat.com>
To: Felipe Franciosi <felipe@nutanix.com>
Subject: Re: [RFC v4 PATCH 00/49] Initial support of multi-process qemu -
 status update
Message-ID: <20191220082554.0c1bc63a@x1.home>
In-Reply-To: <9540FF2A-FC7E-40AE-9259-46EF431ED65F@nutanix.com>
References: <cover.1571905346.git.jag.raman@oracle.com>
 <20191210064716.GA6401@flaka>
 <20191213104116.GB1180977@stefanha-x1.localdomain>
 <20191216194655.GA5922@flaka>
 <AFBAD3A1-0E22-4E22-AF22-C56794929D87@nutanix.com>
 <20191217163316.GB1333385@stefanha-x1.localdomain>
 <DDE3DA62-31DD-437B-8392-CAD505253EED@nutanix.com>
 <20191219115545.GD1624084@stefanha-x1.localdomain>
 <772D9CF3-D15D-42D1-B9CF-1279619D7C20@nutanix.com>
 <20191219125504.GI1190276@redhat.com>
 <20191220094712.GA1635864@stefanha-x1.localdomain>
 <bfaf0b42-513c-08f2-2d4f-d99437b7041d@redhat.com>
 <9540FF2A-FC7E-40AE-9259-46EF431ED65F@nutanix.com>
Organization: Red Hat
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: cdf4pC_xPMiQEhIsVkzSkA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
Cc: Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 "fam@euphon.net" <fam@euphon.net>, Swapnil Ingle <swapnil.ingle@nutanix.com>,
 "john.g.johnson@oracle.com" <john.g.johnson@oracle.com>,
 Stefan Hajnoczi <stefanha@gmail.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "Walker,
 Benjamin" <benjamin.walker@intel.com>, "kraxel@redhat.com" <kraxel@redhat.com>,
 "jag.raman@oracle.com" <jag.raman@oracle.com>, "Harris,
 James R" <james.r.harris@intel.com>,
 "quintela@redhat.com" <quintela@redhat.com>, "mst@redhat.com" <mst@redhat.com>,
 "armbru@redhat.com" <armbru@redhat.com>,
 "kanth.ghatraju@oracle.com" <kanth.ghatraju@oracle.com>,
 "thuth@redhat.com" <thuth@redhat.com>,
 "ehabkost@redhat.com" <ehabkost@redhat.com>,
 "konrad.wilk@oracle.com" <konrad.wilk@oracle.com>,
 "dgilbert@redhat.com" <dgilbert@redhat.com>,
 "liran.alon@oracle.com" <liran.alon@oracle.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 "rth@twiddle.net" <rth@twiddle.net>, "kwolf@redhat.com" <kwolf@redhat.com>,
 "Daniel P. =?UTF-8?B?QmVycmFuZ8Op?=" <berrange@redhat.com>,
 "mreitz@redhat.com" <mreitz@redhat.com>,
 "ross.lagerwall@citrix.com" <ross.lagerwall@citrix.com>,
 "marcandre.lureau@gmail.com" <marcandre.lureau@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 20 Dec 2019 14:14:33 +0000
Felipe Franciosi <felipe@nutanix.com> wrote:

> > On Dec 20, 2019, at 9:50 AM, Paolo Bonzini <pbonzini@redhat.com> wrote:
> > 
> > On 20/12/19 10:47, Stefan Hajnoczi wrote:  
> >>> If it doesn't create too large of a burden to support both, then I think
> >>> it is very desirable. IIUC, this is saying a kernel based solution as the
> >>> optimized/optimal solution, and userspace UNIX socket based option as the
> >>> generic "works everywhere" fallback solution.  
> >> I'm slightly in favor of the kernel implementation because it keeps us
> >> better aligned with VFIO.  That means solving problems in one place only
> >> and less reinventing the wheel.  
> > 
> > I think there are anyway going to be some differences with VFIO.
> > 
> > For example, currently VFIO requires pinning user memory.  Is that a
> > limitation for muser too?  If so, that would be a big disadvantage; if
> > not, however, management tools need to learn that muser devices unlike
> > other VFIO devices do not prevent overcommit.  
> 
> More or less. We pin them today, but I think we don't really have to.
> I created an issue to look into it:
> https://github.com/nutanix/muser/issues/28
> 
> In any case, if Qemu is ballooning and calls UNMAP_DMA for memory that
> has been ballooned out, then we would release it.

That's exactly the problem with ballooning and vfio, it doesn't unmap
memory, it just zaps it out of the VM, to be demand faulted back in
later.  It's very vCPU-centric.  Memory hotplug is the only case where
we'll see a memory region get unmapped.
 
> The reason we keep it pinned is to support libmuser restarts. IIRC,
> VFIO doesn't need to pin pages for mdev devices (that's the job of the
> mdev driver on the other end via vfio_pin_pages()). It only keeps the
> DMA entries in a RB tree.
> 
> If my understanding is right, then we can probably just keep the map
> Qemu registered (without holding the pages) and call vfio_pin_pages()
> on demand when libmuser restarts.
> 
> For context, this is how the DMA memory registration works today:
> 
> 1) Qemu calls ioctl(vfio_fd, IOMMU_MAP_DMA, &vm_map);
> 
> 2) The iommu driver notifies muser.ko
> 
> 3) Muser.ko pins the pages (in get_dma_map(), called from below)
> (https://github.com/nutanix/muser/blob/master/kmod/muser.c#L711)

Yikes, it pins every page??  vfio_pin_pages() intends for the vendor
driver to be much smarter than this :-\  Thanks,

Alex
 
> 4) Muser.ko notifies libmuser about the memory registration
> (The iommu driver context goes to sleep, hence the pinning)
> 
> 5) Libmuser wakes up and calls mmap() on muser.ko
> 
> 6) Muser.ko inserts the VM memory in libmuser's context
> (https://github.com/nutanix/muser/blob/master/kmod/muser.c#L543)
> 
> 7) Libmuser tells muser.ko that it's done
> 
> 8) Muser.ko iommu callback context that was sleeping wakes up
> 
> 9) Muser.ko places the memory in a "dma_list" for the mudev and returns.
> 
> We could potentially modify the last step to unpin and keep only what
> we need for a future call to vfio_pin_pages(), but I need to check if
> that works.
> 
> Cheers,
> Felipe
> 
> > 
> > Paolo
> >   
> 
> 


