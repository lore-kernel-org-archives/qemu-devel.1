Return-Path: <SRS0=huOX=VG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ADBBC606D5
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2019 03:54:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 263C9216C4
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2019 03:54:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 263C9216C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46454 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hkhDH-00071R-Ek
	for qemu-devel@archiver.kernel.org; Mon, 08 Jul 2019 23:54:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43127)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <zhexu@redhat.com>) id 1hkfnH-00025B-0m
 for qemu-devel@nongnu.org; Mon, 08 Jul 2019 22:23:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <zhexu@redhat.com>) id 1hkfnF-0007bm-Rh
 for qemu-devel@nongnu.org; Mon, 08 Jul 2019 22:23:46 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:46201)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <zhexu@redhat.com>) id 1hkfnF-0007bP-L0
 for qemu-devel@nongnu.org; Mon, 08 Jul 2019 22:23:45 -0400
Received: by mail-pl1-f195.google.com with SMTP id c2so7668943plz.13
 for <qemu-devel@nongnu.org>; Mon, 08 Jul 2019 19:23:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:date:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=FftJaRbYWHNa3kHaHykrZd5QPuju+ZHzp0iECf6zExs=;
 b=oCfQTvYUkc3vpyK5mEj5t5Ncx9JsPSMcdiJBUOHhIwuRTSx8YAUQy5QcsZLow2NM+H
 r1nKJhqcx4F/qbEQXqTzboBBlDJFedVPUwqJqaD1nq3LpIdKMDJAAPKmy0UnR9WqoRPB
 yxCUK86PugsHBZAk24SKV2+IEnW8xW+eIwOK8YV4u39ngMEvlUNY4et98ETAJISTtlQQ
 K7y2qcdl/alPmZOkJSFECd0HsUJb1mztUqjCqzF9s/bOERobdPFe1eBB0LQ3qbemObSz
 VYN3gh656Jkx8lpqAl/S6Z0Cvj5eaUBVp5OM1gqxeDu1i4LtQwU9BWQ9OnZUW88saxKv
 VrQQ==
X-Gm-Message-State: APjAAAWZ9KOaxLgY9g73sMceDvqjLS4s+O2uwBFws0LUmYJ29h+/nxuE
 GcHGRPUj6z4+tVCW5OHew0o3FA==
X-Google-Smtp-Source: APXvYqwzmKpI5EesOO0vk+59pI/520HJ89u6q7GGPvTwITw0dJNDabjnRhXuYY8/ZwR5FdtuFXypUQ==
X-Received: by 2002:a17:902:b944:: with SMTP id
 h4mr28322101pls.179.1562639024360; 
 Mon, 08 Jul 2019 19:23:44 -0700 (PDT)
Received: from xz-x1 ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id 30sm881340pjk.17.2019.07.08.19.23.39
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Mon, 08 Jul 2019 19:23:43 -0700 (PDT)
From: Peter Xu <zhexu@redhat.com>
X-Google-Original-From: Peter Xu <peterx@redhat.com>
Date: Tue, 9 Jul 2019 10:23:32 +0800
To: Liu Yi L <yi.l.liu@intel.com>
Message-ID: <20190709022332.GC5178@xz-x1>
References: <1562324511-2910-1-git-send-email-yi.l.liu@intel.com>
 <1562324511-2910-6-git-send-email-yi.l.liu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1562324511-2910-6-git-send-email-yi.l.liu@intel.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.214.195
X-Mailman-Approved-At: Mon, 08 Jul 2019 23:51:52 -0400
Subject: Re: [Qemu-devel] [RFC v1 05/18] vfio/pci: add pasid alloc/free
 implementation
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
Cc: tianyu.lan@intel.com, kevin.tian@intel.com,
 Jacob Pan <jacob.jun.pan@linux.intel.com>, Yi Sun <yi.y.sun@linux.intel.com>,
 kvm@vger.kernel.org, mst@redhat.com, jun.j.tian@intel.com,
 qemu-devel@nongnu.org, eric.auger@redhat.com, alex.williamson@redhat.com,
 pbonzini@redhat.com, yi.y.sun@intel.com, david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Jul 05, 2019 at 07:01:38PM +0800, Liu Yi L wrote:
> This patch adds vfio implementation PCIPASIDOps.alloc_pasid/free_pasid().
> These two functions are used to propagate guest pasid allocation and
> free requests to host via vfio container ioctl.
> 
> Cc: Kevin Tian <kevin.tian@intel.com>
> Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
> Cc: Peter Xu <peterx@redhat.com>
> Cc: Eric Auger <eric.auger@redhat.com>
> Cc: Yi Sun <yi.y.sun@linux.intel.com>
> Cc: David Gibson <david@gibson.dropbear.id.au>
> Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
> Signed-off-by: Yi Sun <yi.y.sun@linux.intel.com>
> ---
>  hw/vfio/pci.c | 61 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 61 insertions(+)
> 
> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index ce3fe96..ab184ad 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -2690,6 +2690,65 @@ static void vfio_unregister_req_notifier(VFIOPCIDevice *vdev)
>      vdev->req_enabled = false;
>  }
>  
> +static int vfio_pci_device_request_pasid_alloc(PCIBus *bus,
> +                                               int32_t devfn,
> +                                               uint32_t min_pasid,
> +                                               uint32_t max_pasid)
> +{
> +    PCIDevice *pdev = bus->devices[devfn];
> +    VFIOPCIDevice *vdev = DO_UPCAST(VFIOPCIDevice, pdev, pdev);
> +    VFIOContainer *container = vdev->vbasedev.group->container;
> +    struct vfio_iommu_type1_pasid_request req;
> +    unsigned long argsz;
> +    int pasid;
> +
> +    argsz = sizeof(req);
> +    req.argsz = argsz;
> +    req.flag = VFIO_IOMMU_PASID_ALLOC;
> +    req.min_pasid = min_pasid;
> +    req.max_pasid = max_pasid;
> +
> +    rcu_read_lock();

Could I ask what's this RCU lock protecting?

> +    pasid = ioctl(container->fd, VFIO_IOMMU_PASID_REQUEST, &req);
> +    if (pasid < 0) {
> +        error_report("vfio_pci_device_request_pasid_alloc:"
> +                     " request failed, contanier: %p", container);

Can use __func__, also since we're going to dump the error after all,
we can also include the errno (pasid) here which seems to be more
helpful than the container pointer at least to me. :)

> +    }
> +    rcu_read_unlock();
> +    return pasid;
> +}
> +
> +static int vfio_pci_device_request_pasid_free(PCIBus *bus,
> +                                              int32_t devfn,
> +                                              uint32_t pasid)
> +{
> +    PCIDevice *pdev = bus->devices[devfn];
> +    VFIOPCIDevice *vdev = DO_UPCAST(VFIOPCIDevice, pdev, pdev);
> +    VFIOContainer *container = vdev->vbasedev.group->container;
> +    struct vfio_iommu_type1_pasid_request req;
> +    unsigned long argsz;
> +    int ret = 0;
> +
> +    argsz = sizeof(req);
> +    req.argsz = argsz;
> +    req.flag = VFIO_IOMMU_PASID_FREE;
> +    req.pasid = pasid;
> +
> +    rcu_read_lock();
> +    ret = ioctl(container->fd, VFIO_IOMMU_PASID_REQUEST, &req);
> +    if (ret != 0) {
> +        error_report("vfio_pci_device_request_pasid_free:"
> +                     " request failed, contanier: %p", container);
> +    }
> +    rcu_read_unlock();
> +    return ret;
> +}
> +
> +static PCIPASIDOps vfio_pci_pasid_ops = {
> +    .alloc_pasid = vfio_pci_device_request_pasid_alloc,
> +    .free_pasid = vfio_pci_device_request_pasid_free,
> +};
> +
>  static void vfio_realize(PCIDevice *pdev, Error **errp)
>  {
>      VFIOPCIDevice *vdev = PCI_VFIO(pdev);
> @@ -2991,6 +3050,8 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
>      vfio_register_req_notifier(vdev);
>      vfio_setup_resetfn_quirk(vdev);
>  
> +    pci_setup_pasid_ops(pdev, &vfio_pci_pasid_ops);
> +
>      return;
>  
>  out_teardown:
> -- 
> 2.7.4
> 

Regards,

-- 
Peter Xu

