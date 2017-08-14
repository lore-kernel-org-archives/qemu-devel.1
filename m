Received: from eggs.gnu.org ([2001:4830:134:3::10]:34434)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1dhKCC-0003TQ-FU
	for qemu-devel@nongnu.org; Mon, 14 Aug 2017 14:34:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1dhKC9-0004ND-C0
	for qemu-devel@nongnu.org; Mon, 14 Aug 2017 14:34:36 -0400
Received: from 8.mo2.mail-out.ovh.net ([188.165.52.147]:48792)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1dhKC9-0004LM-5Q
	for qemu-devel@nongnu.org; Mon, 14 Aug 2017 14:34:33 -0400
Received: from player770.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo2.mail-out.ovh.net (Postfix) with ESMTP id 66D4DA31AF
	for <qemu-devel@nongnu.org>; Mon, 14 Aug 2017 20:34:24 +0200 (CEST)
References: <1502721197-32717-1-git-send-email-mst@redhat.com>
	<20170814173335.58f0e84f.cohuck@redhat.com>
	<f08ad396-50bf-aff7-95e8-5cd1b862923e@redhat.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <0e0fabcc-5dfa-abee-a6ed-f39e57aa3aaa@kaod.org>
Date: Mon, 14 Aug 2017 20:34:14 +0200
MIME-Version: 1.0
In-Reply-To: <f08ad396-50bf-aff7-95e8-5cd1b862923e@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] tests: switch tests to accel=kvm:tcg
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, Cornelia Huck <cohuck@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Greg Kurz <groug@kaod.org>, "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>

On 08/14/2017 05:47 PM, Thomas Huth wrote:
> On 14.08.2017 17:33, Cornelia Huck wrote:
>> On Mon, 14 Aug 2017 17:34:15 +0300
>> "Michael S. Tsirkin" <mst@redhat.com> wrote:
>>
>>> Speed up tests on host systems with kvm support.
>>> In particular, this fixes tests with --disable-tcg.
> [...]
>>> diff --git a/tests/pnv-xscom-test.c b/tests/pnv-xscom-test.c
>>> index 5adc3fd..7be396f 100644
>>> --- a/tests/pnv-xscom-test.c
>>> +++ b/tests/pnv-xscom-test.c
>>> @@ -84,7 +84,7 @@ static void test_cfam_id(const void *data)
>>>      char *args;
>>>      const PnvChip *chip =3D data;
>>> =20
>>> -    args =3D g_strdup_printf("-M powernv,accel=3Dtcg -cpu %s", chip-=
>cpu_model);
>>> +    args =3D g_strdup_printf("-M powernv,accel=3Dkvm:tcg -cpu %s", c=
hip->cpu_model);
>>> =20
>>>      qtest_start(args);
>>>      test_xscom_cfam_id(chip);
>>> @@ -112,7 +112,7 @@ static void test_core(const void *data)
>>>      char *args;
>>>      const PnvChip *chip =3D data;
>>> =20
>>> -    args =3D g_strdup_printf("-M powernv,accel=3Dtcg -cpu %s", chip-=
>cpu_model);
>>> +    args =3D g_strdup_printf("-M powernv,accel=3Dkvm:tcg -cpu %s", c=
hip->cpu_model);
>>> =20
>>>      qtest_start(args);
>>>      test_xscom_core(chip);
>>
>> These seem to test a specified cpu model explicitly, so I'm not sure
>> how well this will work with kvm.
>=20
> AFAIK the powernv machine does not work with KVM yet (C=C3=A9dric, can =
you
> confirm?), so you better drop the changes to this file.

No. the powernv machine does not work with KVM.

C.

>>> diff --git a/tests/prom-env-test.c b/tests/prom-env-test.c
>>> index eac207b..0a10f06 100644
>>> --- a/tests/prom-env-test.c
>>> +++ b/tests/prom-env-test.c
>>> @@ -50,7 +50,7 @@ static void test_machine(const void *machine)
>>>      /* The pseries firmware boots much faster without the default de=
vices */
>>>      extra_args =3D strcmp(machine, "pseries") =3D=3D 0 ? "-nodefault=
s" : "";
>>> =20
>>> -    args =3D g_strdup_printf("-M %s,accel=3Dtcg %s -prom-env 'use-nv=
ramrc?=3Dtrue' "
>>> +    args =3D g_strdup_printf("-M %s,accel=3Dkvm:tcg %s -prom-env 'us=
e-nvramrc?=3Dtrue' "
>>>                             "-prom-env 'nvramrc=3D%x %x l!' ",
>>>                             (const char *)machine, extra_args, MAGIC,=
 ADDRESS);
>>
>> The header explicitly states that this is supposed to test tcg mode.
>=20
> This change should be OK here. But it is currently not necessary yet:
> The test only runs on SPARC and PPC machines, and both do not support
> the --disable-tcg switch yet.
>=20
>  Thomas
>=20
