Return-Path: <SRS0=bVMU=B5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CC60C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2020 15:17:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6BA0F207FF
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2020 15:17:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b5RQD51/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BA0F207FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45430 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k8PqX-000313-S5
	for qemu-devel@archiver.kernel.org; Wed, 19 Aug 2020 11:17:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60980)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1k8PpQ-0001qC-NM
 for qemu-devel@nongnu.org; Wed, 19 Aug 2020 11:16:40 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:25165
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1k8PpN-0007wr-Rz
 for qemu-devel@nongnu.org; Wed, 19 Aug 2020 11:16:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597850193;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=OwGAD9rfUSaOnHvqP4VH7dep+fl3FcjnAOBAGiC5wrg=;
 b=b5RQD51/LswUxb3FDa5ZIrdCKSIsopinzUCCiz6cZNh3lmJoHi/5RA5W3rRQM0nuHToBN7
 CDOPNrermV38ZHqFzqwxxTE9AJ+9E3Y0btjBdyIfXHVT3SkTMZTOnxYbgUo8YmCzlo+Z6e
 SkBMKGEn6qNmVK269Pi3l93YQh9YIGY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-425-cjFC1zYgM5Cs36ZUrFvX-Q-1; Wed, 19 Aug 2020 11:16:30 -0400
X-MC-Unique: cjFC1zYgM5Cs36ZUrFvX-Q-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8A9641005E65;
 Wed, 19 Aug 2020 15:16:29 +0000 (UTC)
Received: from linux.fritz.box (ovpn-114-24.ams2.redhat.com [10.36.114.24])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 96C237A435;
 Wed, 19 Aug 2020 15:16:26 +0000 (UTC)
Date: Wed, 19 Aug 2020 17:16:25 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Max Reitz <mreitz@redhat.com>
Subject: Re: [PATCH v7 14/47] stream: Deal with filters
Message-ID: <20200819151625.GF10272@linux.fritz.box>
References: <20200625152215.941773-1-mreitz@redhat.com>
 <20200625152215.941773-15-mreitz@redhat.com>
 <20200818142851.GD6865@linux.fritz.box>
 <59fe8d64-b073-aeff-1afb-b526e9a085f1@redhat.com>
MIME-Version: 1.0
In-Reply-To: <59fe8d64-b073-aeff-1afb-b526e9a085f1@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kwolf@redhat.com
X-Mimecast-Spam-Score: 0.0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="MAH+hnPXVZWQ5cD/"
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=kwolf@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/19 04:00:34
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
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--MAH+hnPXVZWQ5cD/
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 19.08.2020 um 16:47 hat Max Reitz geschrieben:
> On 18.08.20 16:28, Kevin Wolf wrote:
> > Am 25.06.2020 um 17:21 hat Max Reitz geschrieben:
> >> Because of the (not so recent anymore) changes that make the stream jo=
b
> >> independent of the base node and instead track the node above it, we
> >> have to split that "bottom" node into two cases: The bottom COW node,
> >> and the node directly above the base node (which may be an R/W filter
> >> or the bottom COW node).
> >>
> >> Signed-off-by: Max Reitz <mreitz@redhat.com>
> >> ---
> >>  qapi/block-core.json |  4 +++
> >>  block/stream.c       | 63 ++++++++++++++++++++++++++++++++-----------=
-
> >>  blockdev.c           |  4 ++-
> >>  3 files changed, 53 insertions(+), 18 deletions(-)
> >>
> >> diff --git a/qapi/block-core.json b/qapi/block-core.json
> >> index b20332e592..df87855429 100644
> >> --- a/qapi/block-core.json
> >> +++ b/qapi/block-core.json
> >> @@ -2486,6 +2486,10 @@
> >>  # On successful completion the image file is updated to drop the back=
ing file
> >>  # and the BLOCK_JOB_COMPLETED event is emitted.
> >>  #
> >> +# In case @device is a filter node, block-stream modifies the first n=
on-filter
> >> +# overlay node below it to point to base's backing node (or NULL if @=
base was
> >> +# not specified) instead of modifying @device itself.
> >=20
> > Not to @base's backing node, but to @base itself (or actually, to
> > above_base's backing node, which is initially @base, but may have
> > changed when the job is completed).
>=20
> Oh, yes.
>=20
> (I thought I had noticed that already at some point and fixed it
> locally...  But apparently not.)
>=20
> > Should we also document what using a filter node for @base means?
>=20
> Hm.  What does it mean?  I think the more interesting case is what it
> means if above_base is a filter, right?
>=20
> Maybe we can put in somewhere in the =E2=80=9CIf a base file is specified=
 then
> sectors are not copied from that base file and its backing chain.=E2=80=
=9D  But
> the more I think about it, the less I know what we could add to it.
> What happens if there are filters above @base is that their data isn=E2=
=80=99t
> copied, because that=E2=80=99s exactly the data in @base.

The interesting part is probably the graph reconfiguration at the end of
the job. Which is actually already documented:

# When streaming completes the image file will have the base
# file as its backing file.

Of course, this is not entirely correct any more (because the base may
have changed).

If @base is a filter, what backing file path do we write into the top
layer? A json: filename including the filter? Is this worth mentioning
or do you consider it obvious?

Kevin

--MAH+hnPXVZWQ5cD/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE3D3rFZqa+V09dFb+fwmycsiPL9YFAl89QkkACgkQfwmycsiP
L9bZIBAAjK9xQjeoH9yY3vVEDmzstMtvaoufrHaMRPi09kqFntmJlNtB+8ub98tX
dcT6XqXvDgAGQeouDKn7axwF0Itx8AeNL1cysWsdWgyCksWxh1+sgJE4fBIL9Cuf
fyjt3ZBMwFtSpmJn89YeJN6CPo3FHBADyqqOUj1c/0D87j6/yKvEUNm/1VLDfjlQ
l+Su+dWEyE10lWw6j3+xe313P/QOrs7SsTiItY2C3RIlKDjSoWNPNzopq8z4fRgI
kJlTbCDHJC5TwWwuflq7spEIQqgrk1shvOmX9Pjpfc0VncvvT1SDQqN9SYelNQc9
TsSpkSg2ppz7eCQFKH3wRlcvEc1c4Kj2qwkcMw7xaT5kwQjXm1CTKEjWhc+ZYV7M
zUYMGcChVJ0xzVU/3Urwz2ZPEXXU8d7v6Wp311/IWO9MYWR1SF3E25oU1CQuKHi7
cGZnYqE2nuBwIvijdIup++aZmZxUnUjH88QKf0VVpal6D33kcvGTTMuPEvKjbXao
5NmwCilo+HIxsxl6wDr/1B5YmV6LfV9F+Nj2R/ucRm0PB8CdlyCH+LGWEdwv3n0/
leoq/4AB+huUGd6RRGjl4MJKhiwQYe96fxkkno0MeWZ9vprA9NELw2zBTZLmmeat
1cGNxfemxU19yNhOuX4DtlqvqHJ6YQrdDwAEavwH14Oec/ssmGA=
=yXZE
-----END PGP SIGNATURE-----

--MAH+hnPXVZWQ5cD/--


