Return-Path: <SRS0=CoOB=7C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6FABC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 16:24:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 44B7C20709
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 16:24:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GjtsdKJY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44B7C20709
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60160 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbRW3-0007PS-9o
	for qemu-devel@archiver.kernel.org; Wed, 20 May 2020 12:24:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46726)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jbRVL-0006d4-52
 for qemu-devel@nongnu.org; Wed, 20 May 2020 12:23:40 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:51077
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jbRVH-0000Bi-ST
 for qemu-devel@nongnu.org; Wed, 20 May 2020 12:23:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589991815;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ISWxH4LiqG89wb128+eRHPTTqAZy01zcxk/F/kKELE0=;
 b=GjtsdKJYHie1GDHLG4enFE5q+bCAejMTxw5Uxj6+5THQis4bSK8zhRhVyxMrlY4dE2n1FZ
 81G8oKEixHS19iF1guazZv/BM7wNBGoKtglW1hl2KuLaFfuP7KlOoPMZhBvrtwUOW0tC/o
 9mjlXbP0QmmYjIaTzH5BCmSg8cJp5/M=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-405-O8lGJdXFOQ2_nwui958dig-1; Wed, 20 May 2020 12:23:29 -0400
X-MC-Unique: O8lGJdXFOQ2_nwui958dig-1
Received: by mail-wm1-f69.google.com with SMTP id f62so1468741wme.3
 for <qemu-devel@nongnu.org>; Wed, 20 May 2020 09:23:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=ISWxH4LiqG89wb128+eRHPTTqAZy01zcxk/F/kKELE0=;
 b=SVMQGSTw1DPPRk5xfOqSLupakIEH6I1w+KKw1EzM+YPKtCts+YB/g0LtbOJ0cCklWj
 wQD1s5yUhO4FJ8dnEObXSHclCpWMDqHbM2WsRlT4lb4RnTxgNx2lyjO1KTOjh5NnrHmj
 6poHHNdrtFkVqgXlX3ZgLU5VfBITvkreBe+hk37LsdZd4PpjzaonNSUcDk9lLFAY8kQ3
 9FePryf/0GZQ1VcM7GW0xFk2Sl44QUOjk19ZyVe2XbNxInNpfgvPbmEiD8+N8VpBqveY
 07uhwIeBXc1PH622HRWp/0+1CGtrFCNqOecLed9Kq8iJ43layXxACwiAQxKwP7JQ3yGC
 4xIQ==
X-Gm-Message-State: AOAM533jM87jMR8IEdSToCig146QEU9lTFNjrGY9groKzd0DsWTBy2uB
 TzHZpNlVJ8JA4sTFank2BZ7vvKPeVwUs/2tUd0zsUGD/k4jPjQBA1JrnKBiqWDZBbR7k9xwz/WT
 5oa5l/o7YasNn2SE=
X-Received: by 2002:a1c:a912:: with SMTP id s18mr5585263wme.55.1589991808284; 
 Wed, 20 May 2020 09:23:28 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxR3pb9222Q4G2K7mSsApbAygAFx4rT/AZMw4ixeTrFhHwTwdC3AkV1NwrYkuWbVUj9lpSGLg==
X-Received: by 2002:a1c:a912:: with SMTP id s18mr5585237wme.55.1589991807998; 
 Wed, 20 May 2020 09:23:27 -0700 (PDT)
Received: from redhat.com (bzq-109-64-41-91.red.bezeqint.net. [109.64.41.91])
 by smtp.gmail.com with ESMTPSA id
 q144sm3744009wme.0.2020.05.20.09.23.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 May 2020 09:23:27 -0700 (PDT)
Date: Wed, 20 May 2020 12:23:24 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [PATCH v2 1/1] virtio-ccw: auto-manage VIRTIO_F_IOMMU_PLATFORM
 if PV
Message-ID: <20200520121507-mutt-send-email-mst@kernel.org>
References: <20200514221155.32079-1-pasic@linux.ibm.com>
MIME-Version: 1.0
In-Reply-To: <20200514221155.32079-1-pasic@linux.ibm.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/20 04:09:34
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
 David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 qemu-devel@nongnu.org, Christian Borntraeger <borntraeger@de.ibm.com>,
 qemu-s390x@nongnu.org, Viktor Mihajlovski <mihajlov@linux.ibm.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, May 15, 2020 at 12:11:55AM +0200, Halil Pasic wrote:
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

So, how about this: switch iommu to on/off/auto.  Add a property with a
reasonable name "allow protected"?  If set allow switch to protected
memory and also set iommu auto to on by default.  If not set then don't.

This will come handy for other things like migrating to hosts without
protected memory support.


Also, virtio now calls this PLATFORM_ACCESS, maybe we should rename
the property (keeping old one around for compat)?
I feel this will address lots of complaints ...

> Currently presenting a PV guest with a (paravirtualized) virtio-ccw
> device has catastrophic consequences for the VM (after the hypervisors
> access to protected memory). This is especially grave in case of device
> hotplug (because in this case the guest is more likely to be in the
> middle of something important).
> 
> Let us manage the VIRTIO_F_ACCESS_PLATFORM virtio feature automatically
> for virtio-ccw devices, i.e. force it before we start the protected VM.
> If the VM should cease to be protected, the original value is restored.
> 
> Signed-off-by: Halil Pasic <pasic@linux.ibm.com>


I don't really understand things fully but it looks like you are
changing features of a device.  If so this bothers me, resets
happen at random times while driver is active, and we never
expect features to change.


> ---
> 
> NOTES:
> 
> * Doing more system_resets() is a big hack.  We should look into this.
> * The user interface implications of this patch are also an ugly can of
> worms. We need to discuss them.
> 
> 
> v1 --> v2:
> * Use the default or user supplied iommu_on flag when when !PV
> * Use virtio functions for feature manipulation
> 
> Link to v1:
> https://www.mail-archive.com/qemu-devel@nongnu.org/msg683775.html
> 
> Unfortunately the v1 did not see much discussion because we had more
> pressing issues.
> 
> ---
>  hw/s390x/s390-virtio-ccw.c |  2 ++
>  hw/s390x/virtio-ccw.c      | 14 ++++++++++++++
>  hw/s390x/virtio-ccw.h      |  1 +
>  3 files changed, 17 insertions(+)
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
> index 64f928fc7d..67d5bc68ba 100644
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
> +    if (ms->pv && !virtio_host_has_feature(vdev, VIRTIO_F_IOMMU_PLATFORM)) {
> +        virtio_add_feature(&vdev->host_features, VIRTIO_F_IOMMU_PLATFORM);
> +        dev->forced_iommu_platform = true;
> +    } else if (!ms->pv && dev->forced_iommu_platform) {
> +        virtio_clear_feature(&vdev->host_features, VIRTIO_F_IOMMU_PLATFORM);
> +        dev->forced_iommu_platform = false;
> +    }
>  
>      virtio_ccw_reset_virtio(dev, vdev);
>      if (vdc->parent_reset) {
> diff --git a/hw/s390x/virtio-ccw.h b/hw/s390x/virtio-ccw.h
> index 3453aa1f98..34ff7b0b4e 100644
> --- a/hw/s390x/virtio-ccw.h
> +++ b/hw/s390x/virtio-ccw.h
> @@ -99,6 +99,7 @@ struct VirtioCcwDevice {
>      IndAddr *summary_indicator;
>      uint64_t ind_bit;
>      bool force_revision_1;
> +    bool forced_iommu_platform;
>  };
>  
>  /* The maximum virtio revision we support. */
> 

This seems unused. Why is it helpful?


> base-commit: 0ffd3d64bd1bb8b84950e52159a0062fdab34628
> -- 
> 2.17.1


