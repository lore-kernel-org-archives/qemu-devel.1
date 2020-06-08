Return-Path: <SRS0=zEF8=7V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4F82C433E0
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 17:06:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 69C3E206C3
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 17:06:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69C3E206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39216 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jiLEX-0007ub-Nf
	for qemu-devel@archiver.kernel.org; Mon, 08 Jun 2020 13:06:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47738)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pasic@linux.ibm.com>)
 id 1jiLDd-0006zg-C6; Mon, 08 Jun 2020 13:05:53 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:22914)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pasic@linux.ibm.com>)
 id 1jiLDb-0003IU-Oj; Mon, 08 Jun 2020 13:05:53 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 058GY2wr004901; Mon, 8 Jun 2020 13:05:44 -0400
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 31g5fc60u9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 08 Jun 2020 13:05:36 -0400
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 058GYwJF014171;
 Mon, 8 Jun 2020 13:05:21 -0400
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com
 [169.51.49.98])
 by mx0a-001b2d01.pphosted.com with ESMTP id 31g5fc5xdk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 08 Jun 2020 13:05:21 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
 by ppma03ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 058GtB99014036;
 Mon, 8 Jun 2020 17:00:51 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com
 (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
 by ppma03ams.nl.ibm.com with ESMTP id 31g2s7vcc5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 08 Jun 2020 17:00:51 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com
 (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
 by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 058H0mF563438920
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 8 Jun 2020 17:00:48 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 607B9A405F;
 Mon,  8 Jun 2020 17:00:48 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B2B51A4065;
 Mon,  8 Jun 2020 17:00:47 +0000 (GMT)
Received: from oc2783563651 (unknown [9.145.151.111])
 by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Mon,  8 Jun 2020 17:00:47 +0000 (GMT)
Date: Mon, 8 Jun 2020 19:00:45 +0200
From: Halil Pasic <pasic@linux.ibm.com>
To: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH v2 1/1] virtio-ccw: auto-manage VIRTIO_F_IOMMU_PLATFORM
 if PV
Message-ID: <20200608190045.319dd68b.pasic@linux.ibm.com>
In-Reply-To: <20200608181428.3c6f127c.cohuck@redhat.com>
References: <20200514221155.32079-1-pasic@linux.ibm.com>
 <20200520121507-mutt-send-email-mst@kernel.org>
 <20200606013217.2cffa3ed.pasic@linux.ibm.com>
 <20200608181428.3c6f127c.cohuck@redhat.com>
Organization: IBM
X-Mailer: Claws Mail 3.11.1 (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216, 18.0.687
 definitions=2020-06-08_14:2020-06-08,
 2020-06-08 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015
 priorityscore=1501 mlxscore=0 spamscore=0 mlxlogscore=999 malwarescore=0
 lowpriorityscore=0 suspectscore=2 phishscore=0 cotscore=-2147483648
 bulkscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2006080117
Received-SPF: pass client-ip=148.163.156.1; envelope-from=pasic@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/08 11:10:17
X-ACL-Warn: Detected OS   = Linux 3.x [generic] [fuzzy]
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, KHOP_DYNAMIC=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001,
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

[..]
> > Let me list some pros and cons (compared to the previous patch):
> > 
> > PRO:
> > * Thanks to on/off/auto we don't override what the user specified. From 
> > user interface perspective preferable. I usually hate software that
> > thinks its than me and can do the opposite I tell it.
> 
> Agreed.
> 
> > 
> > CON:
> > * It is more code: "4 files changed, 37 insertions(+), 2 deletions(-)"
> >   against "3 files changed, 17 insertions(+)"
> > * Unlike the previous one, this one is not fool-proof! The user can
> >   still specify access_platform=off to lets say a hotplug device, and
> >   bring down the guest. We could however fence such stuff with an error
> >   message. Would be even more code though.
> 
> I think trying to hotplug such a device to a guest running in protected
> mode should simply fail (and not crash anything.)

Yes, if on/off/auto with a similar semantics like here is the path
we are going to walk, I will definitely have to throw in some code that
fails the hotplug of such devices.

> 
> > * As far as I can tell 'auto' was used to pick a value on initialization
> >   time. This is a novel, and possibly dodgy use in a sense that the value
> >   of the property may change during the lifetime of the VM.
> 
> You mean that we start the vm once with support for prot virt, and
> later without?

No, this patch does not care if VM supports prot virt or not, it only
cares about the mode we are running in (prot virt or not). That is, I
still might add F_ACCESS_PLATFORM when the VM gets transitioned to a
prot virt VM. And this is something other uses of OnOffAuto don't seem
to do. 

> 
> > * We may need to do something about libvirt.
> 
> I'm also not 100% sure about migration... would it make sense to
> discuss all of this in the context of the cross-arch patchset? It seems
> power has similar issues.
> 

I'm going to definitely have a good look at that. What I think special
about s390 is that F_ACCESS_PLATFORM is hurting us because all IO needs
to go through ZONE_DMA (this is a problem of the implementation that
stemming form a limitation of the DMA API, upstream didn't let me
fix it). 

> > 
> > Further improvements are possible and probably necessary if we want
> > to go down this path. But I would like to verify that first.
> > 
> > ----------------------------8<---------------------------------
> > From: Halil Pasic <pasic@linux.ibm.com>
> > Date: Wed, 26 Feb 2020 16:48:21 +0100
> > Subject: [PATCH v2.5 1/1] virtio-ccw: auto-manage VIRTIO_F_IOMMU_PLATFORM if PV
> > 
> > The virtio specification tells that the device is to present
> > VIRTIO_F_ACCESS_PLATFORM (a.k.a. VIRTIO_F_IOMMU_PLATFORM) when the
> > device "can only access certain memory addresses with said access
> > specified and/or granted by the platform". This is the case for a
> > protected VMs, as the device can access only memory addresses that are
> > in pages that are currently shared (only the guest can share/unsare its
> > pages).
> > 
> > No VM, however, starts out as a protected VM, but some VMs may be
> > converted to protected VMs if the guest decides so.
> > 
> > Making the end user explicitly manage the VIRTIO_F_ACCESS_PLATFORM via
> > the property iommu_on is a minor disaster. Since the correctness of the
> > paravirtualized virtio devices depends (and thus in a sense the
> > correctness of the hypervisor) it, then the hypervisor should have the
> > last word about whether VIRTIO_F_ACCESS_PLATFORM is to be presented or
> > not.
> > 
> > Currently presenting a PV guest with a (paravirtualized) virtio-ccw
> > device has catastrophic consequences for the VM (after the hypervisors
> > access to protected memory). This is especially grave in case of device
> > hotplug (because in this case the guest is more likely to be in the
> > middle of something important).
> 
> You mean for virtio-ccw devices that don't have iommu_on, right? 
> 
> 

Right, I'm missing the most important words.

> > 
> > Let us add the ability to manage the VIRTIO_F_ACCESS_PLATFORM virtio
> > feature automatically. This is accomplished  by turning the property
> > into an 'on/off/auto' property, and for virtio-ccw devices if auto
> > was specified forcing its value before  we start the protected VM. If
> > the VM should cease to be protected, the original value is restored.
> > 
> > Signed-off-by: Halil Pasic <pasic@linux.ibm.com>
> > ---
> >  hw/s390x/s390-virtio-ccw.c |  2 ++
> >  hw/s390x/virtio-ccw.c      | 14 ++++++++++++++
> >  hw/virtio/virtio.c         | 19 +++++++++++++++++++
> >  include/hw/virtio/virtio.h |  4 ++--
> >  4 files changed, 37 insertions(+), 2 deletions(-)
> > 
> > diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
> > index f660070d22..705e6b153a 100644
> > --- a/hw/s390x/s390-virtio-ccw.c
> > +++ b/hw/s390x/s390-virtio-ccw.c
> > @@ -330,6 +330,7 @@ static void s390_machine_unprotect(S390CcwMachineState *ms)
> >      migrate_del_blocker(pv_mig_blocker);
> >      error_free_or_abort(&pv_mig_blocker);
> >      qemu_balloon_inhibit(false);
> > +    subsystem_reset();
> >  }
> >  
> >  static int s390_machine_protect(S390CcwMachineState *ms)
> > @@ -382,6 +383,7 @@ static int s390_machine_protect(S390CcwMachineState *ms)
> >      if (rc) {
> >          goto out_err;
> >      }
> > +    subsystem_reset();
> >      return rc;
> >  
> >  out_err:
> > diff --git a/hw/s390x/virtio-ccw.c b/hw/s390x/virtio-ccw.c
> > index 64f928fc7d..2bb29b57aa 100644
> > --- a/hw/s390x/virtio-ccw.c
> > +++ b/hw/s390x/virtio-ccw.c
> > @@ -874,6 +874,20 @@ static void virtio_ccw_reset(DeviceState *d)
> >      VirtioCcwDevice *dev = VIRTIO_CCW_DEVICE(d);
> >      VirtIODevice *vdev = virtio_bus_get_device(&dev->bus);
> >      VirtIOCCWDeviceClass *vdc = VIRTIO_CCW_DEVICE_GET_CLASS(dev);
> > +    S390CcwMachineState *ms = S390_CCW_MACHINE(qdev_get_machine());
> > +
> > +    /*
> > +     * An attempt to use a paravirt device without VIRTIO_F_IOMMU_PLATFORM
> > +     * in PV, has catastrophic consequences for the VM. Let's force
> > +     * VIRTIO_F_IOMMU_PLATFORM not already specified.
> > +     */
> > +    if (vdev->access_platform_auto && ms->pv) {
> > +        virtio_add_feature(&vdev->host_features, VIRTIO_F_IOMMU_PLATFORM);
> > +        vdev->access_platform = ON_OFF_AUTO_ON;
> > +    } else if (vdev->access_platform_auto) {
> > +        virtio_clear_feature(&vdev->host_features, VIRTIO_F_IOMMU_PLATFORM);
> > +        vdev->access_platform = ON_OFF_AUTO_OFF;
> > +    }
> 
> If the consequences are so dire, we really should disallow adding a
> device of IOMMU_PLATFORM off if pv is on.

I totally agree. My previous patch didn't have the problem because there
we just forced what we need.

> 
> (Can we disallow transition to pv if it is off? Maybe with the machine
> property approach from the cross-arch patchset?)

No we can't disallow transition because for hotplug that already
happened.

I can't say anything about the cross-arch patchset. Will come back to you
once I'm smarter.

> 
> >  
> >      virtio_ccw_reset_virtio(dev, vdev);
> >      if (vdc->parent_reset) {
> > diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
> > index b6c8ef5bc0..f6bd271f14 100644
> > --- a/hw/virtio/virtio.c
> > +++ b/hw/virtio/virtio.c
> > @@ -3232,7 +3232,11 @@ void virtio_instance_init_common(Object *proxy_obj, void *data,
> >  
> >      object_initialize_child(proxy_obj, "virtio-backend", vdev, vdev_size,
> >                              vdev_name, &error_abort, NULL);
> > +    object_property_add_alias(OBJECT(vdev), "iommu_platform",
> > +                              OBJECT(vdev), "access_platform", &error_abort);
> >      qdev_alias_all_properties(vdev, proxy_obj);
> > +    object_property_add_alias(proxy_obj, "iommu_platform",
> > +                              OBJECT(vdev), "access_platform", &error_abort);
> >  }
> >  
> >  void virtio_init(VirtIODevice *vdev, const char *name,
> > @@ -3626,6 +3630,19 @@ static void virtio_device_realize(DeviceState *dev, Error **errp)
> >          return;
> >      }
> >  
> > +    switch (vdev->access_platform) {
> > +    case ON_OFF_AUTO_ON:
> > +        virtio_add_feature(&vdev->host_features, VIRTIO_F_IOMMU_PLATFORM);
> > +        break;
> > +    case ON_OFF_AUTO_AUTO:
> > +        /* transport code can mange access_platform */
> > +        vdev->access_platform_auto = true;
> 
> Can we really make that transport-specific? While ccw implies s390, pci
> might be a variety of architectures.
> 

Right, this is more about the machine than the transport. I was thinking
of a machine hook, but decided to discuss the more basic stuff first
(i.e. is it OK to change the property after stuff is realized).

This would already fix the most pressing issue which is virtio-ccw. I
didn't even bother checking if virtio-pci works with PV out of the box,
or if something needs to be done there. My bet is that it does not work.

> > +        break;
> > +    case ON_OFF_AUTO_OFF: /*fall through*/
> > +    default:
> > +        vdev->access_platform_auto = false;
> > +    }
> > +
> >      vdev->listener.commit = virtio_memory_listener_commit;
> >      memory_listener_register(&vdev->listener, vdev->dma_as);
> >  }
> > @@ -3681,6 +3698,8 @@ static Property virtio_properties[] = {
> >      DEFINE_VIRTIO_COMMON_FEATURES(VirtIODevice, host_features),
> >      DEFINE_PROP_BOOL("use-started", VirtIODevice, use_started, true),
> >      DEFINE_PROP_BOOL("use-disabled-flag", VirtIODevice, use_disabled_flag, true),
> > +    DEFINE_PROP_ON_OFF_AUTO("access_platform", VirtIODevice, access_platform,
> > +                            ON_OFF_AUTO_AUTO),
> >      DEFINE_PROP_END_OF_LIST(),
> >  };
> >  
> > diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
> > index b69d517496..b77e1545b4 100644
> > --- a/include/hw/virtio/virtio.h
> > +++ b/include/hw/virtio/virtio.h
> > @@ -110,6 +110,8 @@ struct VirtIODevice
> >      uint8_t device_endian;
> >      bool use_guest_notifier_mask;
> >      AddressSpace *dma_as;
> > +    OnOffAuto access_platform;
> > +    bool access_platform_auto;
> >      QLIST_HEAD(, VirtQueue) *vector_queues;
> >  };
> >  
> > @@ -289,8 +291,6 @@ typedef struct VirtIORNGConf VirtIORNGConf;
> >                        VIRTIO_F_NOTIFY_ON_EMPTY, true), \
> >      DEFINE_PROP_BIT64("any_layout", _state, _field, \
> >                        VIRTIO_F_ANY_LAYOUT, true), \
> > -    DEFINE_PROP_BIT64("iommu_platform", _state, _field, \
> > -                      VIRTIO_F_IOMMU_PLATFORM, false), \
> 
> I'm wondering about migration compat.

Should be fine, I have the alias for that. But if this is the
path we are taking I will definitely test it.

Thanks for having a look and for all the good questions!

Regards,
Halil 


> 
> >      DEFINE_PROP_BIT64("packed", _state, _field, \
> >                        VIRTIO_F_RING_PACKED, false)
> >  
> > 
> > base-commit: 0ffd3d64bd1bb8b84950e52159a0062fdab34628
> 


