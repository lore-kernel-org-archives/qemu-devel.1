Received: from eggs.gnu.org ([2001:4830:134:3::10]:54410)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ddfrb-0001vt-If
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 12:54:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ddfrY-0002Jk-Lu
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 12:54:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41754)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1ddfrY-0002JC-Ei
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 12:54:12 -0400
References: <150168523493.31663.3716600121804656211.stgit@bahia.lan>
	<928f0ce3-159a-e371-6309-078fac31eace@amsat.org>
	<b999332b-aef1-6f19-0a1c-cf1d4a694b32@redhat.com>
	<20170803162441.43f84f54@gondolin>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <3af2df1d-d250-98ff-e2e9-88fa50e24ea2@redhat.com>
Date: Fri, 4 Aug 2017 18:54:04 +0200
MIME-Version: 1.0
In-Reply-To: <20170803162441.43f84f54@gondolin>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] kvm: workaround build break on gcc-7.1.1 /
 fedora26
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>, Eric Blake <eblake@redhat.com>
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Fam Zheng <famz@redhat.com>

On 03/08/2017 16:24, Cornelia Huck wrote:
> On Thu, 3 Aug 2017 09:10:29 -0500
> Eric Blake <eblake@redhat.com> wrote:
>=20
>> On 08/03/2017 08:46 AM, Philippe Mathieu-Daud=C3=A9 wrote:
>>> Hi Greg,
>>>
>>> On 08/02/2017 11:47 AM, Greg Kurz wrote: =20
>>>> Building QEMU on fedora26 with the latest gcc package fails:
>>>>
>>>>    CC      ppc64-softmmu/target/ppc/kvm.o
>>>> In file included from include/sysemu/hw_accel.h:16:0,
>>>>                   from target/ppc/kvm.c:31:
>>>> target/ppc/kvm.c: In function =E2=80=98kvmppc_booke_watchdog_enable=E2=
=80=99:
>>>> include/sysemu/kvm.h:449:35: error: =E2=80=98args_tmp[i]=E2=80=99 ma=
y be used
>>>> uninitialized
>>>>   in this function [-Werror=3Dmaybe-uninitialized]
>>>>               cap.args[i] =3D args_tmp[i];                          =
     \
>>>>                                     ^
>>>> target/ppc/kvm.c: In function =E2=80=98kvmppc_set_papr=E2=80=99:
>>>> include/sysemu/kvm.h:449:35: error: =E2=80=98args_tmp[i]=E2=80=99 ma=
y be used
>>>> uninitialized
>>>>   in this function [-Werror=3Dmaybe-uninitialized]
>>>> cc1: all warnings being treated as errors =20
>>>
>>> I'm trying to reproduce this in our docker images (all x86_64 based) =
but
>>> can't reproduce. =20
>>
>> That's because x86_64 hosts only call kvm_vm_enable_cap() with non-emp=
ty
>> varargs. =20
>=20
> There's
>=20
> target/i386/kvm.c:            kvm_vcpu_enable_cap(cs, KVM_CAP_HYPERV_SY=
NIC, 0)) {
>=20
>> But we have:
>>
>> accel/kvm/kvm-all.c: ret =3D kvm_vm_enable_cap(s, KVM_CAP_S390_IRQCHIP=
, 0);
>>
>> which is only compiled on s390 hosts (or, at least that's my guess,
>> based on the cap name)
>=20
> I don't see how the compiler can optimize this away, as the check for
> this cap is an ioctl...

Indeed.  This is a compiler bug and it only provides a warning (meaning
--disable-werror silences it).  I don't think it's a good idea to uglify
the code for something that the compiler should easily optimize away...

Paolo

> This seems a bit ugly. And I still don't understand why this only seems
> to hit on ppc...
