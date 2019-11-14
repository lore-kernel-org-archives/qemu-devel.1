Return-Path: <SRS0=NHD5=ZG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B124C432C3
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2019 10:03:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ED730206D9
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2019 10:03:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gN3THK5w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED730206D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55134 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iVByJ-0008GE-0c
	for qemu-devel@archiver.kernel.org; Thu, 14 Nov 2019 05:03:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38481)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iVBle-000380-Dv
 for qemu-devel@nongnu.org; Thu, 14 Nov 2019 04:50:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iVBlc-0007IF-3a
 for qemu-devel@nongnu.org; Thu, 14 Nov 2019 04:50:22 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:49915
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1iVBlb-0007H6-TS
 for qemu-devel@nongnu.org; Thu, 14 Nov 2019 04:50:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573725018;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=PSMrPiqCb9br3g2nOFUtJc0oA3/IGdib9/8MGCrZWX0=;
 b=gN3THK5wRDqWZVodbinkzRvibolg4dXenYrXgZCalgQd8GfgcWWGVZNRSVsOlkpeQOaWXo
 yiGQVkbLauyIrpCl9pjaeCTOqtv3td/ES/jLq5hOCgzo4G7o+vMAEsGiCdHMZe4nwuIodo
 qTWdLjCE5iP7a4nhEIIiR9b4jfLHI7s=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-187-8oJLk1mhPQau7d_li7hK-w-1; Thu, 14 Nov 2019 04:50:16 -0500
X-MC-Unique: 8oJLk1mhPQau7d_li7hK-w-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 16F0E107ACC8;
 Thu, 14 Nov 2019 09:50:15 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-117-160.ams2.redhat.com
 [10.36.117.160])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id EF6905E258;
 Thu, 14 Nov 2019 09:50:12 +0000 (UTC)
Subject: Re: [Qemu-devel] [PATCH v4 01/14] qapi: Parse numeric values
To: Markus Armbruster <armbru@redhat.com>
References: <20190624173935.25747-1-mreitz@redhat.com>
 <20190624173935.25747-2-mreitz@redhat.com>
 <87mucyq0mp.fsf@dusky.pond.sub.org>
From: Max Reitz <mreitz@redhat.com>
Autocrypt: addr=mreitz@redhat.com; prefer-encrypt=mutual; keydata=
 mQENBFXOJlcBCADEyyhOTsoa/2ujoTRAJj4MKA21dkxxELVj3cuILpLTmtachWj7QW+TVG8U
 /PsMCFbpwsQR7oEy8eHHZwuGQsNpEtNC2G/L8Yka0BIBzv7dEgrPzIu+W3anZXQW4702+uES
 U29G8TP/NGfXRRHGlbBIH9KNUnOSUD2vRtpOLXkWsV5CN6vQFYgQfFvmp5ZpPeUe6xNplu8V
 mcTw8OSEDW/ZnxJc8TekCKZSpdzYoxfzjm7xGmZqB18VFwgJZlIibt1HE0EB4w5GsD7x5ekh
 awIe3RwoZgZDLQMdOitJ1tUc8aqaxvgA4tz6J6st8D8pS//m1gAoYJWGwwIVj1DjTYLtABEB
 AAG0HU1heCBSZWl0eiA8bXJlaXR6QHJlZGhhdC5jb20+iQFTBBMBCAA9AhsDBQkSzAMABQsJ
 CAcCBhUICQoLAgQWAgMBAh4BAheABQJVzie5FRhoa3A6Ly9rZXlzLmdudXBnLm5ldAAKCRD0
 B9sAYdXPQDcIB/9uNkbYEex1rHKz3mr12uxYMwLOOFY9fstP5aoVJQ1nWQVB6m2cfKGdcRe1
 2/nFaHSNAzT0NnKz2MjhZVmcrpyd2Gp2QyISCfb1FbT82GMtXFj1wiHmPb3CixYmWGQUUh+I
 AvUqsevLA+WihgBUyaJq/vuDVM1/K9Un+w+Tz5vpeMidlIsTYhcsMhn0L9wlCjoucljvbDy/
 8C9L2DUdgi3XTa0ORKeflUhdL4gucWoAMrKX2nmPjBMKLgU7WLBc8AtV+84b9OWFML6NEyo4
 4cP7cM/07VlJK53pqNg5cHtnWwjHcbpGkQvx6RUx6F1My3y52vM24rNUA3+ligVEgPYBuQEN
 BFXOJlcBCADAmcVUNTWT6yLWQHvxZ0o47KCP8OcLqD+67T0RCe6d0LP8GsWtrJdeDIQk+T+F
 xO7DolQPS6iQ6Ak2/lJaPX8L0BkEAiMuLCKFU6Bn3lFOkrQeKp3u05wCSV1iKnhg0UPji9V2
 W5eNfy8F4ZQHpeGUGy+liGXlxqkeRVhLyevUqfU0WgNqAJpfhHSGpBgihUupmyUg7lfUPeRM
 DzAN1pIqoFuxnN+BRHdAecpsLcbR8sQddXmDg9BpSKozO/JyBmaS1RlquI8HERQoe6EynJhd
 64aICHDfj61rp+/0jTIcevxIIAzW70IadoS/y3DVIkuhncgDBvGbF3aBtjrJVP+5ABEBAAGJ
 ASUEGAEIAA8FAlXOJlcCGwwFCRLMAwAACgkQ9AfbAGHVz0CbFwf9F/PXxQR9i4N0iipISYjU
 sxVdjJOM2TMut+ZZcQ6NSMvhZ0ogQxJ+iEQ5OjnIputKvPVd5U7WRh+4lF1lB/NQGrGZQ1ic
 alkj6ocscQyFwfib+xIe9w8TG1CVGkII7+TbS5pXHRxZH1niaRpoi/hYtgzkuOPp35jJyqT/
 /ELbqQTDAWcqtJhzxKLE/ugcOMK520dJDeb6x2xVES+S5LXby0D4juZlvUj+1fwZu+7Io5+B
 bkhSVPb/QdOVTpnz7zWNyNw+OONo1aBUKkhq2UIByYXgORPFnbfMY7QWHcjpBVw9MgC4tGeF
 R4bv+1nAMMxKmb5VvQCExr0eFhJUAHAhVg==
Message-ID: <f42afeb3-422a-16f0-5f7e-be885f1132ff@redhat.com>
Date: Thu, 14 Nov 2019 10:50:10 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <87mucyq0mp.fsf@dusky.pond.sub.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="lLTlRknFjJbeaQfME8LQQ6fMkATAbuwDw"
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org,
 Michael Roth <mdroth@linux.vnet.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--lLTlRknFjJbeaQfME8LQQ6fMkATAbuwDw
Content-Type: multipart/mixed; boundary="qGXBiv7TiXnx1hXbUmZqcvhjKHqyJle4u"

--qGXBiv7TiXnx1hXbUmZqcvhjKHqyJle4u
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 14.11.19 10:15, Markus Armbruster wrote:
> Max Reitz <mreitz@redhat.com> writes:
>=20
>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>> ---
>>  tests/qapi-schema/bad-type-int.json      |  1 -
>>  tests/qapi-schema/enum-int-member.json   |  1 -
>>  scripts/qapi/common.py                   | 25 ++++++++++++++++++++----
>>  scripts/qapi/introspect.py               |  2 ++
>>  tests/qapi-schema/bad-type-int.err       |  2 +-
>>  tests/qapi-schema/enum-int-member.err    |  2 +-
>>  tests/qapi-schema/leading-comma-list.err |  2 +-
>>  7 files changed, 26 insertions(+), 9 deletions(-)
>>
>> diff --git a/tests/qapi-schema/bad-type-int.json b/tests/qapi-schema/bad=
-type-int.json
>> index 56fc6f8126..81355eb196 100644
>> --- a/tests/qapi-schema/bad-type-int.json
>> +++ b/tests/qapi-schema/bad-type-int.json
>> @@ -1,3 +1,2 @@
>>  # we reject an expression with a metatype that is not a string
>> -# FIXME: once the parser understands integer inputs, improve the error =
message
>>  { 'struct': 1, 'data': { } }
>> diff --git a/tests/qapi-schema/enum-int-member.json b/tests/qapi-schema/=
enum-int-member.json
>> index 6c9c32e149..6958440c6d 100644
>> --- a/tests/qapi-schema/enum-int-member.json
>> +++ b/tests/qapi-schema/enum-int-member.json
>> @@ -1,3 +1,2 @@
>>  # we reject any enum member that is not a string
>> -# FIXME: once the parser understands integer inputs, improve the error =
message
>>  { 'enum': 'MyEnum', 'data': [ 1 ] }
>> diff --git a/scripts/qapi/common.py b/scripts/qapi/common.py
>> index d61bfdc526..3396ea4a09 100644
>> --- a/scripts/qapi/common.py
>> +++ b/scripts/qapi/common.py
>> @@ -498,6 +498,8 @@ class QAPISchemaParser(object):
>>              raise QAPISemError(info, "Unknown pragma '%s'" % name)
>> =20
>>      def accept(self, skip_comment=3DTrue):
>> +        num_match =3D re.compile(r'([-+]?inf|nan|[-+0-9.][0-9a-f.ex]*)'=
)
>> +
>>          while True:
>>              self.tok =3D self.src[self.cursor]
>>              self.pos =3D self.cursor
>=20
> This is yet another extension over plain JSON.  RFC 8259:
>=20
>       number =3D [ minus ] int [ frac ] [ exp ]
>       decimal-point =3D %x2E       ; .
>       digit1-9 =3D %x31-39         ; 1-9
>       e =3D %x65 / %x45            ; e E
>       exp =3D e [ minus / plus ] 1*DIGIT
>       frac =3D decimal-point 1*DIGIT
>       int =3D zero / ( digit1-9 *DIGIT )
>       minus =3D %x2D               ; -
>       plus =3D %x2B                ; +
>       zero =3D %x30                ; 0
>=20
> Extensions are acceptable when we have an actual use for it, and we
> document them properly.

Well, it isn=E2=80=99t really an extension, because this isn=E2=80=99t a JS=
ON parser but
just something that accepts anything that looks like a number and then
lets Python try a conversion on it.

> Isn't the parenthesis in your regular expression redundant?

You=E2=80=99re right, but on second thought, maybe I should surround it by =
\<
and \>.

> What use do you have in mind for 'inf' and 'nan'?

I could imagine inf being a useful default value, actually.  nan,
probably not so much.

> Why accept leading '+' as in '+123'?
>=20
> Why accept empty integral part as in '.123'?
>=20
> Why accept '.xe.'?  Kidding you, that must be a bug in your regexp.

Well, kind of.

I wanted to accept anything that looks in any way like a number and then
let Python try to convert it.  That=E2=80=99s also the reason why the case =
comes
last.

For that reason, I decided to keep the regex as simple as possible,
because the attempted conversions would reject anything that isn=E2=80=99t =
(to
Python) a valid number later.

It was my impression that the QAPI schema isn=E2=80=99t really JSON anyway =
and
that our QAPI schema parser isn=E2=80=99t a JSON parser.  Under that assump=
tion
it simply seemed useful to me to accept anything that could potentially
be a number to Python and convert it.

Now, honestly, I still don=E2=80=99t see the point of having a strict JSON
=E2=80=9Cparser=E2=80=9D here, but if you insist.  Seems possible to do in =
a regex.

Though I do think it makes sense to support hex integers as an extension.

> Please decide what number syntax you'd like to accept, then specify it
> in docs/devel/qapi-code-gen.txt, so we can first discuss the
> specification, and then check the regexp implements it.
>=20
> docs/devel/qapi-code-gen.txt update goes here:
>=20
>     =3D=3D=3D Schema syntax =3D=3D=3D
>=20
>     Syntax is loosely based on JSON (http://www.ietf.org/rfc/rfc8259.txt)=
.
>     Differences:
>=20
>     * Comments: start with a hash character (#) that is not part of a
>       string, and extend to the end of the line.
>=20
>     * Strings are enclosed in 'single quotes', not "double quotes".
>=20
>     * Strings are restricted to printable ASCII, and escape sequences to
>       just '\\'.
>=20
> --> * Numbers and null are not supported.

OK.

> Hrmm, commit 9d55380b5a "qapi: Remove null from schema language" left
> two instances in error messages behind.  I'll fix them.
>=20
>> @@ -584,7 +586,22 @@ class QAPISchemaParser(object):
>>                      return
>>                  self.line +=3D 1
>>                  self.line_pos =3D self.cursor
>> -            elif not self.tok.isspace():
>> +            elif self.tok.isspace():
>> +                pass
>> +            elif num_match.match(self.src[self.pos:]):
>> +                match =3D num_match.match(self.src[self.pos:]).group(0)
>=20
> Sadly, the walrus operator is Python 3.8.
>=20
>> +                try:
>> +                    self.val =3D int(match, 0)
>> +                except ValueError:
>> +                    try:
>> +                        self.val =3D float(match)
>> +                    except ValueError:
>> +                        raise QAPIParseError(self,
>> +                                '"%s" is not a valid integer or float' =
% match)
>> +
>> +                self.cursor +=3D len(match) - 1
>> +                return
>> +            else:
>>                  raise QAPIParseError(self, 'Stray "%s"' % self.tok)
>=20
> Any particular reason for putting the number case last?

Because the match is so broad.

>> =20
>>      def get_members(self):
>> @@ -617,9 +634,9 @@ class QAPISchemaParser(object):
>>          if self.tok =3D=3D ']':
>>              self.accept()
>>              return expr
>> -        if self.tok not in "{['tfn":
>> +        if self.tok not in "{['tfn-+0123456789.i":
>=20
> This is getting a bit ugly.  Let's not worry about it now.
>=20
>>              raise QAPIParseError(self, 'Expected "{", "[", "]", string,=
 '
>> -                                 'boolean or "null"')
>> +                                 'boolean, number or "null"')
>>          while True:
>>              expr.append(self.get_expr(True))
>>              if self.tok =3D=3D ']':
>> @@ -638,7 +655,7 @@ class QAPISchemaParser(object):
>>          elif self.tok =3D=3D '[':
>>              self.accept()
>>              expr =3D self.get_values()
>> -        elif self.tok in "'tfn":
>> +        elif self.tok in "'tfn-+0123456789.i":
>>              expr =3D self.val
>>              self.accept()
>>          else:
>> diff --git a/scripts/qapi/introspect.py b/scripts/qapi/introspect.py
>> index f62cf0a2e1..6a61dd831f 100644
>> --- a/scripts/qapi/introspect.py
>> +++ b/scripts/qapi/introspect.py
>> @@ -57,6 +57,8 @@ def to_qlit(obj, level=3D0, suppress_first_indent=3DFa=
lse):
>>          ret +=3D indent(level) + '}))'
>>      elif isinstance(obj, bool):
>>          ret +=3D 'QLIT_QBOOL(%s)' % ('true' if obj else 'false')
>> +    elif isinstance(obj, int) and obj >=3D -(2 ** 63) and obj < 2 ** 63=
:
>> +        ret +=3D 'QLIT_QNUM(%i)' % obj
>=20
> Please explain the range check.

Will do.

>>      else:
>>          assert False                # not implemented
>>      if level > 0:
>> diff --git a/tests/qapi-schema/bad-type-int.err b/tests/qapi-schema/bad-=
type-int.err
>> index da89895404..e22fb4f655 100644
>> --- a/tests/qapi-schema/bad-type-int.err
>> +++ b/tests/qapi-schema/bad-type-int.err
>> @@ -1 +1 @@
>> -tests/qapi-schema/bad-type-int.json:3:13: Stray "1"
>> +tests/qapi-schema/bad-type-int.json:2: 'struct' key must have a string =
value
>=20
> Test needs a rename, assuming it's not redundant now.

I=E2=80=99m not adding a test here, it=E2=80=99s just the value has changed=
 in
4d42815587063d.

Thanks for reviewing!

Max

>> diff --git a/tests/qapi-schema/enum-int-member.err b/tests/qapi-schema/e=
num-int-member.err
>> index 071c5213d8..112175f79d 100644
>> --- a/tests/qapi-schema/enum-int-member.err
>> +++ b/tests/qapi-schema/enum-int-member.err
>> @@ -1 +1 @@
>> -tests/qapi-schema/enum-int-member.json:3:31: Stray "1"
>> +tests/qapi-schema/enum-int-member.json:2: Member of enum 'MyEnum' requi=
res a string name
>=20
> This one's name is still good.
>=20
>> diff --git a/tests/qapi-schema/leading-comma-list.err b/tests/qapi-schem=
a/leading-comma-list.err
>> index f5c870bb9c..fa9c80aa57 100644
>> --- a/tests/qapi-schema/leading-comma-list.err
>> +++ b/tests/qapi-schema/leading-comma-list.err
>> @@ -1 +1 @@
>> -tests/qapi-schema/leading-comma-list.json:2:13: Expected "{", "[", "]",=
 string, boolean or "null"
>> +tests/qapi-schema/leading-comma-list.json:2:13: Expected "{", "[", "]",=
 string, boolean, number or "null"



--qGXBiv7TiXnx1hXbUmZqcvhjKHqyJle4u--

--lLTlRknFjJbeaQfME8LQQ6fMkATAbuwDw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl3NI1IACgkQ9AfbAGHV
z0CgYwf/dIMAsJBt6HvmH1qkcH4Od3brCIXd8Tchs4PWM5PSKhVoBQgpZm7XHXdP
kAx27wfiol6aRCHugd9Addz0aoKy633vjcuokU61FBtiA9LqTBee7MDivRsdXx+L
Nl4UjUYbxNIiJeCK7908mxbM8ARtTfxNGNBWGlqSnHtfi6LoxSx2rhp0s6e7lYfJ
4DjfdFLd4PSIVnke3QdkASEIzJAPEBadxGdClE4wzfQhVl3/Z/FkBLdoptLDoTrO
2XtB3xjnzZIDKppvSVEZ6TgsjqRgCp7XwgwYNopGbLyyKdbAhygSaZp7obaXMyUk
FxbpJKutqzjO8ah1JVx8tjIrdtux9Q==
=T0KG
-----END PGP SIGNATURE-----

--lLTlRknFjJbeaQfME8LQQ6fMkATAbuwDw--


