Received: from eggs.gnu.org ([2001:4830:134:3::10]:38524)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gNFWo-0000l8-IK
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 06:09:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gNFWi-00037o-Ff
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 06:09:39 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44580)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1gNFWZ-00031J-Ab
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 06:09:30 -0500
References: <20181109110221.10553-1-david@redhat.com>
	<20181109110221.10553-3-david@redhat.com>
	<87r2fnod2p.fsf@dusky.pond.sub.org>
From: David Hildenbrand <david@redhat.com>
Message-ID: <359e518d-ffdc-e062-c9c7-20034155051e@redhat.com>
Date: Thu, 15 Nov 2018 12:09:19 +0100
MIME-Version: 1.0
In-Reply-To: <87r2fnod2p.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH RFC 2/6] qapi: use qemu_strtod() in
 string-input-visitor
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>

On 14.11.18 17:09, Markus Armbruster wrote:
> David Hildenbrand <david@redhat.com> writes:
>=20
>> Let's use the new function.
>>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
>> ---
>>  qapi/string-input-visitor.c | 6 ++----
>>  1 file changed, 2 insertions(+), 4 deletions(-)
>>
>> diff --git a/qapi/string-input-visitor.c b/qapi/string-input-visitor.c
>> index b3fdd0827d..dee708d384 100644
>> --- a/qapi/string-input-visitor.c
>> +++ b/qapi/string-input-visitor.c
>> @@ -20,6 +20,7 @@
>>  #include "qemu/option.h"
>>  #include "qemu/queue.h"
>>  #include "qemu/range.h"
>> +#include "qemu/cutils.h"
>> =20
>> =20
>>  struct StringInputVisitor
>> @@ -313,12 +314,9 @@ static void parse_type_number(Visitor *v, const c=
har *name, double *obj,
>>                                Error **errp)
>>  {
>>      StringInputVisitor *siv =3D to_siv(v);
>> -    char *endp =3D (char *) siv->string;
>>      double val;
>> =20
>> -    errno =3D 0;
>> -    val =3D strtod(siv->string, &endp);
>> -    if (errno || endp =3D=3D siv->string || *endp) {
>> +    if (qemu_strtod(siv->string, NULL, &val)) {
>>          error_setg(errp, QERR_INVALID_PARAMETER_TYPE, name ? name : "=
null",
>>                     "number");
>>          return;
>=20
> Three more: in qobject-input-visitor.c's
> qobject_input_type_number_keyval(),

This one is interesting, as it properly bails out when parsing "inf"
(via isFinite()). - should we do the same for the string input visitor?

Especially, should we forbid "inf" and "NaN" in both scenarios?

cutil.c's do_strtosz(), and
> json-parser.c's parse_literal().
>=20
> The latter doesn't check for errors since the lexer ensures the input i=
s
> sane.  Overflow can still happen, and is silently ignored.  Feel free
> not to convert this one.
>=20

I'll do the conversion of all (allowing -ERANGE where it used to be
allow), we can then discuss with the patches at hand if it makes sense.

--=20

Thanks,

David / dhildenb
