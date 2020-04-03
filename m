Return-Path: <SRS0=URa6=5T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFA1BC43331
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2020 10:12:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7923120757
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2020 10:12:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AsqlgNrX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7923120757
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53150 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jKJJY-0008JL-L1
	for qemu-devel@archiver.kernel.org; Fri, 03 Apr 2020 06:12:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34865)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1jKJHq-00068u-Es
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 06:10:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1jKJHp-0001zw-9P
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 06:10:54 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:51675
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1jKJHp-0001zP-56
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 06:10:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585908652;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=EjDl7RJhUl4gal0S+CLLSPIpxT4VfbXva6nnJEnQ3e0=;
 b=AsqlgNrXrsyJul2AtpxLRNaFOxa7uVGFvJy4/SoAq2q1ywOZ5DW0k1MDE7a9kAPKkvX5Ww
 3XQ4fcCmZ/yrAbewsiHJNLEjj7MmM7oj47OQMzxbRNTCX7EgQnqbji3dRJdBTFiS62/sDm
 JXsCC4K7zawmr97ftQFsfQQ9R8h6hos=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-351-dHpZO7k9PfuYIE3CVXqRbg-1; Fri, 03 Apr 2020 06:10:48 -0400
X-MC-Unique: dHpZO7k9PfuYIE3CVXqRbg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 53D59100550D;
 Fri,  3 Apr 2020 10:10:47 +0000 (UTC)
Received: from localhost (ovpn-114-214.ams2.redhat.com [10.36.114.214])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8F1685DA87;
 Fri,  3 Apr 2020 10:10:44 +0000 (UTC)
Date: Fri, 3 Apr 2020 11:10:44 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v2] util/async: Add memory barrier to aio_ctx_prepare
Message-ID: <20200403101044.GA135040@stefanha-x1.localdomain>
References: <20200402024431.1629-1-fangying1@huawei.com>
 <20200402093221.GD28280@stefanha-x1.localdomain>
 <7de4d886-d861-5c80-f669-098b730906c8@redhat.com>
MIME-Version: 1.0
In-Reply-To: <7de4d886-d861-5c80-f669-098b730906c8@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="cNdxnHkX5QqsyA0e"
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: fam@euphon.net, zhang.zhanghailiang@huawei.com, qemu-devel@nongnu.org,
 qemu-stable@nongnu.org, qemu-arm@nongnu.org, Ying Fang <fangying1@huawei.com>,
 wu.wubin@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--cNdxnHkX5QqsyA0e
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 02, 2020 at 11:59:06AM +0200, Paolo Bonzini wrote:
> On 02/04/20 11:32, Stefan Hajnoczi wrote:
> > Paolo, I'm not sure how to interpret this case according to
> > docs/devel/atomics.txt.  Maybe you can clarify.
> >=20
> > atomic_or() is sequentially consistent and I therefore expected it to
> > act as a barrier.  Or does sequential consistency only cover the memory
> > accessed via the sequentially consistent atomics APIs and everything
> > else (like aio_compute_timeout()) can be reordered?
>=20
> Yes, that's what I expected too when I wrote that code. :(  But Torvald
> Riegel explained a while ago that seq-cst accesses are actually weaker
> than e.g. the Linux kernel atomics[1].
>=20
> The difference basically only matters if you are writing the relatively
> common synchronization pattern
>=20
> =09write A=09=09=09=09write B
> =09smp_mb()=09=09=09smp_mb()
> =09read B=09=09=09=09read A
> =09if not B then sleep=09=09if A then wake up the other side
> =09do something
>=20
> because you must either use memory barriers as above, or use seq-cst
> writes *and* reads.  You cannot rely on having a memory barrier implicit
> in the writes.
>=20
> Paolo
>=20
> [1] https://lists.gnu.org/archive/html/qemu-arm/2019-10/msg00051.html

Thanks.  I know you are probably very busy right now, but updating
atomics.txt would be great.

Stefan

--cNdxnHkX5QqsyA0e
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl6HC6MACgkQnKSrs4Gr
c8jb3wgApUrsFc9OgKA8jcUzLnqULaTnxs4Vbc3d3aTBOUUK6kohWoEmFIMqnUMt
84lw2B4PYoazj1aM5KoXQMFuS6+sLQff8NWNINXK2qBF+YQAPrMiakm7BMBtH1s2
wbFwPrlIDtpbnrK1ulC621NjPYOcvhn+yrWp4dHrXXjb/TJ+htXmrO1qteqDsVWl
pxv28G9pJ/SNl2AqrxAiN8mWDD2dRtQlo6VV2cEMidXoDogcGFzcQr/DM9dTgXgW
Nfc8sznFE8qt7BJe6vj5F05byOtnu6Jq8JTS7upWEUJDgeM+9AIOwxjgzXXbLwV5
5dJTLpyU4ef8P49mBZgQZAnJq8MKTQ==
=6w+Y
-----END PGP SIGNATURE-----

--cNdxnHkX5QqsyA0e--


