Return-Path: <SRS0=sZ46=CY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07B05C43461
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 11:32:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4875820872
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 11:32:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b1Qq1paq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4875820872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46908 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kI9CT-0007sv-4K
	for qemu-devel@archiver.kernel.org; Tue, 15 Sep 2020 07:32:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34112)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1kI993-0005se-Nd
 for qemu-devel@nongnu.org; Tue, 15 Sep 2020 07:29:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:26975)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1kI990-0001Vz-TN
 for qemu-devel@nongnu.org; Tue, 15 Sep 2020 07:29:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600169344;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vFYXj3FZJso3DY0L/q/LPATkoPH742Rkb8735oLaAbg=;
 b=b1Qq1paqy7LiL/xyuLDoLRUA/QiknMCuZFFgYp/59WVjXncbmE0JGcr+rDZKLbhh93Ucin
 ZEGJOQ7rXRX/5JOdnkwpJi4BeOs/EfL2fXd4EfO6BxuPc1NYKCNiNRL/h76QJkX0cAUM+g
 qdtQyrSl/FVp0cSxgup8UUEmOPIOwrI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-558-lsVxycozOJOiGfmRn2vkLw-1; Tue, 15 Sep 2020 07:29:02 -0400
X-MC-Unique: lsVxycozOJOiGfmRn2vkLw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C0B1710BBED1;
 Tue, 15 Sep 2020 11:29:00 +0000 (UTC)
Received: from gondolin (ovpn-113-4.ams2.redhat.com [10.36.113.4])
 by smtp.corp.redhat.com (Postfix) with ESMTP id AB5D6100239F;
 Tue, 15 Sep 2020 11:28:52 +0000 (UTC)
Date: Tue, 15 Sep 2020 13:28:49 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: Matthew Rosato <mjrosato@linux.ibm.com>
Subject: Re: [PATCH v2 2/3] s390x/pci: Honor DMA limits set by vfio
Message-ID: <20200915132849.5e166b3e.cohuck@redhat.com>
In-Reply-To: <1600122570-12941-3-git-send-email-mjrosato@linux.ibm.com>
References: <1600122570-12941-1-git-send-email-mjrosato@linux.ibm.com>
 <1600122570-12941-3-git-send-email-mjrosato@linux.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=cohuck@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=cohuck@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/15 02:23:19
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.999,
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
Cc: thuth@redhat.com, pmorel@linux.ibm.com, david@redhat.com,
 schnelle@linux.ibm.com, qemu-s390x@nongnu.org, qemu-devel@nongnu.org,
 pasic@linux.ibm.com, borntraeger@de.ibm.com, alex.williamson@redhat.com,
 rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 14 Sep 2020 18:29:29 -0400
Matthew Rosato <mjrosato@linux.ibm.com> wrote:

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

(...)

> @@ -737,6 +742,82 @@ static void s390_pci_iommu_free(S390pciState *s, PCIBus *bus, int32_t devfn)
>      object_unref(OBJECT(iommu));
>  }
>  
> +static bool s390_sync_dma_avail(int fd, unsigned int *avail)

Not sure I like the name. It sounds like the function checks whether
"sync dma" is available. Maybe s390_update_dma_avail()?

> +{
> +    struct vfio_iommu_type1_info *info;
> +    uint32_t argsz;
> +    bool rval = false;
> +    int ret;
> +
> +    if (avail == NULL) {
> +        return false;
> +    }
> +
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

Adding vfio specific things into the generic s390 pci emulation code
looks a bit ugly... I'd prefer to factor that out into a separate file,
especially if you plan to add more vfio-specific things in the future.

> +
> +out:
> +    g_free(info);
> +    return rval;
> +}
> +

(...)

> diff --git a/hw/s390x/s390-pci-inst.c b/hw/s390x/s390-pci-inst.c
> index 2f7a7d7..6af9af4 100644
> --- a/hw/s390x/s390-pci-inst.c
> +++ b/hw/s390x/s390-pci-inst.c
> @@ -32,6 +32,9 @@
>          }                                                          \
>      } while (0)
>  
> +#define INC_DMA_AVAIL(iommu) if (iommu->dma_limit) iommu->dma_limit->avail++;
> +#define DEC_DMA_AVAIL(iommu) if (iommu->dma_limit) iommu->dma_limit->avail--;

Hm... maybe lowercase inline functions might be better here?

> +
>  static void s390_set_status_code(CPUS390XState *env,
>                                   uint8_t r, uint64_t status_code)
>  {

(...)

> @@ -620,6 +629,7 @@ int rpcit_service_call(S390CPU *cpu, uint8_t r1, uint8_t r2, uintptr_t ra)
>      S390PCIIOMMU *iommu;
>      S390IOTLBEntry entry;
>      hwaddr start, end;
> +    uint32_t dma_avail;
>  
>      if (env->psw.mask & PSW_MASK_PSTATE) {
>          s390_program_interrupt(env, PGM_PRIVILEGED, ra);
> @@ -675,8 +685,9 @@ int rpcit_service_call(S390CPU *cpu, uint8_t r1, uint8_t r2, uintptr_t ra)
>          }
>  
>          start += entry.len;
> -        while (entry.iova < start && entry.iova < end) {
> -            s390_pci_update_iotlb(iommu, &entry);
> +        dma_avail = 1; /* Assume non-zero dma_avail to start */
> +        while (entry.iova < start && entry.iova < end && dma_avail > 0) {
> +            dma_avail = s390_pci_update_iotlb(iommu, &entry);
>              entry.iova += PAGE_SIZE;
>              entry.translated_addr += PAGE_SIZE;
>          }
> @@ -689,7 +700,13 @@ err:
>          s390_pci_generate_error_event(error, pbdev->fh, pbdev->fid, start, 0);
>      } else {
>          pbdev->fmb.counter[ZPCI_FMB_CNT_RPCIT]++;
> -        setcc(cpu, ZPCI_PCI_LS_OK);
> +        if (dma_avail > 0) {

When I compile this (with a headers update), the compiler moans here
about an uninitialized variable.

> +            setcc(cpu, ZPCI_PCI_LS_OK);
> +        } else {
> +            /* vfio DMA mappings are exhausted, trigger a RPCIT */
> +            setcc(cpu, ZPCI_PCI_LS_ERR);
> +            s390_set_status_code(env, r1, ZPCI_RPCIT_ST_INSUFF_RES);
> +        }
>      }
>      return 0;
>  }

(...)


