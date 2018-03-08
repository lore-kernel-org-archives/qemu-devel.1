Received: from eggs.gnu.org ([2001:4830:134:3::10]:38797)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1ettRo-0007f5-Rz
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 06:10:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1ettRl-0004XS-IW
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 06:10:56 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:54838 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1ettRl-0004W8-BZ
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 06:10:53 -0500
References: <20180307144951.d75lo5rgzi2vf27z@eukaryote>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <90ba320e-2a05-8962-dc6b-252b3e15d1b7@redhat.com>
Date: Thu, 8 Mar 2018 12:10:30 +0100
MIME-Version: 1.0
In-Reply-To: <20180307144951.d75lo5rgzi2vf27z@eukaryote>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC] Defining firmware (OVMF,
 et al) metadata format & file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kashyap Chamarthy <kchamart@redhat.com>, qemu-devel@nongnu.org, libvir-list@redhat.com
Cc: kraxel@redhat.com, "Daniel P. Berrange" <berrange@redhat.com>, Ard Biesheuvel <ard.biesheuvel@linaro.org>

(
Ard, the thread starts here:

http://mid.mail-archive.com/20180307144951.d75lo5rgzi2vf27z@eukaryote
)

On 03/07/18 15:49, Kashyap Chamarthy wrote:
> Problem background
> ------------------
> 
> The various OVMF binary file names and paths are slightly different[+]
> for each Linux distribution.  And each high-level management tool
> (libguestfs, oVirt, `virt-manager` and OpenStack Nova) is inventing its
> own approach to detect and configure the said OVMF files.  This email
> thread is about arriving at some common understanding to make this a bit
> more "unified" by addressing these needs in QEMU and libvirt.

I've read Dan's message <20180307151836.GK20201@redhat.com> and Gerd's
messages <20180308075245.lgzredyhn2paawg4@sirius.home.kraxel.org>,
<20180308074507.nwho4tddsoxb3b7v@sirius.home.kraxel.org>.

Those seem to cover everything, I don't have anything to add wrt.
purpose, use case, flexibility etc.

I suggest (or agree) that the property list be composed of free-form
name=value pairs (at least conceptually). I understand Gerd is proposing
a QAPI schema for this, so maybe do { property_name : "foo",
property_value : "bar" }, or similar. The registry of properties (names,
possible values, meanings) should be kept separate (although possibly
still under QEMU).

For OVMF (x86), I guess the initial set of properties should come from
the "-D FOO[=BAR]" build flags that OVMF currently supports. (The list
might grow or change incompatibly over time, so this is just a raw
starter idea.)

We have:

(0) ARCH (one of IA32, IA32X64, X64) -- the bitnesses of the PEI and DXE
phases of the firmware.

IA32 stands for "32-bit PEI and DXE". Such firmware is usable for
booting 32-bit OSes only, and runs on both qemu-system-i386 and
qemu-system-x86_64.

IA32X64 stands for "32-bit PEI, 64-bit DXE". Needs qemu-system-x86_64
and runs 64-bit OSes only.

X64 stands for "64-bit PEI and DXE". Needs qemu-system-x86_64 and runs
64-bit OSes only.


(1) SECURE_BOOT_ENABLE (boolean) -- whether the Secure Boot UEFI feature
is built into the firmware image.

This decides whether the Secure Boot software interfaces will be
available to the guest OS. Turning on just this flag does not imply that
the guest OS cannot circumvent the SB software interfaces by direct
(guest kernel) access to the pflash chip.


(2) SMM_REQUIRE (boolean) -- whether the SMM driver stack is included in
the firmware.

If this flag is enabled, then SMM emulation is required from the board
(implying Q35), otherwise the firmware will not boot.

If enabled in combination with SECURE_BOOT_ENABLE, *and* the "secure"
property of the "cfi.pflash01" driver is set to "on", then the
circumvention under (1) is prevented by QEMU, and Secure Boot becomes
actually secure.

Regarding 32-bit x86 (qemu-system-i386), the compatible CPU models are
strongly limited; one model that works is "coreduo", but the NX flag has
to be disabled even on that.

If ARCH (from under (0)) is X64, and SMM_REQUIRE is enabled, then ACPI
S3 suspend/resume has to be disabled ("disable_s3" property of the
"ICH9-LPC" driver), otherwise the firmware will not boot. IA32 and
IA32X64 are not limited like this.


(3) HTTP_BOOT_ENABLE (boolean) -- whether UEFI HTTP boot is available in
the firmware image, in addition to the default PXE boot.


(4) TLS_ENABLE (boolean) -- configurable independently of
HTTP_BOOT_ENABLE, but only really makes sense in combination.

Determines whether HTTPS boot is available in the firmware image.


(5) NETWORK_IP6_ENABLE (boolean) -- determines whether IPv6 support is
available.

Orthogonal to all of: PXE, HTTP, HTTPS boot.


(6) FD_SIZE_IN_KB (one of: 1024, 2048, 4096) -- the size of the combined
firmware image (executable portion and variable store together), in KB.

(Boolean shorthands are FD_SIZE_1MB, FD_SIZE_2MB, FD_SIZE_4MB.)

Firmware images where this value is 1024 and 2048 are "compatible" with
each other in the sense that the variable store files they use are
identically structured. The variable store files are 128KB in size, and
the actual variable space they offer is 56KB. This is generally
sufficient for a low number of UEFI variables, and very basic key
enrollment for Secure Boot.

A firmware image where the value is 4096 is incompatible. The variable
store file is 528KB in size, and the actual variable space it offers is
256KB. This is considered "generous" by recent-ish industry practice,
and it is large enough for passing the Microsoft SVVP test cases related
to Secure Boot. (Obviously there are other requirements presented by
those test cases; I'm just saying that the size requirement is satisfied.)

The variable store template files are pre-formatted in all cases
(meaning "wire format" only -- on a logical level, they are "empty").
Under some circumstances, it could be desirable to provide varstore
template files that are pre-populated with various certificates
enrolled. It might make sense to describe such facts with another property.


(7) DEBUG_ON_SERIAL_PORT (boolean) -- whether OVMF sends its debug
messages to the QEMU debug IO port, or to the serial port.


(8) SOURCE_DEBUG_ENABLE (boolean) -- whether OVMF includes the edk2
debug agent that allows it to be debugged from a proprietary debugger
program, likely connected via the emulated serial port.


(9) CSM_ENABLE (boolean) -- whether OVMF includes traditional BIOS
support, by including the SeaBIOS Compatibility Support Module.

Including the SeaBIOS CSM makes OVMF capable of booting traditional (not
UEFI) OS-es. Such boots are never covered by Secure Boot.

Given that the SeaBIOS CSM itself can be built with various
configurations, it might make sense to list further properties when this
property is enabled.


(10) E1000_ENABLE (boolean) -- whether OVMF includes the
non-redistributable, binary only E1000(E) UEFI driver module from Intel
(previously known as "PROEFI", more recently known as "BootUtil").

This driver can drive QEMU's e1000 and e1000e cards for network booting,
which is why the option exists at all.


(11) USE_OLD_SHELL (boolean) -- whether the UEFI shell implementation
built into OVMF is the old (EDK1 / EFI-1 style) shell which lives in a
separate repository, or the new (EDK2 / UEFI-2 style) shell which lives
within the edk2 project.


(12) TOOLCHAIN (string): the edk2 toolchain identifier with which the
firmware was built.

(13) TARGET (one of NOOPT, DEBUG, RELEASE) -- the target for which the
firmware image was built.

NOOPT means "no optimization, DEBUG msgs/ASSERTs enabled".
DEBUG means "optimization enabled, DEBUG msgs/ASSERTs enabled".
RELEASE means "optimization enabled, DEBUG msgs/ASSERTs disabled".



For ArmVirt, we have:

(12) ARCH (one of ARM and AARCH64) -- 32-bit / 64-bit distinction.

Mixed PEI and DXE bitness is not used, unlike on x86.


(13, 14) TOOLCHAIN and TARGET -- see (12) and (13) above

(15) SECURE_BOOT_ENABLE (boolean) -- see (1).

Note that SMM_REQUIRE (or its architectural match on ARM/AARCH64) is
currently not supported in the ArmVirt firmwares, hence the Secure Boot
feature should only be included in the firmware for development /
testing purposes.

(16) HTTP_BOOT_ENABLE (boolean) -- see (3).

(17) Well, what do I call this, let's call it ENTRY_POINT (one of Qemu,
QemuKernel, Xen).

This distinguishes what VMM the ArmVirt firmware was built for, and for
QEMU, it also distinguishes "boot from flash" (Qemu) or "boot as payload
for another, earlier boot firmware" (QemuKernel).


In the above, I tried to be comprehensive; pick whatever you think makes
sense to track in the metadata files.

Since Dan mentions we should have a "just gimme EFI" shorthand, I can
try suggesting specific combinations:

- For x86:

property_name         property_value
--------------------  --------------
ARCH                  IA32X64
SECURE_BOOT_ENABLE    TRUE
SMM_REQUIRE           TRUE
HTTP_BOOT_ENABLE      TRUE
TLS_ENABLE            TRUE
NETWORK_IP6_ENABLE    TRUE
FD_SIZE_IN_KB         4096
DEBUG_ON_SERIAL_PORT  FALSE
SOURCE_DEBUG_ENABLE   FALSE
CSM_ENABLE            FALSE
E1000_ENABLE          FALSE
USE_OLD_SHELL         FALSE
TOOLCHAIN             GCC5
TARGET                DEBUG

This gives you a firmware image that requires Q35, with SMM emulation
enabled. Secure Boot, when configured in the guest, is actually secure.
Microsoft SVVP SB testing can be passed (with certificates properly
enrolled, in addition), if you need that. ACPI S3 is supported. All
kinds of netbooting are enabled (PXE, HTTP, HTTPS, over both IPv4 and
IPv6). Debug messages are sent to the QEMU debug port (not messing up
your serial port / terminal traffic). No proprietary or
proprietary-interfacing components included. A pure UEFI build; if you
need to boot a legacy OS, just use standalone SeaBIOS. Built with at
least gcc-5, hence LTO (link time optimization) was utilized, allowing
for better performance and better firmware space utilization. Debug
messages are logged and assertions are enforced. Only 64-bit OSes are
supported, qemu-system-x86_64 is required.

- For arm:

property_name         property_value
--------------------  --------------
ARCH                  AARCH64
TOOLCHAIN             GCC5
TARGET                DEBUG
SECURE_BOOT_ENABLE    FALSE
HTTP_BOOT_ENABLE      TRUE
ENTRY_POINT           QEMU

qemu-system-aarch64 is required, only 64-bit OSes are supported.
Toolchain/target: see above. Debug messages can only be sent to the
PL011 UART (no separate debug port on qemu-system-aarch64 / "virt").
Secure Boot is not included, because at this point it cannot be secured
in virtual hardware (no Management Mode equivalent just yet). Allow HTTP
booting, and build to be booted on QEMU from pflash.

Final note: variable store formats are entirely incompatible between
OVMF and ArmVirt.

Thanks,
Laszlo
