Return-Path: <SRS0=zL9l=BA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 280B3C433E2
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2020 10:51:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E5D4E2073A
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2020 10:51:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O77owdf7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5D4E2073A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39438 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jxps0-0000ml-7V
	for qemu-devel@archiver.kernel.org; Tue, 21 Jul 2020 06:51:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36086)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jxpqr-0008Gf-Hv
 for qemu-devel@nongnu.org; Tue, 21 Jul 2020 06:50:25 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:29452
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jxpqo-0006Wg-7S
 for qemu-devel@nongnu.org; Tue, 21 Jul 2020 06:50:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595328620;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=OqGKuVBOzR1VPuKdPylM1/B/0TyTxtijUJ1Feh8/wL0=;
 b=O77owdf7L4zu8lTUTJ2XExOBslnUYHrFbXiJChyoK64fZKwYiVvlkqaGg1NDiG3Hnp2k16
 4nM0DcjQUKGs6QH3vCvbkeaNAyFqMhI35WDnIC5foXCm+s/LS1VXU7NGTGUtAujynOZ7MA
 ij/Qf8wlwd2d1o4wwRXC6wkBPVDdF1Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-285--QYE4CkSOkO9fakSOrJ5BA-1; Tue, 21 Jul 2020 06:50:15 -0400
X-MC-Unique: -QYE4CkSOkO9fakSOrJ5BA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EA9051083;
 Tue, 21 Jul 2020 10:50:14 +0000 (UTC)
Received: from localhost (ovpn-114-133.ams2.redhat.com [10.36.114.133])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 883E62DE7F;
 Tue, 21 Jul 2020 10:50:14 +0000 (UTC)
Date: Tue, 21 Jul 2020 11:50:13 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Subject: Re: Memory leak in bitmap code?
Message-ID: <20200721105013.GC172689@stefanha-x1.localdomain>
References: <5f14a0997a4e8_4e6d3fcbdd8e41b010815d@sidekiq-catchall-05-sv-gprd.mail>
 <16102b4a-160a-a400-a332-4477b83468d8@redhat.com>
 <90825871-7259-d516-e103-176d0433c4e6@virtuozzo.com>
MIME-Version: 1.0
In-Reply-To: <90825871-7259-d516-e103-176d0433c4e6@virtuozzo.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="WplhKdTI2c8ulnbP"
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=stefanha@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/21 01:46:39
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Thomas Huth <thuth@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--WplhKdTI2c8ulnbP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 20, 2020 at 10:50:23AM +0300, Vladimir Sementsov-Ogievskiy wrot=
e:
> 20.07.2020 09:16, Thomas Huth wrote:
> >=20
> >   Hi,
> >=20
> > looks like the LeakSanitizer spotted a memory leak in the bitmap relate=
d
> > code ... not sure why it just triggered with Richard's pull request, an=
d
> > I can also not reproduce it... But since there is a nice backtrace in i=
t
> > and there have been some bitmap-related patches recently, could you
> > maybe have a look whether this rings a bell by any chance:
> >=20
> >   https://gitlab.com/qemu-project/qemu/-/jobs/645799805#L3282
> >=20
>=20
> Hi! Hmm. bitmap.c/bitmap.h is a simple bitmap library, which was not chan=
ged this
> year. The last commit I see is about a year ago.
>=20
> So, I assume the problem should be somewhere below in the stack trace.
>=20
> I don't know this code, but try to look at:
>=20
> OK, sanitizer reports that we loose the memory allocated at exce.c:2219, =
i.e.
>=20
> new_blocks->blocks1[j] =3D bitmap_new(DIRTY_MEMORY_BLOCK_SIZE);
>=20
> Hmm. And where is this bitmap released? I can't find the place. May be th=
e leak
> was introduced in far 5b82b703b69acc67b7 with this bitmap_new()? Add Stef=
an to
> CC.

g_free_rcu() is used when ram_list->dirty_memory[] is extended, so the
leak is not dangerous.

There is no cleanup function for the global ram_list. I'll investigate
writing a patch to clean up ram_list fields.

Thanks,
Stefan

--WplhKdTI2c8ulnbP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl8WyGUACgkQnKSrs4Gr
c8itOggAolejLDswJYFJAe3xhMj+wMSUhhwZ5dEdm58obvZWw7D3XhvnIzw6Q1ns
j/wCl/VZlKyGNR0ElZpvzcNIYoK39u3U1oFBgabwd5e1YXQkGqiHC/gz4gfmGVGl
1dtRfPN9j3fE1SqMdXmLhzYBEuJHpdWlcsLaoF7zH9GIt181JfdRRJzJulMBRcrN
A7ZAPkTJn/64nXKld8+Lc3Gp0puHRPdAqHoOLYiBEr0lNYXcBzSJbUHtCsCcmGbs
D2PrIXkHWjC0lp+uXcu1nWopS21rb3+JOXIzW56PB/q0CnhvvGeKLY9etCaXN9E5
Lm7Lyx6/GQj6h8aR5X19zf81z461jQ==
=l9Nl
-----END PGP SIGNATURE-----

--WplhKdTI2c8ulnbP--


