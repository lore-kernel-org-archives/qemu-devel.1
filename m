Received: from eggs.gnu.org ([2001:4830:134:3::10]:42750)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1dXZxX-00013q-CP
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 17:23:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1dXZxT-0004LC-69
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 17:23:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33852)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <crosa@redhat.com>) id 1dXZxS-0004KT-Sn
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 17:23:07 -0400
References: <15fc8a05-daff-d2af-7389-7253cb0b3517@linux.vnet.ibm.com>
	<96e5169c-6149-fd7a-3347-0994089e01ac@redhat.com>
From: Cleber Rosa <crosa@redhat.com>
Message-ID: <ac3a06a2-bc47-92bb-50e2-0b8174c2b515@redhat.com>
Date: Tue, 18 Jul 2017 17:22:57 -0400
MIME-Version: 1.0
In-Reply-To: <96e5169c-6149-fd7a-3347-0994089e01ac@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="PO8Ne8RxKJV0lpadEecEhcWJJpMfbilFf"
Subject: Re: [Qemu-devel] Question for iotests 188, 189 and 087
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, Jing Liu <liujbjl@linux.vnet.ibm.com>, qemu-devel@nongnu.org
Cc: Lukas Doktor <ldoktor@redhat.com>, Amador Segundo <asegundo@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--PO8Ne8RxKJV0lpadEecEhcWJJpMfbilFf
From: Cleber Rosa <crosa@redhat.com>
To: John Snow <jsnow@redhat.com>, Jing Liu <liujbjl@linux.vnet.ibm.com>,
 qemu-devel@nongnu.org
Cc: Lukas Doktor <ldoktor@redhat.com>, Amador Segundo <asegundo@redhat.com>
Message-ID: <ac3a06a2-bc47-92bb-50e2-0b8174c2b515@redhat.com>
Subject: Re: [Qemu-devel] Question for iotests 188, 189 and 087
References: <15fc8a05-daff-d2af-7389-7253cb0b3517@linux.vnet.ibm.com>
 <96e5169c-6149-fd7a-3347-0994089e01ac@redhat.com>
In-Reply-To: <96e5169c-6149-fd7a-3347-0994089e01ac@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 07/18/2017 02:07 PM, John Snow wrote:
>=20
>=20
> On 07/17/2017 11:01 PM, Jing Liu wrote:
>> Hi all,
>>
>> Do you anybody have iotests failure: 188, 189 and 087 of the latest qe=
mu
>> upsteam?
>>
>> I just wondered if it has something wrong with my test machines becaus=
e
>> I have different results with two machines.
>>
>>
>> Thanks.
>>
>> Jing
>>
>>
>=20
> Presumably you are missing aio=3Dnative support for 087,
>=20

I see 6 different "tests" as part of 087, and only one them requires AIO
support ("aio=3Dnative without O_DIRECT"), which can fail like this:

--- /home/cleber/src/qemu/tests/qemu-iotests/087.out    2017-07-17
19:33:26.409758360 -0400
+++ 087.out.bad 2017-07-18 17:01:37.736038689 -0400
@@ -27,7 +27,7 @@
 Testing:
 QMP_VERSION
 {"return": {}}
-{"error": {"class": "GenericError", "desc": "aio=3Dnative was specified,=

but it requires cache.direct=3Don, which was not specified."}}
+{"error": {"class": "GenericError", "desc": "aio=3Dnative was specified,=

but is not supported in this build."}}
 {"return": {}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP},
"event": "SHUTDOWN", "data": {"guest": false}}

Failures: 087
Failed 1 of 1 tests

When either "--disable-linux-aio" is given or when libaio headers are
missing, which in the end means that CONFIG_LINUX_AIO won't be set in
config-host.mak or config-host.h.

> and 188/189 I believe require compression and/or LUKS libraries.
>=20

I did not check if/which optional configure time option would end up
disabling LUKS support and affecting those tests, but it's possible that
something similar exists.

> These are false positives caused by missing libraries. We should
> probably work out a proper solution to meaningfully skipping tests we
> didn't compile support for.
>=20
> --js
>=20

I see issues here:

1) The qemu-iotests "runner", that is, "./check", understands that a
file number is a test.  No further granularity is (currently?)
achievable here.

The easy solution would be to split tests which depend on optional
features to separate test files.  In the 087 test given as example,
the "=3D=3D=3D aio=3Dnative without O_DIRECT =3D=3D=3D" block would becom=
e, say, 190.

2) Skip tests based on features more easily.  There's already support
for skipping tests on various situations.  From 087:

=2E..
_supported_fmt qcow2
_supported_proto file
_supported_os Linux
=2E..

It's trivial to also have access to other compile time settings.  I did
a quick experiment that would add a "_required_feature" function to
"common.rc".  For 087 (or 190?) it would look like:

=2E..
_supported_fmt qcow2
_supported_proto file
_supported_os Linux
_required_feature CONFIG_LINUX_AIO
=2E..

Does it make sense?  Would a patch series along those lines would be
welcomed by reviews?

Thanks!

--=20
Cleber Rosa
[ Sr Software Engineer - Virtualization Team - Red Hat ]
[ Avocado Test Framework - avocado-framework.github.io ]
[  7ABB 96EB 8B46 B94D 5E0F  E9BB 657E 8D33 A5F2 09F3  ]


--PO8Ne8RxKJV0lpadEecEhcWJJpMfbilFf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZbnw0AAoJEGV+jTOl8gnz09IP/jkR99Rl52NMEwy0uHd/EPtB
mXsa+XtbQaCXMAa6187MO4Eso762EoHcK64yckbfu+DEVCK/m6UWUQsLj22ft5Zu
MoNMBJclUSkU8hWOtaV74Y3gaAgyiHifVgVrOY0WuPPPiJ//bUYej0P38QCe7mXy
4YspxaUB4U1SrJna+ZySRFcfxOCmP0j6o2hBPLJwCm7sgWDD0IK5e2oheUKYQjij
/ZGTn20jucvQtmcmgI/IDOdXJFCcMyrHIVATyeYluOofPhajZUFFejd+EeDwyWpS
TM5CbtGamtEZaPyLZPBXswXD52hjpRUCLdUEY5sUpOnEXp3ghLVpTnjCco2s2VyW
Y+Z7brcHbUPmPu9dQ2OiRmEgLPA7upKy2J4ZhJVwJSsCsuTSz1QAT3gr6wJ3D0rB
AfT/gCAFUx36KqQm8ewwYRipweI9VPHtitJgoSaRKxfImVWBgXf3SYpL+8/aaLsO
VzE3myiZ/A65/EYnarUKLCixRmmpLRKOxNzSteuvzqwqShrH/TFgg7gnCGd2P/pv
L/YRucucbw35r92oyVjM8RktgtHMlZtJRfKFwuGt8rcrOntHj1vCn/Il3ULpet4t
a/mufnhofN3czHRBRFxJjarBjj5ILqqoPS9XOIXpDYKK6fWJjqZjdglK3ZqQW0pW
Yfby8MfbOJZFJmv/ULtF
=G332
-----END PGP SIGNATURE-----

--PO8Ne8RxKJV0lpadEecEhcWJJpMfbilFf--
