Received: from eggs.gnu.org ([209.51.188.92]:33178)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1gs6jV-0005hh-C5
	for qemu-devel@nongnu.org; Fri, 08 Feb 2019 09:02:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1gs6jU-0003LM-I0
	for qemu-devel@nongnu.org; Fri, 08 Feb 2019 09:02:21 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34042)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lvivier@redhat.com>) id 1gs6jU-0003Kt-CJ
	for qemu-devel@nongnu.org; Fri, 08 Feb 2019 09:02:20 -0500
References: <20190201160653.13829-1-peter.maydell@linaro.org>
	<20190201160653.13829-44-peter.maydell@linaro.org>
From: Laurent Vivier <lvivier@redhat.com>
Message-ID: <767a2e82-acf4-d282-30a2-a3f5889c01f9@redhat.com>
Date: Fri, 8 Feb 2019 15:02:15 +0100
MIME-Version: 1.0
In-Reply-To: <20190201160653.13829-44-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org, Remi Denis-Courmont <remi.denis.courmont@huawei.com>, Richard Henderson <richard.henderson@linaro.org>

On 01/02/2019 17:06, Peter Maydell wrote:
> From: Remi Denis-Courmont <remi.denis.courmont@huawei.com>
> 
> Since QEMU does not support the ARMv8.2-LVA, Large Virtual Address,
> extension (yet), the VA address space is 48-bits plus a sign bit. User
> mode can only handle the positive half of the address space, so that
> makes a limit of 48 bits.
> 
> (With LVA, it would be 53 and 52 bits respectively.)
> 
> The incorrectly large address space conflicts with PAuth instructions,
> which use bits 48-54 and 56-63 for the pointer authentication code. This
> also conflicts with (as yet unsupported by QEMU) data tagging and with
> the ARMv8.5-MTE extension.
> 
> Signed-off-by: Remi Denis-Courmont <remi.denis.courmont@huawei.com>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/arm/cpu.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/target/arm/cpu.h b/target/arm/cpu.h
> index 63934a200ad..a68bcc9fedb 100644
> --- a/target/arm/cpu.h
> +++ b/target/arm/cpu.h
> @@ -2512,7 +2512,7 @@ bool write_cpustate_to_list(ARMCPU *cpu);
>  
>  #if defined(TARGET_AARCH64)
>  #  define TARGET_PHYS_ADDR_SPACE_BITS 48
> -#  define TARGET_VIRT_ADDR_SPACE_BITS 64
> +#  define TARGET_VIRT_ADDR_SPACE_BITS 48
>  #else
>  #  define TARGET_PHYS_ADDR_SPACE_BITS 40
>  #  define TARGET_VIRT_ADDR_SPACE_BITS 32
> 

This change breaks qemu-aarch64 (using LTP test suite):

# chroot chroot/arm64/bionic /opt/ltp/testcases/bin/access03
tst_test.c:1015: INFO: Timeout per run is 0h 05m 00s
qemu-aarch64: .../qemu/accel/tcg/translate-all.c:2522: page_check_range: Assertion `start < ((target_ulong)1 << L1_MAP_ADDR_SPACE_BITS)' failed.
qemu:handle_cpu_signal received signal outside vCPU context @ pc=0x60001554

Any idea?
Thanks,
Laurent
