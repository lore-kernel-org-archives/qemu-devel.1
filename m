Return-Path: <SRS0=hUBF=7W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACDFEC433E0
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 06:45:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7590120820
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 06:45:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KXqU3u06"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7590120820
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45646 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jiY0m-0005Sd-OC
	for qemu-devel@archiver.kernel.org; Tue, 09 Jun 2020 02:45:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36248)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1jiXzg-00050b-2h
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 02:44:20 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:20121
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1jiXzd-00080E-Fw
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 02:44:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591685056;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Uc5k9/VctJ1N6nWfRHe9NkeF6gYAkHozLf6NAAstoX0=;
 b=KXqU3u065ZxZc+VAQ/zdBrfM1WAcL5+ht/STB+sHbpdP+0OWv0FNXyy5j3OFHQutHwpdA0
 5LaUv/MdP8ZqkLb3js7jMEOKorlz3qjq4ekZhytxpoFqNmFP2cC+n6UVxyKamUtpvbgkr2
 A5/KEHkVx82+pVxcB5YVY7OHcAhRc1Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-320-QLr5TQ2sO5aIj3KDBg7NNA-1; Tue, 09 Jun 2020 02:44:14 -0400
X-MC-Unique: QLr5TQ2sO5aIj3KDBg7NNA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4552A1800D42;
 Tue,  9 Jun 2020 06:44:13 +0000 (UTC)
Received: from gondolin (ovpn-113-27.ams2.redhat.com [10.36.113.27])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7BAF95D9C9;
 Tue,  9 Jun 2020 06:44:05 +0000 (UTC)
Date: Tue, 9 Jun 2020 08:44:02 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [PATCH v2 1/1] virtio-ccw: auto-manage VIRTIO_F_IOMMU_PLATFORM
 if PV
Message-ID: <20200609084402.35d317ec.cohuck@redhat.com>
In-Reply-To: <20200608190045.319dd68b.pasic@linux.ibm.com>
References: <20200514221155.32079-1-pasic@linux.ibm.com>
 <20200520121507-mutt-send-email-mst@kernel.org>
 <20200606013217.2cffa3ed.pasic@linux.ibm.com>
 <20200608181428.3c6f127c.cohuck@redhat.com>
 <20200608190045.319dd68b.pasic@linux.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=cohuck@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/09 02:44:16
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Thomas Huth <thuth@redhat.com>, Boris Fiuczynski <fiuczy@linux.ibm.com>,
 Janosch Frank <frankja@linux.ibm.com>, Pierre Morel <pmorel@linux.ibm.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, David Hildenbrand <david@redhat.com>,
 qemu-devel@nongnu.org, Christian Borntraeger <borntraeger@de.ibm.com>,
 qemu-s390x@nongnu.org, David Gibson <david@gibson.dropbear.id.au>,
 Viktor Mihajlovski <mihajlov@linux.ibm.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 8 Jun 2020 19:00:45 +0200
Halil Pasic <pasic@linux.ibm.com> wrote:


> > I'm also not 100% sure about migration... would it make sense to
> > discuss all of this in the context of the cross-arch patchset? It seems
> > power has similar issues.
> >   
> 
> I'm going to definitely have a good look at that. What I think special
> about s390 is that F_ACCESS_PLATFORM is hurting us because all IO needs
> to go through ZONE_DMA (this is a problem of the implementation that
> stemming form a limitation of the DMA API, upstream didn't let me
> fix it). 

My understanding is that power runs into similar issues, but I don't
know much about power, so I might be entirely wrong :)

> 
> > > 
> > > Further improvements are possible and probably necessary if we want
> > > to go down this path. But I would like to verify that first.
> > > 
> > > ----------------------------8<---------------------------------
> > > From: Halil Pasic <pasic@linux.ibm.com>
> > > Date: Wed, 26 Feb 2020 16:48:21 +0100
> > > Subject: [PATCH v2.5 1/1] virtio-ccw: auto-manage VIRTIO_F_IOMMU_PLATFORM if PV
> > > 
> > > The virtio specification tells that the device is to present
> > > VIRTIO_F_ACCESS_PLATFORM (a.k.a. VIRTIO_F_IOMMU_PLATFORM) when the
> > > device "can only access certain memory addresses with said access
> > > specified and/or granted by the platform". This is the case for a
> > > protected VMs, as the device can access only memory addresses that are
> > > in pages that are currently shared (only the guest can share/unsare its
> > > pages).
> > > 
> > > No VM, however, starts out as a protected VM, but some VMs may be
> > > converted to protected VMs if the guest decides so.
> > > 
> > > Making the end user explicitly manage the VIRTIO_F_ACCESS_PLATFORM via
> > > the property iommu_on is a minor disaster. Since the correctness of the
> > > paravirtualized virtio devices depends (and thus in a sense the
> > > correctness of the hypervisor) it, then the hypervisor should have the
> > > last word about whether VIRTIO_F_ACCESS_PLATFORM is to be presented or
> > > not.
> > > 
> > > Currently presenting a PV guest with a (paravirtualized) virtio-ccw
> > > device has catastrophic consequences for the VM (after the hypervisors
> > > access to protected memory). This is especially grave in case of device
> > > hotplug (because in this case the guest is more likely to be in the
> > > middle of something important).  
> > 
> > You mean for virtio-ccw devices that don't have iommu_on, right? 
> > 
> >   
> 
> Right, I'm missing the most important words.
> 
> > > 
> > > Let us add the ability to manage the VIRTIO_F_ACCESS_PLATFORM virtio
> > > feature automatically. This is accomplished  by turning the property
> > > into an 'on/off/auto' property, and for virtio-ccw devices if auto
> > > was specified forcing its value before  we start the protected VM. If
> > > the VM should cease to be protected, the original value is restored.
> > > 
> > > Signed-off-by: Halil Pasic <pasic@linux.ibm.com>
> > > ---
> > >  hw/s390x/s390-virtio-ccw.c |  2 ++
> > >  hw/s390x/virtio-ccw.c      | 14 ++++++++++++++
> > >  hw/virtio/virtio.c         | 19 +++++++++++++++++++
> > >  include/hw/virtio/virtio.h |  4 ++--
> > >  4 files changed, 37 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
> > > index f660070d22..705e6b153a 100644
> > > --- a/hw/s390x/s390-virtio-ccw.c
> > > +++ b/hw/s390x/s390-virtio-ccw.c
> > > @@ -330,6 +330,7 @@ static void s390_machine_unprotect(S390CcwMachineState *ms)
> > >      migrate_del_blocker(pv_mig_blocker);
> > >      error_free_or_abort(&pv_mig_blocker);
> > >      qemu_balloon_inhibit(false);
> > > +    subsystem_reset();
> > >  }
> > >  
> > >  static int s390_machine_protect(S390CcwMachineState *ms)
> > > @@ -382,6 +383,7 @@ static int s390_machine_protect(S390CcwMachineState *ms)
> > >      if (rc) {
> > >          goto out_err;
> > >      }
> > > +    subsystem_reset();
> > >      return rc;
> > >  
> > >  out_err:
> > > diff --git a/hw/s390x/virtio-ccw.c b/hw/s390x/virtio-ccw.c
> > > index 64f928fc7d..2bb29b57aa 100644
> > > --- a/hw/s390x/virtio-ccw.c
> > > +++ b/hw/s390x/virtio-ccw.c
> > > @@ -874,6 +874,20 @@ static void virtio_ccw_reset(DeviceState *d)
> > >      VirtioCcwDevice *dev = VIRTIO_CCW_DEVICE(d);
> > >      VirtIODevice *vdev = virtio_bus_get_device(&dev->bus);
> > >      VirtIOCCWDeviceClass *vdc = VIRTIO_CCW_DEVICE_GET_CLASS(dev);
> > > +    S390CcwMachineState *ms = S390_CCW_MACHINE(qdev_get_machine());
> > > +
> > > +    /*
> > > +     * An attempt to use a paravirt device without VIRTIO_F_IOMMU_PLATFORM
> > > +     * in PV, has catastrophic consequences for the VM. Let's force
> > > +     * VIRTIO_F_IOMMU_PLATFORM not already specified.
> > > +     */
> > > +    if (vdev->access_platform_auto && ms->pv) {
> > > +        virtio_add_feature(&vdev->host_features, VIRTIO_F_IOMMU_PLATFORM);
> > > +        vdev->access_platform = ON_OFF_AUTO_ON;
> > > +    } else if (vdev->access_platform_auto) {
> > > +        virtio_clear_feature(&vdev->host_features, VIRTIO_F_IOMMU_PLATFORM);
> > > +        vdev->access_platform = ON_OFF_AUTO_OFF;
> > > +    }  
> > 
> > If the consequences are so dire, we really should disallow adding a
> > device of IOMMU_PLATFORM off if pv is on.  
> 
> I totally agree. My previous patch didn't have the problem because there
> we just forced what we need.
> 
> > 
> > (Can we disallow transition to pv if it is off? Maybe with the machine
> > property approach from the cross-arch patchset?)  
> 
> No we can't disallow transition because for hotplug that already
> happened.

I mean, can a virtio devices without IOMMU_PLATFORM act as a transition
blocker (i.e. an attempt by a guest to move to pv would fail?)

> 
> I can't say anything about the cross-arch patchset. Will come back to you
> once I'm smarter.
> 
> >   
> > >  
> > >      virtio_ccw_reset_virtio(dev, vdev);
> > >      if (vdc->parent_reset) {
> > > diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
> > > index b6c8ef5bc0..f6bd271f14 100644
> > > --- a/hw/virtio/virtio.c
> > > +++ b/hw/virtio/virtio.c
> > > @@ -3232,7 +3232,11 @@ void virtio_instance_init_common(Object *proxy_obj, void *data,
> > >  
> > >      object_initialize_child(proxy_obj, "virtio-backend", vdev, vdev_size,
> > >                              vdev_name, &error_abort, NULL);
> > > +    object_property_add_alias(OBJECT(vdev), "iommu_platform",
> > > +                              OBJECT(vdev), "access_platform", &error_abort);
> > >      qdev_alias_all_properties(vdev, proxy_obj);
> > > +    object_property_add_alias(proxy_obj, "iommu_platform",
> > > +                              OBJECT(vdev), "access_platform", &error_abort);
> > >  }
> > >  
> > >  void virtio_init(VirtIODevice *vdev, const char *name,
> > > @@ -3626,6 +3630,19 @@ static void virtio_device_realize(DeviceState *dev, Error **errp)
> > >          return;
> > >      }
> > >  
> > > +    switch (vdev->access_platform) {
> > > +    case ON_OFF_AUTO_ON:
> > > +        virtio_add_feature(&vdev->host_features, VIRTIO_F_IOMMU_PLATFORM);
> > > +        break;
> > > +    case ON_OFF_AUTO_AUTO:
> > > +        /* transport code can mange access_platform */
> > > +        vdev->access_platform_auto = true;  
> > 
> > Can we really make that transport-specific? While ccw implies s390, pci
> > might be a variety of architectures.
> >   
> 
> Right, this is more about the machine than the transport. I was thinking
> of a machine hook, but decided to discuss the more basic stuff first
> (i.e. is it OK to change the property after stuff is realized).
> 
> This would already fix the most pressing issue which is virtio-ccw. I
> didn't even bother checking if virtio-pci works with PV out of the box,
> or if something needs to be done there. My bet is that it does not work.

I agree, virtio-pci + pv is unlikely to work. But if at all possible,
I'd prefer a general solution anyway, as other architectures care about
virtio-pci.


