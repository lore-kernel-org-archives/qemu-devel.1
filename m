Return-Path: <SRS0=+pSw=DC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C45BC4346E
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 01:23:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF1EC207C4
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 01:22:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UHcjNrR0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF1EC207C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44688 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLcRv-00066q-11
	for qemu-devel@archiver.kernel.org; Thu, 24 Sep 2020 21:22:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59310)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1kLcO3-0002Mi-AV
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 21:18:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:40957)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1kLcO1-0005yP-03
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 21:18:59 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600996736;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+eAWhkOg4S/5Q/qGzifapGu8jn4cDB+cmFxNWH7+A8I=;
 b=UHcjNrR04XXgyFH6yVGbuFMPfe2hyso2DQd3z/HzdZXoIqq9lKnIoa7pR7CJ8BsM0iYKBA
 7y16i5mntZj3MxAne5nCb2LpXQwxwCUwwtqRaN8ca3u8KG2O1XBXeNUCRH6cDrWIjjjK7e
 uvHD+aGrCfNOWmJl8MH+FaEKdP3LfBs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-141-Tx--KXQoOSunQEwT2fNVbQ-1; Thu, 24 Sep 2020 21:18:53 -0400
X-MC-Unique: Tx--KXQoOSunQEwT2fNVbQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8D0681882FC6;
 Fri, 25 Sep 2020 01:18:52 +0000 (UTC)
Received: from localhost.localdomain (ovpn-119-55.rdu2.redhat.com
 [10.10.119.55])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D017875120;
 Fri, 25 Sep 2020 01:18:51 +0000 (UTC)
Date: Thu, 24 Sep 2020 21:18:49 -0400
From: Cleber Rosa <crosa@redhat.com>
To: John Snow <jsnow@redhat.com>
Subject: Re: [PATCH 16/16] qapi/expr.py: Use an expression checker dispatch
 table
Message-ID: <20200925011849.GI368253@localhost.localdomain>
References: <20200922211313.4082880-1-jsnow@redhat.com>
 <20200922211313.4082880-17-jsnow@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200922211313.4082880-17-jsnow@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=crosa@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="9s922KAXlWjPfK/Q"
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=crosa@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/22 23:02:20
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.199,
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
Cc: Michael Roth <mdroth@linux.vnet.ibm.com>,
 Markus Armbruster <armbru@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--9s922KAXlWjPfK/Q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 22, 2020 at 05:13:13PM -0400, John Snow wrote:
> This enforces a type signature against all of the top-level expression
> check routines without necessarily needing to create some
> overcomplicated class hierarchy for them.
>=20
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  scripts/qapi/expr.py | 69 ++++++++++++++++++++++----------------------
>  1 file changed, 35 insertions(+), 34 deletions(-)
>=20
> diff --git a/scripts/qapi/expr.py b/scripts/qapi/expr.py
> index 74b2681ef8..cfd342aa04 100644
> --- a/scripts/qapi/expr.py
> +++ b/scripts/qapi/expr.py
> @@ -31,8 +31,11 @@
>  structures and contextual semantic validation.
>  """
> =20
> +from enum import Enum
>  import re
>  from typing import (
> +    Callable,
> +    Dict,
>      Iterable,
>      List,
>      MutableMapping,
> @@ -494,6 +497,26 @@ def check_event(expr: Expression, info: QAPISourceIn=
fo) -> None:
>      check_type(args, info, "'data'", allow_dict=3Dnot boxed)
> =20
> =20
> +class ExpressionType(str, Enum):
> +    INCLUDE =3D 'include'
> +    ENUM =3D 'enum'
> +    UNION =3D 'union'
> +    ALTERNATE =3D 'alternate'
> +    STRUCT =3D 'struct'
> +    COMMAND =3D 'command'
> +    EVENT =3D 'event'
> +
> +
> +_CHECK_FN: Dict[str, Callable[[Expression, QAPISourceInfo], None]] =3D {
> +    'enum': check_enum,
> +    'union': check_union,
> +    'alternate': check_alternate,
> +    'struct': check_struct,
> +    'command': check_command,
> +    'event': check_event,
> +}
> +
> +
>  def check_exprs(exprs: List[_JSObject]) -> List[_JSObject]:
>      """
>      Validate and normalize a list of parsed QAPI schema expressions. [RW=
]
> @@ -519,28 +542,20 @@ def check_exprs(exprs: List[_JSObject]) -> List[_JS=
Object]:
>          assert tmp is None or isinstance(tmp, QAPIDoc)
>          doc: Optional[QAPIDoc] =3D tmp
> =20
> -        if 'include' in expr:
> -            continue
> -
> -        if 'enum' in expr:
> -            meta =3D 'enum'
> -        elif 'union' in expr:
> -            meta =3D 'union'
> -        elif 'alternate' in expr:
> -            meta =3D 'alternate'
> -        elif 'struct' in expr:
> -            meta =3D 'struct'
> -        elif 'command' in expr:
> -            meta =3D 'command'
> -        elif 'event' in expr:
> -            meta =3D 'event'
> +        for kind in ExpressionType:
> +            if kind in expr:
> +                meta =3D kind
> +                break
>          else:
>              raise QAPISemError(info, "expression is missing metatype")
> =20
> +        if meta =3D=3D ExpressionType.INCLUDE:
> +            continue
> +
>          name =3D cast(str, expr[meta])  # asserted right below:
> -        check_name_is_str(name, info, "'%s'" % meta)
> -        info.set_defn(meta, name)
> -        check_defn_name_str(name, info, meta)
> +        check_name_is_str(name, info, "'%s'" % meta.value)
> +        info.set_defn(meta.value, name)
> +        check_defn_name_str(name, info, meta.value)
> =20
>          if doc:
>              if doc.symbol !=3D name:
> @@ -551,22 +566,8 @@ def check_exprs(exprs: List[_JSObject]) -> List[_JSO=
bject]:
>              raise QAPISemError(info,
>                                 "documentation comment required")
> =20
> -        if meta =3D=3D 'enum':
> -            check_enum(expr, info)
> -        elif meta =3D=3D 'union':
> -            check_union(expr, info)
> -        elif meta =3D=3D 'alternate':
> -            check_alternate(expr, info)
> -        elif meta =3D=3D 'struct':
> -            check_struct(expr, info)
> -        elif meta =3D=3D 'command':
> -            check_command(expr, info)
> -        elif meta =3D=3D 'event':
> -            check_event(expr, info)
> -        else:
> -            assert False, 'unexpected meta type'
> -
> -        check_if(expr, info, meta)
> +        _CHECK_FN[meta](expr, info)

I have to say the style of this line bothers me, but it's just that,
style. So,

Reviewed-by: Cleber Rosa <crosa@redhat.com>

--9s922KAXlWjPfK/Q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEeruW64tGuU1eD+m7ZX6NM6XyCfMFAl9tRXcACgkQZX6NM6Xy
CfOSNw/+KJcGjzhiRwcsOA9kosqVTuNEhc5/8Ygd0kcdOKVGS2V2UhJ237NxZ+FD
JJBPpIGbFdMJfarumIXamnkMKTOPFBKWpsjH/G2Fyr4Y7TG8H8CAwem+38gmTOwi
bFYwHfJeCtmXEVPkMlp0w1VNajxvZOqpxDejqhMQRxb/O2IfGgZGlGI9Z934dY+X
cbbrjIZwgkh48MFSRED9KziLtIk8mzWK+ep9N/zC3G5174wjqQ9+vIGbDwpZ1Wwf
alnP9PUecv95EXKrPmqqGOWAJCaZmJEmUX9GgZpgBlwai/IXJlpOWxQzWc3UQ9Ba
D/NZJetGuppdT188LEaY63jYA33zQ3C4JaCB8FTwPC6zyl53X2r8hke1H78UhpQE
Nq7zkmH+jzQ/KYHUlVeXLfUUlfVEFT5IGO5TwydFgZHmlABR0tdww2Q9lqa4mSBx
ViYWm48qE1G/F/3oqTqJwfDysod0yOP0eZ/YCZtqwY5JCz1lvaebKfLL2+DcUFZa
EP30jVyTd19w5VMgXqLh8zBFpeaXvq1do6niuOxKOMgYfiOmFDx9T6z+evHuRu+B
euvGreijJdeSQ02MBaVvCOq87qIiGOgd3NGizBjcji07J+tiDdIXAHzhu96XEVY1
Y6941HXC3kITW0gMM5RjzIzQqiq85BUqVf+CX2XTknyih5RrIFY=
=NPlK
-----END PGP SIGNATURE-----

--9s922KAXlWjPfK/Q--


