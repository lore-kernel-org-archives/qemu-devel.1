Return-Path: <SRS0=IvAo=6E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8165AC38A30
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2020 16:45:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4BAE52082E
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2020 16:45:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Lde3F6Qs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4BAE52082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39278 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jQZYP-0005xy-Fc
	for qemu-devel@archiver.kernel.org; Mon, 20 Apr 2020 12:45:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52536 helo=eggs1p.gnu.org)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1jQZXR-0005Im-0r
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 12:44:53 -0400
Received: from Debian-exim by eggs1p.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1jQZXQ-0004C2-D2
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 12:44:52 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:23467
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jQZXQ-00049W-16
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 12:44:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587401091;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Utx0zh3YVLluHZlOB9J73ae73kBiXmT4KrZmTB0M478=;
 b=Lde3F6QsLHqSHc54fsMzGCPPl2K1iuu/uVH6W6PJAaig7jQH4kCd7VY7Bo6KsYr2zVVhyn
 0D5eqRUBDBalqnVB2UDTYcfXi2M2LWnBFJVxmbs0sO469bVfWksUtSHoLghbl8tnXfuvoH
 PTgzzEolCITM/aFA6R4wbIrZg6t9OQg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-30-TsAH3fLwO7u-MLgJ4gM7NA-1; Mon, 20 Apr 2020 12:44:48 -0400
X-MC-Unique: TsAH3fLwO7u-MLgJ4gM7NA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5F8921922961;
 Mon, 20 Apr 2020 16:44:47 +0000 (UTC)
Received: from localhost (ovpn-112-169.ams2.redhat.com [10.36.112.169])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DEFAD28980;
 Mon, 20 Apr 2020 16:44:46 +0000 (UTC)
Date: Mon, 20 Apr 2020 17:44:45 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Subject: Re: [PATCH 6/9] block/io: expand in_flight inc/dec section:
 block-status
Message-ID: <20200420164445.GI7321@stefanha-x1.localdomain>
References: <20200408093051.9893-1-vsementsov@virtuozzo.com>
 <20200408093051.9893-7-vsementsov@virtuozzo.com>
MIME-Version: 1.0
In-Reply-To: <20200408093051.9893-7-vsementsov@virtuozzo.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="o7gdRJTuwFmWapyH"
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

--o7gdRJTuwFmWapyH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 08, 2020 at 12:30:48PM +0300, Vladimir Sementsov-Ogievskiy wrot=
e:
> It's safer to expand in_flight request to start before enter to
> coroutine in synchronous wrappers and end after BDRV_POLL_WHILE loop.
> Note that qemu_coroutine_enter may only schedule the coroutine in some
> circumstances.
>=20
> block-status requests are complex, they involve querying different
> block driver states across backing chain. Let's expand only in_flight
> section for the top bs, keeping other sections as is.
>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  block/io.c | 60 +++++++++++++++++++++++++++++++++++++++++-------------
>  1 file changed, 46 insertions(+), 14 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--o7gdRJTuwFmWapyH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl6d0X0ACgkQnKSrs4Gr
c8hvEggAjKRQa3JdUfVOUmqS6ssxRoK6bE6oIRdhXwrIqvdQa3D+348Gt+tSUX3w
Tv8Tqd8ozcWqq8G1QBhQMlEkBgZsk83J7PZZnWE+PMX68c8QwQBK0ZhZ8Ucf626F
89ZodvyAow5SDvqf2nkckmA081KRzlMi0nLUiYdZ492ADi6V0KykEoJXnAPf1R2k
zoyWMnQrXzV9uTpcnPM5tG/dFVDmf7yezUToQZf3Jfukv44vggN1nibnbtYyYdzZ
5DbqPYbOVX/N4YQ219U1eZgKVNXoX7qjlKY3JxarcE/ppUlsdpuFC9DNx8E+nEfp
YHDuExY8T7lBhK45Ne1CChlpSjWnig==
=9Dmh
-----END PGP SIGNATURE-----

--o7gdRJTuwFmWapyH--


