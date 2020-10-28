Return-Path: <SRS0=Un+l=ED=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25D68C388F7
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 15:36:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 617CA24790
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 15:36:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f3+eUa+z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 617CA24790
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46852 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXnUm-00028x-Ub
	for qemu-devel@archiver.kernel.org; Wed, 28 Oct 2020 11:36:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47944)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kXnPQ-0007NL-8k
 for qemu-devel@nongnu.org; Wed, 28 Oct 2020 11:30:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:47540)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kXnPJ-000895-3I
 for qemu-devel@nongnu.org; Wed, 28 Oct 2020 11:30:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603899035;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gHnokdNVoAuzyfUswOWzvEZl0f1OjIiNr+YLOO+qlKc=;
 b=f3+eUa+zOGbUaMulxzKuyF9jiD6UZ0tkI0X6EygAY3R4CDn7XC7iNOYmFfZikAMwbc/Wv9
 /JdEWkLFN1qDep0hknefs+7XZHM8JeW54vAsO8CpjYrXn8SY1bCinIbcUF6zPJy9GzZyeG
 iVoLLxKp3fm/5W2+QnLypJ7bm8tnERs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-186-EDeqgaAuMAe3x5PXS7FAEg-1; Wed, 28 Oct 2020 11:30:30 -0400
X-MC-Unique: EDeqgaAuMAe3x5PXS7FAEg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 73DE88070F7;
 Wed, 28 Oct 2020 15:30:28 +0000 (UTC)
Received: from localhost (ovpn-114-6.ams2.redhat.com [10.36.114.6])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D8E8010013D9;
 Wed, 28 Oct 2020 15:30:24 +0000 (UTC)
Date: Wed, 28 Oct 2020 15:30:23 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Subject: Re: [PATCH 18/25] block/nvme: Pass AioContext argument to
 nvme_add_io_queue()
Message-ID: <20201028153023.GM231368@stefanha-x1.localdomain>
References: <20201027135547.374946-1-philmd@redhat.com>
 <20201027135547.374946-19-philmd@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20201027135547.374946-19-philmd@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="yaap9KN+GmBP785v"
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

--yaap9KN+GmBP785v
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 27, 2020 at 02:55:40PM +0100, Philippe Mathieu-Daud=E9 wrote:
> We want to get ride of the BlockDriverState pointer at some point,
> so pass aio_context along.

Potential future changes are a weak justification. Someone else might
decide that the aio_context argument is redundant and reverse this
change. Either way works, so this change is somewhat arbitrary at the
moment.

A strong justification would be if the next patch removes the BDS
pointer argument.

Until this change is necessary I would prefer not to include it. That
saves reviewer time, reduces the risk of introducing bugs, etc.

--yaap9KN+GmBP785v
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl+Zjo8ACgkQnKSrs4Gr
c8hxNgf/a8byVtNqFmcAzSqb/fqNBxebzRDERD430n0WWTQJLFWmgfOGbV7DsPIY
Gm8zur41cQdfV0qsspZplP2yGkMDgbiriEtfF7HXezEAOaeqGFXUF0hPk/4uSLcA
pUdnAhGvVaTF0psvMs/0RT0hmPxsCIQlGmLMgq9AcvNIf/P4GDT/Bs6+qYAT/FoU
9jA5vKn4ltji0SQ3cP05tvtyfg4lk/xIWhm3UQmFSetbnxAh0I/lrizsXxY5Hk9y
2xCaC988RaIxL+JRdZ+7M3P6yMtt58I4sggkPvuB+qOZwlA++TisJYY5RrnMuQZx
6tgQlIMKfopI9GMVP54PI7ON2I/KYA==
=NeW9
-----END PGP SIGNATURE-----

--yaap9KN+GmBP785v--


