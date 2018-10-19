Received: from eggs.gnu.org ([2001:4830:134:3::10]:34668)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gDRAV-0003z3-M7
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 05:34:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gDRAT-0005HC-V4
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 05:34:07 -0400
References: <20181015141453.32632-1-mreitz@redhat.com>
	<20181015141453.32632-10-mreitz@redhat.com>
	<20181015222638.GH31060@habkost.net>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <5682ded4-8fd8-76c9-8e1c-0c797fb267ef@redhat.com>
Date: Fri, 19 Oct 2018 11:33:54 +0200
MIME-Version: 1.0
In-Reply-To: <20181015222638.GH31060@habkost.net>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="EX8eFGJrSEKJTkBLld754v2L58Wwy0Txz"
Subject: Re: [Qemu-devel] [PATCH 9/9] iotests: Unify log outputs between
 Python 2 and 3
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Cleber Rosa <crosa@redhat.com>, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--EX8eFGJrSEKJTkBLld754v2L58Wwy0Txz
From: Max Reitz <mreitz@redhat.com>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Cleber Rosa <crosa@redhat.com>, qemu-devel@nongnu.org
Message-ID: <5682ded4-8fd8-76c9-8e1c-0c797fb267ef@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 9/9] iotests: Unify log outputs between
 Python 2 and 3
References: <20181015141453.32632-1-mreitz@redhat.com>
 <20181015141453.32632-10-mreitz@redhat.com>
 <20181015222638.GH31060@habkost.net>
In-Reply-To: <20181015222638.GH31060@habkost.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 16.10.18 00:26, Eduardo Habkost wrote:
> On Mon, Oct 15, 2018 at 04:14:53PM +0200, Max Reitz wrote:
>> When dumping an object into the log, there are differences between
>> Python 2 and 3.  First, unicode strings are prefixed by 'u' in Python =
2
>> (they are no longer in 3, because unicode strings are the default
>> there).  [...]
>=20
> This could be addressed using JSON.  See below[1].
>=20
>> [...] Second, the order of keys in dicts may differ.  [...]
>=20
> Can be addressed using json.dumps(..., sort_keys=3DTrue).

Ah.  Nice. :-)

>> [...] Third,
>> especially long numbers are longs in Python 2 and thus get an 'L'
>> suffix, which does not happen in Python 3.
>=20
> print() doesn't add a L suffix on Python 2.7 on my system:
>=20
> Python 2.7.15 (default, May 15 2018, 15:37:31)
> [GCC 7.3.1 20180303 (Red Hat 7.3.1-5)] on linux2
> Type "help", "copyright", "credits" or "license" for more information.
>>>> print(99999999999999999999999999999999999999999999999999999999999999=
999999999999999999999L)
> 99999999999999999999999999999999999999999999999999999999999999999999999=
999999999999
>=20
> So I assume this happens only for QMP commands.

It happens for dicts:

>>> print 99999999999999999999L
99999999999999999999
>>> print {'foo':99999999999999999999L}
{'foo': 99999999999999999999L}

> It would be addressed if using JSON, too.

OK.

>> To get around these differences, this patch introduces functions to
>> convert an object to a string that looks the same regardless of the
>> Python version: In Python 2, they decode unicode strings to byte strin=
gs
>> (normal str); in Python 3, they encode byte strings to unicode strings=

>> (normal str).  They also manually convert lists and dicts to strings,
>> which allows sorting the dicts by key, so we are no longer at the merc=
y
>> of the internal implementation when it comes to how the keys appear in=

>> the output.
>>
>> This changes the output of all tests that use these logging functions.=

>>
>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>> ---
>>  tests/qemu-iotests/194.out    |  22 +-
>>  tests/qemu-iotests/202.out    |  12 +-
>>  tests/qemu-iotests/203.out    |  14 +-
>>  tests/qemu-iotests/206.out    | 144 +++++-----
>>  tests/qemu-iotests/207.out    |  52 ++--
>>  tests/qemu-iotests/208.out    |   8 +-
>>  tests/qemu-iotests/210.out    |  72 ++---
>>  tests/qemu-iotests/211.out    |  66 ++---
>>  tests/qemu-iotests/212.out    | 102 +++----
>>  tests/qemu-iotests/213.out    | 124 ++++----
>>  tests/qemu-iotests/216.out    |   4 +-
>>  tests/qemu-iotests/218.out    |  20 +-
>>  tests/qemu-iotests/219.out    | 526 +++++++++++++++++----------------=
-
>>  tests/qemu-iotests/222.out    |  24 +-
>>  tests/qemu-iotests/iotests.py |  42 ++-
>>  15 files changed, 634 insertions(+), 598 deletions(-)
> [...]
>> diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotest=
s.py
>> index a64ea90fb4..f8dbc8cc71 100644
>> --- a/tests/qemu-iotests/iotests.py
>> +++ b/tests/qemu-iotests/iotests.py
>> @@ -250,10 +250,45 @@ def filter_img_info(output, filename):
>>          lines.append(line)
>>      return '\n'.join(lines)
>> =20
>> +def log_to_string_repr(obj):
>> +    # Normal Python 3 strings are the unicode strings from Python 2;
>> +    # and normal Python 2 strings are byte strings in Python 3.  Thus=
,
>> +    # we convert bytes -> str in py3 and unicode -> str in py2.
>> +    if sys.version_info.major >=3D 3:
>> +        if type(obj) is bytes:
>> +            return repr(obj.decode('utf-8'))
>> +    else:
>> +        if type(obj) is unicode:
>> +            return repr(obj.encode('utf-8'))
>> +        elif type(obj) is long:
>> +            return str(obj) # repr() would include an 'L' suffix
>> +
>> +    if type(obj) is list:
>> +        return '[' + ', '.join(map(log_to_string_repr, obj)) + ']'
>> +    elif type(obj) is dict:
>> +        return '{' + ', '.join(map(lambda k: log_to_string_repr(k) + =
': ' +
>> +                                             log_to_string_repr(obj[k=
]),
>> +                                   sorted(obj.keys()))) + '}'
>> +    else:
>> +        return repr(obj)
>=20
> I assume this function exists only because of QMP logging,
> correct?

In practice probably yes.

> I would just use json.dumps() at qmp_log(), see below[1].

However, there is not just qmp_log(), there are places that dump objects
directly into log().

>> +
>> +def log_to_string(obj):
>> +    if type(obj) is str:
>> +        return obj
>> +
>> +    if sys.version_info.major >=3D 3:
>> +        if type(obj) is bytes:
>> +            return obj.decode('utf-8')
>=20
> Do you know how many of existing log() calls actually pass a byte
> string as argument?

Frankly I hope none.

>> +    else:
>> +        if type(obj) is unicode:
>> +            return obj.encode('utf-8')
>=20
> Is this really necessary?  The existing code just calls
> print(msg) and it works, doesn't it?

True.  But the main issue is that we still need to return immediately
for byte strings and Unicode strings, but the type "bytes" only exists
in 3.x and "unicode" only exists in 2.x, i.e. "if type(obj) is unicode"
throws an exception in 3.x.

So I have to distinguish between 2.x and 3.x anyway, and I thought to
myself that if I distinguished anyway, I might do the conversion to the
native type at the same time.

>> +
>> +    return log_to_string_repr(obj)
>> +
>>  def log(msg, filters=3D[]):
>>      for flt in filters:
>>          msg =3D flt(msg)
>> -    print(msg)
>> +    print(log_to_string(msg))
>> =20
>>  class Timeout:
>>      def __init__(self, seconds, errmsg =3D "Timeout"):
>> @@ -441,10 +476,11 @@ class VM(qtest.QEMUQtestMachine):
>>          return result
>> =20
>>      def qmp_log(self, cmd, filters=3D[filter_testfiles], **kwargs):
>> -        logmsg =3D "{'execute': '%s', 'arguments': %s}" % (cmd, kwarg=
s)
>> +        logmsg =3D "{'execute': '%s', 'arguments': %s}" % \
>> +            (cmd, log_to_string(kwargs))
>>          log(logmsg, filters)
>>          result =3D self.qmp(cmd, **kwargs)
>> -        log(str(result), filters)
>> +        log(log_to_string(result), filters)
>=20
> [1]
>=20
> If we're being forced to regenerate all the QMP output in the
> .out files, what about always using JSON instead of the hack at
> log_to_string_repr()?  i.e.:
>=20
> diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests=
=2Epy
> index a64ea90fb4..0b28dc2a65 100644
> --- a/tests/qemu-iotests/iotests.py
> +++ b/tests/qemu-iotests/iotests.py
> @@ -441,10 +441,12 @@ class VM(qtest.QEMUQtestMachine):
>          return result
> =20
>      def qmp_log(self, cmd, filters=3D[filter_testfiles], **kwargs):
> -        logmsg =3D "{'execute': '%s', 'arguments': %s}" % (cmd, kwargs=
)
> +        logmsg =3D '{"execute": %s, "arguments": %s}' % \
> +                 (json.dumps(cmd, sort_keys=3DTrue),
> +                  json.dumps(kwargs, sort_keys=3DTrue))
>          log(logmsg, filters)
>          result =3D self.qmp(cmd, **kwargs)
> -        log(str(result), filters)
> +        log(json.dumps(result, sort_keys=3DTrue), filters)
>          return result

Sure, sounds good, thanks. :-)

The only thing is I would allow log() to still accept objects, it should
do the conversion to JSON itself (if the object to be logged is a list
or dict).

Max

>      def run_job(self, job, auto_finalize=3DTrue, auto_dismiss=3DFalse)=
:
>=20
>>          return result
>> =20
>>      def run_job(self, job, auto_finalize=3DTrue, auto_dismiss=3DFalse=
):
>> --=20
>> 2.17.1
>>
>>
>=20



--EX8eFGJrSEKJTkBLld754v2L58Wwy0Txz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlvJpQIACgkQ9AfbAGHV
z0D6BAf/V5bJi8ztEmD9GfsEztVO2y3shV/+ShYqvBmiASrVWv+jHP09HmZ8Lvkz
xK2IoTbTcevjbPfLR/0pF7Ti2E/KW5CKOiDX3Yi0vQmBnmkyY1SIYn8lw34uVhTK
P705Q+kDUYl/247SjIH4yfSmsHXQ+ggIGX51hAU2CIg8//nfy98nJ7GwDm/bEWuA
gXRLLHPjPtJptIBHwnT5FgRBiQBHU0l7BMNQynJOF7ZxjiopWkzgzeR21fx3gXMP
vdEWnF7axnX/J0wly0DiVtalC+aufFb5XJ15unfMlqOSOVm+CK3gpYW6ivfJ+/gp
dX++eBUGPgbbe1RVvHX/qvcfBo16ow==
=zNa7
-----END PGP SIGNATURE-----

--EX8eFGJrSEKJTkBLld754v2L58Wwy0Txz--
