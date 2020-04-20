Return-Path: <SRS0=IvAo=6E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D520FC3815B
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2020 15:59:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9AFA72074F
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2020 15:59:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DoIzfI7n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9AFA72074F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38324 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jQYpc-00043b-Jp
	for qemu-devel@archiver.kernel.org; Mon, 20 Apr 2020 11:59:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43602 helo=eggs1p.gnu.org)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1jQYoJ-0002w4-OY
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 11:58:16 -0400
Received: from Debian-exim by eggs1p.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1jQYoJ-0006zT-C0
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 11:58:15 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:54077
 helo=us-smtp-1.mimecast.com)
 by eggs1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jQYoI-0006wi-Um
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 11:58:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587398292;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hfyhM1NsYYHgrXX+GLtzcqWxxj19IVykyFyHBjqUSJ4=;
 b=DoIzfI7nlYh0z8wL8jv4Dikw1P/5MEmCQOZrZBRE7FO+mp6ZRWGUj6eeBoPST8aBhvzGxe
 VICGyMVYsYdGD+8vyRobEhgeehJVuUvjBTQd+LY99lBqtX4wewaEL15awfvATQBWSNZgkh
 dZ6lFfUN7MbBGnJGW7POjYnnuTYX+o8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-297-CT1S6upVNsGw6K3VCdEUdw-1; Mon, 20 Apr 2020 11:58:08 -0400
X-MC-Unique: CT1S6upVNsGw6K3VCdEUdw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 45EC4DBB1;
 Mon, 20 Apr 2020 15:57:57 +0000 (UTC)
Received: from localhost (ovpn-112-169.ams2.redhat.com [10.36.112.169])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 920E829340;
 Mon, 20 Apr 2020 15:57:55 +0000 (UTC)
Date: Mon, 20 Apr 2020 16:57:54 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Subject: Re: [PATCH 2/9] block/io: refactor bdrv_co_ioctl: move aio stuff to
 corresponding block
Message-ID: <20200420155754.GB7321@stefanha-x1.localdomain>
References: <20200408093051.9893-1-vsementsov@virtuozzo.com>
 <20200408093051.9893-3-vsementsov@virtuozzo.com>
MIME-Version: 1.0
In-Reply-To: <20200408093051.9893-3-vsementsov@virtuozzo.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="xXmbgvnjoT4axfJE"
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=stefanha@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs1p.gnu.org: First seen = 2020/04/20
 03:29:13
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
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
Cc: kwolf@redhat.com, fam@euphon.net, qemu-block@nongnu.org,
 qemu-devel@nongnu.org, mreitz@redhat.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--xXmbgvnjoT4axfJE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Apr 08, 2020 at 12:30:44PM +0300, Vladimir Sementsov-Ogievskiy wrote:
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  block/io.c | 23 +++++++++++++++--------
>  1 file changed, 15 insertions(+), 8 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--xXmbgvnjoT4axfJE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl6dxoIACgkQnKSrs4Gr
c8ibbwgAkQPiIBxzd80pbK6i4m9g+uERjxKPyUB9rCfIf2xpAP21r8MkSQ6mCWGJ
096BjY9n1Iz0TtrqMAQvc+BuLLr1mSmNC5AAlKByjFWgGPIrob69TxsW0dRrNuio
3qnTvPvBlSRGdsISBmVev5AYH6q+OxpUFC6nQ5PBa26y2BoLZZOesoSJ9PM9/k31
6sIKqZpQ/IBHWTX8pC982+2XKMDU4u2s7Wl+5T2Pb79WVT58ZOO4QIRJeR3auHlG
HiO/vVNyMdTMKsNmP2K33MERnWgrkO9+tFPdLJFLr+PjVhSyoAJyzJFlvhL7y/6z
pl6YX1p3XYAO25n4gXH3OSFVhbzcGA==
=Ulmv
-----END PGP SIGNATURE-----

--xXmbgvnjoT4axfJE--


