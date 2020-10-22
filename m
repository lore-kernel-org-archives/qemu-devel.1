Return-Path: <SRS0=9x1+=D5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30C2EC388F2
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2020 14:02:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4506222249
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2020 14:02:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TSBXUrbQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4506222249
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41260 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVbAP-0001I4-W9
	for qemu-devel@archiver.kernel.org; Thu, 22 Oct 2020 10:02:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42152)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kVb9R-0000VS-Mx
 for qemu-devel@nongnu.org; Thu, 22 Oct 2020 10:01:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:54230)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kVb9K-0008PW-Lq
 for qemu-devel@nongnu.org; Thu, 22 Oct 2020 10:01:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603375259;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tYdW5403kuiDy3RCL1Rz+heA3ORxrQjpwh+pPyz6pKE=;
 b=TSBXUrbQoA8qxL37srB39+xz3RD2AnOeTr7lku0OMH+kKxBteLc1CLETmDxZHxsr/O9HA3
 J26HUpoOqyRGf4wiIkhrmtDSYHq1y2So/8KJVEiRu4KqSe8gw897T0Z8tARRaULuoykB3L
 rz350AhCKMLG6dEFiBTr/sRTpXl+p1I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-518-OATmVh6ePJGi098DK65uqg-1; Thu, 22 Oct 2020 10:00:56 -0400
X-MC-Unique: OATmVh6ePJGi098DK65uqg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5B998804B64;
 Thu, 22 Oct 2020 14:00:55 +0000 (UTC)
Received: from localhost (ovpn-114-229.ams2.redhat.com [10.36.114.229])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0E3175D9D5;
 Thu, 22 Oct 2020 14:00:51 +0000 (UTC)
Date: Thu, 22 Oct 2020 15:00:50 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Subject: Re: [PATCH 03/16] util/vfio-helpers: Pass minimum page size to
 qemu_vfio_open_pci()
Message-ID: <20201022140050.GD761187@stefanha-x1.localdomain>
References: <20201020172428.2220726-1-philmd@redhat.com>
 <20201020172428.2220726-4-philmd@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20201020172428.2220726-4-philmd@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="48TaNjbzBVislYPb"
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/22 08:09:01
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--48TaNjbzBVislYPb
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 20, 2020 at 07:24:15PM +0200, Philippe Mathieu-Daud=E9 wrote:
> @@ -724,7 +725,7 @@ static int nvme_init(BlockDriverState *bs, const char=
 *device, int namespace,
>          goto out;
>      }
> =20
> -    s->page_size =3D MAX(4096, 1u << (12 + NVME_CAP_MPSMIN(cap)));
> +    s->page_size =3D MAX(min_page_size, 1u << (12 + NVME_CAP_MPSMIN(cap)=
));

Is there a guarantee that the NVMe drive supports our min_page_size?

Stefan

--48TaNjbzBVislYPb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl+RkJIACgkQnKSrs4Gr
c8gC3Qf+KLpnNxnNc2RznsnkxzuLeo0CBzYIwtZjAL+B6Lps5rIpij7eG+RFhASP
rfVyuv+7PfhOYUjZBO42AFQzKT5jUyhveZa96X3mTWzaDuMsEQzclHSg/0//LGy9
LlnKe5v3RRzOvOybce9/ehcArw5D7ptYKTj/JqbPaLvpWD0khqLGXWsee77ADk8w
+EPFgPSSYHysVOmw+1AAfRo3YcOa2lOIhjXMiab17+2otw9SiVIvQ94LY0ssJI4B
V/yATHfDMigLSuCBW31FfdqpMvkWYywhmQP+v2spKiuawwcp+IjnIfb6u6J5kjSG
nVnDtBANkSWXKDuU0KVlwh+K3foJUA==
=+vr2
-----END PGP SIGNATURE-----

--48TaNjbzBVislYPb--


