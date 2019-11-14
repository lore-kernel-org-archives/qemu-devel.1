Return-Path: <SRS0=NHD5=ZG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C67DFC432C3
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2019 09:17:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 94BE5206C0
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2019 09:17:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cAuuBD2A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94BE5206C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54640 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iVBFV-0006vg-K2
	for qemu-devel@archiver.kernel.org; Thu, 14 Nov 2019 04:17:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58652)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1iVBEY-0006OH-A8
 for qemu-devel@nongnu.org; Thu, 14 Nov 2019 04:16:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1iVBES-0006qI-I6
 for qemu-devel@nongnu.org; Thu, 14 Nov 2019 04:16:10 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:45963
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1iVBES-0006q1-Dr
 for qemu-devel@nongnu.org; Thu, 14 Nov 2019 04:16:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573722963;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xAJbj8VqOT8Z0MJ0eqHMqWI3V+z3oVEWj0LyHM6uBu4=;
 b=cAuuBD2AX/3WUh9oL4wpagPJJwjBdZxdbSwmDGd7H8NTjc2cSysAI4BqNjCDvZshJ20+wl
 ZIjDtmdi2BeSZvvXPOWEOjqaiQhAJ8X7xBIgjDek2a5QtiJQLTefHeQppSgOOaoAPfDKCX
 3MJvSoh9t0zYz4AcZcvupzTjm3z5w9M=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-212-iAphpDCzNJqMrPA3xFO2TA-1; Thu, 14 Nov 2019 04:16:01 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3E1569125E;
 Thu, 14 Nov 2019 09:16:00 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.36.118.123])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D83615C1C3;
 Thu, 14 Nov 2019 09:15:59 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 637E41138648; Thu, 14 Nov 2019 10:15:58 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Max Reitz <mreitz@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v4 01/14] qapi: Parse numeric values
References: <20190624173935.25747-1-mreitz@redhat.com>
 <20190624173935.25747-2-mreitz@redhat.com>
Date: Thu, 14 Nov 2019 10:15:58 +0100
In-Reply-To: <20190624173935.25747-2-mreitz@redhat.com> (Max Reitz's message
 of "Mon, 24 Jun 2019 19:39:21 +0200")
Message-ID: <87mucyq0mp.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: iAphpDCzNJqMrPA3xFO2TA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org,
 Michael Roth <mdroth@linux.vnet.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Max Reitz <mreitz@redhat.com> writes:

> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>  tests/qapi-schema/bad-type-int.json      |  1 -
>  tests/qapi-schema/enum-int-member.json   |  1 -
>  scripts/qapi/common.py                   | 25 ++++++++++++++++++++----
>  scripts/qapi/introspect.py               |  2 ++
>  tests/qapi-schema/bad-type-int.err       |  2 +-
>  tests/qapi-schema/enum-int-member.err    |  2 +-
>  tests/qapi-schema/leading-comma-list.err |  2 +-
>  7 files changed, 26 insertions(+), 9 deletions(-)
>
> diff --git a/tests/qapi-schema/bad-type-int.json b/tests/qapi-schema/bad-=
type-int.json
> index 56fc6f8126..81355eb196 100644
> --- a/tests/qapi-schema/bad-type-int.json
> +++ b/tests/qapi-schema/bad-type-int.json
> @@ -1,3 +1,2 @@
>  # we reject an expression with a metatype that is not a string
> -# FIXME: once the parser understands integer inputs, improve the error m=
essage
>  { 'struct': 1, 'data': { } }
> diff --git a/tests/qapi-schema/enum-int-member.json b/tests/qapi-schema/e=
num-int-member.json
> index 6c9c32e149..6958440c6d 100644
> --- a/tests/qapi-schema/enum-int-member.json
> +++ b/tests/qapi-schema/enum-int-member.json
> @@ -1,3 +1,2 @@
>  # we reject any enum member that is not a string
> -# FIXME: once the parser understands integer inputs, improve the error m=
essage
>  { 'enum': 'MyEnum', 'data': [ 1 ] }
> diff --git a/scripts/qapi/common.py b/scripts/qapi/common.py
> index d61bfdc526..3396ea4a09 100644
> --- a/scripts/qapi/common.py
> +++ b/scripts/qapi/common.py
> @@ -498,6 +498,8 @@ class QAPISchemaParser(object):
>              raise QAPISemError(info, "Unknown pragma '%s'" % name)
> =20
>      def accept(self, skip_comment=3DTrue):
> +        num_match =3D re.compile(r'([-+]?inf|nan|[-+0-9.][0-9a-f.ex]*)')
> +
>          while True:
>              self.tok =3D self.src[self.cursor]
>              self.pos =3D self.cursor

This is yet another extension over plain JSON.  RFC 8259:

      number =3D [ minus ] int [ frac ] [ exp ]
      decimal-point =3D %x2E       ; .
      digit1-9 =3D %x31-39         ; 1-9
      e =3D %x65 / %x45            ; e E
      exp =3D e [ minus / plus ] 1*DIGIT
      frac =3D decimal-point 1*DIGIT
      int =3D zero / ( digit1-9 *DIGIT )
      minus =3D %x2D               ; -
      plus =3D %x2B                ; +
      zero =3D %x30                ; 0

Extensions are acceptable when we have an actual use for it, and we
document them properly.

Isn't the parenthesis in your regular expression redundant?

What use do you have in mind for 'inf' and 'nan'?

Why accept leading '+' as in '+123'?

Why accept empty integral part as in '.123'?

Why accept '.xe.'?  Kidding you, that must be a bug in your regexp.
Please decide what number syntax you'd like to accept, then specify it
in docs/devel/qapi-code-gen.txt, so we can first discuss the
specification, and then check the regexp implements it.

docs/devel/qapi-code-gen.txt update goes here:

    =3D=3D=3D Schema syntax =3D=3D=3D

    Syntax is loosely based on JSON (http://www.ietf.org/rfc/rfc8259.txt).
    Differences:

    * Comments: start with a hash character (#) that is not part of a
      string, and extend to the end of the line.

    * Strings are enclosed in 'single quotes', not "double quotes".

    * Strings are restricted to printable ASCII, and escape sequences to
      just '\\'.

--> * Numbers and null are not supported.

Hrmm, commit 9d55380b5a "qapi: Remove null from schema language" left
two instances in error messages behind.  I'll fix them.

> @@ -584,7 +586,22 @@ class QAPISchemaParser(object):
>                      return
>                  self.line +=3D 1
>                  self.line_pos =3D self.cursor
> -            elif not self.tok.isspace():
> +            elif self.tok.isspace():
> +                pass
> +            elif num_match.match(self.src[self.pos:]):
> +                match =3D num_match.match(self.src[self.pos:]).group(0)

Sadly, the walrus operator is Python 3.8.

> +                try:
> +                    self.val =3D int(match, 0)
> +                except ValueError:
> +                    try:
> +                        self.val =3D float(match)
> +                    except ValueError:
> +                        raise QAPIParseError(self,
> +                                '"%s" is not a valid integer or float' %=
 match)
> +
> +                self.cursor +=3D len(match) - 1
> +                return
> +            else:
>                  raise QAPIParseError(self, 'Stray "%s"' % self.tok)

Any particular reason for putting the number case last?

> =20
>      def get_members(self):
> @@ -617,9 +634,9 @@ class QAPISchemaParser(object):
>          if self.tok =3D=3D ']':
>              self.accept()
>              return expr
> -        if self.tok not in "{['tfn":
> +        if self.tok not in "{['tfn-+0123456789.i":

This is getting a bit ugly.  Let's not worry about it now.

>              raise QAPIParseError(self, 'Expected "{", "[", "]", string, =
'
> -                                 'boolean or "null"')
> +                                 'boolean, number or "null"')
>          while True:
>              expr.append(self.get_expr(True))
>              if self.tok =3D=3D ']':
> @@ -638,7 +655,7 @@ class QAPISchemaParser(object):
>          elif self.tok =3D=3D '[':
>              self.accept()
>              expr =3D self.get_values()
> -        elif self.tok in "'tfn":
> +        elif self.tok in "'tfn-+0123456789.i":
>              expr =3D self.val
>              self.accept()
>          else:
> diff --git a/scripts/qapi/introspect.py b/scripts/qapi/introspect.py
> index f62cf0a2e1..6a61dd831f 100644
> --- a/scripts/qapi/introspect.py
> +++ b/scripts/qapi/introspect.py
> @@ -57,6 +57,8 @@ def to_qlit(obj, level=3D0, suppress_first_indent=3DFal=
se):
>          ret +=3D indent(level) + '}))'
>      elif isinstance(obj, bool):
>          ret +=3D 'QLIT_QBOOL(%s)' % ('true' if obj else 'false')
> +    elif isinstance(obj, int) and obj >=3D -(2 ** 63) and obj < 2 ** 63:
> +        ret +=3D 'QLIT_QNUM(%i)' % obj

Please explain the range check.

>      else:
>          assert False                # not implemented
>      if level > 0:
> diff --git a/tests/qapi-schema/bad-type-int.err b/tests/qapi-schema/bad-t=
ype-int.err
> index da89895404..e22fb4f655 100644
> --- a/tests/qapi-schema/bad-type-int.err
> +++ b/tests/qapi-schema/bad-type-int.err
> @@ -1 +1 @@
> -tests/qapi-schema/bad-type-int.json:3:13: Stray "1"
> +tests/qapi-schema/bad-type-int.json:2: 'struct' key must have a string v=
alue

Test needs a rename, assuming it's not redundant now.

> diff --git a/tests/qapi-schema/enum-int-member.err b/tests/qapi-schema/en=
um-int-member.err
> index 071c5213d8..112175f79d 100644
> --- a/tests/qapi-schema/enum-int-member.err
> +++ b/tests/qapi-schema/enum-int-member.err
> @@ -1 +1 @@
> -tests/qapi-schema/enum-int-member.json:3:31: Stray "1"
> +tests/qapi-schema/enum-int-member.json:2: Member of enum 'MyEnum' requir=
es a string name

This one's name is still good.

> diff --git a/tests/qapi-schema/leading-comma-list.err b/tests/qapi-schema=
/leading-comma-list.err
> index f5c870bb9c..fa9c80aa57 100644
> --- a/tests/qapi-schema/leading-comma-list.err
> +++ b/tests/qapi-schema/leading-comma-list.err
> @@ -1 +1 @@
> -tests/qapi-schema/leading-comma-list.json:2:13: Expected "{", "[", "]", =
string, boolean or "null"
> +tests/qapi-schema/leading-comma-list.json:2:13: Expected "{", "[", "]", =
string, boolean, number or "null"


