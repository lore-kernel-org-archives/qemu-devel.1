Return-Path: <SRS0=rzeH=64=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D374BC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 11:08:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 98CB8206DA
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 11:08:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g1oBqXyY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98CB8206DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54110 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZBj3-0006Zy-NA
	for qemu-devel@archiver.kernel.org; Thu, 14 May 2020 07:08:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42808)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jZBhn-0005w4-QJ
 for qemu-devel@nongnu.org; Thu, 14 May 2020 07:07:11 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:33607
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jZBhn-0001rj-1X
 for qemu-devel@nongnu.org; Thu, 14 May 2020 07:07:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589454430;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sevWWzYAoHeFYr8NHT3OfrM2YgJtBVRISEefMJv0Hug=;
 b=g1oBqXyYU0jM+O6lJW6EuuE31d9ObxZKsPMEOydHIiiOkuS4HtzaQ3GeDlDdVcleubKfyU
 n8/gvxwhI7cx8V0h05yAErdCjrXjiXnyNaENyILNNPLLydir/6jOgik56cHYKueRveAtie
 beyOPQF4DeDPqgaTp0CFXBlTwkuK2Q8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-435-MKgDJ5vIMLCgRPTwxhelDg-1; Thu, 14 May 2020 07:07:08 -0400
X-MC-Unique: MKgDJ5vIMLCgRPTwxhelDg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D85F61005512;
 Thu, 14 May 2020 11:07:06 +0000 (UTC)
Received: from linux.fritz.box (ovpn-114-9.ams2.redhat.com [10.36.114.9])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B811D60C47;
 Thu, 14 May 2020 11:07:04 +0000 (UTC)
Date: Thu, 14 May 2020 13:07:03 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Max Reitz <mreitz@redhat.com>
Subject: Re: [RFC v2] migration: Add migrate-set-bitmap-node-mapping
Message-ID: <20200514110703.GE5518@linux.fritz.box>
References: <20200513145610.1484567-1-mreitz@redhat.com>
 <0270abbd-3fa7-dcca-bbf5-80dd0fad1733@redhat.com>
 <5454a628-0c6c-086c-c398-b5b3a8c6ec5b@redhat.com>
MIME-Version: 1.0
In-Reply-To: <5454a628-0c6c-086c-c398-b5b3a8c6ec5b@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="da4uJneut+ArUgXk"
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=kwolf@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/13 22:25:46
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org, Juan Quintela <quintela@redhat.com>,
 qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Peter Krempa <pkrempa@redhat.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--da4uJneut+ArUgXk
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 14.05.2020 um 09:13 hat Max Reitz geschrieben:
> On 13.05.20 18:11, Eric Blake wrote:
> > On 5/13/20 9:56 AM, Max Reitz wrote:
> >> This command allows mapping block node names to aliases for the purpos=
e
> >> of block dirty bitmap migration.
> >>
> >> This way, management tools can use different node names on the source
> >> and destination and pass the mapping of how bitmaps are to be
> >> transferred to qemu (on the source, the destination, or even both with
> >> arbitrary aliases in the migration stream).
> >>
> >> Suggested-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> >> Signed-off-by: Max Reitz <mreitz@redhat.com>
> >> ---
> >=20
> >> @@ -713,6 +731,44 @@ static bool dirty_bitmap_has_postcopy(void *opaqu=
e)
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return true;
> >> =C2=A0 }
> >> =C2=A0 +void
> >> qmp_migrate_set_bitmap_node_mapping(MigrationBlockNodeMappingList
> >> *mapping,
> >> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 Error **errp)
> >> +{
> >> +=C2=A0=C2=A0=C2=A0 QDict *in_mapping =3D qdict_new();
> >> +=C2=A0=C2=A0=C2=A0 QDict *out_mapping =3D qdict_new();
> >> +
> >> +=C2=A0=C2=A0=C2=A0 for (; mapping; mapping =3D mapping->next) {
> >> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 MigrationBlockNodeMapping =
*entry =3D mapping->value;
> >> +
> >> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (qdict_haskey(out_mappi=
ng, entry->node_name)) {
> >> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 er=
ror_setg(errp, "Cannot map node name '%s' twice",
> >> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 entry->node=
_name);
> >> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 go=
to fail;
> >> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> >=20
> > Can we call this command more than once?=C2=A0 Is it cumulative (call i=
t once
> > to set mapping for "a", second time to also set mapping for "b"), or
> > should it reset (second call wipes out all mappings from first call, an=
y
> > mappings that must exist must be passed in the final call)?
>=20
> I tried to make it clear in the documentation:
>=20
> > +# @mapping: The mapping; must be one-to-one, but not necessarily
> > +#           complete.  Any mapping not given will be reset to the
> > +#           default (i.e. the identity mapping).
>=20
> So everything that isn=E2=80=99t set in the second call is reset.  I thou=
ght
> about what you proposed (because I guess that=E2=80=99s the most intuitiv=
e
> idea), but after consideration I didn=E2=80=99t see why we=E2=80=99d need=
 different
> behavior, so it would only serve to make the code more complicated.

Also, if it were cumulative, we would need a separate reset command
because you probably don't want to use the same mapping you used for an
incoming migration when you later migrate away again to a third host.

Kevin

--da4uJneut+ArUgXk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE3D3rFZqa+V09dFb+fwmycsiPL9YFAl69JlcACgkQfwmycsiP
L9YnahAAsgfT1zKfo59uk4xLW5aWjv4duSYtSzszaOiGurjFIBHcu9BfS+u+Jkxb
rv7NVlf2dRwgNrWuStxM2MgXJDNjvIE7DljykKztYqzE//7cAiN416XMQV6SaI2o
4qJ933KzqKLk7cQgfRrm61dK5jmkizYq4j/8wxiqeKQLpf6lgYfumT9S89Lfjb/S
gVLlOFpH67amsVFzXS2tUt8xCVLMy8tBGKlsh6UNxs32GgaDx08tkoz2ZtnrZIdc
hdW5Ue9FoDngUanZ6SmTFOrWcdpIcQujFySgNm0rRyM0KywHdhtfx5lMr9uN5hvd
xlgjwxayTMvTqcIcwA73qwjpBnKJKeiYBz58ooJQST0FZqkuvaElkCjO1F3lwYoB
Poyn+FD+xhaxhDhguDCGrbR7nvR+ykZqDVIJ3QGROJUwJLYqHymsZ6jQwIaj//b2
t7y67OZnDO4uNeJKY9pJUI2zORaeB3CUbqQ8KqbGccIGcqWe9dxYryaNQml/0Hli
qqAY7rH8dIHpDh8vtMY4c7CeTUL9omRXh/vgxQpra7XQnXaer6e7grWYGhIBRtL7
a61ahp6wlpZoPu+inFQkbIV6PGxTkFx4cWeeYM3ZZcpWzj+3qJdiwCdc4drIRJ5x
2zfEuXEKJPxkvVHm37u9r7pi90/lB3Qyj3p77OUoc2d/7eCPN9c=
=gqcK
-----END PGP SIGNATURE-----

--da4uJneut+ArUgXk--


