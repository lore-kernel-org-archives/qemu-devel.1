Return-Path: <SRS0=h+Ky=AR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E99BC433E0
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 11:39:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 03F4D206E9
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 11:39:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GBd3xoub"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03F4D206E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39820 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jsPSq-00077Q-9P
	for qemu-devel@archiver.kernel.org; Mon, 06 Jul 2020 07:39:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45440)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jsPRq-0006Kb-Kg
 for qemu-devel@nongnu.org; Mon, 06 Jul 2020 07:38:10 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:27455
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jsPRp-0002E4-4E
 for qemu-devel@nongnu.org; Mon, 06 Jul 2020 07:38:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594035488;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ctMmVIgjRWZa+Y4JwKZeihi67g6iSxJzhvjIS+a1oEw=;
 b=GBd3xoubS5HDIr2FbbKGTe72HVzYS+N5caYELIPn1aJFw/pNL92Qj+sO3pFnflZCHMPfgN
 9t2w0PPSvSHlqfhjXQjAPYpg2LbvGP8QyKJubnTD0GGjOqbAOS410P5XJ4vf/iGPRi783r
 bDVoTqb/rseSB+dSW95y1+UcQbce6fo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-394-DcVQSA8aNVeGMRKEfKNJrQ-1; Mon, 06 Jul 2020 07:38:04 -0400
X-MC-Unique: DcVQSA8aNVeGMRKEfKNJrQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 23118A0BDE;
 Mon,  6 Jul 2020 11:38:03 +0000 (UTC)
Received: from localhost (ovpn-114-217.ams2.redhat.com [10.36.114.217])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 749BA7B411;
 Mon,  6 Jul 2020 11:38:02 +0000 (UTC)
Date: Mon, 6 Jul 2020 12:38:01 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Subject: Re: [PATCH v3 06/16] block/nvme: Use common error path in
 nvme_add_io_queue()
Message-ID: <20200706113801.GB342708@stefanha-x1.localdomain>
References: <20200704213051.19749-1-philmd@redhat.com>
 <20200704213051.19749-7-philmd@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200704213051.19749-7-philmd@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="nVMJ2NtxeReIH9PS"
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=stefanha@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/06 01:22:37
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
 qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Maxim Levitsky <mlevitsk@redhat.com>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--nVMJ2NtxeReIH9PS
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 04, 2020 at 11:30:41PM +0200, Philippe Mathieu-Daud=E9 wrote:
> Rearrange nvme_add_io_queue() by using a common error path.
> This will be proven useful in few commits where we add IRQ
> notification to the IO queues.
>=20
> Signed-off-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>
> ---
>  block/nvme.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--nVMJ2NtxeReIH9PS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl8DDRkACgkQnKSrs4Gr
c8gFywgAhEd0SVagFdImUbSFTKfZlHacBCHs5dQJWfnUZI+AIUMtfMM0SugkucPO
vVupzoToYeJ9dRfzq/VldeyHvlWyuFG3y+8m19caZtl16vEkwXcDgrHLERpGgKwQ
6Yb+/SViMQyRzHUe6NeC0ZnVvD6kCtC/669fbGq94ftG/AU9bBd3yS+tjLN2O3wZ
ilCmnc7nhfZKtLWjYL7JHctJKdbXIJ5ou7q+4gR/rLOsn63k3BkcKe8REa5rirM1
WCXms4vo3n1gl8OW3BzP/5dt7IaIxJB5/2Ud7U9JrbS4/6oc6p4hCkY2f8iTir4E
t1F/y39wda5zpNQchNjkKXJ+E4luxA==
=Wdjb
-----END PGP SIGNATURE-----

--nVMJ2NtxeReIH9PS--


