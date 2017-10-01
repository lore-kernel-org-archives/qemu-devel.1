Received: from eggs.gnu.org ([2001:4830:134:3::10]:51779)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1dyazL-0007V0-Fn
	for qemu-devel@nongnu.org; Sun, 01 Oct 2017 05:56:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1dyazI-0008CW-EC
	for qemu-devel@nongnu.org; Sun, 01 Oct 2017 05:56:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55784)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1dyazI-0008Bm-6w
	for qemu-devel@nongnu.org; Sun, 01 Oct 2017 05:56:40 -0400
From: Laszlo Ersek <lersek@redhat.com>
References: <69fd8746-b2bd-31d0-4d70-792f40ef2d79@amd.com>
	<20170926170901-mutt-send-email-mst@kernel.org>
	<2fb6e86d-5afa-d7f0-6f62-8f81db5a5419@amd.com>
	<20170927190724-mutt-send-email-mst@kernel.org>
	<927fedc3-a2c8-d37c-930e-11cecb7b0149@amd.com>
	<11d514ce-5752-d1a9-852c-9f091d2791e2@redhat.com>
	<210c74c8-5ced-94cd-2025-29f94c71fdf2@amd.com>
	<fc4e1267-0fd3-6412-b7af-5082b122c309@redhat.com>
Message-ID: <8377576a-000e-8a8e-9817-41bd39122efb@redhat.com>
Date: Sun, 1 Oct 2017 11:56:31 +0200
MIME-Version: 1.0
In-Reply-To: <fc4e1267-0fd3-6412-b7af-5082b122c309@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] libvirt/QEMU/SEV interaction
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: Brijesh Singh <brijesh.singh@amd.com>
Cc: Richard Relph <richard.relph@amd.com>, "Michael S. Tsirkin" <mst@redhat.com>, libvir-list@redhat.com, "Lendacky, Thomas" <Thomas.Lendacky@amd.com>, qemu-devel@nongnu.org
List-ID: <qemu-devel.nongnu.org>

On 10/01/17 11:17, Laszlo Ersek wrote:

> (3) Implement SEV encryption for pflash. A pflash chip can be in one of
> two modes: (a) it reads and executes as ROM, or (b) it behaves like a
> programmable (r/w) device with MMIO registers. Switching between both
> modes is explicit (see
> "OvmfPkg/QemuFlashFvbServicesRuntimeDxe/QemuFlash.c"); perhaps some SEV
> controls could be hooked in there.

Hmmm wait a second, we *already* execute code from pflash (namely SEC
code from OVMF_CODE.fd), and instruction fetch always entails decryption.

Furthermore, in SEC, we decompress PEI and DXE FVs from pflash
(OVMF_CODE.fd) to RAM -- the decompression code runs in long mode, plus
you modified the OVMF/X64 reset vector to set the C-bit in all PTEs,
covering the low 4GB of guest RAM.

This tells me that at least read and execute from pflash work with SEV
decryption already. Is this expected?

However, in PlatformPei, we don't report the varstore pflash range via
any resource descriptor HOB (the varstore chip is at [0xffc00000,
0xFFC84000) in the 4MB build).  Consequently, AmdSevDxe clears the C-bit
under the "NonExistent" branch:

AmdSevDxe:SetMemoryEncDec: Cr3Base=0x0 Physical=0xFEF00000
Length=0x1100000 Mode=Decrypt CacheFlush=0

Subsequently, "OvmfPkg/QemuFlashFvbServicesRuntimeDxe/FwBlockService.c"
adds the pflash range as EFI_MEMORY_UC | EFI_MEMORY_RUNTIME. The C-bit
remains clear, AIUI.

OK, I'm totally confused now. Looks like SEV decryption already works
for pflash (from SEC's example), and transparently at that (???), but we
fail to use it in QemuFlashFvbServicesRuntimeDxe?

Laszlo
