Received: from eggs.gnu.org ([2001:4830:134:3::10]:40191)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cgxq2-0004jP-C6
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 13:09:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cgxq1-0000rU-4O
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 13:09:58 -0500
Received: from mail-wr0-x234.google.com ([2a00:1450:400c:c0c::234]:36705)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cgxq0-0000rL-Tr
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 13:09:57 -0500
Received: by mail-wr0-x234.google.com with SMTP id 89so26727039wrr.3
	for <qemu-devel@nongnu.org>; Thu, 23 Feb 2017 10:09:56 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1487722868-9111-9-git-send-email-yongbok.kim@imgtec.com>
References: <1487722868-9111-1-git-send-email-yongbok.kim@imgtec.com>
	<1487722868-9111-9-git-send-email-yongbok.kim@imgtec.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 23 Feb 2017 18:09:35 +0000
Message-ID: <CAFEAcA_314UcvxXFPw7XkXnEqDCRWEvPdPRLgGKZJTU+-eg+9g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PULL v2 8/8] hw/mips: MIPS Boston board support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Yongbok Kim <yongbok.kim@imgtec.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 22 February 2017 at 00:21, Yongbok Kim <yongbok.kim@imgtec.com> wrote:
> From: Paul Burton <paul.burton@imgtec.com>
>
> Introduce support for emulating the MIPS Boston development board. The
> Boston board is built around an FPGA & 3 PCIe controllers, one of which
> is connected to an Intel EG20T Platform Controller Hub. It is used
> during the development & debug of new CPUs and the software intended to
> run on them, and is essentially the successor to the older MIPS Malta
> board.
>
> This patch does not implement the EG20T, instead connecting an already
> supported ICH-9 AHCI controller. Whilst this isn't accurate it's enough
> for typical stock Boston software (eg. Linux kernels) to work with hard
> disks given that both the ICH-9 & EG20T implement the AHCI
> specification.
>
> Boston boards typically boot kernels in the FIT image format, and this
> patch will treat kernels provided to QEMU as such. When loading a kernel
> directly, the board code will generate minimal firmware much as the
> Malta board code does. This firmware will set up the CM, CPC & GIC
> register base addresses then set argument registers & jump to the kernel
> entry point. Alternatively, bootloader code may be loaded using the bios
> argument in which case no firmware will be generated & execution will
> proceed from the start of the boot code at the default MIPS boot
> exception vector (offset 0x1fc00000 into (c)kseg1).
>
> Currently real Boston boards are always used with FPGA bitfiles that
> include a Global Interrupt Controller (GIC), so the interrupt
> configuration is only defined for such cases. Therefore the board will
> only allow use of CPUs which implement the CPS components, including the
> GIC, and will otherwise exit with a message.
>
> +static void boston_mach_class_init(MachineClass *mc)
> +{
> +    mc->desc = "MIPS Boston";
> +    mc->init = boston_mach_init;
> +    mc->block_default_type = IF_IDE;
> +    mc->default_ram_size = 2 * G_BYTE;
> +    mc->max_cpus = 16;
> +}

I only just noticed, but this breaks "make check" on 32-bit hosts:

TEST: tests/qom-test... (pid=16740)
  /mips64el/qom/boston:
qemu-system-mips64el: at most 2047 MB RAM can be simulated
Broken pipe
FAIL

because vl.c has
        /* On 32-bit hosts, QEMU is limited by virtual address space */
        if (ram_size > (2047 << 20) && HOST_LONG_BITS == 32) {
            error_report("at most 2047 MB RAM can be simulated");
            exit(1);
        }

Unfortunately I didn't notice before I pushed your pull request.
Luckily this is the last patch in the pullreq, so I can just
revert this one commit (d3473e147a754e999718bf6fcb015d9978c6a1ee)...

Please fix the board model patch and resend it. You'll need
the board to default to a ram size that works on all hosts.

(I'm taking the revert option because we're getting pretty
close to freeze and I have a bunch of pull requests in the
queue that I'd prefer not to delay while we fix this up.)

thanks
-- PMM
