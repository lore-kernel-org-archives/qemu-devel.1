Return-Path: <SRS0=OA/w=ZN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCB86C432C0
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2019 11:36:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A79F620674
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2019 11:36:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KpUSOM2S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A79F620674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39112 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXklG-0006rx-Js
	for qemu-devel@archiver.kernel.org; Thu, 21 Nov 2019 06:36:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56209)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1iXkj4-0004iE-0x
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 06:34:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1iXkj1-0005f1-Nm
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 06:34:16 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:22868
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1iXkj0-0005eQ-Vo
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 06:34:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574336053;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kgqotGlUG/5fs78GRANCQ6uctQy7LA7BfGfJc2vqjXg=;
 b=KpUSOM2SvqZfu6qLXwyxSvJyMGuXxNF3+do3FKNGUazpSsbVJz20uk2c/q7OP+eVZA9zVm
 7U3WFJwfQxRGCghPf6brnuELUzf6FmHOaZmuK4S9C8R+Elu5azoEdlB2Qsm5RJFCYztC5B
 dOSF5TwUrdSNvPuIim9x1x0U9dzivZI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-51-1Q9E9B49P82LSi3Xv4qi0w-1; Thu, 21 Nov 2019 06:34:09 -0500
X-MC-Unique: 1Q9E9B49P82LSi3Xv4qi0w-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9F292102CCC9;
 Thu, 21 Nov 2019 11:34:08 +0000 (UTC)
Received: from linux.fritz.box (ovpn-117-225.ams2.redhat.com [10.36.117.225])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2DBB86CE71;
 Thu, 21 Nov 2019 11:34:07 +0000 (UTC)
Date: Thu, 21 Nov 2019 12:34:05 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Max Reitz <mreitz@redhat.com>
Subject: Re: [PATCH v2 2/6] block: truncate: Don't make backing file data
 visible
Message-ID: <20191121113405.GE6007@linux.fritz.box>
References: <20191120184501.28159-1-kwolf@redhat.com>
 <20191120184501.28159-3-kwolf@redhat.com>
 <c53f6f2d-2451-2fb3-cbf0-2a1a686cccf5@redhat.com>
MIME-Version: 1.0
In-Reply-To: <c53f6f2d-2451-2fb3-cbf0-2a1a686cccf5@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="XvKFcGCOAo53UbWW"
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: vsementsov@virtuozzo.com, stefanha@redhat.com, qemu-block@nongnu.org,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--XvKFcGCOAo53UbWW
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 21.11.2019 um 09:59 hat Max Reitz geschrieben:
> On 20.11.19 19:44, Kevin Wolf wrote:
> > When extending the size of an image that has a backing file larger than
> > its old size, make sure that the backing file data doesn't become
> > visible in the guest, but the added area is properly zeroed out.
> >=20
> > Consider the following scenario where the overlay is shorter than its
> > backing file:
> >=20
> >     base.qcow2:     AAAAAAAA
> >     overlay.qcow2:  BBBB
> >=20
> > When resizing (extending) overlay.qcow2, the new blocks should not stay
> > unallocated and make the additional As from base.qcow2 visible like
> > before this patch, but zeros should be read.
> >=20
> > A similar case happens with the various variants of a commit job when a=
n
> > intermediate file is short (- for unallocated):
> >=20
> >     base.qcow2:     A-A-AAAA
> >     mid.qcow2:      BB-B
> >     top.qcow2:      C--C--C-
> >=20
> > After commit top.qcow2 to mid.qcow2, the following happens:
> >=20
> >     mid.qcow2:      CB-C00C0 (correct result)
> >     mid.qcow2:      CB-C--C- (before this fix)
> >=20
> > Without the fix, blocks that previously read as zeros on top.qcow2
> > suddenly turn into A.
> >=20
> > Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> > ---
> >  block/io.c | 32 ++++++++++++++++++++++++++++++++
> >  1 file changed, 32 insertions(+)
>=20
> Zeroing the intersection may take some time.  So is it right for QMP=E2=
=80=99s
> block_resize to do this, seeing it is a synchronous operation?

What else would be right? Returning an error?

Common cases (raw and qcow2 v3 without external data files) are quick
anyway.

> As far as I can tell, jobs actually have the same problem.  I don=E2=80=
=99t
> think mirror or commit have a pause point before truncating, so they
> still block the monitor there, don=E2=80=99t they?

Do you really need a pause point? They call bdrv_co_truncate() from
inside the job coroutine, so it will yield. I would expect that this
is enough.

But in fact, all jobs have a pause point before even calling .run(), so
even if that made a difference, it should still be fine.

Kevin

--XvKFcGCOAo53UbWW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJd1nYtAAoJEH8JsnLIjy/WbNYQAL5KU/tj/Hv49FoxxZPDvBOW
j4EkAH2XN2OV/p0bb1HTyZU0vVyMNx9Pm2ZdC3JZMcGrYZdQ6TvF35iTpIr4A65v
VuZM269S379QDGU3T4Aq3lNkIbFJmXzDQVJU8uIK1wcD6ASkr+/0TIqQecGFe9Ew
l/EvWW//OOvrYHL3J4v+FK3VXXIn24tn71RWh8hhcuaolEl1EzMOT9E6uDrt7VwV
oVLKHQ2wNdgzWxWdQ1aydHtIpVpLBfjif/E0TVcRAr+O2DcaVXxKnWvPbpDPtM63
GsTgoMbu1cia99g8El9avolvhM7TTQAQ8NKjv7YG95a9yasJG64MUtHRT+b5nI0M
Y044nqvQvB6kR1gnAtd/54Lj5+zK8teXDGFMfEUJWDuS8MlzWXqyOKxsTfBZdkL0
SI0qTk/KUrVOzfMkWa5enLKyut6PXFBzZwtTHVf+Evmz7MMHvQG7KKwgjrXT1wOO
NDkwnuwq1qPhLP9YK/syPaj4Sd094CdAXq8YcAKHIS3joxfyyJW7xVrppeSV5os+
HfD62HMYp8ThVSE+f5yaFBD5FT8y7UDt2z2DiDoUcmPQBsA2Mz14Mxyyr9HYCXwX
GS8i+RpMSdbVtPb14kOt4/XdWW/rNVRPp277AFd9TvTGe8+sQGI+iXBj4FpfNR0M
xwpimooAX7H9hoWV5yaJ
=mBYi
-----END PGP SIGNATURE-----

--XvKFcGCOAo53UbWW--


