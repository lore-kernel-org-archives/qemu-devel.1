Return-Path: <SRS0=Jh9c=W4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1093BC3A5A4
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Sep 2019 09:31:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C704F22CE9
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Sep 2019 09:31:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="K4oysQY8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C704F22CE9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56165 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i4MD9-0001eb-OF
	for qemu-devel@archiver.kernel.org; Sun, 01 Sep 2019 05:31:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34310)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <yuval.shaia@oracle.com>) id 1i4MC2-0000lm-42
 for qemu-devel@nongnu.org; Sun, 01 Sep 2019 05:30:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <yuval.shaia@oracle.com>) id 1i4MC0-0003tV-C8
 for qemu-devel@nongnu.org; Sun, 01 Sep 2019 05:30:41 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:52706)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <yuval.shaia@oracle.com>)
 id 1i4MC0-0003sG-4C
 for qemu-devel@nongnu.org; Sun, 01 Sep 2019 05:30:40 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
 by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x819UZSo098236;
 Sun, 1 Sep 2019 09:30:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=kRctL7kyWho7Ld1HvorjlKYH+CPP9VWbvNbwgbXD/zI=;
 b=K4oysQY8mScaVE9nsKgR/gxJ41gHOtRm7aboRYcmNKgwLdoHnB1cr4NBR/CuJZ3Mbk2d
 OM3UsO4zUQ8PfUWZdERFhvyi7DbP/jJSx5xHSMbJAlXEJ6I/PjjnFdYlHswB39CjTDEv
 vdpOcEVu0l19oCVDsj4EPUgpKhgHX61azIkKzK3kHanNMTlLHzG4dZ/NdEtuuHneqdVR
 q9f+u6RiMzqA1lpsNdCPOgvIY4IIxYFQ60UiJXREsRGWU4ndDfXPujeiRKXox1AyqFiI
 hvO2CW4FEiIS45vGhKgMOprfvdqkG3AS5BD889zTgqFNdK1pCpveBP9LlBAgZHRlpAD5 WQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
 by userp2120.oracle.com with ESMTP id 2urbdv8005-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sun, 01 Sep 2019 09:30:35 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
 by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x819SL4Y135432;
 Sun, 1 Sep 2019 09:30:34 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
 by aserp3020.oracle.com with ESMTP id 2uqgqjjqdd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sun, 01 Sep 2019 09:30:34 +0000
Received: from abhmp0022.oracle.com (abhmp0022.oracle.com [141.146.116.28])
 by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x819UYwE024802;
 Sun, 1 Sep 2019 09:30:34 GMT
Received: from lap1 (/77.138.183.59) by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Sun, 01 Sep 2019 02:30:33 -0700
Date: Sun, 1 Sep 2019 12:30:29 +0300
From: Yuval Shaia <yuval.shaia@oracle.com>
To: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Message-ID: <20190901093028.GB16041@lap1>
References: <20190818132107.18181-1-yuval.shaia@oracle.com>
 <20190818132107.18181-3-yuval.shaia@oracle.com>
 <9ede18f4-641c-aef4-cedf-830fd52a02ec@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9ede18f4-641c-aef4-cedf-830fd52a02ec@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9366
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1909010111
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9366
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1909010111
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 156.151.31.85
Subject: Re: [Qemu-devel] [PATCH 2/2] hw/rdma: Utilize ibv_reg_mr_iova for
 memory registration
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
Cc: thuth@redhat.com, berrange@redhat.com, qemu-devel@nongnu.org,
 laurent@vivier.eu, pbonzini@redhat.com, philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, Aug 31, 2019 at 10:31:57PM +0300, Marcel Apfelbaum wrote:
> Hi Yuval,
> 
> On 8/18/19 4:21 PM, Yuval Shaia wrote:
> > The virtual address that is provided by the guest in post_send and
> > post_recv operations is related to the guest address space. This address
> > space is unknown to the HCA resides on host so extra step in these
> > operations is needed to adjust the address to host virtual address.
> > 
> > This step, which is done in data-path affects performances.
> > 
> > An enhanced verion of MR registration introduced here
> > https://patchwork.kernel.org/patch/11044467/ can be used so that the
> > guest virtual address space for this MR is known to the HCA in host.
> > 
> > This will save the data-path adjustment.
> > 
> > Signed-off-by: Yuval Shaia <yuval.shaia@oracle.com>
> > ---
> >   hw/rdma/rdma_backend.c    | 13 +++++++++++++
> >   hw/rdma/rdma_backend.h    |  5 +++++
> >   hw/rdma/rdma_rm.c         |  5 +++++
> >   hw/rdma/vmw/pvrdma_main.c |  6 ++++++
> >   4 files changed, 29 insertions(+)
> > 
> > diff --git a/hw/rdma/rdma_backend.c b/hw/rdma/rdma_backend.c
> > index c39051068d..c346407cd3 100644
> > --- a/hw/rdma/rdma_backend.c
> > +++ b/hw/rdma/rdma_backend.c
> > @@ -391,7 +391,11 @@ static int build_host_sge_array(RdmaDeviceResources *rdma_dev_res,
> >               return VENDOR_ERR_INVLKEY | ssge[ssge_idx].lkey;
> >           }
> > +#ifdef LEGACY_RDMA_REG_MR
> >           dsge->addr = (uintptr_t)mr->virt + ssge[ssge_idx].addr - mr->start;
> 
> This is the performance hit you are addressing? The address computation?

This is the support for legacy library, see below the enhancement.

> 
> Thanks,
> Marcel
> 
> 
> > +#else
> > +        dsge->addr = ssge[ssge_idx].addr;

Here it is, no need to adjust to host virtual address.

Please note also that this is a huge step toward virtio-rdma support where
the emulation will be bypassed in data path so no chance for address
adjustment.

> > +#endif
> >           dsge->length = ssge[ssge_idx].length;
> >           dsge->lkey = rdma_backend_mr_lkey(&mr->backend_mr);
> > @@ -735,10 +739,19 @@ void rdma_backend_destroy_pd(RdmaBackendPD *pd)
> >       }
> >   }
> > +#ifdef LEGACY_RDMA_REG_MR
> >   int rdma_backend_create_mr(RdmaBackendMR *mr, RdmaBackendPD *pd, void *addr,
> >                              size_t length, int access)
> > +#else
> > +int rdma_backend_create_mr(RdmaBackendMR *mr, RdmaBackendPD *pd, void *addr,
> > +                           size_t length, uint64_t guest_start, int access)
> > +#endif
> >   {
> > +#ifdef LEGACY_RDMA_REG_MR
> >       mr->ibmr = ibv_reg_mr(pd->ibpd, addr, length, access);
> > +#else
> > +    mr->ibmr = ibv_reg_mr_iova(pd->ibpd, addr, length, guest_start, access);
> > +#endif
> >       if (!mr->ibmr) {
> >           rdma_error_report("ibv_reg_mr fail, errno=%d", errno);
> >           return -EIO;
> > diff --git a/hw/rdma/rdma_backend.h b/hw/rdma/rdma_backend.h
> > index 7c1a19a2b5..127f96e2d5 100644
> > --- a/hw/rdma/rdma_backend.h
> > +++ b/hw/rdma/rdma_backend.h
> > @@ -78,8 +78,13 @@ int rdma_backend_query_port(RdmaBackendDev *backend_dev,
> >   int rdma_backend_create_pd(RdmaBackendDev *backend_dev, RdmaBackendPD *pd);
> >   void rdma_backend_destroy_pd(RdmaBackendPD *pd);
> > +#ifdef LEGACY_RDMA_REG_MR
> >   int rdma_backend_create_mr(RdmaBackendMR *mr, RdmaBackendPD *pd, void *addr,
> >                              size_t length, int access);
> > +#else
> > +int rdma_backend_create_mr(RdmaBackendMR *mr, RdmaBackendPD *pd, void *addr,
> > +                           size_t length, uint64_t guest_start, int access);
> > +#endif
> >   void rdma_backend_destroy_mr(RdmaBackendMR *mr);
> >   int rdma_backend_create_cq(RdmaBackendDev *backend_dev, RdmaBackendCQ *cq,
> > diff --git a/hw/rdma/rdma_rm.c b/hw/rdma/rdma_rm.c
> > index 1927f85472..1524dfaeaa 100644
> > --- a/hw/rdma/rdma_rm.c
> > +++ b/hw/rdma/rdma_rm.c
> > @@ -227,8 +227,13 @@ int rdma_rm_alloc_mr(RdmaDeviceResources *dev_res, uint32_t pd_handle,
> >           mr->length = guest_length;
> >           mr->virt += (mr->start & (TARGET_PAGE_SIZE - 1));
> > +#ifdef LEGACY_RDMA_REG_MR
> >           ret = rdma_backend_create_mr(&mr->backend_mr, &pd->backend_pd, mr->virt,
> >                                        mr->length, access_flags);
> > +#else
> > +        ret = rdma_backend_create_mr(&mr->backend_mr, &pd->backend_pd, mr->virt,
> > +                                     mr->length, guest_start, access_flags);
> > +#endif
> >           if (ret) {
> >               ret = -EIO;
> >               goto out_dealloc_mr;
> > diff --git a/hw/rdma/vmw/pvrdma_main.c b/hw/rdma/vmw/pvrdma_main.c
> > index 3e36e13013..18075285f6 100644
> > --- a/hw/rdma/vmw/pvrdma_main.c
> > +++ b/hw/rdma/vmw/pvrdma_main.c
> > @@ -664,6 +664,12 @@ static void pvrdma_realize(PCIDevice *pdev, Error **errp)
> >       dev->shutdown_notifier.notify = pvrdma_shutdown_notifier;
> >       qemu_register_shutdown_notifier(&dev->shutdown_notifier);
> > +#ifdef LEGACY_RDMA_REG_MR
> > +    rdma_info_report("Using legacy reg_mr");
> > +#else
> > +    rdma_info_report("Using iova reg_mr");
> > +#endif
> > +
> >   out:
> >       if (rc) {
> >           pvrdma_fini(pdev);
> 
> 

