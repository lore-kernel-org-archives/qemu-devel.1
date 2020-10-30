Return-Path: <SRS0=q+n2=EF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49EFBC4363A
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 10:31:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 83889221EB
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 10:31:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U0Aim9/g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83889221EB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53832 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kYRgT-0005Dl-AE
	for qemu-devel@archiver.kernel.org; Fri, 30 Oct 2020 06:31:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48120)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kYRbR-0006kP-DN
 for qemu-devel@nongnu.org; Fri, 30 Oct 2020 06:25:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:55037)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kYRbK-0000wc-Hk
 for qemu-devel@nongnu.org; Fri, 30 Oct 2020 06:25:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604053540;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uaGHpAHWD9ks3LIGz6RmBK3NueQAckz5y8aJ7EJEjBM=;
 b=U0Aim9/gyxrPVSr2mNUY4gdDolQK2PATyCpM95iNkpMABLcxus81MbMNVqeI7RO8wiNTfY
 zkH7rFW63S2f/yErEmSQK4llCOw3DpqYk80yrBGwdyztgqrbWZmjbSsrHndnQ4rFgqgswe
 4J9zlCQCS9y9WrF/CtI9xAXGgcs3cGg=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-346-CHuLpMIjPPKDE3_CCb9vAQ-1; Fri, 30 Oct 2020 06:25:39 -0400
X-MC-Unique: CHuLpMIjPPKDE3_CCb9vAQ-1
Received: by mail-wm1-f70.google.com with SMTP id y21so212441wmi.7
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2020 03:25:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=uaGHpAHWD9ks3LIGz6RmBK3NueQAckz5y8aJ7EJEjBM=;
 b=sQ505DR8rhtYM/KgDkJpTmwlZu3OcUU8p1ia5eqpTIiOre3njUR44CZjSju4zI1RRe
 oTWk48c93hJ0IxfiPpZp5iJkxJFVjpPJds351T64JKzBizT9shQVmhlAZTiMYgZl0GNH
 7q2250QzLJ7ZhSlok8j+0hUbbp00SqV5qr/a33cTAqBOKkgTOCcLfwGfrK3LOFH+QuvU
 oG0veGNhx5qjU811Q2zmAUGk8+LDIqY4nTUQ01aeQK5oyq2wPJ3He0KOdWj5zCvenYJH
 pepAMoFFTcFzn+NK3Jp6a2w6UmxOP3eTCjCZAHELBnMbqNZP0qa5zy0AWvNcXdjW0S5Y
 DYEw==
X-Gm-Message-State: AOAM533yhrwWzD8Ou+Cd8QYYnRsFROCoJYZL9UxZr8uLM9zRl3ifgyVA
 9ktkG9gYeXD3oNIv9hUNVzSnyraYuZm9OLfzZz53bvDtacsU7Zr6TDDXxSY512BGGllcAIcDQ6B
 razCglBaEuDLrSkg=
X-Received: by 2002:a05:600c:21c3:: with SMTP id
 x3mr1778333wmj.81.1604053537924; 
 Fri, 30 Oct 2020 03:25:37 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyv8idjCn+87HbLck06YrZ/BCI/HEvDHlj+svaumUO0S76mmcHejsxWmgtg++1PsDZdWehxBw==
X-Received: by 2002:a05:600c:21c3:: with SMTP id
 x3mr1778313wmj.81.1604053537702; 
 Fri, 30 Oct 2020 03:25:37 -0700 (PDT)
Received: from redhat.com (bzq-79-176-118-93.red.bezeqint.net. [79.176.118.93])
 by smtp.gmail.com with ESMTPSA id 26sm4167218wmk.42.2020.10.30.03.25.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Oct 2020 03:25:36 -0700 (PDT)
Date: Fri, 30 Oct 2020 06:25:34 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH v10 10/10] vfio: Don't issue full 2^64 unmap
Message-ID: <20201030062513-mutt-send-email-mst@kernel.org>
References: <20201008171558.410886-1-jean-philippe@linaro.org>
 <20201008171558.410886-11-jean-philippe@linaro.org>
 <20201008152214.3cb1425b@w520.home>
MIME-Version: 1.0
In-Reply-To: <20201008152214.3cb1425b@w520.home>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/30 01:22:25
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>, qemu-devel@nongnu.org,
 peterx@redhat.com, eric.auger@redhat.com, pbonzini@redhat.com,
 bbhushan2@marvell.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Oct 08, 2020 at 03:22:14PM -0600, Alex Williamson wrote:
> On Thu,  8 Oct 2020 19:15:58 +0200
> Jean-Philippe Brucker <jean-philippe@linaro.org> wrote:
> 
> > IOMMUs may declare memory regions spanning from 0 to UINT64_MAX. When
> > attempting to deal with such region, vfio_listener_region_del() passes a
> > size of 2^64 to int128_get64() which throws an assertion failure.  Even
> > ignoring this, the VFIO_IOMMU_DMA_MAP ioctl cannot handle this size
> > since the size field is 64-bit. Split the request in two.
> > 
> > Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> > ---
> > For me this happens when memory_region_iommu_set_page_size_mask()
> > returns an error because a hotplugged endpoint uses an incompatible page
> > mask. vfio_connect_container() releases the memory listener which calls
> > region_del() with the 2^64 IOMMU region. There are probably other ways
> > to reach this.
> > ---
> >  hw/vfio/common.c | 11 +++++++++++
> >  1 file changed, 11 insertions(+)
> > 
> > diff --git a/hw/vfio/common.c b/hw/vfio/common.c
> > index e66054b02a7..e90a89c389e 100644
> > --- a/hw/vfio/common.c
> > +++ b/hw/vfio/common.c
> > @@ -797,6 +797,17 @@ static void vfio_listener_region_del(MemoryListener *listener,
> >      }
> >  
> >      if (try_unmap) {
> > +        if (llsize == int128_2_64()) {
> > +            /* The unmap ioctl doesn't accept a full 64-bit span. */
> > +            llsize = int128_rshift(llsize, 1);
> > +            ret = vfio_dma_unmap(container, iova, int128_get64(llsize));
> > +            if (ret) {
> > +                error_report("vfio_dma_unmap(%p, 0x%"HWADDR_PRIx", "
> > +                             "0x%"HWADDR_PRIx") = %d (%m)",
> > +                             container, iova, int128_get64(llsize), ret);
> > +            }
> > +            iova += int128_get64(llsize);
> > +        }
> >          ret = vfio_dma_unmap(container, iova, int128_get64(llsize));
> >          if (ret) {
> >              error_report("vfio_dma_unmap(%p, 0x%"HWADDR_PRIx", "
> 
> We're still susceptible that splitting the range in two could result in
> unmap calls that attempt to bisect a mapping that spans both ranges.
> Both unmap calls would fail in that case.  I think we could solve this
> more completely with a high water marker, but this probably good enough
> for now.
> 
> Acked-by: Alex Williamson <alex.williamson@redhat.com>


Are you merging this then?
If yes

Acked-by: Michael S. Tsirkin <mst@redhat.com>


