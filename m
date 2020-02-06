Return-Path: <SRS0=rlpO=32=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6F90C2D0B1
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 14:42:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 844B620838
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 14:42:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ezf7hcP7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 844B620838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40212 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iziMq-0001hp-OR
	for qemu-devel@archiver.kernel.org; Thu, 06 Feb 2020 09:42:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34468)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1iziME-0001Ey-UG
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 09:42:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1iziMD-0002cK-BN
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 09:42:18 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:41878
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1iziMD-0002ZZ-7L
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 09:42:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581000135;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MHhJ116iLQKmm5Eyfz+GQcObeJWfqqw+vGj2QFHucbY=;
 b=Ezf7hcP7Qthi486qPMmB5/XtaustaoUHdw8B3WNqgl40k5xdzTjQhM/0po1MOpIrpTO1Tj
 Zwu3N0582BqlGbA0fc6XyJqMylW1Qm1VXR3/lHBzNsJSs/yHL7/QhFemSjgDN5z7pA+UJp
 fCxUi6FhWJ4CWy0e0SAIeHxIdWeuPLM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-148-yophsqjSPTWy_gTLnPqPZQ-1; Thu, 06 Feb 2020 09:42:11 -0500
X-MC-Unique: yophsqjSPTWy_gTLnPqPZQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 90560189F760;
 Thu,  6 Feb 2020 14:42:10 +0000 (UTC)
Received: from linux.fritz.box (ovpn-116-204.ams2.redhat.com [10.36.116.204])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4291E1A8E9;
 Thu,  6 Feb 2020 14:42:09 +0000 (UTC)
Date: Thu, 6 Feb 2020 15:42:07 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Max Reitz <mreitz@redhat.com>
Subject: Re: [PATCH for-5.0 v2 10/23] quorum: Implement
 .bdrv_recurse_can_replace()
Message-ID: <20200206144207.GC4926@linux.fritz.box>
References: <20191111160216.197086-1-mreitz@redhat.com>
 <20191111160216.197086-11-mreitz@redhat.com>
 <20200205155511.GF5768@dhcp-200-226.str.redhat.com>
 <7429d107-63c0-b6e4-5047-d17e9d510efc@redhat.com>
MIME-Version: 1.0
In-Reply-To: <7429d107-63c0-b6e4-5047-d17e9d510efc@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="lrZ03NoBR/3+SXJZ"
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
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--lrZ03NoBR/3+SXJZ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 06.02.2020 um 11:21 hat Max Reitz geschrieben:
> On 05.02.20 16:55, Kevin Wolf wrote:
> > Am 11.11.2019 um 17:02 hat Max Reitz geschrieben:
> >> Signed-off-by: Max Reitz <mreitz@redhat.com>
> >> ---
> >>  block/quorum.c | 62 +++++++++++++++++++++++++++++++++++++++++++++++++=
+
> >>  1 file changed, 62 insertions(+)
> >>
> >> diff --git a/block/quorum.c b/block/quorum.c
> >> index 3a824e77e3..8ee03e9baf 100644
> >> --- a/block/quorum.c
> >> +++ b/block/quorum.c
> >> @@ -825,6 +825,67 @@ static bool quorum_recurse_is_first_non_filter(Bl=
ockDriverState *bs,
> >>      return false;
> >>  }
> >> =20
> >> +static bool quorum_recurse_can_replace(BlockDriverState *bs,
> >> +                                       BlockDriverState *to_replace)
> >> +{
> >> +    BDRVQuorumState *s =3D bs->opaque;
> >> +    int i;
> >> +
> >> +    for (i =3D 0; i < s->num_children; i++) {
> >> +        /*
> >> +         * We have no idea whether our children show the same data as
> >> +         * this node (@bs).  It is actually highly likely that
> >> +         * @to_replace does not, because replacing a broken child is
> >> +         * one of the main use cases here.
> >> +         *
> >> +         * We do know that the new BDS will match @bs, so replacing
> >> +         * any of our children by it will be safe.  It cannot change
> >> +         * the data this quorum node presents to its parents.
> >> +         *
> >> +         * However, replacing @to_replace by @bs in any of our
> >> +         * children's chains may change visible data somewhere in
> >> +         * there.  We therefore cannot recurse down those chains with
> >> +         * bdrv_recurse_can_replace().
> >> +         * (More formally, bdrv_recurse_can_replace() requires that
> >> +         * @to_replace will be replaced by something matching the @bs
> >> +         * passed to it.  We cannot guarantee that.)
> >> +         *
> >> +         * Thus, we can only check whether any of our immediate
> >> +         * children matches @to_replace.
> >> +         *
> >> +         * (In the future, we might add a function to recurse down a
> >> +         * chain that checks that nothing there cares about a change
> >> +         * in data from the respective child in question.  For
> >> +         * example, most filters do not care when their child's data
> >> +         * suddenly changes, as long as their parents do not care.)
> >> +         */
> >> +        if (s->children[i].child->bs =3D=3D to_replace) {
> >> +            Error *local_err =3D NULL;
> >> +
> >> +            /*
> >> +             * We now have to ensure that there is no other parent
> >> +             * that cares about replacing this child by a node with
> >> +             * potentially different data.
> >> +             */
> >> +            s->children[i].to_be_replaced =3D true;
> >> +            bdrv_child_refresh_perms(bs, s->children[i].child, &local=
_err);
> >> +
> >> +            /* Revert permissions */
> >> +            s->children[i].to_be_replaced =3D false;
> >> +            bdrv_child_refresh_perms(bs, s->children[i].child, &error=
_abort);
> >=20
> > Quite a hack. The two obvious problems are:
> >=20
> > 1. We can't guarantee that we can actually revert the permissions. I
> >    think we ignore failure to loosen permissions meanwhile so that at
> >    least the &error_abort doesn't trigger, but bs could still be in the
> >    wrong state afterwards.
>=20
> I thought we guaranteed that loosening permissions never fails.
>=20
> (Well, you know.  It may =E2=80=9Cleak=E2=80=9D permissions, but we=E2=80=
=99d never get an error
> here so there=E2=80=99s nothing to handle anyway.)

This is what I meant. We ignore the failure (i.e. don't return an error),
but the result still isn't completely correct ("leaked" permissions).

> >    It would be cleaner to use check+abort instead of actually setting
> >    the new permission.
>=20
> Oh.  Yes.  Maybe.  It does require more code, though, because I=E2=80=99d=
 rather
> not use bdrv_check_update_perm() from here as-is.

I'm not saying you need to do it, just that it would be cleaner. :-)

> > 2. As aborting the permission change makes more obvious, we're checking
> >    something that might not be true any more when we actually make the
> >    change.
>=20
> True.  I tried to do it right by having a post-replace cleanup function,
> but after a while that was just going nowhere, really.  So I just went
> with what=E2=80=99s patch 13 here.
>=20
> But isn=E2=80=99t 13 enough, actually?  It check can_replace right before
> replacing in a drained section.  I can=E2=80=99t imagine the permissions =
to
> change there.

Permissions are tied to file locks, so an external process can just grab
the locks in between. But if I understand correctly, all we try here is
to have an additional safeguard to prevent the user from doing stupid
things. So I guess not being 100% is fine as long as it's documented in
the code.

Kevin

--lrZ03NoBR/3+SXJZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJePCW/AAoJEH8JsnLIjy/WaV4P/1XlIeffNeZ0zs1xv/bzYFP9
lK3Y04eqMqZDBvgIGYdRwWxZK3Bajy695YKDIHgfVIhK549XNOxvLst344OsIgSZ
fPwZHj2+6ahX1ExhTzxJAkvP51dKKkpEOJprg9afftF/4kiGaugJHbcIt1fnoEUT
oFD+NhqmlCizu8ql04LGE3lyZJuVb82ZfaWHTTnNeUUdTKxyiWety0LOxxyR0wVz
xnaRmiOgPxv7tUxPWjybaKLligN3jqKNi1+JSZU95R2O5Otr3IyW0M7dKQCrsp7q
jSPyD/NFDqeVN8gPNrMflJB2WvBeN3fOeSHkl2BRAu9bbfcOb35QQxNYWFwY+v8g
xxiqAwq9DhxWgtfoGak3ENSe5pqRsSRnf1AwGUb0SwuK19Al0k2ahkKnsll4Xff2
yeknxeEerx3hvVIQ8QvRrpQTGhPxmOPmLrOUXfJtDkBnz9DaDfyOMD8og58pde/X
mzFOqdknVt2BBPBYn5GshIesFGI+AHAUL6T5z2X0LscdILtI7uv8vpIzMx51nnYe
ywAc79heBN8Ec4kOeFSjeXp2Xvk68EK8mBGoq/5SFKsWk8kdqtIHF3ypoln2zu2l
s7rBG4pyiPFnwvZ/0YN8IBahFLLTaTfgYu4yot7wcZ8eYlz1raW4vqTDtvc9tVae
2Dec1PWkQhTDM1AbZ+kO
=hFSi
-----END PGP SIGNATURE-----

--lrZ03NoBR/3+SXJZ--


