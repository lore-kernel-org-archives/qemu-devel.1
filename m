Return-Path: <SRS0=sZ46=CY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43181C43461
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 14:38:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9775B206B5
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 14:38:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JNQPNNQS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9775B206B5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58518 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIC6e-0001e4-8S
	for qemu-devel@archiver.kernel.org; Tue, 15 Sep 2020 10:38:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59926)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1kIC5v-0000mG-R6
 for qemu-devel@nongnu.org; Tue, 15 Sep 2020 10:38:07 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:25765
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1kIC5t-0003DA-7a
 for qemu-devel@nongnu.org; Tue, 15 Sep 2020 10:38:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600180684;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lQA8J5/lzvIjgSMZTN88Nk3iYiZ4825mk9TOmyK+Du4=;
 b=JNQPNNQSh0YyRnspnCC08iBWZ1xcIbj43GlKp8GzNcOdBviNFpmafusnZ8COqNm0lvdg9t
 7lRiFyaTKNqzxyN/jsIB1QF5yMKrYYISTomxU3m/kg5eo0dzs4TUdg0tftToLZ3wRAzy2y
 SL8bEfyLD3nKv6vMxmIe8VZWgUh1igQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-320-btKNaCezPuuJ6Q577VTIwA-1; Tue, 15 Sep 2020 10:38:00 -0400
X-MC-Unique: btKNaCezPuuJ6Q577VTIwA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2F431100A27B;
 Tue, 15 Sep 2020 14:37:43 +0000 (UTC)
Received: from gondolin (ovpn-115-4.ams2.redhat.com [10.36.115.4])
 by smtp.corp.redhat.com (Postfix) with ESMTP id BB9C760BE2;
 Tue, 15 Sep 2020 14:37:40 +0000 (UTC)
Date: Tue, 15 Sep 2020 16:37:38 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: Matthew Rosato <mjrosato@linux.ibm.com>
Subject: Re: [PATCH v2 1/3] vfio: Find DMA available capability
Message-ID: <20200915163738.7eea5d23.cohuck@redhat.com>
In-Reply-To: <d07e2247-b2bf-1014-5b22-00b7f58fc821@linux.ibm.com>
References: <1600122570-12941-1-git-send-email-mjrosato@linux.ibm.com>
 <1600122570-12941-2-git-send-email-mjrosato@linux.ibm.com>
 <20200915123302.64b26031.cohuck@redhat.com>
 <d07e2247-b2bf-1014-5b22-00b7f58fc821@linux.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=cohuck@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=cohuck@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/15 03:21:13
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.999,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, 15 Sep 2020 09:57:03 -0400
Matthew Rosato <mjrosato@linux.ibm.com> wrote:

> On 9/15/20 6:33 AM, Cornelia Huck wrote:
> > On Mon, 14 Sep 2020 18:29:28 -0400
> > Matthew Rosato <mjrosato@linux.ibm.com> wrote:
> >   
> >> The underlying host may be limiting the number of outstanding DMA
> >> requests for type 1 IOMMU.  Add helper functions to check for the
> >> DMA available capability and retrieve the current number of DMA
> >> mappings allowed.
> >>
> >> Signed-off-by: Matthew Rosato <mjrosato@linux.ibm.com>
> >> ---
> >>   hw/vfio/common.c              | 37 +++++++++++++++++++++++++++++++++++++
> >>   include/hw/vfio/vfio-common.h |  2 ++
> >>   2 files changed, 39 insertions(+)
> >>  
> > 
> > (...)
> >   
> >> +bool vfio_get_info_dma_avail(struct vfio_iommu_type1_info *info,
> >> +                             unsigned int *avail)
> >> +{
> >> +    struct vfio_info_cap_header *hdr;
> >> +    struct vfio_iommu_type1_info_dma_avail *cap;
> >> +
> >> +    /* If the capability cannot be found, assume no DMA limiting */
> >> +    hdr = vfio_get_iommu_type1_info_cap(info,
> >> +                                        VFIO_IOMMU_TYPE1_INFO_DMA_AVAIL);  
> > 
> > ...don't you need a headers sync first to get the new definitions?
> >   
> 
> You are right of course, though the associated header change is not yet 
> merged in the kernel so it's a bit flaky.  But bottom line:  yes, we 
> need a header sync first, I'll include one in v3.

Just include a placeholder patch :) It's easy to replace them with a
real update prior to merging.


