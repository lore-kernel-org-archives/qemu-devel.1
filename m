Return-Path: <SRS0=rlpO=32=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3CA1C33CAC
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 15:48:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B12A7214AF
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 15:48:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G8lNyxTo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B12A7214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41374 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izjOX-0006YT-Rm
	for qemu-devel@archiver.kernel.org; Thu, 06 Feb 2020 10:48:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47246)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1izjIC-00007Y-HB
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 10:42:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1izjIA-00060c-Qs
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 10:42:12 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:59293
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1izjIA-0005yY-JA
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 10:42:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581003730;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HHJy3KoJgKjpjmINMg34RVZjSuRJu0MMz+bxFMIdVk4=;
 b=G8lNyxToD+buPgaRsKGP+MeZoEdmvB2ck0VRKZ6p1+CjoNCLo7Ap+oo510neYIA2m+sELS
 RkXGc9WEaSrSZdUfXp0gAf4cPVsZp1YAmSUPv/7QUCMEoqSngNc1azL4YawfGe0l6lCEEY
 WSbj7BuCEpe1hroEtl3d7ThCPzWwlvc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-281-stlHjoGAOZqOuQWhBXcn8g-1; Thu, 06 Feb 2020 10:42:05 -0500
X-MC-Unique: stlHjoGAOZqOuQWhBXcn8g-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 05B31800D54;
 Thu,  6 Feb 2020 15:42:04 +0000 (UTC)
Received: from linux.fritz.box (ovpn-116-204.ams2.redhat.com [10.36.116.204])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 94A0684DB4;
 Thu,  6 Feb 2020 15:42:02 +0000 (UTC)
Date: Thu, 6 Feb 2020 16:42:01 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Max Reitz <mreitz@redhat.com>
Subject: Re: [PATCH for-5.0 v2 10/23] quorum: Implement
 .bdrv_recurse_can_replace()
Message-ID: <20200206154201.GF4926@linux.fritz.box>
References: <20191111160216.197086-1-mreitz@redhat.com>
 <20191111160216.197086-11-mreitz@redhat.com>
 <20200205155511.GF5768@dhcp-200-226.str.redhat.com>
 <7429d107-63c0-b6e4-5047-d17e9d510efc@redhat.com>
 <20200206144207.GC4926@linux.fritz.box>
 <1bb2e344-e66d-de37-0d49-f4a8a5a6eb40@redhat.com>
MIME-Version: 1.0
In-Reply-To: <1bb2e344-e66d-de37-0d49-f4a8a5a6eb40@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="yLVHuoLXiP9kZBkt"
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
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--yLVHuoLXiP9kZBkt
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 06.02.2020 um 16:19 hat Max Reitz geschrieben:
> On 06.02.20 15:42, Kevin Wolf wrote:
> > Am 06.02.2020 um 11:21 hat Max Reitz geschrieben:
> >> On 05.02.20 16:55, Kevin Wolf wrote:
> >>> Am 11.11.2019 um 17:02 hat Max Reitz geschrieben:
> >>>> Signed-off-by: Max Reitz <mreitz@redhat.com>
> >>>> ---
> >>>>  block/quorum.c | 62 +++++++++++++++++++++++++++++++++++++++++++++++=
+++
> >>>>  1 file changed, 62 insertions(+)
> >>>>
> >>>> diff --git a/block/quorum.c b/block/quorum.c
> >>>> index 3a824e77e3..8ee03e9baf 100644
> >>>> --- a/block/quorum.c
> >>>> +++ b/block/quorum.c
> >>>> @@ -825,6 +825,67 @@ static bool quorum_recurse_is_first_non_filter(=
BlockDriverState *bs,
> >>>>      return false;
> >>>>  }
> >>>> =20
> >>>> +static bool quorum_recurse_can_replace(BlockDriverState *bs,
> >>>> +                                       BlockDriverState *to_replace=
)
> >>>> +{
> >>>> +    BDRVQuorumState *s =3D bs->opaque;
> >>>> +    int i;
> >>>> +
> >>>> +    for (i =3D 0; i < s->num_children; i++) {
> >>>> +        /*
> >>>> +         * We have no idea whether our children show the same data =
as
> >>>> +         * this node (@bs).  It is actually highly likely that
> >>>> +         * @to_replace does not, because replacing a broken child i=
s
> >>>> +         * one of the main use cases here.
> >>>> +         *
> >>>> +         * We do know that the new BDS will match @bs, so replacing
> >>>> +         * any of our children by it will be safe.  It cannot chang=
e
> >>>> +         * the data this quorum node presents to its parents.
> >>>> +         *
> >>>> +         * However, replacing @to_replace by @bs in any of our
> >>>> +         * children's chains may change visible data somewhere in
> >>>> +         * there.  We therefore cannot recurse down those chains wi=
th
> >>>> +         * bdrv_recurse_can_replace().
> >>>> +         * (More formally, bdrv_recurse_can_replace() requires that
> >>>> +         * @to_replace will be replaced by something matching the @=
bs
> >>>> +         * passed to it.  We cannot guarantee that.)
> >>>> +         *
> >>>> +         * Thus, we can only check whether any of our immediate
> >>>> +         * children matches @to_replace.
> >>>> +         *
> >>>> +         * (In the future, we might add a function to recurse down =
a
> >>>> +         * chain that checks that nothing there cares about a chang=
e
> >>>> +         * in data from the respective child in question.  For
> >>>> +         * example, most filters do not care when their child's dat=
a
> >>>> +         * suddenly changes, as long as their parents do not care.)
> >>>> +         */
> >>>> +        if (s->children[i].child->bs =3D=3D to_replace) {
> >>>> +            Error *local_err =3D NULL;
> >>>> +
> >>>> +            /*
> >>>> +             * We now have to ensure that there is no other parent
> >>>> +             * that cares about replacing this child by a node with
> >>>> +             * potentially different data.
> >>>> +             */
> >>>> +            s->children[i].to_be_replaced =3D true;
> >>>> +            bdrv_child_refresh_perms(bs, s->children[i].child, &loc=
al_err);
> >>>> +
> >>>> +            /* Revert permissions */
> >>>> +            s->children[i].to_be_replaced =3D false;
> >>>> +            bdrv_child_refresh_perms(bs, s->children[i].child, &err=
or_abort);
> >>>
> >>> Quite a hack. The two obvious problems are:
> >>>
> >>> 1. We can't guarantee that we can actually revert the permissions. I
> >>>    think we ignore failure to loosen permissions meanwhile so that at
> >>>    least the &error_abort doesn't trigger, but bs could still be in t=
he
> >>>    wrong state afterwards.
> >>
> >> I thought we guaranteed that loosening permissions never fails.
> >>
> >> (Well, you know.  It may =E2=80=9Cleak=E2=80=9D permissions, but we=E2=
=80=99d never get an error
> >> here so there=E2=80=99s nothing to handle anyway.)
> >=20
> > This is what I meant. We ignore the failure (i.e. don't return an error=
),
> > but the result still isn't completely correct ("leaked" permissions).
> >=20
> >>>    It would be cleaner to use check+abort instead of actually setting
> >>>    the new permission.
> >>
> >> Oh.  Yes.  Maybe.  It does require more code, though, because I=E2=80=
=99d rather
> >> not use bdrv_check_update_perm() from here as-is.
> >=20
> > I'm not saying you need to do it, just that it would be cleaner. :-)
>=20
> It would.  Thanks for the suggestion, I obviously didn=E2=80=99t think of=
 it.
> (Or there=E2=80=99d be a comment on how this is not the best way in theor=
y, but
> in practice it=E2=80=99s good enough.)  I suppose I=E2=80=99ll see how wh=
at I can do.
>=20
> >>> 2. As aborting the permission change makes more obvious, we're checki=
ng
> >>>    something that might not be true any more when we actually make th=
e
> >>>    change.
> >>
> >> True.  I tried to do it right by having a post-replace cleanup functio=
n,
> >> but after a while that was just going nowhere, really.  So I just went
> >> with what=E2=80=99s patch 13 here.
> >>
> >> But isn=E2=80=99t 13 enough, actually?  It check can_replace right bef=
ore
> >> replacing in a drained section.  I can=E2=80=99t imagine the permissio=
ns to
> >> change there.
> >=20
> > Permissions are tied to file locks, so an external process can just gra=
b
> > the locks in between.
>=20
> Ah, right, I didn=E2=80=99t think of that.
>=20
> > But if I understand correctly, all we try here is
> > to have an additional safeguard to prevent the user from doing stupid
> > things. So I guess not being 100% is fine as long as it's documented in
> > the code.
>=20
> Yes.  I just think it actually would be 100 % in practice, so I wondered
> whether it would need to be documented.
>=20
> You=E2=80=99re right, though, it isn=E2=80=99t 100 %, so it should defini=
tely be
> documented.  Maybe something like
>=20
> In theory, we would have to keep the permissions tightened until the
> node is replaced.  In practice, that would require post-replacement
> cleanup infrastructure, which we do not have, and which would be
> unreasonably complex to implement.

Sounds good until here.

> Therefore, all we can do is require
> anyone who wants to replace one node by some potentially unrelated other
> node (i.e., the mirror job on completion) to invoke
> bdrv_recurse_can_replace() immediately before and thus minimize the time
> during which some condition may arise that might forbid the swap.
>=20
> ?

This second part of your suggested comment could be dropped, as far as
I'm concerned. If anything, it's part of the contract and would belong
in the bdrv_recurse_can_replace() documentation.

However, I think I would mention why not being 100% is okay: The part
with "additional safeguard to prevent the user from doing stupid
things", and that it doesn't make a difference if the user runs the
correct command.

Kevin

--yLVHuoLXiP9kZBkt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJePDPJAAoJEH8JsnLIjy/WzJ8P/2zBNQFfjaJuNKBrXCgEpUyy
dfYmA7rul7NmFcki4dSULCQRSs7hrPiUaFlQvrI5epKnkhexsNGDIoV2vb+rJWqE
ZyBl+VReb5vYBR6vc843IlC52W65uZOG5h5+86QBaOCvOYvP7Mn+7oGA88Obpqo0
3cHnSjWTQLYozISrFmwaxCWjdNtaiicDFXY+8VW815BbcBqbuqkks1jndZqaKMty
FG+e74qjRiMFgvEYovCzIHxYdeWxVeaSWtRRdslMlSHir9rB5CTgO/iAJKnSCn1m
kMEsUZL9d2d19VVLMO2M4OZJ099QYVSu+Osz/l4h5LoFwXlZDhs7trGD9Z3Rq3Lq
qEXLdW/GpzJdzOgs++t4RKG2cC9tjF25JMlzZmXkj5mOhLVPwaWIKawr31djFmJC
iU83WchCYCIpXGTzfKJukQQJQ0AOFrR0XYOPz1WAwoP1/rpGHyoSPxroHqNJajvL
08d+WEnhIWlic/rz20Pv6nMN7ZGK2OLOZ9fWif4bGAiRylinYpUsnuD74wYjA6iG
610NCgPaRto1YyiVQeYmO8oRlXHhYj6zazUQcBPSU97K4eYprxqY1rRs+mcf0CMY
musrE5mlkIGxQFHXK6Z2j4jDO+eEEzMxYSFGS5fyzlCPmHZx+UPfQalGZh4xqI3B
OzKlGY99ebCIAhCDQDQu
=cGth
-----END PGP SIGNATURE-----

--yLVHuoLXiP9kZBkt--


