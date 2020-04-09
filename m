Return-Path: <SRS0=qpXq=5Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93A94C2BA19
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Apr 2020 17:02:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B32020678
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Apr 2020 17:02:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dhSyBoE+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B32020678
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52918 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jMaZ9-0005Gl-I2
	for qemu-devel@archiver.kernel.org; Thu, 09 Apr 2020 13:02:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60762)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1jMaXj-0004aZ-7F
 for qemu-devel@nongnu.org; Thu, 09 Apr 2020 13:00:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1jMaXi-0000fb-B2
 for qemu-devel@nongnu.org; Thu, 09 Apr 2020 13:00:43 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:28738
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1jMaXi-0000ek-7S
 for qemu-devel@nongnu.org; Thu, 09 Apr 2020 13:00:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1586451641;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FWxy6fw2uZVAl0dRQZsq8Rxx/e1sK25ara4uoHFT7Zk=;
 b=dhSyBoE+C6FDkzVXKe7NPTaFrsejy3Jq4XBE5f4RuC5r62Tg67kRzy7Av28Hqx4SZ45Agi
 0cD9EH3q1HupnwNlL+wwmg7f3BmOfagci0GM7uAYFl7PRNILjW9vmvHkDHpTHdRTxlTCmV
 fHENPC9jRxIo0YrMg6x8KkPxMJOpo9E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-346-Z2aCQLziOXikqwIRgX5s4g-1; Thu, 09 Apr 2020 13:00:37 -0400
X-MC-Unique: Z2aCQLziOXikqwIRgX5s4g-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0F8501800D71;
 Thu,  9 Apr 2020 17:00:36 +0000 (UTC)
Received: from localhost (ovpn-114-141.ams2.redhat.com [10.36.114.141])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8BECB272CC;
 Thu,  9 Apr 2020 17:00:35 +0000 (UTC)
Date: Thu, 9 Apr 2020 18:00:34 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Subject: Re: [PATCH for-5.0? 0/9] block/io: safer inc/dec in_flight sections
Message-ID: <20200409170034.GD319181@stefanha-x1.localdomain>
References: <20200408093051.9893-1-vsementsov@virtuozzo.com>
MIME-Version: 1.0
In-Reply-To: <20200408093051.9893-1-vsementsov@virtuozzo.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="5gxpn/Q6ypwruk0T"
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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

--5gxpn/Q6ypwruk0T
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 08, 2020 at 12:30:42PM +0300, Vladimir Sementsov-Ogievskiy wrot=
e:
> Hi all!
>=20
> This is inspired by Kevin's
> "block: Fix blk->in_flight during blk_wait_while_drained()" series.
>=20
> So, like it's now done for block-backends, let's expand
> in_flight-protected sections for bdrv_ interfaces, including
> coroutine_enter and BDRV_POLL_WHILE loop into these sections.

This looks like a code improvement but let's leave it for the next
release since QEMU 5.0 is in freeze and this patch series does not fix a
specific user-visible bug.

I will review this in depth next week.  Thanks!

Stefan

--5gxpn/Q6ypwruk0T
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl6PVLIACgkQnKSrs4Gr
c8gfrQf/Scnt3M3ZHV/OQ6HdXJVXRwUvCGL0cruDHEgZed7+Ag758RR6aaJT+d4m
qOx98tu3ZJwpFSQ+e6Uj49x/CMVHAX1wDJtV2QMRmmL9fq0yr4xAgynqLTHooihK
x77KkyKdxrFoh4cihhBi30rL9ef4arWL63IOX5JLkL4YC40AElyXo6W3Tycwtbmj
Q1EGH4OQOc8xL0GfLGhNh3XavfS9KHzbIe2eZevx/Rlqc6HUFjIpfJKufuqLUPGC
4pLZIlIT5DqNfWNW8ukzHKrn1evLiFG0OZtjodao4T9YXl6IYkeQ58bIh/O0pzNW
9EM+GVux2fyN/gONymoism761W2PSw==
=psMA
-----END PGP SIGNATURE-----

--5gxpn/Q6ypwruk0T--


