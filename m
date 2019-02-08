Received: from eggs.gnu.org ([209.51.188.92]:51748)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1gsD8l-0001T2-2U
	for qemu-devel@nongnu.org; Fri, 08 Feb 2019 15:52:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1gsD8j-00065D-Jq
	for qemu-devel@nongnu.org; Fri, 08 Feb 2019 15:52:50 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36920)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lvivier@redhat.com>) id 1gsD8j-00064G-Bi
	for qemu-devel@nongnu.org; Fri, 08 Feb 2019 15:52:49 -0500
References: <20190201160653.13829-1-peter.maydell@linaro.org>
	<20190201160653.13829-44-peter.maydell@linaro.org>
	<767a2e82-acf4-d282-30a2-a3f5889c01f9@redhat.com>
	<C029431E20CCA74C901B75816C3A8BB108B70192@lhreml501-mbb>
From: Laurent Vivier <lvivier@redhat.com>
Message-ID: <536a29c7-a158-90a8-b544-50d383175ba2@redhat.com>
Date: Fri, 8 Feb 2019 19:26:10 +0100
MIME-Version: 1.0
In-Reply-To: <C029431E20CCA74C901B75816C3A8BB108B70192@lhreml501-mbb>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 43/47] target/arm: fix AArch64 virtual
 address space size
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Remi Denis Courmont <remi.denis.courmont@huawei.com>, Peter Maydell <peter.maydell@linaro.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Richard Henderson <richard.henderson@linaro.org>

On 08/02/2019 16:38, Remi Denis Courmont wrote:
>    Hi,
>=20
> That LTP test case deliberately tries to invoke a system call with an i=
nvalid address to make sure that the kernel fails safely. There seems to =
be an impedance mismatch between access_ok() and page_check_range() here,=
 where the later assumes that the address is in guest range:
>=20
>     /* This function should never be called with addresses outside the
>        guest address space.  If this assert fires, it probably indicate=
s
>        a missing call to h2g_valid.  */
>=20
> It looks to me that there actually two separate bugs here:
>=20
> 1) access_ok() does not fulfill the requirements of page_check_range(),=
 misses a guest_addr_valid() call.
> 2) The page_check_range() assertion does not account for potential over=
flow, although the non-debug code does account for it.

You're right, this fixes the problem for me:

diff --git a/linux-user/qemu.h b/linux-user/qemu.h
index ef400cb78a..a8dce7f821 100644
--- a/linux-user/qemu.h
+++ b/linux-user/qemu.h
@@ -457,6 +457,9 @@ extern unsigned long guest_stack_size;
=20
 static inline int access_ok(int type, abi_ulong addr, abi_ulong size)
 {
+    if (!h2g_valid(addr)) {
+        return 0;
+    }
     return page_check_range((target_ulong)addr, size,
                             (type =3D=3D VERIFY_READ) ? PAGE_READ : (PAG=
E_READ | PAGE_WRITE)) =3D=3D 0;
 }

> ________________________________________
> De : Laurent Vivier [lvivier@redhat.com]
> Envoy=C3=A9 : vendredi 8 f=C3=A9vrier 2019 16:02
> =C3=80 : Peter Maydell; qemu-devel@nongnu.org; Remi Denis Courmont; Ric=
hard Henderson
> Objet : Re: [Qemu-devel] [PULL 43/47] target/arm: fix AArch64 virtual a=
ddress space size
>=20
> On 01/02/2019 17:06, Peter Maydell wrote:
>> From: Remi Denis-Courmont <remi.denis.courmont@huawei.com>
>>
>> Since QEMU does not support the ARMv8.2-LVA, Large Virtual Address,
>> extension (yet), the VA address space is 48-bits plus a sign bit. User
>> mode can only handle the positive half of the address space, so that
>> makes a limit of 48 bits.
>>
>> (With LVA, it would be 53 and 52 bits respectively.)
>>
>> The incorrectly large address space conflicts with PAuth instructions,
>> which use bits 48-54 and 56-63 for the pointer authentication code. Th=
is
>> also conflicts with (as yet unsupported by QEMU) data tagging and with
>> the ARMv8.5-MTE extension.
>>
>> Signed-off-by: Remi Denis-Courmont <remi.denis.courmont@huawei.com>
>> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
>> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
>> ---
>>  target/arm/cpu.h | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/target/arm/cpu.h b/target/arm/cpu.h
>> index 63934a200ad..a68bcc9fedb 100644
>> --- a/target/arm/cpu.h
>> +++ b/target/arm/cpu.h
>> @@ -2512,7 +2512,7 @@ bool write_cpustate_to_list(ARMCPU *cpu);
>>
>>  #if defined(TARGET_AARCH64)
>>  #  define TARGET_PHYS_ADDR_SPACE_BITS 48
>> -#  define TARGET_VIRT_ADDR_SPACE_BITS 64
>> +#  define TARGET_VIRT_ADDR_SPACE_BITS 48
>>  #else
>>  #  define TARGET_PHYS_ADDR_SPACE_BITS 40
>>  #  define TARGET_VIRT_ADDR_SPACE_BITS 32
>>
>=20
> This change breaks qemu-aarch64 (using LTP test suite):
>=20
> # chroot chroot/arm64/bionic /opt/ltp/testcases/bin/access03
> tst_test.c:1015: INFO: Timeout per run is 0h 05m 00s
> qemu-aarch64: .../qemu/accel/tcg/translate-all.c:2522: page_check_range=
: Assertion `start < ((target_ulong)1 << L1_MAP_ADDR_SPACE_BITS)' failed.
> qemu:handle_cpu_signal received signal outside vCPU context @ pc=3D0x60=
001554
>=20
> Any idea?
> Thanks,
> Laurent
>=20
