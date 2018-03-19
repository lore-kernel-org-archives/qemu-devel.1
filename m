Received: from eggs.gnu.org ([2001:4830:134:3::10]:59894)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1exoxI-0000Tu-9h
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 03:11:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1exoxF-0003nP-4P
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 03:11:40 -0400
References: <20180315041903.10046-1-david@gibson.dropbear.id.au>
	<CAFEAcA9Uv_EyW6E=6cp+9QDCa4w13WxHQ5pCGp6E-3iOhq-mWg@mail.gmail.com>
	<20180317040215.GE4525@umbus.fritz.box>
	<CAFEAcA95=S4A6EhP1ZZROxCUT4iQzC6g8xiHixm9yRtOkbkM1Q@mail.gmail.com>
	<alpine.BSF.2.21.1803171212100.8314@zero.eik.bme.hu>
	<alpine.BSF.2.21.1803171226110.8314@zero.eik.bme.hu>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <eea49044-553f-ece0-53ee-d55a455eb770@redhat.com>
Date: Mon, 19 Mar 2018 08:11:25 +0100
MIME-Version: 1.0
In-Reply-To: <alpine.BSF.2.21.1803171226110.8314@zero.eik.bme.hu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu-ppc] [PULL 0/9] ppc-for-2.12 queue 20180315
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: BALATON Zoltan <balaton@eik.bme.hu>, Peter Maydell <peter.maydell@linaro.org>
Cc: Laurent Vivier <lvivier@redhat.com>, surajjs@au1.ibm.com, QEMU Developers <qemu-devel@nongnu.org>, Greg Kurz <groug@kaod.org>, qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

On 17.03.2018 12:30, BALATON Zoltan wrote:
> On Sat, 17 Mar 2018, BALATON Zoltan wrote:
>> On Sat, 17 Mar 2018, Peter Maydell wrote:
[...]
>>>>> =C2=A0 /ppc64/boot-serial/sam460ex:
>>>>> /home/petmay01/linaro/qemu-for-merges/target/ppc/translate.c:2979:1=
5:
>>>>> runtime error: load of value 85, which is not a valid value for typ=
e
>>>>> 'bool'
>>>>> OK
>>>>>
>>>>> Looks like you're not initializing ctx->lazy_tlb_flush for all
>>>>> configs:
>>>>> =C2=A0=C2=A0=C2=A0 if (env->mmu_model =3D=3D POWERPC_MMU_32B ||
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 env->mmu_model =3D=3D PO=
WERPC_MMU_601 ||
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (env->mmu_model & POWERP=
C_MMU_64B))
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
ctx->lazy_tlb_flush =3D true;
>>>>>
>>>>> should perhaps be
>>>>> =C2=A0=C2=A0=C2=A0 ctx->lazy_tlb_flush =3D
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 env->mmu_model =3D=3D PO=
WERPC_MMU_32B ||
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 env->mmu_model =3D=3D PO=
WERPC_MMU_601 ||
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (env->mmu_model & POWERP=
C_MMU_64B);
>>>>>
>>>>> ?
>>>>
>>>> Uh.. maybe.. except I don't see anything in the series that would be
>>>> likely to change that behaviour.
>>>
>>> I imagine it's "tests/boot-serial: Test the sam460ex board" --
>>> this code was previously not being exercised in 'make check',
>>> and now it is.
>>
>> I'm not sure what could cause this in case of sam460ex. It has PPC440
>> which has POWERPC_MMU_BOOKE but the ppce500 should also have that and
>> a similar u-boot and that does not produce this error. Is there maybe
>> some initialisation of some structure I've missed somewhere? But these
>> DisasContext structs seem to be internal to TCG so I'm not sure what
>> could be missing outside of TCG to avoid this. Could be that the
>> different u-boot version does something that triggers this while the
>> one for ppce500 does not execute code that causes this warning during
>> the test?
>=20
> Oops, replied too soon. I've checked e500 and it seems to have
> POWERPC_MMU_BOOKE206 (I thought e500 was BookE but I don't know these
> very well). Only bamboo, virtex-ml507 and sam460ex seem to be
> POWERPC_MMU_BOOKE so if only the sam460ex test is added now and the
> others were never tested then it could be this is the first time this i=
s
> catched.

Right, bamboo and virtex-ml507 do not ship with a pre-built firmware
image, so they are *not* tested in the boot-serial tester. ppce500 is
the only embedded PPC board that is tested so far. So it's good that we
finally have one more test case for an additional CPU type here :-)

 Thomas
