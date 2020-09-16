Return-Path: <SRS0=+YCa=CZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2834EC43461
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 11:06:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 103CD20838
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 11:06:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JiJWWFjS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 103CD20838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50948 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIVGY-0004Sb-1N
	for qemu-devel@archiver.kernel.org; Wed, 16 Sep 2020 07:06:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43028)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1kIVG0-00040z-Q9
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 07:05:48 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:38899
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1kIVFy-0002CZ-Ap
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 07:05:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600254344;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZLmHQQTvYZ1vyzqk0TBru3JZL4lsKVfVuFbc/jCl0b0=;
 b=JiJWWFjSkPfvcV72RlPGCCx8bMOPPO3V+l+4dhPh9DVqLN4BRx5fGOnHV3qlMkV4fWfKky
 jfFYBIZJPoYpM8XiVIFKXYC5L2xgauWWgc8RyOtIb0t9L/zGTsyIfP+bFRY10AVG10orz7
 hobfOjimAbYt9J/kRM0vdZG8dtp/1T8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-364-XOPxXcRAN1KoDzSHz7IBQQ-1; Wed, 16 Sep 2020 07:05:42 -0400
X-MC-Unique: XOPxXcRAN1KoDzSHz7IBQQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5300080EF84;
 Wed, 16 Sep 2020 11:05:41 +0000 (UTC)
Received: from gondolin (ovpn-112-252.ams2.redhat.com [10.36.112.252])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7815F5FC36;
 Wed, 16 Sep 2020 11:05:27 +0000 (UTC)
Date: Wed, 16 Sep 2020 13:05:24 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: Matthew Rosato <mjrosato@linux.ibm.com>
Subject: Re: [PATCH v3 5/5] s390x/pci: Honor DMA limits set by vfio
Message-ID: <20200916130524.48e11b26.cohuck@redhat.com>
In-Reply-To: <1600197283-25274-6-git-send-email-mjrosato@linux.ibm.com>
References: <1600197283-25274-1-git-send-email-mjrosato@linux.ibm.com>
 <1600197283-25274-6-git-send-email-mjrosato@linux.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Received-SPF: pass client-ip=205.139.110.61; envelope-from=cohuck@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/16 00:53:39
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.999,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: thuth@redhat.com, kvm@vger.kernel.org, pmorel@linux.ibm.com,
 david@redhat.com, schnelle@linux.ibm.com, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org, pasic@linux.ibm.com, borntraeger@de.ibm.com,
 alex.williamson@redhat.com, mst@redhat.com, pbonzini@redhat.com,
 rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 15 Sep 2020 15:14:43 -0400
Matthew Rosato <mjrosato@linux.ibm.com> wrote:

> When an s390 guest is using lazy unmapping, it can result in a very
> large number of oustanding DMA requests, far beyond the default
> limit configured for vfio.  Let's track DMA usage similar to vfio
> in the host, and trigger the guest to flush their DMA mappings
> before vfio runs out.
> 
> Signed-off-by: Matthew Rosato <mjrosato@linux.ibm.com>
> ---
>  hw/s390x/s390-pci-bus.c  | 56 +++++++++++++++++++++++++++++++++++++++++++-----
>  hw/s390x/s390-pci-bus.h  |  9 ++++++++
>  hw/s390x/s390-pci-inst.c | 34 +++++++++++++++++++++++------
>  hw/s390x/s390-pci-inst.h |  3 +++
>  4 files changed, 91 insertions(+), 11 deletions(-)

(...)

> @@ -737,6 +740,41 @@ static void s390_pci_iommu_free(S390pciState *s, PCIBus *bus, int32_t devfn)
>      object_unref(OBJECT(iommu));
>  }
>  
> +static S390PCIDMACount *s390_start_dma_count(S390pciState *s, VFIODevice *vdev)

Should these go into the new vfio-related file?

> +{
> +    int id = vdev->group->container->fd;
> +    S390PCIDMACount *cnt;
> +    uint32_t avail;
> +
> +    if (!s390_pci_update_dma_avail(id, &avail)) {
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
> +    assert(cnt);
> +
> +    cnt->users--;
> +    if (cnt->users == 0) {
> +        QTAILQ_REMOVE(&s->zpci_dma_limit, cnt, link);
> +    }
> +}
> +
>  static void s390_pcihost_realize(DeviceState *dev, Error **errp)
>  {
>      PCIBus *b;
> @@ -764,6 +802,7 @@ static void s390_pcihost_realize(DeviceState *dev, Error **errp)
>      s->bus_no = 0;
>      QTAILQ_INIT(&s->pending_sei);
>      QTAILQ_INIT(&s->zpci_devs);
> +    QTAILQ_INIT(&s->zpci_dma_limit);
>  
>      css_register_io_adapters(CSS_IO_ADAPTER_PCI, true, false,
>                               S390_ADAPTER_SUPPRESSIBLE, errp);
> @@ -902,6 +941,7 @@ static void s390_pcihost_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
>  {
>      S390pciState *s = S390_PCI_HOST_BRIDGE(hotplug_dev);
>      PCIDevice *pdev = NULL;
> +    VFIOPCIDevice *vpdev = NULL;
>      S390PCIBusDevice *pbdev = NULL;
>  
>      if (object_dynamic_cast(OBJECT(dev), TYPE_PCI_BRIDGE)) {
> @@ -941,17 +981,20 @@ static void s390_pcihost_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
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

I think you can just pass s and pbdev to that function... that would
move dealing with vfio specifics from this file.

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

(...)

> diff --git a/hw/s390x/s390-pci-inst.c b/hw/s390x/s390-pci-inst.c
> index 2f7a7d7..cc34b17 100644
> --- a/hw/s390x/s390-pci-inst.c
> +++ b/hw/s390x/s390-pci-inst.c
> @@ -32,6 +32,9 @@
>          }                                                          \
>      } while (0)
>  
> +#define inc_dma_avail(iommu) if (iommu->dma_limit) iommu->dma_limit->avail++;

I was thinking more of something like

static inline void inc_dma_avail(S390PCIIOMMU *iommu)
{
    if (iommu->dma_limit) {
        iommu->dma_limit->avail++;
    }
}

> +#define dec_dma_avail(iommu) if (iommu->dma_limit) iommu->dma_limit->avail--;
> +
>  static void s390_set_status_code(CPUS390XState *env,
>                                   uint8_t r, uint64_t status_code)
>  {

(...)


