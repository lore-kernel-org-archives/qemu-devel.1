Return-Path: <SRS0=2P1T=2A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45EDDC43603
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2019 00:38:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 11B63206E0
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2019 00:38:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gcZxSuXM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11B63206E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48716 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ieTXT-0007UM-7R
	for qemu-devel@archiver.kernel.org; Mon, 09 Dec 2019 19:38:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55889)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <crosa@redhat.com>) id 1ieTWe-0006li-01
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 19:37:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <crosa@redhat.com>) id 1ieTWa-0003lO-S5
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 19:37:14 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:23038
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <crosa@redhat.com>) id 1ieTWa-0003kj-9g
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 19:37:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575938230;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qCd2Hq901afn/CjdzDibSBmN0Mg5+BrH/lT42gmeEhk=;
 b=gcZxSuXMFv4s/RH1Cto6wqaJ3/HVpJ/fq8o8C0RoiE1U4RBjHW7NaObq3qFQITna8FiUEW
 rdKIIom4yTJaDT28u5wXxbExz/BDl3gY4mknHvluruxpy78HH0XeQV+ACduXs4loSnWNr2
 lZXattBOmnC1Ge0PfhQHMsAjG5SOa8s=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-91-IcNJydTTNgCIZkxYzBQHZw-1; Mon, 09 Dec 2019 19:37:09 -0500
X-MC-Unique: IcNJydTTNgCIZkxYzBQHZw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DB1B5107ACC4;
 Tue, 10 Dec 2019 00:37:07 +0000 (UTC)
Received: from localhost.localdomain (ovpn-125-99.rdu2.redhat.com
 [10.10.125.99])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3E5751001925;
 Tue, 10 Dec 2019 00:36:59 +0000 (UTC)
Date: Mon, 9 Dec 2019 19:36:58 -0500
From: Cleber Rosa <crosa@redhat.com>
To: Wainer dos Santos Moschetta <wainersm@redhat.com>
Subject: Re: [PATCH v2 1/4] python/qemu: Move kvm_available() to its own module
Message-ID: <20191210003658.GB31990@localhost.localdomain>
References: <20191206213433.11305-1-wainersm@redhat.com>
 <20191206213433.11305-2-wainersm@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20191206213433.11305-2-wainersm@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="PmA2V3Z32TCmWXqI"
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
Cc: fam@euphon.net, ehabkost@redhat.com, alex.bennee@linaro.org,
 qemu-devel@nongnu.org, philmd@redhat.com, jsnow@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--PmA2V3Z32TCmWXqI
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 06, 2019 at 04:34:30PM -0500, Wainer dos Santos Moschetta wrote=
:
> This creates the 'accel' Python module to be the home for
> utilities that deal with accelerators. Also moved kvm_available()
> from __init__.py to this new module.
>=20
> Signed-off-by: Wainer dos Santos Moschetta <wainersm@redhat.com>
> Reviewed-by: Alex Benn=E9e <alex.bennee@linaro.org>
> Reviewed-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>
> ---
>  python/qemu/__init__.py | 20 +-------------------
>  python/qemu/accel.py    | 31 +++++++++++++++++++++++++++++++
>  tests/vm/basevm.py      |  2 +-
>  3 files changed, 33 insertions(+), 20 deletions(-)
>  create mode 100644 python/qemu/accel.py
>=20
> diff --git a/python/qemu/__init__.py b/python/qemu/__init__.py
> index 6c919a3d56..eff17a306e 100644
> --- a/python/qemu/__init__.py
> +++ b/python/qemu/__init__.py
> @@ -12,24 +12,6 @@
>  # Based on qmp.py.
>  #
> =20
> -import logging
> -import os
> -
>  from . import qmp
>  from . import machine

These lines don't achieve anything besides forcing an earlier
evaluation of those modules, which AFAICT is totally unnecessary.
If there was code in QEMU such as:

  import qemu

  def foo():
     ...
     raise qemu.qmp.QMPError

Then there would be a reason for such imports.  I couldn't find
any though.  Anyway, I now this is not from your patch but...

> -
> -LOG =3D logging.getLogger(__name__)
> -
> -# Mapping host architecture to any additional architectures it can
> -# support which often includes its 32 bit cousin.
> -ADDITIONAL_ARCHES =3D {
> -    "x86_64" : "i386",
> -    "aarch64" : "armhf"
> -}
> -
> -def kvm_available(target_arch=3DNone):
> -    host_arch =3D os.uname()[4]
> -    if target_arch and target_arch !=3D host_arch:
> -        if target_arch !=3D ADDITIONAL_ARCHES.get(host_arch):
> -            return False
> -    return os.access("/dev/kvm", os.R_OK | os.W_OK)
> +from . import accel

... according to that reasoning, this should be ommited.  IMO we could
use another patch in this series removing those imports.

> diff --git a/python/qemu/accel.py b/python/qemu/accel.py
> new file mode 100644
> index 0000000000..cbeac10dd1
> --- /dev/null
> +++ b/python/qemu/accel.py
> @@ -0,0 +1,31 @@
> +"""
> +QEMU accel module:
> +
> +This module provides utilities for discover and check the availability o=
f
> +accelerators.
> +"""
> +# Copyright (C) 2015-2016 Red Hat Inc.
> +# Copyright (C) 2012 IBM Corp.
> +#
> +# Authors:
> +#  Fam Zheng <famz@redhat.com>
> +#
> +# This work is licensed under the terms of the GNU GPL, version 2.  See
> +# the COPYING file in the top-level directory.
> +#
> +
> +import os
> +
> +# Mapping host architecture to any additional architectures it can
> +# support which often includes its 32 bit cousin.
> +ADDITIONAL_ARCHES =3D {
> +    "x86_64" : "i386",
> +    "aarch64" : "armhf"
> +}
> +
> +def kvm_available(target_arch=3DNone):
> +    host_arch =3D os.uname()[4]
> +    if target_arch and target_arch !=3D host_arch:
> +        if target_arch !=3D ADDITIONAL_ARCHES.get(host_arch):
> +            return False
> +    return os.access("/dev/kvm", os.R_OK | os.W_OK)
> diff --git a/tests/vm/basevm.py b/tests/vm/basevm.py
> index 91a9226026..3e2b69c96c 100755
> --- a/tests/vm/basevm.py
> +++ b/tests/vm/basevm.py
> @@ -21,7 +21,7 @@ import logging
>  import time
>  import datetime
>  sys.path.append(os.path.join(os.path.dirname(__file__), '..', '..', 'pyt=
hon'))
> -from qemu import kvm_available
> +from qemu.accel import kvm_available
>  from qemu.machine import QEMUMachine
>  import subprocess
>  import hashlib
> --=20
> 2.21.0
>=20

Other than that, this LGTM.

- Cleber.

--PmA2V3Z32TCmWXqI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEeruW64tGuU1eD+m7ZX6NM6XyCfMFAl3u6KcACgkQZX6NM6Xy
CfMMUA//WiYRFU3J+Y3mBisSWrpmM6PKVD4QMBuj8VnHEgyz4G7hKatRPoHzG67s
LI0EIjspe+TLFOYCOaG2rroXZGZ5HzsvOaL8dspIV2iT17d+l91CeCC9980EyMPw
3cm3BgtdN++5dj6aodv/be0eyZqCGvSGAC/n6Vk9K6a7hL4mH9PRNstTIKz8ADIV
98TSogs1UAC8zNEzIO1+ztayJPRi9nW1ZfvUD0RbP8pMloflipD8QUd5pnAzfUxB
WspL2wLPPTO/hzLgkgyR1QhJ7tTIFK3bXApXTuQa5qeGkfJkQSEOKDewMyWjVzDR
zNDzBJfFToFG+lvdiL5bVYCAl3RlG6JgXb7NeBujFO2pHyY1NGaCBPG6oztFsE8M
28KfhatSYhGsdGRDFFfwOQZveQm2vBV2FODCchYBsULN7TdEXxT+65WNWFr8at6T
6J3ppyh5DBL6AIW5TGiV8h47tMl30lFyGqGb3wYHHN8B/VUls/lKwgBe+ZkJQD2V
OQYNtG9YAEzrYpz9yRpMuLplGHYpaW8TiVExZqmF/iLF9mfqm+zy1AQuyYpN7I1m
CwKb9kQv/Y4t3tkXWNT8OIAMotiR47B9o9JMdYdF9ipLq/J7cJM5LghTpbz76vlT
ryrBpRi1Ox/AndNnZFeYQQDxSYUh0uF1WL4DpIKHdfuoOBf3LAw=
=63TZ
-----END PGP SIGNATURE-----

--PmA2V3Z32TCmWXqI--


