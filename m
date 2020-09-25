Return-Path: <SRS0=+pSw=DC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DE05C4363D
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 15:52:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C9C6D21D7A
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 15:52:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YytAUqMX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9C6D21D7A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43650 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLq1V-0005iV-SZ
	for qemu-devel@archiver.kernel.org; Fri, 25 Sep 2020 11:52:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35240)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kLpmp-0007nk-8e
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 11:37:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:27292)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kLpml-0007Eb-1h
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 11:37:26 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601048242;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ANe7izlsvAT61cUuBs6PVDfU18VVxHK+XZUhRdZvqqE=;
 b=YytAUqMXFw7nc06K+UZUHm0aD/OGpa/MleugYtRRqDPk8aa28fqOE9Q9wwd1aHGdmJYaGI
 4/VDvFYGZEfA/foJ7w6yg0zcAf19KL0iQoWxXniH41l2/j+VZXb7oSEh1ZW3KR9YagzWSC
 SeKV/1Me61MbHUg1d5LZfSn2fqoxJgM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-482-9jlOX98aMnKzLLkrpPvmGg-1; Fri, 25 Sep 2020 11:37:05 -0400
X-MC-Unique: 9jlOX98aMnKzLLkrpPvmGg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D4FF21005E6D;
 Fri, 25 Sep 2020 15:37:04 +0000 (UTC)
Received: from localhost (ovpn-115-66.ams2.redhat.com [10.36.115.66])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 791EC19C66;
 Fri, 25 Sep 2020 15:37:04 +0000 (UTC)
Date: Fri, 25 Sep 2020 16:37:03 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Subject: Re: [PATCH v2 0/6] block/nvme: Map doorbells pages write-only,
 remove magic from nvme_init
Message-ID: <20200925153703.GC343759@stefanha-x1.localdomain>
References: <20200922083821.578519-1-philmd@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200922083821.578519-1-philmd@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="jy6Sn24JjFx/iggw"
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/25 01:07:33
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.199,
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
 qemu-devel@nongnu.org, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--jy6Sn24JjFx/iggw
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 22, 2020 at 10:38:15AM +0200, Philippe Mathieu-Daud=E9 wrote:
> Instead of mapping 8K of I/O + doorbells as RW during the whole
> execution, maps I/O temporarly at init, and map doorbells WO.
>=20
> Replace various magic values by slighly more explicit macros from
> "block/nvme.h".
>=20
> Since v1: Fix uninitialized regs* (patchew)
>=20
> Philippe Mathieu-Daud=E9 (6):
>   util/vfio-helpers: Pass page protections to qemu_vfio_pci_map_bar()
>   block/nvme: Map doorbells pages write-only
>   block/nvme: Reduce I/O registers scope
>   block/nvme: Drop NVMeRegs structure, directly use NvmeBar
>   block/nvme: Use register definitions from 'block/nvme.h'
>   block/nvme: Replace magic value by SCALE_MS definition
>=20
>  include/qemu/vfio-helpers.h |  2 +-
>  block/nvme.c                | 73 +++++++++++++++++++++----------------
>  util/vfio-helpers.c         |  4 +-
>  3 files changed, 44 insertions(+), 35 deletions(-)
>=20
> --=20
> 2.26.2
>=20

Thanks, applied to my block tree:
https://github.com/stefanha/qemu/commits/block

Stefan

--jy6Sn24JjFx/iggw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl9uDp8ACgkQnKSrs4Gr
c8hYvQgAn0inP/zsZZ69JBiPpm6quzuhz+Gnu+72fooDMD/bY+bIth7EnRBRAVAw
IgsW5jiIx4w00ldTpyjq4M98XtO+B5NDd/daYRpUEfMmyufgmKZCM5w66ErOftlL
wzTshlvtohy2cEtHigGbaLJoeTTLsnf4DXdk4qNA/T6mDrsPFZ8sBpgqYMknA9Zn
byiD7O6RocuooVcGE7potfQM2hU8vlslAQHqiLNYJUArPfh9oOCUzvu3yqvADbR0
/Pc521f9yjTvt7t2d4wgN+HlnqQD5oiOq4BDcPX/SiajVsmYObw3LcmtURVRX5SZ
cjASkLNkgL5B85rLARBRN1PcdG5duQ==
=qXpW
-----END PGP SIGNATURE-----

--jy6Sn24JjFx/iggw--


