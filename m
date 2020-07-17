Return-Path: <SRS0=LOIU=A4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ED13C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2020 11:33:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DBAD520775
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2020 11:33:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Bh0k/IB0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DBAD520775
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36976 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jwOcc-0006BT-5t
	for qemu-devel@archiver.kernel.org; Fri, 17 Jul 2020 07:33:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55664)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jwObk-0005fA-PO
 for qemu-devel@nongnu.org; Fri, 17 Jul 2020 07:32:56 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:30577
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jwObi-0004Fm-B7
 for qemu-devel@nongnu.org; Fri, 17 Jul 2020 07:32:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594985569;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PID81BLf7eJgHDzE4p2B+/1E4LD6HDrwuz9la7cQg4I=;
 b=Bh0k/IB04bEZn6QiQA0YzGuaZ8NOcYQEND8kiL+pbyHKg6B+X2tRLq0F5qjXuiVPh3eOs0
 qAKzTZ9l2awDaAPXiJ07/Po2LolKcP/tMjnd0G342xDOM1LApxaUm6abY5Nrwd58M3XaAA
 EVDn0DZAMbuiRbFUF7kBRQ92Uyco2Z8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-265-GesyiKg2NNOvB3v46qBmtA-1; Fri, 17 Jul 2020 07:32:46 -0400
X-MC-Unique: GesyiKg2NNOvB3v46qBmtA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7BCC2100527B;
 Fri, 17 Jul 2020 11:32:45 +0000 (UTC)
Received: from linux.fritz.box (ovpn-113-80.ams2.redhat.com [10.36.113.80])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 86FF55C1D3;
 Fri, 17 Jul 2020 11:32:44 +0000 (UTC)
Date: Fri, 17 Jul 2020 13:32:43 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Max Reitz <mreitz@redhat.com>
Subject: Re: [PATCH for-5.1 v2 1/2] block: Require aligned image size to
 avoid assertion failure
Message-ID: <20200717113243.GB4550@linux.fritz.box>
References: <20200716142601.111237-1-kwolf@redhat.com>
 <20200716142601.111237-2-kwolf@redhat.com>
 <7567943c-85e0-5c5b-b67e-3b915d5fa9de@redhat.com>
MIME-Version: 1.0
In-Reply-To: <7567943c-85e0-5c5b-b67e-3b915d5fa9de@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="82I3+IH0IqGh5yIs"
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/17 05:27:47
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

--82I3+IH0IqGh5yIs
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 17.07.2020 um 13:02 hat Max Reitz geschrieben:
> On 16.07.20 16:26, Kevin Wolf wrote:
> > Unaligned requests will automatically be aligned to bl.request_alignmen=
t
> > and we can't extend write requests to access space beyond the end of th=
e
> > image without resizing the image, so if we have the WRITE permission,
> > but not the RESIZE one, it's required that the image size is aligned.
> >=20
> > Failing to meet this requirement could cause assertion failures like
> > this if RESIZE permissions weren't requested:
> >=20
> > qemu-img: block/io.c:1910: bdrv_co_write_req_prepare: Assertion `end_se=
ctor <=3D bs->total_sectors || child->perm & BLK_PERM_RESIZE' failed.
> >=20
> > This was e.g. triggered by qemu-img converting to a target image with 4=
k
> > request alignment when the image was only aligned to 512 bytes, but not
> > to 4k.
> >=20
> > Turn this into a graceful error in bdrv_check_perm() so that WRITE
> > without RESIZE can only be taken if the image size is aligned. If a use=
r
> > holds both permissions and drops only RESIZE, the function will return
> > an error, but bdrv_child_try_set_perm() will ignore the failure silentl=
y
> > if permissions are only requested to be relaxed and just keep both
> > permissions while returning success.
> >=20
> > Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> > ---
> >  block.c | 16 ++++++++++++++++
> >  1 file changed, 16 insertions(+)
> >=20
> > diff --git a/block.c b/block.c
> > index 35a372df57..6371928edb 100644
> > --- a/block.c
> > +++ b/block.c
> > @@ -2025,6 +2025,22 @@ static int bdrv_check_perm(BlockDriverState *bs,=
 BlockReopenQueue *q,
> >          return -EPERM;
> >      }
> > =20
> > +    /*
> > +     * Unaligned requests will automatically be aligned to bl.request_=
alignment
> > +     * and without RESIZE we can't extend requests to write to space b=
eyond the
> > +     * end of the image, so it's required that the image size is align=
ed.
> > +     */
> > +    if ((cumulative_perms & BLK_PERM_WRITE) &&
>=20
> What about WRITE_UNCHANGED?  I think this would only matter with nodes
> that can have backing files (i.e., qcow2 in practice) because
> WRITE_UNCHANGED is only used by COR and block jobs doing something with
> a backing chain, so it shouldn=E2=80=99t matter in practice, but, well.

So basically just replacing the line with this?

    if ((cumulative_perms & (BLK_PERM_WRITE | BDRV_PERM_WRITE_UNCHANGED)) &=
&

I can do that while applying if it is what you mean.

> So, either way:
>=20
> Reviewed-by: Max Reitz <mreitz@redhat.com>

Thanks!

Kevin

> > +        !(cumulative_perms & BLK_PERM_RESIZE))
> > +    {
> > +        if ((bs->total_sectors * BDRV_SECTOR_SIZE) % bs->bl.request_al=
ignment) {
> > +            error_setg(errp, "Cannot get 'write' permission without 'r=
esize': "
> > +                             "Image size is not a multiple of request =
"
> > +                             "alignment");
> > +            return -EPERM;
> > +        }
> > +    }
> > +
> >      /* Check this node */
> >      if (!drv) {
> >          return 0;
> >=20
>=20
>=20




--82I3+IH0IqGh5yIs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE3D3rFZqa+V09dFb+fwmycsiPL9YFAl8RjFoACgkQfwmycsiP
L9bbLhAAjOgXa4bwwmPjDEaKJSAYRgGIiVkHQkXce28u8cCatcNb/xWRKaDs8Exz
ZtIsKjA9LaQa/zRnbvUHrt/suQmeT7qopQG8kB+AFW1m9EBXQHsvt2WbOzqlBLy4
4/wDAQBeKVWGxKCS5IRpUluFyHp3nXV2QaC5/xIPb8Sl/FwJ6ewmNI3VxB8Ha+Au
AVSZ8yFqi6eU67+mmno4ZR9mn3dhS3yQgpDmgaHd7NqXUHuIAg2OOBk0evkG//PR
OaEOelHFHoKg3yi5eMnVxW6hTChDqDxtSIZ6NFmNPRfQ/fQ8A+9X46laQerv1uAH
Shsez7zE/Ou5Hzm/V0imZwH5bnCLjuq3U8q9Gd8XeA319dd6PpeFHqtwwGXn81u5
YFU2vqNoAjYkyhtXYtWRzTDBjR2IxNiYE8/x1d7U8oFzZs3fr8U2milj6LBU9gSW
oKJFHbiHcL+M8ZdVISLILhL9AuAxF03G+QM83H/iEzlg39x1eRm8GsmugK6V7L9A
6y5obA5u+fnj5o6y7qh4fYX5VuA3GKNB9qJgv2IXxZLWfKoIVigBkbkEvC6ddc/g
31qklpoNGK57kFVctnoqSl6wk0AH4dWXb0XSxR7EoW8RA8IivoUYRATVGGoxPl13
74RxbK/RLe2pN+nPS1Q8cX/rDy2y3+a9C2jRoXsPmAq9wNf0sXM=
=zbvG
-----END PGP SIGNATURE-----

--82I3+IH0IqGh5yIs--


