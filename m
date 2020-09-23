Return-Path: <SRS0=UzyQ=DA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44A5EC4363D
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 23:10:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 513FF20759
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 23:10:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IAXdr9hb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 513FF20759
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42070 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLDtl-0001kz-6k
	for qemu-devel@archiver.kernel.org; Wed, 23 Sep 2020 19:10:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51420)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1kLDsh-0000wr-9f
 for qemu-devel@nongnu.org; Wed, 23 Sep 2020 19:08:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:46182)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1kLDse-0007pX-A3
 for qemu-devel@nongnu.org; Wed, 23 Sep 2020 19:08:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600902534;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xV8cbduwguFb9tNhuSV3uKwFMOyFl0p+h2mWI8mxlp0=;
 b=IAXdr9hbBFQHbt+mZZxLO46Ubactantz+D8J4N/FIf3sBJ3iAmfdV6ey2oGkpo2egrYZf8
 hwYbUcmJ9e3FyB9Q3eKmzkWp3uCULr226hy4LcaNrwdL9PUlPp/EqNvfMuW2sbvjgujAhH
 6ViDUZx0S5WIWlOiRuMq1UkS5k7KtSw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-157-ihP7QJfDN0mySvt_k2MNCw-1; Wed, 23 Sep 2020 19:08:51 -0400
X-MC-Unique: ihP7QJfDN0mySvt_k2MNCw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5F6E01005E6D;
 Wed, 23 Sep 2020 23:08:50 +0000 (UTC)
Received: from localhost.localdomain (ovpn-119-55.rdu2.redhat.com
 [10.10.119.55])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B00F71002397;
 Wed, 23 Sep 2020 23:08:48 +0000 (UTC)
Date: Wed, 23 Sep 2020 19:08:46 -0400
From: Cleber Rosa <crosa@redhat.com>
To: John Snow <jsnow@redhat.com>
Subject: Re: [PATCH v2 24/38] qapi/gen.py: Fix edge-case of _is_user_module
Message-ID: <20200923230846.GX191229@localhost.localdomain>
References: <20200922210101.4081073-1-jsnow@redhat.com>
 <20200922210101.4081073-25-jsnow@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200922210101.4081073-25-jsnow@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=crosa@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="lBR2yNlwcY132B3M"
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=crosa@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/22 23:02:20
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.228,
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org,
 Michael Roth <mdroth@linux.vnet.ibm.com>,
 Markus Armbruster <armbru@redhat.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--lBR2yNlwcY132B3M
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 22, 2020 at 05:00:47PM -0400, John Snow wrote:
> The edge case is that if the name is '', this expression returns a
> string instead of a bool, which violates our declared type.
>=20
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  scripts/qapi/gen.py | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/scripts/qapi/gen.py b/scripts/qapi/gen.py
> index 9898d513ae..cb2b2655c3 100644
> --- a/scripts/qapi/gen.py
> +++ b/scripts/qapi/gen.py
> @@ -251,7 +251,7 @@ def __init__(self, prefix, what, user_blurb, builtin_=
blurb, pydoc):
> =20
>      @staticmethod
>      def _is_user_module(name):
> -        return name and not name.startswith('./')
> +        return name is not None and not name.startswith('./')

Another possibility here that handles the empty string situation and
will never return anything but a bool:

  return all([name, not name.startswith('./')])

Either way,

Reviewed-by: Cleber Rosa <crosa@redhat.com>

--lBR2yNlwcY132B3M
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEeruW64tGuU1eD+m7ZX6NM6XyCfMFAl9r1XsACgkQZX6NM6Xy
CfMSnQ//UZcmPmOHBygrWNIGUFWW865vL0hEqf8JgH97u1J9WdLxR2hF2mPPAapB
9Mo43Rhe+jRX/2VyJsvvv6/oiagDxCFguoCGKdjuGMrYtCztXbUIuD7MXzBkeg9x
HqlipBLoEc2Uh3QdeqwNsY5J6EHb0CkjmbNa9KJnKlUs19HqNRCu6IIr0Ydb4rTJ
k8+v9eXh6dfLZPin28HlloxPQCNPp1fLBOS89GAH9HLpIpNRXZxpMN2W/mFJR5h5
H1B317CWBCtI0Ha4qLhgdlLu8ULqz1e8U4xX3uu1YrYy33fqOb0RN2w5kTVY6htD
A7JXkFxCdtDMFr000GCrq6AdMJ/as2PNhQTKPhb23N4QTxJGmj4esO/80D0Kue9w
It4rR5K6WzbzvQa41+iyBMdmbuNoanaZ19UFbKF+HHA7hKcmDt/Owrbt5oQcpf2l
vZQW0XGxb1ajh5kLPb7vVqegCLA9LQZujwP4VEq554+oEYGtLFrYYqDTs6lL3ga0
PHGCdJEiFlPc6BfgCBmPFHmTUadpT75Iz2j8Wjub4Yo1xnIvqR4lX47LDw3YyAnr
Kej4fQtkHCEDgIEjObGZonh1RTYqjClbFNSYO6rd/sVI18NZD73C6Ip5IDzZ8w+H
aGk5AN8dxipXRbwDLpJCiL/0sBzTQ3dhcID9aLzGnMx2AMWN7rw=
=cPut
-----END PGP SIGNATURE-----

--lBR2yNlwcY132B3M--


