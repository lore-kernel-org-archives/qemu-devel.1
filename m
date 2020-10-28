Return-Path: <SRS0=Un+l=ED=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE851C388F7
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 15:23:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 25E8D247C3
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 15:23:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JBbtZPDA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25E8D247C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46284 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXnIf-0006dg-0I
	for qemu-devel@archiver.kernel.org; Wed, 28 Oct 2020 11:23:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45622)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kXnGr-0004uo-QO
 for qemu-devel@nongnu.org; Wed, 28 Oct 2020 11:21:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:37251)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kXnGo-0006kx-QC
 for qemu-devel@nongnu.org; Wed, 28 Oct 2020 11:21:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603898509;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gymiFpXx/QXaoTKnIL+2CdOZJ95n1J4Bne6ZcGm0J3Q=;
 b=JBbtZPDA33TPrLUbIH0ON675AAyOd826qcl54RRwOwuAqyRiMDuOypF7pEBqyHGUNbHXFG
 rw5RQGkflkETAuFe+9llwOkAS2B6CVFi4aQwxXx6pa7zvfnvEOcjy5oeix39ILwEahSOTS
 uWboqJsTQB4IYjHQ8sjRs2ftfaRPnNQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-388-17rHszFMPL6En5bIHgwzDg-1; Wed, 28 Oct 2020 11:21:47 -0400
X-MC-Unique: 17rHszFMPL6En5bIHgwzDg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9CB27809DEB;
 Wed, 28 Oct 2020 15:21:45 +0000 (UTC)
Received: from localhost (ovpn-114-6.ams2.redhat.com [10.36.114.6])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2414F60C04;
 Wed, 28 Oct 2020 15:21:41 +0000 (UTC)
Date: Wed, 28 Oct 2020 15:21:41 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Subject: Re: [PATCH 17/25] block/nvme: Simplify nvme_cmd_sync()
Message-ID: <20201028152141.GL231368@stefanha-x1.localdomain>
References: <20201027135547.374946-1-philmd@redhat.com>
 <20201027135547.374946-18-philmd@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20201027135547.374946-18-philmd@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="jtcAeju3WzRmRF+o"
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/28 01:51:10
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
 qemu-block@nongnu.org, Eric Auger <eric.auger@redhat.com>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Keith Busch <kbusch@kernel.org>, Klaus Jensen <its@irrelevant.dk>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--jtcAeju3WzRmRF+o
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 27, 2020 at 02:55:39PM +0100, Philippe Mathieu-Daud=E9 wrote:
> As all commands use the ADMIN queue, it is pointless to pass
> it as argument each time. Remove the argument.
>=20
> Signed-off-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>
> ---
>  block/nvme.c | 15 ++++++++-------
>  1 file changed, 8 insertions(+), 7 deletions(-)
>=20
> diff --git a/block/nvme.c b/block/nvme.c
> index 2d3648694b0..68f0c3f7959 100644
> --- a/block/nvme.c
> +++ b/block/nvme.c
> @@ -487,9 +487,10 @@ static void nvme_cmd_sync_cb(void *opaque, int ret)
>      aio_wait_kick();
>  }
> =20
> -static int nvme_cmd_sync(BlockDriverState *bs, NVMeQueuePair *q,
> -                         NvmeCmd *cmd)
> +static int nvme_cmd_sync(BlockDriverState *bs, NvmeCmd *cmd)

Please rename the function to nvme_admin_cmd_sync() so it's behavior is
clear.

--jtcAeju3WzRmRF+o
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl+ZjIQACgkQnKSrs4Gr
c8jHXgf/Tu1ULagxVRDjcXfpPtguebcWhp+qgDtBn/b1UKIHyTarok9WeyuJi3Zp
VRiPuWpaf4HoYsmMOpdcTRi1wsvmKcE3wBTsNf/p1WMdIRWf+m63uHmB+5nxk/QH
ozpagHiHJOg063QExGRrt5AIfVSGE7H6NXSIRC+nsKI6S1hPOm/IB4c5VJCZE/SF
tdZ2XihestgpL47m3Yqaqbq87tS6cudEJa8w108uLZKehJqnz8MJqd6Pkjqlrcxi
nVAYQy8iFJYGoxTA3YEQC6FAqc35HEpMwhOCMewpHUBZVM7NLbSccuxi4VoaO21s
t8rSMj3q5tM6KoOHYt4TbNMUquWgcQ==
=uwgK
-----END PGP SIGNATURE-----

--jtcAeju3WzRmRF+o--


