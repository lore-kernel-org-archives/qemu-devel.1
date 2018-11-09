Received: from eggs.gnu.org ([2001:4830:134:3::10]:38002)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhijianx.li@intel.com>) id 1gL3YC-0005dT-QY
	for qemu-devel@nongnu.org; Fri, 09 Nov 2018 04:58:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhijianx.li@intel.com>) id 1gL3Y8-00016g-PH
	for qemu-devel@nongnu.org; Fri, 09 Nov 2018 04:58:04 -0500
Received: from mga06.intel.com ([134.134.136.31]:57680)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <zhijianx.li@intel.com>)
	id 1gL3Y8-00015T-FJ
	for qemu-devel@nongnu.org; Fri, 09 Nov 2018 04:58:00 -0500
References: <1541674784-25936-1-git-send-email-lizhijian@cn.fujitsu.com>
	<1541674784-25936-2-git-send-email-lizhijian@cn.fujitsu.com>
	<CAFEAcA_47wyar3WNhuBmNPdr02RHx-wn_TeyFaajpjzvzG8j5Q@mail.gmail.com>
	<c50d103e-95c3-c44c-d852-b6d7f8114b3a@cn.fujitsu.com>
	<20181109072015.GA86700@gmail.com>
From: Li Zhijian <zhijianx.li@intel.com>
Message-ID: <38905d35-29af-b522-1629-b13e98a47a42@intel.com>
Date: Fri, 9 Nov 2018 17:57:50 +0800
MIME-Version: 1.0
In-Reply-To: <20181109072015.GA86700@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [RFC/PoC PATCH 1/3] i386: set initrd_max to 4G - 1
 to allow up to 4G initrd
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ingo Molnar <mingo@kernel.org>, Li Zhijian <lizhijian@cn.fujitsu.com>, Juergen Gross <jgross@suse.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, x86@kernel.org, hpa@zytor.com, bp@alien8.de, mingo@redhat.com, tglx@linutronix.de, QEMU Developers <qemu-devel@nongnu.org>, Philip Li <philip.li@intel.com>, linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Kees Cook <keescook@chromium.org>

On 11/9/2018 3:20 PM, Ingo Molnar wrote:
> * Li Zhijian <lizhijian@cn.fujitsu.com> wrote:
>
>>> If the kernel initrd creation process creates an initrd which
>>> is larger than 2GB and also claims that it can't be placed
>>> with any part of it above 2GB, then that sounds like a bug
>>> in the initrd creation process...
>> Exactly, it's a real problem.
>>
>> Add x86 maintainers and LKML:
>>
>> The background is that QEMU want to support up to 4G initrd. but linux header (
>> initrd_addr_max field) only allow 2G-1.
>> Is one of the below approaches reasonable:
>> 1) change initrd_addr_max to 4G-1 directly simply(arch/x86/boot/header.S)?
>> 2) lie QEMU bootloader the initrd_addr_max is 4G-1 even though header said 2G-1
>> 3) any else
> A 10 years old comment from hpa says:
>
>    initrd_addr_max: .long 0x7fffffff
>                                          # (Header version 0x0203 or later)
>                                          # The highest safe address for
>                                          # the contents of an initrd
>                                          # The current kernel allows up to 4 GB,
>                                          # but leave it at 2 GB to avoid
>                                          # possible bootloader bugs.
>
> To avoid the potential of bugs lurking in dozens of major and hundreds of
> minor iterations of various Linux bootloaders I'd prefer a real solution
> and extend it - because if there's a 2GB initrd for some weird reason
> today there might be a 4GB one in two years.

thank a lots. that's amazing.


>
> The real solution would be to:
>
>   - Extend the boot protocol with a 64-bit field, named initrd_addr64_max
>     or such.
>   - We don't change the old field - but if the new field is set by new
>     kernels then new bootloaders can use that as a new initrd_addr64_max
>     value. (or reject to load the kernel if the address is too high.)
>
>   - The kernel build should also emit a warning when building larger than
>     2GB initrds, with a list of bootloaders that support the new protocol.

Actually i just knew QEMU(Seabios + optionrom(linuxboot_dma.bin)) can support ~4GB initrd so far.

i just drafted at patch to add this field. could you have a look.
another patch which is to document initrd_addr64_max is ongoing.

commit db463ac9c1975f115d1ce2acb82d530c2b63b888
Author: Li Zhijian <lizhijian@cn.fujitsu.com>
Date:   Fri Nov 9 17:24:14 2018 +0800

     x86: Add header field initrd_addr64_max
     
     Years ago, kernel had support load ~4GB initrd. But for some weird reasons (
     avoid possible bootloader bugs), it only allow leave initrd under 2GB address
     space(see initrd_addr_max fild at arch/x86/boot/header.S).
     
     So modern bootloaders have not chance to load >=2G initrd previously.
     
     To avoid the potential of bugs lurking in dozens of major and hundreds of
     minor iterations of various Linux bootloaders. Ingo suggests to add a new field
     initrd_addr64_max. If bootloader believes that it can load initrd to >=2G
     address space, it can use initrd_addr64_max as the maximum loading address in
     stead of the old field initrd_addr_max.

diff --git a/arch/x86/boot/header.S b/arch/x86/boot/header.S
index 4c881c8..5fc3ebe 100644
--- a/arch/x86/boot/header.S
+++ b/arch/x86/boot/header.S
@@ -300,7 +300,7 @@ _start:
         # Part 2 of the header, from the old setup.S
  
                 .ascii  "HdrS"          # header signature
-               .word   0x020e          # header version number (>= 0x0105)
+               .word   0x020f          # header version number (>= 0x0105)
                                         # or else old loadlin-1.5 will fail)
                 .globl realmode_swtch
  realmode_swtch:        .word   0, 0            # default_switch, SETUPSEG
@@ -562,6 +562,12 @@ acpi_rsdp_addr:            .quad 0                 # 64-bit physical pointer to the
                                                 # ACPI RSDP table, added with
                                                 # version 2.14
  
+#ifdef CONFIG_INITRD_SIZE_4GB
+initrd_addr64_max:     .quad 0xffffffff        # allow ~4G initrd since 2.15
+#else
+initrd_addr64_max:     .quad 0
+#endif
+
  # End of setup header #####################################################
  
         .section ".entrytext", "ax"
diff --git a/arch/x86/include/uapi/asm/bootparam.h b/arch/x86/include/uapi/asm/bootparam.h
index 22f89d0..b86013d 100644
--- a/arch/x86/include/uapi/asm/bootparam.h
+++ b/arch/x86/include/uapi/asm/bootparam.h
@@ -90,6 +90,7 @@ struct setup_header {
         __u32   init_size;
         __u32   handover_offset;
         __u64   acpi_rsdp_addr;
+       __u64   initrd_addr64_max;
  } __attribute__((packed));
  
  struct sys_desc_table {
diff --git a/init/Kconfig b/init/Kconfig
index a4112e9..611d4af 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1080,6 +1080,14 @@ config BLK_DEV_INITRD
  
           If unsure say Y.
  
+config INITRD_SIZE_4GB
+       bool "4G size initrd support"
+       depends on (X86 || X86_64)
+       help
+         This option enables support ~4GB initrd.
+
+         if unsure say N.
+
  if BLK_DEV_INITRD
  
  source "usr/Kconfig"

Thanks
Zhijian




> Or something along those lines.
>
> Thanks,
>
> 	Ingo
