Return-Path: <SRS0=zEF8=7V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8672DC433E0
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 16:37:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 40D252053B
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 16:37:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DH3iibH0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40D252053B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53508 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jiKly-0007Np-Fd
	for qemu-devel@archiver.kernel.org; Mon, 08 Jun 2020 12:37:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39500)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1jiKQW-00083d-VR
 for qemu-devel@nongnu.org; Mon, 08 Jun 2020 12:15:10 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:23744
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1jiKQU-00029V-Iv
 for qemu-devel@nongnu.org; Mon, 08 Jun 2020 12:15:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591632905;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=27dPBvEK2EIZLnDV50y2v1jgw5FSZnqTLLF+lUfjTIw=;
 b=DH3iibH03bRLHffouN0ssIoYsMKpDiuxGgebR1rd6DK0A/A81cuDBvwNFEO5+2mmbbvmfi
 E0il3/heU2TgcL4wxaWCLcfnf/T1hmMxYNHTSoOK12OhtIYsIySwFvyyv5wZ2yWziTP7fL
 jksRk9Jb7CmELj2c7K3lHOdyuKVJx/M=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-236-oBBR7X5vMlGSM19PXRYEdQ-1; Mon, 08 Jun 2020 12:14:51 -0400
X-MC-Unique: oBBR7X5vMlGSM19PXRYEdQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6A6781005510;
 Mon,  8 Jun 2020 16:14:50 +0000 (UTC)
Received: from gondolin (ovpn-115-1.ams2.redhat.com [10.36.115.1])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CE9435C557;
 Mon,  8 Jun 2020 16:14:31 +0000 (UTC)
Date: Mon, 8 Jun 2020 18:14:28 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [PATCH v2 1/1] virtio-ccw: auto-manage VIRTIO_F_IOMMU_PLATFORM
 if PV
Message-ID: <20200608181428.3c6f127c.cohuck@redhat.com>
In-Reply-To: <20200606013217.2cffa3ed.pasic@linux.ibm.com>
References: <20200514221155.32079-1-pasic@linux.ibm.com>
 <20200520121507-mutt-send-email-mst@kernel.org>
 <20200606013217.2cffa3ed.pasic@linux.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=cohuck@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/08 01:05:50
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
 qemu-s390x@nongnu.org, Viktor Mihajlovski <mihajlov@linux.ibm.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, 6 Jun 2020 01:32:17 +0200
Halil Pasic <pasic@linux.ibm.com> wrote:

> On Wed, 20 May 2020 12:23:24 -0400
> "Michael S. Tsirkin" <mst@redhat.com> wrote:
> 
> > On Fri, May 15, 2020 at 12:11:55AM +0200, Halil Pasic wrote:  
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
> > 
> > So, how about this: switch iommu to on/off/auto.  Add a property with a
> > reasonable name "allow protected"?  If set allow switch to protected
> > memory and also set iommu auto to on by default.  If not set then don't.
> > 
> > This will come handy for other things like migrating to hosts without
> > protected memory support.
> > 
> > 
> > Also, virtio now calls this PLATFORM_ACCESS, maybe we should rename
> > the property (keeping old one around for compat)?
> > I feel this will address lots of complaints ...
> >   
> 
> I'm not sure I've entirely understood your proposal, but I tried to
> do something in that direction. 
> 
> Short summary of the changes: 
> * added new property "access_platform" as on/off/auto (default auto)
> * added alias "iommu_platform" for compatibility
> * rewrote this patch to on/off/auto so that we only do the override when
>   user specified auto 
> 
> Let me list some pros and cons (compared to the previous patch):
> 
> PRO:
> * Thanks to on/off/auto we don't override what the user specified. From 
> user interface perspective preferable. I usually hate software that
> thinks its than me and can do the opposite I tell it.

Agreed.

> 
> CON:
> * It is more code: "4 files changed, 37 insertions(+), 2 deletions(-)"
>   against "3 files changed, 17 insertions(+)"
> * Unlike the previous one, this one is not fool-proof! The user can
>   still specify access_platform=off to lets say a hotplug device, and
>   bring down the guest. We could however fence such stuff with an error
>   message. Would be even more code though.

I think trying to hotplug such a device to a guest running in protected
mode should simply fail (and not crash anything.)

> * As far as I can tell 'auto' was used to pick a value on initialization
>   time. This is a novel, and possibly dodgy use in a sense that the value
>   of the property may change during the lifetime of the VM.

You mean that we start the vm once with support for prot virt, and
later without?

> * We may need to do something about libvirt.

I'm also not 100% sure about migration... would it make sense to
discuss all of this in the context of the cross-arch patchset? It seems
power has similar issues.

> 
> Further improvements are possible and probably necessary if we want
> to go down this path. But I would like to verify that first.
> 
> ----------------------------8<---------------------------------
> From: Halil Pasic <pasic@linux.ibm.com>
> Date: Wed, 26 Feb 2020 16:48:21 +0100
> Subject: [PATCH v2.5 1/1] virtio-ccw: auto-manage VIRTIO_F_IOMMU_PLATFORM if PV
> 
> The virtio specification tells that the device is to present
> VIRTIO_F_ACCESS_PLATFORM (a.k.a. VIRTIO_F_IOMMU_PLATFORM) when the
> device "can only access certain memory addresses with said access
> specified and/or granted by the platform". This is the case for a
> protected VMs, as the device can access only memory addresses that are
> in pages that are currently shared (only the guest can share/unsare its
> pages).
> 
> No VM, however, starts out as a protected VM, but some VMs may be
> converted to protected VMs if the guest decides so.
> 
> Making the end user explicitly manage the VIRTIO_F_ACCESS_PLATFORM via
> the property iommu_on is a minor disaster. Since the correctness of the
> paravirtualized virtio devices depends (and thus in a sense the
> correctness of the hypervisor) it, then the hypervisor should have the
> last word about whether VIRTIO_F_ACCESS_PLATFORM is to be presented or
> not.
> 
> Currently presenting a PV guest with a (paravirtualized) virtio-ccw
> device has catastrophic consequences for the VM (after the hypervisors
> access to protected memory). This is especially grave in case of device
> hotplug (because in this case the guest is more likely to be in the
> middle of something important).

You mean for virtio-ccw devices that don't have iommu_on, right?


> 
> Let us add the ability to manage the VIRTIO_F_ACCESS_PLATFORM virtio
> feature automatically. This is accomplished  by turning the property
> into an 'on/off/auto' property, and for virtio-ccw devices if auto
> was specified forcing its value before  we start the protected VM. If
> the VM should cease to be protected, the original value is restored.
> 
> Signed-off-by: Halil Pasic <pasic@linux.ibm.com>
> ---
>  hw/s390x/s390-virtio-ccw.c |  2 ++
>  hw/s390x/virtio-ccw.c      | 14 ++++++++++++++
>  hw/virtio/virtio.c         | 19 +++++++++++++++++++
>  include/hw/virtio/virtio.h |  4 ++--
>  4 files changed, 37 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
> index f660070d22..705e6b153a 100644
> --- a/hw/s390x/s390-virtio-ccw.c
> +++ b/hw/s390x/s390-virtio-ccw.c
> @@ -330,6 +330,7 @@ static void s390_machine_unprotect(S390CcwMachineState *ms)
>      migrate_del_blocker(pv_mig_blocker);
>      error_free_or_abort(&pv_mig_blocker);
>      qemu_balloon_inhibit(false);
> +    subsystem_reset();
>  }
>  
>  static int s390_machine_protect(S390CcwMachineState *ms)
> @@ -382,6 +383,7 @@ static int s390_machine_protect(S390CcwMachineState *ms)
>      if (rc) {
>          goto out_err;
>      }
> +    subsystem_reset();
>      return rc;
>  
>  out_err:
> diff --git a/hw/s390x/virtio-ccw.c b/hw/s390x/virtio-ccw.c
> index 64f928fc7d..2bb29b57aa 100644
> --- a/hw/s390x/virtio-ccw.c
> +++ b/hw/s390x/virtio-ccw.c
> @@ -874,6 +874,20 @@ static void virtio_ccw_reset(DeviceState *d)
>      VirtioCcwDevice *dev = VIRTIO_CCW_DEVICE(d);
>      VirtIODevice *vdev = virtio_bus_get_device(&dev->bus);
>      VirtIOCCWDeviceClass *vdc = VIRTIO_CCW_DEVICE_GET_CLASS(dev);
> +    S390CcwMachineState *ms = S390_CCW_MACHINE(qdev_get_machine());
> +
> +    /*
> +     * An attempt to use a paravirt device without VIRTIO_F_IOMMU_PLATFORM
> +     * in PV, has catastrophic consequences for the VM. Let's force
> +     * VIRTIO_F_IOMMU_PLATFORM not already specified.
> +     */
> +    if (vdev->access_platform_auto && ms->pv) {
> +        virtio_add_feature(&vdev->host_features, VIRTIO_F_IOMMU_PLATFORM);
> +        vdev->access_platform = ON_OFF_AUTO_ON;
> +    } else if (vdev->access_platform_auto) {
> +        virtio_clear_feature(&vdev->host_features, VIRTIO_F_IOMMU_PLATFORM);
> +        vdev->access_platform = ON_OFF_AUTO_OFF;
> +    }

If the consequences are so dire, we really should disallow adding a
device of IOMMU_PLATFORM off if pv is on.

(Can we disallow transition to pv if it is off? Maybe with the machine
property approach from the cross-arch patchset?)

>  
>      virtio_ccw_reset_virtio(dev, vdev);
>      if (vdc->parent_reset) {
> diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
> index b6c8ef5bc0..f6bd271f14 100644
> --- a/hw/virtio/virtio.c
> +++ b/hw/virtio/virtio.c
> @@ -3232,7 +3232,11 @@ void virtio_instance_init_common(Object *proxy_obj, void *data,
>  
>      object_initialize_child(proxy_obj, "virtio-backend", vdev, vdev_size,
>                              vdev_name, &error_abort, NULL);
> +    object_property_add_alias(OBJECT(vdev), "iommu_platform",
> +                              OBJECT(vdev), "access_platform", &error_abort);
>      qdev_alias_all_properties(vdev, proxy_obj);
> +    object_property_add_alias(proxy_obj, "iommu_platform",
> +                              OBJECT(vdev), "access_platform", &error_abort);
>  }
>  
>  void virtio_init(VirtIODevice *vdev, const char *name,
> @@ -3626,6 +3630,19 @@ static void virtio_device_realize(DeviceState *dev, Error **errp)
>          return;
>      }
>  
> +    switch (vdev->access_platform) {
> +    case ON_OFF_AUTO_ON:
> +        virtio_add_feature(&vdev->host_features, VIRTIO_F_IOMMU_PLATFORM);
> +        break;
> +    case ON_OFF_AUTO_AUTO:
> +        /* transport code can mange access_platform */
> +        vdev->access_platform_auto = true;

Can we really make that transport-specific? While ccw implies s390, pci
might be a variety of architectures.

> +        break;
> +    case ON_OFF_AUTO_OFF: /*fall through*/
> +    default:
> +        vdev->access_platform_auto = false;
> +    }
> +
>      vdev->listener.commit = virtio_memory_listener_commit;
>      memory_listener_register(&vdev->listener, vdev->dma_as);
>  }
> @@ -3681,6 +3698,8 @@ static Property virtio_properties[] = {
>      DEFINE_VIRTIO_COMMON_FEATURES(VirtIODevice, host_features),
>      DEFINE_PROP_BOOL("use-started", VirtIODevice, use_started, true),
>      DEFINE_PROP_BOOL("use-disabled-flag", VirtIODevice, use_disabled_flag, true),
> +    DEFINE_PROP_ON_OFF_AUTO("access_platform", VirtIODevice, access_platform,
> +                            ON_OFF_AUTO_AUTO),
>      DEFINE_PROP_END_OF_LIST(),
>  };
>  
> diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
> index b69d517496..b77e1545b4 100644
> --- a/include/hw/virtio/virtio.h
> +++ b/include/hw/virtio/virtio.h
> @@ -110,6 +110,8 @@ struct VirtIODevice
>      uint8_t device_endian;
>      bool use_guest_notifier_mask;
>      AddressSpace *dma_as;
> +    OnOffAuto access_platform;
> +    bool access_platform_auto;
>      QLIST_HEAD(, VirtQueue) *vector_queues;
>  };
>  
> @@ -289,8 +291,6 @@ typedef struct VirtIORNGConf VirtIORNGConf;
>                        VIRTIO_F_NOTIFY_ON_EMPTY, true), \
>      DEFINE_PROP_BIT64("any_layout", _state, _field, \
>                        VIRTIO_F_ANY_LAYOUT, true), \
> -    DEFINE_PROP_BIT64("iommu_platform", _state, _field, \
> -                      VIRTIO_F_IOMMU_PLATFORM, false), \

I'm wondering about migration compat.

>      DEFINE_PROP_BIT64("packed", _state, _field, \
>                        VIRTIO_F_RING_PACKED, false)
>  
> 
> base-commit: 0ffd3d64bd1bb8b84950e52159a0062fdab34628


