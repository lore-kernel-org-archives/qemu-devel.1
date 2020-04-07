Return-Path: <SRS0=U3m5=5X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE14BC2BB1D
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2020 11:14:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A66AA206F7
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2020 11:14:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="acIxBblI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A66AA206F7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45346 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jLmB6-0008Go-U3
	for qemu-devel@archiver.kernel.org; Tue, 07 Apr 2020 07:14:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49767)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1jLmAS-0007Ta-2b
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 07:13:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1jLmAR-0007Iv-2i
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 07:13:20 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:40233
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1jLmAQ-0007Ih-VN
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 07:13:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1586257998;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GOmyV5X0+cGJYLY7zlc8NDLRi52E/+j70sgHsWN62Ss=;
 b=acIxBblIIAxGJtfYZweJP29C8fJJJpXYQiZqGGMVqyBTQO9enzGJtrmWXR9a+xlS2BDF0P
 FZcOfY7pbuM7UCKqavylLuPXBA/+En5vK97tegLqMJ18tM1cOTLtHkOFK7lfJzt5aw3Wvk
 s7FBRCjxyqBW4Wnzh7kIAHPq6DptOHk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-412-mYtj3WtHPGefYVjWTQQZyQ-1; Tue, 07 Apr 2020 07:13:14 -0400
X-MC-Unique: mYtj3WtHPGefYVjWTQQZyQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 97A2718B9FC2;
 Tue,  7 Apr 2020 11:13:12 +0000 (UTC)
Received: from linux.fritz.box (ovpn-113-253.ams2.redhat.com [10.36.113.253])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 04B5D60BEC;
 Tue,  7 Apr 2020 11:13:05 +0000 (UTC)
Date: Tue, 7 Apr 2020 13:13:04 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Max Reitz <mreitz@redhat.com>
Subject: Re: [PATCH for-5.0 v2 2/3] block: Increase BB.in_flight for
 coroutine interfaces
Message-ID: <20200407111304.GD7695@linux.fritz.box>
References: <20200406171403.6761-1-kwolf@redhat.com>
 <20200406171403.6761-3-kwolf@redhat.com>
 <5c5ee71e-f2d7-201d-73d1-2ee9a68b042a@redhat.com>
 <eead4e39-0784-1550-f245-ebe98e73f17e@redhat.com>
MIME-Version: 1.0
In-Reply-To: <eead4e39-0784-1550-f245-ebe98e73f17e@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="XsQoSWH+UP9D9v3l"
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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

--XsQoSWH+UP9D9v3l
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 07.04.2020 um 12:15 hat Max Reitz geschrieben:
> On 07.04.20 12:04, Max Reitz wrote:
> > On 06.04.20 19:14, Kevin Wolf wrote:
> >> External callers of blk_co_*() don't currently increase the
> >> BlockBackend.in_flight counter, but calls from blk_aio_*() do, so ther=
e
> >> is an inconsistency whether the counter has been increased or not.
> >>
> >> This patch moves the actual operations to static functions that can
> >> later know they will always be called with in_flight increased exactly
> >> once, even for external callers using the blk_co_*() coroutine
> >> interfaces.
> >>
> >> If the public blk_co_*() interface is unused, remove it.
> >>
> >> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> >> ---
> >>  include/sysemu/block-backend.h |  1 -
> >>  block/block-backend.c          | 94 +++++++++++++++++++++++++++------=
-
> >>  2 files changed, 76 insertions(+), 19 deletions(-)
> >=20
> > Reviewed-by: Max Reitz <mreitz@redhat.com>
>=20
> On second thought (I assumed this would be addressed by the third
> patch), blk_prw() no longer increments in_flight, but the blk_co_*
> functions do that now.  In v1, blk_prw() did that.
>=20
> I thought we=E2=80=99d want blk_prw() to set in_flight, just like blk_aio=
_prwv()
> does, and then let the synchronous functions that use blk_prw() pass the
> blk_do_* functions to it.

Does it make a difference, though?

But the change should be easy enough (inc/dec in blk_prw() and the let
*_entry() call blk_do_*() instead of blk_co_*()) that I guess I can just
do it and send a v3.

Kevin

--XsQoSWH+UP9D9v3l
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJejGBAAAoJEH8JsnLIjy/WAKAQAJhq93vOoikb0jc9CTW+Vu70
Eore5Ay7hgp1cbZfD0SwOmJdVS7wFP0cjNkwohNatReFttCfHlbZA/PHQ9eYHGrn
+HgctvVImrjpSFGE8zJck2QzjIMX0M8WSkW6jdk5VlGVHlUQA9bKsoXNHRqU/i+M
NTFLfleN7i/pRBBI0p/jxPn60zFheXjZ1E8holZSinyXKQVQBOKLE967DnRe4Sps
tMO+WrGAet0ZG2vxfQPHC2Ub3yJGkQXuYlaW4gmyFv1ujqzs1JQpgj7dQ6yWY60A
3Lc5I4LeP/XhSwcAP3tKPV15a0BOv8cdJoaj3c54ClhvLTS6rL/2G9hPZvFG+zlQ
Tx4hAFwTP2lLq7j1wDwzFPPrplW+tIQALn8cWZ3nXVt22+rCjMCIAEcq1e9UZPGy
ia53VkwRkoDTpggywucTwAL2lRn0C5Ro8iszg3wXoD+w9nM8sM/E3DKNgvCsCcA1
u0LDmzkpOSwYtSCRaVBS4XDtpIDevEiOah2oEJeZ7mX2Spt+2vERqpSYm/bmxo5w
eTC6jjUDSK05b2RwrwZxlX8Fe5uG0J7KgdZmlJuGc6huYc8Q5tm7x4UpmoKKk4W1
L8vzVpX53yDPuQXIxzfuQsygyXxEVZH7+GeAsEYhkK0QcMHIvjC3BWw6pwud0eki
4v9WzBbiqNWGrZSDQyGL
=xsJI
-----END PGP SIGNATURE-----

--XsQoSWH+UP9D9v3l--


