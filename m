Return-Path: <SRS0=bVMU=B5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FB08C433E1
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2020 15:00:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A5B82076E
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2020 15:00:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gA6Xl30b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A5B82076E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43964 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k8PZy-0005vl-BQ
	for qemu-devel@archiver.kernel.org; Wed, 19 Aug 2020 11:00:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55530)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1k8PYx-0004Qe-PW
 for qemu-devel@nongnu.org; Wed, 19 Aug 2020 10:59:39 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:41693
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1k8PYw-0005Ca-6T
 for qemu-devel@nongnu.org; Wed, 19 Aug 2020 10:59:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597849177;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Dax6ojqcdgW6yrTiTuBqdm9JAsBXyleFwZW48Hu9uvo=;
 b=gA6Xl30bz19WJaq46T8cOWzIkGTLahNxF2HGG5KmzjO9Q8x96knod3MkqiJs/7AO80FnmM
 OpiUVATEBxXkr71EfJjPmkrjbnJdiwbDLvNDt4vcyWMHZChgxT5NThupppGMT4mrbQnmr8
 BXUD4F5pzl8gHqg9duvztf79vUvi+Ug=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-115-4_vyTA82N06sriLlovGMug-1; Wed, 19 Aug 2020 10:59:32 -0400
X-MC-Unique: 4_vyTA82N06sriLlovGMug-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A579264080;
 Wed, 19 Aug 2020 14:59:31 +0000 (UTC)
Received: from localhost (ovpn-113-22.ams2.redhat.com [10.36.113.22])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 39F625D9D5;
 Wed, 19 Aug 2020 14:59:31 +0000 (UTC)
Date: Wed, 19 Aug 2020 15:59:29 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Subject: Re: [PATCH v3 04/12] block/io:
 bdrv_wait_serialising_requests_locked: drop extra bs arg
Message-ID: <20200819145929.GK366841@stefanha-x1.localdomain>
References: <20200817091553.283155-1-vsementsov@virtuozzo.com>
 <20200817091553.283155-5-vsementsov@virtuozzo.com>
MIME-Version: 1.0
In-Reply-To: <20200817091553.283155-5-vsementsov@virtuozzo.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="7ArrI7P/b+va1vZ8"
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/19 01:46:53
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
Cc: fam@euphon.net, kwolf@redhat.com, qemu-block@nongnu.org, armbru@redhat.com,
 qemu-devel@nongnu.org, mreitz@redhat.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--7ArrI7P/b+va1vZ8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 17, 2020 at 12:15:45PM +0300, Vladimir Sementsov-Ogievskiy wrot=
e:
> bs is linked in req, so no needs to pass it separately. Most of
> tracked-requests API doesn't have bs argument. Actually, after this
> patch only tracked_request_begin has it, but it's for purpose.
>=20
> While being here, also add a comment about what "_locked" is.
>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  block/io.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--7ArrI7P/b+va1vZ8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl89PlEACgkQnKSrs4Gr
c8gA4gf8ChY+5pMNSgq+jlGqxV/bXvRuo+EHHybB1NoJlBYanIj1uyWaB77Hzpim
QTTxxpjZ3ASjRAR5Ewl3Cah4QWrpwVLTXw03UhDG3kHQsPSh1mYVoY8TzX/Rx+y9
+8EPzJ/Q7S+Vc8Q/jMJc8Teb1AbfLRWKYYbvMkYN71MsIvJUMuTp7bKlKfXwxair
GMsdqGqQrgkLuII14xStHJM0ClXaotRe8w94W0dXb28Cep1JGk0nOUIUGTigE10h
NFkPvE0TItIH2PVistuLSvO3IcESN9ujD887xH1l+TxRnS2NZX9YfbCPobQ/TmLX
iiXq/KMj6wprq8AbRU4jQlUBPJuUVw==
=JCB2
-----END PGP SIGNATURE-----

--7ArrI7P/b+va1vZ8--


