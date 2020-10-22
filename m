Return-Path: <SRS0=9x1+=D5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBA98C388F7
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2020 14:21:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D578C2225F
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2020 14:21:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WyCPcjZZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D578C2225F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43916 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVbSq-0006Zf-Jp
	for qemu-devel@archiver.kernel.org; Thu, 22 Oct 2020 10:21:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45664)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kVbMH-0001Pj-2H
 for qemu-devel@nongnu.org; Thu, 22 Oct 2020 10:14:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:54959)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kVbM7-0001bJ-IW
 for qemu-devel@nongnu.org; Thu, 22 Oct 2020 10:14:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603376048;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=V2xK11XbU/VDmxYzMBhTBlptA54B/XOwMFlBmdk3mBs=;
 b=WyCPcjZZKNooHV5q+ZsluZVnX4KIkEnDyJntaAqylJyJHwbs1Ss9o5g7qfs6UyhjQ/Hp8c
 I6+nVEt68nCC3lFuuz1daD2ivfaHu9JGGS1a0cMpO9UWZAOwZ1QqZk+CZnAVYoRDYLN86Q
 DLhl2vPSBOYnMwn5ZkcIwLOgGtWWsNg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-512-Gf948PgDO-W80ZPuXyyZtA-1; Thu, 22 Oct 2020 10:14:05 -0400
X-MC-Unique: Gf948PgDO-W80ZPuXyyZtA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BEA641020904;
 Thu, 22 Oct 2020 14:14:04 +0000 (UTC)
Received: from localhost (ovpn-114-229.ams2.redhat.com [10.36.114.229])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7C1025B4B2;
 Thu, 22 Oct 2020 14:14:00 +0000 (UTC)
Date: Thu, 22 Oct 2020 15:13:59 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Subject: Re: [PATCH 07/16] util/vfio-helpers: Trace where BARs are mapped
Message-ID: <20201022141359.GG761187@stefanha-x1.localdomain>
References: <20201020172428.2220726-1-philmd@redhat.com>
 <20201020172428.2220726-8-philmd@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20201020172428.2220726-8-philmd@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="qoTlaiD+Y2fIM3Ll"
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/22 08:09:01
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

--qoTlaiD+Y2fIM3Ll
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 20, 2020 at 07:24:19PM +0200, Philippe Mathieu-Daud=E9 wrote:
> For debugging purpose, trace where a BAR is mapped.
>=20
> Reviewed-by: Fam Zheng <fam@euphon.net>
> Signed-off-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>
> ---
>  util/vfio-helpers.c | 2 ++
>  util/trace-events   | 1 +
>  2 files changed, 3 insertions(+)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--qoTlaiD+Y2fIM3Ll
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl+Rk6cACgkQnKSrs4Gr
c8irswf+JRxE0rgP9OQFQiFyHViti/gX94F/S8NCzzXNJaVFiimv8Vg7DW3inDRU
CGXVTuvgBbrOrBAT9mdv3UoEBvQuzwXv8t1qeLUk2RSkSPjmRIKp7S6g8tksh6hS
Z59VXaD8IyAAGK8p1dgx/naVUneOBnda+nHFheSm6S741RV7wAWPiK9AJ165l0yt
SQY9hXpJ4XIsBmmHn1j87YaYlkkpZnExLdC8WwU8SwbX6ou2IyDCpUPyLO0xHvSH
hOFre3QCivIqKRpwK1ETFRJYxhLS+9SKzLCTZ0KjICxbQdpGdGrAY04Z1kwVvHvy
QCoQUCAkE5b122wZ2Hm+DVT1r4wpbw==
=2gcd
-----END PGP SIGNATURE-----

--qoTlaiD+Y2fIM3Ll--


