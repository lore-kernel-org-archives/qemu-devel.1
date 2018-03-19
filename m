Received: from eggs.gnu.org ([2001:4830:134:3::10]:57927)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1exwao-0001h6-S1
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 11:21:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1exwal-0007ov-Mq
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 11:20:58 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36660 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1exwal-0007nm-HQ
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 11:20:55 -0400
References: <CAFEAcA9u3s=qZWN0Q1irqNu8cpHvBf2p4MsstaAaq-nbNLq1_A@mail.gmail.com>
	<20180319112032.GC3151@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <c9ded04a-5729-984f-b98b-969d10018419@redhat.com>
Date: Mon, 19 Mar 2018 10:20:44 -0500
MIME-Version: 1.0
In-Reply-To: <20180319112032.GC3151@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] qapi escape-too-big test doesn't work if LANG=C ?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "=?UTF-8?Q?Daniel_P._Berrang=c3=a9?=" <berrange@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Markus Armbruster <armbru@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>

On 03/19/2018 06:20 AM, Daniel P. Berrang=C3=A9 wrote:
> On Mon, Mar 19, 2018 at 10:37:12AM +0000, Peter Maydell wrote:
>> I recently tweaked my build scripts to run with LANG=3DC (trying
>> to suppress gcc's irritating habit of using smartquotes rather
>> than plain old ''). This seems to result in an error running
>> the qapi-schema/escape-too-big test:
>>
>> PYTHONPATH=3D/home/petmay01/linaro/qemu-for-merges/scripts python3 -B
>> /home/petmay01/linaro/qemu-for-merges/tests/qapi-schema/test-qapi.py
>> /home/petmay01/linaro/qemu-for-merges/tests/qapi-schema/escape-too-big=
.json
>>> tests/qapi-schema/escape-too-big.test.out
>> 2>tests/qapi-schema/escape-too-big.test.err; echo $?
>>> tests/qapi-schema/escape-too-big.test.exit
>> 1c1,10
>> < tests/qapi-schema/escape-too-big.json:3:14: For now, \u escape only
>> supports non-zero values up to \u007f
>> ---
>>> Traceback (most recent call last):
>>>    File "tests/qapi-schema/test-qapi.py", line 64, in <module>
>>>      schema =3D QAPISchema(sys.argv[1])
>>>    File "scripts/qapi/common.py", line 1492, in __init__
>>>      parser =3D QAPISchemaParser(open(fname, 'r'))
>>>    File "scripts/qapi/common.py", line 264, in __init__
>>>      self.src =3D fp.read()
>>>    File "/usr/lib/python3.5/encodings/ascii.py", line 26, in decode
>>>      return codecs.ascii_decode(input, self.errors)[0]
>>> UnicodeDecodeError: 'ascii' codec can't decode byte 0xc3 in position =
61: ordinal not in range(128)
>> /home/petmay01/linaro/qemu-for-merges/tests/Makefile.include:927:
>> recipe for target 'check-tests/qapi-schema/escape-too-big.json' failed
>=20
> So your "C" locale will be non-UTF-8, except on OS-X where the "C" loca=
le
> is UTF-8 by default.
>=20
> Unfortunately while POSIX expects the "C" locale to be 8-bit cleanup,
> Python by default will reject any characters outside the 7-bit range
> with its "ascii" codec. So this is ultimately a python bug, but there's
> little we can do about that given how widely deployed the bug is.

Yep, the bug is in python.  And we've already worked around it elsewhere=20
in qemu; see commit d4e5ec877.

>=20
> To workaround this problem in other applications what I have done is
> add the following to Makefiles before invoking python:
>=20
>      LC_ALL=3D LANG=3DC LC_CTYPE=3Den_US.UTF-8
>=20
> The LC_ALL=3D bit is needed because if the user has set LC_ALL themselv=
es
> it will override LANG and all other LC_* variables. Setting LANG=3DC is
> not strictly needed, as LC_CTYPE will override it.
>=20
> CC'ing Eric since he was involved in the discussions about this bug
> in other libvirt related apps.

So the question is how to fix the test to not trip the python bugs.  And=20
the only non-7-bit-clean byte in that file is in a comment, so maybe the=20
simplest stupid thing that would work for now is to rewrite the comment=20
to drop the =C3=A9 and instead use pure ASCII.  A nicer fix would be teac=
hing=20
scripts/qapi/common.py to read input in an 8-bit-clean manner regardless=20
of locale, but that's more invasive (and I'd rather have Markus' help on=20
that front), so for 2.12, I'll just do the obvious bug fix of avoiding=20
the problem by skipping the unfortunate comment.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
