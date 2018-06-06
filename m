Received: from eggs.gnu.org ([2001:4830:134:3::10]:40392)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fQboK-0007Zl-LU
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 13:01:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fQboH-0007Bl-CI
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 13:01:24 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:49906 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1fQboH-0007BK-6f
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 13:01:21 -0400
Date: Wed, 6 Jun 2018 18:01:17 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180606170117.GN3064@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20180606165319.27056-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180606165319.27056-1-f4bug@amsat.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH] qmp.py: Fix exception parsing partial
 JSON
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Cc: Eduardo Habkost <ehabkost@redhat.com>, Cleber Rosa <crosa@redhat.com>, Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org, =?utf-8?B?THVrw6HFoQ==?= Doktor <ldoktor@redhat.com>

On Wed, Jun 06, 2018 at 01:53:19PM -0300, Philippe Mathieu-Daud=C3=A9 wro=
te:
> The readline() call returns partial data.
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
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
> Daniel suggested this is due to blocking i/o.
>=20
> I'm sure there is a nicer/more pythonic way to do this, but this works =
for me,
> sorry :)
>=20
>  scripts/qmp/qmp.py | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
>=20
> diff --git a/scripts/qmp/qmp.py b/scripts/qmp/qmp.py
> index 5c8cf6a056..e8b55dfcc4 100644
> --- a/scripts/qmp/qmp.py
> +++ b/scripts/qmp/qmp.py
> @@ -78,11 +78,16 @@ class QEMUMonitorProtocol(object):
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
> +                continue

Downside is that we'll blindly loop if QEMU ever sends
malformed data, but given the use context of this QMP
shell that's not too serious.

>              if 'event' in resp:
>                  self.logger.debug("<<< %s", resp)
>                  self.__events.append(resp)

If we get an event, we'll continue on the loop and append
to 'data' again, so you must blank out data to "" after
json.loads() succeeeds.


Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
