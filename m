Return-Path: <SRS0=EA86=VT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E04DAC76188
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2019 08:15:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B51ED21E70
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2019 08:15:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B51ED21E70
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59612 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hpTTO-0008OM-N9
	for qemu-devel@archiver.kernel.org; Mon, 22 Jul 2019 04:15:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47220)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mst@redhat.com>) id 1hpTTE-0007zX-75
 for qemu-devel@nongnu.org; Mon, 22 Jul 2019 04:14:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1hpTTD-0005Qy-0a
 for qemu-devel@nongnu.org; Mon, 22 Jul 2019 04:14:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53092)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1hpTTC-0005QG-Ns
 for qemu-devel@nongnu.org; Mon, 22 Jul 2019 04:14:54 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id C28A030862BE;
 Mon, 22 Jul 2019 08:14:53 +0000 (UTC)
Received: from redhat.com (ovpn-120-233.rdu2.redhat.com [10.10.120.233])
 by smtp.corp.redhat.com (Postfix) with SMTP id 477EB5C3FD;
 Mon, 22 Jul 2019 08:14:46 +0000 (UTC)
Date: Mon, 22 Jul 2019 04:14:45 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: David Hildenbrand <david@redhat.com>
Message-ID: <20190722041121-mutt-send-email-mst@kernel.org>
References: <20190719160120.26581-1-david@redhat.com>
 <20190719160120.26581-4-david@redhat.com>
 <20190722030436.GC1426@umbus.fritz.box>
 <e82ecb8c-edb7-b987-806b-b0a92fb291fa@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e82ecb8c-edb7-b987-806b-b0a92fb291fa@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.49]); Mon, 22 Jul 2019 08:14:53 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v1 3/3] virtio-balloon: Rework pbp tracking
 data
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
Cc: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Jul 22, 2019 at 09:43:43AM +0200, David Hildenbrand wrote:
> On 22.07.19 05:04, David Gibson wrote:
> > On Fri, Jul 19, 2019 at 06:01:20PM +0200, David Hildenbrand wrote:
> >> Using the address of a RAMBlock to test for a matching pbp is not really
> >> safe. Instead, let's use the guest physical address of the base page
> >> along with the page size (via the number of subpages).
> >>
> >> While at it, move "struct PartiallyBalloonedPage" to virtio-balloon.h
> >> now (previously most probably avoided to te the ramblock), renaming it.
> >>
> >> Also, let's only dynamically allocating the bitmap. This makes the code
> >> easier to read and maintain - we can reuse bitmap_new().
> >>
> >> Signed-off-by: David Hildenbrand <david@redhat.com>
> > 
> > This mostly looks good, but one thing bothers me..
> > 
> >> ---
> >>  hw/virtio/virtio-balloon.c         | 52 +++++++++++++++++-------------
> >>  include/hw/virtio/virtio-balloon.h | 15 +++++++--
> >>  2 files changed, 42 insertions(+), 25 deletions(-)
> >>
> >> diff --git a/hw/virtio/virtio-balloon.c b/hw/virtio/virtio-balloon.c
> >> index 29cee344b2..8e5f9459c2 100644
> >> --- a/hw/virtio/virtio-balloon.c
> >> +++ b/hw/virtio/virtio-balloon.c
> >> @@ -34,23 +34,31 @@
> >>  
> >>  #define BALLOON_PAGE_SIZE  (1 << VIRTIO_BALLOON_PFN_SHIFT)
> >>  
> >> -struct PartiallyBalloonedPage {
> >> -    RAMBlock *rb;
> >> -    ram_addr_t base;
> >> -    unsigned long bitmap[];
> >> -};
> >> -
> >>  static void virtio_balloon_reset_pbp(VirtIOBalloon *balloon)
> >>  {
> >> -    g_free(balloon->pbp);
> >> -    balloon->pbp = NULL;
> >> +    balloon->pbp.base_gpa = 0;
> >> +    balloon->pbp.subpages = 0;
> >> +    g_free(balloon->pbp.bitmap);
> >> +    balloon->pbp.bitmap = NULL;
> >> +}
> >> +
> >> +static bool virtio_balloon_pbp_valid(VirtIOBalloon *balloon)
> >> +{
> >> +    return balloon->pbp.bitmap;
> >> +}
> >> +
> >> +static bool virtio_balloon_pbp_matches(VirtIOBalloon *balloon,
> >> +                                       ram_addr_t base_gpa, long subpages)
> >> +{
> >> +    return balloon->pbp.subpages == subpages &&
> >> +           balloon->pbp.base_gpa == base_gpa;
> > 
> > .. so, I'm trying to think what base_gpa matching, but subpages not
> > matching means.  I think that can only happen if a pbp is created,
> > then the ramblock it was in is unplugged, then another ramblock is
> > plugged in covering the same address and with a different (host) page
> > size.  Which is unlikely but possible, IIUC.  However, also possible
> > and marginally less unlikely is to plug a new block of the same page
> > size, in which case this *will* match, but presumably the pbp should
> > still be discarded.
> 
> Why should it be discarded? The guest didn't deflate, so if we drop the
> backing page, it works as expected. If the guest deflated, the pbp would
> be discarded.
> 
> Please note that this will not happen in real life (Linux):
> 
> Before we unplug a DIMM, the guest has to offline that memory. Offlining
> means evacuating all pages that are not free (Buddy). Balloon-inflated
> pages are treated like allocated pages, so the balloon pages will have
> to be moved to a different location (inflate new + deflate old). At this
> point, we had a deflate on the page and dropped the pbp.
> 
> If the guest would be reusing memory (after unplug/replug) and leave
> parts of the memory inflated, it would be expected that something goes
> wrong - especially, also the balloon stats would be most probably wrong.
> 
> Using ramblock notifiers, we could discard the pbp in case a new block
> is added/removed, however I am not convinced that this is really needed.

I think I agree here.

> 
> 
> However, there is (yet) another related issue with PBP. In QEMU, we
> don't set
> 
> #define VIRTIO_BALLOON_F_MUST_TELL_HOST 0 /* Tell before reclaiming pages */
> 
> Which means it would right now be valid for the guest to reuse pages
> tracked in the PBP without deflating (although Linux always tells the
> host). This could result in stale PBP data.
> 
> We really should be setting VIRTIO_BALLOON_F_MUST_TELL_HOST.

Ouch. More than that, anything using PBP is already corrupting
guest memory with legacy guests (before 3.0).
Well given it's also corrupting host memory, I'm not sure
whether we should care ...


> -- 
> 
> Thanks,
> 
> David / dhildenb

