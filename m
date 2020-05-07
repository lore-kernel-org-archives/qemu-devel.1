Return-Path: <SRS0=s5cl=6V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FE6DC38A2A
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 11:20:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EE81520725
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 11:20:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TscxTcLa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE81520725
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60564 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWeZc-0007Fk-4Q
	for qemu-devel@archiver.kernel.org; Thu, 07 May 2020 07:20:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56640)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jWeYq-0006mF-8X
 for qemu-devel@nongnu.org; Thu, 07 May 2020 07:19:28 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:23576
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jWeYo-0001JJ-OL
 for qemu-devel@nongnu.org; Thu, 07 May 2020 07:19:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588850365;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Br0ikamOZl8W0sAAXS7tNPt7k1HLlsZ2zdgfX/Sb5xM=;
 b=TscxTcLaaPHNuexDmaQG/HOu2Hhs52SK+m2nQUFzZMI0EnRKp4KFFDNBfYeSFuQJZBTwyz
 v0GMBOYrJfPxaUnNkwTZBUebl2VYGusnXiI6DVRWMjWjXwP99kakmAagS6QGkkX2+ipbQL
 NhWQwPpb0TQ+omK12MYrL79cBnWD+Z0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-501-idQq9CXfM_ayQnR-v4y5aQ-1; Thu, 07 May 2020 07:19:24 -0400
X-MC-Unique: idQq9CXfM_ayQnR-v4y5aQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EADCD835B40;
 Thu,  7 May 2020 11:19:22 +0000 (UTC)
Received: from linux.fritz.box (ovpn-113-33.ams2.redhat.com [10.36.113.33])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D7F9463F61;
 Thu,  7 May 2020 11:19:21 +0000 (UTC)
Date: Thu, 7 May 2020 13:19:20 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Max Reitz <mreitz@redhat.com>
Subject: Re: [PATCH v3 09/33] block: Add generic bdrv_inherited_options()
Message-ID: <20200507111920.GC6019@linux.fritz.box>
References: <20200218124242.584644-1-mreitz@redhat.com>
 <20200218124242.584644-10-mreitz@redhat.com>
 <20200506103722.GB6333@linux.fritz.box>
 <7d226c94-2f14-eddb-b795-f8a961023947@redhat.com>
MIME-Version: 1.0
In-Reply-To: <7d226c94-2f14-eddb-b795-f8a961023947@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="Nq2Wo0NMKNjxTN9z"
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/07 00:55:34
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
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--Nq2Wo0NMKNjxTN9z
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 07.05.2020 um 10:49 hat Max Reitz geschrieben:
> On 06.05.20 12:37, Kevin Wolf wrote:
> > Am 18.02.2020 um 13:42 hat Max Reitz geschrieben:
> >> +    if (role & BDRV_CHILD_COW) {
> >> +        /* backing files are always opened read-only */
> >=20
> > Not "always", just by default.
>=20
> OK.  I just copied the comment from bdrv_backing_options().

Yes, sorry, I noticed this only later (it's how review goes when a move
is split into a copy in one patch and a removal later). I don't insist
on a change if you prefer to have a clean copy.

> >> +        qdict_set_default_str(child_options, BDRV_OPT_READ_ONLY, "on"=
);
> >> +        qdict_set_default_str(child_options, BDRV_OPT_AUTO_READ_ONLY,=
 "off");
> >> +    } else {
> >> +        /* Inherit the read-only option from the parent if it's not s=
et */
> >> +        qdict_copy_default(child_options, parent_options, BDRV_OPT_RE=
AD_ONLY);
> >> +        qdict_copy_default(child_options, parent_options,
> >> +                           BDRV_OPT_AUTO_READ_ONLY);
> >> +    }
> >> +
> >> +    if (parent_is_format && !(role & BDRV_CHILD_COW)) {
> >> +        /*
> >> +         * Our format drivers take care to send flushes and respect
> >> +         * unmap policy, so we can default to enable both on lower
> >> +         * layers regardless of the corresponding parent options.
> >> +         */
> >> +        qdict_set_default_str(child_options, BDRV_OPT_DISCARD, "unmap=
");
> >> +    }
> >=20
> > Why the restriction to format here? Don't we break "unmap" propagation
> > through filters with this?
>=20
> Right now (before this series), the behavior seems ambiguous, in that
> for filters that use bs->file, it is set, but for those that use
> bs->backing, it isn=E2=80=99t.

It's probably easy to agree that this is a bug.

> But I suspect the main reason for what I did is the way I interpreted
> the comment (which before this series only mentions block drivers in
> general, not specifically format drivers): It sounded to me as if the
> block driver needed to respect the unmap policy, and I didn=E2=80=99t thi=
nk
> filters did that.  So it was my understanding that filter drivers would
> just propagate discards and thus we couldn=E2=80=99t default-enable unmap=
 on
> their children.

This was actually my thought as well. And in order to propagate, we have
to copy the option from parent_options, no? Currently it will always be
disabled (unless specified explicitly for the node) because that's the
default setting for unmap.

> But I was wrong, the block driver doesn=E2=80=99t need to respect anythin=
g,
> because bdrv_co_pdiscard() already does.
>=20
> So I suppose it should indeed be enabled for all children, with the
> comment changed to express that it isn=E2=80=99t any block driver that re=
spects
> unmap policy, but bdrv_co_pdiscard(), e.g.:
>=20
> bdrv_co_pdiscard() respects unmap policy for the parent, so we can
> default to enable it on lower layers regardless of the parent option.

This would restore the behaviour before this series for child_file and
child_format. It would be different in that it also enables "unmap" for
backing files, which should be okay.

> > It would probably also be a good question why we don't propagate it to
> > the backing file, but this is preexisting.
>=20
> I suppose we should, although it=E2=80=99s irrelevant, so.  I suppose I=
=E2=80=99ll just
> drop the parent_is_format, adjust the comment and that should be fine
> for this series.

Isn't it relevant for zero writes during active commit? (The "normal"
intermediate commit job doesn't even try to optimise zero blocks...)

The job will have its own BdrvChild to access the node, but option
inheritance happens only from the parent that "owns" the backing file,
so if a qcow2 image doesn't set "unmap" on its COW child, unmap will be
disabled for the active commit job, too.

(Oops. Turns out that it's not the case because the 'unmap' option for
the job exists only for drive-mirror. blockdev-mirror passes true
unconditionally and block-commit passes false unconditionally. I'm
always amazed how consistently we fail to be consistent.

But I think using zero writes with MAY_UNMAP in a commit job is an
obvious extension, so considering it now can't hurt anyway.)

Kevin

--Nq2Wo0NMKNjxTN9z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE3D3rFZqa+V09dFb+fwmycsiPL9YFAl6z7rgACgkQfwmycsiP
L9aGmhAAi+e1hk7sHvNsnGTQPhIGJNpCZ4FycZpJKoZDsRVC8q/K/oyHQ3J9Sy64
J1WSvpEl+DM9ZvJ8VeY2cekRE0hhYpGtxeTdBlT2mjJQv4DQwJdFGXNH+aV6EYtz
UCgLiXpH0npVNhfAfF28EcccUDfhq8M175THze2hdMbxzJgifShO6+wsVL6Njhyb
w0BKs91bp5ga1W5eKKA7cndStc7wOa8OEhurOHqAu6UdxTZuxs9ZnQuGsRiv5TqD
B6KC3E22hpnMVCFMhImyG4iiEfjLT2CrnYOZl7HQ3T4j6/3QDUU7GOBDU2TCV7lm
68jfHRYYbSU+5wfTd5Vtt1ZCe4p95/CCz2cxniyjZbvJ0vcy5sxZoX5rW2lxjQ+n
idAp1tHh4Tit9hi7NVezU1tL6eA3W0NoAfjr0fMbQjoIs7Ah7Ilm/0DCVZfArcnV
9fpJS0bdEZIzhNyB0p5rbNMYJfxXzbF7NAZZ/LJcGPRgGKOYnDISQiwtG+CK2oxl
sOG1pgGam4MEQLGPm29evocDjcOYtk8MRWdunfIDXnhQJ0uAq4spJ7MJyTZiuG/w
wJih2JtUB/qIGXWkWoSHePzVwnFQfEEsLBRtjDfHxM/QQx7ZLwgbDU+UqM1yAONh
tVyjLYVPwJBXqBstPAoLWx0Mllvze6hbcqcRo4u2mFvTMARFbu0=
=wPJE
-----END PGP SIGNATURE-----

--Nq2Wo0NMKNjxTN9z--


