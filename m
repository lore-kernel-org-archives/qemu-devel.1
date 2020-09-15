Return-Path: <SRS0=sZ46=CY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CA72C433E2
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 14:56:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A5724206E6
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 14:56:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZBgD4A9c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5724206E6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47214 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kICNQ-0003uI-Ma
	for qemu-devel@archiver.kernel.org; Tue, 15 Sep 2020 10:56:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35962)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1kICMb-0003HA-TE
 for qemu-devel@nongnu.org; Tue, 15 Sep 2020 10:55:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:49000)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1kICMY-0005UM-Iu
 for qemu-devel@nongnu.org; Tue, 15 Sep 2020 10:55:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600181717;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2EGm7JY2AcONtMHsj74+sxGbYEEmiFnm21akSM/x7vM=;
 b=ZBgD4A9cDbURN4VY2VeFvUdx1Xez1uYWVgBiCA3acu40/BQSdNnvhjxrsBNfQ3c4rv9QaD
 P4oK/qC0FNGib0vQkhr4TVv9rA3VrcMZHJv+JCjRvQ58Q02eAvoQFDdHiqP4/riegr+5Iy
 /HP9dE0HPgyPrvoszCGp0o+8eTVMJSI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-407-BFaPIokdNPWPazhPgb8gIg-1; Tue, 15 Sep 2020 10:55:14 -0400
X-MC-Unique: BFaPIokdNPWPazhPgb8gIg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 065C110AF410;
 Tue, 15 Sep 2020 14:50:39 +0000 (UTC)
Received: from gondolin (ovpn-115-4.ams2.redhat.com [10.36.115.4])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C033F78A89;
 Tue, 15 Sep 2020 14:50:36 +0000 (UTC)
Date: Tue, 15 Sep 2020 16:50:33 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: Matthew Rosato <mjrosato@linux.ibm.com>
Subject: Re: [PATCH v2 2/3] s390x/pci: Honor DMA limits set by vfio
Message-ID: <20200915165033.1ce30bd2.cohuck@redhat.com>
In-Reply-To: <2913a3f4-0c4e-14d2-9d8e-fda75e5defb4@linux.ibm.com>
References: <1600122570-12941-1-git-send-email-mjrosato@linux.ibm.com>
 <1600122570-12941-3-git-send-email-mjrosato@linux.ibm.com>
 <20200915132849.5e166b3e.cohuck@redhat.com>
 <2913a3f4-0c4e-14d2-9d8e-fda75e5defb4@linux.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=cohuck@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=cohuck@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/15 02:10:32
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

On Tue, 15 Sep 2020 10:16:23 -0400
Matthew Rosato <mjrosato@linux.ibm.com> wrote:

> On 9/15/20 7:28 AM, Cornelia Huck wrote:
> > On Mon, 14 Sep 2020 18:29:29 -0400
> > Matthew Rosato <mjrosato@linux.ibm.com> wrote:
> >   
> >> When an s390 guest is using lazy unmapping, it can result in a very
> >> large number of oustanding DMA requests, far beyond the default
> >> limit configured for vfio.  Let's track DMA usage similar to vfio
> >> in the host, and trigger the guest to flush their DMA mappings
> >> before vfio runs out.
> >>
> >> Signed-off-by: Matthew Rosato <mjrosato@linux.ibm.com>
> >> ---
> >>   hw/s390x/s390-pci-bus.c  | 99 +++++++++++++++++++++++++++++++++++++++++++++---
> >>   hw/s390x/s390-pci-bus.h  |  9 +++++
> >>   hw/s390x/s390-pci-inst.c | 29 +++++++++++---
> >>   hw/s390x/s390-pci-inst.h |  3 ++
> >>   4 files changed, 129 insertions(+), 11 deletions(-)
> >>  
> > 
> > (...)
> >   
> >> @@ -737,6 +742,82 @@ static void s390_pci_iommu_free(S390pciState *s, PCIBus *bus, int32_t devfn)
> >>       object_unref(OBJECT(iommu));
> >>   }
> >>   
> >> +static bool s390_sync_dma_avail(int fd, unsigned int *avail)  
> > 
> > Not sure I like the name. It sounds like the function checks whether
> > "sync dma" is available. Maybe s390_update_dma_avail()?
> >   
> 
> Sounds fine to me.
> 
> >> +{
> >> +    struct vfio_iommu_type1_info *info;
> >> +    uint32_t argsz;
> >> +    bool rval = false;
> >> +    int ret;
> >> +
> >> +    if (avail == NULL) {
> >> +        return false;
> >> +    }
> >> +
> >> +    argsz = sizeof(struct vfio_iommu_type1_info);
> >> +    info = g_malloc0(argsz);
> >> +    info->argsz = argsz;
> >> +    /*
> >> +     * If the specified argsz is not large enough to contain all
> >> +     * capabilities it will be updated upon return.  In this case
> >> +     * use the updated value to get the entire capability chain.
> >> +     */
> >> +    ret = ioctl(fd, VFIO_IOMMU_GET_INFO, info);
> >> +    if (argsz != info->argsz) {
> >> +        argsz = info->argsz;
> >> +        info = g_realloc(info, argsz);
> >> +        info->argsz = argsz;
> >> +        ret = ioctl(fd, VFIO_IOMMU_GET_INFO, info);
> >> +    }
> >> +
> >> +    if (ret) {
> >> +        goto out;
> >> +    }
> >> +
> >> +    /* If the capability exists, update with the current value */
> >> +    rval = vfio_get_info_dma_avail(info, avail);  
> > 
> > Adding vfio specific things into the generic s390 pci emulation code
> > looks a bit ugly... I'd prefer to factor that out into a separate file,
> > especially if you plan to add more vfio-specific things in the future.
> >   
> 
> Fair.   hw/s390x/s390-pci-vfio.* ?

Sounds good to me.


