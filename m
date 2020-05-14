Return-Path: <SRS0=rzeH=64=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD87FC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 11:05:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF21C20722
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 11:05:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RM8AmA1j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF21C20722
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49472 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZBgR-0004LZ-OB
	for qemu-devel@archiver.kernel.org; Thu, 14 May 2020 07:05:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42412)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jZBfW-0003gE-AS
 for qemu-devel@nongnu.org; Thu, 14 May 2020 07:04:50 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:28085
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jZBfS-0001N0-3B
 for qemu-devel@nongnu.org; Thu, 14 May 2020 07:04:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589454284;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=y8iSoVIJWHMzv7kJ77/PP9MePbVfuXqeA4xkNpY8gK8=;
 b=RM8AmA1jgJfQlsouGNTT/wuLFWlFc4WZzmSsRkejpSxjaSdgv3RYE0J44yqWhM2UAmJcX3
 yrN7LyMV0k0na09k6YBGlp2jiqDOK4oMSgfEcNuPFzLtA7p8u06fsVIt8kYBAaQjhqM/W3
 X2yPsJU/pjB9NWRrGV9UEECG7k6Vvuo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-261-NdwjqWhVOy61pEHIC2f0gg-1; Thu, 14 May 2020 07:04:42 -0400
X-MC-Unique: NdwjqWhVOy61pEHIC2f0gg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5DF1318FE866;
 Thu, 14 May 2020 11:04:41 +0000 (UTC)
Received: from linux.fritz.box (ovpn-114-9.ams2.redhat.com [10.36.114.9])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5CC1C51322;
 Thu, 14 May 2020 11:04:39 +0000 (UTC)
Date: Thu, 14 May 2020 13:04:37 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Max Reitz <mreitz@redhat.com>
Subject: Re: [RFC v2] migration: Add migrate-set-bitmap-node-mapping
Message-ID: <20200514110437.GD5518@linux.fritz.box>
References: <20200513145610.1484567-1-mreitz@redhat.com>
 <6a82008b-d272-82f2-a8a1-615437abcda7@virtuozzo.com>
 <dc5dbf70-a0da-67eb-b1b4-2f74778ec671@redhat.com>
MIME-Version: 1.0
In-Reply-To: <dc5dbf70-a0da-67eb-b1b4-2f74778ec671@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="l76fUT7nc3MelDdI"
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
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org, Juan Quintela <quintela@redhat.com>,
 qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Peter Krempa <pkrempa@redhat.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--l76fUT7nc3MelDdI
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 14.05.2020 um 11:09 hat Max Reitz geschrieben:
> On 13.05.20 22:09, Vladimir Sementsov-Ogievskiy wrote:
> [...]
> > 1. So, you decided to make only node-mapping, not bitmap-mapping, so we
> > can't rename bitmaps in-flight and can't migrate bitmaps from one node
> > to several and visa-versa. I think it's OK, nothing good in such
> > possibilities, and this simplifies things.
>=20
> On second thought, I wonder whether it would be useful to migrate
> bitmaps from multiple nodes to a single one.  But probably not, this
> would only make sense for filters, really, and in such a case the
> bitmaps should probably just be moved prior to migration.
>=20
> (And I can=E2=80=99t imagine any other case.  When flattening backing cha=
ins,
> the bitmaps from the dropped layers basically become useless.)

I agree, you can always move the bitmaps in a separate step, either on
the source before migration or on the destination afterwards. Migration
is already complicated enough, let's not move things into it that don't
necessarily have to be there.

You would get complications like possibly conflicting bitmap names when
you migrate the bitmaps of two nodes into a single one.

Kevin

--l76fUT7nc3MelDdI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE3D3rFZqa+V09dFb+fwmycsiPL9YFAl69JcUACgkQfwmycsiP
L9aZhg//SDSXBt3HHJpXx3j2y6pPdbhBma5J9mLn5kLh1xxfXoUlNE0BA1lgKBCo
+TzhmjRrD5KtXtcE5zmJYDROIdURVKXbYLRo/eoLPPoTojyA/BXISoMqTRQ5B9hH
KNYh4leLbbAD2TqmD6m0g1nF/N4Ig/uRz90kgvt1yFURDp5/eYhuySKq8uLpYm+H
HRQHIJUHgtVYQifpfQKRpf238DWepREtpu6wqTWYCyG0qde2E0UkSv+SbE7hK/A+
CEl4U7+CVTJZIAM5iFrDFzhBeIZv9yLORwmONhi04L8tylBI+pJ8xnoylvx/MBHH
P8nreifyDLptMYCBERnkVcKlxti5AH0SBv/9IfQT71oXx4R6obBR0yd1k30dT0IU
u+cIgH/jmPTuN03UCLXUyJGQoN02wyth+mycfKddMBDT97OFouhTpI6kwQl4G2dy
un5YqsrSLfKpYaafit47rU3+0AEfckmmamIDPSxPmvoGhmrPHBO3HAYLadl3GQ2n
DiVXyZYMYRY560i/kHQFWKELAwgE6hpMXPQHr4MuiLZSjh4UZ/+VmwRucmLzipwp
U17vW1m8kuX8C9q1L9cR0lzVopk5XrcIc1gVmONOHq3p3SmQe29crMiNd9sALaKY
eHwRkd7YexyMzLA4GXZv9NQGaNMsNZIxGhsnnpHznpfwBY8FtOs=
=jIi6
-----END PGP SIGNATURE-----

--l76fUT7nc3MelDdI--


