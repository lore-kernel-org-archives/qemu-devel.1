Return-Path: <SRS0=URa6=5T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73A13C2BA12
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2020 14:51:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B97C206F5
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2020 14:51:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QQvEwfS4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B97C206F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56570 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jKNfg-0003NP-Cl
	for qemu-devel@archiver.kernel.org; Fri, 03 Apr 2020 10:51:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44882)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1jKNeQ-0002fv-7K
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 10:50:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1jKNeP-0001Pp-1M
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 10:50:30 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:28159
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1jKNeO-0001PD-TB
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 10:50:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585925428;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=BKX+ya1UavVEfubPGRUXTecUf4mH6xSiQgkhK9oE4MI=;
 b=QQvEwfS4N0XcQaLQ2h5qUW9+79ganQu+y85+aOzo3lXbQnh3CR5FGmeY3IZCIXoA2M2imA
 lEVNj9rG8P0XhMVRtDWBg2R/xSasigWPFWC0/KS9Dtr7bnoGvz+gFxtWvLkOwWvmqR2Yyu
 7n60A6jJi1CHZPW71QbXnjULWQGYbyc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-186-M9RWldS5OlKaMerI5kPMOQ-1; Fri, 03 Apr 2020 10:50:25 -0400
X-MC-Unique: M9RWldS5OlKaMerI5kPMOQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BADE98017F3;
 Fri,  3 Apr 2020 14:50:23 +0000 (UTC)
Received: from linux.fritz.box (ovpn-113-132.ams2.redhat.com [10.36.113.132])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D66FB50BEE;
 Fri,  3 Apr 2020 14:50:18 +0000 (UTC)
Date: Fri, 3 Apr 2020 16:50:17 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Max Reitz <mreitz@redhat.com>
Subject: Re: [PATCH for-5.0 2/2] block: Fix blk->in_flight during
 blk_wait_while_drained()
Message-ID: <20200403145017.GE5336@linux.fritz.box>
References: <20200403104415.20963-1-kwolf@redhat.com>
 <20200403104415.20963-3-kwolf@redhat.com>
 <30e7194e-afbc-2822-f086-9891539c0e3a@redhat.com>
MIME-Version: 1.0
In-Reply-To: <30e7194e-afbc-2822-f086-9891539c0e3a@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="8P1HSweYDcXXzwPJ"
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
Cc: vsementsov@virtuozzo.com, qemu-block@nongnu.org, s.reiter@proxmox.com,
 qemu-devel@nongnu.org, t.lamprecht@proxmox.com, stefanha@redhat.com,
 dietmar@proxmox.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--8P1HSweYDcXXzwPJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 03.04.2020 um 14:42 hat Max Reitz geschrieben:
> On 03.04.20 12:44, Kevin Wolf wrote:
> > Calling blk_wait_while_drained() while blk->in_flight is increased for
> > the current request is wrong because it will cause the drain operation
> > to deadlock.
> >=20
> > Many callers of blk_wait_while_drained() have already increased
> > blk->in_flight when called in a blk_aio_*() path, but can also be calle=
d
> > in synchonous code paths where blk->in_flight isn't increased. This
> > means that these calls of blk_wait_while_drained() are wrong at least i=
n
> > some cases.
> >=20
> > In order to fix this, increase blk->in_flight even for synchronous
> > operations and temporarily decrease the counter again in
> > blk_wait_while_drained().
> >=20
> > Fixes: cf3129323f900ef5ddbccbe86e4fa801e88c566e
> > Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> > ---
> >  block/block-backend.c | 8 ++++----
> >  1 file changed, 4 insertions(+), 4 deletions(-)
>=20
> blk_co_pdiscard() and blk_co_flush() are called from outside of
> block-backend.c (namely from mirror.c and nbd/server.c).  Is that OK?

Hm... I think you're right that the NBD server has a problem now because
we might now decrease blk->in_flight without having increased it.
(Mirror should be fine anyway because it sets disable_request_queuing.)

At first I was going to suggest that we could do the opposite of this
patch and just move the dec/wait/inc sequence (which this patch removes
for read/write) to all coroutine entry functions, so direct calls
wouldn't incorrectly decrease the counter.

But this is not what we want either, we do want to queue requests for
drained BlockBackends even in the blk_co_*() API.

Do you have another idea or do we have to turn blk_co_*() into wrappers
around the existing functions, which would gain an additional bool
parameter that tells whether we need to dec/inc or not?

Kevin

--8P1HSweYDcXXzwPJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJeh00pAAoJEH8JsnLIjy/W6q8P/01U203iHotCGLaYOkdmep9E
tMf9vzIdZHXRARhYNxmurEllp+2wdAZPZ2KQLI9tZ2pE3zPGeBElV56WysROGUvA
x6ybxQfb7mi/k71cegMrvbVCPyN9GhpAaB4iLPMQf7seTCKiWGSzVaA7iZWK+kVf
jwf22vYpWWV3/PNLoebkSyBBP3Ub+lSzoe9jcGMflADLF+xKTuW2HI6pTMVvtXsF
Kwww+o30b8plb8QlK4BJSaa7KLGsW0N0284oz1kaaiGOIyhXRN7e5b4MM8nNTq9E
yKhkrGKjCbdiz3oEfO1b4HkzVALjzG6XoKNEWMC+90cVfIpAuqoV5I9zJgO5ff45
HfpE/uwg7UAT+ZaH1KZrWMkDwtj2ug5LwCWZChUU0P93ft5CNwX058diIjr3F1wk
zX+/fJ73pRPlRYrRFgudKEvCieoV3BXTgerdw9mlwnbAFsIw4Md0JYtpg5RqhxN5
OMl9gvUwilXxSTpKn167XGAgME/OESxpMFZrW2EW+29w9EN1rRiRcHqd5wAOORBJ
qvj8YLNenbXf8QUZSo6d8KmVW+gLvQuj092xGx6yQ95W/QXBm2fhRM0DqEwGbynd
7V5EZnG6S31Ljg29Sh7wekk3AvVU8KFrNjIVsZubhGlFVGxtaIlgK/NE7A+tILRq
+J58UiV7KLAU83x5+t+I
=SFYQ
-----END PGP SIGNATURE-----

--8P1HSweYDcXXzwPJ--


