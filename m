Received: from eggs.gnu.org ([2001:4830:134:3::10]:35355)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ldoktor@redhat.com>) id 1dxVCm-0003vy-VC
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 05:34:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ldoktor@redhat.com>) id 1dxVCm-0001Z0-21
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 05:34:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53792)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ldoktor@redhat.com>) id 1dxVCl-0001Yk-OA
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 05:34:03 -0400
References: <20170927130339.21444-1-ehabkost@redhat.com>
	<20170927130339.21444-5-ehabkost@redhat.com>
	<20170927133321.GB8521@lemon.lan>
	<20170927134431.GN21016@localhost.localdomain>
From: =?UTF-8?B?THVrw6HFoSBEb2t0b3I=?= <ldoktor@redhat.com>
Message-ID: <7b84fb9c-9969-c9d5-8ede-2d54c3825ea6@redhat.com>
Date: Thu, 28 Sep 2017 11:33:57 +0200
MIME-Version: 1.0
In-Reply-To: <20170927134431.GN21016@localhost.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="KDl3ccndaw73K8T2u4aSv5LareC2XcbTI"
Subject: Re: [Qemu-devel] [PATCH] fixup! scripts: Remove debug parameter
 from QEMUMonitorProtocol
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>, Fam Zheng <famz@redhat.com>
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org, Cleber Rosa <crosa@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--KDl3ccndaw73K8T2u4aSv5LareC2XcbTI
From: =?UTF-8?B?THVrw6HFoSBEb2t0b3I=?= <ldoktor@redhat.com>
To: Eduardo Habkost <ehabkost@redhat.com>, Fam Zheng <famz@redhat.com>
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org, Cleber Rosa <crosa@redhat.com>
Message-ID: <7b84fb9c-9969-c9d5-8ede-2d54c3825ea6@redhat.com>
Subject: Re: [PATCH] fixup! scripts: Remove debug parameter from
 QEMUMonitorProtocol
References: <20170927130339.21444-1-ehabkost@redhat.com>
 <20170927130339.21444-5-ehabkost@redhat.com>
 <20170927133321.GB8521@lemon.lan>
 <20170927134431.GN21016@localhost.localdomain>
In-Reply-To: <20170927134431.GN21016@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Dne 27.9.2017 v 15:44 Eduardo Habkost napsal(a):
> On Wed, Sep 27, 2017 at 09:33:21PM +0800, Fam Zheng wrote:
>> On Wed, 09/27 10:03, Eduardo Habkost wrote:
>>> @@ -51,7 +54,6 @@ class QEMUMonitorProtocol(object):
>>>          """
>>>          self.__events =3D []
>>>          self.__address =3D address
>>> -        self._debug =3D debug
>>
>> Should you also drop the debug parameter from the method?
>>
>>>          self.__sock =3D self.__get_sock()
>>>          self.__sockfile =3D None
>>>          if server:
>>> @@ -83,8 +85,7 @@ class QEMUMonitorProtocol(object):
>>>                  return
>>>              resp =3D json.loads(data)
>>>              if 'event' in resp:
>>> -                if self._debug:
>>> -                    print >>sys.stderr, "QMP:<<< %s" % resp

This is the only user of `sys` import, please remove it as well. Apart fr=
om this it looks good, although you might consider using `__name__` inste=
ad of hardcoded `QMP` in `logger =3D logging.getLogger(__name__)` for the=
 sake of consistency (people might expect it to correlate with the module=
 name).

Luk=C3=A1=C5=A1

>>> +                self.logger.debug("<<< %s", resp)
>>>                  self.__events.append(resp)
>>>                  if not only_event:
>>>                      continue
>>> @@ -164,8 +165,7 @@ class QEMUMonitorProtocol(object):
>>>          @return QMP response as a Python dict or None if the connect=
ion has
>>>                  been closed
>>>          """
>>> -        if self._debug:
>>> -            print >>sys.stderr, "QMP:>>> %s" % qmp_cmd
>>> +        self.logger.debug("<<< %s", qmp_cmd)
>>
>> This should be ">>> %s".
>>
>=20
> Fixed.
>=20
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> ---
>  scripts/qmp/qmp.py | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/scripts/qmp/qmp.py b/scripts/qmp/qmp.py
> index be79d7aa80..369d9fef39 100644
> --- a/scripts/qmp/qmp.py
> +++ b/scripts/qmp/qmp.py
> @@ -40,7 +40,7 @@ class QEMUMonitorProtocol(object):
>      #: Socket's timeout
>      timeout =3D socket.timeout
> =20
> -    def __init__(self, address, server=3DFalse, debug=3DFalse):
> +    def __init__(self, address, server=3DFalse):
>          """
>          Create a QEMUMonitorProtocol class.
> =20
> @@ -165,7 +165,7 @@ class QEMUMonitorProtocol(object):
>          @return QMP response as a Python dict or None if the connectio=
n has
>                  been closed
>          """
> -        self.logger.debug("<<< %s", qmp_cmd)
> +        self.logger.debug(">>> %s", qmp_cmd)
>          try:
>              self.__sock.sendall(json.dumps(qmp_cmd))
>          except socket.error as err:
>=20



--KDl3ccndaw73K8T2u4aSv5LareC2XcbTI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEwBAEBCAAaBQJZzMIFExxsZG9rdG9yQHJlZGhhdC5jb20ACgkQJrNi5H/PIsGN
RggAsGVC8jpLzmDtHSG//ahkrrsL1dfgTTdmg+8eaA2U1SgSf3XSolBkKyutQ8r4
LdVrTsW3kIIaWR/YSJ5eYgCaW7t+ffI0e1ji1B9LWbpaRrGfeYRERf+o92K5dbVG
RhWr9yNpooRj8C5q3Zq6dFgBa6G2bHSXn/6CX24tnJZfF08uanhWBglJ4cW76QgH
i0TxpLtqeGQ32/s7l4fLthE6jIwCWAH5hsHnGtdRJIJdOVy5b9xEAay8eq2tqmR2
dn0WEGocYd1woFj9KsuYDeOHqjePS/6bx98x80kVOLo6rVIH+jz+z5kGy265eILG
wa9u78E9UlJIO+9CrGefN+MVhQ==
=q209
-----END PGP SIGNATURE-----

--KDl3ccndaw73K8T2u4aSv5LareC2XcbTI--
