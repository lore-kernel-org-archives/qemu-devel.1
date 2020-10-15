Return-Path: <SRS0=muvY=DW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 030A7C433E7
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 17:08:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5521422210
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 17:08:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BuDDO9pe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5521422210
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45212 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kT6jW-0002kS-8y
	for qemu-devel@archiver.kernel.org; Thu, 15 Oct 2020 13:08:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46554)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1kT6dD-00053m-1Y
 for qemu-devel@nongnu.org; Thu, 15 Oct 2020 13:01:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:41118)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1kT6dA-0002dA-El
 for qemu-devel@nongnu.org; Thu, 15 Oct 2020 13:01:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602781291;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=L71s4nzANCgezJ752fF1qP/VsptVK5bu09KI2KcmtmE=;
 b=BuDDO9peJ8Lu4yL+rf6JjBeVL214L5Po7AFx4cO9TlFdNxIAOZ3lVsy16eFsCbzVc5K89n
 2xAuUb4+C/qQwBURBuApw6rvnTWVAQ7bLKvikURVyJNS3fQtEEW8su6ML1ZG1rXpfIrrhs
 InNGrhsgqTLgN90bSA+9a24TClHpHUk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-321-aN_BoYzjMIa8bkXGcxfZIA-1; Thu, 15 Oct 2020 13:01:28 -0400
X-MC-Unique: aN_BoYzjMIa8bkXGcxfZIA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 679A91DDE3;
 Thu, 15 Oct 2020 17:01:27 +0000 (UTC)
Received: from merkur.fritz.box (ovpn-114-163.ams2.redhat.com [10.36.114.163])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 75B4619C4F;
 Thu, 15 Oct 2020 17:01:23 +0000 (UTC)
Date: Thu, 15 Oct 2020 19:01:21 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Max Reitz <mreitz@redhat.com>
Subject: Re: [PATCH v2 02/20] fuse: Allow exporting BDSs via FUSE
Message-ID: <20201015170121.GM4610@merkur.fritz.box>
References: <20200922104932.46384-1-mreitz@redhat.com>
 <20200922104932.46384-3-mreitz@redhat.com>
 <20201015085703.GB4610@merkur.fritz.box>
 <2db9dbfe-137a-4cdc-08ab-aaa1aed26423@redhat.com>
 <20201015154123.GK4610@merkur.fritz.box>
 <256dd14e-f5c3-7f83-60e0-9bdacdcd5f99@redhat.com>
MIME-Version: 1.0
In-Reply-To: <256dd14e-f5c3-7f83-60e0-9bdacdcd5f99@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kwolf@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="HG+GLK89HZ1zG0kk"
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/15 02:38:26
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--HG+GLK89HZ1zG0kk
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 15.10.2020 um 17:59 hat Max Reitz geschrieben:
> On 15.10.20 17:41, Kevin Wolf wrote:
> > Am 15.10.2020 um 16:46 hat Max Reitz geschrieben:
> >> On 15.10.20 10:57, Kevin Wolf wrote:
> >>> Am 22.09.2020 um 12:49 hat Max Reitz geschrieben:
>=20
> [...]
>=20
> >>>> +static void fuse_export_shutdown(BlockExport *blk_exp)
> >>>> +{
> >>>> +    FuseExport *exp =3D container_of(blk_exp, FuseExport, common);
> >>>> +
> >>>> +    if (exp->fuse_session) {
> >>>> +        fuse_session_exit(exp->fuse_session);
> >>>> +
> >>>> +        if (exp->mounted) {
> >>>> +            fuse_session_unmount(exp->fuse_session);
> >>>> +            exp->mounted =3D false;
> >>>> +        }
> >>>> +
> >>>> +        if (exp->fd_handler_set_up) {
> >>>> +            aio_set_fd_handler(exp->common.ctx,
> >>>> +                               fuse_session_fd(exp->fuse_session), =
true,
> >>>> +                               NULL, NULL, NULL, NULL);
> >>>> +            exp->fd_handler_set_up =3D false;
> >>>> +        }
> >>>> +
> >>>> +        fuse_session_destroy(exp->fuse_session);
> >>>> +        exp->fuse_session =3D NULL;
> >>>
> >>> What happens if a request is still in flight?
> >>>
> >>> Oh, can't happen because the driver is fully synchronous after this
> >>> series. Fair enough, making it asynchronous can come on top of it.
> >>
> >> (I had multiple approaches of handling parallel requests, but none mad=
e
> >> a substantial performance difference, which is why I left the driver i=
n
> >> the most simple form for this first proposal.)
> >=20
> > I think the more relevant part is that we'd block the guest or anything
> > else running in the main loop while doing I/O.
> >=20
> > Not a problem if you spawn a new qemu-storage-daemon just for this FUSE
> > export, but if you want to have multiple exports, or export from the
> > system emulator, you probably don't want to have synchronous operations=
.
>=20
> Ah, hm.  Hmm. O:)
>=20
> Does NBD work any different, though?  I had always assumed it runs in
> the BB=E2=80=99s context.

Yes, it runs in the BB's AioContext, but it's coroutine based, so
instead of blocking, it just yields and lets other stuff in the same
event loop make progress while it's waiting for its I/O.

Kevin

--HG+GLK89HZ1zG0kk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE3D3rFZqa+V09dFb+fwmycsiPL9YFAl+IgGEACgkQfwmycsiP
L9bfoQ//YRrQn+CX+7rXW9IwFDj7mLPVcHLXzTKac0+lle9iJW3iTtTIqPLEqa05
JiZCo6qkfekl5WmWVd16l8dQhrQvoXPwke5rqRh5bKJenLnKsu+6y6VSEUl4bRAr
NoVSABjsYua54edqG+Q5jsgvM5PijMv3WB2GUoZqCnVlYxRJoJq0z/5/cdTcIJqJ
6jwYiM5v32OsaTIzhn1kp3xZgTCPxUcoAW+mi296wnADAaJMOBONpBQeZcu5T+zP
F2x1hOyd0VFkKfyJAx4aB/n7dZ0zj0Qnn1+I0wE5BTcBBX6jrabm+oceMOjGDFMx
FjhFCUlkoqUGEz7YFbubINBfoLA1muPCOSVkdVC7Lw1DSmklzXBWWrpwzlPRnZqM
tnl6Xd1o6L95CFJflkCnRt5zKBEVVP8KClEmVziVTG32GeD+NmppPkhlTxkU/6wT
hj+uKOukCLVBnHfb/X+1cNHBwfn2cY9P6Q6t0TGRtmse6z4aM5IrGqHwIAwsygRc
A/yujfFkTktu2VvFqicNoiw5hsZhowAfo88JWyn28DPn8EDVoBh1Kmb0PjzznyUr
pcDwsjYe+hAgDaaiYQxzsPj1OniEruzGJ01GL4/REYMtHE4IXbk+TKTbXHazbu0L
Qyc7MDKj+GteHHduyp7HrpyjCTkZubYTa06EML0cSUL/ZpPRAEQ=
=WjOE
-----END PGP SIGNATURE-----

--HG+GLK89HZ1zG0kk--


