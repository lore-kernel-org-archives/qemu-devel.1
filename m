Return-Path: <SRS0=0TZc=4P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FB33C34022
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 15:30:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6D7762469F
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 15:30:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TJhHCSah"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D7762469F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33428 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7L7L-0006Wl-GM
	for qemu-devel@archiver.kernel.org; Thu, 27 Feb 2020 10:30:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57056)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j7L6Z-00064v-MK
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 10:29:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j7L6Y-0004Dh-FM
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 10:29:39 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:55946
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j7L6Y-0004Dc-Bu
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 10:29:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582817377;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QtWQmyotzybazqBAy4HE6auOBLXlml26bf2TeoWFi3E=;
 b=TJhHCSahUrn/bPbG2jxpzszC1APmsjf/FPRR/A3zBprKImc8DfqtBlkvBKqGZWF/qugxdq
 jRll4UNJpJtquBiaB55fIq6VL220rD181+IaW22AIFn6ICJOJRWSBzRmQfZI70xPIpIgN0
 tMXWZcA3lei9Nulobs4+k4gUDr/1zAs=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-110-0i54cIZOOBecnMUx5WwShA-1; Thu, 27 Feb 2020 10:29:34 -0500
X-MC-Unique: 0i54cIZOOBecnMUx5WwShA-1
Received: by mail-wr1-f69.google.com with SMTP id o9so1453102wrw.14
 for <qemu-devel@nongnu.org>; Thu, 27 Feb 2020 07:29:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=5DX9z3QiifUm9i+y3EP0EmAbcEdU2Lzh8CkDhu2LPAs=;
 b=QZwvQDuMnvG31zSGS23wWIRQRb0qAB9X6w3JHr1TW2aL95fZBYmiCSNmClGfwIEsZo
 NjQ1WYCh9dq/Qs2uA2kt/k/thcepK0vbshlcykIvAbdh+/OZpE4vzSk6UTg8BQLKrpcb
 1Pqz/P3POwxAtUfJHcCbAmCKqdu9p2a0inK53T/9PkqqLPQhhk8NhREVrXxAMNd59tZv
 1LmyyWnWk+dz3kQHgmvFcacbDCjPr0ZjWYl49dG+VGund0zYMa4lfv5WJMIPHHjeQ8bb
 JS7L48wtYse7K6aiYky1X55WpvY4KtyX/CUbCqKLr/xNuGysvIsvhjAb0q3uREIpjx1Z
 +mCQ==
X-Gm-Message-State: APjAAAVaLu1jPz0GiZ5g3mzr8p2ZL9ONWhtAdcdL9uq+XESlUcb6u2LL
 2khCYamNCcTmrAVKpCiQ1tkoxt2f7CpHByBmwSQJdIt0Hw09vy80dpkaMfUYMed5WgqYsczqGYP
 iCeEDR67BKdufg0Q=
X-Received: by 2002:a1c:df45:: with SMTP id w66mr20352wmg.171.1582817372805;
 Thu, 27 Feb 2020 07:29:32 -0800 (PST)
X-Google-Smtp-Source: APXvYqxbctmiEPUCnwksNuCJB1Cn56TYUPfrQP0Ncc07S3ESV7oBWc1dG2AKA89/mQhx334QCNOILw==
X-Received: by 2002:a1c:df45:: with SMTP id w66mr20277wmg.171.1582817371643;
 Thu, 27 Feb 2020 07:29:31 -0800 (PST)
Received: from [192.168.1.35] (47.red-88-21-205.staticip.rima-tde.net.
 [88.21.205.47])
 by smtp.gmail.com with ESMTPSA id a16sm8408266wrx.87.2020.02.27.07.29.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 27 Feb 2020 07:29:31 -0800 (PST)
Subject: Re: [PATCH 2/4] qapi: Drop conditionals for Python 2
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <20200227144531.24309-1-armbru@redhat.com>
 <20200227144531.24309-3-armbru@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <fb8fe3bf-da1f-2c6b-933c-c8a79bdee9fa@redhat.com>
Date: Thu, 27 Feb 2020 16:29:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200227144531.24309-3-armbru@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: crosa@redhat.com, jsnow@redhat.com, mdroth@linux.vnet.ibm.com,
 ehabkost@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/27/20 3:45 PM, Markus Armbruster wrote:
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>   scripts/qapi/common.py         | 6 +-----
>   scripts/qapi/gen.py            | 6 +-----
>   scripts/qapi/parser.py         | 6 +-----
>   tests/qapi-schema/test-qapi.py | 6 +-----
>   4 files changed, 4 insertions(+), 20 deletions(-)
>=20
> diff --git a/scripts/qapi/common.py b/scripts/qapi/common.py
> index e00dcafce7..ba35abea47 100644
> --- a/scripts/qapi/common.py
> +++ b/scripts/qapi/common.py
> @@ -12,7 +12,6 @@
>   # See the COPYING file in the top-level directory.
>  =20
>   import re
> -import string
>  =20
>  =20
>   # ENUMName -> ENUM_NAME, EnumName1 -> ENUM_NAME1
> @@ -43,10 +42,7 @@ def c_enum_const(type_name, const_name, prefix=3DNone)=
:
>       return camel_to_upper(type_name) + '_' + c_name(const_name, False).=
upper()
>  =20
>  =20
> -if hasattr(str, 'maketrans'):
> -    c_name_trans =3D str.maketrans('.-', '__')
> -else:
> -    c_name_trans =3D string.maketrans('.-', '__')
> +c_name_trans =3D str.maketrans('.-', '__')
>  =20
>  =20
>   # Map @name to a valid C identifier.
> diff --git a/scripts/qapi/gen.py b/scripts/qapi/gen.py
> index a53a705c73..317cd72601 100644
> --- a/scripts/qapi/gen.py
> +++ b/scripts/qapi/gen.py
> @@ -15,7 +15,6 @@
>   import errno
>   import os
>   import re
> -import sys
>   from contextlib import contextmanager
>  =20
>   from qapi.common import *
> @@ -54,10 +53,7 @@ class QAPIGen:
>                   if e.errno !=3D errno.EEXIST:
>                       raise
>           fd =3D os.open(pathname, os.O_RDWR | os.O_CREAT, 0o666)
> -        if sys.version_info[0] >=3D 3:
> -            f =3D open(fd, 'r+', encoding=3D'utf-8')
> -        else:
> -            f =3D os.fdopen(fd, 'r+')
> +        f =3D open(fd, 'r+', encoding=3D'utf-8')
>           text =3D self.get_content()
>           oldtext =3D f.read(len(text) + 1)
>           if text !=3D oldtext:
> diff --git a/scripts/qapi/parser.py b/scripts/qapi/parser.py
> index 2e3a3c5d76..cf14e5426c 100644
> --- a/scripts/qapi/parser.py
> +++ b/scripts/qapi/parser.py
> @@ -16,7 +16,6 @@
>  =20
>   import os
>   import re
> -import sys
>   from collections import OrderedDict
>  =20
>   from qapi.error import QAPIParseError, QAPISemError
> @@ -30,10 +29,7 @@ class QAPISchemaParser:
>           previously_included.add(os.path.abspath(fname))
>  =20
>           try:
> -            if sys.version_info[0] >=3D 3:
> -                fp =3D open(fname, 'r', encoding=3D'utf-8')
> -            else:
> -                fp =3D open(fname, 'r')
> +            fp =3D open(fname, 'r', encoding=3D'utf-8')
>               self.src =3D fp.read()
>           except IOError as e:
>               raise QAPISemError(incl_info or QAPISourceInfo(None, None, =
None),
> diff --git a/tests/qapi-schema/test-qapi.py b/tests/qapi-schema/test-qapi=
.py
> index 41232c11a3..bee18ee344 100755
> --- a/tests/qapi-schema/test-qapi.py
> +++ b/tests/qapi-schema/test-qapi.py
> @@ -16,15 +16,11 @@ import argparse
>   import difflib
>   import os
>   import sys
> +from io import StringIO
>  =20
>   from qapi.error import QAPIError
>   from qapi.schema import QAPISchema, QAPISchemaVisitor
>  =20
> -if sys.version_info[0] < 3:
> -    from cStringIO import StringIO
> -else:
> -    from io import StringIO
> -
>  =20
>   class QAPISchemaTestVisitor(QAPISchemaVisitor):
>  =20
>=20

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>


