Return-Path: <SRS0=IvAo=6E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4324C54FCB
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2020 15:58:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A12BA206DD
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2020 15:58:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ipokJJBi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A12BA206DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38310 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jQYod-0002yc-S0
	for qemu-devel@archiver.kernel.org; Mon, 20 Apr 2020 11:58:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43334 helo=eggs1p.gnu.org)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1jQYn6-0001xy-Fa
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 11:57:02 -0400
Received: from Debian-exim by eggs1p.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1jQYn6-0002cL-3S
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 11:57:00 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:55668
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jQYn5-0002Su-Lt
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 11:56:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587398218;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZTBTL8wrLjYS5g/UbMYpUPOSFFT/s1iKFd9ZeGtINQ8=;
 b=ipokJJBiHp41AdYxUxnieTzNqj1OYJJa3raEMeJh6lKPe0aGAiZHWGQfvIWiL1+5/UkI7M
 Q63CMqp639qz63jTAV+Z8JM+B5oeA5Ugee8bDzKLrq3IjlRRpP7xH/Vfa8a8sXKwj+d3FX
 SjQgBuJSE7YlwvN1YdlJyoM2/c1mVYs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-376-dfw92eYcP8uD9Oo7EgeQ-g-1; Mon, 20 Apr 2020 11:56:56 -0400
X-MC-Unique: dfw92eYcP8uD9Oo7EgeQ-g-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 323A910CE791;
 Mon, 20 Apr 2020 15:56:55 +0000 (UTC)
Received: from localhost (ovpn-112-169.ams2.redhat.com [10.36.112.169])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8AC105C1B2;
 Mon, 20 Apr 2020 15:56:54 +0000 (UTC)
Date: Mon, 20 Apr 2020 16:56:53 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Subject: Re: [PATCH 1/9] block/io: refactor bdrv_is_allocated_above to run
 only one coroutine
Message-ID: <20200420155653.GA7321@stefanha-x1.localdomain>
References: <20200408093051.9893-1-vsementsov@virtuozzo.com>
 <20200408093051.9893-2-vsementsov@virtuozzo.com>
MIME-Version: 1.0
In-Reply-To: <20200408093051.9893-2-vsementsov@virtuozzo.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="cWoXeonUoKmBZSoM"
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs1p.gnu.org: First seen = 2020/04/20
 09:01:45
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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

--cWoXeonUoKmBZSoM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Apr 08, 2020 at 12:30:43PM +0300, Vladimir Sementsov-Ogievskiy wrote:
> +int coroutine_fn
> +bdrv_is_allocated_above(BlockDriverState *top, BlockDriverState *base,
> +                        bool include_base, int64_t offset, int64_t bytes,
> +                        int64_t *pnum)

s/coroutine_fn//

Only functions that must be called from coroutine context should be
marked as coroutine_fn.  Since this function supports both contexts, so
it doesn't apply here.

--cWoXeonUoKmBZSoM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl6dxkUACgkQnKSrs4Gr
c8hPTQf+M1siFRipd8K/2hKw57sPHZCLRh2Mke4u7zPrYuouhtotCLgr3GQ0wKfM
TPAUqbJPNGnH8mIvuehO5UvLLsPWEoaY17hdNOPenFXfr1cn52o3/LwMJlvAe9Kr
xxACkvvjIfrtsvQ1LjJoDUN9gq3Qc2Mti0F1yW/bFQYD7L7/G1Nbx3k5gob8AV/1
SKi6pi5BnHAS1RYqsS6hbwXOUzA5b76nyJ58bgqEbVpgv6O1jzjSpWWYs571S1a0
Zfyb2Fa1Q/FfKZ8xmGJvC5QK7NpAnVMfs6TbjTOM2CTfNu4piKk1BqIRk4OZidkg
Uayr0RhbBzZS280T80irwXkOC2AlGA==
=kpvL
-----END PGP SIGNATURE-----

--cWoXeonUoKmBZSoM--


