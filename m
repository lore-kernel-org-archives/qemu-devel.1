Received: from eggs.gnu.org ([2001:4830:134:3::10]:55177)
	by lists.gnu.org with esmtp (Exim 4.71) (envelope-from <n54@gmx.com>)
	id 1dqhWp-0005hp-1l
	for qemu-devel@nongnu.org; Sat, 09 Sep 2017 11:18:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <n54@gmx.com>) id 1dqhWl-0003ma-11
	for qemu-devel@nongnu.org; Sat, 09 Sep 2017 11:18:39 -0400
Received: from mout.gmx.net ([212.227.17.21]:56778)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <n54@gmx.com>) id 1dqhWk-0003m0-N5
	for qemu-devel@nongnu.org; Sat, 09 Sep 2017 11:18:34 -0400
References: <20170909054613.19148-1-famz@redhat.com>
	<20170909054613.19148-11-famz@redhat.com>
	<CAFEAcA83JDUMAsCAY=YBL+qS8A1n6VMfH1p_DAmouF0W8m-j9g@mail.gmail.com>
	<20170909150710.GA29670@lemon.lan>
From: Kamil Rytarowski <n54@gmx.com>
Message-ID: <4377bd37-3309-fe80-666f-f05626efe930@gmx.com>
Date: Sat, 9 Sep 2017 17:08:01 +0200
MIME-Version: 1.0
In-Reply-To: <20170909150710.GA29670@lemon.lan>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="dmVeCjcMVf8f46uhXs5c8JPSufsVm7Qtv"
Subject: Re: [Qemu-devel] [PULL v2 10/37] scripts: Add archive-source.sh
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--dmVeCjcMVf8f46uhXs5c8JPSufsVm7Qtv
From: Kamil Rytarowski <n54@gmx.com>
To: Fam Zheng <famz@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>
Message-ID: <4377bd37-3309-fe80-666f-f05626efe930@gmx.com>
Subject: Re: [Qemu-devel] [PULL v2 10/37] scripts: Add archive-source.sh
References: <20170909054613.19148-1-famz@redhat.com>
 <20170909054613.19148-11-famz@redhat.com>
 <CAFEAcA83JDUMAsCAY=YBL+qS8A1n6VMfH1p_DAmouF0W8m-j9g@mail.gmail.com>
 <20170909150710.GA29670@lemon.lan>
In-Reply-To: <20170909150710.GA29670@lemon.lan>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 09.09.2017 17:07, Fam Zheng wrote:
> On Sat, 09/09 13:07, Peter Maydell wrote:
>> On 9 September 2017 at 06:45, Fam Zheng <famz@redhat.com> wrote:
>>> Signed-off-by: Fam Zheng <famz@redhat.com>
>>> Message-Id: <20170905021201.25684-4-famz@redhat.com>
>>> ---
>>>  scripts/archive-source.sh | 31 +++++++++++++++++++++++++++++++
>>>  1 file changed, 31 insertions(+)
>>>  create mode 100755 scripts/archive-source.sh
>>>
>>> diff --git a/scripts/archive-source.sh b/scripts/archive-source.sh
>>> new file mode 100755
>>> index 0000000000..1de369532e
>>> --- /dev/null
>>> +++ b/scripts/archive-source.sh
>>> @@ -0,0 +1,31 @@
>>> +#!/bin/sh
>>> +#
>>> +# Author: Fam Zheng <famz@redhat.com>
>>> +#
>>> +# Create archive of source tree, including submodules
>>> +#
>>> +# This code is licensed under the GPL version 2 or later.  See
>>> +# the COPYING file in the top-level directory.
>>
>> So is this the script that for instance Mike Roth would use
>> to create the release tarballs? If it isn't, should it be?
>=20
> I don't know the workflow of release tarballs, there is ./scripts/make-=
release
> for that. So this one is not.
>=20
>> Is it intended for end users to create tarballs with, or
>> is it really just a helper script for the docker stuff?
>> If the latter, it would be helpful to say so. If the former,
>> it could really use more usage information/documentation...
>=20
> I'm not sure what end users would use this for, but it should do its wo=
rk just
> the same.. What kind of usage information do you suggest? More explaina=
tion in
> the header, or in the "usage" output when no target is specified, or a =
"-h"
> option for help?
>=20
>>
>>> +
>>> +set -e
>>> +
>>> +if test $# -lt 1; then
>>> +    echo "Usage: $0 <output>"
>>> +    exit 1
>>> +fi
>>> +
>>> +submodules=3D$(git submodule foreach --recursive --quiet 'echo $name=
')
>>> +
>>> +if test -n "$submodules"; then
>>> +    {
>>> +        git ls-files
>>> +        for sm in $submodules; do
>>> +            (cd $sm; git ls-files) | sed "s:^:$sm/:"
>>> +        done
>>> +    } | grep -x -v $(for sm in $submodules; do echo "-e $sm"; done) =
> $1.list
>>
>> Supporting '-e something' in a tar -T listfile seems to
>> be GNU tar specific. Do we care?
>=20
> The "-e $sm" will go to the grep command line, so it isn't GNU specific=
, is it?
>=20

BSD OSes use GNU grep(1) the latest version GPLv2. There is a work in
progress BSD grep(1), but not turned on by default as it's slower.

The -e option is supported by SmartOS grep(1).

>>
>>> +else
>>> +    git ls-files > $1.list
>>> +fi
>>
>> This will blow up if we ever have a file in the repo
>> that starts with a '-'. Do we care?
>=20
> I'm sure such a file will be a trouble, but I'd rather we deal with it =
when
> there is one: I don't think anyone will think about adding, or welcome =
such a
> file.
>=20
>>
>>> +
>>> +tar -cf $1 -T $1.list
>>> +rm $1.list
>>
>> This is missing a lot of quoting for $1, so it will go wrong
>> if there's a space in that filename argument.
>=20
> Yes, good point. I will fix it before sending another pull request alon=
g with
> other comments that are just raised.
>=20
> Fam
>=20



--dmVeCjcMVf8f46uhXs5c8JPSufsVm7Qtv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJABAEBCAAqFiEELaxVpweEzw+lMDwuS7MI6bAudmwFAlm0A9IMHG41NEBnbXgu
Y29tAAoJEEuzCOmwLnZsMY8P/i48gBLPgvELFHMeZ01hcntG73BDKtqtKIZY5wO6
2CkJe16O4jVJe+FoztUnK3DRXwI5Ase3p8+dHohTE3SQcvfqakWLPL1namWLGEZo
P5wc6aqXV2FEPVx6zmwPGcRnVfS6WRi10sUtNHig6Bkg4DHKSJv0BcDw1cQgKJuh
NXotakWmw/AZNNv6mnhK2+b1RbOQzhUzDK7TqSp9bKgkZnA4Fyi5ax4qeauT9kRJ
FUBw15sbm9W6CD165d7S4wgfgdAlMRLdbzf+4pI5gB1UtrDlm0Ve6R/IBE9sD5+B
nMHhzKvKlCxFgrQG2UT+W4yJcatV03lNn8Nlru+wFGq/EVnjvmsDZnu/CW9xk45t
6ZDEteC9e1MXciwjnD3egJyrVEmw53+Dx6pA10eoIK1qhP3TF06DttpDPx9Am5N0
/6tdXbKNOhOIvJJnvQuanaPXbfM9ou3npdS4i0Ik9rBvQiM6hnAtGvV7bCo8QOXZ
4jX5AQgNHV1ZUQ0HcVwyv3d7Kjs4ruTHrJEHHODoaKSvFsmEFBeYg4jkZyd8JX+0
tnTuZ6xqsXg+ZlAin1qQsfP7QLLSe2UCvg6fMCDb7jdctd9iItTVjJOZsGnU2VL7
Lq8GaTEa4Vba7nUYX+cskbirE/HDVaoN+5LwJm2A/K0Jar0msPQxu2nqpSbvxe3c
093d
=JL5x
-----END PGP SIGNATURE-----

--dmVeCjcMVf8f46uhXs5c8JPSufsVm7Qtv--
