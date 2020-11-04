Return-Path: <SRS0=hH57=EK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25370C4741F
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 11:19:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7208D21556
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 11:19:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LyPMdwz0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7208D21556
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39844 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kaGok-0005T1-Al
	for qemu-devel@archiver.kernel.org; Wed, 04 Nov 2020 06:19:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50498)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kaGjS-0008Ac-1w
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 06:13:38 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:50880)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kaGjP-00006G-U9
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 06:13:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604488415;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZK+kscyAhxLBU4zkTArjZfJgk427ovf+Sp3A4BUYwYI=;
 b=LyPMdwz0p0j9qdjV1+lraXGeyhSVihII6fVRIabnY5HTej+qrsETzSHk9mX/nVIikQEbx+
 ci0PvuwVAF3OYgFR/t5Js81T0RCtK/bwVbSr/bCb4NDGvWCS/ooq6DqHKC7TsO4897dLfW
 U7xe8gfN//K+XRDo0B/b3E/EHbYo/xs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-382-M5lauHF1OEe_NE7U0qzU_w-1; Wed, 04 Nov 2020 06:13:33 -0500
X-MC-Unique: M5lauHF1OEe_NE7U0qzU_w-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3A17210A0B82;
 Wed,  4 Nov 2020 11:13:31 +0000 (UTC)
Received: from redhat.com (ovpn-115-26.ams2.redhat.com [10.36.115.26])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 501856EF7E;
 Wed,  4 Nov 2020 11:13:24 +0000 (UTC)
Date: Wed, 4 Nov 2020 11:13:20 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Yuri Benditovich <yuri.benditovich@daynix.com>
Subject: Re: [RFC PATCH 5/6] virtio-net: Added eBPF RSS to virtio-net.
Message-ID: <20201104111320.GE565323@redhat.com>
References: <20201102185115.7425-1-andrew@daynix.com>
 <20201102185115.7425-6-andrew@daynix.com>
 <060630f2-d077-7b71-f1d7-86036dd8f38d@redhat.com>
 <CAOEp5Oc7-1Dyj4ryF+S7BVP2YP=0ZrDRN89Qi0jajA3PE0Q6NA@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAOEp5Oc7-1Dyj4ryF+S7BVP2YP=0ZrDRN89Qi0jajA3PE0Q6NA@mail.gmail.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=berrange@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/03 22:09:52
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Yan Vugenfirer <yan@daynix.com>, Jason Wang <jasowang@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Andrew Melnychenko <andrew@daynix.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Nov 04, 2020 at 01:07:41PM +0200, Yuri Benditovich wrote:
> On Wed, Nov 4, 2020 at 5:09 AM Jason Wang <jasowang@redhat.com> wrote:
> 
> >
> > On 2020/11/3 上午2:51, Andrew Melnychenko wrote:
> > > From: Andrew <andrew@daynix.com>
> > >
> > > When RSS is enabled the device tries to load the eBPF program
> > > to select RX virtqueue in the TUN. If eBPF can be loaded
> > > the RSS will function also with vhost (works with kernel 5.8 and later).
> > > Software RSS is used as a fallback with vhost=off when eBPF can't be
> > loaded
> > > or when hash population requested by the guest.
> > >
> > > Signed-off-by: Yuri Benditovich <yuri.benditovich@daynix.com>
> > > Signed-off-by: Andrew Melnychenko <andrew@daynix.com>
> > > ---
> > >   hw/net/vhost_net.c             |   2 +
> > >   hw/net/virtio-net.c            | 120 +++++++++++++++++++++++++++++++--
> > >   include/hw/virtio/virtio-net.h |   4 ++
> > >   net/vhost-vdpa.c               |   2 +
> > >   4 files changed, 124 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/hw/net/vhost_net.c b/hw/net/vhost_net.c
> > > index 24d555e764..16124f99c3 100644
> > > --- a/hw/net/vhost_net.c
> > > +++ b/hw/net/vhost_net.c
> > > @@ -71,6 +71,8 @@ static const int user_feature_bits[] = {
> > >       VIRTIO_NET_F_MTU,
> > >       VIRTIO_F_IOMMU_PLATFORM,
> > >       VIRTIO_F_RING_PACKED,
> > > +    VIRTIO_NET_F_RSS,
> > > +    VIRTIO_NET_F_HASH_REPORT,
> > >
> > >       /* This bit implies RARP isn't sent by QEMU out of band */
> > >       VIRTIO_NET_F_GUEST_ANNOUNCE,
> > > diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
> > > index 277289d56e..afcc3032ec 100644
> > > --- a/hw/net/virtio-net.c
> > > +++ b/hw/net/virtio-net.c
> > > @@ -698,6 +698,19 @@ static void virtio_net_set_queues(VirtIONet *n)
> > >
> > >   static void virtio_net_set_multiqueue(VirtIONet *n, int multiqueue);
> > >
> > > +static uint64_t fix_ebpf_vhost_features(uint64_t features)
> > > +{
> > > +    /* If vhost=on & CONFIG_EBPF doesn't set - disable RSS feature */
> > > +    uint64_t ret = features;
> > > +#ifndef CONFIG_EBPF
> > > +    virtio_clear_feature(&ret, VIRTIO_NET_F_RSS);
> > > +#endif
> > > +    /* for now, there is no solution for populating the hash from eBPF
> > */
> > > +    virtio_clear_feature(&ret, VIRTIO_NET_F_HASH_REPORT);
> >
> >
> > I think we probably need to to something reverse since RSS is under the
> > control on qemu cli, disable features like this may break migration.
> >
> >
> How by design we add new features to qemu in light of possible migration to
> older qemu version when the destination
> qemu does not support these features?

If the feature affects guest ABI, then we don't want to silently/
automatically turn on features that have a dependancy on kernel
features existing. They need to be an opt-in by mgmt app/admin.

IOW there needs to be an explicit property that is set to turn on use
of eBPF. If this property is set, then QEMU must use eBPF or fail
with an error. If it is unset, then QEMU must never use eBPF.

The mgmt app controlling QEMU will decide whether to use eBPF and
turn on the property, and will then know not to migrate it to a
host without eBPF support.


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


