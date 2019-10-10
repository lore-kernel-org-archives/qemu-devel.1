Return-Path: <SRS0=X6L9=YD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E798EC4360C
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2019 16:18:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB76D2067B
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2019 16:18:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB76D2067B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41948 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIb8y-0005fy-0i
	for qemu-devel@archiver.kernel.org; Thu, 10 Oct 2019 12:18:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38928)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1iIapi-0004rR-Eg
 for qemu-devel@nongnu.org; Thu, 10 Oct 2019 11:58:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1iIapg-0002h5-3v
 for qemu-devel@nongnu.org; Thu, 10 Oct 2019 11:58:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41570)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1iIapd-0002eR-Dj
 for qemu-devel@nongnu.org; Thu, 10 Oct 2019 11:58:27 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 4DE6D308302F;
 Thu, 10 Oct 2019 15:58:21 +0000 (UTC)
Received: from work-vm (unknown [10.36.118.41])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 220A15D6A5;
 Thu, 10 Oct 2019 15:58:11 +0000 (UTC)
Date: Thu, 10 Oct 2019 16:58:09 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v3] virtio-net: prevent offloads reset on migration
Message-ID: <20191010155809.GF3292@work-vm>
References: <1570709475-32073-1-git-send-email-mikhail.sennikovskii@cloud.ionos.com>
 <1570709475-32073-2-git-send-email-mikhail.sennikovskii@cloud.ionos.com>
 <20191010105212-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191010105212-mutt-send-email-mst@kernel.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.46]); Thu, 10 Oct 2019 15:58:21 +0000 (UTC)
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
Cc: jasowang@redhat.com,
 Mikhail Sennikovsky <mikhail.sennikovskii@cloud.ionos.com>,
 qemu-devel@nongnu.org, stefanha@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Michael S. Tsirkin (mst@redhat.com) wrote:
> On Thu, Oct 10, 2019 at 02:11:15PM +0200, Mikhail Sennikovsky wrote:
> > Currently offloads disabled by guest via the VIRTIO_NET_CTRL_GUEST_OFFLOADS_SET
> > command are not preserved on VM migration.
> > Instead all offloads reported by guest features (via VIRTIO_PCI_GUEST_FEATURES)
> > get enabled.
> > What happens is: first the VirtIONet::curr_guest_offloads gets restored
> > and offloads are getting set correctly:
> > 
> >  #0  qemu_set_offload (nc=0x555556a11400, csum=1, tso4=0, tso6=0, ecn=0, ufo=0) at net/net.c:474
> >  #1  virtio_net_apply_guest_offloads (n=0x555557701ca0) at hw/net/virtio-net.c:720
> >  #2  virtio_net_post_load_device (opaque=0x555557701ca0, version_id=11) at hw/net/virtio-net.c:2334
> >  #3  vmstate_load_state (f=0x5555569dc010, vmsd=0x555556577c80 <vmstate_virtio_net_device>, opaque=0x555557701ca0, version_id=11)
> >      at migration/vmstate.c:168
> >  #4  virtio_load (vdev=0x555557701ca0, f=0x5555569dc010, version_id=11) at hw/virtio/virtio.c:2197
> >  #5  virtio_device_get (f=0x5555569dc010, opaque=0x555557701ca0, size=0, field=0x55555668cd00 <__compound_literal.5>) at hw/virtio/virtio.c:2036
> >  #6  vmstate_load_state (f=0x5555569dc010, vmsd=0x555556577ce0 <vmstate_virtio_net>, opaque=0x555557701ca0, version_id=11) at migration/vmstate.c:143
> >  #7  vmstate_load (f=0x5555569dc010, se=0x5555578189e0) at migration/savevm.c:829
> >  #8  qemu_loadvm_section_start_full (f=0x5555569dc010, mis=0x5555569eee20) at migration/savevm.c:2211
> >  #9  qemu_loadvm_state_main (f=0x5555569dc010, mis=0x5555569eee20) at migration/savevm.c:2395
> >  #10 qemu_loadvm_state (f=0x5555569dc010) at migration/savevm.c:2467
> >  #11 process_incoming_migration_co (opaque=0x0) at migration/migration.c:449
> > 
> > However later on the features are getting restored, and offloads get reset to
> > everything supported by features:
> > 
> >  #0  qemu_set_offload (nc=0x555556a11400, csum=1, tso4=1, tso6=1, ecn=0, ufo=0) at net/net.c:474
> >  #1  virtio_net_apply_guest_offloads (n=0x555557701ca0) at hw/net/virtio-net.c:720
> >  #2  virtio_net_set_features (vdev=0x555557701ca0, features=5104441767) at hw/net/virtio-net.c:773
> >  #3  virtio_set_features_nocheck (vdev=0x555557701ca0, val=5104441767) at hw/virtio/virtio.c:2052
> >  #4  virtio_load (vdev=0x555557701ca0, f=0x5555569dc010, version_id=11) at hw/virtio/virtio.c:2220
> >  #5  virtio_device_get (f=0x5555569dc010, opaque=0x555557701ca0, size=0, field=0x55555668cd00 <__compound_literal.5>) at hw/virtio/virtio.c:2036
> >  #6  vmstate_load_state (f=0x5555569dc010, vmsd=0x555556577ce0 <vmstate_virtio_net>, opaque=0x555557701ca0, version_id=11) at migration/vmstate.c:143
> >  #7  vmstate_load (f=0x5555569dc010, se=0x5555578189e0) at migration/savevm.c:829
> >  #8  qemu_loadvm_section_start_full (f=0x5555569dc010, mis=0x5555569eee20) at migration/savevm.c:2211
> >  #9  qemu_loadvm_state_main (f=0x5555569dc010, mis=0x5555569eee20) at migration/savevm.c:2395
> >  #10 qemu_loadvm_state (f=0x5555569dc010) at migration/savevm.c:2467
> >  #11 process_incoming_migration_co (opaque=0x0) at migration/migration.c:449
> > 
> > Fix this by making the virtio_net_set_features not reset
> > the curr_guest_offloads in case the VM runstate is RUN_STATE_INMIGRATE
> > 
> > Signed-off-by: Mikhail Sennikovsky <mikhail.sennikovskii@cloud.ionos.com>
> 
> I thought more about it and I really think the problem here is
> different: we really should first set features and then apply offloads.
> 
> It is simply dumb that we are calling device specific
> code before initializing generic virtio.
> 
> The logical order of initialization should be:
> 
> init base class
> init derived class
> 
> 
> instead we have it all spread out :(

Yeh; we've hit problems there before.

> 
> What to do about it?
> Could we maybe teach vmstate to record post load hooks
> it needs to run *somewhere*?
> Then we could load device specific state and record post load
> hooks, then load generic state, run generic post load,
> then run device specific post load hooks.
> 
> Dave, what do you think?

I worry about changing all existing virtio devices; who knows
what existing ordering constraints those devices might have on their
post_load's - for example one field in the vmstate might rely on
another post_load having already run and set a flag; that's not
that unusual.

I can imagine having a Notifier* chain; you initialise it at the start
of virtio_load, provide a virtio_load_post_notifier_add(...) and any
post_load that wants delaying can add itself and then you call it
at the right point in virtio_load; but I'd be too scared to change
the ordering of all post_loads of all devices.  You might be
OK to do that for the top level post_load of a virtio device,
because there are only a few to check.

Dave

> 
> 
> > ---
> >  hw/net/virtio-net.c | 9 ++++++++-
> >  1 file changed, 8 insertions(+), 1 deletion(-)
> > 
> > diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
> > index b9e1cd7..49be172 100644
> > --- a/hw/net/virtio-net.c
> > +++ b/hw/net/virtio-net.c
> > @@ -767,7 +767,14 @@ static void virtio_net_set_features(VirtIODevice *vdev, uint64_t features)
> >      n->rsc6_enabled = virtio_has_feature(features, VIRTIO_NET_F_RSC_EXT) &&
> >          virtio_has_feature(features, VIRTIO_NET_F_GUEST_TSO6);
> >  
> > -    if (n->has_vnet_hdr) {
> > +    /*
> > +     * In case of RUN_STATE_INMIGRATE the virtio_net_set_features
> > +     * is called as part of VM state restore process.
> > +     * At this stage we do not want the curr_guest_offloads to be reset,
> > +     * i.e. want to preserve them in the same state as was set
> > +     * by the guest on the source machine.
> > +     */
> > +    if (n->has_vnet_hdr && !runstate_check(RUN_STATE_INMIGRATE)) {
> >          n->curr_guest_offloads =
> >              virtio_net_guest_offloads_by_features(features);
> >          virtio_net_apply_guest_offloads(n);
> > -- 
> > 2.7.4
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

