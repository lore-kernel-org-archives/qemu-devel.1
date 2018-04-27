Received: from eggs.gnu.org ([2001:4830:134:3::10]:50953)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ldoktor@redhat.com>) id 1fC8om-0007mr-3Z
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 15:14:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ldoktor@redhat.com>) id 1fC8oi-00072Y-0j
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 15:14:04 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:39100 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ldoktor@redhat.com>) id 1fC8oh-0006ww-PV
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 15:13:59 -0400
References: <20180426135755.GI29865@localhost.localdomain>
From: =?UTF-8?B?THVrw6HFoSBEb2t0b3I=?= <ldoktor@redhat.com>
Message-ID: <54b50fb6-9619-ffda-fb4b-8702166628de@redhat.com>
Date: Fri, 27 Apr 2018 21:13:42 +0200
MIME-Version: 1.0
In-Reply-To: <20180426135755.GI29865@localhost.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="veyGDOpNOefdm6UMZDBqwXOjLXbeKtSgC"
Subject: Re: [Qemu-devel] Who is running QEMU automated tests, and when?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: Yash Mankad <ymankad@redhat.com>, Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, Cleber Rosa <crosa@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--veyGDOpNOefdm6UMZDBqwXOjLXbeKtSgC
From: =?UTF-8?B?THVrw6HFoSBEb2t0b3I=?= <ldoktor@redhat.com>
To: Eduardo Habkost <ehabkost@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
Cc: Yash Mankad <ymankad@redhat.com>, Thomas Huth <thuth@redhat.com>,
 qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Cleber Rosa <crosa@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?=
 <f4bug@amsat.org>
Message-ID: <54b50fb6-9619-ffda-fb4b-8702166628de@redhat.com>
Subject: Re: [Qemu-devel] Who is running QEMU automated tests, and when?
References: <20180426135755.GI29865@localhost.localdomain>
In-Reply-To: <20180426135755.GI29865@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Dne 26.4.2018 v 15:57 Eduardo Habkost napsal(a):
> (Starting a new thread, for more visibility)
>=20

Hello guys,

what a nice topic. My Jenkins runs following weekly/daily upstream checks=
 using RHEL.7 as host:

ppc64
=3D=3D=3D=3D=3D

frequency: weekly
host:
    - ppc64
    - ppc64le
tests:
    - make    # building all targets
    - SPEED=3Dslow make check
    - kvm-unit-tests:
        - ACCEL=3Dkvm,kvm-type=3DHV
        - ACCEL=3Dkvm,kvm-type=3DPR
        - ACCEL=3Dtcg
    - qemu-iotests:
        - ALL_TESTS -qcow2 -file
        - ALL_TESTS -qcow2 -nbd    # quite broken
        - ALL_TESTS -raw -file
        - ALL_TESTS -raw -nbd    # quite broken
        - 059 -vmdk
        - 064 vhdx
        - 070 vhdx
        - 075 cloop
        - 076 parallels
        - 078 -bochs
        - 084 -vdi
        - 088 -vpc
        - 116 -qed
        - 131 -parallels
        - 135 -vpc
        - 146 -vpc
        # I tried -nfs but it seems broken and I'm still waiting for feed=
back
    - functonal:    # using Avocado-vt
        guest:
            - ppc64
            - ppc64le
        tests:
            - various RHEL.7 install jobs
            - migration between various tagged qemu revisions

s390x
=3D=3D=3D=3D=3D

frequency: daily
tests:
    - make     # building all targets
    - SPEED=3Dslow make check
    - kvm-unit-tests
    - functonal:    # using Avocado-vt
        - various RHEL.7 install jobs
        - migration using the latest qemu only

Unfortunately I'm currently changing the setup so for the past 1-2 months=
 it's semi-broken. When I finish the transition I plan to add aarch64 ups=
tream checks as well (as I am already running similar downstream suite th=
ere), but now I'm struggling with Jenkins and the new setup (which should=
 have simplified things).

Kind regards,
Luk=C3=A1=C5=A1


> (This was: Re: [Qemu-devel] [RFC PATCH] tests/device-introspect: Test
> devices with all machines, not only with "none")
>=20
> On Thu, Apr 26, 2018 at 01:54:43PM +0200, Markus Armbruster wrote:
>> Thomas Huth <thuth@redhat.com> writes:
>>> On 17.04.2018 14:12, Markus Armbruster wrote:
>>>> Thomas Huth <thuth@redhat.com> writes:
>>>>
>>>>> Many device introspection crashes only happen if you are using a
>>>>> certain machine, e.g.:
>>>>>
>>>>> $ ppc-softmmu/qemu-system-ppc -S -M ref405ep,accel=3Dqtest -qmp std=
io
>>>>> {"QMP": {"version": {"qemu": {"micro": 50, "minor": 11, "major": 2}=
,
>>>>>  "package": "build-all"}, "capabilities": []}}
>>>>> { 'execute': 'qmp_capabilities' }
>>>>> {"return": {}}
>>>>> { 'execute': 'device-list-properties',
>>>>>   'arguments': {'typename': 'macio-newworld'}}
>>>>> Unexpected error in qemu_chr_fe_init() at chardev/char-fe.c:222:
>>>>> Device 'serial0' is in use
>>>>> Aborted (core dumped)
>>>>>
>>>>> To be able to catch these problems, let's extend the device-introsp=
ect
>>>>> test to check the devices on all machine types. Since this is a rat=
her
>>>>> slow operation, the test is only run in "SPEED=3Dslow" mode.
>>>>
>>>> If the device works with one machine type, it has a decent chance to=

>>>> work with others, too.  Thus, testing each device with every machine=

>>>> type is overkill.  I appreciate having overkill as an option :)
>>>>
>>>> What I'd like to see for a quick "make check" is testing each device=

>>>> once.  That should flush out most bugs. =20
>>>
>>> That's already done with the "none" machine.
>>
>> I was too terse.  We test each device with -machine none for every
>> target.  Fine if that's quick enough.  If not, we might want to reduce=

>> redundancy there.
>>
>> Actually, a worse offender in the "waste everybody's time via redunanc=
y"
>> department could be qom-test.
>>
>>> Anyway, do you think my patch here is useful and has a chance of gett=
ing
>>> included? I.e. shall I re-spin this as a non-RFC patch? Or shall we
>>> rather wait for Eduardo's python-based tests to get included into the=

>>> repository?
>>
>> I don't mind having make check SPEED=3Dslow run more extensive tests.
>> Assuming we actually run them at least once in a while, which seems
>> doubtful.
>=20
> We probably don't do that, but we really must be running a more
> extensive (and slower) test set at least once before every
> release.
>=20
> Maybe some people are running SPEED=3Dslow tests, or even more
> extensive test suites like avocado-vt once in a while, but we
> need to know who is running them, and when.
>=20
> Today, the only test set I know people really run and would
> surely block a release is "make check [SPEED=3Dquick]".
>=20
> So, for anybody that runs automated QEMU tests once in a while,
> can we know:
>=20
> * What test cases are you running?  Where can we get more
>   information about the tests you run?
> * When do you run them?  What triggers a new test run?
>=20
> Peter, do you have additional tests you run before merging a pull
> request?  Additional test sets run before tagging a release?
>=20



--veyGDOpNOefdm6UMZDBqwXOjLXbeKtSgC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEpApMRcQDTeAqWtSDJrNi5H/PIsEFAlrjdmYACgkQJrNi5H/P
IsHNWgf+I8TD76xp1DTGp2WvZXXl2AhtaJBLtyj7ya+juf682zABQSoBlphHm1GW
msklkrfHNNJ29LY8wDGGLzckCe6Fh6smkEd7gvKFGWTnU02JzCNYKsEE15QyBYcl
LCnVWSgTxOJgfTZSVYKafxv3K56NUvNYPTH1q6xUYExf14SkphdBeX05oYhxUMhU
kcB4UIHuEcfDe61XVvVtzCgw7NDpOFqbIHudufW85DET3Ne71pYY/omM3wDBwVCa
WX24wX/3eDf/YkMTTz+5s8tqXDYOWpyi4nz2QBzbaIhHrG99D8Q8V9Y4lJ9AzN6M
NwdVgpnGYN4FQdcR5/iiCJ4eg2fo0A==
=hn91
-----END PGP SIGNATURE-----

--veyGDOpNOefdm6UMZDBqwXOjLXbeKtSgC--
