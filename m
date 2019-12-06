Return-Path: <SRS0=8N/K=Z4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF3A5C43603
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2019 15:18:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A8CEC24659
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2019 15:18:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gmsvs0Sa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8CEC24659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39556 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1idFNK-00028n-5U
	for qemu-devel@archiver.kernel.org; Fri, 06 Dec 2019 10:18:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51182)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <crosa@redhat.com>) id 1idEa2-0005Ib-BH
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 09:27:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <crosa@redhat.com>) id 1idEZy-0004sQ-7u
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 09:27:36 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:42249
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <crosa@redhat.com>) id 1idEZv-0004iN-Hq
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 09:27:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575642450;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lh0h97lZ5xX7WyxSFZmFXjeZtoVH7A+wO7WDIrR2VeQ=;
 b=gmsvs0Sa5apdyT65LPbkSjPE5twlG53W7XR+Ip1wXAUKz+TNFZBY214SBstaWDKHFXKvPI
 WyE+AqCzv+yFrSlEduGDM/mZZ/rkmr8BUmcwd6s5Tq/1K5eGYE/x3x8bbYUPooMZbyTByl
 zAlpXFGJ4Pk9lLLqq54+1sFxH6SnKF0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-5-Kc8Q1B71OzKeDbRhp4bXSw-1; Fri, 06 Dec 2019 09:27:29 -0500
X-MC-Unique: Kc8Q1B71OzKeDbRhp4bXSw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4005B102CE17
 for <qemu-devel@nongnu.org>; Fri,  6 Dec 2019 14:27:28 +0000 (UTC)
Received: from dhcp-17-72.bos.redhat.com (dhcp-17-72.bos.redhat.com
 [10.18.17.72])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C61CB5D6BE;
 Fri,  6 Dec 2019 14:27:24 +0000 (UTC)
Date: Fri, 6 Dec 2019 09:27:23 -0500
From: Cleber Rosa <crosa@redhat.com>
To: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>
Subject: Re: [PATCH 2/2] analyze-migration.py: replace numpy with python 3.2
Message-ID: <20191206142723.GA5020@dhcp-17-72.bos.redhat.com>
References: <20191127101038.327080-1-marcandre.lureau@redhat.com>
 <20191127101038.327080-3-marcandre.lureau@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20191127101038.327080-3-marcandre.lureau@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="jI8keyz6grp/JLjh"
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--jI8keyz6grp/JLjh
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 27, 2019 at 02:10:38PM +0400, Marc-Andr=E9 Lureau wrote:
> Use int.from_bytes() from python 3.2 instead.
>=20
> Signed-off-by: Marc-Andr=E9 Lureau <marcandre.lureau@redhat.com>
> ---
>  scripts/analyze-migration.py | 35 +++++++++++++++++++----------------
>  1 file changed, 19 insertions(+), 16 deletions(-)
>=20
> diff --git a/scripts/analyze-migration.py b/scripts/analyze-migration.py
> index 2b835d9b70..96a31d3974 100755
> --- a/scripts/analyze-migration.py
> +++ b/scripts/analyze-migration.py
> @@ -1,4 +1,4 @@
> -#!/usr/bin/env python
> +#!/usr/bin/env python3
>  #
>  #  Migration Stream Analyzer
>  #
> @@ -17,12 +17,18 @@
>  # You should have received a copy of the GNU Lesser General Public
>  # License along with this library; if not, see <http://www.gnu.org/licen=
ses/>.
> =20
> -from __future__ import print_function
> -import numpy as np
>  import json
>  import os
>  import argparse
>  import collections
> +import struct
> +import sys
> +
> +
> +MIN_PYTHON =3D (3, 2)
> +if sys.version_info < MIN_PYTHON:
> +    sys.exit("Python %s.%s or later is required.\n" % MIN_PYTHON)
> +
>
>  def mkdir_p(path):
>      try:
> @@ -30,29 +36,26 @@ def mkdir_p(path):
>      except OSError:
>          pass
> =20
> +
>  class MigrationFile(object):
>      def __init__(self, filename):
>          self.filename =3D filename
>          self.file =3D open(self.filename, "rb")
> =20
>      def read64(self):
> -        return np.asscalar(np.fromfile(self.file, count=3D1, dtype=3D'>i=
8')[0])
> +        return int.from_bytes(self.file.read(8), byteorder=3D'big', sign=
ed=3DTrue)
>
>      def read32(self):
> -        return np.asscalar(np.fromfile(self.file, count=3D1, dtype=3D'>i=
4')[0])
> +        return int.from_bytes(self.file.read(4), byteorder=3D'big', sign=
ed=3DTrue)
> =20
>      def read16(self):
> -        return np.asscalar(np.fromfile(self.file, count=3D1, dtype=3D'>i=
2')[0])
> +        return int.from_bytes(self.file.read(2), byteorder=3D'big', sign=
ed=3DTrue)
> =20
>      def read8(self):
> -        return np.asscalar(np.fromfile(self.file, count=3D1, dtype=3D'>i=
1')[0])
> +        return int.from_bytes(self.file.read(1), byteorder=3D'big', sign=
ed=3DTrue)
>
>      def readstr(self, len =3D None):
> -        if len is None:
> -            len =3D self.read8()
> -        if len =3D=3D 0:
> -            return ""
> -        return np.fromfile(self.file, count=3D1, dtype=3D('S%d' % len))[=
0]
> +        return self.readvar(len).decode('utf-8')
> =20
>      def readvar(self, size =3D None):
>          if size is None:
> @@ -275,7 +278,7 @@ class VMSDFieldGeneric(object):
>          return str(self.__str__())
> =20
>      def __str__(self):
> -        return " ".join("{0:02x}".format(ord(c)) for c in self.data)
> +        return " ".join("{0:02x}".format(c) for c in self.data)
> =20
>      def getDict(self):
>          return self.__str__()
> @@ -307,8 +310,8 @@ class VMSDFieldInt(VMSDFieldGeneric):
> =20
>      def read(self):
>          super(VMSDFieldInt, self).read()
> -        self.sdata =3D np.fromstring(self.data, count=3D1, dtype=3D(self=
.sdtype))[0]
> -        self.udata =3D np.fromstring(self.data, count=3D1, dtype=3D(self=
.udtype))[0]
> +        self.sdata =3D int.from_bytes(self.data, byteorder=3D'big', sign=
ed=3DTrue)
> +        self.udata =3D int.from_bytes(self.data, byteorder=3D'big', sign=
ed=3DFalse)
>          self.data =3D self.sdata
>          return self.data
> =20
> @@ -363,7 +366,7 @@ class VMSDFieldStruct(VMSDFieldGeneric):
>              array_len =3D field.pop('array_len')
>              field['index'] =3D 0
>              new_fields.append(field)
> -            for i in xrange(1, array_len):
> +            for i in range(1, array_len):
>                  c =3D field.copy()
>                  c['index'] =3D i
>                  new_fields.append(c)
> --=20
> 2.24.0
>=20

Marc-Andr=E9, I couldn't yet pinpoint the reason yet, but this patch
changes the parsing of bool fields.  This is a diff between the output
pre/post this patch on the same images:

$ diff -u out_x8664_pre out_x8664_post=20
--- out_x8664_pre       2019-12-06 09:14:16.128943264 -0500
+++ out_x8664_post      2019-12-06 09:23:35.861378600 -0500
@@ -3039,7 +3039,7 @@
             "mac_reg[RADV]": "0x00000000",
             "mac_reg[TADV]": "0x00000000",
             "mac_reg[ITR]": "0x00000000",
-            "mit_irq_level": true
+            "mit_irq_level": false
         },
         "e1000/full_mac_state": {
             "mac_reg": [
@@ -36010,10 +36010,10 @@
             ],
             "smb_auxctl": "0x02",
             "smb_blkdata": "0x00",
-            "i2c_enable": true,
+            "i2c_enable": false,
             "op_done": true,
-            "in_i2c_block_read": true,
-            "start_transaction_on_status_read": true
+            "in_i2c_block_read": false,
+            "start_transaction_on_status_read": false
         },
         "ar.tmr.timer": "ff ff ff ff ff ff ff ff",
         "ar.tmr.overflow_time": "0x0000000000000000",

This true/false flipping is consistent across various images (tried on
images generated on a few other targets).

- Cleber.

--jI8keyz6grp/JLjh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEeruW64tGuU1eD+m7ZX6NM6XyCfMFAl3qZUgACgkQZX6NM6Xy
CfOyRg/8CoRL1YLKO6AnBPKrcuMLR+neZR1MQLsd6GzMOQ8Oz37Y6X9hyvoRr5Cu
9HY/H3s/qx8FeMYumd3SVJfRTmLOP9NidLendtXQrUNxrMSNJ7dV4V0UY+68y8i9
OrxPuEF1EZTJr9R5a4DqDRhL8T8QuKGiZSaiKj8jkVWLIwAa2AHtvie4JXRHAqTa
gdOAQWA2Riw+UzvEffWHkOBURnx81di/3kqxP9FtpnEcNdbKGnjhZqLpwmz6qVud
l/iHpCOqDgPuvoZbR0bMarjGluE8JXO2swCcS2kl6xzIhIHdelBZoGNXqmfjdee8
zkyYJPxzmHXSw/OY00RzVpCWhV8MzKJEdwjchrIii4xDcQIrWc8N5ea7O/UYgGDc
QM5VNTeGWZYPrHHFamq1yDhqod8YbiJPFHFqHBhoRD9g1VwvwaJlSI/jUHrbsQyo
yiRHxvGaX46IdFkT/P0HGRACkLVGUs5I/gBQCJkF/9pIr2p6NepofXJ0gDgilqqx
Gxh8YPPdZHYozIJdBdi5NcIqdbRcgHExacor+u2gbnWfzK1TO0Q8ZblfIw9Ca5nn
cURtu/M+gVYofHA7FICbzZbRp91LME594hAnV/lASRdwalWB9QGPQPZbDUClHIvL
YJvOe5LG3yZGeeVKmLeSwWKKTfwZlzHREdP/KE7pK3bN/KteES8=
=Gs55
-----END PGP SIGNATURE-----

--jI8keyz6grp/JLjh--


