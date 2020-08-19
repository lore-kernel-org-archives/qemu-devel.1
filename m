Return-Path: <SRS0=bVMU=B5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1721C433E1
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2020 14:44:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7105B207BB
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2020 14:44:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IDMan4Px"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7105B207BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39120 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k8PJw-0008Ub-LP
	for qemu-devel@archiver.kernel.org; Wed, 19 Aug 2020 10:44:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49516)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1k8PGX-00033K-25
 for qemu-devel@nongnu.org; Wed, 19 Aug 2020 10:40:37 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:43941
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1k8PGV-0002Mh-AK
 for qemu-devel@nongnu.org; Wed, 19 Aug 2020 10:40:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597848034;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UgYFUI5HlBibB9Hns1rWlF1KhRxarlz9bVKpw1YfKBI=;
 b=IDMan4PxZ2GKvDqywA63hIKnrG/MbpuQy4CJpHF4AIYK2iJI1uDYHp7o9gH7A8qxZNhewY
 Vi39v8f3o/l53ZiPjnul/aqY/7V1L7dy1IckQAqOIFm+vWKejN7k0NcD0qD7jU076sMyWM
 GShqLwkXT/2LpGzEMtHkkWjwRZuxEQQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-371-i3jKOpkEMNSSirTJHgHVOA-1; Wed, 19 Aug 2020 10:40:28 -0400
X-MC-Unique: i3jKOpkEMNSSirTJHgHVOA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2A3438030B5;
 Wed, 19 Aug 2020 14:40:27 +0000 (UTC)
Received: from localhost (ovpn-113-22.ams2.redhat.com [10.36.113.22])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 61640756C3;
 Wed, 19 Aug 2020 14:40:26 +0000 (UTC)
Date: Wed, 19 Aug 2020 15:40:24 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Subject: Re: [PATCH v3 05/12] block: bdrv_mark_request_serialising: split
 non-waiting function
Message-ID: <20200819144024.GF366841@stefanha-x1.localdomain>
References: <20200817091553.283155-1-vsementsov@virtuozzo.com>
 <20200817091553.283155-6-vsementsov@virtuozzo.com>
MIME-Version: 1.0
In-Reply-To: <20200817091553.283155-6-vsementsov@virtuozzo.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="ExXT7PjY8AI4Hyfa"
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

--ExXT7PjY8AI4Hyfa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 17, 2020 at 12:15:46PM +0300, Vladimir Sementsov-Ogievskiy wrot=
e:
> @@ -882,6 +878,20 @@ static bool coroutine_fn bdrv_wait_serialising_reque=
sts(BdrvTrackedRequest *self
>      return waited;
>  }
> =20
> +bool bdrv_make_request_serialising(BdrvTrackedRequest *req, uint64_t ali=
gn)
> +{
> +    bool waited;
> +
> +    qemu_co_mutex_lock(&req->bs->reqs_lock);

qemu_co_mutex_lock() is a coroutine_fn so
bdrv_make_request_serialising() needs to be marked coroutine_fn too.

--ExXT7PjY8AI4Hyfa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl89OdgACgkQnKSrs4Gr
c8i84wf/bGzuaILb8ZjFYtfrnVVZItln1WJM2GwJehzTNvO4FIdSGAbDdaxyUGRA
pw6UcpTpij+HyzPAxBO4CSJZMWUIm+oSQPPH0EavjqLzhuNhV7vpIIJgvh0OK163
cua94KaNpcaFGpGo8khvCY6RkaWx0irXIOYLocXEaMHtTnagt7FidmOraiSadDXE
1b8GBuZ0eBotnCuSVBM2+k+y48Z8BeHBgV/PPhQdpr7c3jquvp4O6xNTWJb70JtV
RDa8H4XQI+NZMInIFxNsaR4+N3PqODGjDtT3oHy6fmG7G16W8s/WDCCyfCxagPZ+
BgQy/aERjQAyGmKxVr6IsqE08yB7jQ==
=MkOR
-----END PGP SIGNATURE-----

--ExXT7PjY8AI4Hyfa--


