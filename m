Return-Path: <SRS0=Un+l=ED=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23192C4363A
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 07:53:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 429C52220B
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 07:53:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Vnv3qZo3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 429C52220B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44934 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXgGf-0000GF-3X
	for qemu-devel@archiver.kernel.org; Wed, 28 Oct 2020 03:53:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59226)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kXgFO-0007z3-Ji
 for qemu-devel@nongnu.org; Wed, 28 Oct 2020 03:51:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:32061)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kXgFI-0000Su-VL
 for qemu-devel@nongnu.org; Wed, 28 Oct 2020 03:51:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603871507;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=VcHfxPU8bp4lJsiEGv5aIsGeq9hB6cpBNe5j1o9mJQE=;
 b=Vnv3qZo3GTtBpkYvjFSaSvoU8eOuFp4z5da6qYfOs7PTWQnyzQbRKmkbnjKjwr9mmMc9qp
 aV7aUEv2xzBZZpkYRAMOJf1kCWtTt9a2H4pGa/Hs/pm6IW9EHkHKUYiDCo58ZruIv9QRl3
 MdE2tyG58RUzOnJY/9rS/F62ymDqOPM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-93-B2ZUVFWYMSiUkGPDX3Gfkg-1; Wed, 28 Oct 2020 03:51:44 -0400
X-MC-Unique: B2ZUVFWYMSiUkGPDX3Gfkg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4DEF81009E38;
 Wed, 28 Oct 2020 07:51:43 +0000 (UTC)
Received: from localhost (ovpn-113-87.ams2.redhat.com [10.36.113.87])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 83FF31C4;
 Wed, 28 Oct 2020 07:51:39 +0000 (UTC)
Date: Wed, 28 Oct 2020 07:51:38 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Subject: Re: [PATCH-for-5.2] block/nvme: Fix nvme_submit_command() on
 big-endian host
Message-ID: <20201028075138.GA221115@stefanha-x1.localdomain>
References: <20201027160407.418423-1-philmd@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20201027160407.418423-1-philmd@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="3MwIy2ne0vdjdPXF"
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/28 01:50:00
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Keith Busch <kbusch@kernel.org>, Eric Auger <eric.auger@redhat.com>,
 Klaus Jensen <its@irrelevant.dk>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--3MwIy2ne0vdjdPXF
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 27, 2020 at 05:04:07PM +0100, Philippe Mathieu-Daud=E9 wrote:
> The Completion Queue Command Identifier is a 16-bit value,
> so nvme_submit_command() is unlikely to work on big-endian
> hosts, as the relevant bits are truncated.
>=20
> The "Completion Queue Entry: DW 2" describes it as:
>=20
>   This identifier is assigned by host software when
>   the command is submitted to the Submission
>=20
> As the is just an opaque cookie, it is pointless to byte-swap it.

The code does not make it clear that the missing byteswap is
intentional. Please either fix the byteswap (32 -> 16) or add code
comments explaining why the byteswap is not necessary.

--3MwIy2ne0vdjdPXF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl+ZIwoACgkQnKSrs4Gr
c8gm+wf/a4hRbGykYjDEx8vRsq3vLf4u76/S6463+pHV59/TJFjGYoPSscD0y6aW
CIaR0cM3ZPAMynecwVUs7udoYZDqYAOJ9ceJY1QMEMnIcyK+EYUzlUKdw2zFzwfe
LHbI7oI6uEcxdalNBjgZiXc/z/qbAQPIKz2oQqFVkDgyEX+9JQs01PAynfPk9HCR
Gu4bFaC5Gvo+8DQOHkKldBD+B7VCik1itq10vAPNPP74mFXYTfSe+1Nut4/1jWop
yI1TrtOpn7L0qaXnjFLyV1Pwre6P1QgrNM05QJp5pe8P1M6idqJCiGfcBIB/uSOY
9UvGiMhy5aMMYmfhSh+SFplcNJLbCw==
=MGDT
-----END PGP SIGNATURE-----

--3MwIy2ne0vdjdPXF--


