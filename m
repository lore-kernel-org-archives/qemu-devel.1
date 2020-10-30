Return-Path: <SRS0=q+n2=EF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24E0FC00A89
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 17:27:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6F7562054F
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 17:27:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GqCHo2I2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F7562054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40950 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kYYBS-0000kB-Cq
	for qemu-devel@archiver.kernel.org; Fri, 30 Oct 2020 13:27:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37468)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1kYYAj-0000J3-EA
 for qemu-devel@nongnu.org; Fri, 30 Oct 2020 13:26:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:28006)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1kYYAg-000092-VD
 for qemu-devel@nongnu.org; Fri, 30 Oct 2020 13:26:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604078796;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=roZrPnl1INrRuJyLo1/YIMl7H7YGYBq3tyapZkS/r1A=;
 b=GqCHo2I2D/qMP8zL/tvF38DZpV9bz3q+47ShpydTlEcfG+0SdDoRWZRDx2ia1iDvK55Aj+
 pFEJtCKJHraSwPocqr75rWd1mfKJJmn5FG3u9QlrsN8BrXrkSOk/MrY+KLGKc7/ii+PijQ
 0I8jC6R6SGeGFKLMziVYiRyDWeIgLis=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-209-ov-OaBe2OSm8Fn6satgm4Q-1; Fri, 30 Oct 2020 13:26:32 -0400
X-MC-Unique: ov-OaBe2OSm8Fn6satgm4Q-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 90BF310066FD;
 Fri, 30 Oct 2020 17:26:31 +0000 (UTC)
Received: from w520.home (ovpn-112-213.phx2.redhat.com [10.3.112.213])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4F7E55C1CF;
 Fri, 30 Oct 2020 17:26:22 +0000 (UTC)
Date: Fri, 30 Oct 2020 11:26:22 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v10 10/10] vfio: Don't issue full 2^64 unmap
Message-ID: <20201030112622.0edaa660@w520.home>
In-Reply-To: <20201030062513-mutt-send-email-mst@kernel.org>
References: <20201008171558.410886-1-jean-philippe@linaro.org>
 <20201008171558.410886-11-jean-philippe@linaro.org>
 <20201008152214.3cb1425b@w520.home>
 <20201030062513-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=alex.williamson@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=216.205.24.124;
 envelope-from=alex.williamson@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/30 02:24:40
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>, qemu-devel@nongnu.org,
 peterx@redhat.com, eric.auger@redhat.com, pbonzini@redhat.com,
 bbhushan2@marvell.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 30 Oct 2020 06:25:34 -0400
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> On Thu, Oct 08, 2020 at 03:22:14PM -0600, Alex Williamson wrote:
> > On Thu,  8 Oct 2020 19:15:58 +0200
> > Jean-Philippe Brucker <jean-philippe@linaro.org> wrote:
> >   
> > > IOMMUs may declare memory regions spanning from 0 to UINT64_MAX. When
> > > attempting to deal with such region, vfio_listener_region_del() passes a
> > > size of 2^64 to int128_get64() which throws an assertion failure.  Even
> > > ignoring this, the VFIO_IOMMU_DMA_MAP ioctl cannot handle this size
> > > since the size field is 64-bit. Split the request in two.
> > > 
> > > Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> > > ---
> > > For me this happens when memory_region_iommu_set_page_size_mask()
> > > returns an error because a hotplugged endpoint uses an incompatible page
> > > mask. vfio_connect_container() releases the memory listener which calls
> > > region_del() with the 2^64 IOMMU region. There are probably other ways
> > > to reach this.
> > > ---
> > >  hw/vfio/common.c | 11 +++++++++++
> > >  1 file changed, 11 insertions(+)
> > > 
> > > diff --git a/hw/vfio/common.c b/hw/vfio/common.c
> > > index e66054b02a7..e90a89c389e 100644
> > > --- a/hw/vfio/common.c
> > > +++ b/hw/vfio/common.c
> > > @@ -797,6 +797,17 @@ static void vfio_listener_region_del(MemoryListener *listener,
> > >      }
> > >  
> > >      if (try_unmap) {
> > > +        if (llsize == int128_2_64()) {
> > > +            /* The unmap ioctl doesn't accept a full 64-bit span. */
> > > +            llsize = int128_rshift(llsize, 1);
> > > +            ret = vfio_dma_unmap(container, iova, int128_get64(llsize));
> > > +            if (ret) {
> > > +                error_report("vfio_dma_unmap(%p, 0x%"HWADDR_PRIx", "
> > > +                             "0x%"HWADDR_PRIx") = %d (%m)",
> > > +                             container, iova, int128_get64(llsize), ret);
> > > +            }
> > > +            iova += int128_get64(llsize);
> > > +        }
> > >          ret = vfio_dma_unmap(container, iova, int128_get64(llsize));
> > >          if (ret) {
> > >              error_report("vfio_dma_unmap(%p, 0x%"HWADDR_PRIx", "  
> > 
> > We're still susceptible that splitting the range in two could result in
> > unmap calls that attempt to bisect a mapping that spans both ranges.
> > Both unmap calls would fail in that case.  I think we could solve this
> > more completely with a high water marker, but this probably good enough
> > for now.
> > 
> > Acked-by: Alex Williamson <alex.williamson@redhat.com>  
> 
> 
> Are you merging this then?
> If yes
> 
> Acked-by: Michael S. Tsirkin <mst@redhat.com>
> 

No, the series is focused on virtio-iommu therefore I assumed you or
Eric would merge it, thus I provided an Ack.  Thanks,

Alex


