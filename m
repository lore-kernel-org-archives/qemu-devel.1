Received: from eggs.gnu.org ([2001:4830:134:3::10]:51275)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1da1n8-0007ei-DW
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 11:30:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1da1n4-0006bS-99
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 11:30:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55176)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <crosa@redhat.com>) id 1da1n3-0006aB-Vg
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 11:30:30 -0400
References: <20170724124438.27344-1-apahim@redhat.com>
	<20170724124438.27344-2-apahim@redhat.com>
	<20170725133708.GE23343@stefanha-x1.localdomain>
From: Cleber Rosa <crosa@redhat.com>
Message-ID: <fe45a297-3f65-e212-90fc-33dd6d48a2f0@redhat.com>
Date: Tue, 25 Jul 2017 11:30:16 -0400
MIME-Version: 1.0
In-Reply-To: <20170725133708.GE23343@stefanha-x1.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="KdHXo58j8htjcgri1tqgAon8ALdl8iAsJ"
Subject: Re: [Qemu-devel] [PATCH v4 1/2] qemu.py: make 'args' public
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>, Amador Pahim <apahim@redhat.com>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, ldoktor@redhat.com, ehabkost@redhat.com, armbru@redhat.com, mreitz@redhat.com, famz@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--KdHXo58j8htjcgri1tqgAon8ALdl8iAsJ
From: Cleber Rosa <crosa@redhat.com>
To: Stefan Hajnoczi <stefanha@gmail.com>, Amador Pahim <apahim@redhat.com>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, ldoktor@redhat.com,
 ehabkost@redhat.com, armbru@redhat.com, mreitz@redhat.com, famz@redhat.com
Message-ID: <fe45a297-3f65-e212-90fc-33dd6d48a2f0@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v4 1/2] qemu.py: make 'args' public
References: <20170724124438.27344-1-apahim@redhat.com>
 <20170724124438.27344-2-apahim@redhat.com>
 <20170725133708.GE23343@stefanha-x1.localdomain>
In-Reply-To: <20170725133708.GE23343@stefanha-x1.localdomain>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable



On 07/25/2017 09:37 AM, Stefan Hajnoczi wrote:
> On Mon, Jul 24, 2017 at 02:44:37PM +0200, Amador Pahim wrote:
>> Let's make args public so users can extend it without feeling like
>> abusing the internal API.
>=20
> Nothing is abusing an internal API.  PEP8 describes the difference
> between public (no underscore), protected aka subclass API (single
> underscore), and private fields (single or double underscore):
>=20
>   https://www.python.org/dev/peps/pep-0008/
>=20
> _args is a protected field.  It is perfectly normal for a subclass to
> access a protected field in its parent class.
>=20

Right, which means that instances should not be using it.  I guess
there's a clear conflict of what is assumed to be the intended use for
this class.

I can see the value in using it *directly*, and I can also see changing
the QEMU args as a requirement.

>> Signed-off-by: Amador Pahim <apahim@redhat.com>
>> Reviewed-by: Fam Zheng <famz@redhat.com>
>> ---
>>  scripts/qemu.py               | 10 +++++-----
>>  tests/qemu-iotests/iotests.py | 18 +++++++++---------
>>  2 files changed, 14 insertions(+), 14 deletions(-)
>=20
> Please don't do this, it encourages code duplication.  Now arbitrary
> users can start accessing the public field directly instead of adding a=

> reusable interfaces like add_monitor_telnet(), add_fd(), etc.
>=20

Judging from tests/qemu-iotests/iotests.py:VM and your comment above, I
assume you see value in simple wrappers such as:

   def add_device(self, opts):
        self._args.append('-device')
        self._args.append(opts)
        return self

I honestly do not see any value here.  I do see value in other wrappers,
such as add_drive(), in which default values are there for convenience,
and a drive count is kept.  In the end, my point is that the there are
cases when a wrapper is just an annoyance and provides nothing more than
 the illusion of a better design.

If "args" is not made public, wrappers with no real value will start to
be proposed, either within the test's own subclass (like in
tests/qemu-iotests/iotests.py:VM) or will make its way to
scripts/qemu.py:QEMUMachine.

What you describe as "adding reusable interfaces" can be seen both as a
blessing if they're really well designed interfaces, or a curse if
they're something a test writer *has* to write while a test is being
written to get around the fact that "args" is not available.

Extending on the "add_device()" example, how would you feel about
something like:

   def add_arg(self, arg, opts=3DNone):
      self._args.append(arg)
      if opts is not None:
          self._args.append(opts)

FIY, I have a bad feeling about it, but it's quite comparable to
add_device(), and it keeps "args" private.

--=20
Cleber Rosa
[ Sr Software Engineer - Virtualization Team - Red Hat ]
[ Avocado Test Framework - avocado-framework.github.io ]
[  7ABB 96EB 8B46 B94D 5E0F  E9BB 657E 8D33 A5F2 09F3  ]


--KdHXo58j8htjcgri1tqgAon8ALdl8iAsJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZd2QIAAoJEGV+jTOl8gnzbooP+gPWtrUSHd6cktIVqcWt3iZw
hl09//jJKbDHW4PKVwz/qJXL7M+R29yuKbpAS6hZfQrlvCSoJp3s7LenqSMwEL/9
pvY6B+c+y9VPQ0OTrZWCMfFAwbFbkJjUCAl/kH6ezHiN82QgF+n6BLK6h0UfVb2f
sj7Mw5U+9l3w3cTGyL2zYzTIr6+P4Hl0uOuG9lu2tS3fFBeO4tz6Nj5qT3gzqg+t
tX5qSjuQgsaYLd7zYFsHoUUc7IK//auYPmobS6viFd079qySJrv3rkQHRen5MbnB
x7OcYOh4ASh5JYF+eCPsdTbXc3+BzYxr1D9LOjw4Lb+ORTNO7IezCDPLs5yFFykD
GhnJl7GWltZos9r9PxzXgE/ta4gjl+g2bpzQjU3Zuc3MIxrWP4GwK3P/gGHyGAR8
BAsjR+qWp61R4unAQomzOVRGzZh/P/tSDLirwyS3KmQrEv2P+nsLIQvO5/XhRAbt
fCQ48m/orbrICysNDBNFjbleUI/7Ndb9gMs7+EA/BRmCtZzEZ8/JsIVp9xnojb8l
darl9rPIPMuFkRewAacD19uEcdj4WUvNrzMeOYO/gVewBDsqtdlhtrTue9Q0upyX
jFU2IBDVzAM96AtmmlXwOFRxryiLXFRWc3vSEpfyyOQatyIq6f2SjkLxm3MHhi2W
GUNLvRh22J85hrUpyWwM
=gFVI
-----END PGP SIGNATURE-----

--KdHXo58j8htjcgri1tqgAon8ALdl8iAsJ--
