Received: from eggs.gnu.org ([2001:4830:134:3::10]:50772)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fQegK-0006Na-3P
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 16:05:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fQegG-0006Up-Sk
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 16:05:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43300)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1fQegG-0006UA-FY
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 16:05:16 -0400
Date: Wed, 6 Jun 2018 17:05:13 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180606200513.GY7451@localhost.localdomain>
References: <20180606192731.6910-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20180606192731.6910-1-f4bug@amsat.org>
Content-Transfer-Encoding: quoted-printable
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
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>
Cc: Cleber Rosa <crosa@redhat.com>, Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org, =?utf-8?B?THVrw6HFoQ==?= Doktor <ldoktor@redhat.com>, Daniel P =?iso-8859-1?Q?=2E_Berrang=E9?= <berrange@redhat.com>

On Wed, Jun 06, 2018 at 04:27:31PM -0300, Philippe Mathieu-Daud=E9 wrote:
> The readline() call returns partial data.

How can this be reproduced?  Despite not being forbidden by the
QMP specification, QEMU normally doesn't break QMP replies in
multiple lines, and readline() is not supposed to return a
partial line unless it encounters EOF.


> Keep appending until the JSON buffer is complete.
>=20
> This fixes:
>=20
>     $ scripts/qmp/qmp-shell -v -p /tmp/qmp.sock
>     Traceback (most recent call last):
>       File "scripts/qmp/qmp-shell", line 456, in <module>
>         main()
>       File "scripts/qmp/qmp-shell", line 441, in main
>         qemu.connect(negotiate)
>       File "scripts/qmp/qmp-shell", line 284, in connect
>         self._greeting =3D super(QMPShell, self).connect(negotiate)
>       File "scripts/qmp/qmp.py", line 143, in connect
>         return self.__negotiate_capabilities()
>       File "scripts/qmp/qmp.py", line 71, in __negotiate_capabilities
>         greeting =3D self.__json_read()
>       File "scripts/qmp/qmp.py", line 85, in __json_read
>         resp =3D json.loads(data)
>       File "/usr/lib/python2.7/json/__init__.py", line 339, in loads
>         return _default_decoder.decode(s)
>       File "/usr/lib/python2.7/json/decoder.py", line 364, in decode
>         obj, end =3D self.raw_decode(s, idx=3D_w(s, 0).end())
>       File "/usr/lib/python2.7/json/decoder.py", line 380, in raw_decod=
e
>         obj, end =3D self.scan_once(s, idx)
>     ValueError: Expecting object: line 1 column 3 (char 2)
>=20
> Signed-off-by: Philippe Mathieu-Daud=E9 <f4bug@amsat.org>
> ---
> Since v1:
> - addressed Daniel review: clean data after json.loads() succeeds
> - add a XXX comment
>=20
> Daniel suggested this is due to blocking i/o.
>=20
> I'm sure there is a nicer/more pythonic way to do this, but this works =
for me,
> sorry :)

It looks like there's no elegant solution for this:
https://stackoverflow.com/a/21709058

>=20
>  scripts/qmp/qmp.py | 13 ++++++++++---
>  1 file changed, 10 insertions(+), 3 deletions(-)
>=20
> diff --git a/scripts/qmp/qmp.py b/scripts/qmp/qmp.py
> index 5c8cf6a056..14f0b48936 100644
> --- a/scripts/qmp/qmp.py
> +++ b/scripts/qmp/qmp.py
> @@ -78,11 +78,18 @@ class QEMUMonitorProtocol(object):
>          raise QMPCapabilitiesError
> =20
>      def __json_read(self, only_event=3DFalse):
> +        data =3D ""
>          while True:
> -            data =3D self.__sockfile.readline()
> -            if not data:
> +            tmp =3D self.__sockfile.readline()
> +            if not tmp:
>                  return
> -            resp =3D json.loads(data)
> +            data +=3D tmp
> +            try:
> +                resp =3D json.loads(data)
> +            except ValueError:
> +                # XXX: blindly loop, even if QEMU ever sends malformed=
 data
> +                continue

I was going to suggest using json.JSONDecoder.raw_decode() and
saving the remaining data in case we already read partial data
for a second JSON message.

But the QMP specification says all messages are terminated with
CRLF, so we we should never see the data for two different
messages in a single readline() call.  Noting this in a comment
wouldn't hurt, though.

The patch seems reasonable, but first I would like to understand
how this bug can be triggered.

> +            data =3D ""
>              if 'event' in resp:
>                  self.logger.debug("<<< %s", resp)
>                  self.__events.append(resp)
> --=20
> 2.17.1
>=20

--=20
Eduardo
