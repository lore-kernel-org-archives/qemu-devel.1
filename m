Return-Path: <SRS0=sZ46=CY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E977BC43461
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 13:07:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 67AB720684
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 13:07:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LlexGVik"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67AB720684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54018 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIAgA-0007XZ-Ez
	for qemu-devel@archiver.kernel.org; Tue, 15 Sep 2020 09:07:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57930)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kIAUP-0001YP-EH
 for qemu-devel@nongnu.org; Tue, 15 Sep 2020 08:55:17 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:54754
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kIAUL-0004yl-JS
 for qemu-devel@nongnu.org; Tue, 15 Sep 2020 08:55:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600174511;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XenKRFXMCMemmYBxy6DJC7TEKcFssMfYO5ijTrmNJog=;
 b=LlexGVik8i7OgAMJycjUf88CsQON2R1sRSG9VKRlAfvAgUBq7z1+Y+NuiALt0ehl3xoB51
 6sVjWVoK6YoasBHnQWmkiEgEmUW+4+8r23yOMyEsOUHrQavsLm0KaoQRw8PvwI0xTS25G8
 0gWN1guy/+uzIpFrH0iC7S03TRkagzk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-424-Lo4ZbOusNe23YtSRZUQmLw-1; Tue, 15 Sep 2020 08:55:07 -0400
X-MC-Unique: Lo4ZbOusNe23YtSRZUQmLw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A479D425CD;
 Tue, 15 Sep 2020 12:55:05 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-112-174.ams2.redhat.com [10.36.112.174])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0C4CD5DC17;
 Tue, 15 Sep 2020 12:54:56 +0000 (UTC)
Subject: Re: [PATCH v2 2/3] s390x/pci: Honor DMA limits set by vfio
To: Matthew Rosato <mjrosato@linux.ibm.com>, alex.williamson@redhat.com,
 cohuck@redhat.com
References: <1600122570-12941-1-git-send-email-mjrosato@linux.ibm.com>
 <1600122570-12941-3-git-send-email-mjrosato@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <6d835b47-5935-8eb7-f0f7-d81f0cec4028@redhat.com>
Date: Tue, 15 Sep 2020 14:54:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <1600122570-12941-3-git-send-email-mjrosato@linux.ibm.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=thuth@redhat.com
X-Mimecast-Spam-Score: 0.003
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Received-SPF: pass client-ip=205.139.110.61; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/15 03:21:13
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.999,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: pmorel@linux.ibm.com, schnelle@linux.ibm.com, david@redhat.com,
 qemu-devel@nongnu.org, pasic@linux.ibm.com, borntraeger@de.ibm.com,
 qemu-s390x@nongnu.org, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 15/09/2020 00.29, Matthew Rosato wrote:
> When an s390 guest is using lazy unmapping, it can result in a very
> large number of oustanding DMA requests, far beyond the default
> limit configured for vfio.  Let's track DMA usage similar to vfio
> in the host, and trigger the guest to flush their DMA mappings
> before vfio runs out.
> 
> Signed-off-by: Matthew Rosato <mjrosato@linux.ibm.com>
> ---
>  hw/s390x/s390-pci-bus.c  | 99 +++++++++++++++++++++++++++++++++++++++++++++---
>  hw/s390x/s390-pci-bus.h  |  9 +++++
>  hw/s390x/s390-pci-inst.c | 29 +++++++++++---
>  hw/s390x/s390-pci-inst.h |  3 ++
>  4 files changed, 129 insertions(+), 11 deletions(-)
> 
> diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
> index 92146a2..23474cd 100644
> --- a/hw/s390x/s390-pci-bus.c
> +++ b/hw/s390x/s390-pci-bus.c
> @@ -11,6 +11,8 @@
>   * directory.
>   */
>  
> +#include <sys/ioctl.h>
> +
>  #include "qemu/osdep.h"
>  #include "qapi/error.h"
>  #include "qapi/visitor.h"
> @@ -24,6 +26,9 @@
>  #include "qemu/error-report.h"
>  #include "qemu/module.h"
>  
> +#include "hw/vfio/pci.h"
> +#include "hw/vfio/vfio-common.h"
> +
>  #ifndef DEBUG_S390PCI_BUS
>  #define DEBUG_S390PCI_BUS  0
>  #endif
> @@ -737,6 +742,82 @@ static void s390_pci_iommu_free(S390pciState *s, PCIBus *bus, int32_t devfn)
>      object_unref(OBJECT(iommu));
>  }
>  
> +static bool s390_sync_dma_avail(int fd, unsigned int *avail)
> +{
> +    struct vfio_iommu_type1_info *info;

You could use g_autofree to get rid of the g_free() at the end.

> +    uint32_t argsz;
> +    bool rval = false;
> +    int ret;
> +
> +    if (avail == NULL) {
> +        return false;
> +    }

Since this is a "static" local function, and calling it with avail ==
NULL does not make too much sense, I think I'd rather turn this into an
assert() instead.

> +    argsz = sizeof(struct vfio_iommu_type1_info);
> +    info = g_malloc0(argsz);
> +    info->argsz = argsz;
> +    /*
> +     * If the specified argsz is not large enough to contain all
> +     * capabilities it will be updated upon return.  In this case
> +     * use the updated value to get the entire capability chain.
> +     */
> +    ret = ioctl(fd, VFIO_IOMMU_GET_INFO, info);
> +    if (argsz != info->argsz) {
> +        argsz = info->argsz;
> +        info = g_realloc(info, argsz);
> +        info->argsz = argsz;
> +        ret = ioctl(fd, VFIO_IOMMU_GET_INFO, info);
> +    }
> +
> +    if (ret) {
> +        goto out;
> +    }
> +
> +    /* If the capability exists, update with the current value */
> +    rval = vfio_get_info_dma_avail(info, avail);
> +
> +out:
> +    g_free(info);
> +    return rval;
> +}
> +
> +static S390PCIDMACount *s390_start_dma_count(S390pciState *s, VFIODevice *vdev)
> +{
> +    int id = vdev->group->container->fd;
> +    S390PCIDMACount *cnt;
> +    uint32_t avail;
> +
> +    if (!s390_sync_dma_avail(id, &avail)) {
> +        return NULL;
> +    }
> +
> +    QTAILQ_FOREACH(cnt, &s->zpci_dma_limit, link) {
> +        if (cnt->id  == id) {
> +            cnt->users++;
> +            return cnt;
> +        }
> +    }
> +
> +    cnt = g_new0(S390PCIDMACount, 1);
> +    cnt->id = id;
> +    cnt->users = 1;
> +    cnt->avail = avail;
> +    QTAILQ_INSERT_TAIL(&s->zpci_dma_limit, cnt, link);
> +    return cnt;
> +}
> +
> +static void s390_end_dma_count(S390pciState *s, S390PCIDMACount *cnt)
> +{
> +    if (cnt == NULL) {
> +        return;
> +    }

Either use assert() or drop this completely (since you're checking it at
the caller site already).

> +    cnt->users--;
> +    if (cnt->users == 0) {
> +        QTAILQ_REMOVE(&s->zpci_dma_limit, cnt, link);
> +    }
> +}
> +
>  static void s390_pcihost_realize(DeviceState *dev, Error **errp)
>  {
>      PCIBus *b;
> @@ -764,6 +845,7 @@ static void s390_pcihost_realize(DeviceState *dev, Error **errp)
>      s->bus_no = 0;
>      QTAILQ_INIT(&s->pending_sei);
>      QTAILQ_INIT(&s->zpci_devs);
> +    QTAILQ_INIT(&s->zpci_dma_limit);
>  
>      css_register_io_adapters(CSS_IO_ADAPTER_PCI, true, false,
>                               S390_ADAPTER_SUPPRESSIBLE, errp);
> @@ -902,6 +984,7 @@ static void s390_pcihost_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
>  {
>      S390pciState *s = S390_PCI_HOST_BRIDGE(hotplug_dev);
>      PCIDevice *pdev = NULL;
> +    VFIOPCIDevice *vpdev = NULL;
>      S390PCIBusDevice *pbdev = NULL;
>  
>      if (object_dynamic_cast(OBJECT(dev), TYPE_PCI_BRIDGE)) {
> @@ -941,17 +1024,20 @@ static void s390_pcihost_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
>              }
>          }
>  
> +        pbdev->pdev = pdev;
> +        pbdev->iommu = s390_pci_get_iommu(s, pci_get_bus(pdev), pdev->devfn);
> +        pbdev->iommu->pbdev = pbdev;
> +        pbdev->state = ZPCI_FS_DISABLED;
> +
>          if (object_dynamic_cast(OBJECT(dev), "vfio-pci")) {
>              pbdev->fh |= FH_SHM_VFIO;
> +            vpdev = container_of(pbdev->pdev, VFIOPCIDevice, pdev);
> +            pbdev->iommu->dma_limit = s390_start_dma_count(s,
> +                                                           &vpdev->vbasedev);
>          } else {
>              pbdev->fh |= FH_SHM_EMUL;
>          }
>  
> -        pbdev->pdev = pdev;
> -        pbdev->iommu = s390_pci_get_iommu(s, pci_get_bus(pdev), pdev->devfn);
> -        pbdev->iommu->pbdev = pbdev;
> -        pbdev->state = ZPCI_FS_DISABLED;
> -
>          if (s390_pci_msix_init(pbdev)) {
>              error_setg(errp, "MSI-X support is mandatory "
>                         "in the S390 architecture");
> @@ -1004,6 +1090,9 @@ static void s390_pcihost_unplug(HotplugHandler *hotplug_dev, DeviceState *dev,
>          pbdev->fid = 0;
>          QTAILQ_REMOVE(&s->zpci_devs, pbdev, link);
>          g_hash_table_remove(s->zpci_table, &pbdev->idx);
> +        if (pbdev->iommu->dma_limit) {
> +            s390_end_dma_count(s, pbdev->iommu->dma_limit);
> +        }
>          qdev_unrealize(dev);
>      }
>  }

 Thomas


