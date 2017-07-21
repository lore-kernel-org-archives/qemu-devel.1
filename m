Received: from eggs.gnu.org ([2001:4830:134:3::10]:43835)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ldoktor@redhat.com>) id 1dYRZK-0004Wj-1Y
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 02:37:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ldoktor@redhat.com>) id 1dYRZG-0000rw-Vo
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 02:37:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51260)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ldoktor@redhat.com>) id 1dYRZG-0000rO-LK
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 02:37:42 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 5C6A06551
	for <qemu-devel@nongnu.org>; Fri, 21 Jul 2017 06:37:41 +0000 (UTC)
References: <20170720162815.19802-1-ldoktor@redhat.com>
	<20170720162815.19802-6-ldoktor@redhat.com>
	<20170720182753.GV2757@localhost.localdomain>
From: =?UTF-8?B?THVrw6HFoSBEb2t0b3I=?= <ldoktor@redhat.com>
Message-ID: <6701dad4-40a5-7287-a4b8-a22e19b90ce2@redhat.com>
Date: Fri, 21 Jul 2017 08:37:34 +0200
MIME-Version: 1.0
In-Reply-To: <20170720182753.GV2757@localhost.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="cBRaX6qm6dKSu0oI0PNLtQ8l80b3FLHgw"
Subject: Re: [Qemu-devel] [PATCH 05/11] qemu.py: Use custom exceptions
 rather than Exception
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: apahim@redhat.com, qemu-devel@nongnu.org, famz@redhat.com, armbru@redhat.com, mreitz@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--cBRaX6qm6dKSu0oI0PNLtQ8l80b3FLHgw
From: =?UTF-8?B?THVrw6HFoSBEb2t0b3I=?= <ldoktor@redhat.com>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: apahim@redhat.com, qemu-devel@nongnu.org, famz@redhat.com,
 armbru@redhat.com, mreitz@redhat.com
Message-ID: <6701dad4-40a5-7287-a4b8-a22e19b90ce2@redhat.com>
Subject: Re: [PATCH 05/11] qemu.py: Use custom exceptions rather than
 Exception
References: <20170720162815.19802-1-ldoktor@redhat.com>
 <20170720162815.19802-6-ldoktor@redhat.com>
 <20170720182753.GV2757@localhost.localdomain>
In-Reply-To: <20170720182753.GV2757@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Dne 20.7.2017 v 20:27 Eduardo Habkost napsal(a):
> On Thu, Jul 20, 2017 at 06:28:09PM +0200, Luk=C3=A1=C5=A1 Doktor wrote:=

>> The naked Exception should not be widely used. It makes sense to be a
>> bit more specific and use better-suited custom exceptions. As a benefi=
t
>> we can store the full reply in the exception in case someone needs it
>> when catching the exception.
>>
>> Signed-off-by: Luk=C3=A1=C5=A1 Doktor <ldoktor@redhat.com>
>> ---
>>  scripts/qemu.py | 17 +++++++++++++++--
>>  1 file changed, 15 insertions(+), 2 deletions(-)
>>
>> diff --git a/scripts/qemu.py b/scripts/qemu.py
>> index 5948e19..2bd522f 100644
>> --- a/scripts/qemu.py
>> +++ b/scripts/qemu.py
>> @@ -19,6 +19,19 @@ import subprocess
>>  import qmp.qmp
>> =20
>> =20
>> +class MonitorResponseError(qmp.qmp.QMPError):
>> +    '''
>> +    Represents erroneous QMP monitor reply
>> +    '''
>> +    def __init__(self, reply):
>> +        try:
>> +            desc =3D reply["error"]["desc"]
>> +        except KeyError:
>> +            desc =3D reply
>> +        super(MonitorResponseError, self).__init__(desc)
>> +        self.reply =3D reply
>=20
> This would require every user of self.reply to first check if
> it's a string or dictionary.  All because of the "Monitor is
> closed" case below:
>=20
I haven't used it for the `Monitor is closed` exception, so it's just to =
be able to store really broken reply safely. Anyway people can check whet=
her the reply is a dict, or I can add `is_valid_reply` property which wou=
ld check for `[error][desc]` presence (which is a bit more precise than j=
ust plain dict type checking).

>> +
>> +
>>  class QEMUMachine(object):
>>      '''A QEMU VM'''
>> =20
>> @@ -197,9 +210,9 @@ class QEMUMachine(object):
>>          '''
>>          reply =3D self.qmp(cmd, conv_keys, **args)
>>          if reply is None:
>> -            raise Exception("Monitor is closed")
>> +            raise qmp.qmp.QMPError("Monitor is closed")
>=20
> Should we really use the same exception type for this, if it's
> not really a QMP monitor error reply, and won't even have a real
> QMP reply in self.reply?
>=20
I wasn't sure but the same exception can be caused by other failures when=
 obtaining replies so I think in case the monitor is closed we might expe=
ct the same exception. Would importing it in the top level of this module=
 to become `qemu.QMPError` work for you better, or would you prefer IOErr=
or, RuntimeError or another custom exception?

Luk=C3=A1=C5=A1

>=20
>>          if "error" in reply:
>> -            raise Exception(reply["error"]["desc"])
>> +            raise MonitorResponseError(reply)
>>          return reply["return"]
>> =20
>>      def get_qmp_event(self, wait=3DFalse):
>> --=20
>> 2.9.4
>>
>=20



--cBRaX6qm6dKSu0oI0PNLtQ8l80b3FLHgw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEwBAEBCAAaBQJZcaEuExxsZG9rdG9yQHJlZGhhdC5jb20ACgkQJrNi5H/PIsGr
Ngf/Sb44T8tM303mZGx9i8Q+GJOcEUY8P7/iCF6G3gauzt8QIcRQzoDzlQ0pSX06
JzxZHMVlyfjoVgh9WYMihGB9fC+grX7kj1SLo2jBuvTepMKYw31OsvikNIuYQ/Xg
GjWYUKRCFtlMZWbNuhpZKv9gaYM5fufrWrnJEIzwTpFzlC8p2/41hHgi9skwpVZf
4JNK58Ue/5ajpbWXnQb9KbujsDa2n+su6ETSPrhbvtPzJKK9ufoyOiukGfDZmv9i
cu5pEo8vXPiNfZsSUytliBwZBVS5BQZHCtV3AixcDn1atu8LCpWKrCHIGBJQsn1M
cwEk58A2Ed0Xmw9K2lZdrgvHCA==
=t9QX
-----END PGP SIGNATURE-----

--cBRaX6qm6dKSu0oI0PNLtQ8l80b3FLHgw--
