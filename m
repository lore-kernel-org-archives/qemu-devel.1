Return-Path: <SRS0=UzyQ=DA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A3D4C4727D
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 00:01:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 306E92071A
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 00:01:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZyFdvfvN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 306E92071A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41992 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKsDy-0001mc-QB
	for qemu-devel@archiver.kernel.org; Tue, 22 Sep 2020 20:01:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46286)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1kKsDC-0001Jf-Me
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 20:00:42 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:58665
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1kKsDA-0000wb-6T
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 20:00:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600819238;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=s8DP9bAhrbZSD5FZTdfireN6xOyEJJqqcdNgbGOIrB8=;
 b=ZyFdvfvNaswr0WhQ1QH5akNr6nNhnOP1mGzlB5gtTSI/ikJ7cKAgtKu1LfU2PIrgczwXED
 ygp9LeGYIZFSW7shK/+wMBu8w5OvF7Wylzk4v1pG09pQlaMjffMvIRymuRRXOBwcdgp3D/
 QvoiBJehtnLtNfjQvAODHYyn/Qb74Xg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-189-v9CLwC_zOEiAkxlFlUIHmQ-1; Tue, 22 Sep 2020 20:00:35 -0400
X-MC-Unique: v9CLwC_zOEiAkxlFlUIHmQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 00D511005E64;
 Wed, 23 Sep 2020 00:00:34 +0000 (UTC)
Received: from localhost.localdomain (ovpn-119-55.rdu2.redhat.com
 [10.10.119.55])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id EB20410013DB;
 Wed, 23 Sep 2020 00:00:32 +0000 (UTC)
Date: Tue, 22 Sep 2020 20:00:31 -0400
From: Cleber Rosa <crosa@redhat.com>
To: John Snow <jsnow@redhat.com>
Subject: Re: [PATCH v2 02/38] qapi-gen: Separate arg-parsing from generation
Message-ID: <20200923000031.GB191229@localhost.localdomain>
References: <20200922210101.4081073-1-jsnow@redhat.com>
 <20200922210101.4081073-3-jsnow@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200922210101.4081073-3-jsnow@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=crosa@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="JP+T4n/bALQSJXh8"
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=crosa@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/22 17:01:22
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.455,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org,
 Michael Roth <mdroth@linux.vnet.ibm.com>,
 Markus Armbruster <armbru@redhat.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--JP+T4n/bALQSJXh8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 22, 2020 at 05:00:25PM -0400, John Snow wrote:
> This is a minor re-work of the entrypoint script. It isolates a
> generate() method from the actual command-line mechanism.
>=20
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  scripts/qapi-gen.py | 87 ++++++++++++++++++++++++++++++++-------------
>  1 file changed, 63 insertions(+), 24 deletions(-)
>=20
> diff --git a/scripts/qapi-gen.py b/scripts/qapi-gen.py
> index 4b03f7d53b..59becba3e1 100644
> --- a/scripts/qapi-gen.py
> +++ b/scripts/qapi-gen.py
> @@ -1,9 +1,13 @@
>  #!/usr/bin/env python3
> -# QAPI generator
> -#
> +
>  # This work is licensed under the terms of the GNU GPL, version 2 or lat=
er.
>  # See the COPYING file in the top-level directory.
> =20
> +"""
> +QAPI Generator
> +
> +This script is the main entry point for generating C code from the QAPI =
schema.
> +"""
> =20
>  import argparse
>  import re
> @@ -11,21 +15,65 @@
> =20
>  from qapi.commands import gen_commands
>  from qapi.doc import gen_doc
> +from qapi.error import QAPIError
>  from qapi.events import gen_events
>  from qapi.introspect import gen_introspect
> -from qapi.schema import QAPIError, QAPISchema
> +from qapi.schema import QAPISchema
>  from qapi.types import gen_types
>  from qapi.visit import gen_visit
> =20
> =20
> -def main(argv):
> +DEFAULT_OUTPUT_DIR =3D ''
> +DEFAULT_PREFIX =3D ''

I did not understand the purpose of these.  If they're used only as
the default value for the command line option parsing, I'd suggest
dropping them.

> +
> +
> +def generate(schema_file: str,
> +             output_dir: str,
> +             prefix: str,
> +             unmask: bool =3D False,
> +             builtins: bool =3D False) -> None:
> +    """
> +    generate uses a given schema to produce C code in the target directo=
ry.
> +
> +    :param schema_file: The primary QAPI schema file.
> +    :param output_dir: The output directory to store generated code.
> +    :param prefix: Optional C-code prefix for symbol names.
> +    :param unmask: Expose non-ABI names through introspection?
> +    :param builtins: Generate code for built-in types?
> +
> +    :raise QAPIError: On failures.
> +    """
> +    match =3D re.match(r'([A-Za-z_.-][A-Za-z0-9_.-]*)?', prefix)
> +    if match and match.end() !=3D len(prefix):

Nice catch with the extra check here.  Maybe worth mentioning and/or
splitting the change?

> +        msg =3D "funny character '{:s}' in prefix '{:s}'".format(
> +            prefix[match.end()], prefix)
> +        raise QAPIError('', None, msg)
> +
> +    schema =3D QAPISchema(schema_file)
> +    gen_types(schema, output_dir, prefix, builtins)
> +    gen_visit(schema, output_dir, prefix, builtins)
> +    gen_commands(schema, output_dir, prefix)
> +    gen_events(schema, output_dir, prefix)
> +    gen_introspect(schema, output_dir, prefix, unmask)
> +    gen_doc(schema, output_dir, prefix)
> +
> +
> +def main() -> int:

One extra Pythonic touch would be to use a bool here, and then:

  sys.exit(0 if main() else 1)

But that's probably overkill.

> +    """
> +    gapi-gen shell script entrypoint.
> +    Expects arguments via sys.argv, see --help for details.
> +
> +    :return: int, 0 on success, 1 on failure.
> +    """
>      parser =3D argparse.ArgumentParser(
>          description=3D'Generate code from a QAPI schema')
>      parser.add_argument('-b', '--builtins', action=3D'store_true',
>                          help=3D"generate code for built-in types")
> -    parser.add_argument('-o', '--output-dir', action=3D'store', default=
=3D'',
> +    parser.add_argument('-o', '--output-dir', action=3D'store',
> +                        default=3DDEFAULT_OUTPUT_DIR,
>                          help=3D"write output to directory OUTPUT_DIR")
> -    parser.add_argument('-p', '--prefix', action=3D'store', default=3D''=
,
> +    parser.add_argument('-p', '--prefix', action=3D'store',
> +                        default=3DDEFAULT_PREFIX,
>                          help=3D"prefix for symbols")
>      parser.add_argument('-u', '--unmask-non-abi-names', action=3D'store_=
true',
>                          dest=3D'unmask',
> @@ -33,26 +81,17 @@ def main(argv):
>      parser.add_argument('schema', action=3D'store')
>      args =3D parser.parse_args()
> =20
> -    match =3D re.match(r'([A-Za-z_.-][A-Za-z0-9_.-]*)?', args.prefix)
> -    if match.end() !=3D len(args.prefix):
> -        print("%s: 'funny character '%s' in argument of --prefix"
> -              % (sys.argv[0], args.prefix[match.end()]),
> -              file=3Dsys.stderr)
> -        sys.exit(1)
> -
>      try:
> -        schema =3D QAPISchema(args.schema)
> +        generate(args.schema,
> +                 output_dir=3Dargs.output_dir,
> +                 prefix=3Dargs.prefix,
> +                 unmask=3Dargs.unmask,
> +                 builtins=3Dargs.builtins)
>      except QAPIError as err:
> -        print(err, file=3Dsys.stderr)
> -        exit(1)
> -

Glad to see that this "quitter" is gone in favor of one and only
sys.exit().

- Cleber.

> -    gen_types(schema, args.output_dir, args.prefix, args.builtins)
> -    gen_visit(schema, args.output_dir, args.prefix, args.builtins)
> -    gen_commands(schema, args.output_dir, args.prefix)
> -    gen_events(schema, args.output_dir, args.prefix)
> -    gen_introspect(schema, args.output_dir, args.prefix, args.unmask)
> -    gen_doc(schema, args.output_dir, args.prefix)
> +        print(f"{sys.argv[0]}: {str(err)}", file=3Dsys.stderr)
> +        return 1
> +    return 0
> =20
> =20
>  if __name__ =3D=3D '__main__':
> -    main(sys.argv)
> +    sys.exit(main())
> --=20
> 2.26.2
>=20

--JP+T4n/bALQSJXh8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEeruW64tGuU1eD+m7ZX6NM6XyCfMFAl9qkBwACgkQZX6NM6Xy
CfM4ohAAi2SpWizfvgJjovn02r2ngUuH2yJro2BIWhgbtPr9Td/FOZX0orDisc21
OtjUG+1MdWhRTSsDywZfOdvIWtxiWWnXHvjdcyvErBAILxGzsL+y7aY9Xiz/TXNo
3LpaXYfZmpfuFlWhKMKJobKdxImdhbLzpeu5Sahi4UjTn+mW030unBhDKvTJKk3u
9A/Wc2NPhbZMzkjSov+JnAca4zYgvGlC0+3eyHC1QFMbjNKSXYa6Pr9yGiWsj1zd
6mIBdJnwtJcGsqqYY1o1M6ayllh7/STQlbS4mWq23O9T3RGrJ3OzusLvJ/fLlb9Q
vTQbFS8B+2QG23SFg84BWeaNuyAiZuudXbZCc6pBBwcPCTdtp1JeQTxmkGSpoaHx
y0pzdC8p5u3rRq55VQHPKvD/C/uJCkuamRkqLA4SqwSzrI1EQUAtFUz8BlXGp4w3
sAmNuZHhmi/ABkArFNTo33BW0iHeVjfIfyrqlJiOnVC14jRwbOZxmafhKf3BJyfw
ZaP01kRzfEK+rjBJ4hvZ/fYVhrqSreP1FvyLaz5w3Ws0XPKrk/oYcd+VFc2uVCGF
VFGKeHBiecX4kAMga1N5HowntrMWX8Kh2X7IDDOlC2KZYMCfAKaM3KUxLxbdnGKo
cz8Vw3uNGoQXMicv/Hz7aiae+Phqn6H9cSdQkqa2gM6ZPrNkZ4I=
=JydZ
-----END PGP SIGNATURE-----

--JP+T4n/bALQSJXh8--


