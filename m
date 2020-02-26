Return-Path: <SRS0=zj/5=4O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92250C4BA10
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 13:46:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5E01E2467B
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 13:46:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q9o87D9b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E01E2467B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44568 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6x1S-00075Y-Iz
	for qemu-devel@archiver.kernel.org; Wed, 26 Feb 2020 08:46:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47845)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1j6x0d-0006S7-QE
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 08:45:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1j6x0c-0001ZS-ND
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 08:45:55 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:32242
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1j6x0c-0001Vw-JL
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 08:45:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582724753;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/EAzYK3OJ5ZGcwqRAY2qQCWviE6qm1Fx2MVE70YbouM=;
 b=Q9o87D9bygHI7GFyxNWAGx4KFawqzKeRiHiBye+zFevecOsdsJSsJRhkSnbxDZyRw1G43t
 YoF53R96oDUMQ5AKkMzFzh9V7S2VXOsJP50c1QW7z76WW+Mxviz2N7lalUJpFFre5H3x/T
 32I6ZGuipEIx9dqETejD0861/JPs6l8=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-475-Phkd0fEwPJ-bN87PzrhPFw-1; Wed, 26 Feb 2020 08:45:50 -0500
X-MC-Unique: Phkd0fEwPJ-bN87PzrhPFw-1
Received: by mail-qk1-f200.google.com with SMTP id 205so4299996qkg.0
 for <qemu-devel@nongnu.org>; Wed, 26 Feb 2020 05:45:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=fsvvToDs/CeyYwZP74lzMX9H8gae+87/RnoF18I3+7A=;
 b=KBz++DH9AsAL2SwFliH3CoRM2PSlLqgVF15JhzxRnP1EKpJydmaa8Yw4SOdzE0CK3f
 XsVWiXDC696EJhsyC7MitZ1QZJY3hGoeFa68wfqcMen+rkMkdJ9f+CVbaPq0W6G4JaHk
 9V+HFt3nE0FJM5sM1q6kpN0+iC6mFc6mcv8zuz4nmn1iKTca/3SHMc9KARfXP2fAnuRz
 MJwKAEaY7+//V33JTIdJamD3wLDV8oPlZEL2Mwz+terllxHj6Kklyg0nUUR7T0ghKMKS
 8sWs0OKCrFzJavUvVOQJOAGmtkkc+fhXM6tpApei67ZcAaJ2Ll3+FSWUr4z2i7RR5ooe
 9P7w==
X-Gm-Message-State: APjAAAXksti+O0ku2oykUjFK9xV070/a2zHaEgaCQPy7+nMow1r3LWAd
 4eN07HJ8KRbmIkIsW6rZoHKPUSQSbvIu5jk0UylihSqgEBDONCxN/dK5D1NfFXUkKXk1QyqPPu0
 VYjPYM4q+Zi706b0=
X-Received: by 2002:aed:2519:: with SMTP id v25mr1670880qtc.176.1582724749510; 
 Wed, 26 Feb 2020 05:45:49 -0800 (PST)
X-Google-Smtp-Source: APXvYqw5ZZQs/mSptEfC+8o7e3gl+Nvm26w/q/ZMKKYkJwj+kXZtTXCIeiuWnjiHJl/Ug56FPg28NQ==
X-Received: by 2002:aed:2519:: with SMTP id v25mr1670858qtc.176.1582724749295; 
 Wed, 26 Feb 2020 05:45:49 -0800 (PST)
Received: from redhat.com (bzq-79-178-2-214.red.bezeqint.net. [79.178.2.214])
 by smtp.gmail.com with ESMTPSA id
 89sm1123633qth.3.2020.02.26.05.45.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Feb 2020 05:45:48 -0800 (PST)
Date: Wed, 26 Feb 2020 08:45:44 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [PATCH V2] vhost: correctly turn on VIRTIO_F_IOMMU_PLATFORM
Message-ID: <20200226084423-mutt-send-email-mst@kernel.org>
References: <20200226094357.25061-1-jasowang@redhat.com>
 <20200226045128-mutt-send-email-mst@kernel.org>
 <20200226135539.384489f7.pasic@linux.ibm.com>
MIME-Version: 1.0
In-Reply-To: <20200226135539.384489f7.pasic@linux.ibm.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
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
Cc: Jason Wang <jasowang@redhat.com>, qemu-devel@nongnu.org,
 qemu-stable@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Feb 26, 2020 at 01:55:39PM +0100, Halil Pasic wrote:
> On Wed, 26 Feb 2020 04:53:33 -0500
> "Michael S. Tsirkin" <mst@redhat.com> wrote:
>=20
> > On Wed, Feb 26, 2020 at 05:43:57PM +0800, Jason Wang wrote:
> > > We turn on device IOTLB via VIRTIO_F_IOMMU_PLATFORM unconditionally o=
n
> > > platform without IOMMU support. This can lead unnecessary IOTLB
> > > transactions which will damage the performance.
> > >=20
> > > Fixing this by check whether the device is backed by IOMMU and disabl=
e
> > > device IOTLB.
> > >=20
> > > Reported-by: Halil Pasic <pasic@linux.ibm.com>
> > > Fixes: c471ad0e9bd46 ("vhost_net: device IOTLB support")
> >=20
> > Well it's just an optimization, isn't it?
> > I don't think it's justified to push this to everyone using
> > vhost with IOTLB, is it?
>=20
> IMHO we need this for everyone using vhost! For instance vhost-vsock
> currently does not work with iommu_platform=3Don, because unlike vhost-ne=
t
> vhost does not offer F_ACCESS_PLATFORM, so set features IOCTL fails.=20

You mean vsock does not offer it? OK but that's still not a bugfix.
Making new configs work is great, but that's a feature almost
by definition.

> > If you disagree, could you comment a bit on which configurations where =
tested?
> >=20
> > > Cc: qemu-stable@nongnu.org
> > > Signed-off-by: Jason Wang <jasowang@redhat.com>
> >=20
> > Halil could you test this pls? Does this help your performance issue?
> >=20
>=20
> I'm pretty sure it does, but I will re-test. The previous version where
> it was done virtio-net certainly did.
>=20
> Regards,
> Halil
>=20
>=20


