Return-Path: <SRS0=D+kF=7K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4075AC433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 15:24:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A02720888
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 15:24:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V/+Wih2+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A02720888
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42892 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jeKOa-00075f-4r
	for qemu-devel@archiver.kernel.org; Thu, 28 May 2020 11:24:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59072)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jeKNz-0006SC-KZ
 for qemu-devel@nongnu.org; Thu, 28 May 2020 11:23:59 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:20952
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jeKNy-0003ds-Ru
 for qemu-devel@nongnu.org; Thu, 28 May 2020 11:23:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590679438;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1FKyHE6Gk6a52AKt/GsTIgFsDWCty/j3oeKWuDbezJ8=;
 b=V/+Wih2+3G0FhEcAyXDY9siPiv+kmvKPiK8kFeqaSMOWbqAzIEAz6nmBuKd+OinR73/yom
 TR/VJQwO9ApeWXDid8Wa9YWtB0LsZxITTryFt6Vky8mheLSlXfgS5QF9BuiOso1nHMwj9X
 ja3MnrnrrQGZwvki16QcAlT24/G39OM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-19-0o0EFXtjMt-v-IUVEboaFQ-1; Thu, 28 May 2020 11:23:56 -0400
X-MC-Unique: 0o0EFXtjMt-v-IUVEboaFQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F2905800688;
 Thu, 28 May 2020 15:23:54 +0000 (UTC)
Received: from localhost (ovpn-114-90.ams2.redhat.com [10.36.114.90])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 63212A09AD;
 Thu, 28 May 2020 15:23:51 +0000 (UTC)
Date: Thu, 28 May 2020 16:23:50 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Sergio Lopez <slp@redhat.com>
Subject: Re: [PATCH 1/7] block/nvme: poll queues without q->lock
Message-ID: <20200528152350.GI158218@stefanha-x1.localdomain>
References: <20200519171138.201667-1-stefanha@redhat.com>
 <20200519171138.201667-2-stefanha@redhat.com>
 <20200525080713.7kvgnlzvdbhfbowt@dritchie>
MIME-Version: 1.0
In-Reply-To: <20200525080713.7kvgnlzvdbhfbowt@dritchie>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="v2/QI0iRXglpx0hK"
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=stefanha@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/28 03:11:04
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--v2/QI0iRXglpx0hK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 25, 2020 at 10:07:13AM +0200, Sergio Lopez wrote:
> On Tue, May 19, 2020 at 06:11:32PM +0100, Stefan Hajnoczi wrote:
> > A lot of CPU time is spent simply locking/unlocking q->lock during
> > polling. Check for completion outside the lock to make q->lock disappea=
r
> > from the profile.
> >=20
> > Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> > ---
> >  block/nvme.c | 12 ++++++++++++
> >  1 file changed, 12 insertions(+)
> >=20
> > diff --git a/block/nvme.c b/block/nvme.c
> > index eb2f54dd9d..7eb4512666 100644
> > --- a/block/nvme.c
> > +++ b/block/nvme.c
> > @@ -512,6 +512,18 @@ static bool nvme_poll_queues(BDRVNVMeState *s)
> > =20
> >      for (i =3D 0; i < s->nr_queues; i++) {
> >          NVMeQueuePair *q =3D s->queues[i];
> > +        const size_t cqe_offset =3D q->cq.head * NVME_CQ_ENTRY_BYTES;
> > +        NvmeCqe *cqe =3D (NvmeCqe *)&q->cq.queue[cqe_offset];
> > +
> > +        /*
> > +         * q->lock isn't needed for checking completion because
> > +         * nvme_process_completion() only runs in the event loop threa=
d and
> > +         * cannot race with itself.
> > +         */
> > +        if ((le16_to_cpu(cqe->status) & 0x1) =3D=3D q->cq_phase) {
> > +            continue;
> > +        }
> > +
>=20
> IIUC, this is introducing an early check of the phase bit to determine
> if there is something new in the queue.
>=20
> I'm fine with this optimization, but I have the feeling that the
> comment doesn't properly describe it.

I'm not sure I understand. The comment explains why it's safe not to
take q->lock. Normally it would be taken. Without the comment readers
could be confused why we ignore the locking rules here.

As for documenting the cqe->status expression itself, I didn't think of
explaining it since it's part of the theory of operation of this device.
Any polling driver will do this, there's nothing QEMU-specific or
unusual going on here.

Would you like me to expand the comment explaining that NVMe polling
consists of checking the phase bit of the latest cqe to check for
readiness?

Or maybe I misunderstood? :)

Stefan

--v2/QI0iRXglpx0hK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl7P14YACgkQnKSrs4Gr
c8gDgQf+NeiOzShZdeDYU/xIHNFNtsiG2/E+mHjJi1nQ7PkjgyngZNGODfp6WBE0
5UJ8O3XDavHuu8l2y6dyWYsHKv61+ybvUXgEa3TkuOgntbBCmK5UnX7+HVB2GRlW
NcAza9UWOusA07Io4aYChCEYDup00EaQrBZYu0JPO6K1t5vuhaQwLURKE3ndiaYo
8KWoAFvIWX5x5B1bGLtOFatmMrhRo5Xxbpo+sz1f1Se89bjfzJn4a2bUFszREmy6
sO+5NkIjipzH/kFi5Mb5u38dov2XE65f3V+J4ESIAmjyOooar781UzL9l+0TKy4I
BB/iX5QbWRCHJSEkSeDt/hYTDuPBaQ==
=zYVR
-----END PGP SIGNATURE-----

--v2/QI0iRXglpx0hK--


