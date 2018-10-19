Received: from eggs.gnu.org ([2001:4830:134:3::10]:37753)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gDQP2-0007EH-8E
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 04:45:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gDQP1-0007OH-7p
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 04:45:04 -0400
References: <20181015141453.32632-1-mreitz@redhat.com>
	<20181015141453.32632-9-mreitz@redhat.com>
	<a797c85a-97c8-37c8-2a39-7ce33478a425@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <a55e1a03-0a0b-74c7-ac6b-cf8ec24f626a@redhat.com>
Date: Fri, 19 Oct 2018 10:44:52 +0200
MIME-Version: 1.0
In-Reply-To: <a797c85a-97c8-37c8-2a39-7ce33478a425@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="r8SuXAcoMtVirpDDOWLggHy0qMQXZlfOy"
Subject: Re: [Qemu-devel] [PATCH 8/9] iotests: Modify imports for Python 3
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cleber Rosa <crosa@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--r8SuXAcoMtVirpDDOWLggHy0qMQXZlfOy
From: Max Reitz <mreitz@redhat.com>
To: Cleber Rosa <crosa@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <a55e1a03-0a0b-74c7-ac6b-cf8ec24f626a@redhat.com>
Subject: Re: [PATCH 8/9] iotests: Modify imports for Python 3
References: <20181015141453.32632-1-mreitz@redhat.com>
 <20181015141453.32632-9-mreitz@redhat.com>
 <a797c85a-97c8-37c8-2a39-7ce33478a425@redhat.com>
In-Reply-To: <a797c85a-97c8-37c8-2a39-7ce33478a425@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 15.10.18 20:59, Cleber Rosa wrote:
>=20
>=20
> On 10/15/18 10:14 AM, Max Reitz wrote:
>> There are two imports that need to be modified when running the iotest=
s
>> under Python 3: One is StringIO, which no longer exists; instead, the
>> StringIO class comes from the io module, so import it from there.  The=

>> other is the ConfigParser, which has just been renamed to configparser=
=2E
>>
>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>> ---
>>  tests/qemu-iotests/iotests.py            | 8 ++++++--
>>  tests/qemu-iotests/nbd-fault-injector.py | 7 +++++--
>>  2 files changed, 11 insertions(+), 4 deletions(-)
>>
>> diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotest=
s.py
>> index 7ca94e9278..a64ea90fb4 100644
>> --- a/tests/qemu-iotests/iotests.py
>> +++ b/tests/qemu-iotests/iotests.py
>> @@ -683,13 +683,17 @@ def main(supported_fmts=3D[], supported_oses=3D[=
'linux'], supported_cache_modes=3D[],
>> =20
>>      # We need to filter out the time taken from the output so that qe=
mu-iotest
>>      # can reliably diff the results against master output.
>> -    import StringIO
>> +    if sys.version_info.major >=3D 3:
>> +        from io import StringIO
>> +    else:
>> +        from StringIO import StringIO
>> +
>>      if debug:
>>          output =3D sys.stdout
>>          verbosity =3D 2
>>          sys.argv.remove('-d')
>>      else:
>> -        output =3D StringIO.StringIO()
>> +        output =3D StringIO()
>> =20
>>      logging.basicConfig(level=3D(logging.DEBUG if debug else logging.=
WARN))
>> =20
>> diff --git a/tests/qemu-iotests/nbd-fault-injector.py b/tests/qemu-iot=
ests/nbd-fault-injector.py
>> index d45e2e0a6a..6b2d659dee 100755
>> --- a/tests/qemu-iotests/nbd-fault-injector.py
>> +++ b/tests/qemu-iotests/nbd-fault-injector.py
>> @@ -48,7 +48,10 @@ import sys
>>  import socket
>>  import struct
>>  import collections
>> -import ConfigParser
>> +if sys.version_info.major >=3D 3:
>> +    import configparser
>> +else:
>> +    import ConfigParser as configparser
>> =20
>>  FAKE_DISK_SIZE =3D 8 * 1024 * 1024 * 1024 # 8 GB
>> =20
>> @@ -225,7 +228,7 @@ def parse_config(config):
>>      return rules
>> =20
>>  def load_rules(filename):
>> -    config =3D ConfigParser.RawConfigParser()
>> +    config =3D configparser.RawConfigParser()
>>      with open(filename, 'rt') as f:
>>          config.readfp(f, filename)
>>      return parse_config(config)
>>
>=20
> This may be a type of culture clash (on my side, due to not enough QEMU=

> culture), but shouldn't this be applied before anything else on this se=
ries?
>=20
> I mean, PATCH 1/9 is supposed to fix the reliability aspects of
> nbd-fault-injector under Python 3, but without this patch, it won't
> actually run on Python 3.

I don't mind, I followed no specific order.  Well, patch 9 is patch 9
because it is the largest one, so I didn't want to discourage people
before the end of the series. :-)

Max


--r8SuXAcoMtVirpDDOWLggHy0qMQXZlfOy
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlvJmYQACgkQ9AfbAGHV
z0DJSQgAoAivajK27GJ5kQPcGSdREcsQE3eMsqBm53TY8kgSyNX+lgULGhraWjRY
tOAD9SHkZnucZuVCLFxS1IfD91+shL0VoRSvqc7PKIzHqw9AmhNjs7CdUAsyg5X+
GezZ68X3gaVh5QRnWy77JJxvLZVd9P6M5KoABNDehyroo+AG7lPTuKVjfkjyYcnR
FncYau0n5sGG3rJOcOH0l6n1uXBe05KD6d6chclBtK4BuiyPj4vFmUZIvuY39LpX
OqdcaOah+VTDherjU3LV9yU19LGk1inTOzkrz0SCyh68VpW2EpH5zxTp9EC13X2S
830OuWVA5wAt5Kt8G3/q9yhEV+XMDg==
=7WPu
-----END PGP SIGNATURE-----

--r8SuXAcoMtVirpDDOWLggHy0qMQXZlfOy--
