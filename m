Received: from eggs.gnu.org ([2001:4830:134:3::10]:50124)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ldoktor@redhat.com>) id 1fRLeF-0002LB-FE
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 13:58:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ldoktor@redhat.com>) id 1fRLeB-0005UK-FD
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 13:58:03 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:49624 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ldoktor@redhat.com>) id 1fRLeB-0005Tu-8d
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 13:57:59 -0400
References: <20180606192731.6910-1-f4bug@amsat.org>
	<20180606200513.GY7451@localhost.localdomain>
	<6a527693-33e6-813b-9fc5-b114aacc7668@amsat.org>
From: =?UTF-8?B?THVrw6HFoSBEb2t0b3I=?= <ldoktor@redhat.com>
Message-ID: <ff4501f9-f45e-dc96-9f02-861458fee39b@redhat.com>
Date: Fri, 8 Jun 2018 19:57:55 +0200
MIME-Version: 1.0
In-Reply-To: <6a527693-33e6-813b-9fc5-b114aacc7668@amsat.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="MXwpnuVNxTsckGamUZdNY8Or1EfZsENcW"
Subject: Re: [Qemu-devel] [RFC PATCH v2] qmp.py: Fix exception parsing
 partial JSON
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Eduardo Habkost <ehabkost@redhat.com>
Cc: Cleber Rosa <crosa@redhat.com>, Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org, "=?UTF-8?Q?Daniel_P._Berrang=c3=a9?=" <berrange@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--MXwpnuVNxTsckGamUZdNY8Or1EfZsENcW
From: =?UTF-8?B?THVrw6HFoSBEb2t0b3I=?= <ldoktor@redhat.com>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 Eduardo Habkost <ehabkost@redhat.com>
Cc: Cleber Rosa <crosa@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 qemu-devel@nongnu.org, =?UTF-8?Q?Daniel_P._Berrang=c3=a9?=
 <berrange@redhat.com>
Message-ID: <ff4501f9-f45e-dc96-9f02-861458fee39b@redhat.com>
Subject: Re: [RFC PATCH v2] qmp.py: Fix exception parsing partial JSON
References: <20180606192731.6910-1-f4bug@amsat.org>
 <20180606200513.GY7451@localhost.localdomain>
 <6a527693-33e6-813b-9fc5-b114aacc7668@amsat.org>
In-Reply-To: <6a527693-33e6-813b-9fc5-b114aacc7668@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hello guys,

Dne 7.6.2018 v 01:06 Philippe Mathieu-Daud=C3=A9 napsal(a):
> On 06/06/2018 05:05 PM, Eduardo Habkost wrote:
>> On Wed, Jun 06, 2018 at 04:27:31PM -0300, Philippe Mathieu-Daud=C3=A9 =
wrote:
>>> The readline() call returns partial data.
>>
>> How can this be reproduced?  Despite not being forbidden by the
>> QMP specification, QEMU normally doesn't break QMP replies in
>> multiple lines, and readline() is not supposed to return a
>> partial line unless it encounters EOF.
>=20
> $ git rev-parse HEAD
> c1c2a435905ae76b159c573b0c0d6f095b45ebc6
>=20
> config copy/pasted from:
> https://wiki.qemu.org/index.php/Documentation/QMP#Trying_it
> (now looking at it, it seems I'm mixing configs...)
>=20
> $ cat qmp.conf
> [chardev "qmp"]
>   backend =3D "socket"
>   path =3D "/tmp/qmp.sock"
>   server =3D "on"
>   wait =3D "off"
> [mon "qmp"]
>   mode =3D "control"
>   chardev =3D "qmp"
>   pretty =3D "on"
>=20

nice, pretty printing..., didn't expected that.

> $ arm-softmmu/qemu-system-arm -M lm3s6965evb -kernel /dev/zero \
>  -readconfig qmp.conf -S
>=20
>>
>>
>>> Keep appending until the JSON buffer is complete.
>>>
>>> This fixes:
>>>
>>>     $ scripts/qmp/qmp-shell -v -p /tmp/qmp.sock
>>>     Traceback (most recent call last):
>>>       File "scripts/qmp/qmp-shell", line 456, in <module>
>>>         main()
>>>       File "scripts/qmp/qmp-shell", line 441, in main
>>>         qemu.connect(negotiate)
>>>       File "scripts/qmp/qmp-shell", line 284, in connect
>>>         self._greeting =3D super(QMPShell, self).connect(negotiate)
>>>       File "scripts/qmp/qmp.py", line 143, in connect
>>>         return self.__negotiate_capabilities()
>>>       File "scripts/qmp/qmp.py", line 71, in __negotiate_capabilities=

>>>         greeting =3D self.__json_read()
>>>       File "scripts/qmp/qmp.py", line 85, in __json_read
>>>         resp =3D json.loads(data)
>>>       File "/usr/lib/python2.7/json/__init__.py", line 339, in loads
>>>         return _default_decoder.decode(s)
>>>       File "/usr/lib/python2.7/json/decoder.py", line 364, in decode
>>>         obj, end =3D self.raw_decode(s, idx=3D_w(s, 0).end())
>>>       File "/usr/lib/python2.7/json/decoder.py", line 380, in raw_dec=
ode
>>>         obj, end =3D self.scan_once(s, idx)
>>>     ValueError: Expecting object: line 1 column 3 (char 2)
>>>
>>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>>> ---
>>> Since v1:
>>> - addressed Daniel review: clean data after json.loads() succeeds
>>> - add a XXX comment
>>>
>>> Daniel suggested this is due to blocking i/o.
>>>
>>> I'm sure there is a nicer/more pythonic way to do this, but this work=
s for me,
>>> sorry :)
>>
>> It looks like there's no elegant solution for this:
>> https://stackoverflow.com/a/21709058
>>

Yep, that looks nicer, but even the original solution should not be that =
bad as it should be rarely used. What troubles me more is the possible in=
finite loop. Would you mind adding a timeout?

Luk=C3=A1=C5=A1

>>>
>>>  scripts/qmp/qmp.py | 13 ++++++++++---
>>>  1 file changed, 10 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/scripts/qmp/qmp.py b/scripts/qmp/qmp.py
>>> index 5c8cf6a056..14f0b48936 100644
>>> --- a/scripts/qmp/qmp.py
>>> +++ b/scripts/qmp/qmp.py
>>> @@ -78,11 +78,18 @@ class QEMUMonitorProtocol(object):
>>>          raise QMPCapabilitiesError
>>> =20
>>>      def __json_read(self, only_event=3DFalse):
>>> +        data =3D ""
>>>          while True:
>>> -            data =3D self.__sockfile.readline()
>>> -            if not data:
>>> +            tmp =3D self.__sockfile.readline()
>>> +            if not tmp:
>>>                  return
>>> -            resp =3D json.loads(data)
>>> +            data +=3D tmp
>>> +            try:
>>> +                resp =3D json.loads(data)
>>> +            except ValueError:
>>> +                # XXX: blindly loop, even if QEMU ever sends malform=
ed data
>>> +                continue
>>>> I was going to suggest using json.JSONDecoder.raw_decode() and
>> saving the remaining data in case we already read partial data
>> for a second JSON message.
>>
>> But the QMP specification says all messages are terminated with
>> CRLF, so we we should never see the data for two different
>> messages in a single readline() call.  Noting this in a comment
>> wouldn't hurt, though.
>>
>> The patch seems reasonable, but first I would like to understand
>> how this bug can be triggered.
>>
>>> +            data =3D ""
>>>              if 'event' in resp:
>>>                  self.logger.debug("<<< %s", resp)
>>>                  self.__events.append(resp)
>>> --=20
>>> 2.17.1
>>>
>>



--MXwpnuVNxTsckGamUZdNY8Or1EfZsENcW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEpApMRcQDTeAqWtSDJrNi5H/PIsEFAlsaw6MACgkQJrNi5H/P
IsF+xAf/cXxuFdrQHl70pB3Xx0NYl0ko5zxvDwVn/GXIzfuYF63xNhvEZmYIG/0j
FxJL4qqRDdGe/b7VrgBsewcSnFFDBMqK0dksapVH/h4wf02gECo6tpNLVeAZv2k1
kp0G/xOM0P86hr6OuOIpAbxgckObL5ytFB1YkfRVj/6yS8qkE3nHCtENwafdkSwO
EAY9xAsa3rgbp7t//n9YBjtrJmDuOCMyAIIskfn4u9tHsdRkY4bKVYipU0wltfvm
0JzmcJfj0yvDhsE862jVk7PSVLv7cmR7D6mZPLGIjvAjlMl9mEMfbyu7Uq9MjcYy
5EP627IC79oGiRNb27xGfLW24Hw9bw==
=0raq
-----END PGP SIGNATURE-----

--MXwpnuVNxTsckGamUZdNY8Or1EfZsENcW--
