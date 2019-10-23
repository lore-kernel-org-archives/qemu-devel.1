Return-Path: <SRS0=brme=YQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF62BCA9EB9
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 18:56:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F1F52086D
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 18:56:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="dEW5EPvk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F1F52086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44038 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNLnb-0004Du-4V
	for qemu-devel@archiver.kernel.org; Wed, 23 Oct 2019 14:55:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37662)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <lukasstraub2@web.de>) id 1iNL9R-0003YV-R6
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 14:14:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <lukasstraub2@web.de>) id 1iNL9Q-0003Ld-EL
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 14:14:29 -0400
Received: from mout.web.de ([212.227.15.3]:47601)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <lukasstraub2@web.de>)
 id 1iNL9M-00031K-Mk; Wed, 23 Oct 2019 14:14:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1571854456;
 bh=ZHvC7MGZvu9SvmpRQyWx01eVWde1JBrbtnBpERLBsTc=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject:In-Reply-To:References;
 b=dEW5EPvkdAWaLAKp0jWsO/oGCSvqP/ycD+9Gzt6iF3XcY79oS/hnEL6ztMzDJkq4w
 P+/EaUfZxJL1X33RLnrvAaUTAyNQdlXqx+5KH1fZC/JMd5cSmrFUZzIo4fkGCYOsdR
 LA3p29zF6HbuhPrCdnw2yLXnP4fsEj9rpcQTxH64=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from luklap ([88.130.61.3]) by smtp.web.de (mrweb001
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0LrbLR-1i0U6t30CT-013Jzy; Wed, 23
 Oct 2019 20:08:46 +0200
Date: Wed, 23 Oct 2019 20:07:37 +0200
From: Lukas Straub <lukasstraub2@web.de>
To: Max Reitz <mreitz@redhat.com>
Subject: Re: [PATCH v6 1/4] block/replication.c: Ignore requests after failover
Message-ID: <20191023200737.6adf4834@luklap>
In-Reply-To: <26551274-6bb9-734f-0131-a146742d22f3@redhat.com>
References: <cover.1570280098.git.lukasstraub2@web.de>
 <596a6f07850002a09461f317afa75f3e0c9bb784.1570280098.git.lukasstraub2@web.de>
 <26551274-6bb9-734f-0131-a146742d22f3@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:lB/UpQ19bxQJUGz5y1kEa8tPfKHZGexwwDhBTj3n00ehVAdP9v5
 IB8namRRj8Q5B5ZilZUF2qcL9NEwWqFynbaEBG653EikyfutwJrgXJqOVqAW8o3mTiAFBGy
 lVPgxGCxwQyyZsFqk5cWusaNVuKkVbgU4XIlkqPXEjfDjPUMUACqMzvfnOol+JNPdSdMSKg
 OvxCzzeBi3zYzrGScTDXA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:od2KCnk+Ics=:75IedKr1RaXuwIhGTwT+Q/
 CgmVZuqdRbFFG+ZraRMNtUoP97koWlenSEdfb2BvMLnf5+Cz5xExPlHY2pbasobq7mPTNeNeQ
 myowvtB0t+TOG+rDZY/7f9gy9SxhEosvPSKZQzI6IrCM+GaTSBzKIfJcUku8gvdbv1hfarDTD
 oD4HbS79HAS8sp0KV7WdRJSfNNQ5PnIjcQUidmOoeoztAetPYUmP1q8XBOOacW7d6aPRSlbFw
 WzU9AaWE4OsSZmya44xwQQ6QRHTld2nmPD4MO+xgK6yGIZdf3CTG4NHipihmAKhAfYHODHkhB
 uK0xppUZbimcNWYVekXprAbMqv5RSnk9h2HlrG4VI0E707N2Y07RPmDQklYmgql5dyDvQlScb
 OuHQ59NOrKWeb7jCUeeGAR09kAyGQ6WAfqC8JqAAaJk3+/Nuth2iHgaDqrDtkkRyuM2kdfObj
 xPqTKPrdCFd8RVJmGopIupx/cIzfF9LA0+akvoFZUtO46WePpsw2vaF1xW4mZDrv8NX9FvqLu
 xEDsF5SG17plevW0wqWhvqKTop8ugYNs6b7cMavLf9zk1OawiS2CLiaOhz/gTW2Es+d8iGGBw
 c1m0gxAtiA+1qNlqQrCrclvqHz+G8dJhoJOOBOeDhvpwAz/QsqGW+flWyrdEbYJdlGWiX+nJN
 L6AiQMxruMzHJHrtDPwluoMKjggObEw+7euFEKBNAH97Hr/xz1co6nZkU26C5fph8gWyEL5iP
 Ec0kye1vrwMa5aJbbFODM/B7l+PN26udGw3eQsxkmgTwQuSPQdd3AgFMl1HLFoMPdmWpOVqbG
 taGwMla1GdNf3IBloWmBBVQNgqPLUF/bNvgNXWtklk1yGFlsRzAk8hNLKjPOl/bH4EngC9pGv
 H6rSn9em5u3uSQzWM1ww6XEHFOnAVpR/P9uIEs4TVAHrg/QWdJdLdKHf6PbPVC4718RnoXm7h
 tGlX0CpDWw/M3WpgQGm22uyEY/mFnI/+tIcvdPKg/rk/DyL/8nF+jTY70F9Lwem5kVZ/Dvkwn
 Lm7ViS0xVimrTfu553V+9TRbqMUx46FFAParCDKr4IlK3XinmaI2vEl1rKveIEwsFuSutEq3w
 mxbAoqiHiALe2PYqzd6MMzWYAkAwH0oTNs7arhIY8dtynMX/tg2nWZT94O4r/hxXmuHE3lsqK
 u516aq1jXjTtO6j+94fAMBiS2GCYTNVeprKxJ2OD21ae0mYxo5CfTl5mk/QGpuzbULCh3l6iX
 fDipNXBBscSOvT3yZ2R9hHvIdrIAiJzUQLGJZcuGwK0Fxk5r7B2KUnm66TxA=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 212.227.15.3
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block <qemu-block@nongnu.org>,
 Wen Congyang <wencongyang2@huawei.com>, Jason Wang <jasowang@redhat.com>,
 qemu-devel <qemu-devel@nongnu.org>, Zhang Chen <chen.zhang@intel.com>,
 Xie Changlong <xiechanglong.d@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 23 Oct 2019 14:49:29 +0200
Max Reitz <mreitz@redhat.com> wrote:

> On 05.10.19 15:05, Lukas Straub wrote:
> > After failover the Secondary side of replication shouldn't change state=
, because
> > it now functions as our primary disk.
> >=20
> > In replication_start, replication_do_checkpoint, replication_stop, igno=
re
> > the request if current state is BLOCK_REPLICATION_DONE (sucessful failo=
ver) or
> > BLOCK_REPLICATION_FAILOVER (failover in progres i.e. currently merging =
active
> > and hidden images into the base image).
> >=20
> > Signed-off-by: Lukas Straub <lukasstraub2@web.de>
> > Reviewed-by: Zhang Chen <chen.zhang@intel.com>
> > ---
> >  block/replication.c | 38 +++++++++++++++++++++++++++++++++++---
> >  1 file changed, 35 insertions(+), 3 deletions(-) =20
>=20
> Disclaimer: I don=E2=80=99t know anything about the replication block dri=
ver.
>=20
> > diff --git a/block/replication.c b/block/replication.c
> > index 3d4dedddfc..97cc65c0cf 100644
> > --- a/block/replication.c
> > +++ b/block/replication.c =20
>=20
> [...]
>=20
> > @@ -529,8 +540,7 @@ static void replication_start(ReplicationState *rs,=
 ReplicationMode mode,
> >                     "Block device is in use by internal backup job");
> >=20
> >          top_bs =3D bdrv_lookup_bs(s->top_id, s->top_id, NULL);
> > -        if (!top_bs || !bdrv_is_root_node(top_bs) ||
> > -            !check_top_bs(top_bs, bs)) {
> > +        if (!top_bs || !check_top_bs(top_bs, bs)) { =20
>=20
> It appears to me that top_bs is only used to install op blockers.  It
> seems reasonable to require a root node to be able to do so (because op
> blockers are really only checked on a root node).
> (And the commit message doesn=E2=80=99t tell why we=E2=80=99d want to dro=
p the
> is_root_node check here.)
>=20
> Now OTOH I don=E2=80=99t know whether the replication driver needs an op =
blocker
> at all or whether the permission system suffices...

Hi,
Now that I look at again, it actually works without this change, by passing
a correct top-id=3D parameter to the driver (I somehow overlooked that para=
meter).=20
So I will revert this change in the next version.

>=20
> I suppose the rest of this patch is not really about the block layer, so
> I can=E2=80=99t really comment on it.  (It looks OK to me from a generic =
and
> na=C3=AFve standpoint, though.)
>=20
> >              error_setg(errp, "No top_bs or it is invalid");
> >              reopen_backing_file(bs, false, NULL);
> >              aio_context_release(aio_context); =20
>=20
> [...]
>=20
> > @@ -593,7 +614,7 @@ static void replication_get_error(ReplicationState =
*rs, Error **errp)
> >      aio_context_acquire(aio_context);
> >      s =3D bs->opaque;
> >=20
> > -    if (s->stage !=3D BLOCK_REPLICATION_RUNNING) {
> > +    if (s->stage =3D=3D BLOCK_REPLICATION_NONE) { =20
>=20
> Just one question out of curiosity, though: Is this a bug fix?

No, It only applies to continuous replication, because colo will
check all replication nodes for errors before checkpointing. So
a secondary continuing replication would error out here, because
it is either in state BLOCK_REPLICATION_DONE or=20
BLOCK_REPLICATION_FAILOVER.

> Max
>=20
> >          error_setg(errp, "Block replication is not running");
> >          aio_context_release(aio_context);
> >          return; =20
>=20


