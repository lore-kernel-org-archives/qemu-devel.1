Return-Path: <SRS0=0TZc=4P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1727FC11D3D
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 15:49:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C8BEF24697
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 15:48:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V7e7KwVv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8BEF24697
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33610 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7LPG-0006gn-T2
	for qemu-devel@archiver.kernel.org; Thu, 27 Feb 2020 10:48:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33629)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1j7LOR-00067D-9b
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 10:48:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1j7LOP-0000C8-Dy
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 10:48:06 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:33433
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1j7LOP-00008I-94
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 10:48:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582818482;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zR7EJtAf8dfIwDJW87HEyNejWQ7hG50HGDdE6wz3XiY=;
 b=V7e7KwVv5GEo+cQ6bLxVeBh424Z7mIjcxr0nN9+6roiMRvaZgbWGB2eiifHX0KIFGg0+MM
 aN8nvhNhRNj5cIAH/d0QukTf8J7768rVZH2ugasavDXXs2T/ouviccSPiNkPwr+qljpqPg
 5cezrqWkVVd51L1wu0uli+k1Xb3IzL8=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-379-W_AcXetaMwO_3JlT2fpFGg-1; Thu, 27 Feb 2020 10:47:28 -0500
X-MC-Unique: W_AcXetaMwO_3JlT2fpFGg-1
Received: by mail-qv1-f72.google.com with SMTP id b3so4161109qvy.3
 for <qemu-devel@nongnu.org>; Thu, 27 Feb 2020 07:47:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=otq+mXz+hXp3JPj56noj/v8obPEj17YDEIfSRpri6Xk=;
 b=B+5M/Y8yWwmdhiJU7dTa6mpvz3w3mHxKcs+NwgfwfHPVAIzNRAN2mtuLmimB2/y4dr
 g9bXdDQo3D6bH0OPJM9flNUtpntacQaVHH4kOX35Mho6kVehbOgmniEempFI/UlGG1mD
 6yagf/rdXzUbS4kaj/CLlB8t3FZwP3hrlE+MsNv7+2DT/uxGDlB2CHvTcd59Rqe4bkcu
 bBrGmz/WSAVgKhS7pPhmQkURwbw0elUsh08uNLv1Mzgj2elZyKho9ZcjAMmpOdg8pHsJ
 tvpeRJEfJlfHNacGWRZDweGiYAl9SgWNJUTeBokw5g/lVUO8SGA15PYJn4pZq8K+Grnb
 0FSQ==
X-Gm-Message-State: APjAAAWbzlveHQWjiVTcIBR6+ZHyja4zyCrpuF+BZFKcVygcrw2cCUdE
 w4lhlSaD8AJDBpV8r7o5uwWkNm90kawZU6WHJIRPl+v8wUpZNqzaSCParAHZPF5mkuB9KdoxnEZ
 DS8SJzoX6fmauP9k=
X-Received: by 2002:ae9:f30a:: with SMTP id p10mr6281177qkg.313.1582818447875; 
 Thu, 27 Feb 2020 07:47:27 -0800 (PST)
X-Google-Smtp-Source: APXvYqwX8h3W29psivwDFRjo0CQnpY2Ha54Z7MEOBMmRyczvb13GrCLkmd0WzXkytLeqxm9RBaSoqg==
X-Received: by 2002:ae9:f30a:: with SMTP id p10mr6281158qkg.313.1582818447649; 
 Thu, 27 Feb 2020 07:47:27 -0800 (PST)
Received: from redhat.com (bzq-79-178-2-214.red.bezeqint.net. [79.178.2.214])
 by smtp.gmail.com with ESMTPSA id
 u49sm3409752qtb.37.2020.02.27.07.47.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Feb 2020 07:47:26 -0800 (PST)
Date: Thu, 27 Feb 2020 10:47:22 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [PATCH V2] vhost: correctly turn on VIRTIO_F_IOMMU_PLATFORM
Message-ID: <20200227104233-mutt-send-email-mst@kernel.org>
References: <20200226094357.25061-1-jasowang@redhat.com>
 <20200226142839.4263de9b.pasic@linux.ibm.com>
 <20200226083654-mutt-send-email-mst@kernel.org>
 <20200226163618.31aa86ed.pasic@linux.ibm.com>
 <20200226115009-mutt-send-email-mst@kernel.org>
 <20200227140215.2d12149c.pasic@linux.ibm.com>
MIME-Version: 1.0
In-Reply-To: <20200227140215.2d12149c.pasic@linux.ibm.com>
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
Cc: Tom Lendacky <thomas.lendacky@amd.com>, Jason Wang <jasowang@redhat.com>,
 qemu-devel@nongnu.org, qemu-stable@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Feb 27, 2020 at 02:02:15PM +0100, Halil Pasic wrote:
> On Wed, 26 Feb 2020 11:52:26 -0500
> "Michael S. Tsirkin" <mst@redhat.com> wrote:
>=20
> > On Wed, Feb 26, 2020 at 04:36:18PM +0100, Halil Pasic wrote:
> > > On Wed, 26 Feb 2020 08:37:13 -0500
> > > "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > >=20
> > > > On Wed, Feb 26, 2020 at 02:28:39PM +0100, Halil Pasic wrote:
> > > > > On Wed, 26 Feb 2020 17:43:57 +0800
> > > > > Jason Wang <jasowang@redhat.com> wrote:
> > > > >=20
> > > > > > We turn on device IOTLB via VIRTIO_F_IOMMU_PLATFORM uncondition=
ally on
> > > > > > platform without IOMMU support. This can lead unnecessary IOTLB
> > > > > > transactions which will damage the performance.
> > > > > >=20
> > > > > > Fixing this by check whether the device is backed by IOMMU and =
disable
> > > > > > device IOTLB.
> > > > > >=20
> > > > > > Reported-by: Halil Pasic <pasic@linux.ibm.com>
> > > > > > Fixes: c471ad0e9bd46 ("vhost_net: device IOTLB support")
> > > > > > Cc: qemu-stable@nongnu.org
> > > > > > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > > > >=20
> > > > > Tested-by: Halil Pasic <pasic@linux.ibm.com>
> > > > > Reviewed-by: Halil Pasic <pasic@linux.ibm.com>
> > > > >=20
> > > > > Thank you very much for fixing this! BTW as I mentioned before it
> > > > > fixes vhost-vsock with iommu_platform=3Don as well.
> > > >=20
> > > > Fixes as in improves performance?
> > >=20
> > > No, fixes like one does not get something like:
> > > qemu-system-s390x: vhost_set_features failed: Operation not supported=
 (95)
> > > qemu-system-s390x: Error starting vhost: 95
> > > any more.
> > >=20
> > > Regards,
> > > Halil
> > >=20
> > > [..]
> >=20
> > But can commit c471ad0e9bd46 actually boot a secure guest
> > where iommu_platform=3Don is required?
> >=20
>=20
> No, of course it can not. But I'm not sure about AMD SEV. AFAIU without
> Jason's patch it does not work for AMD SEV. Tom already stated that with
> SEV they don't need the IOVA translation aspect of ACCESS_PLATFORM, but
> I have no idea if the condition vdev->dma_as =3D=3D &address_space_memory
> catches them as well or not. They probably have !=3D.
>=20
> CCing Tom. @Tom does vhost-vsock work for you with SEV and current qemu?
>=20
> Also, one can specify iommu_platform=3Don on a device that ain't a part o=
f
> a secure-capable VM, just for the fun of it. And that breaks
> vhost-vsock. Or is setting iommu_platform=3Don only valid if
> qemu-system-s390x is protected virtualization capable?
>=20
> BTW, I don't have a strong opinion on the fixes tag. We currently do not
> recommend setting iommu_platform, and thus I don't think we care too
> much about past qemus having problems with it.
>=20
> Regards,
> Halil


Let's just say if we do have a Fixes: tag we want to set it correctly to
the commit that needs this fix.

--=20
MST


