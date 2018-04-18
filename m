Received: from eggs.gnu.org ([2001:4830:134:3::10]:48431)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1f8ikV-0001I3-Uw
	for qemu-devel@nongnu.org; Wed, 18 Apr 2018 04:47:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1f8ikS-0006ij-M3
	for qemu-devel@nongnu.org; Wed, 18 Apr 2018 04:47:31 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:50504 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1f8ikS-0006ib-Fs
	for qemu-devel@nongnu.org; Wed, 18 Apr 2018 04:47:28 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20180417224054.26363-1-lersek@redhat.com>
Date: Wed, 18 Apr 2018 10:47:26 +0200
In-Reply-To: <20180417224054.26363-1-lersek@redhat.com> (Laszlo Ersek's
	message of "Wed, 18 Apr 2018 00:40:54 +0200")
Message-ID: <87po2wzysh.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [qemu RFC v2] qapi: add "firmware.json"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laszlo Ersek <lersek@redhat.com>
Cc: qemu-devel@nongnu.org, libvir-list@redhat.com, Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, Peter Krempa <pkrempa@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Michal Privoznik <mprivozn@redhat.com>, Kashyap Chamarthy <kchamart@redhat.com>, Alexander Graf <agraf@suse.de>, Gary Ching-Pang Lin <glin@suse.com>, Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, David Gibson <dgibson@redhat.com>

Mostly quick QAPI schema style review, as I know next to nothing about
the subject matter.

Laszlo Ersek <lersek@redhat.com> writes:

> Add a schema that describes the different uses and properties of virtual
> machine firmware.
>
> Each firmware executable installed on a host system should come with at
> least one JSON file that conforms to this schema. Each file informs the
> management applications about the firmware's properties and one possible
> use case / feature set.
>
> In addition, a configuration directory with symlinks to the JSON files
> should exist, with the symlinks carefully named to reflect a priority
> order. Management applications can then search this directory in priority
> order for the first firmware description that satisfies their search
> criteria. The found JSON file provides the management layer with domain
> configuration bits that are required to run the firmware binary for a
> certain use case or feature set.
>
> Cc: "Daniel P. Berrange" <berrange@redhat.com>
> Cc: Alexander Graf <agraf@suse.de>
> Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> Cc: David Gibson <dgibson@redhat.com>
> Cc: Eric Blake <eblake@redhat.com>
> Cc: Gary Ching-Pang Lin <glin@suse.com>
> Cc: Gerd Hoffmann <kraxel@redhat.com>
> Cc: Kashyap Chamarthy <kchamart@redhat.com>
> Cc: Markus Armbruster <armbru@redhat.com>
> Cc: Michael Roth <mdroth@linux.vnet.ibm.com>
> Cc: Michal Privoznik <mprivozn@redhat.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Peter Krempa <pkrempa@redhat.com>
> Cc: Peter Maydell <peter.maydell@linaro.org>
> Cc: Thomas Huth <thuth@redhat.com>
> Signed-off-by: Laszlo Ersek <lersek@redhat.com>
> ---
[...]
> diff --git a/qapi/firmware.json b/qapi/firmware.json
> new file mode 100644
> index 000000000000..3653b4628a5b
> --- /dev/null
> +++ b/qapi/firmware.json
> @@ -0,0 +1,503 @@
> +# -*- Mode: Python -*-
> +#
> +# Copyright (C) 2018 Red Hat, Inc.
> +#
> +# Authors:
> +#  Daniel P. Berrange <berrange@redhat.com>
> +#  Laszlo Ersek <lersek@redhat.com>
> +#
> +# This work is licensed under the terms of the GNU GPL, version 2 or later. See
> +# the COPYING file in the top-level directory.
> +
> +##
> +# = Firmware
> +##
> +
> +{ 'include' : 'block-core.json' }
> +
> +##
> +# @FirmwareType:
> +#
> +# Lists firmware types commonly used with QEMU virtual machines.
> +#
> +# @bios: The firmware was built from the SeaBIOS project.
> +#
> +# @slof: The firmware was built from the Slimline Open Firmware project.
> +#
> +# @uboot: The firmware was built from the U-Boot project.
> +#
> +# @uefi: The firmware was built from the edk2 (EFI Development Kit II) project.
> +#
> +# Since: 2.13
> +##
> +{ 'enum' : 'FirmwareType',
> +  'data' : [ 'bios', 'slof', 'uboot', 'uefi' ] }
> +
> +##
> +# @FirmwareDevice:
> +#
> +# Defines the device types that firmware can be mapped into.
> +#
> +# @flash: The firmware executable and its accompanying NVRAM file are to be
> +#         mapped into a pflash chip each.
> +#
> +# @kernel: The firmware is to be loaded like a Linux kernel. This is similar to
> +#          @memory but may imply additional processing that is specific to the
> +#          target architecture and machine type.
> +#
> +# @memory: The firmware is to be mapped into memory.
> +#
> +# Since: 2.13
> +##
> +{ 'enum' : 'FirmwareDevice',
> +  'data' : [ 'flash', 'kernel', 'memory' ] }
> +
> +##
> +# @FirmwareArchitecture:
> +#
> +# Defines the target architectures (emulator binaries) that firmware may
> +# execute on.
> +#
> +# @aarch64: The firmware can be executed by the qemu-system-aarch64 emulator.
> +#
> +# @arm: The firmware can be executed by the qemu-system-arm emulator.
> +#
> +# @i386: The firmware can be executed by the qemu-system-i386 emulator.
> +#
> +# @x86_64: The firmware can be executed by the qemu-system-x86_64 emulator.
> +#
> +# Since: 2.13
> +##
> +{ 'enum' : 'FirmwareArchitecture',
> +  'data' : [ 'aarch64', 'arm', 'i386', 'x86_64' ] }

Partial dupe of CpuInfoArch from misc.json.  Neither covers all our
target architectures.  Should we have one that does in common.json
instead?

> +
> +##
> +# @FirmwareTarget:
> +#
> +# Defines the machine types that firmware may execute on.
> +#
> +# @architecture: Determines the emulation target (the QEMU system emulator)
> +#                that can execute the firmware.
> +#
> +# @machines: Lists the machine types (known by the emulator that is specified
> +#            through @architecture) that can execute the firmware. Elements of
> +#            @machines are not supposed to be versioned; if a machine type is
> +#            versioned in QEMU (e.g. "pc-i440fx-2.12"), then its unversioned
> +#            variant, which typically refers to the latest version (e.g. "pc"),
> +#            should be listed in @machines. On the QEMU command line, "-machine
> +#            type=..." specifies the requested machine type.
> +#
> +# Since: 2.13
> +##
> +{ 'struct' : 'FirmwareTarget',
> +  'data'   : { 'architecture' : 'FirmwareArchitecture',
> +               'machines'     : [ 'str' ] } }
> +
> +##
> +# @FirmwareFeature:
> +#
> +# Defines the features that firmware may support, and the platform requirements
> +# that firmware may present.
> +#
> +# @acpi-s3: The firmware supports S3 sleep (suspend to RAM), as defined in the
> +#           ACPI specification. On the "pc" machine type of the @i386 and
> +#           @x86_64 emulation targets, S3 can be enabled with "-global
> +#           PIIX4_PM.disable_s3=0" and disabled with "-global
> +#           PIIX4_PM.disable_s3=1". On the "q35" machine type of the @i386 and
> +#           @x86_64 emulation targets, S3 can be enabled with "-global
> +#           ICH9-LPC.disable_s3=0" and disabled with "-global
> +#           ICH9-LPC.disable_s3=1".
> +#
> +# @acpi-s4: The firmware supports S4 hibernation (suspend to disk), as defined
> +#           in the ACPI specification. On the "pc" machine type of the @i386
> +#           and @x86_64 emulation targets, S4 can be enabled with "-global
> +#           PIIX4_PM.disable_s4=0" and disabled with "-global
> +#           PIIX4_PM.disable_s4=1". On the "q35" machine type of the @i386 and
> +#           @x86_64 emulation targets, S4 can be enabled with "-global
> +#           ICH9-LPC.disable_s4=0" and disabled with "-global
> +#           ICH9-LPC.disable_s4=1".

Would you mind breaking documentation lines a bit ealier?

> +#
> +# @amd-sev: The firmware supports running under AMD Secure Encrypted
> +#           Virtualization, as specified in the AMD64 Architecture Programmer's
> +#           Manual. QEMU command line options related to this feature are
> +#           documented in "docs/amd-memory-encryption.txt".
> +#
> +# @requires-smm: The firmware requires the platform to emulate SMM (System
> +#                Management Mode), as defined in the AMD64 Architecture
> +#                Programmer's Manual, and in the Intel(R)64 and IA-32
> +#                Architectures Software Developer's Manual. On the "q35"
> +#                machine type of the @i386 and @x86_64 emulation targets, SMM
> +#                emulation can be enabled with "-machine smm=on". (On the "q35"
> +#                machine type of the @i386 emulation target, @requires-smm
> +#                presents further CPU requirements; one combination known to
> +#                work is "-cpu coreduo,-nx".) If the firmware is marked as both
> +#                @secure-boot and @requires-smm, then write accesses to the
> +#                pflash chip (NVRAM) that holds the UEFI variable store must be
> +#                restricted to code that executes in SMM, using the additional
> +#                option "-global driver=cfi.pflash01,property=secure,value=on".
> +#                Furthermore, a large guest-physical address space (comprising
> +#                guest RAM, memory hotplug range, and 64-bit PCI MMIO
> +#                aperture), and/or a high VCPU count, may present high SMRAM
> +#                requirements from the firmware. On the "q35" machine type of
> +#                the @i386 and @x86_64 emulation targets, the SMRAM size may be
> +#                increased above the default 16MB with the "-global
> +#                mch.extended-tseg-mbytes=uint16" option. As a rule of thumb,
> +#                the default 16MB size suffices for 1TB of guest-phys address
> +#                space and a few tens of VCPUs; for every further TB of
> +#                guest-phys address space, add 8MB of SMRAM. 48MB should
> +#                suffice for 4TB of guest-phys address space and 2-3 hundred
> +#                VCPUs.
> +#
> +# @secure-boot: The firmware implements the software interfaces for UEFI Secure
> +#               Boot, as defined in the UEFI specification. Note that without
> +#               @requires-smm, guest code running with kernel privileges can
> +#               undermine the security of Secure Boot.
> +#
> +# @secure-boot-enrolled-keys: The variable store (NVRAM) template associated
> +#                             with the firmware binary has the Secure Boot
> +#                             operational mode enabled, and -- at least -- the
> +#                             following certificates enrolled. (1) As Platform
> +#                             Key (PK), and as one Key Exchange Key (KEK), a
> +#                             self-signed certificate issued by the firmware
> +#                             distributor is enrolled. (2) As another Key
> +#                             Exchange Key (KEK), the "Microsoft Corporation
> +#                             KEK CA 2011" certificate is enrolled. The UEFI
> +#                             Forum releases updates for the Secure Boot
> +#                             Signature/Certificate Blacklist ("dbx")
> +#                             periodically at
> +#                             <http://www.uefi.org/revocationlistfile>, signed
> +#                             with a certificate chain anchored in this
> +#                             certificate. (3) As one Secure Boot
> +#                             Signature/Certificate ("db"), the "Microsoft
> +#                             Windows Production PCA 2011" certificate is
> +#                             enrolled. This certificate verifies Windows 8,
> +#                             Windows Server 2012 R2, etc boot loaders. (4) As
> +#                             another Secure Boot Signature/Certificate ("db"),
> +#                             the "Microsoft Corporation UEFI CA 2011"
> +#                             certificate is enrolled. This certificate
> +#                             verifies the "shim" UEFI application, and PCI
> +#                             expansion ROMs. @secure-boot-enrolled-keys is
> +#                             only valid if the firmware also supports
> +#                             @secure-boot.
> +#
> +# @verbose-dynamic: When firmware log capture is enabled, the firmware logs a
> +#                   large amount of debug messages, which may impact boot
> +#                   performance. With log capture disabled, there is no boot
> +#                   performance impact. On the "pc" and "q35" machine types of
> +#                   the @i386 and @x86_64 emulation targets, firmware log
> +#                   capture can be enabled with the QEMU command line options
> +#                   "-chardev file,id=fwdebug,path=LOGFILEPATH -device
> +#                   isa-debugcon,iobase=0x402,chardev=fwdebug".
> +#                   @verbose-dynamic is mutually exclusive with
> +#                   @verbose-static.
> +#
> +# @verbose-static: The firmware unconditionally produces a large amount of
> +#                  debug messages, which may impact boot performance. This
> +#                  feature may typically be carried by certain UEFI firmware
> +#                  for the "virt" machine type of the @arm and @aarch64
> +#                  emulation targets, where the debug messages are written to
> +#                  the first (always present) PL011 UART. @verbose-static is
> +#                  mutually exclusive with @verbose-dynamic.
> +#
> +# Since: 2.13
> +##
> +{ 'enum' : 'FirmwareFeature',
> +  'data' : [ 'acpi-s3', 'acpi-s4', 'amd-sev', 'requires-smm', 'secure-boot',
> +             'secure-boot-enrolled-keys', 'verbose-dynamic',
> +             'verbose-static' ] }
> +
> +##
> +# @FirmwareFlashFile:
> +#
> +# Defines common properties that are necessary for loading a firmware file into
> +# a pflash chip. The corresponding QEMU command line option is "-drive
> +# file=@pathname,format=@format". Note however that the option-argument shown
> +# here is incomplete; it is completed under @FirmwareMappingFlash.
> +#
> +# @pathname: Specifies the pathname on the host filesystem where the firmware
> +#            file can be found.

We use @filename elsewhere in the QAPI schema.  Let's stick to that.
More of the same below.

> +#
> +# @format: Specifies the block format of the file pointed-to by @pathname, such
> +#          as @raw or @qcow2.
> +#
> +# Since: 2.13
> +##
> +{ 'struct' : 'FirmwareFlashFile',
> +  'data'   : { 'pathname' : 'str',
> +               'format'   : 'BlockdevDriver' } }
> +
> +##
> +# @FirmwareMappingFlash:
> +#
> +# Describes loading and mapping properties for the firmware executable and its
> +# accompanying NVRAM file, when @FirmwareDevice is @flash.
> +#
> +# @executable: Identifies the firmware executable. The firmware executable may
> +#              be shared by multiple virtual machine definitions. The
> +#              corresponding QEMU command line option is "-drive
> +#              if=pflash,unit=0,readonly=on,file=@executable.@pathname,format=@executable.@format".

I guess @executable.@pathname means member @pathname of @executable.  I
read it as two distinct parameters first, then wondered where parameter
@pathname is.  Perhaps @executable.pathname would be clearer.

> +#
> +# @nvram_template: Identifies the NVRAM template compatible with @executable.
> +#                  Management software instantiates an individual copy -- a
> +#                  specific NVRAM file -- from @nvram_template.@pathname for
> +#                  each new virtual machine definition created.
> +#                  @nvram_template.@pathname itself is never mapped into
> +#                  virtual machines, only individual copies of it are. An NVRAM
> +#                  file is typically used for persistently storing the
> +#                  non-volatile UEFI variables of a virtual machine definition.
> +#                  The corresponding QEMU command line option is "-drive
> +#                  if=pflash,unit=1,readonly=off,file=PATHNAME_OF_PRIVATE_NVRAM_FILE,format=@nvram_template.@format".
> +#
> +# Since: 2.13
> +##
> +{ 'struct' : 'FirmwareMappingFlash',
> +  'data'   : { 'executable'     : 'FirmwareFlashFile',
> +               'nvram_template' : 'FirmwareFlashFile' } }
> +
> +##
> +# @FirmwareMappingKernel:
> +#
> +# Describes loading and mapping properties for the firmware executable, when
> +# @FirmwareDevice is @kernel.
> +#
> +# @pathname: Identifies the firmware executable. The firmware executable may be
> +#            shared by multiple virtual machine definitions. The corresponding
> +#            QEMU command line option is "-kernel @pathname".
> +#
> +# Since: 2.13
> +##
> +{ 'struct' : 'FirmwareMappingKernel',
> +  'data'   : { 'pathname' : 'str' } }
> +
> +##
> +# @FirmwareMappingMemory:
> +#
> +# Describes loading and mapping properties for the firmware executable, when
> +# @FirmwareDevice is @memory.
> +#
> +# @pathname: Identifies the firmware executable. The firmware executable may be
> +#            shared by multiple virtual machine definitions. The corresponding
> +#            QEMU command line option is "-bios @pathname".
> +#
> +# Since: 2.13
> +##
> +{ 'struct' : 'FirmwareMappingMemory',
> +  'data'   : { 'pathname' : 'str' } }
> +
> +##
> +# @FirmwareMapping:
> +#
> +# Provides a discriminated structure for firmware to describe its loading /
> +# mapping properties.
> +#
> +# @device: Selects the device type that the firmware must be mapped into.
> +#
> +# Since: 2.13
> +##
> +{ 'union'         : 'FirmwareMapping',
> +  'base'          : { 'device' : 'FirmwareDevice' },
> +  'discriminator' : 'device',
> +  'data'          : { 'flash'  : 'FirmwareMappingFlash',
> +                      'kernel' : 'FirmwareMappingKernel',
> +                      'memory' : 'FirmwareMappingMemory' } }

The FirmwareMapping* all have a member @pathname.  It could be moved to
the base.  Makes sense if we think future FirmwareMappingFOOs will also
have it.  Your choice.

> +
> +##
> +# @Firmware:
> +#
> +# Describes a firmware (or a firmware use case) to management software.
> +#
> +# @description: Provides a human-readable description of the firmware.
> +#               Management software may or may not display @description.
> +#
> +# @type: Exposes the type of the firmware. @type is generally the primary key
> +#        for which management software looks when picking a firmware for a new
> +#        virtual machine definition.
> +#
> +# @mapping: Describes the loading / mapping properties of the firmware.
> +#
> +# @targets: Collects the target architectures (QEMU system emulators) and their
> +#           machine types that may execute the firmware.
> +#
> +# @features: Lists the features that the firmware supports, and the platform
> +#            requirements it presents.
> +#
> +# @tags: A list of auxiliary strings associated with the firmware for which
> +#        @description is not approprite, due to the latter's possible exposure

s/approprite/appropriate/

Feed the new comments to a spell checker?

> +#        to the end-user. @tags serves development and debugging purposes only,
> +#        and management software shall explicitly ignore it.
> +#
> +# Since: 2.13
> +#
> +# Examples:
> +#
> +# {
> +#     "description": "SeaBIOS",
> +#     "type": "bios",
> +#     "mapping": {
> +#         "device": "memory",
> +#         "pathname": "/usr/share/seabios/bios-256k.bin"
> +#     },
> +#     "targets": [
> +#         {
> +#             "architecture": "i386",
> +#             "machines": [
> +#                 "pc",
> +#                 "q35"
> +#             ]
> +#         },
> +#         {
> +#             "architecture": "x86_64",
> +#             "machines": [
> +#                 "pc",
> +#                 "q35"
> +#             ]
> +#         }
> +#     ],
> +#     "features": [
> +#         "acpi-s3",
> +#         "acpi-s4"
> +#     ],
> +#     "tags": [
> +#         "CONFIG_BOOTSPLASH=n",
> +#         "CONFIG_ROM_SIZE=256",
> +#         "CONFIG_USE_SMM=n"
> +#     ]
> +# }
> +#
> +# {
> +#     "description": "OVMF with SB+SMM, empty varstore",
> +#     "type": "uefi",
> +#     "mapping": {
> +#         "device": "flash",
> +#         "executable": {
> +#             "pathname": "/usr/share/OVMF/OVMF_CODE.secboot.fd",
> +#             "format": "raw"
> +#         },
> +#         "nvram_template": {
> +#             "pathname": "/usr/share/OVMF/OVMF_VARS.fd",
> +#             "format": "raw"
> +#         }
> +#     },
> +#     "targets": [
> +#         {
> +#             "architecture": "x86_64",
> +#             "machines": [
> +#                 "q35"
> +#             ]
> +#         }
> +#     ],
> +#     "features": [
> +#         "acpi-s3",
> +#         "amd-sev",
> +#         "requires-smm",
> +#         "secure-boot",
> +#         "verbose-dynamic"
> +#     ],
> +#     "tags": [
> +#         "-a IA32",
> +#         "-a X64",
> +#         "-p OvmfPkg/OvmfPkgIa32X64.dsc",
> +#         "-t GCC48",
> +#         "-b DEBUG",
> +#         "-D SMM_REQUIRE",
> +#         "-D SECURE_BOOT_ENABLE",
> +#         "-D FD_SIZE_4MB"
> +#     ]
> +# }
> +#
> +# {
> +#     "description": "OVMF with SB+SMM, SB enabled, MS certs enrolled",
> +#     "type": "uefi",
> +#     "mapping": {
> +#         "device": "flash",
> +#         "executable": {
> +#             "pathname": "/usr/share/OVMF/OVMF_CODE.secboot.fd",
> +#             "format": "raw"
> +#         },
> +#         "nvram_template": {
> +#             "pathname": "/usr/share/OVMF/OVMF_VARS.secboot.fd",
> +#             "format": "raw"
> +#         }
> +#     },
> +#     "targets": [
> +#         {
> +#             "architecture": "x86_64",
> +#             "machines": [
> +#                 "q35"
> +#             ]
> +#         }
> +#     ],
> +#     "features": [
> +#         "acpi-s3",
> +#         "amd-sev",
> +#         "requires-smm",
> +#         "secure-boot",
> +#         "secure-boot-enrolled-keys",
> +#         "verbose-dynamic"
> +#     ],
> +#     "tags": [
> +#         "-a IA32",
> +#         "-a X64",
> +#         "-p OvmfPkg/OvmfPkgIa32X64.dsc",
> +#         "-t GCC48",
> +#         "-b DEBUG",
> +#         "-D SMM_REQUIRE",
> +#         "-D SECURE_BOOT_ENABLE",
> +#         "-D FD_SIZE_4MB"
> +#     ]
> +# }
> +#
> +# {
> +#     "description": "UEFI firmware for ARM64 virtual machines",
> +#     "type": "uefi",
> +#     "mapping": {
> +#         "device": "flash",
> +#         "executable": {
> +#             "pathname": "/usr/share/AAVMF/AAVMF_CODE.fd",
> +#             "format": "raw"
> +#         },
> +#         "nvram_template": {
> +#             "pathname": "/usr/share/AAVMF/AAVMF_VARS.fd",
> +#             "format": "raw"
> +#         }
> +#     },
> +#     "targets": [
> +#         {
> +#             "architecture": "aarch64",
> +#             "machines": [
> +#                 "virt"
> +#             ]
> +#         }
> +#     ],
> +#     "features": [
> +#
> +#     ],
> +#     "tags": [
> +#         "-a AARCH64",
> +#         "-p ArmVirtPkg/ArmVirtQemu.dsc",
> +#         "-t GCC48",
> +#         "-b DEBUG",
> +#         "-D DEBUG_PRINT_ERROR_LEVEL=0x80000000"
> +#     ]
> +# }
> +##
> +{ 'struct' : 'Firmware',
> +  'data'   : { 'description' : 'str',
> +               'type'        : 'FirmwareType',
> +               'mapping'     : 'FirmwareMapping',
> +               'targets'     : [ 'FirmwareTarget' ],
> +               'features'    : [ 'FirmwareFeature' ],
> +               'tags'        : [ 'str' ] } }
> +
> +##
> +# @x-check-firmware:
> +#
> +# Accept a @Firmware object and do nothing, successfully. This command can be
> +# used in the QMP shell to validate @Firmware JSON against the schema.
> +#
> +# @fw: ignored
> +#
> +# Since: 2.13
> +##
> +{ 'command' : 'x-check-firmware',
> +  'data'    : { 'fw' : 'Firmware' } }

Introspection has a similar need for validating data against the schema,
but it solves it with a test case without adding a QMP command.  Commit
39a18158165:

    A new test-qmp-input-visitor test case feeds its result for both
    tests/qapi-schema/qapi-schema-test.json and qapi-schema.json to a
    QmpInputVisitor to verify it actually conforms to the schema.

The test case has since moved to tests/test-qobject-input-visitor.c,
function test_visitor_in_qmp_introspect().  Please check it out to see
whether you can do without a QMP command, too.

> diff --git a/qapi/qapi-schema.json b/qapi/qapi-schema.json
> index 25bce78352b8..2d6339ca8c99 100644
> --- a/qapi/qapi-schema.json
> +++ b/qapi/qapi-schema.json
> @@ -92,4 +92,5 @@
>  { 'include': 'transaction.json' }
>  { 'include': 'trace.json' }
>  { 'include': 'introspect.json' }
> +{ 'include': 'firmware.json' }
>  { 'include': 'misc.json' }
