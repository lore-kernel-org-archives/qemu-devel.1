Return-Path: <SRS0=q+n2=EF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB7D7C4363A
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 10:26:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 49B2220825
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 10:26:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZLLu7+GR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49B2220825
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39496 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kYRc8-0007O2-3K
	for qemu-devel@archiver.kernel.org; Fri, 30 Oct 2020 06:26:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47596)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kYRaG-0005pQ-64
 for qemu-devel@nongnu.org; Fri, 30 Oct 2020 06:24:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:57205)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kYRaD-0000OZ-Ey
 for qemu-devel@nongnu.org; Fri, 30 Oct 2020 06:24:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604053471;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pJroRI8ps8IUlPjGlc42O7It0H8JWG0P0n+w0T4XOQc=;
 b=ZLLu7+GR+J0KWsaocsSYT2DOp7qEvyMJNjgnZfBBc/AxNtKM8Hzvf4AaVsDlnN6bFn7dnv
 nnvqJAmf5GF77ubkWoO0raKJAzepC1oGfPecM4W/CbX/yoUxsYLfP+1rVgbmPdMcda+aDd
 ud6YK8tEZ1FEC9xyjkxP5ik1FZKK/YU=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-322-9iQPFUJGNMmw6vkwivB5uw-1; Fri, 30 Oct 2020 06:24:29 -0400
X-MC-Unique: 9iQPFUJGNMmw6vkwivB5uw-1
Received: by mail-wm1-f72.google.com with SMTP id t201so1081063wmt.1
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2020 03:24:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=pJroRI8ps8IUlPjGlc42O7It0H8JWG0P0n+w0T4XOQc=;
 b=pRWdJIDo++85GG+rN2mu3YcGWqxg9ETPJtdwpiWQFSCkOCCaSl1ZTxeH5q/OOUfyWy
 ZYGpdnlqAEI3ppkGma95v8ASOsSXf5Re31tVAJUkKf/CXx1HWH5AxOWpY/d5PudcNQMr
 IRktpL7PNl5jX63ND2I1GTpMm2uBpTPqunByUJ4+uKYmgccIEmL/hpvXy6bh/91oD4V6
 Pb0JwYVbd9EYyHSo7pIuA6YIIoR3a5Qt8Ztw38DVnJSBh1bO8D0gjIaKtWb2YkSbhLW6
 qYzItpaThIskh2MCrv1bLhgdBHbGLIETFSok7m/VVZ8sXe4Thi3iamGsi3JdbxdGIYBo
 Jbxg==
X-Gm-Message-State: AOAM533kIHCeXRl83S0xeybKMOQ2yW5JRKtedsLmjXYO//W+aWsPBDGB
 TBorrGV9qGu9FbgqYgb/Oz/NIKKgM33sBLCkcdbcXQv2tt8anRJaFPUFthAX961dKIqvwWDGUl/
 uKrvyb4d1e1PmYBY=
X-Received: by 2002:adf:b7c8:: with SMTP id t8mr2227801wre.143.1604053468532; 
 Fri, 30 Oct 2020 03:24:28 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyq3Ax9Zr9hHurHTF77LJbSDQdagpOCc+HZDAOlIlgvcjQr69jYu9cjGTsUHd/ezOm6nCr8bQ==
X-Received: by 2002:adf:b7c8:: with SMTP id t8mr2227779wre.143.1604053468300; 
 Fri, 30 Oct 2020 03:24:28 -0700 (PDT)
Received: from redhat.com (bzq-79-176-118-93.red.bezeqint.net. [79.176.118.93])
 by smtp.gmail.com with ESMTPSA id j9sm6668719wrr.49.2020.10.30.03.24.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Oct 2020 03:24:27 -0700 (PDT)
Date: Fri, 30 Oct 2020 06:24:24 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: Re: [PATCH v10 09/10] virtio-iommu: Set supported page size mask
Message-ID: <20201030062403-mutt-send-email-mst@kernel.org>
References: <20201008171558.410886-1-jean-philippe@linaro.org>
 <20201008171558.410886-10-jean-philippe@linaro.org>
 <20201019213539.GC3203@xz-x1> <20201022163937.GB1808268@myrica>
 <20201022205616.GD3208@xz-x1> <20201023074858.GA2265982@myrica>
 <20201023164702.GF3208@xz-x1> <20201027173840.GA2320704@myrica>
MIME-Version: 1.0
In-Reply-To: <20201027173840.GA2320704@myrica>
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
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>, eric.auger@redhat.com,
 alex.williamson@redhat.com, pbonzini@redhat.com, bbhushan2@marvell.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Oct 27, 2020 at 06:38:40PM +0100, Jean-Philippe Brucker wrote:
> On Fri, Oct 23, 2020 at 12:47:02PM -0400, Peter Xu wrote:
> > On Fri, Oct 23, 2020 at 09:48:58AM +0200, Jean-Philippe Brucker wrote:
> > > Arm CPUs and SMMU support 4k, 16k and 64k page sizes. I don't think 16k is
> > > used anywhere but some distributions chose 64k (RHEL, I think?), others
> > > 4k, so we need to support both.
> > > 
> > > Unfortunately as noted above host64k-guest4k is not possible without
> > > adding a negotiation mechanism to virtio-iommu, host VFIO and IOMMU
> > > driver.
> > 
> > I see.  Then it seems we would still need to support host4k-guest64k.
> > 
> > Maybe for assigned case, we can simply AND all the psize_masks of all the vfio
> > containers that supported to replace the default psize mask (TARGET_PAGE_SIZE)
> > without caring about whether it's shrinking or not?  Note that current patch
> > only update config.psize_mask to the new one, but I think we need to calculate
> > the subset of all containers rather than a simply update.
> 
> Yes I think an AND is the right operation. We'll return an error if the
> resulting mask is 0. Then for hotplug, I think I'll keep the current "best
> effort" code from this patch. If necessary we could later add a parameter
> to set a default mask and guarantee hotplug success.
> 
> Thanks,
> Jean


So I should expect a new version with that?

> > Then with the help
> > of 39b3b3c9cac1 imho we'll gracefully fail the probe if the psize is not
> > suitable anyway, e.g., host64k-guest4k.
> > 
> > Thanks,
> > 
> > -- 
> > Peter Xu
> > 


