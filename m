Received: from eggs.gnu.org ([2001:4830:134:3::10]:44591)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1fEEq3-0004Ci-1p
	for qemu-devel@nongnu.org; Thu, 03 May 2018 10:04:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1fEEpu-0000q9-H7
	for qemu-devel@nongnu.org; Thu, 03 May 2018 10:04:03 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:45804 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1fEEpu-0000nz-7r
	for qemu-devel@nongnu.org; Thu, 03 May 2018 10:03:54 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 42E92A2016
	for <qemu-devel@nongnu.org>; Thu,  3 May 2018 14:03:44 +0000 (UTC)
From: Laszlo Ersek <lersek@redhat.com>
References: <20180420231246.23130-1-lersek@redhat.com>
	<20180420231246.23130-4-lersek@redhat.com>
Message-ID: <4ab16b9e-1826-a693-47f0-c9ae6afe7410@redhat.com>
Date: Thu, 3 May 2018 16:03:37 +0200
MIME-Version: 1.0
In-Reply-To: <20180420231246.23130-4-lersek@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [qemu RFC v3 3/3] qapi: add "firmware.json"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, libvir-list@redhat.com
Cc: Thomas Huth <thuth@redhat.com>, Kashyap Chamarthy <kchamart@redhat.com>, Markus Armbruster <armbru@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, David Gibson <dgibson@redhat.com>

Ping:

On 04/21/18 01:12, Laszlo Ersek wrote:
> Add a schema that describes the different uses and properties of virtual
> machine firmware.
> 
> Each firmware executable installed on a host system should come with at
> least one JSON file that conforms to this schema. Each file informs the
> management applications about
> - the firmware's properties and one possible use case / feature set,
> - configuration bits that are required to run the firmware binary.
> 
> In addition, define rules for management apps for picking the highest
> priority firmware JSON file when multiple such files match the search
> criteria.
> 
> Cc: "Daniel P. Berrange" <berrange@redhat.com>
> Cc: David Gibson <dgibson@redhat.com>
> Cc: Eric Blake <eblake@redhat.com>
> Cc: Gerd Hoffmann <kraxel@redhat.com>
> Cc: Kashyap Chamarthy <kchamart@redhat.com>
> Cc: Markus Armbruster <armbru@redhat.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Thomas Huth <thuth@redhat.com>
> Signed-off-by: Laszlo Ersek <lersek@redhat.com>
> ---
> 
> Notes:
>     RFCv3:
>     
>     - Previous version (RFCv2) was posted at:
>       <http://mid.mail-archive.com/20180417224054.26363-1-lersek@redhat.com>
>     
>     - Trim the CC list a little.
>     
>     - Wrap to a 72-char margin, for an easier reading. [Markus]
>     
>     - Run spell-checker. [Markus]
>     
>     - Rename @FirmwareType to @FirmwareOSInterface, to better express the
>       concept. Update the enum constants accordingly (incl. documentation);
>       in particular replace @slof with @openfirmware. Rename the @type field
>       in @Firmware to @interface-type. [David, Gerd, Paolo, Thomas]
>     
>     - Better yet, rename @interface-type to @interface-types (plural), and
>       turn it into a list of @FirmwareOSInterface entries, to express an
>       ordered compat list with multiple firmware<->OS interface types. [Dan,
>       Eric, Gerd, Paolo]
>     
>     - Drop @FirmwareArchitecture, and switch the type of
>       @FirmwareTarget.@architecture to @SysEmuTarget (now defined in
>       "common.json"). [Dan, Gerd, Markus]
>     
>     - Switch elements of @FirmwareTarget.@machines from aliases ("pc",
>       "q35", "virt") to concrete machine types, with glob patterns
>       understood. [Dan, Gerd]
>     
>     - Rename @secure-boot-enrolled-keys to @enrolled-keys, and drop the
>       dependency on @secure-boot in its documentation. [Gerd]
>     
>     - Describe the firmware JSON directories and the search rules to
>       management apps, under the @Firmware element. Relatedly, remove the
>       language on any concrete certificates under @enrolled-keys, as these
>       can be customized through the overrides. Also refresh the commit
>       message. [Dan, Gerd]
>     
>     - Rename @pathname fields to @filename. [Markus]
>     
>     - Don't replace "@executable.@filename" with "@executable.filename"
>       (that is, keep the second @ sign), because removing the 2nd @ sign
>       messes up the documentation ("filename" stops being type-set in
>       monospace in the HTML, for example). [Markus]
>     
>     - Rename @nvram_template to @nvram-template. [Thomas]
>     
>     - Keep @x-check-firmware for a while longer. [Dan, Gerd, Markus, Paolo]

Any comments on this single patch?

Should I post just the schema, identically, for
"docs/interop/firmware.json", as a regular PATCH?

(Personally I wouldn't like to add any real QAPI integration for this
schema. I'm not saying it "shouldn't be done", just that it shouldn't be
done by me.)

Thanks,
Laszlo


>     RFCv2:
>     
>     - previous version (RFCv1) was posted at
>       <http://mid.mail-archive.com/20180407000117.25640-1-lersek@redhat.com>
>     
>     - v2 is basically a rewrite from scratch, starting out with Dan's
>       definitions from
>       <http://mid.mail-archive.com/20180410102033.GL5155@redhat.com> and
>       <http://mid.mail-archive.com/20180410110357.GP5155@redhat.com>,
>       hopefully addressing others' feedback as well
>     
>     RFCv1:
>     
>     - Folks on the CC list, please try to see if the suggested schema is
>       flexible enough to describe the virtual firmware(s) that you are
>       familiar with. Thanks!
> 
>  Makefile              |   9 +
>  Makefile.objs         |   4 +
>  qapi/firmware.json    | 554 ++++++++++++++++++++++++++++++++++++++++++++++++++
>  qapi/qapi-schema.json |   1 +
>  qmp.c                 |   5 +
>  .gitignore            |   4 +
>  6 files changed, 577 insertions(+)
>  create mode 100644 qapi/firmware.json
> 
> diff --git a/Makefile b/Makefile
> index d71dd5bea416..32034abe1583 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -97,6 +97,7 @@ GENERATED_FILES += qapi/qapi-types-block.h qapi/qapi-types-block.c
>  GENERATED_FILES += qapi/qapi-types-char.h qapi/qapi-types-char.c
>  GENERATED_FILES += qapi/qapi-types-common.h qapi/qapi-types-common.c
>  GENERATED_FILES += qapi/qapi-types-crypto.h qapi/qapi-types-crypto.c
> +GENERATED_FILES += qapi/qapi-types-firmware.h qapi/qapi-types-firmware.c
>  GENERATED_FILES += qapi/qapi-types-introspect.h qapi/qapi-types-introspect.c
>  GENERATED_FILES += qapi/qapi-types-migration.h qapi/qapi-types-migration.c
>  GENERATED_FILES += qapi/qapi-types-misc.h qapi/qapi-types-misc.c
> @@ -115,6 +116,7 @@ GENERATED_FILES += qapi/qapi-visit-block.h qapi/qapi-visit-block.c
>  GENERATED_FILES += qapi/qapi-visit-char.h qapi/qapi-visit-char.c
>  GENERATED_FILES += qapi/qapi-visit-common.h qapi/qapi-visit-common.c
>  GENERATED_FILES += qapi/qapi-visit-crypto.h qapi/qapi-visit-crypto.c
> +GENERATED_FILES += qapi/qapi-visit-firmware.h qapi/qapi-visit-firmware.c
>  GENERATED_FILES += qapi/qapi-visit-introspect.h qapi/qapi-visit-introspect.c
>  GENERATED_FILES += qapi/qapi-visit-migration.h qapi/qapi-visit-migration.c
>  GENERATED_FILES += qapi/qapi-visit-misc.h qapi/qapi-visit-misc.c
> @@ -132,6 +134,7 @@ GENERATED_FILES += qapi/qapi-commands-block.h qapi/qapi-commands-block.c
>  GENERATED_FILES += qapi/qapi-commands-char.h qapi/qapi-commands-char.c
>  GENERATED_FILES += qapi/qapi-commands-common.h qapi/qapi-commands-common.c
>  GENERATED_FILES += qapi/qapi-commands-crypto.h qapi/qapi-commands-crypto.c
> +GENERATED_FILES += qapi/qapi-commands-firmware.h qapi/qapi-commands-firmware.c
>  GENERATED_FILES += qapi/qapi-commands-introspect.h qapi/qapi-commands-introspect.c
>  GENERATED_FILES += qapi/qapi-commands-migration.h qapi/qapi-commands-migration.c
>  GENERATED_FILES += qapi/qapi-commands-misc.h qapi/qapi-commands-misc.c
> @@ -149,6 +152,7 @@ GENERATED_FILES += qapi/qapi-events-block.h qapi/qapi-events-block.c
>  GENERATED_FILES += qapi/qapi-events-char.h qapi/qapi-events-char.c
>  GENERATED_FILES += qapi/qapi-events-common.h qapi/qapi-events-common.c
>  GENERATED_FILES += qapi/qapi-events-crypto.h qapi/qapi-events-crypto.c
> +GENERATED_FILES += qapi/qapi-events-firmware.h qapi/qapi-events-firmware.c
>  GENERATED_FILES += qapi/qapi-events-introspect.h qapi/qapi-events-introspect.c
>  GENERATED_FILES += qapi/qapi-events-migration.h qapi/qapi-events-migration.c
>  GENERATED_FILES += qapi/qapi-events-misc.h qapi/qapi-events-misc.c
> @@ -581,6 +585,7 @@ qapi-modules = $(SRC_PATH)/qapi/qapi-schema.json $(SRC_PATH)/qapi/common.json \
>                 $(SRC_PATH)/qapi/block.json $(SRC_PATH)/qapi/block-core.json \
>                 $(SRC_PATH)/qapi/char.json \
>                 $(SRC_PATH)/qapi/crypto.json \
> +               $(SRC_PATH)/qapi/firmware.json \
>                 $(SRC_PATH)/qapi/introspect.json \
>                 $(SRC_PATH)/qapi/migration.json \
>                 $(SRC_PATH)/qapi/misc.json \
> @@ -600,6 +605,7 @@ qapi/qapi-types-block.c qapi/qapi-types-block.h \
>  qapi/qapi-types-char.c qapi/qapi-types-char.h \
>  qapi/qapi-types-common.c qapi/qapi-types-common.h \
>  qapi/qapi-types-crypto.c qapi/qapi-types-crypto.h \
> +qapi/qapi-types-firmware.c qapi/qapi-types-firmware.h \
>  qapi/qapi-types-introspect.c qapi/qapi-types-introspect.h \
>  qapi/qapi-types-migration.c qapi/qapi-types-migration.h \
>  qapi/qapi-types-misc.c qapi/qapi-types-misc.h \
> @@ -618,6 +624,7 @@ qapi/qapi-visit-block.c qapi/qapi-visit-block.h \
>  qapi/qapi-visit-char.c qapi/qapi-visit-char.h \
>  qapi/qapi-visit-common.c qapi/qapi-visit-common.h \
>  qapi/qapi-visit-crypto.c qapi/qapi-visit-crypto.h \
> +qapi/qapi-visit-firmware.c qapi/qapi-visit-firmware.h \
>  qapi/qapi-visit-introspect.c qapi/qapi-visit-introspect.h \
>  qapi/qapi-visit-migration.c qapi/qapi-visit-migration.h \
>  qapi/qapi-visit-misc.c qapi/qapi-visit-misc.h \
> @@ -635,6 +642,7 @@ qapi/qapi-commands-block.c qapi/qapi-commands-block.h \
>  qapi/qapi-commands-char.c qapi/qapi-commands-char.h \
>  qapi/qapi-commands-common.c qapi/qapi-commands-common.h \
>  qapi/qapi-commands-crypto.c qapi/qapi-commands-crypto.h \
> +qapi/qapi-commands-firmware.c qapi/qapi-commands-firmware.h \
>  qapi/qapi-commands-introspect.c qapi/qapi-commands-introspect.h \
>  qapi/qapi-commands-migration.c qapi/qapi-commands-migration.h \
>  qapi/qapi-commands-misc.c qapi/qapi-commands-misc.h \
> @@ -652,6 +660,7 @@ qapi/qapi-events-block.c qapi/qapi-events-block.h \
>  qapi/qapi-events-char.c qapi/qapi-events-char.h \
>  qapi/qapi-events-common.c qapi/qapi-events-common.h \
>  qapi/qapi-events-crypto.c qapi/qapi-events-crypto.h \
> +qapi/qapi-events-firmware.c qapi/qapi-events-firmware.h \
>  qapi/qapi-events-introspect.c qapi/qapi-events-introspect.h \
>  qapi/qapi-events-migration.c qapi/qapi-events-migration.h \
>  qapi/qapi-events-misc.c qapi/qapi-events-misc.h \
> diff --git a/Makefile.objs b/Makefile.objs
> index c6c9b8fc2177..6ed4e0010b10 100644
> --- a/Makefile.objs
> +++ b/Makefile.objs
> @@ -9,6 +9,7 @@ util-obj-y += qapi/qapi-types-block.o
>  util-obj-y += qapi/qapi-types-char.o
>  util-obj-y += qapi/qapi-types-common.o
>  util-obj-y += qapi/qapi-types-crypto.o
> +util-obj-y += qapi/qapi-types-firmware.o
>  util-obj-y += qapi/qapi-types-introspect.o
>  util-obj-y += qapi/qapi-types-migration.o
>  util-obj-y += qapi/qapi-types-misc.o
> @@ -27,6 +28,7 @@ util-obj-y += qapi/qapi-visit-block.o
>  util-obj-y += qapi/qapi-visit-char.o
>  util-obj-y += qapi/qapi-visit-common.o
>  util-obj-y += qapi/qapi-visit-crypto.o
> +util-obj-y += qapi/qapi-visit-firmware.o
>  util-obj-y += qapi/qapi-visit-introspect.o
>  util-obj-y += qapi/qapi-visit-migration.o
>  util-obj-y += qapi/qapi-visit-misc.o
> @@ -44,6 +46,7 @@ util-obj-y += qapi/qapi-events-block.o
>  util-obj-y += qapi/qapi-events-char.o
>  util-obj-y += qapi/qapi-events-common.o
>  util-obj-y += qapi/qapi-events-crypto.o
> +util-obj-y += qapi/qapi-events-firmware.o
>  util-obj-y += qapi/qapi-events-introspect.o
>  util-obj-y += qapi/qapi-events-migration.o
>  util-obj-y += qapi/qapi-events-misc.o
> @@ -139,6 +142,7 @@ common-obj-y += qapi/qapi-commands-block.o
>  common-obj-y += qapi/qapi-commands-char.o
>  common-obj-y += qapi/qapi-commands-common.o
>  common-obj-y += qapi/qapi-commands-crypto.o
> +common-obj-y += qapi/qapi-commands-firmware.o
>  common-obj-y += qapi/qapi-commands-introspect.o
>  common-obj-y += qapi/qapi-commands-migration.o
>  common-obj-y += qapi/qapi-commands-misc.o
> diff --git a/qapi/firmware.json b/qapi/firmware.json
> new file mode 100644
> index 000000000000..2add6fd8afe7
> --- /dev/null
> +++ b/qapi/firmware.json
> @@ -0,0 +1,554 @@
> +# -*- Mode: Python -*-
> +#
> +# Copyright (C) 2018 Red Hat, Inc.
> +#
> +# Authors:
> +#  Daniel P. Berrange <berrange@redhat.com>
> +#  Laszlo Ersek <lersek@redhat.com>
> +#
> +# This work is licensed under the terms of the GNU GPL, version 2 or
> +# later. See the COPYING file in the top-level directory.
> +
> +##
> +# = Firmware
> +##
> +
> +{ 'include' : 'common.json' }
> +{ 'include' : 'block-core.json' }
> +
> +##
> +# @FirmwareOSInterface:
> +#
> +# Lists the firmware-OS interface types provided by various firmware
> +# that is commonly used with QEMU virtual machines.
> +#
> +# @bios: Traditional x86 BIOS interface. For example, firmware built
> +#        from the SeaBIOS project usually provides this interface.
> +#
> +# @openfirmware: The interface is defined by the (historical) IEEE
> +#                1275-1994 standard. Examples for firmware projects that
> +#                provide this interface are: OpenBIOS, OpenHackWare,
> +#                SLOF.
> +#
> +# @uboot: Firmware interface defined by the U-Boot project.
> +#
> +# @uefi: Firmware interface defined by the UEFI specification. For
> +#        example, firmware built from the edk2 (EFI Development Kit II)
> +#        project usually provides this interface.
> +#
> +# Since: 2.13
> +##
> +{ 'enum' : 'FirmwareOSInterface',
> +  'data' : [ 'bios', 'openfirmware', 'uboot', 'uefi' ] }
> +
> +##
> +# @FirmwareDevice:
> +#
> +# Defines the device types that firmware can be mapped into.
> +#
> +# @flash: The firmware executable and its accompanying NVRAM file are to
> +#         be mapped into a pflash chip each.
> +#
> +# @kernel: The firmware is to be loaded like a Linux kernel. This is
> +#          similar to @memory but may imply additional processing that
> +#          is specific to the target architecture and machine type.
> +#
> +# @memory: The firmware is to be mapped into memory.
> +#
> +# Since: 2.13
> +##
> +{ 'enum' : 'FirmwareDevice',
> +  'data' : [ 'flash', 'kernel', 'memory' ] }
> +
> +##
> +# @FirmwareTarget:
> +#
> +# Defines the machine types that firmware may execute on.
> +#
> +# @architecture: Determines the emulation target (the QEMU system
> +#                emulator) that can execute the firmware.
> +#
> +# @machines: Lists the machine types (known by the emulator that is
> +#            specified through @architecture) that can execute the
> +#            firmware. Elements of @machines are supposed to be concrete
> +#            machine types, not aliases. Glob patterns are understood,
> +#            which is especially useful for versioned machine types.
> +#            (For example, the glob pattern "pc-i440fx-*" matches
> +#            "pc-i440fx-2.12".) On the QEMU command line, "-machine
> +#            type=..." specifies the requested machine type (but that
> +#            option does not accept glob patterns).
> +#
> +# Since: 2.13
> +##
> +{ 'struct' : 'FirmwareTarget',
> +  'data'   : { 'architecture' : 'SysEmuTarget',
> +               'machines'     : [ 'str' ] } }
> +
> +##
> +# @FirmwareFeature:
> +#
> +# Defines the features that firmware may support, and the platform
> +# requirements that firmware may present.
> +#
> +# @acpi-s3: The firmware supports S3 sleep (suspend to RAM), as defined
> +#           in the ACPI specification. On the "pc-i440fx-*" machine
> +#           types of the @i386 and @x86_64 emulation targets, S3 can be
> +#           enabled with "-global PIIX4_PM.disable_s3=0" and disabled
> +#           with "-global PIIX4_PM.disable_s3=1". On the "pc-q35-*"
> +#           machine types of the @i386 and @x86_64 emulation targets, S3
> +#           can be enabled with "-global ICH9-LPC.disable_s3=0" and
> +#           disabled with "-global ICH9-LPC.disable_s3=1".
> +#
> +# @acpi-s4: The firmware supports S4 hibernation (suspend to disk), as
> +#           defined in the ACPI specification. On the "pc-i440fx-*"
> +#           machine types of the @i386 and @x86_64 emulation targets, S4
> +#           can be enabled with "-global PIIX4_PM.disable_s4=0" and
> +#           disabled with "-global PIIX4_PM.disable_s4=1". On the
> +#           "pc-q35-*" machine types of the @i386 and @x86_64 emulation
> +#           targets, S4 can be enabled with "-global
> +#           ICH9-LPC.disable_s4=0" and disabled with "-global
> +#           ICH9-LPC.disable_s4=1".
> +#
> +# @amd-sev: The firmware supports running under AMD Secure Encrypted
> +#           Virtualization, as specified in the AMD64 Architecture
> +#           Programmer's Manual. QEMU command line options related to
> +#           this feature are documented in
> +#           "docs/amd-memory-encryption.txt".
> +#
> +# @enrolled-keys: The variable store (NVRAM) template associated with
> +#                 the firmware binary has the UEFI Secure Boot
> +#                 operational mode turned on, with certificates
> +#                 enrolled.
> +#
> +# @requires-smm: The firmware requires the platform to emulate SMM
> +#                (System Management Mode), as defined in the AMD64
> +#                Architecture Programmer's Manual, and in the Intel(R)64
> +#                and IA-32 Architectures Software Developer's Manual. On
> +#                the "pc-q35-*" machine types of the @i386 and @x86_64
> +#                emulation targets, SMM emulation can be enabled with
> +#                "-machine smm=on". (On the "pc-q35-*" machine types of
> +#                the @i386 emulation target, @requires-smm presents
> +#                further CPU requirements; one combination known to work
> +#                is "-cpu coreduo,-nx".) If the firmware is marked as
> +#                both @secure-boot and @requires-smm, then write
> +#                accesses to the pflash chip (NVRAM) that holds the UEFI
> +#                variable store must be restricted to code that executes
> +#                in SMM, using the additional option "-global
> +#                driver=cfi.pflash01,property=secure,value=on".
> +#                Furthermore, a large guest-physical address space
> +#                (comprising guest RAM, memory hotplug range, and 64-bit
> +#                PCI MMIO aperture), and/or a high VCPU count, may
> +#                present high SMRAM requirements from the firmware. On
> +#                the "pc-q35-*" machine types of the @i386 and @x86_64
> +#                emulation targets, the SMRAM size may be increased
> +#                above the default 16MB with the "-global
> +#                mch.extended-tseg-mbytes=uint16" option. As a rule of
> +#                thumb, the default 16MB size suffices for 1TB of
> +#                guest-phys address space and a few tens of VCPUs; for
> +#                every further TB of guest-phys address space, add 8MB
> +#                of SMRAM. 48MB should suffice for 4TB of guest-phys
> +#                address space and 2-3 hundred VCPUs.
> +#
> +# @secure-boot: The firmware implements the software interfaces for UEFI
> +#               Secure Boot, as defined in the UEFI specification. Note
> +#               that without @requires-smm, guest code running with
> +#               kernel privileges can undermine the security of Secure
> +#               Boot.
> +#
> +# @verbose-dynamic: When firmware log capture is enabled, the firmware
> +#                   logs a large amount of debug messages, which may
> +#                   impact boot performance. With log capture disabled,
> +#                   there is no boot performance impact. On the
> +#                   "pc-i440fx-*" and "pc-q35-*" machine types of the
> +#                   @i386 and @x86_64 emulation targets, firmware log
> +#                   capture can be enabled with the QEMU command line
> +#                   options "-chardev file,id=fwdebug,path=LOGFILEPATH
> +#                   -device isa-debugcon,iobase=0x402,chardev=fwdebug".
> +#                   @verbose-dynamic is mutually exclusive with
> +#                   @verbose-static.
> +#
> +# @verbose-static: The firmware unconditionally produces a large amount
> +#                  of debug messages, which may impact boot performance.
> +#                  This feature may typically be carried by certain UEFI
> +#                  firmware for the "virt-*" machine types of the @arm
> +#                  and @aarch64 emulation targets, where the debug
> +#                  messages are written to the first (always present)
> +#                  PL011 UART. @verbose-static is mutually exclusive
> +#                  with @verbose-dynamic.
> +#
> +# Since: 2.13
> +##
> +{ 'enum' : 'FirmwareFeature',
> +  'data' : [ 'acpi-s3', 'acpi-s4', 'amd-sev', 'enrolled-keys',
> +             'requires-smm', 'secure-boot', 'verbose-dynamic',
> +             'verbose-static' ] }
> +
> +##
> +# @FirmwareFlashFile:
> +#
> +# Defines common properties that are necessary for loading a firmware
> +# file into a pflash chip. The corresponding QEMU command line option is
> +# "-drive file=@filename,format=@format". Note however that the
> +# option-argument shown here is incomplete; it is completed under
> +# @FirmwareMappingFlash.
> +#
> +# @filename: Specifies the filename on the host filesystem where the
> +#            firmware file can be found.
> +#
> +# @format: Specifies the block format of the file pointed-to by
> +#          @filename, such as @raw or @qcow2.
> +#
> +# Since: 2.13
> +##
> +{ 'struct' : 'FirmwareFlashFile',
> +  'data'   : { 'filename' : 'str',
> +               'format'   : 'BlockdevDriver' } }
> +
> +##
> +# @FirmwareMappingFlash:
> +#
> +# Describes loading and mapping properties for the firmware executable
> +# and its accompanying NVRAM file, when @FirmwareDevice is @flash.
> +#
> +# @executable: Identifies the firmware executable. The firmware
> +#              executable may be shared by multiple virtual machine
> +#              definitions. The corresponding QEMU command line option
> +#              is "-drive
> +#              if=pflash,unit=0,readonly=on,file=@executable.@filename,format=@executable.@format".
> +#
> +# @nvram-template: Identifies the NVRAM template compatible with
> +#                  @executable. Management software instantiates an
> +#                  individual copy -- a specific NVRAM file -- from
> +#                  @nvram-template.@filename for each new virtual
> +#                  machine definition created. @nvram-template.@filename
> +#                  itself is never mapped into virtual machines, only
> +#                  individual copies of it are. An NVRAM file is
> +#                  typically used for persistently storing the
> +#                  non-volatile UEFI variables of a virtual machine
> +#                  definition. The corresponding QEMU command line
> +#                  option is "-drive
> +#                  if=pflash,unit=1,readonly=off,file=FILENAME_OF_PRIVATE_NVRAM_FILE,format=@nvram-template.@format".
> +#
> +# Since: 2.13
> +##
> +{ 'struct' : 'FirmwareMappingFlash',
> +  'data'   : { 'executable'     : 'FirmwareFlashFile',
> +               'nvram-template' : 'FirmwareFlashFile' } }
> +
> +##
> +# @FirmwareMappingKernel:
> +#
> +# Describes loading and mapping properties for the firmware executable,
> +# when @FirmwareDevice is @kernel.
> +#
> +# @filename: Identifies the firmware executable. The firmware executable
> +#            may be shared by multiple virtual machine definitions. The
> +#            corresponding QEMU command line option is "-kernel
> +#            @filename".
> +#
> +# Since: 2.13
> +##
> +{ 'struct' : 'FirmwareMappingKernel',
> +  'data'   : { 'filename' : 'str' } }
> +
> +##
> +# @FirmwareMappingMemory:
> +#
> +# Describes loading and mapping properties for the firmware executable,
> +# when @FirmwareDevice is @memory.
> +#
> +# @filename: Identifies the firmware executable. The firmware executable
> +#            may be shared by multiple virtual machine definitions. The
> +#            corresponding QEMU command line option is "-bios
> +#            @filename".
> +#
> +# Since: 2.13
> +##
> +{ 'struct' : 'FirmwareMappingMemory',
> +  'data'   : { 'filename' : 'str' } }
> +
> +##
> +# @FirmwareMapping:
> +#
> +# Provides a discriminated structure for firmware to describe its
> +# loading / mapping properties.
> +#
> +# @device: Selects the device type that the firmware must be mapped
> +#          into.
> +#
> +# Since: 2.13
> +##
> +{ 'union'         : 'FirmwareMapping',
> +  'base'          : { 'device' : 'FirmwareDevice' },
> +  'discriminator' : 'device',
> +  'data'          : { 'flash'  : 'FirmwareMappingFlash',
> +                      'kernel' : 'FirmwareMappingKernel',
> +                      'memory' : 'FirmwareMappingMemory' } }
> +
> +##
> +# @Firmware:
> +#
> +# Describes a firmware (or a firmware use case) to management software.
> +#
> +# It is possible for multiple @Firmware elements to match the search
> +# criteria of management software. Applications thus need rules to pick
> +# one of the many matches, and users need the ability to override distro
> +# defaults.
> +#
> +# It is recommended to create firmware JSON files (each containing a
> +# single @Firmware root element) with a double-digit prefix, for example
> +# "50-ovmf.json", "50-seabios-256k.json", etc, so they can be sorted in
> +# predictable order. The firmware JSON files should be searched for in
> +# three directories:
> +#
> +#   - /usr/share/qemu/firmware -- populated by distro-provided firmware
> +#                                 packages (XDG_DATA_DIRS covers
> +#                                 /usr/share by default),
> +#
> +#   - /etc/qemu/firmware -- exclusively for sysadmins' local additions,
> +#
> +#   - $XDG_CONFIG_HOME/qemu/firmware -- exclusively for per-user local
> +#                                       additions (XDG_CONFIG_HOME
> +#                                       defaults to $HOME/.config).
> +#
> +# Top-down, the list of directories goes from general to specific.
> +#
> +# Management software should build a list of files from all three
> +# locations, then sort the list by filename (i.e., last pathname
> +# component). Management software should choose the first JSON file on
> +# the sorted list that matches the search criteria. If a more specific
> +# directory has a file with same name as a less specific directory, then
> +# the file in the more specific directory takes effect. If the more
> +# specific file is zero length, it hides the less specific one.
> +#
> +# For example, if a distro ships
> +#
> +#   - /usr/share/qemu/firmware/50-ovmf.json
> +#
> +#   - /usr/share/qemu/firmware/50-seabios-256k.json
> +#
> +# then the sysadmin can prevent the default OVMF being used at all with
> +#
> +#   $ touch /etc/qemu/firmware/50-ovmf.json
> +#
> +# The sysadmin can replace/alter the distro default OVMF with
> +#
> +#   $ vim /etc/qemu/firmware/50-ovmf.json
> +#
> +# or they can provide a parallel OVMF with higher priority
> +#
> +#   $ vim /etc/qemu/firmware/10-ovmf.json
> +#
> +# or they can provide a parallel OVMF with lower priority
> +#
> +#   $ vim /etc/qemu/firmware/99-ovmf.json
> +#
> +# @description: Provides a human-readable description of the firmware.
> +#               Management software may or may not display @description.
> +#
> +# @interface-types: Lists the types of interfaces that the firmware can
> +#                   expose to the guest OS. This is a non-empty, ordered
> +#                   list; entries near the beginning of @interface-types
> +#                   are considered more native to the firmware, and/or
> +#                   to have a higher quality implementation in the
> +#                   firmware, than entries near the end of
> +#                   @interface-types.
> +#
> +# @mapping: Describes the loading / mapping properties of the firmware.
> +#
> +# @targets: Collects the target architectures (QEMU system emulators)
> +#           and their machine types that may execute the firmware.
> +#
> +# @features: Lists the features that the firmware supports, and the
> +#            platform requirements it presents.
> +#
> +# @tags: A list of auxiliary strings associated with the firmware for
> +#        which @description is not appropriate, due to the latter's
> +#        possible exposure to the end-user. @tags serves development and
> +#        debugging purposes only, and management software shall
> +#        explicitly ignore it.
> +#
> +# Since: 2.13
> +#
> +# Examples:
> +#
> +# {
> +#     "description": "SeaBIOS",
> +#     "interface-types": [
> +#         "bios"
> +#     ],
> +#     "mapping": {
> +#         "device": "memory",
> +#         "filename": "/usr/share/seabios/bios-256k.bin"
> +#     },
> +#     "targets": [
> +#         {
> +#             "architecture": "i386",
> +#             "machines": [
> +#                 "pc-i440fx-*",
> +#                 "pc-q35-*"
> +#             ]
> +#         },
> +#         {
> +#             "architecture": "x86_64",
> +#             "machines": [
> +#                 "pc-i440fx-*",
> +#                 "pc-q35-*"
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
> +#     "interface-types": [
> +#         "uefi"
> +#     ],
> +#     "mapping": {
> +#         "device": "flash",
> +#         "executable": {
> +#             "filename": "/usr/share/OVMF/OVMF_CODE.secboot.fd",
> +#             "format": "raw"
> +#         },
> +#         "nvram-template": {
> +#             "filename": "/usr/share/OVMF/OVMF_VARS.fd",
> +#             "format": "raw"
> +#         }
> +#     },
> +#     "targets": [
> +#         {
> +#             "architecture": "x86_64",
> +#             "machines": [
> +#                 "pc-q35-*"
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
> +#     "interface-types": [
> +#         "uefi"
> +#     ],
> +#     "mapping": {
> +#         "device": "flash",
> +#         "executable": {
> +#             "filename": "/usr/share/OVMF/OVMF_CODE.secboot.fd",
> +#             "format": "raw"
> +#         },
> +#         "nvram-template": {
> +#             "filename": "/usr/share/OVMF/OVMF_VARS.secboot.fd",
> +#             "format": "raw"
> +#         }
> +#     },
> +#     "targets": [
> +#         {
> +#             "architecture": "x86_64",
> +#             "machines": [
> +#                 "pc-q35-*"
> +#             ]
> +#         }
> +#     ],
> +#     "features": [
> +#         "acpi-s3",
> +#         "amd-sev",
> +#         "enrolled-keys",
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
> +#     "description": "UEFI firmware for ARM64 virtual machines",
> +#     "interface-types": [
> +#         "uefi"
> +#     ],
> +#     "mapping": {
> +#         "device": "flash",
> +#         "executable": {
> +#             "filename": "/usr/share/AAVMF/AAVMF_CODE.fd",
> +#             "format": "raw"
> +#         },
> +#         "nvram-template": {
> +#             "filename": "/usr/share/AAVMF/AAVMF_VARS.fd",
> +#             "format": "raw"
> +#         }
> +#     },
> +#     "targets": [
> +#         {
> +#             "architecture": "aarch64",
> +#             "machines": [
> +#                 "virt-*"
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
> +  'data'   : { 'description'     : 'str',
> +               'interface-types' : [ 'FirmwareOSInterface' ],
> +               'mapping'         : 'FirmwareMapping',
> +               'targets'         : [ 'FirmwareTarget' ],
> +               'features'        : [ 'FirmwareFeature' ],
> +               'tags'            : [ 'str' ] } }
> +
> +##
> +# @x-check-firmware:
> +#
> +# Accept a @Firmware object and do nothing, successfully. This command
> +# can be used in the QMP shell to validate @Firmware JSON against the
> +# schema.
> +#
> +# @fw: ignored
> +#
> +# Since: 2.13
> +##
> +{ 'command' : 'x-check-firmware',
> +  'data'    : { 'fw' : 'Firmware' } }
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
> diff --git a/qmp.c b/qmp.c
> index f72261667f92..2141ebe6f027 100644
> --- a/qmp.c
> +++ b/qmp.c
> @@ -34,6 +34,7 @@
>  #include "qapi/qapi-commands-block-core.h"
>  #include "qapi/qapi-commands-misc.h"
>  #include "qapi/qapi-commands-ui.h"
> +#include "qapi/qapi-commands-firmware.h"
>  #include "qapi/qmp/qdict.h"
>  #include "qapi/qmp/qerror.h"
>  #include "qapi/qobject-input-visitor.h"
> @@ -781,3 +782,7 @@ void qmp_x_oob_test(bool lock, Error **errp)
>          qemu_sem_post(&x_oob_test_sem);
>      }
>  }
> +
> +void qmp_x_check_firmware(Firmware *fw, Error **errp)
> +{
> +}
> diff --git a/.gitignore b/.gitignore
> index 4055e12ee85d..1d8d1066d3d1 100644
> --- a/.gitignore
> +++ b/.gitignore
> @@ -35,6 +35,7 @@
>  /qapi/qapi-commands-char.[ch]
>  /qapi/qapi-commands-common.[ch]
>  /qapi/qapi-commands-crypto.[ch]
> +/qapi/qapi-commands-firmware.[ch]
>  /qapi/qapi-commands-introspect.[ch]
>  /qapi/qapi-commands-migration.[ch]
>  /qapi/qapi-commands-misc.[ch]
> @@ -52,6 +53,7 @@
>  /qapi/qapi-events-char.[ch]
>  /qapi/qapi-events-common.[ch]
>  /qapi/qapi-events-crypto.[ch]
> +/qapi/qapi-events-firmware.[ch]
>  /qapi/qapi-events-introspect.[ch]
>  /qapi/qapi-events-migration.[ch]
>  /qapi/qapi-events-misc.[ch]
> @@ -70,6 +72,7 @@
>  /qapi/qapi-types-char.[ch]
>  /qapi/qapi-types-common.[ch]
>  /qapi/qapi-types-crypto.[ch]
> +/qapi/qapi-types-firmware.[ch]
>  /qapi/qapi-types-introspect.[ch]
>  /qapi/qapi-types-migration.[ch]
>  /qapi/qapi-types-misc.[ch]
> @@ -87,6 +90,7 @@
>  /qapi/qapi-visit-char.[ch]
>  /qapi/qapi-visit-common.[ch]
>  /qapi/qapi-visit-crypto.[ch]
> +/qapi/qapi-visit-firmware.[ch]
>  /qapi/qapi-visit-introspect.[ch]
>  /qapi/qapi-visit-migration.[ch]
>  /qapi/qapi-visit-misc.[ch]
> 
