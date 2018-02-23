Received: from eggs.gnu.org ([2001:4830:134:3::10]:38314)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1epHCJ-0004ha-IZ
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 12:31:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1epHCE-0002pJ-Cw
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 12:31:51 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36038 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1epHCE-0002oO-80
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 12:31:46 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <20180211093607.27351-1-armbru@redhat.com>
	<20180211093607.27351-16-armbru@redhat.com>
	<151899823299.12376.14441267959518289640@sif>
Date: Fri, 23 Feb 2018 18:31:42 +0100
In-Reply-To: <151899823299.12376.14441267959518289640@sif> (Michael Roth's
	message of "Sun, 18 Feb 2018 17:57:12 -0600")
Message-ID: <87woz3k3y9.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 15/29] qapi: Record 'include' directives
 in parse tree
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Roth <mdroth@linux.vnet.ibm.com>
Cc: qemu-devel@nongnu.org, marcandre.lureau@redhat.com

Michael Roth <mdroth@linux.vnet.ibm.com> writes:

> Quoting Markus Armbruster (2018-02-11 03:35:53)
>> The parse tree is a list of expressions.  Except include expressions
>> currently get replaced by the included file's parse tree.
>>=20
>> Instead of throwing away the include expression, keep it with the file
>> name expanded so you don't have to track the including file's
>> directory to make sense of it.
>>=20
>> A future commit will put this include expression to use.
>>=20
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>> ---
>>  scripts/qapi/common.py | 21 +++++++++++++++++----
>>  1 file changed, 17 insertions(+), 4 deletions(-)
>>=20
>> diff --git a/scripts/qapi/common.py b/scripts/qapi/common.py
>> index cc5a5941dd..6d49709784 100644
>> --- a/scripts/qapi/common.py
>> +++ b/scripts/qapi/common.py
>> @@ -290,8 +290,11 @@ class QAPISchemaParser(object):
>>                  if not isinstance(include, str):
>>                      raise QAPISemError(info,
>>                                         "Value of 'include' must be a st=
ring")
>> -                exprs_include =3D self._include(include, info,
>> -                                              os.path.dirname(self.fnam=
e),
>> +                incl_fname =3D os.path.join(os.path.dirname(self.fname),
>> +                                          include)
>> +                self.exprs.append({'expr': {'include': incl_fname},
>> +                                   'info': info})
>> +                exprs_include =3D self._include(include, info, incl_fna=
me,
>>                                                previously_included)
>>                  if exprs_include:
>>                      self.exprs.extend(exprs_include.exprs)
>> @@ -326,8 +329,7 @@ class QAPISchemaParser(object):
>>                  "Documentation for '%s' is not followed by the definiti=
on"
>>                  % doc.symbol)
>>=20
>> -    def _include(self, include, info, base_dir, previously_included):
>> -        incl_fname =3D os.path.join(base_dir, include)
>> +    def _include(self, include, info, incl_fname, previously_included):
>>          incl_abs_fname =3D os.path.abspath(incl_fname)
>>          # catch inclusion cycle
>>          inf =3D info
>> @@ -893,6 +895,9 @@ def check_exprs(exprs):
>>          info =3D expr_elem['info']
>>          doc =3D expr_elem.get('doc')
>>=20
>> +        if 'include' in expr:
>> +            continue
>> +
>>          if not doc and doc_required:
>>              raise QAPISemError(info,
>>                                 "Expression missing documentation commen=
t")
>> @@ -931,6 +936,9 @@ def check_exprs(exprs):
>>=20
>>      # Try again for hidden UnionKind enum
>>      for expr_elem in exprs:
>> +        if 'include' in expr:
>> +            continue
>> +
>
> Wouldn't this ^
>
>>          expr =3D expr_elem['expr']
>
> Need to come after this?

D'oh!

>>          if 'union' in expr and not discriminator_find_enum_define(expr):
>>              name =3D '%sKind' % expr['union']
>> @@ -943,6 +951,9 @@ def check_exprs(exprs):
>>=20
>>      # Validate that exprs make sense
>>      for expr_elem in exprs:
>> +        if 'include' in expr:
>> +            continue
>> +
>>          expr =3D expr_elem['expr']
>
> And here.

Right.  I wonder how this passes tests.

>>          info =3D expr_elem['info']
>>          doc =3D expr_elem.get('doc')
>> @@ -1667,6 +1678,8 @@ class QAPISchema(object):
>>                  self._def_command(expr, info, doc)
>>              elif 'event' in expr:
>>                  self._def_event(expr, info, doc)
>> +            elif 'include' in expr:
>> +                pass
>>              else:
>>                  assert False
>>=20
>> --=20
>> 2.13.6
>>=20
