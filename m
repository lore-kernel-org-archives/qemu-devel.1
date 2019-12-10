Return-Path: <SRS0=2P1T=2A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F28DFC43603
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2019 00:59:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BA7A22073D
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2019 00:59:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UQLlUyNp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA7A22073D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48862 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ieTru-00068o-Mg
	for qemu-devel@archiver.kernel.org; Mon, 09 Dec 2019 19:59:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60384)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <crosa@redhat.com>) id 1ieTr5-0005he-NK
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 19:58:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <crosa@redhat.com>) id 1ieTr4-0003Er-K6
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 19:58:23 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:37593
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <crosa@redhat.com>) id 1ieTr4-0003Eg-G9
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 19:58:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575939501;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=u/sDMbtLhyLxfz97HyhrudPfVvbmih0u/8ERfj0X4U4=;
 b=UQLlUyNp3pm21Jb8Y8JHvnmkAAB3nsRz/BCmS+E3SKWdWlaFqgZqfpMyL1buu+uiiOouWb
 tyezHiV+qV2vOjksa+z3FCqt0NlIDeap+KlzXFV2v6o0dMEaM7fRcMSaZROIdsIPyIpKMR
 t+iw2p141agefM3MtvWRA3fSB1543jg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-330-Yt98zv6YNFyhGaA9uKzyMA-1; Mon, 09 Dec 2019 19:58:18 -0500
X-MC-Unique: Yt98zv6YNFyhGaA9uKzyMA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B12E6800D41;
 Tue, 10 Dec 2019 00:58:17 +0000 (UTC)
Received: from localhost.localdomain (ovpn-125-99.rdu2.redhat.com
 [10.10.125.99])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9702F19C5B;
 Tue, 10 Dec 2019 00:58:09 +0000 (UTC)
Date: Mon, 9 Dec 2019 19:58:07 -0500
From: Cleber Rosa <crosa@redhat.com>
To: Wainer dos Santos Moschetta <wainersm@redhat.com>
Subject: Re: [PATCH v2 3/4] python/qemu: accel: Strengthen kvm_available()
 checks
Message-ID: <20191210005807.GD31990@localhost.localdomain>
References: <20191206213433.11305-1-wainersm@redhat.com>
 <20191206213433.11305-4-wainersm@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20191206213433.11305-4-wainersm@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="mJm6k4Vb/yFcL9ZU"
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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
Cc: fam@euphon.net, ehabkost@redhat.com, alex.bennee@linaro.org,
 qemu-devel@nongnu.org, philmd@redhat.com, jsnow@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--mJm6k4Vb/yFcL9ZU
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 06, 2019 at 04:34:32PM -0500, Wainer dos Santos Moschetta wrote=
:
> Currently kvm_available() checks for the presence of kvm module
> and, if target and host arches don't mismatch. This patch adds
> an 3rd checking: if QEMU binary was compiled with kvm
> support.
>=20
> Signed-off-by: Wainer dos Santos Moschetta <wainersm@redhat.com>
> Reviewed-by: Alex Benn=E9e <alex.bennee@linaro.org>
> Reviewed-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>
> ---
>  python/qemu/accel.py | 27 +++++++++++++++++++++------
>  1 file changed, 21 insertions(+), 6 deletions(-)
>=20
> diff --git a/python/qemu/accel.py b/python/qemu/accel.py
> index 746b7e68f5..9fecffb44b 100644
> --- a/python/qemu/accel.py
> +++ b/python/qemu/accel.py
> @@ -46,9 +46,24 @@ def list_accel(qemu_bin):
>      # Skip the first line which is the header.
>      return [l.strip() for l in lines[1:] if l]
> =20
> -def kvm_available(target_arch=3DNone):
> -    host_arch =3D os.uname()[4]
> -    if target_arch and target_arch !=3D host_arch:
> -        if target_arch !=3D ADDITIONAL_ARCHES.get(host_arch):
> -            return False
> -    return os.access("/dev/kvm", os.R_OK | os.W_OK)
> +def kvm_available(target_arch=3DNone, qemu_bin=3DNone):
> +    """
> +    Check if KVM is available using the following heuristic:
> +      - Kernel module is present in the host;
> +      - Target and host arches don't mismatch;
> +      - KVM is enabled in the QEMU binary.
> +
> +    @param target_arch (str): target architecture
> +    @param qemu_bin (str): path to the QEMU binary
> +    @return True if kvm is available, otherwise False.
> +    """
> +    if not os.access("/dev/kvm", os.R_OK | os.W_OK):
> +        return False
> +    if target_arch:
> +        host_arch =3D os.uname()[4]
> +        if target_arch !=3D host_arch:
> +            if target_arch !=3D ADDITIONAL_ARCHES.get(host_arch):
> +                return False
> +    if qemu_bin and "kvm" not in list_accel(qemu_bin):
> +        return False
> +    return True
> --=20
> 2.21.0
>=20

Reviewed-by: Cleber Rosa <crosa@redhat.com>
Tested-by: Cleber Rosa <crosa@redhat.com>

--mJm6k4Vb/yFcL9ZU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEeruW64tGuU1eD+m7ZX6NM6XyCfMFAl3u7ZwACgkQZX6NM6Xy
CfNhdRAAlkuZDqVgzkU88onl33rKFtAD1M2KXf3Z1BKIxCNQ2Qq5nmPFBIPnsAuQ
kPX+W9Ndb8E31/aZZtGxiAmmRTvNPS9q+/CRDyJZYB5TXYth8jKEWRvFQdzkjcLo
Ac0iMqbjoUCLkiqz2mStKjzeUpgtLBKwZtRgeGlWKRCkL/zmPAoeiyfGgvJX7pEi
i+zjopW1FYIg6b2uH4UZj5zwIrOTOGIZPoLoRzJRVMQvQl5qInlZ/Z0Gvmjzy7yM
1RyaTjeYyyPrVJ4e4JbiFbvfk+qRs0qFoIpOju8jeadUOEYK6aNOVTmLB6Qi0rrj
3ygYqacYH5IU3GmRowMYdSlRj490dY838mdmMWlRklznvWauuQx56OBygY3u1DEJ
DNpvWxEXy2ddLqPggddzv293Jlrdb095YIrR/oJ9R5PeTd96weCPpLANK3OXoxLD
pNtqMhggCpH3eFGyBs3kWnhYKuCqX92wsBWo6K+u8UE8WX37vuhYFiKUTsdWXucH
hRCdNaCPORrN3GmRbnJj12ITyWKgMiBJQBiOjwKU3Wo015tqP/ALX2oHdRmWV4Q8
lWjrjgY6VtvEQnlHAvBYJGs6XQyKcdtrb7XGW6mpkdKRTOvsrEiRiOBp8rxiqQs+
Wlht+6dxnOivh1PMNcwREBYnpl4UNQ5ex73+GMJmRlwL+kTgYGg=
=VA5E
-----END PGP SIGNATURE-----

--mJm6k4Vb/yFcL9ZU--


