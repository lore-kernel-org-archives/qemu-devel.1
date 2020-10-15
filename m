Return-Path: <SRS0=muvY=DW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AB7AC43457
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 13:12:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7701B2225C
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 13:12:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XQuhhL6U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7701B2225C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52784 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kT33D-0002S5-Go
	for qemu-devel@archiver.kernel.org; Thu, 15 Oct 2020 09:12:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44974)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kT32G-0001Ta-Jd
 for qemu-devel@nongnu.org; Thu, 15 Oct 2020 09:11:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:55304)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kT32E-00057Z-0C
 for qemu-devel@nongnu.org; Thu, 15 Oct 2020 09:11:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602767469;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TIgtWUpzFpRlyvSHToxxj8ouZk4VU/ehys1Xg3bQTX8=;
 b=XQuhhL6U4GVPG1UcRxqeJQEAMMTOfUNMTjy3Y90zzxcSju2cssK7zGfZA2APVPrBqbyii5
 Zst9ZpuyG301ZyN9GDF4py0Yr846WBJOA3BjomrjV4TU891BZ43u9mL2d7qSCG6Gnx4fqY
 trREOZv2XEQIkyp1c19L1A5Gy8euRIc=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-570-m1EecQ8VOYShD_P8gvVQCA-1; Thu, 15 Oct 2020 09:11:07 -0400
X-MC-Unique: m1EecQ8VOYShD_P8gvVQCA-1
Received: by mail-wr1-f71.google.com with SMTP id b11so1888000wrm.3
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2020 06:11:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=TIgtWUpzFpRlyvSHToxxj8ouZk4VU/ehys1Xg3bQTX8=;
 b=Sn/S6GD6vrVmg+jU+JJfvx/Pnum9sfkFVX5hiFoJA1g8yBXmuEtJDCvHMBHWzOWe9r
 2lOWKwZtu/sk5D0H4ZVsVIaaqbpvKWlMPuskdK35jh8qtjs4hjFxVvcCYtqPbYAhKQqa
 aQ/w9wdATdDCi3WJOI1pnltqJhuMbEUo+/KYZa0eL9scZDu+kui/9Oqa6ZeJw8kSsCBK
 o2bVz+F8dqPc56WG3rTXCraLNgZKNpTXZPvOj+s5DECNYtaPFIhUCEFEdXo5QFhmgaPQ
 Ilkm3Eb+NUjWpY/H81wO6AEyLgUNIbwmHvPywAlyZ9im9vva+kPjyRi8xQlDXLwNkAst
 kEqg==
X-Gm-Message-State: AOAM530mjTIyNi66VmIqzv9Ipvo1Dm3Bd/uyOZaPy79DgIv72OoxgyW6
 JjzGHlfe3CPPNUi/rg9uuaVjxmoGaXhk+GvnUeW4VCvTt/FGkLlLmdr0UMYvmVI0MN5ZeHdQQ7y
 6ou6gGtkOQcQU0SU=
X-Received: by 2002:a1c:c28a:: with SMTP id s132mr4205681wmf.13.1602767465873; 
 Thu, 15 Oct 2020 06:11:05 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwYm3s+rsipyLfIxBKe+hA4w84HlWILFVpKIX9R8kaZE6OcIuc5iIBK3aoXrzYoy3+4E1UCvg==
X-Received: by 2002:a1c:c28a:: with SMTP id s132mr4205662wmf.13.1602767465701; 
 Thu, 15 Oct 2020 06:11:05 -0700 (PDT)
Received: from redhat.com (bzq-79-176-118-93.red.bezeqint.net. [79.176.118.93])
 by smtp.gmail.com with ESMTPSA id d3sm2864419wrb.66.2020.10.15.06.11.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Oct 2020 06:11:05 -0700 (PDT)
Date: Thu, 15 Oct 2020 09:11:02 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH] vhost-vdpa: negotiate VIRTIO_NET_F_STATUS with driver
Message-ID: <20201015091056-mutt-send-email-mst@kernel.org>
References: <1601582985-14944-1-git-send-email-si-wei.liu@oracle.com>
 <a0326690-31c1-60b3-b31e-99b1e6571c52@redhat.com>
MIME-Version: 1.0
In-Reply-To: <a0326690-31c1-60b3-b31e-99b1e6571c52@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/15 02:10:02
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Si-Wei Liu <si-wei.liu@oracle.com>, joao.m.martins@oracle.com,
 qemu-devel@nongnu.org, boris.ostrovsky@oracle.com, qemu-stable@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Oct 15, 2020 at 03:24:29PM +0800, Jason Wang wrote:
> 
> On 2020/10/2 上午4:09, Si-Wei Liu wrote:
> > Vendor driver may not support or implement config
> > interrupt delivery for link status notifications.
> > In this event, vendor driver is expected to NACK
> > the feature, but guest will keep link always up.
> > 
> > Signed-off-by: Si-Wei Liu <si-wei.liu@oracle.com>
> > ---
> >   net/vhost-vdpa.c | 1 +
> >   1 file changed, 1 insertion(+)
> > 
> > diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
> > index bc0e0d2..55e01d9 100644
> > --- a/net/vhost-vdpa.c
> > +++ b/net/vhost-vdpa.c
> > @@ -55,6 +55,7 @@ const int vdpa_feature_bits[] = {
> >       VIRTIO_F_IOMMU_PLATFORM,
> >       VIRTIO_F_RING_PACKED,
> >       VIRTIO_NET_F_GUEST_ANNOUNCE,
> > +    VIRTIO_NET_F_STATUS,
> >       VHOST_INVALID_FEATURE_BIT
> >   };
> 
> 
> Acked-by: Jason Wang <jasowang@redhat.com>
> 
> Michael, do you want to pick this patch or I will do that?
> 
> Thanks

Tagged, thanks!


