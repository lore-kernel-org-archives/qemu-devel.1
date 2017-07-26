Received: from eggs.gnu.org ([2001:4830:134:3::10]:34872)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ldoktor@redhat.com>) id 1daE6m-0000n0-TL
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 00:39:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ldoktor@redhat.com>) id 1daE6i-00040S-Bh
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 00:39:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52926)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ldoktor@redhat.com>) id 1daE6i-0003ya-2F
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 00:39:36 -0400
References: <20170725150951.16038-1-ldoktor@redhat.com>
	<20170725150951.16038-6-ldoktor@redhat.com>
	<20170725160639.GO2757@localhost.localdomain>
From: =?UTF-8?B?THVrw6HFoSBEb2t0b3I=?= <ldoktor@redhat.com>
Message-ID: <e9246b9c-c004-3647-edb7-44e849f33f94@redhat.com>
Date: Wed, 26 Jul 2017 06:39:28 +0200
MIME-Version: 1.0
In-Reply-To: <20170725160639.GO2757@localhost.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="bouWXDWr9KqC93AK2Ll73PfLCxD1lbS15"
Subject: Re: [Qemu-devel] [PATCH v2 05/10] qemu.py: Use custom exceptions
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
Cc: qemu-devel@nongnu.org, famz@redhat.com, apahim@redhat.com, mreitz@redhat.com, f4bug@amsat.org, armbru@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--bouWXDWr9KqC93AK2Ll73PfLCxD1lbS15
From: =?UTF-8?B?THVrw6HFoSBEb2t0b3I=?= <ldoktor@redhat.com>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: qemu-devel@nongnu.org, famz@redhat.com, apahim@redhat.com,
 mreitz@redhat.com, f4bug@amsat.org, armbru@redhat.com
Message-ID: <e9246b9c-c004-3647-edb7-44e849f33f94@redhat.com>
Subject: Re: [PATCH v2 05/10] qemu.py: Use custom exceptions rather than
 Exception
References: <20170725150951.16038-1-ldoktor@redhat.com>
 <20170725150951.16038-6-ldoktor@redhat.com>
 <20170725160639.GO2757@localhost.localdomain>
In-Reply-To: <20170725160639.GO2757@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Dne 25.7.2017 v 18:06 Eduardo Habkost napsal(a):
> On Tue, Jul 25, 2017 at 05:09:46PM +0200, Luk=C3=A1=C5=A1 Doktor wrote:=

>> The naked Exception should not be widely used. It makes sense to be a
>> bit more specific and use better-suited custom exceptions. As a benefi=
t
>> we can store the full reply in the exception in case someone needs it
>> when catching the exception.
>>
>> Signed-off-by: Luk=C3=A1=C5=A1 Doktor <ldoktor@redhat.com>
>> Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
>> ---
>>  scripts/qemu.py | 17 +++++++++++++++--
>>  1 file changed, 15 insertions(+), 2 deletions(-)
>>
>> diff --git a/scripts/qemu.py b/scripts/qemu.py
>> index 5948e19..e6df54c 100644
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
>                       ^^^ (*)
>> +        super(MonitorResponseError, self).__init__(repr(desc))
>=20
> This will end up calling Exception.__init__.  I previously
> suggested repr(desc) above(*) because I didn't know what happened
> when the Exception.__init__ argument is not a string.
>=20
> I couldn't find any documentation on the right argument types for
> Exception.__init__.  The examples in the Python documentation[1]
> don't call Exception.__init__ at all: they simply implement
> __str__().
>=20
> However, based on my testing and on the BaseException
> documentation[2], I believe repr() isn't really necessary:
>=20
> "If str() or unicode() is called on an instance of this class,
> the representation of the argument(s) to the instance are
> returned, or the empty string when there were no arguments."
>=20
> So your previous version was good, already.
>=20
> But maybe we could do this instead, to make the constructor as
> simple as possible:
>=20
> class MonitorResponseError(qmp.qmp.QMPError):
>     def __init__(self, reply):
>         self.reply =3D reply
>=20
>     def __str__(self):
>         return self.reply.get('error', {}).get('desc', repr(self.reply)=
)
>=20
Well I know I can implement custom `__str__` class, but the default one s=
imply stores the argument as string and reports it, so for simple strings=
 I usually go with super call and with complex ones with custom `__str__`=
=2E Anyway if this suits this project style better I'll change it in v2.

Luk=C3=A1=C5=A1

>=20
> [1] https://docs.python.org/2/tutorial/errors.html#user-defined-excepti=
ons
> [2] https://docs.python.org/2/library/exceptions.html#exceptions.BaseEx=
ception
>=20
>> +        self.reply =3D reply
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



--bouWXDWr9KqC93AK2Ll73PfLCxD1lbS15
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEwBAEBCAAaBQJZeB0AExxsZG9rdG9yQHJlZGhhdC5jb20ACgkQJrNi5H/PIsEV
tgf9E1+4xDAhULHkttLmBGN7dDpcLe2Rw2+zPf0Wx7yus7ycAVkoaY7KE9GBOctc
HMi0U9eqUILk9wsEkMI5FNBE9194EiOb+3mwR4tb82da7HYwcNmTOmP6tkT/Ktl6
qm67ScY1K/e61YVcbtlB/PHcgqV7SMZKO6wW5gBMvTZkosuStdJIhfRzs1gpLC59
iW5jd9VNizLHtgik+7g/W0OaB7PUEi8xNOfYOzryL8HLVzvnB3+blp6bq3+1phf/
90KiFK2nTg8hneORsM6rRW/go6XoY2c6xe7Wn14zeXnWtFd2oPyIn6hvpvGpsaIl
/qIIVC+i4zXMZlIaoNEH3oNmaw==
=cj8P
-----END PGP SIGNATURE-----

--bouWXDWr9KqC93AK2Ll73PfLCxD1lbS15--
