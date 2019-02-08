Received: from eggs.gnu.org ([209.51.188.92]:53996)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <remi.denis.courmont@huawei.com>) id 1gs8FA-00025t-Ij
	for qemu-devel@nongnu.org; Fri, 08 Feb 2019 10:39:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <remi.denis.courmont@huawei.com>) id 1gs8F9-0005BU-G2
	for qemu-devel@nongnu.org; Fri, 08 Feb 2019 10:39:08 -0500
Received: from lhrrgout.huawei.com ([185.176.76.210]:45342 helo=huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <remi.denis.courmont@huawei.com>)
	id 1gs8F9-0004zS-8n
	for qemu-devel@nongnu.org; Fri, 08 Feb 2019 10:39:07 -0500
From: Remi Denis Courmont <remi.denis.courmont@huawei.com>
Date: Fri, 8 Feb 2019 15:38:51 +0000
Message-ID: <C029431E20CCA74C901B75816C3A8BB108B70192@lhreml501-mbb>
References: <20190201160653.13829-1-peter.maydell@linaro.org>
	<20190201160653.13829-44-peter.maydell@linaro.org>,
	<767a2e82-acf4-d282-30a2-a3f5889c01f9@redhat.com>
In-Reply-To: <767a2e82-acf4-d282-30a2-a3f5889c01f9@redhat.com>
Content-Language: fr-FR
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
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
To: Laurent Vivier <lvivier@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Richard Henderson <richard.henderson@linaro.org>

   Hi,=0A=
=0A=
That LTP test case deliberately tries to invoke a system call with an inval=
id address to make sure that the kernel fails safely. There seems to be an =
impedance mismatch between access_ok() and page_check_range() here, where t=
he later assumes that the address is in guest range:=0A=
=0A=
    /* This function should never be called with addresses outside the=0A=
       guest address space.  If this assert fires, it probably indicates=0A=
       a missing call to h2g_valid.  */=0A=
=0A=
It looks to me that there actually two separate bugs here:=0A=
=0A=
1) access_ok() does not fulfill the requirements of page_check_range(), mis=
ses a guest_addr_valid() call.=0A=
2) The page_check_range() assertion does not account for potential overflow=
, although the non-debug code does account for it.=0A=
=0A=
________________________________________=0A=
De : Laurent Vivier [lvivier@redhat.com]=0A=
Envoy=E9 : vendredi 8 f=E9vrier 2019 16:02=0A=
=C0 : Peter Maydell; qemu-devel@nongnu.org; Remi Denis Courmont; Richard He=
nderson=0A=
Objet : Re: [Qemu-devel] [PULL 43/47] target/arm: fix AArch64 virtual addre=
ss space size=0A=
=0A=
On 01/02/2019 17:06, Peter Maydell wrote:=0A=
> From: Remi Denis-Courmont <remi.denis.courmont@huawei.com>=0A=
>=0A=
> Since QEMU does not support the ARMv8.2-LVA, Large Virtual Address,=0A=
> extension (yet), the VA address space is 48-bits plus a sign bit. User=0A=
> mode can only handle the positive half of the address space, so that=0A=
> makes a limit of 48 bits.=0A=
>=0A=
> (With LVA, it would be 53 and 52 bits respectively.)=0A=
>=0A=
> The incorrectly large address space conflicts with PAuth instructions,=0A=
> which use bits 48-54 and 56-63 for the pointer authentication code. This=
=0A=
> also conflicts with (as yet unsupported by QEMU) data tagging and with=0A=
> the ARMv8.5-MTE extension.=0A=
>=0A=
> Signed-off-by: Remi Denis-Courmont <remi.denis.courmont@huawei.com>=0A=
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>=0A=
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>=0A=
> ---=0A=
>  target/arm/cpu.h | 2 +-=0A=
>  1 file changed, 1 insertion(+), 1 deletion(-)=0A=
>=0A=
> diff --git a/target/arm/cpu.h b/target/arm/cpu.h=0A=
> index 63934a200ad..a68bcc9fedb 100644=0A=
> --- a/target/arm/cpu.h=0A=
> +++ b/target/arm/cpu.h=0A=
> @@ -2512,7 +2512,7 @@ bool write_cpustate_to_list(ARMCPU *cpu);=0A=
>=0A=
>  #if defined(TARGET_AARCH64)=0A=
>  #  define TARGET_PHYS_ADDR_SPACE_BITS 48=0A=
> -#  define TARGET_VIRT_ADDR_SPACE_BITS 64=0A=
> +#  define TARGET_VIRT_ADDR_SPACE_BITS 48=0A=
>  #else=0A=
>  #  define TARGET_PHYS_ADDR_SPACE_BITS 40=0A=
>  #  define TARGET_VIRT_ADDR_SPACE_BITS 32=0A=
>=0A=
=0A=
This change breaks qemu-aarch64 (using LTP test suite):=0A=
=0A=
# chroot chroot/arm64/bionic /opt/ltp/testcases/bin/access03=0A=
tst_test.c:1015: INFO: Timeout per run is 0h 05m 00s=0A=
qemu-aarch64: .../qemu/accel/tcg/translate-all.c:2522: page_check_range: As=
sertion `start < ((target_ulong)1 << L1_MAP_ADDR_SPACE_BITS)' failed.=0A=
qemu:handle_cpu_signal received signal outside vCPU context @ pc=3D0x600015=
54=0A=
=0A=
Any idea?=0A=
Thanks,=0A=
Laurent=0A=
