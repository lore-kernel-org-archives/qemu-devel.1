Return-Path: <SRS0=zj/5=4O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E889CC4BA18
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 16:53:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B690321556
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 16:53:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ABd8QSiD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B690321556
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47002 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6zwC-0004en-Sr
	for qemu-devel@archiver.kernel.org; Wed, 26 Feb 2020 11:53:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59990)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1j6zvL-00043t-Eu
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 11:52:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1j6zvK-0004sA-FC
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 11:52:39 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:35515
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1j6zvK-0004oy-9M
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 11:52:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582735957;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=O+lzFW2XyuJgwMH81eGxKm0oh/RS80lG5yE4N5Zr4LY=;
 b=ABd8QSiD1QA8nicCILAcWx0WxSt143C49wzd+r3nLuz1j19G8WD3iFHbW4cIDgWydOwCMp
 iVU+aegzZ+3JL3hoGsKE9sPNbig2rq1UKxZ2a9o5e3JOWpp+v5TEbn1732Yf2rHm60AdXG
 K6XOGPn1ZM68c51gDg6rbFVDLDI3gh4=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-305-3dg7_vc8NIWYjgngTks8yg-1; Wed, 26 Feb 2020 11:52:35 -0500
X-MC-Unique: 3dg7_vc8NIWYjgngTks8yg-1
Received: by mail-qk1-f199.google.com with SMTP id 22so1870480qkc.7
 for <qemu-devel@nongnu.org>; Wed, 26 Feb 2020 08:52:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=/zzolm4Q6neW1majlH6I6kA3UyKZqlRMGjwUdON8vyY=;
 b=axnhGq9Tc6r06KwuZTVWyOe85Vd2bpI37u+eNaxgGWuEeM8DvhhZXg1fHaGy+BKyTz
 6kvQtYPc8CYFHfFa0sjI/WB5HWdMjJyM9cybE2x5fvCFIErTtVV2bLXkAEGZ1f4mqX5I
 NU1YaLjTo6KBJ7HdgE+2GHRdnnBxLrRBqHFJWaMteb6lFvBwOK9FSvgwGb1DSrpUjGbc
 rHI7c1qGiLwMdE8jeqFNyJQwJzXPEBsbUn07XQfugGLxihXbP7x/VwOYSfySRxmK2sXV
 Kd4xvubWLCIKk66q7npI5RaD8SH6O1KkC5yCKBgCM8IiETAcPcdpUkuAr0O5SxpLp+cQ
 WQEw==
X-Gm-Message-State: APjAAAUj++Brt8WdPErrKcBrEuU3w0EAZeUHO6oyUDZwfcEGNmkNmZzz
 2kpCg6NZ4qCBj+eTPIcWapYkfiawXZyJb1tmTAPojZzLd/ZWPHb7EC8f+ttjJRVY++m4apFZS0u
 PQNq0pf4d0wvNBjU=
X-Received: by 2002:a37:9fd0:: with SMTP id i199mr51832qke.60.1582735953272;
 Wed, 26 Feb 2020 08:52:33 -0800 (PST)
X-Google-Smtp-Source: APXvYqxB59Trkp8ZBuYLFtpZaNjmql+vGeSLfn8NYFJ5Dk2A9SzDJosz3JrRxAZ5E+Ufpm88urmWwQ==
X-Received: by 2002:a37:9fd0:: with SMTP id i199mr51804qke.60.1582735953009;
 Wed, 26 Feb 2020 08:52:33 -0800 (PST)
Received: from redhat.com (bzq-79-178-2-214.red.bezeqint.net. [79.178.2.214])
 by smtp.gmail.com with ESMTPSA id
 l4sm1429277qke.30.2020.02.26.08.52.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Feb 2020 08:52:31 -0800 (PST)
Date: Wed, 26 Feb 2020 11:52:26 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [PATCH V2] vhost: correctly turn on VIRTIO_F_IOMMU_PLATFORM
Message-ID: <20200226115009-mutt-send-email-mst@kernel.org>
References: <20200226094357.25061-1-jasowang@redhat.com>
 <20200226142839.4263de9b.pasic@linux.ibm.com>
 <20200226083654-mutt-send-email-mst@kernel.org>
 <20200226163618.31aa86ed.pasic@linux.ibm.com>
MIME-Version: 1.0
In-Reply-To: <20200226163618.31aa86ed.pasic@linux.ibm.com>
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

On Wed, Feb 26, 2020 at 04:36:18PM +0100, Halil Pasic wrote:
> On Wed, 26 Feb 2020 08:37:13 -0500
> "Michael S. Tsirkin" <mst@redhat.com> wrote:
>=20
> > On Wed, Feb 26, 2020 at 02:28:39PM +0100, Halil Pasic wrote:
> > > On Wed, 26 Feb 2020 17:43:57 +0800
> > > Jason Wang <jasowang@redhat.com> wrote:
> > >=20
> > > > We turn on device IOTLB via VIRTIO_F_IOMMU_PLATFORM unconditionally=
 on
> > > > platform without IOMMU support. This can lead unnecessary IOTLB
> > > > transactions which will damage the performance.
> > > >=20
> > > > Fixing this by check whether the device is backed by IOMMU and disa=
ble
> > > > device IOTLB.
> > > >=20
> > > > Reported-by: Halil Pasic <pasic@linux.ibm.com>
> > > > Fixes: c471ad0e9bd46 ("vhost_net: device IOTLB support")
> > > > Cc: qemu-stable@nongnu.org
> > > > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > >=20
> > > Tested-by: Halil Pasic <pasic@linux.ibm.com>
> > > Reviewed-by: Halil Pasic <pasic@linux.ibm.com>
> > >=20
> > > Thank you very much for fixing this! BTW as I mentioned before it
> > > fixes vhost-vsock with iommu_platform=3Don as well.
> >=20
> > Fixes as in improves performance?
>=20
> No, fixes like one does not get something like:
> qemu-system-s390x: vhost_set_features failed: Operation not supported (95=
)
> qemu-system-s390x: Error starting vhost: 95
> any more.
>=20
> Regards,
> Halil
>=20
> [..]

But can commit c471ad0e9bd46 actually boot a secure guest
where iommu_platform=3Don is required?

--=20
MST


