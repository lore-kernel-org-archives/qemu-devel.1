Return-Path: <SRS0=JiPe=DG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80B3FC4727D
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 04:03:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DBFA4208FE
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 04:03:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QARExY4K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DBFA4208FE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50996 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kN6ra-0000cx-Sg
	for qemu-devel@archiver.kernel.org; Tue, 29 Sep 2020 00:03:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39480)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1kN6r0-00005o-PI
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 00:03:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:48845)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1kN6qz-00065u-7F
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 00:03:02 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601352180;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4SbMIqcOEFmb7ROQ1fqCGug253FOxI63jiWTVG5UbkY=;
 b=QARExY4Kvgn6Ik4KdGs+CvUxr5/7kmiMtiQOgljGpLFvId+rfqOJMMjFJsZ4j2JAqpT+OL
 t7WK6Qa36q63meNZ/cPWkGkA58wvtj7Tajc1H5y8CU3g0+Wqr1tuVJu77d4N6H0GPl7NSc
 muXrZhtl3HFnCNIfgmjQyS80L3K9JMY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-477-zNaX8UkRO8eOnHwaMfdoBw-1; Tue, 29 Sep 2020 00:02:57 -0400
X-MC-Unique: zNaX8UkRO8eOnHwaMfdoBw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 72E191DDED
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2020 04:02:56 +0000 (UTC)
Received: from localhost.localdomain (ovpn-119-55.rdu2.redhat.com
 [10.10.119.55])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D3C1B5D9CA;
 Tue, 29 Sep 2020 04:02:55 +0000 (UTC)
Date: Tue, 29 Sep 2020 00:02:53 -0400
From: Cleber Rosa <crosa@redhat.com>
To: John Snow <jsnow@redhat.com>
Subject: Re: [PATCH v3 07/47] qapi-gen: Separate arg-parsing from generation
Message-ID: <20200929040253.GH700868@localhost.localdomain>
References: <20200925002900.465855-1-jsnow@redhat.com>
 <20200925002900.465855-8-jsnow@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200925002900.465855-8-jsnow@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=crosa@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="BXr400anF0jyguTS"
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=crosa@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/28 23:30:14
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--BXr400anF0jyguTS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 24, 2020 at 08:28:20PM -0400, John Snow wrote:
> This is a minor re-work of the entrypoint script. It isolates a
> generate() method from the actual command-line mechanism.
>=20
> The regex match error checking was modified slightly to check that we
> actually got a regex match.
>=20
> Signed-off-by: John Snow <jsnow@redhat.com>
> Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>

Reviewed-by: Cleber Rosa <crosa@redhat.com>
Tested-by: Cleber Rosa <crosa@redhat.com>

--BXr400anF0jyguTS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEeruW64tGuU1eD+m7ZX6NM6XyCfMFAl9yse0ACgkQZX6NM6Xy
CfPWUxAAtGyYdDTqmhI+hQs4rjvDbQrbJhcS3jgo5DXH8I82D08HkuHIZ0NvpvUX
dkKdkPU3o0gMHX+BdWAhRQQb/MgttEgnPLxXLFxcjbUi3RIgRw5qg95kgqmMm053
KKkdAvdcqoVRmcpV3jtBZatlATatXdmBv6xgEkoUO4Jp7omHoduI7b9T7WRdugKj
xeuxXZz/olDo4prXSspxmTFzJdKjbmcWZHtqDtfrDfwjatClmR+JV1ArLHbcypnx
quoLIbtc20evAp6lIT7gzOguUW+y2Hnze8JzK/MIeAopLsOMELEg7lBZbPMbD6cR
jmYfriXMqBgGttUfQ17I7ozJjjkNgoFL5Poq44+v7ubLpEeiU25cQXE8/zBmIXB+
xeCo1oB4WJJUhAsVsVByv5OKmXJKWzbjElX7D1mpSqDPfJHqansrEE1nS2a8nfcQ
2PSB8St2R4wcR8rQ6gCClY1UyQ5whlQ5KO9td4NspKQfpKvROGzlRyN7OmEsm7oM
lVX8gdrAp3xqIvoL4oAfKo+XS7zXp+p3Le/gSp2RzK00XIP3y/kBUDd+h/X7itR/
FqKxZl+1SK3UBBg2N57+hGiFYRCtIp9kqvSZ9BTKSBQCX6fcS/swtpud6EmcAX8W
dOzdRnVJwnZcZydgVh2xK9T7wTxq6fcNfiCSasmytsX4T3s1pEo=
=mVuM
-----END PGP SIGNATURE-----

--BXr400anF0jyguTS--


