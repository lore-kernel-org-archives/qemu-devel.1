Received: from eggs.gnu.org ([2001:4830:134:3::10]:42181)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <javierm@redhat.com>) id 1dX1xZ-000883-6Y
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 05:04:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <javierm@redhat.com>) id 1dX1xV-0004LW-V0
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 05:04:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42062)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <javierm@redhat.com>) id 1dX1xV-0004Kj-LI
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 05:04:53 -0400
References: <eef9a031-36e9-0443-1d73-30a49df02e9a@redhat.com>
From: Javier Martinez Canillas <javierm@redhat.com>
Message-ID: <1c955fdc-90d5-4bdd-3518-815595bbfd70@redhat.com>
Date: Mon, 17 Jul 2017 11:04:44 +0200
MIME-Version: 1.0
In-Reply-To: <eef9a031-36e9-0443-1d73-30a49df02e9a@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] investigating TPM for OVMF-on-QEMU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laszlo Ersek <lersek@redhat.com>, Jiewen Yao <jiewen.yao@intel.com>, Stefan Berger <stefanb@linux.vnet.ibm.com>, Peter Jones <pjones@redhat.com>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, Amarnath Valluri <amarnath.valluri@intel.com>
Cc: edk2-devel-01 <edk2-devel@lists.01.org>, qemu devel list <qemu-devel@nongnu.org>

Hello Laszlo,

Thanks a lot for the great summary.

On 07/14/2017 08:04 PM, Laszlo Ersek wrote:

[snip]

> 
>      Here I should mention some ACPI and hardware aspects. Under TPM1
>      (whose ACPI table was called "TCPA"), the TPM events (measurements
>      I think) were logged in a reserved memory area described by the
>      TCPA table. Under TPM2, the "TPM2" ACPI table does no such thing,
>      it only helps identify the communication characteristics of the
>      device, and the event log itself is accessible to the OS boot
>      loader via the EFI_TCG2_PROTOCOL.
> 
>      (If you are curious how a legacy BIOS boot loader is supposed to
>      read the event log from a TPM2-only device (no "TCPA" table): I
>      don't have the slightest clue.)
>

The latest "TCG ACPI Specification" draft from February 27, 2017 mentions that
the TPM2 table contains the LAML and LASA fields for the TPM event logs memory
area. But as Stefan pointed out this is just a draft, and has this disclaimer:

"Work in Progress:
This document is an intermediate draft for comment only and is subject to change
without notice. Readers should not design products based on this document."

So I think that will be supported in the future (if the draft doesn't change and
is published).
 
>      I'm not sure about the exact characteristics of the virtual TPM
>      that Stefan's swtpm project:
> 
>        https://github.com/stefanberger/swtpm
> 
>      combined with Amarnath's pending QEMU patches:
> 
>        http://mid.mail-archive.com/1496666711-14630-1-git-send-email-amarnath.valluri@intel.com
> 
>      will expose to the guest. What I do know is that the current QEMU
>      solution, which mostly forwards a physical (host) TPM to the guest,
>      produces a "TPM2" ACPI table if said host TPM device is TPM2. The
>      "TPM2" table is exposed to the guest OS with OVMF's help, and has
>      the following fields:
> 
>      - address of control area: zero
>      - start method: 6 (TIS plus Cancel)
>      - platform specific params: none.
> 
>      This implies that neither ACPI activation (method 2) nor Command
>      Response Buffer activation (method 7) nor a combination of these
>      two (method 8) is available in QEMU.
> 

Even when QEMU always exposes a start method 6 (TIS + cancel) in its TPM2 table
to the guest, pass-through works when the host TPM advertises a different start
method.

For example I've a laptop with an Intel PTT fTPM and the start method is 2, but
I'm able to access the host TPM2 from the guest using the Linux tpm_tis driver.

> 
>      In brief, by not including these two modules, we avoid a "TPM2"
>      ACPI table duplication. We also turn off the Memory Overwrite
>      Request and Physical Presence Interface features -- which are both
>      optional, as far as I can see, and very messy for OVMF's platform
>      code.
> 

Agreed.

> (3) Drivers (and features) that are *not in edk2/SecurityPkg/Tcg:
> 
>     The Intel whitepaper discusses (and Peter also mentioned earlier)
>     "dTPM" versus "fTPM".
> 
>     "dTPM" is basically TPM provided in publicly specified hardware,
>     where the firmware can offer support, such as EFI_TCG2_PROTOCOL, but
>     the OS can also directly drive the hardware. This is what QEMU
>     offers with the TIS+Cancel start method (value 6). (The "Command
>     Response Buffer" start method (value 7) would also qualify as
>     "dTPM"). When the platform provides "dTPM", the _DSM method
>     described above *may* be offered, but it is not required.
> 
>     "fTPM" is where the hardware is completely hidden from the OS, and
>     is implemented fully in firmware. The corresponding start method
>     values are 2 ("ACPI") and 8 ("ACPI with CRB"). In this case, the
>     _DSM method is *required*.
> 
>     To my understanding, edk2 contains no "fTPM" implementation. The
>     in-tree drivers recognize hardware that describes itself as
>     TIS+Cancel (6) or CRB (7). Pure ACPI variants are neither recognized
>     nor offered.
> 

That's my understanding as well. I see that the Valley View 2 / Minnowboard Max
platform pkg (Vlv2TbltDevicePkg) as references to fTPM and a FTPM_ENABLE var to
enable it, but IIUC the fTPM driver is distributed as proprietary binary files:

https://firmware.intel.com/projects/minnowboard-max

>     I think TIS+Cancel / dTPM is the best match: the emulated TPM has to
>     be implemented in virtual hardware (not just faked within the guest,
>     in RAM), so that QEMU can secure the sensitive stuff from guest
>     kernel level access.
> 

Agreed.

Best regards,
-- 
Javier Martinez Canillas
Software Engineer - Desktop Hardware Enablement
Red Hat
