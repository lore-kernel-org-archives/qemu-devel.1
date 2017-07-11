Received: from eggs.gnu.org ([2001:4830:134:3::10]:47436)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ben@skyportsystems.com>) id 1dV4ow-000760-8t
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 19:43:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ben@skyportsystems.com>) id 1dV4os-000407-8s
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 19:43:58 -0400
Received: from mail-pf0-x22b.google.com ([2607:f8b0:400e:c00::22b]:35071)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <ben@skyportsystems.com>)
	id 1dV4or-0003zp-W3
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 19:43:54 -0400
Received: by mail-pf0-x22b.google.com with SMTP id c73so3514956pfk.2
	for <qemu-devel@nongnu.org>; Tue, 11 Jul 2017 16:43:53 -0700 (PDT)
From: Ben Warren <ben@skyportsystems.com>
Message-Id: <3CA8C399-80D0-4BC8-ACC6-FD72A09D9685@skyportsystems.com>
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Date: Tue, 11 Jul 2017 16:43:50 -0700
In-Reply-To: <273a7da7-2243-171f-e96d-39e8e8031984@redhat.com>
References: <1499111049-13721-1-git-send-email-mst@redhat.com>
	<1499111049-13721-20-git-send-email-mst@redhat.com>
	<CAFEAcA_giHFa-aw=WuuqmVFL+dr7HeD9E1o=oLszQywJbAd0wA@mail.gmail.com>
	<7EC3FA95-777F-4F8F-B02D-85FA09BAFC00@skyportsystems.com>
	<CAFEAcA8-o28j-FvHWz3=nZX_pO=+XOc_6MnmyFWB324+G7Ppqw@mail.gmail.com>
	<CAFEAcA-ireu_2fW00dX=Z3hu4Jongftab_ysymbJMB0893M4Ww@mail.gmail.com>
	<20170711220915-mutt-send-email-mst@kernel.org>
	<CAFEAcA_-hCV2Ogy3BS2RV4_AWYYQDT+fCNChVcz8uKZ8-VxhWA@mail.gmail.com>
	<273a7da7-2243-171f-e96d-39e8e8031984@redhat.com>
Content-Type: text/plain;
	charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 19/21] tests: Add unit tests for the VM
 Generation ID feature
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laszlo Ersek <lersek@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, =?utf-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>

Hi Laszlo,

> On Jul 11, 2017, at 3:13 PM, Laszlo Ersek <lersek@redhat.com> wrote:
>=20
> On 07/11/17 22:42, Peter Maydell wrote:
>> On 11 July 2017 at 20:10, Michael S. Tsirkin <mst@redhat.com> wrote:
>>> On Tue, Jul 11, 2017 at 05:49:07PM +0100, Peter Maydell wrote:
>>>> The good news is it's not aarch64-specific. I just hit this on
>>>> a build on x86_64 host, gcc, debug build:
>>>>=20
>>>>  GTESTER check-qtest-x86_64
>>>> **
>>>> =
ERROR:/home/petmay01/linaro/qemu-for-merges/tests/vmgenid-test.c:65:acpi_f=
ind_vgia:
>>>> assertion failed (ACPI_ASSERT_CMP_str =3D=3D "RSDT"): ("" =3D=3D =
"RSDT")
>>>> GTester: last random seed: R02S9eefaf38297e67e4f67d5db77989350e
>>>> /home/petmay01/linaro/qemu-for-merges/tests/Makefile.include:826:
>>>> recipe for target 'check-qtest-x86_64' failed
>>=20
>>> Couldn't reproduce here. I suspect VM didn't start at all.
>>> Am I right to assume this is without KVM?
>>=20
>> On aarch64 host, definitely without KVM. On x86-64 host,
>> I think it is without KVM but am not totally sure.
>>=20
>> It may be one of those cases that only triggers if the
>> host is heavily loaded at the time the test is running.
>=20
> (I apologize if the root cause is obvious at this point -- I'm unclear
> if the discussion is now about understanding the failure, or about =
ways
> to mitigate it. I'm assuming the former.)
>=20
> This test can occasionally fail because the test case has to wait =
until
> the guest firmware proceeds far enough with executing the ACPI
> linker/loader script. See RSDP_SLEEP_US and RSDP_TRIES_MAX in
> acpi_find_vgia(). If the test case pokes at guest RAM "too early", =
using
> monitor commands, then the guest fw will not have yet shaped guest RAM
> as required.
>=20
Yes, it=E2=80=99s definitely a setup time problem.  With the values that =
are checked in, I can=E2=80=99t get it to fail on my setup, but if I =
wind the numbers down I see the same failure as Peter.  So now we have =
the ages-old problem of =E2=80=9Cwhat new arbitrary value should I use =
that will not cause false failures but will eventually time out=E2=80=9D. =
 Can you think of an easy way to tell if firmware is running so we can =
make this more state-driven instead of time-dependent?


> (Again, apologies if this has been obvious all along.)
>=20
> Thanks
> Laszlo
