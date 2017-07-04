Received: from eggs.gnu.org ([2001:4830:134:3::10]:60832)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1dSUjy-0002Sy-9N
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 16:48:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1dSUjv-0006y4-4b
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 16:48:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39478)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1dSUju-0006xO-SJ
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 16:48:07 -0400
References: <1498759215-25382-1-git-send-email-stefanb@linux.vnet.ibm.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <596e2782-cf4f-952a-4d0a-6bf51a8a9e48@redhat.com>
Date: Tue, 4 Jul 2017 22:47:59 +0200
MIME-Version: 1.0
In-Reply-To: <1498759215-25382-1-git-send-email-stefanb@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] specs: Describe the TPM support in QEMU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Berger <stefanb@linux.vnet.ibm.com>, qemu-devel@nongnu.org
Cc: javierm@redhat.com

On 06/29/17 20:00, Stefan Berger wrote:
> This patch adds a description of the current TPM support in QEMU
> to the specs.
> 
> Several public specs are referenced via their landing page on the
> trustedcomputinggroup.org website.
> 
> Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
> ---
>  docs/specs/tpm.txt | 98 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 98 insertions(+)
>  create mode 100644 docs/specs/tpm.txt
> 
> diff --git a/docs/specs/tpm.txt b/docs/specs/tpm.txt
> new file mode 100644
> index 0000000..6472989
> --- /dev/null
> +++ b/docs/specs/tpm.txt
> @@ -0,0 +1,98 @@
> +
> +QEMU TPM Device
> +===============
> +
> += Guest-side Hardware Interface =
> +
> +The QEMU TPM emulation implements a TPM TIS hardware interface following
> +the Trusted Computing Group's specification "TCG PC Client Specific TPM
> +Interface Specification (TIS)", Specifcation Version 1.3, 21 March 2013.
> +This specification, or a later version of it, can be accessed from the
> +following URL:
> +
> +https://trustedcomputinggroup.org/pc-client-work-group-pc-client-specific-tpm-interface-specification-tis/
> +
> +The TIS interface makes a memory mapped IO region in the area 0xfed40000 -
> +0xfed44fff available to the guest operating system.
> +
> +
> +QEMU files related to TPM TIS interfaceL

... OK, Eric mentioned the typo already

> + - hw/tpm/tpm_tis.c
> + - hw/tpm/tpm_tis.h
> +
> +
> += ACPI Interface =
> +
> +The TPM device is defined with ACPI ID "PNP0C31". QEMU builds a SSDT and passes
> +it into the guest through the fw_cfg device. The device description contains
> +the base address of the TIS interface 0xfed40000 and the size of the MMIO area
> +(0x5000). In case a TPM2 is used by QEMU, a TPM2 ACPI table is also provided.
> +The device is described to be used in polling mode rather than interrupt mode
> +primarily because no unused IRQ could be found.
> +
> +To support measurement logs to be written by the firmware, e.g. SeaBIOS, a TCPA
> +table is implemented. This table provides a 64kb buffer where the firmware can
> +write its log into. For TPM 2 only a more recent version of the TPM2 table
> +provides support for measurements logs and a TCPA table does not need to be
> +created.
> +
> +The TCPA and TPM2 ACPI tables follow the Trusted Computing Group specification
> +"TCG ACPI Specification" Family "1.2" and "2.0", Level 00 Revision 00.37. This
> +specification, or a later version of it, can be accessed from the following
> +URL:
> +
> +https://trustedcomputinggroup.org/tcg-acpi-specification/
> +
> +
> +QEMU files related to TPM ACPI tables:
> + - hw/i386/acpi-build.c
> + - include/hw/acpi/tpm.h
> +
> +
> += TPM backend devices =
> +
> +The TPM implementation is split into two parts, frontend and backend. 

git-am complains that this line adds a whitespace error (trailing space,
namely).

> +The frontend part is the hardware interface, such as the TPM TIS interface
> +described earlier, and the other part is the TPM backend interface. The
> +backend interfaces implement the interaction with a TPM device,
> +which may be a physical or an emulated device. The split between the front-
> +and backend devices allows a frontend to be connected with any available
> +backend. This enables the TIS interface to be used with the passthrough
> +backend or the swtpm backend.

In the previous (RFC-like) version, you wrote "(future) swtpm" -- I
think that would be more precise. When QEMU gets swtpm support, we can
update this language (because we should update the filename list(s) as
well). What do you think?

> +
> +
> +QEMU file related to TPM backends:

s/file/files/

> + - backends/tpm.c
> + - include/sysemu/tpm_backend.h
> + - include/sysemu/tpm_backend_int.h

Is this generic backend code? Because for the passthrough backend, you
provide a separate file list below (which is great, but then we should
qualify *this* list as "generic" or some such).

> +
> +
> +== The QEMU TPM passthrough device ==
> +
> +In case QEMU is run on Linux as the host operating system it is possible to
> +make the hardware TPM device available to a single QEMU guest. In this case the
> +user must make sure that no other program is using the device, e.g., /dev/tpm0,
> +before trying to start QEMU with it.
> +
> +The passthrough driver uses the host's TPM device for sending TPM commands
> +and receiving responses from. Besides that it accesses the TPM device's sysfs
> +entry for support of command cancellation. Since none of the state of a hardware
> +TPM can be migrated between hosts, virtual machine migration is disabled when
> +the TPM passthrough driver is used.
> +
> +Since the host's TPM device will already be initialize by the host's firmware,

s/initialize/initialized/

... ah, also pointed out by Eric.

> +certain commands, e.g. TPM_Startup(), sent by the virtual firmware for device
> +initialization, will fail. In this case the firmware should simply not use the
> +TPM.
> +
> +Sharing the device with the host is generally not a recommended usage scenario
> +for a TPM device. The primary reason for this is that two operating systems can
> +then access the device's single set of resources, such as platform configuration
> +registers (PCRs). Applications or kernel security subsystems, such as the
> +Linux Integrity Measurement Architecture (IMA), are not expecting to share PCRs.
> +
> +
> +QEMU files related to TPM passthrough device:
> + - hw/tpm/tpm_passthrough.c
> + - hw/tpm/tpm_util.c
> + - hw/tpm/tpm_util.h
> 

This looks very helpful, thank you, and mostly done (as far as I'm
concerned).

Again, if you were willing to add command line options as examples, that
would be great, but if not, I'm fine (and thankful) that way as well.

Thanks!
Laszlo
