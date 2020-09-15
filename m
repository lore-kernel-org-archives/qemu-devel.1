Return-Path: <SRS0=sZ46=CY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 017C1C433E2
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 13:18:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A11520829
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 13:18:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LznmQVXr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A11520829
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35802 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIArD-0006pv-I3
	for qemu-devel@archiver.kernel.org; Tue, 15 Sep 2020 09:18:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47882)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <otubo@redhat.com>) id 1kI885-0005oT-BT
 for qemu-devel@nongnu.org; Tue, 15 Sep 2020 06:24:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:27100)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <otubo@redhat.com>) id 1kI883-0001aE-3d
 for qemu-devel@nongnu.org; Tue, 15 Sep 2020 06:24:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600165441;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MX6DwO1+cYy4O9yFD3IlyhXSTvyMOZBQ3OdN/82XOYQ=;
 b=LznmQVXr6ffkxBmF1+jEMrTl/CZjeZi0ZBjGR3wDIUOkCem2WIEG50wEKPzZdOHdumsPAI
 2+CxJ3pUkPoyMQexW7qfSnj1aC1t7XoHPAbdCSn4JKTQC8yM9ZtXFxOWpDoLQDv8HpWETl
 k/qT6OjDkeEaTJxFPSgRmkw+7nlPBVg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-244-KKJBPq5DOYW3JRCBIW4fcw-1; Tue, 15 Sep 2020 06:22:38 -0400
X-MC-Unique: KKJBPq5DOYW3JRCBIW4fcw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4B39F18B9F49
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2020 10:22:37 +0000 (UTC)
Received: from genji (ovpn-115-97.ams2.redhat.com [10.36.115.97])
 by smtp.corp.redhat.com (Postfix) with SMTP id 7188A75144;
 Tue, 15 Sep 2020 10:22:36 +0000 (UTC)
Date: Tue, 15 Sep 2020 12:22:35 +0200
From: Eduardo Otubo <otubo@redhat.com>
To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Subject: Re: [PATCH] seccomp: fix killing of whole process instead of thread
Message-ID: <20200915102235.GB5070@genji>
References: <20200911141832.1238636-1-berrange@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200911141832.1238636-1-berrange@redhat.com>
User-Agent: Mutt/1.8.3+47 (5f034395e53d) (2017-05-23)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=otubo@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="V0207lvV8h4k8FAm"
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=otubo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/15 02:10:32
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.792,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 15 Sep 2020 09:15:30 -0400
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--V0207lvV8h4k8FAm
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 11/09/2020 - 15:18:32, Daniel P. Berrange wrote:
> Back in 2018 we introduced support for killing the whole QEMU process
> instead of just one thread, when a seccomp rule is violated:
>=20
>   commit bda08a5764d470f101fa38635d30b41179a313e1
>   Author: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>   Date:   Wed Aug 22 19:02:48 2018 +0200
>=20
>     seccomp: prefer SCMP_ACT_KILL_PROCESS if available
>=20
> Fast forward a year and we introduced a patch to avoid killing the
> process for resource control syscalls tickled by Mesa.
>=20
>   commit 9a1565a03b79d80b236bc7cc2dbce52a2ef3a1b8
>   Author: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
>   Date:   Wed Mar 13 09:49:03 2019 +0000
>=20
>     seccomp: don't kill process for resource control syscalls
>=20
> Unfortunately a logic bug effectively reverted the first commit
> mentioned so that we go back to only killing the thread, not the whole
> process.
>=20
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> ---
>  qemu-seccomp.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/qemu-seccomp.c b/qemu-seccomp.c
> index e0a1829b3d..8325ecb766 100644
> --- a/qemu-seccomp.c
> +++ b/qemu-seccomp.c
> @@ -136,8 +136,9 @@ static uint32_t qemu_seccomp_get_action(int set)
> =20
>              if (qemu_seccomp(SECCOMP_GET_ACTION_AVAIL, 0, &action) =3D=
=3D 0) {
>                  kill_process =3D 1;
> +            } else {
> +                kill_process =3D 0;
>              }
> -            kill_process =3D 0;
>          }
>          if (kill_process =3D=3D 1) {
>              return SCMP_ACT_KILL_PROCESS;
> --=20
> 2.26.2
>=20

Acked-by: Eduardo Otubo <otubo@redhat.com>

--V0207lvV8h4k8FAm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEE1n4bUJN0hrQHI9ur3zLnwPD/+aIFAl9glesACgkQ3zLnwPD/
+aK+vQf/XaMsYgdXC447cvcWhp1FWDm0rORkkQBy1SFKkzwO4jShFHsDqqXHiKhw
xlm7PO3v6V9whPQOq+JJtUszZe2TiVAshoNICVAc9c31nGzJF2dwpzoJc7f2jFM9
1mDLeBp5jgLaR7bQ5P+R27KEH/l1/ia9JeFhhpXmHiExjMYo3NpY0TbcB4pBhy70
foqSpW+CHPI2NEuRohI9SoTBv0Rmyvg9joiurAzd9kk6+tSOo/RWmUO9S7FKvzmD
fFeE1mc87g98e4r/0gstitUKkC747gUcOz/s3fHfFMwBCIsrjJAAiCi585oeGXUu
L1MVVDRt+4bqE/YTts7Vm8qDRP5/FA==
=+VYp
-----END PGP SIGNATURE-----

--V0207lvV8h4k8FAm--


