Return-Path: <SRS0=DsKm=5S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 348F7C43331
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2020 13:48:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 00C8E2072E
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2020 13:48:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dL0dRF6v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00C8E2072E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40282 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jK0CN-00086a-2L
	for qemu-devel@archiver.kernel.org; Thu, 02 Apr 2020 09:47:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50682)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peterx@redhat.com>) id 1jK0Ai-0006OH-7T
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 09:46:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peterx@redhat.com>) id 1jK0Ad-0001kf-Ce
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 09:46:16 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:50492
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <peterx@redhat.com>) id 1jK0Ad-0001jC-8t
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 09:46:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585835170;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ehgim0Fowz99h2ukYDS2n0Cup+my0nsHsQEH1be0qlw=;
 b=dL0dRF6vElZeXXgGYj3nECukzD/LHDexBRvBp6nK7VTMQDnFlyqI9n0fJVYKraMEkW7NYH
 IcL5wFI4sbf3fPgD6mOnfCIqvjQ9tOr6/40s2nvEsIRl9jPhE9C7T3oysF14sgAcuhNsa6
 Y+c6hMK2EK3+hvU6qt5sm2pdiQ8bDUk=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-463-UCLTZHU9MTOctu2g7njRfA-1; Thu, 02 Apr 2020 09:46:07 -0400
X-MC-Unique: UCLTZHU9MTOctu2g7njRfA-1
Received: by mail-wr1-f69.google.com with SMTP id f15so1514420wrt.4
 for <qemu-devel@nongnu.org>; Thu, 02 Apr 2020 06:46:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=9A3CnEsiXSDPqkUmIOaIkmymme/2Og0VecqbFgiZyxU=;
 b=HahJbMt9XupWdHpZFzsRP5QdvoS1dSyfHI9ghVcKYnZ8L3L1DA9uTReHgYQfzIdwzY
 79P279jmH7hcC3BIRWrwM9eJhLTvnl8dHfSk8o52oTv/hi9idSFpVhPHchivZ3/DFxvJ
 V2j+1/t51+hvcLaq9vZJ090RobcfphaJo6CJOVtF7R7kCNGY8R/OoP+hQlkdAQEaDJfz
 W3N6jtHg8MjarT1GZFeXPn/oSt2qs7D1JFKIHM82y4obrMZIY5ddVH3CeLmLqIxpHe7o
 1HIeL5d61bKSbczVYG3Bk1CkfyZDFbLLThE5qq3/iBRgNfgU43y+691r/HPj5CgsyWPx
 BjVQ==
X-Gm-Message-State: AGi0PubnolX69PKsGSmRTx9lY1jznPUvtpLDFJAYAcb6dGKA6xkdCYHs
 VFtmD+DGBPxb0p6bZoTC/tUz4FOphLbGZD3dZ39d1KXNrbGe1wslanIJOuQ4zwfYN83beAB71K7
 B/LXpqtDC2EiuvI0=
X-Received: by 2002:adf:ea83:: with SMTP id s3mr3918077wrm.25.1585835166200;
 Thu, 02 Apr 2020 06:46:06 -0700 (PDT)
X-Google-Smtp-Source: APiQypJZChRwPcgHJam48Q8buWnfLkcBSM2myx23vHYz3rJj5PGDm/NVXjc+sk4Us05VYvFGWrOXZw==
X-Received: by 2002:adf:ea83:: with SMTP id s3mr3918048wrm.25.1585835165988;
 Thu, 02 Apr 2020 06:46:05 -0700 (PDT)
Received: from xz-x1 ([2607:9880:19c0:32::2])
 by smtp.gmail.com with ESMTPSA id a82sm9404955wmh.0.2020.04.02.06.46.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Apr 2020 06:46:05 -0700 (PDT)
Date: Thu, 2 Apr 2020 09:46:01 -0400
From: Peter Xu <peterx@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH v2 00/22] intel_iommu: expose Shared Virtual Addressing
 to VMs
Message-ID: <20200402134601.GJ7174@xz-x1>
References: <1585542301-84087-1-git-send-email-yi.l.liu@intel.com>
 <984e6f47-2717-44fb-7ff2-95ca61d1858f@redhat.com>
MIME-Version: 1.0
In-Reply-To: <984e6f47-2717-44fb-7ff2-95ca61d1858f@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: jean-philippe@linaro.org, kevin.tian@intel.com,
 Liu Yi L <yi.l.liu@intel.com>, kvm@vger.kernel.org, mst@redhat.com,
 jun.j.tian@intel.com, qemu-devel@nongnu.org, eric.auger@redhat.com,
 alex.williamson@redhat.com, pbonzini@redhat.com, david@gibson.dropbear.id.au,
 yi.y.sun@intel.com, hao.wu@intel.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Apr 02, 2020 at 04:33:02PM +0800, Jason Wang wrote:
> > The complete QEMU set can be found in below link:
> > https://github.com/luxis1999/qemu.git: sva_vtd_v10_v2
>=20
>=20
> Hi Yi:
>=20
> I could not find the branch there.

Jason,

He typed wrong... It's actually (I found it myself):

https://github.com/luxis1999/qemu/tree/sva_vtd_v10_qemu_v2

--=20
Peter Xu


