Return-Path: <SRS0=UKTp=CS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E9D7C43461
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 15:46:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D8EE6206B5
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 15:46:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LUuK1pzP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8EE6206B5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39860 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kG2IY-0000SO-MF
	for qemu-devel@archiver.kernel.org; Wed, 09 Sep 2020 11:46:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44972)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1kG2G1-0005Mw-MB
 for qemu-devel@nongnu.org; Wed, 09 Sep 2020 11:43:37 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:45136
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1kG2Fy-0000Ug-Ip
 for qemu-devel@nongnu.org; Wed, 09 Sep 2020 11:43:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599666213;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YOWgZB400EvLdsHgaP1Xa77HhkLdz12JGbF/vf9w+Vs=;
 b=LUuK1pzPT+fAoL7jS8y0R2kZqvCDgt08JBnViBahgfcJmI5QbKMkkyhboc3mthqyAuH/NB
 YzXGaDamu9gCUJG2DGh84A8DxuAhREhf6spdFdsxedAro9U2SANl+W23drixxR4jAJAg5w
 +Bdtb1RwFHDrpC4pCtOZnHY9JZuGS3Y=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-519-DG1JeP4eNtyZYm-7BSyRBw-1; Wed, 09 Sep 2020 11:43:32 -0400
X-MC-Unique: DG1JeP4eNtyZYm-7BSyRBw-1
Received: by mail-qk1-f198.google.com with SMTP id j5so1609557qka.7
 for <qemu-devel@nongnu.org>; Wed, 09 Sep 2020 08:43:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=YOWgZB400EvLdsHgaP1Xa77HhkLdz12JGbF/vf9w+Vs=;
 b=eGAvZ3ktNYvyb3Tc8nwJY/+VkpVz5wazY4BM9N+IeESo3d/nAuAclGtZUStW9fqQmt
 dsU2RU8cVKgg1M9MuNrbes/xW3D+YPcYJmppUqixMW5b5BQA9MhQwulxc1z7TF5oc0fS
 FHPGAk+ZuhcNagWx5I8meHpZybbE+5ta9FSVRDf1+6AdbBAFThmqbKhaGq4QYYvX9gSv
 k6ruNQ5fb90jZhQFzlyP1H1FZhGykGtj48hWVQRmX1NIZkoNlJpCoZCGRN2OhkQ/rMZM
 eH/g9YEalfQAX9lhNvFRyl26GrmW4nxFWd4iO0CsFlST3u5P5zdoYvRBPxk7Oy9u2Fs/
 KfcA==
X-Gm-Message-State: AOAM531j0xkeOxnTa+H+q/GyRyAmWUUPOxumdGvmNu1cZzdAMbbOJfGY
 sNffFuHWB/3UukFXFixKOgDyMccpsHs/mgew/bUMR53iKYELLDPoG7Q/ffPzFqKxLaO8qzAqkww
 g6dBaQsCHPSEmPNE=
X-Received: by 2002:a0c:aed5:: with SMTP id n21mr4844767qvd.20.1599666211621; 
 Wed, 09 Sep 2020 08:43:31 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxdv7VT0U9DCIoxKVg1Usmo5bVYlavMtuFeuBXx1DxqIH2Q3HBiMUCZpZ2YQ4JDR+vVw+WyUg==
X-Received: by 2002:a0c:aed5:: with SMTP id n21mr4844734qvd.20.1599666211280; 
 Wed, 09 Sep 2020 08:43:31 -0700 (PDT)
Received: from xz-x1 (bras-vprn-toroon474qw-lp130-11-70-53-122-15.dsl.bell.ca.
 [70.53.122.15])
 by smtp.gmail.com with ESMTPSA id c13sm3371565qtq.5.2020.09.09.08.43.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Sep 2020 08:43:30 -0700 (PDT)
Date: Wed, 9 Sep 2020 11:43:29 -0400
From: Peter Xu <peterx@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH] pci: advertise a page aligned ATS
Message-ID: <20200909154329.GB247092@xz-x1>
References: <20200909081731.24688-1-jasowang@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200909081731.24688-1-jasowang@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=peterx@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=peterx@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/09 03:05:47
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
Cc: eperezma@redhat.com, qemu-stable@nongnu.org, qemu-devel@nongnu.org,
 mst@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Sep 09, 2020 at 04:17:31PM +0800, Jason Wang wrote:
> After Linux kernel commit 61363c1474b1 ("iommu/vt-d: Enable ATS only
> if the device uses page aligned address."), ATS will be only enabled
> if device advertises a page aligned request.
> 
> Unfortunately, vhost-net is the only user and we don't advertise the
> aligned request capability in the past since both vhost IOTLB and
> address_space_get_iotlb_entry() can support non page aligned request.
> 
> Though it's not clear that if the above kernel commit makes
> sense. Let's advertise a page aligned ATS here to make vhost device
> IOTLB work with Intel IOMMU again.

IIUC the kernel commit should be needed because the VT-d Page Request
Descriptor used the rest bits of the address for other use (bits 11-0), so
logically an unaligned address can be mis-recognized with special meanings.
I'd guess some other archs (with its own IOMMU) might support unaligned
addresses and has different layout of page request descriptor, but not vt-d.

> 
> Note that in the future we may extend pcie_ats_init() to accept
> parameters like queue depth and page alignment.
> 
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Jason Wang <jasowang@redhat.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

Maybe it would be good too that vhost provides real 4k-aligned addresses (in
vhost_iotlb_miss)?  My understanding is that PCI_ATS_CAP_PAGE_ALIGNED will be
more compatible than without the bit set.  E.g., so far vt-d emulation always
cut the address with 4k no matter what iova was passed in.  However not sure
whether this will stop working with some new vIOMMUs joining.

Thanks,

-- 
Peter Xu


