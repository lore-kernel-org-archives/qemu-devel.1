Received: from eggs.gnu.org ([2001:4830:134:3::10]:36346)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ldoktor@redhat.com>) id 1daEDb-0002TA-RZ
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 00:46:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ldoktor@redhat.com>) id 1daEDX-0006wq-Rz
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 00:46:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43866)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ldoktor@redhat.com>) id 1daEDX-0006v7-Gx
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 00:46:39 -0400
References: <20170725150951.16038-1-ldoktor@redhat.com>
	<20170725150951.16038-10-ldoktor@redhat.com>
	<20170725193442.GS2757@localhost.localdomain>
From: =?UTF-8?B?THVrw6HFoSBEb2t0b3I=?= <ldoktor@redhat.com>
Message-ID: <a0a70f94-54a4-737e-cd17-478ff2ba854c@redhat.com>
Date: Wed, 26 Jul 2017 06:46:30 +0200
MIME-Version: 1.0
In-Reply-To: <20170725193442.GS2757@localhost.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="SQWF9VGVCLBGpDM8rhbT8SdeNFx3aRGLI"
Subject: Re: [Qemu-devel] [PATCH v2 09/10] qmp.py: Avoid overriding a
 builtin object
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
--SQWF9VGVCLBGpDM8rhbT8SdeNFx3aRGLI
From: =?UTF-8?B?THVrw6HFoSBEb2t0b3I=?= <ldoktor@redhat.com>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: qemu-devel@nongnu.org, famz@redhat.com, apahim@redhat.com,
 mreitz@redhat.com, f4bug@amsat.org, armbru@redhat.com
Message-ID: <a0a70f94-54a4-737e-cd17-478ff2ba854c@redhat.com>
Subject: Re: [PATCH v2 09/10] qmp.py: Avoid overriding a builtin object
References: <20170725150951.16038-1-ldoktor@redhat.com>
 <20170725150951.16038-10-ldoktor@redhat.com>
 <20170725193442.GS2757@localhost.localdomain>
In-Reply-To: <20170725193442.GS2757@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Dne 25.7.2017 v 21:34 Eduardo Habkost napsal(a):
> On Tue, Jul 25, 2017 at 05:09:50PM +0200, Luk=C3=A1=C5=A1 Doktor wrote:=

>> The "id" is a builtin method to get object's identity and should not b=
e
>> overridden. This might bring some issues in case someone was directly
>> calling "cmd(..., id=3Did)" but I haven't found such usage on brief se=
arch
>> for "cmd\(.*id=3D".
>>
>> Signed-off-by: Luk=C3=A1=C5=A1 Doktor <ldoktor@redhat.com>
>=20
> I don't see the benefit of the patch, as the function is very
> short and unlikely to ever use the id() builtin.  But I am not
> against it if it will silence code analyzer warnings.
>=20
For me the biggest benefit is it decreases the probability of someone cop=
ying the same "idea" to other pieces of code, because, you know, develope=
rs are using copy&paste way too often.

Anyway pylint does complain about this issue. I can either ignore it, ski=
p it with an informative comment `# use id for backward compatibility pyl=
int: disable=3DW0622` or use this patch to fix it properly. I'm inclined =
towards fixing it (until it poisons other parts of the code), you are in =
favor of ignoring it, so let's see whether someone else has another opini=
on, otherwise I'll remove it in v3.

Luk=C3=A1=C5=A1

>=20
>> ---
>>  scripts/qmp/qmp.py | 8 ++++----
>>  1 file changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/scripts/qmp/qmp.py b/scripts/qmp/qmp.py
>> index f2f5a9b..ef12e8a 100644
>> --- a/scripts/qmp/qmp.py
>> +++ b/scripts/qmp/qmp.py
>> @@ -177,19 +177,19 @@ class QEMUMonitorProtocol(object):
>>              print >>sys.stderr, "QMP:<<< %s" % resp
>>          return resp
>> =20
>> -    def cmd(self, name, args=3DNone, id=3DNone):
>> +    def cmd(self, name, args=3DNone, cmd_id=3DNone):
>>          """
>>          Build a QMP command and send it to the QMP Monitor.
>> =20
>>          @param name: command name (string)
>>          @param args: command arguments (dict)
>> -        @param id: command id (dict, list, string or int)
>> +        @param cmd_id: command id (dict, list, string or int)
>>          """
>>          qmp_cmd =3D {'execute': name}
>>          if args:
>>              qmp_cmd['arguments'] =3D args
>> -        if id:
>> -            qmp_cmd['id'] =3D id
>> +        if cmd_id:
>> +            qmp_cmd['id'] =3D cmd_id
>>          return self.cmd_obj(qmp_cmd)
>> =20
>>      def command(self, cmd, **kwds):
>> --=20
>> 2.9.4
>>
>=20



--SQWF9VGVCLBGpDM8rhbT8SdeNFx3aRGLI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEwBAEBCAAaBQJZeB6mExxsZG9rdG9yQHJlZGhhdC5jb20ACgkQJrNi5H/PIsFY
hAgAqI9cgWJrikVlvR4ArvmmJa1BGzh2sLFLnEzSO/9x2wzFHCx7RBnnaRv3T923
DTDSWWr8WHkuYSyKAQK7KwQEZHtGNVD95jOkvNMMgDcJwefp9PNsG5VyLBsiU3AY
YAa5Nc8vaFu3Jpj4HJ+RX6a6nSy+jPFMF9WPOhHFMnscBdyA6Vj6+tEYwqQrchfC
eBIZmTZP1+a3ZlmNgWVFTsovVEBql5HIXPiETEyfsoqIQG2Fb7SsEsmEyfwxgmxy
Qu9dCemoPGMlgeFyrhS3nCpx297LVayZJJPKYONwJhMVIepGB2faA92gA/GX97xY
ELnVIe3TrNjDZzHSWGZwTffJzA==
=83cM
-----END PGP SIGNATURE-----

--SQWF9VGVCLBGpDM8rhbT8SdeNFx3aRGLI--
