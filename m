Return-Path: <SRS0=gwGE=EC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E94EFC4363A
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 09:51:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1B88C20759
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 09:51:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S1/Lrhh/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B88C20759
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46928 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXLdj-0001gp-15
	for qemu-devel@archiver.kernel.org; Tue, 27 Oct 2020 05:51:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51874)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kXLcS-00010p-0v
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 05:50:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:52369)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kXLcP-0005EV-AK
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 05:50:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603792215;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=cIwvlJs/2yZxodsBpYuoeYKPxurkE2mJL+HsRobXMfM=;
 b=S1/Lrhh/7EKGDbgm1B7V744Nf6trU8zgXvmVYqD/KYdieVuPGhIyB2jWiVdibhy9YbAPqN
 0c/VTjRQDS3iXN4CEnGgzr/bcXV7EBuoeqlYwGkBsaSzZuayZpaUafoQdKOKvb8T/1/7XP
 xu2HAyut2OL37HAhqE2+zGu8jQ2lUXk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-304-KWkHohYuPmmn7bkDiIOSsA-1; Tue, 27 Oct 2020 05:50:12 -0400
X-MC-Unique: KWkHohYuPmmn7bkDiIOSsA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A2A7C1882FB7;
 Tue, 27 Oct 2020 09:50:11 +0000 (UTC)
Received: from localhost (ovpn-114-163.ams2.redhat.com [10.36.114.163])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 89A755B4BC;
 Tue, 27 Oct 2020 09:50:05 +0000 (UTC)
Date: Tue, 27 Oct 2020 09:50:04 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Subject: Re: [PATCH v2 14/19] util/vfio-helpers: Pass minimum page size to
 qemu_vfio_open_pci()
Message-ID: <20201027095004.GE79063@stefanha-x1.localdomain>
References: <20201026105504.4023620-1-philmd@redhat.com>
 <20201026105504.4023620-15-philmd@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20201026105504.4023620-15-philmd@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="Oiv9uiLrevHtW1RS"
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/27 01:06:07
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Eric Auger <eric.auger@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--Oiv9uiLrevHtW1RS
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 26, 2020 at 11:54:59AM +0100, Philippe Mathieu-Daud=E9 wrote:
> @@ -737,6 +738,17 @@ static int nvme_init(BlockDriverState *bs, const cha=
r *device, int namespace,
>      }
> =20
>      device_page_size_min =3D 1u << (12 + NVME_CAP_MPSMIN(cap));
> +    device_page_size_max =3D 1u << (12 + NVME_CAP_MPSMAX(cap));
> +    if (iommu_page_size_min > device_page_size_max) {
> +        g_autofree char *iommu_page_size_s =3D size_to_str(iommu_page_si=
ze_min);
> +        g_autofree char *device_page_size_s =3D size_to_str(device_page_=
size_max);
> +
> +        error_setg(errp, "IOMMU minimum page size (%s)"
> +                         " too big for device (max %s)",
> +                   iommu_page_size_s, device_page_size_s);
> +        ret =3D -EINVAL;
> +        goto out;
> +    }

I thought you and Eric worked on a solution to support smaller device
pages on bigger IOMMU pages? For example, 4KB device page size on 64KB
IOMMU page size.

Won't this check be removed again very soon? Why add it at all?

--Oiv9uiLrevHtW1RS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl+X7UwACgkQnKSrs4Gr
c8itNQf8DMwAN7rPn/1YBcJcT/bOv2kLVtG8fHCjSc3Mn5HJh3pDOfWqZXJAB7hI
oudwRGzOVTmPTXAwEPDWPBdiOUKwOzRQDb62Xvsg+tsSiLOh+q8sgytoOGTwRfzn
vyR8xNtJBUqjWS2vCvjqiDTIA965SiohSq9Ccp7EdGBQb+IyVXePquQa87if1Rt4
RLKConsFvxncd9dVoT+9MUCjeIuLRswhnwCPFPrDxr32X4iRPiWD0+GpnEsw+aya
FRyv9eZOLzE9fkHxjK/qPoepvfN6+xgM1+vE+Ln0xb1jbyDebLUpsVF4aYUvF9Ks
V8SPy5GO5RyqUsoxB2r7w+vXJFNCIA==
=0qG/
-----END PGP SIGNATURE-----

--Oiv9uiLrevHtW1RS--


