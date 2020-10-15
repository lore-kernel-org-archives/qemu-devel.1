Return-Path: <SRS0=muvY=DW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9AD5C433E7
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 13:12:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 023C72225C
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 13:12:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a+/vc8X4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 023C72225C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52254 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kT335-0002FB-17
	for qemu-devel@archiver.kernel.org; Thu, 15 Oct 2020 09:12:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44896)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kT326-0001IG-65
 for qemu-devel@nongnu.org; Thu, 15 Oct 2020 09:11:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:34547)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kT320-00056O-U2
 for qemu-devel@nongnu.org; Thu, 15 Oct 2020 09:11:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602767455;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pGt+uh4dSni15eHXmXCFO3XY83Ym/mXHYG8h/Q2O3Hs=;
 b=a+/vc8X4uk9ekhQc/0+zsJSZ9UgfLll9fKv/4bHozlDqRVyBzrtynIW9lMEYpaFB+eiRIY
 v0uUjH1uDF2VTU6NFqod3kqUsFU/a5VgQnSSYgXThlzgoBnZVgMAZaqOjmZSGN3/KPKD0q
 yUB4uqtTgWrHQuEkN/mGfo6/GyoNMd8=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-591-NqWl5v56OcONqM830BKBPw-1; Thu, 15 Oct 2020 09:10:53 -0400
X-MC-Unique: NqWl5v56OcONqM830BKBPw-1
Received: by mail-wr1-f69.google.com with SMTP id k14so1864255wrd.6
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2020 06:10:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=pGt+uh4dSni15eHXmXCFO3XY83Ym/mXHYG8h/Q2O3Hs=;
 b=QkgvGEZjq4YlCt/kp/B/+lVengwkELVpPqG39WD6OLqSi9gxskbHxpVK4BhqQ8Gz+B
 9cd2b7Aie4Czoij8UWq6wMsxRht2Z52ji7ZpEV80GBIxwwy03UDfskTQkA04RPZ9apNt
 wjxuX+yiezmHrak0Rr331+t6V4exeuyE7BdCBBnIutro0LVMlXce/T1Y8KaqyTFIAH6J
 ZfXe3uzYPRtl2YnfkQPxkYeu6uieXdses3bUlCBxtRxTzGlzl4nNdRbktIDXoa8HQw1y
 TxkbBlaUI+2jie7llCzkO6wFE2XJo+zeHoVZSJVCs5WV4LHfIoL3/VIThVUUwQkkdzXS
 QXdQ==
X-Gm-Message-State: AOAM5306V2xVDmU6B6G/K8aayfUFSV56+VAwQmLRkwpB/iicHMejDk/k
 ByW7Sm/WACMJspzppu1AePsObQHWHR7U2XNo6e+IaW/mGLOLgfueyJE0ysylkjMW1grnir1vrr6
 d+3ALmld8JedupcM=
X-Received: by 2002:a1c:df83:: with SMTP id w125mr3919224wmg.36.1602767451903; 
 Thu, 15 Oct 2020 06:10:51 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwvSFa2PBhK8lWsxbVAmD6hld07+cUObdeh2rCwoWpC7AJs8WWv9BbXDNZw6dZalgzvxp2YPQ==
X-Received: by 2002:a1c:df83:: with SMTP id w125mr3919174wmg.36.1602767451495; 
 Thu, 15 Oct 2020 06:10:51 -0700 (PDT)
Received: from redhat.com (bzq-79-176-118-93.red.bezeqint.net. [79.176.118.93])
 by smtp.gmail.com with ESMTPSA id r3sm4584501wrm.51.2020.10.15.06.10.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Oct 2020 06:10:50 -0700 (PDT)
Date: Thu, 15 Oct 2020 09:10:48 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH] pci: advertise a page aligned ATS
Message-ID: <20201015091040-mutt-send-email-mst@kernel.org>
References: <20200909081731.24688-1-jasowang@redhat.com>
 <704323d4-8079-fbd2-3318-c67ebefa2525@redhat.com>
MIME-Version: 1.0
In-Reply-To: <704323d4-8079-fbd2-3318-c67ebefa2525@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/15 02:38:26
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: eperezma@redhat.com, qemu-devel@nongnu.org, peterx@redhat.com,
 qemu-stable@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Oct 15, 2020 at 03:47:09PM +0800, Jason Wang wrote:
> 
> On 2020/9/9 下午4:17, Jason Wang wrote:
> > After Linux kernel commit 61363c1474b1 ("iommu/vt-d: Enable ATS only
> > if the device uses page aligned address."), ATS will be only enabled
> > if device advertises a page aligned request.
> > 
> > Unfortunately, vhost-net is the only user and we don't advertise the
> > aligned request capability in the past since both vhost IOTLB and
> > address_space_get_iotlb_entry() can support non page aligned request.
> > 
> > Though it's not clear that if the above kernel commit makes
> > sense. Let's advertise a page aligned ATS here to make vhost device
> > IOTLB work with Intel IOMMU again.
> > 
> > Note that in the future we may extend pcie_ats_init() to accept
> > parameters like queue depth and page alignment.
> > 
> > Cc: qemu-stable@nongnu.org
> > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > ---
> >   hw/pci/pcie.c | 5 +++--
> >   1 file changed, 3 insertions(+), 2 deletions(-)
> > 
> > diff --git a/hw/pci/pcie.c b/hw/pci/pcie.c
> > index 5b48bae0f6..d4010cf8f3 100644
> > --- a/hw/pci/pcie.c
> > +++ b/hw/pci/pcie.c
> > @@ -971,8 +971,9 @@ void pcie_ats_init(PCIDevice *dev, uint16_t offset)
> >       dev->exp.ats_cap = offset;
> > -    /* Invalidate Queue Depth 0, Page Aligned Request 0 */
> > -    pci_set_word(dev->config + offset + PCI_ATS_CAP, 0);
> > +    /* Invalidate Queue Depth 0, Page Aligned Request 1 */
> > +    pci_set_word(dev->config + offset + PCI_ATS_CAP,
> > +                 PCI_ATS_CAP_PAGE_ALIGNED);
> >       /* STU 0, Disabled by default */
> >       pci_set_word(dev->config + offset + PCI_ATS_CTRL, 0);
> 
> 
> Ping, Michael, want to pick this patch?
> 
> Thanks

Tagged, thanks!


