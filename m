Return-Path: <SRS0=Q6KP=2B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43736C43603
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2019 17:38:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D99B20637
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2019 17:38:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iZ35iD8I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D99B20637
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47000 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1if5wV-0000KV-7Z
	for qemu-devel@archiver.kernel.org; Wed, 11 Dec 2019 12:38:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53046)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1if5vt-0008EO-4g
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 12:37:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1if5vr-0001yi-Jw
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 12:37:52 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:31298
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1if5vr-0001xz-GT
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 12:37:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576085871;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pWIYYDIqxFQrMnbHb7i+JJOBoSDL2kGf0VMHwE0d70U=;
 b=iZ35iD8I+wp6bFNqQzRuUu84MYNYom+ynydT8mf1SUwesyjEx9yt80opIwqzaxS4J6xtuy
 +/h8W+rJEqm8q32UfWMqh7qE0qXD78aQMfvgvcQy3yKIBJ8Qre9uEPCUe8oRcMJ8z532oo
 zBZFTyjOz3LLCXADAUyJ1TPUL3xeaPE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-349-neRtTF0dNvqE2kLLMKEbOw-1; Wed, 11 Dec 2019 12:37:47 -0500
X-MC-Unique: neRtTF0dNvqE2kLLMKEbOw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 89BDB107B79B;
 Wed, 11 Dec 2019 17:37:46 +0000 (UTC)
Received: from localhost (unknown [10.36.118.38])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 269145E244;
 Wed, 11 Dec 2019 17:37:40 +0000 (UTC)
Date: Wed, 11 Dec 2019 17:37:39 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH] virtio: don't enable notifications during polling
Message-ID: <20191211173739.GA947773@stefanha-x1.localdomain>
References: <20191209210957.65087-1-stefanha@redhat.com>
 <20191211105755-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20191211105755-mutt-send-email-mst@kernel.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="WIyZ46R2i8wDzkSu"
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--WIyZ46R2i8wDzkSu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 11, 2019 at 10:58:43AM -0500, Michael S. Tsirkin wrote:
> On Mon, Dec 09, 2019 at 09:09:57PM +0000, Stefan Hajnoczi wrote:
> > Virtqueue notifications are not necessary during polling, so we disable
> > them.  This allows the guest driver to avoid MMIO vmexits.
> > Unfortunately the virtio-blk and virtio-scsi handler functions re-enabl=
e
> > notifications, defeating this optimization.
> >=20
> > Fix virtio-blk and virtio-scsi emulation so they leave notifications
> > disabled.  The key thing to remember for correctness is that polling
> > always checks one last time after ending its loop, therefore it's safe
> > to lose the race when re-enabling notifications at the end of polling.
> >=20
> > There is a measurable performance improvement of 5-10% with the null-co
> > block driver.  Real-life storage configurations will see a smaller
> > improvement because the MMIO vmexit overhead contributes less to
> > latency.
> >=20
> > Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
>=20
>=20
> Thanks! I'll queue it for merge after the release. If possible please pin=
g me
> after the release to help make sure it didn't get dropped.

Great, thanks!

Stefan

--WIyZ46R2i8wDzkSu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl3xKWMACgkQnKSrs4Gr
c8jgTgf/YX9xz9hKasZbmEcl/CS0YSLJuhHP0Yd/c78/Q7NdZerefh2j31vP9dzc
EHEFFnPwk7E1lp97JALYahV9ETiZ98hN0/EJEA13f+hGrFs1Ps7eTW8C0d3yb/XH
9aYf/buuaLAflelT8EUc7CFzFzYn88R1+iER3OqLvh+On+rGa8RK1kJAeJyaNSw2
EL1YxgPrsDKbHPzEPart3xo9dTBSSDqnc8q2XzJ/e9A8TWB0aA3ZoD1g34zfC9WW
dp7RiNdbSUkuZw56qlgLSRXCNVUE7OJeEYPzorI8o80KQf8+gz8HYAvzagey7nPb
XJp+XriIcQjhb+OKLkKFqI04h9+cCw==
=DMNr
-----END PGP SIGNATURE-----

--WIyZ46R2i8wDzkSu--


