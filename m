Return-Path: <SRS0=B5/Q=AS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6893C433E0
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 16:46:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6F90220708
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 16:46:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DYNbbrdf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F90220708
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34420 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jsqjf-0000xA-Na
	for qemu-devel@archiver.kernel.org; Tue, 07 Jul 2020 12:46:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33222)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jsqB8-0002Rc-FW
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 12:10:42 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:35602)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jsqB6-0007gH-Ax
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 12:10:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594138239;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=BPDB8S1Ifc9RbpISTGmqL+hqWTYUrTnEIXXa+3mt/ns=;
 b=DYNbbrdfqBSzDJgA70NTnEU+8EcopH7klXHZ4F21zjXBkgqtbx7CaMomNfYCpQu7UzzF9w
 Ed+Dg+NOoVldnfwD5EucrIvvpz8V/j2zBlYeWF6aEWbbEfjMiWPqOGghZNKxhgiCdJCjRv
 xuL17KDKe4CjbxO0KJWzhocIggfO4JM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-14-PQTqer9IP-6KTIQktyBFGg-1; Tue, 07 Jul 2020 12:10:27 -0400
X-MC-Unique: PQTqer9IP-6KTIQktyBFGg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D94C8800D5C;
 Tue,  7 Jul 2020 16:10:25 +0000 (UTC)
Received: from localhost (ovpn-113-68.ams2.redhat.com [10.36.113.68])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 51E081002394;
 Tue,  7 Jul 2020 16:10:25 +0000 (UTC)
Date: Tue, 7 Jul 2020 17:10:24 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Subject: Re: [PATCH 2/5] block/io: introduce bdrv_co_range_try_lock
Message-ID: <20200707161024.GB459887@stefanha-x1.localdomain>
References: <20200620143649.225852-1-vsementsov@virtuozzo.com>
 <20200620143649.225852-3-vsementsov@virtuozzo.com>
MIME-Version: 1.0
In-Reply-To: <20200620143649.225852-3-vsementsov@virtuozzo.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="R3G7APHDIzY6R/pk"
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=stefanha@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/07 00:31:00
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: fam@euphon.net, kwolf@redhat.com, qemu-block@nongnu.org,
 Anton.Nefedov@acronis.com, armbru@redhat.com, qemu-devel@nongnu.org,
 mreitz@redhat.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--R3G7APHDIzY6R/pk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 20, 2020 at 05:36:46PM +0300, Vladimir Sementsov-Ogievskiy wrot=
e:
> @@ -83,6 +84,12 @@ typedef struct BdrvTrackedRequest {
>      CoQueue wait_queue; /* coroutines blocked on this request */
> =20
>      struct BdrvTrackedRequest *waiting_for;
> +
> +    /*
> +     * If non-zero, the request is under lock, so it's allowed to inters=
ect
> +     * (actully it must be inside) the @lock request.

s/actully/actually/

> @@ -745,15 +747,26 @@ static bool coroutine_fn wait_or_find_conflicts(Bdr=
vTrackedRequest *self,
>              if (tracked_request_overlaps(req, self->overlap_offset,
>                                           self->overlap_bytes))
>              {
> -                /* Hitting this means there was a reentrant request, for
> -                 * example, a block driver issuing nested requests.  Thi=
s must
> -                 * never happen since it means deadlock.
> +                if (self->lock =3D=3D req) {
> +                    /* This is atomic request under range_lock */
> +                    assert(req->type =3D=3D BDRV_TRACKED_LOCK);
> +                    assert(self->offset >=3D req->offset);
> +                    assert(self->bytes <=3D req->bytes);

These assertions do not catch requests that start within the locked
region but span beyond the end of the region. How about:

  assert(self->offset + self->bytes - req->offset >=3D req->bytes);

> +int coroutine_fn bdrv_co_pwrite_zeroes_locked(BdrvChild *child, int64_t =
offset,
> +                                              int bytes, BdrvRequestFlag=
s flags,
> +                                              BdrvTrackedRequest *lock)

The name is confusing because _locked() normally means that a mutex
should be held. Functions using that naming convention already exist in
block/io.c. It would be nice to distinguish between functions that need
BdrvTrackedRequest and functions that must be called with a mutex held.

How about bdrv_co_pwrite_zeroes_with_lock()?

--R3G7APHDIzY6R/pk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl8EnnAACgkQnKSrs4Gr
c8gXUQgAu0lOL2QLEvdxnujCgFFKg9JzQvKuCbg/8jGipCJmJXqb5bPW73z6CvN/
gJ146ciswO0qwbOUMLV9HWu0IiLYwScrGs/1iV5Dhj/ICu2LShICfV3gqhUiO2Xy
/qUoiMbu1t+2rQ+QQi00JHzqyRePJ/awdcTHY3/KuZJmatwKTFQF3iSSQUzNd7CM
2I///XNi2Vxen4Yn/dEQmub4/rwa8l8WH39p3eNo+3IW/vf7EV2cwrd9UnJs9TLZ
J/Hn7uj1OjzhJBuU1lVchhR8iFGnNnFefwRHY0DBlrSWJs2V+++D4Nysxkw42ptW
nBZHdnwMU9wmEWleR7DsLJWQmhXudw==
=eHam
-----END PGP SIGNATURE-----

--R3G7APHDIzY6R/pk--


