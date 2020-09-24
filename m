Return-Path: <SRS0=QZTr=DB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53A34C4363D
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 11:27:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD16A2395B
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 11:27:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hA+5/RhN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD16A2395B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54398 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLPPc-0000R8-Qj
	for qemu-devel@archiver.kernel.org; Thu, 24 Sep 2020 07:27:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39528)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kLPMd-0004pv-29
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 07:24:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:60193)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kLPMB-0004ZT-FT
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 07:24:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600946650;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lbjEMjmXxh9sGQhB/+Im41pv1jla9LL6zlkMThvXYP0=;
 b=hA+5/RhNfLBs1pKrr0URlogCUA6/x122Ov4DGASnkgGlhJ2cDCvRUNkSI0eyJHslk2PSXV
 yFYZ7viSOtzmkRWNo1L3n5ERgcJFzffHrr+aHH757MGhVkSESSX6JBGzMqELRcQ9G4NDaM
 WGtG7jzxbNnBnbHhTvcKkJB9JdyHvy0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-163-Su90VoSPPK-EeXuUowqgFw-1; Thu, 24 Sep 2020 07:24:06 -0400
X-MC-Unique: Su90VoSPPK-EeXuUowqgFw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DD0DD1091068;
 Thu, 24 Sep 2020 11:24:04 +0000 (UTC)
Received: from localhost (ovpn-114-5.ams2.redhat.com [10.36.114.5])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7908578827;
 Thu, 24 Sep 2020 11:24:04 +0000 (UTC)
Date: Thu, 24 Sep 2020 12:24:03 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Subject: Re: [PATCH v8 2/7] block/io: refactor coroutine wrappers
Message-ID: <20200924112403.GU62770@stefanha-x1.localdomain>
References: <20200915164411.20590-1-vsementsov@virtuozzo.com>
 <20200915164411.20590-3-vsementsov@virtuozzo.com>
MIME-Version: 1.0
In-Reply-To: <20200915164411.20590-3-vsementsov@virtuozzo.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="8Tx+BDMK09J610+l"
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/22 23:02:20
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.199,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: fam@euphon.net, kwolf@redhat.com, ehabkost@redhat.com,
 qemu-block@nongnu.org, qemu-devel@nongnu.org, mreitz@redhat.com,
 crosa@redhat.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--8Tx+BDMK09J610+l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 15, 2020 at 07:44:06PM +0300, Vladimir Sementsov-Ogievskiy wrot=
e:
> Most of our coroutine wrappers already follow this convention:
>=20
> We have 'coroutine_fn bdrv_co_<something>(<normal argument list>)' as
> the core function, and a wrapper 'bdrv_<something>(<same argument
> list>)' which does parameters packing and call bdrv_run_co().
>=20
> The only outsiders are the bdrv_prwv_co and
> bdrv_common_block_status_above wrappers. Let's refactor them to behave
> as the others, it simplifies further conversion of coroutine wrappers.
>=20
> This patch adds indirection layer, but it will be compensated by
> further commit, which will drop bdrv_co_prwv together with is_write
> logic, to keep read and write path separate.
>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> Reviewed-by: Eric Blake <eblake@redhat.com>
> ---
>  block/io.c | 60 +++++++++++++++++++++++++++++-------------------------
>  1 file changed, 32 insertions(+), 28 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--8Tx+BDMK09J610+l
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl9sgdMACgkQnKSrs4Gr
c8hi6gf9E8GXn8H8iEJ5L2+Dt96y7PmdzawX78o756UUfmfBiOYPc2+OCxnunFQ6
79qB9N8VMO/iTjpIyDuQ1FXtZk5v1uZ6nvSjW4MZXWHOXrXeNooQ1GVKs/Aoql9j
++t7tkJXu6Zw3mohCULjtluyiDHpNyQRv4xn1XfFLziLVfSIA3B0+g8Mdw74ccQ0
hjUcV17bwBcBWcx+l+5jejSBNZFRw4SbSDGUYOWRhLBIYgy+lH9JiH82uScPUYBj
07BQQYm9JjoMU8rLJTHH7dQIT+XEER/rYZQB0LbpJaqzyYpXn7i7KfnyP9oMy2Vx
jhoCZDcHjR/nZEQDMZSYyTofZfd8cw==
=31Hw
-----END PGP SIGNATURE-----

--8Tx+BDMK09J610+l--


