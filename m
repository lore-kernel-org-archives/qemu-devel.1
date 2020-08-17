Return-Path: <SRS0=yhYb=B3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5445FC433E1
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 13:02:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 221A22075B
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 13:02:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I37ndaer"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 221A22075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50416 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k7emN-0003yb-Bv
	for qemu-devel@archiver.kernel.org; Mon, 17 Aug 2020 09:02:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46012)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1k7elR-0003Sm-Hn
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 09:01:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:26489)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1k7elO-0002pb-Gk
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 09:01:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597669281;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=M+tdAQNbM6bXLcX37havlgcqLB7a17nNiRH0llXdnWc=;
 b=I37ndaerv7YXUYDsmNAjQZ4VoqzCoIEsu55r23cmpWhVV5lCQy00uou10R9bNr00Tvm0b9
 KtQRfGRml/vmhj3/bxYbA31A+CSRF5BXGIsMrf3npgAq/qZkr6M9IFXdGFjsCJAiM71910
 RSo7A8NL639Vu/JVM6+hPOqYpF5Eh6I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-194-gt5L4u52OQekERTIWUZleQ-1; Mon, 17 Aug 2020 09:01:16 -0400
X-MC-Unique: gt5L4u52OQekERTIWUZleQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E235C185E539;
 Mon, 17 Aug 2020 13:01:14 +0000 (UTC)
Received: from linux.fritz.box (ovpn-112-160.ams2.redhat.com [10.36.112.160])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4CFDC756AD;
 Mon, 17 Aug 2020 13:01:12 +0000 (UTC)
Date: Mon, 17 Aug 2020 15:01:10 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Max Reitz <mreitz@redhat.com>
Subject: Re: [RFC PATCH 08/22] nbd: Add max-connections to nbd-server-start
Message-ID: <20200817130110.GK11402@linux.fritz.box>
References: <20200813162935.210070-1-kwolf@redhat.com>
 <20200813162935.210070-9-kwolf@redhat.com>
 <f5e68d28-d8cc-c906-e4c4-177ca6cf1664@redhat.com>
MIME-Version: 1.0
In-Reply-To: <f5e68d28-d8cc-c906-e4c4-177ca6cf1664@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kwolf@redhat.com
X-Mimecast-Spam-Score: 0.0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="YD3LsXFS42OYHhNZ"
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/17 01:24:49
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--YD3LsXFS42OYHhNZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 17.08.2020 um 14:37 hat Max Reitz geschrieben:
> On 13.08.20 18:29, Kevin Wolf wrote:
> > This is a QMP equivalent of qemu-nbd's --share option, limiting the
>=20
> *--shared
>=20
> > maximum number of clients that can attach at the same time.
> >=20
> > Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> > ---
> >  qapi/block-export.json         | 10 ++++++++--
> >  include/block/nbd.h            |  3 ++-
> >  block/monitor/block-hmp-cmds.c |  2 +-
> >  blockdev-nbd.c                 | 33 ++++++++++++++++++++++++++-------
> >  qemu-storage-daemon.c          |  4 ++--
> >  5 files changed, 39 insertions(+), 13 deletions(-)
>=20
> I suppose this is part of this series so that patch 11 can happen?

More like because initially I thought it would be needed for patch 11,
and when I realised that server !=3D export and it's not really needed, I
still didn't want to throw the patch away...

I could make it a patch separate from this series if that's helpful.

Kevin

--YD3LsXFS42OYHhNZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE3D3rFZqa+V09dFb+fwmycsiPL9YFAl86f5YACgkQfwmycsiP
L9bSpw/8DEIGzdW8ktkm549g7Drm6rfZB1J5wqarldd9aUnthxlupJBH9n6jgjF6
LGPxC6xtJ9VuyxwWPtMSDtddvgoQhNQhZv+y/BSkSA5YSojT6aGxSQB1QgSL8lr8
ZqFYGWI9+lQDrovAy/YfbX0Ei7UtQxzgVK+ntHEB09SoOP27hfgfe2/Kn/kRMF7j
C53S15IuxUzUJ0Tslfj6+heQVYbL7YGl/HHET6Oxy/Ox60wsiHWHropA2RbBO16Y
zrU38g2jqlpnfgABHj44nS+/vQ4NgbJPoaWfAxuN1N6pAu2MEkacb8tW1Rv0SVsW
9w56JM0C/G2U6juU8l5JR2q3SITeoai6lzkOlwGsWnx2RMqTZv4XIzu4oTS5eYBM
dxGjj3dz3wW2oDKFpcUztsMcy6raYa1PO+Lm8bjYFnoLdpYzZAelOWfBsxTVthFL
tRvC6JKJCMKL1aeyF56Dk/UYn8gV7SwArCwlWBxi7o0atfKZmwWq5y3s5odiVfku
EqOXzgvlR3rimn/uQRPm7GUiiEBc8vg2BH/QVdEySsm/9Px9yeDFG+B+nZI9P4Pc
Pho/X5RrtShwy0QHlZr4+1M0+BLmqQlFlbp/9TgkWwRdCL32MVgznCrNwTx/ebHJ
1Aey5HKJUUc6tbbwcmlYz2m0wuY3W0hqu5CvQiyWQM9XYSxPwSs=
=Rxkq
-----END PGP SIGNATURE-----

--YD3LsXFS42OYHhNZ--


