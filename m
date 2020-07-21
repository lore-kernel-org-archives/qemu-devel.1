Return-Path: <SRS0=zL9l=BA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C54CC433E7
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2020 12:06:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2419820771
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2020 12:06:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cC7ua1QL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2419820771
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54472 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jxr22-0006p3-A2
	for qemu-devel@archiver.kernel.org; Tue, 21 Jul 2020 08:06:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55056)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jxr1Q-0006My-K4
 for qemu-devel@nongnu.org; Tue, 21 Jul 2020 08:05:24 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:38683
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jxr1O-0000Hi-LE
 for qemu-devel@nongnu.org; Tue, 21 Jul 2020 08:05:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595333121;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fFMrPfWYFezO5t/AQkvYvD/oIfT77GqbOVKnI1qJGBY=;
 b=cC7ua1QLpTATjF5cuUccQy3TULW0v9KmnyMioxVICnDD86GOwfJdH2bgBGv6gTE2p535+2
 yFLjSygrIbC5II7lr6LVtXB1L5ea+8iwWEbXkKsDPEsXYAtHvhK3kxlyTIqByRLRyvnDfX
 iY0sLKPQB54tqLMLsA+sXIKGJys6g2M=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-422-WBJVD29RORuZpdNZHSAGKw-1; Tue, 21 Jul 2020 08:05:19 -0400
X-MC-Unique: WBJVD29RORuZpdNZHSAGKw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 131741005504;
 Tue, 21 Jul 2020 12:05:18 +0000 (UTC)
Received: from localhost (ovpn-114-133.ams2.redhat.com [10.36.114.133])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8AE9D8730A;
 Tue, 21 Jul 2020 12:05:17 +0000 (UTC)
Date: Tue, 21 Jul 2020 13:05:16 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Subject: Re: Memory leak in bitmap code?
Message-ID: <20200721120516.GA183198@stefanha-x1.localdomain>
References: <5f14a0997a4e8_4e6d3fcbdd8e41b010815d@sidekiq-catchall-05-sv-gprd.mail>
 <16102b4a-160a-a400-a332-4477b83468d8@redhat.com>
 <90825871-7259-d516-e103-176d0433c4e6@virtuozzo.com>
MIME-Version: 1.0
In-Reply-To: <90825871-7259-d516-e103-176d0433c4e6@virtuozzo.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="M9NhX3UHpAaciwkO"
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=stefanha@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/21 01:30:29
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

--M9NhX3UHpAaciwkO
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

Looking at this more there are a bunch of exec.c resources that are not
freed at shutdown (system_memory, mutexes, etc). I don't think it is
worth freeing them, especially not for QEMU 5.1 since it needs to be
done very carefully to avoid dangling pointers in case something else
that hasn't been free is still referencing the resources.

Stefan

--M9NhX3UHpAaciwkO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl8W2fwACgkQnKSrs4Gr
c8ik4QgApSLLACH05qXM//3v0AqwvTe6OWC9n8kJIoEei4ud5oQWhlhWeBHNZAcu
lY7kpLCAnAK8/Jp3d+5rKXDOHM/3gpUtDf6ROQb2OH27DsNxn82YOrbjW8n+3bKg
ZpJBy1VRFLha8BCXl28PojcgD/3ei+OItqrTKUD+c4uah7Y0S5GPTa8DD/m9HXyp
b6ps1Se7Oq50CN/MpLAxWYaf4navxcIfSsHwvXlO6zExaEAQmjlI5We211uCibeX
86IAqWWdtyg1jvK76/OhN/VOh4Rs3Q9IYItEEXOi3D1N1D6r63RCxVT1sWhSsRCC
bXfBVKPhqrMNpghac/+OMqXXoOecaA==
=lmxl
-----END PGP SIGNATURE-----

--M9NhX3UHpAaciwkO--


