Received: from eggs.gnu.org ([2001:4830:134:3::10]:37296)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1f4bIX-0006nf-Vu
	for qemu-devel@nongnu.org; Fri, 06 Apr 2018 20:01:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1f4bIU-0001qO-Qf
	for qemu-devel@nongnu.org; Fri, 06 Apr 2018 20:01:38 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:44008 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1f4bIU-0001oT-KH
	for qemu-devel@nongnu.org; Fri, 06 Apr 2018 20:01:34 -0400
From: Laszlo Ersek <lersek@redhat.com>
Date: Sat,  7 Apr 2018 02:01:17 +0200
Message-Id: <20180407000117.25640-1-lersek@redhat.com>
Subject: [Qemu-devel] [qemu RFC] qapi: add "firmware.json"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, libvir-list@redhat.com
Cc: "Daniel P. Berrange" <berrange@redhat.com>, Alexander Graf <agraf@suse.de>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, David Gibson <dgibson@redhat.com>, Eric Blake <eblake@redhat.com>, Gary Ching-Pang Lin <glin@suse.com>, Gerd Hoffmann <kraxel@redhat.com>, Kashyap Chamarthy <kchamart@redhat.com>, Markus Armbruster <armbru@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, Michal Privoznik <mprivozn@redhat.com>, Peter Krempa <pkrempa@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>

Add a schema that describes the properties of virtual machine firmware.

Each firmware executable installed on a host system should come with a
JSON file that conforms to this schema, and informs the management
applications about the firmware's properties.

In addition, a configuration directory with symlinks to the JSON files
should exist, with the symlinks carefully named to reflect a priority
order. Management applications can then search this directory in priority
order for the first firmware executable that satisfies their search
criteria. The found JSON file provides the management layer with domain
configuration bits that are required to run the firmware binary.

Cc: "Daniel P. Berrange" <berrange@redhat.com>
Cc: Alexander Graf <agraf@suse.de>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: David Gibson <dgibson@redhat.com>
Cc: Eric Blake <eblake@redhat.com>
Cc: Gary Ching-Pang Lin <glin@suse.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>
Cc: Kashyap Chamarthy <kchamart@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>
Cc: Michael Roth <mdroth@linux.vnet.ibm.com>
Cc: Michal Privoznik <mprivozn@redhat.com>
Cc: Peter Krempa <pkrempa@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>
Cc: Thomas Huth <thuth@redhat.com>
Signed-off-by: Laszlo Ersek <lersek@redhat.com>
---

Notes:
    Folks on the CC list, please try to see if the suggested schema is
    flexible enough to describe the virtual firmware(s) that you are
    familiar with. Thanks!

 Makefile              |   9 ++
 Makefile.objs         |   4 +
 qapi/firmware.json    | 343 ++++++++++++++++++++++++++++++++++++++++++++++++++
 qapi/qapi-schema.json |   1 +
 qmp.c                 |   5 +
 .gitignore            |   4 +
 6 files changed, 366 insertions(+)
 create mode 100644 qapi/firmware.json

diff --git a/Makefile b/Makefile
index 727ef118f3d9..e088e3c1b39f 100644
--- a/Makefile
+++ b/Makefile
@@ -97,6 +97,7 @@ GENERATED_FILES += qapi/qapi-types-block.h qapi/qapi-types-block.c
 GENERATED_FILES += qapi/qapi-types-char.h qapi/qapi-types-char.c
 GENERATED_FILES += qapi/qapi-types-common.h qapi/qapi-types-common.c
 GENERATED_FILES += qapi/qapi-types-crypto.h qapi/qapi-types-crypto.c
+GENERATED_FILES += qapi/qapi-types-firmware.h qapi/qapi-types-firmware.c
 GENERATED_FILES += qapi/qapi-types-introspect.h qapi/qapi-types-introspect.c
 GENERATED_FILES += qapi/qapi-types-migration.h qapi/qapi-types-migration.c
 GENERATED_FILES += qapi/qapi-types-misc.h qapi/qapi-types-misc.c
@@ -115,6 +116,7 @@ GENERATED_FILES += qapi/qapi-visit-block.h qapi/qapi-visit-block.c
 GENERATED_FILES += qapi/qapi-visit-char.h qapi/qapi-visit-char.c
 GENERATED_FILES += qapi/qapi-visit-common.h qapi/qapi-visit-common.c
 GENERATED_FILES += qapi/qapi-visit-crypto.h qapi/qapi-visit-crypto.c
+GENERATED_FILES += qapi/qapi-visit-firmware.h qapi/qapi-visit-firmware.c
 GENERATED_FILES += qapi/qapi-visit-introspect.h qapi/qapi-visit-introspect.c
 GENERATED_FILES += qapi/qapi-visit-migration.h qapi/qapi-visit-migration.c
 GENERATED_FILES += qapi/qapi-visit-misc.h qapi/qapi-visit-misc.c
@@ -132,6 +134,7 @@ GENERATED_FILES += qapi/qapi-commands-block.h qapi/qapi-commands-block.c
 GENERATED_FILES += qapi/qapi-commands-char.h qapi/qapi-commands-char.c
 GENERATED_FILES += qapi/qapi-commands-common.h qapi/qapi-commands-common.c
 GENERATED_FILES += qapi/qapi-commands-crypto.h qapi/qapi-commands-crypto.c
+GENERATED_FILES += qapi/qapi-commands-firmware.h qapi/qapi-commands-firmware.c
 GENERATED_FILES += qapi/qapi-commands-introspect.h qapi/qapi-commands-introspect.c
 GENERATED_FILES += qapi/qapi-commands-migration.h qapi/qapi-commands-migration.c
 GENERATED_FILES += qapi/qapi-commands-misc.h qapi/qapi-commands-misc.c
@@ -149,6 +152,7 @@ GENERATED_FILES += qapi/qapi-events-block.h qapi/qapi-events-block.c
 GENERATED_FILES += qapi/qapi-events-char.h qapi/qapi-events-char.c
 GENERATED_FILES += qapi/qapi-events-common.h qapi/qapi-events-common.c
 GENERATED_FILES += qapi/qapi-events-crypto.h qapi/qapi-events-crypto.c
+GENERATED_FILES += qapi/qapi-events-firmware.h qapi/qapi-events-firmware.c
 GENERATED_FILES += qapi/qapi-events-introspect.h qapi/qapi-events-introspect.c
 GENERATED_FILES += qapi/qapi-events-migration.h qapi/qapi-events-migration.c
 GENERATED_FILES += qapi/qapi-events-misc.h qapi/qapi-events-misc.c
@@ -581,6 +585,7 @@ qapi-modules = $(SRC_PATH)/qapi/qapi-schema.json $(SRC_PATH)/qapi/common.json \
                $(SRC_PATH)/qapi/block.json $(SRC_PATH)/qapi/block-core.json \
                $(SRC_PATH)/qapi/char.json \
                $(SRC_PATH)/qapi/crypto.json \
+               $(SRC_PATH)/qapi/firmware.json \
                $(SRC_PATH)/qapi/introspect.json \
                $(SRC_PATH)/qapi/migration.json \
                $(SRC_PATH)/qapi/misc.json \
@@ -600,6 +605,7 @@ qapi/qapi-types-block.c qapi/qapi-types-block.h \
 qapi/qapi-types-char.c qapi/qapi-types-char.h \
 qapi/qapi-types-common.c qapi/qapi-types-common.h \
 qapi/qapi-types-crypto.c qapi/qapi-types-crypto.h \
+qapi/qapi-types-firmware.c qapi/qapi-types-firmware.h \
 qapi/qapi-types-introspect.c qapi/qapi-types-introspect.h \
 qapi/qapi-types-migration.c qapi/qapi-types-migration.h \
 qapi/qapi-types-misc.c qapi/qapi-types-misc.h \
@@ -618,6 +624,7 @@ qapi/qapi-visit-block.c qapi/qapi-visit-block.h \
 qapi/qapi-visit-char.c qapi/qapi-visit-char.h \
 qapi/qapi-visit-common.c qapi/qapi-visit-common.h \
 qapi/qapi-visit-crypto.c qapi/qapi-visit-crypto.h \
+qapi/qapi-visit-firmware.c qapi/qapi-visit-firmware.h \
 qapi/qapi-visit-introspect.c qapi/qapi-visit-introspect.h \
 qapi/qapi-visit-migration.c qapi/qapi-visit-migration.h \
 qapi/qapi-visit-misc.c qapi/qapi-visit-misc.h \
@@ -635,6 +642,7 @@ qapi/qapi-commands-block.c qapi/qapi-commands-block.h \
 qapi/qapi-commands-char.c qapi/qapi-commands-char.h \
 qapi/qapi-commands-common.c qapi/qapi-commands-common.h \
 qapi/qapi-commands-crypto.c qapi/qapi-commands-crypto.h \
+qapi/qapi-commands-firmware.c qapi/qapi-commands-firmware.h \
 qapi/qapi-commands-introspect.c qapi/qapi-commands-introspect.h \
 qapi/qapi-commands-migration.c qapi/qapi-commands-migration.h \
 qapi/qapi-commands-misc.c qapi/qapi-commands-misc.h \
@@ -652,6 +660,7 @@ qapi/qapi-events-block.c qapi/qapi-events-block.h \
 qapi/qapi-events-char.c qapi/qapi-events-char.h \
 qapi/qapi-events-common.c qapi/qapi-events-common.h \
 qapi/qapi-events-crypto.c qapi/qapi-events-crypto.h \
+qapi/qapi-events-firmware.c qapi/qapi-events-firmware.h \
 qapi/qapi-events-introspect.c qapi/qapi-events-introspect.h \
 qapi/qapi-events-migration.c qapi/qapi-events-migration.h \
 qapi/qapi-events-misc.c qapi/qapi-events-misc.h \
diff --git a/Makefile.objs b/Makefile.objs
index c6c9b8fc2177..6ed4e0010b10 100644
--- a/Makefile.objs
+++ b/Makefile.objs
@@ -9,6 +9,7 @@ util-obj-y += qapi/qapi-types-block.o
 util-obj-y += qapi/qapi-types-char.o
 util-obj-y += qapi/qapi-types-common.o
 util-obj-y += qapi/qapi-types-crypto.o
+util-obj-y += qapi/qapi-types-firmware.o
 util-obj-y += qapi/qapi-types-introspect.o
 util-obj-y += qapi/qapi-types-migration.o
 util-obj-y += qapi/qapi-types-misc.o
@@ -27,6 +28,7 @@ util-obj-y += qapi/qapi-visit-block.o
 util-obj-y += qapi/qapi-visit-char.o
 util-obj-y += qapi/qapi-visit-common.o
 util-obj-y += qapi/qapi-visit-crypto.o
+util-obj-y += qapi/qapi-visit-firmware.o
 util-obj-y += qapi/qapi-visit-introspect.o
 util-obj-y += qapi/qapi-visit-migration.o
 util-obj-y += qapi/qapi-visit-misc.o
@@ -44,6 +46,7 @@ util-obj-y += qapi/qapi-events-block.o
 util-obj-y += qapi/qapi-events-char.o
 util-obj-y += qapi/qapi-events-common.o
 util-obj-y += qapi/qapi-events-crypto.o
+util-obj-y += qapi/qapi-events-firmware.o
 util-obj-y += qapi/qapi-events-introspect.o
 util-obj-y += qapi/qapi-events-migration.o
 util-obj-y += qapi/qapi-events-misc.o
@@ -139,6 +142,7 @@ common-obj-y += qapi/qapi-commands-block.o
 common-obj-y += qapi/qapi-commands-char.o
 common-obj-y += qapi/qapi-commands-common.o
 common-obj-y += qapi/qapi-commands-crypto.o
+common-obj-y += qapi/qapi-commands-firmware.o
 common-obj-y += qapi/qapi-commands-introspect.o
 common-obj-y += qapi/qapi-commands-migration.o
 common-obj-y += qapi/qapi-commands-misc.o
diff --git a/qapi/firmware.json b/qapi/firmware.json
new file mode 100644
index 000000000000..f267240f44dd
--- /dev/null
+++ b/qapi/firmware.json
@@ -0,0 +1,343 @@
+# -*- Mode: Python -*-
+
+##
+# = Firmware
+##
+
+##
+# @FirmwareDevice:
+#
+# Defines the device types that a firmware file can be mapped into.
+#
+# @memory: The firmware file is to be mapped into memory.
+#
+# @kernel: The firmware file is to be loaded like a Linux kernel. This is
+#          similar to @memory but may imply additional processing that is
+#          specific to the target architecture.
+#
+# @flash: The firmware file is to be mapped into a pflash chip.
+#
+# Since: 2.13
+##
+{ 'enum' : 'FirmwareDevice',
+  'data' : [ 'memory', 'kernel', 'flash' ] }
+
+##
+# @FirmwareAccess:
+#
+# Defines the possible permissions for a given access mode to a device that
+# maps a firmware file.
+#
+# @denied: The access is denied.
+#
+# @permitted: The access is permitted.
+#
+# @restricted-to-secure-context: The access is permitted for guest code that
+#                                runs in a secure context; otherwise the access
+#                                is denied. The definition of "secure context"
+#                                is specific to the target architecture.
+#
+# Since: 2.13
+##
+{ 'enum' : 'FirmwareAccess',
+  'data' : [ 'denied', 'permitted', 'restricted-to-secure-context' ] }
+
+##
+# @FirmwareMapping:
+#
+# Collects the mapping device type and the access permissions to that device
+# for system firmware and for NVRAM slots.
+#
+# @device: The system firmware or the NVRAM slot must reside in a device of
+#          this type.
+#
+# @read: Permission for the guest to read the device that maps the firmware
+#        file. If the field is missing, @permitted is assumed.
+#
+# @write: Permission for the guest to write the device that maps the firmware
+#         file. If the field is missing, @permitted is assumed.
+#
+# @execute: Permission for the guest to execute code from the device that maps
+#           the firmware file. If the field is missing, @permitted is assumed.
+#
+# Since: 2.13
+##
+{ 'struct' : 'FirmwareMapping',
+  'data'   : { 'device'   : 'FirmwareDevice',
+               '*read'    : 'FirmwareAccess',
+               '*write'   : 'FirmwareAccess',
+               '*execute' : 'FirmwareAccess' } }
+
+##
+# @FirmwareFile:
+#
+# Gathers the common traits of system firmware executables and NVRAM templates.
+#
+# @pathname: absolute pathname of the firmware file on the host filesystem
+#
+# @description: human-readable description of the firmware file
+#
+# @tags: a list of machine-readable strings providing additional information
+#
+# @format: If the @FirmwareDevice that this @FirmwareFile is mapped into is
+#          @flash, then @format describes the block format of the drive that
+#          backs the device. Otherwise, this field should be 'raw' or absent.
+#          If the field is missing, 'raw' is assumed.
+#
+# Since: 2.13
+##
+{ 'struct' : 'FirmwareFile',
+  'data'   : { 'pathname'     : 'str',
+               '*description' : 'str',
+               '*tags'        : [ 'str' ],
+               '*format'      : 'str' } }
+
+##
+# @NVRAMSlot:
+#
+# Defines the mapping properties of an NVRAM slot, and associates compatible
+# NVRAM templates with the NVRAM slot.
+#
+# @slot-id: The numeric identifier of the NVRAM slot. The interpretation of
+#           @slot-id is specific to the target architecture and the chosen
+#           system firmware.
+#
+# @nvram-map: the mapping requirements of this NVRAM slot
+#
+# @templates: A non-empty list of @FirmwareFile elements. Any @FirmwareFile
+#             identified by this list as an NVRAM template can be copied to
+#             create an actual NVRAM file, and the NVRAM file can be mapped
+#             into the NVRAM slot identified by @slot-id, subject to the
+#             mapping requirements in @nvram-map.
+#
+# Since: 2.13
+##
+{ 'struct' : 'NVRAMSlot',
+  'data'   : { 'slot-id'   : 'uint64',
+               'nvram-map' : 'FirmwareMapping',
+               'templates' : [ 'FirmwareFile' ] } }
+
+##
+# @SystemFirmwareType:
+#
+# Lists system firmware types commonly used with QEMU virtual machines.
+#
+# @bios: The system firmware was built from the SeaBIOS project.
+#
+# @slof: The system firmware was built from the Slimline Open Firmware project.
+#
+# @uboot: The system firmware was built from the U-Boot project.
+#
+# @uefi: The system firmware was built from the edk2 (EFI Development Kit II)
+#        project.
+#
+# Since: 2.13
+##
+{ 'enum' : 'SystemFirmwareType',
+  'data' : [ 'bios', 'slof', 'uboot', 'uefi' ] }
+
+##
+# @SystemFirmware:
+#
+# Describes a system firmware binary and any NVRAM slots that it requires.
+#
+# @executable: Identifies the platform firmware executable.
+#
+# @type: The type by which the system firmware is commonly known. This is the
+#        main search key by which management software looks up a system
+#        firmware image for a new domain.
+#
+# @targets: a non-empty list of target architectures that are capable of
+#           executing the system firmware
+#
+# @sysfw-map: the mapping requirements of the system firmware binary
+#
+# @nvram-slots: A list of NVRAM slots that are required by the system firmware.
+#               The @slot-id field must be unique across the list. Importantly,
+#               if any @FirmwareAccess is @restricted-to-secure-context in
+#               @sysfw-map or in any @nvram-map in @nvram-slots, then (a) the
+#               virtual machine configuration is required to emulate the secure
+#               code execution context (as defined for @targets), and (b) the
+#               virtual machine configuration is required to actually restrict
+#               the access in question to the secure execution context.
+#
+# @supports-uefi-secure-boot: Whether the system firmware implements the
+#                             software interfaces for UEFI Secure Boot, as
+#                             defined in the UEFI specification. If the field
+#                             is missing, its assumed value is 'false'.
+#
+# @supports-amd-sev: Whether the system firmware supports running under AMD
+#                    Secure Encrypted Virtualization, as specified in the AMD64
+#                    Architecture Programmer's Manual. If the field is missing,
+#                    its assumed value is 'false'.
+#
+# @supports-acpi-s3: Whether the system firmware supports S3 sleep (suspend to
+#                    RAM), as defined in the ACPI specification. If the field
+#                    is missing, its assumed value is 'false'.
+#
+# @supports-acpi-s4: Whether the system firmware supports S4 hibernation
+#                    (suspend to disk), as defined in the ACPI specification.
+#                    If the field is missing, its assumed value is 'false'.
+#
+# Since: 2.13
+#
+# Examples:
+#
+# {
+#     "executable": {
+#         "pathname": "/usr/share/seabios/bios-256k.bin",
+#         "description": "SeaBIOS",
+#         "tags": [
+#             "CONFIG_ROM_SIZE=256"
+#         ]
+#     },
+#     "type": "bios",
+#     "targets": [
+#         "i386",
+#         "x86_64"
+#     ],
+#     "sysfw-map": {
+#         "device": "memory",
+#         "write": "denied"
+#     },
+#     "supports-acpi-s3": true,
+#     "supports-acpi-s4": true
+# }
+#
+# {
+#     "executable": {
+#         "pathname": "/usr/share/OVMF/OVMF_CODE.secboot.fd",
+#         "description": "OVMF with Secure Boot and SMM-protected varstore",
+#         "tags": [
+#             "FD_SIZE_4MB",
+#             "IA32X64",
+#             "SECURE_BOOT_ENABLE",
+#             "SMM_REQUIRE"
+#         ]
+#     },
+#     "type": "uefi",
+#     "targets": [
+#         "x86_64"
+#     ],
+#     "sysfw-map": {
+#         "device": "flash",
+#         "write": "denied"
+#     },
+#     "nvram-slots": [
+#         {
+#             "slot-id": 1,
+#             "nvram-map" : {
+#                 "device": "flash",
+#                 "write": "restricted-to-secure-context"
+#             },
+#             "templates": [
+#                 {
+#                     "pathname": "/usr/share/OVMF/OVMF_VARS.fd",
+#                     "description": "empty varstore template"
+#                 },
+#                 {
+#                     "pathname": "/usr/share/OVMF/OVMF_VARS.secboot.fd",
+#                     "description": "varstore template with the Microsoft certificates enrolled for Secure Boot",
+#                     "tags": [
+#                         "mscerts"
+#                     ]
+#                 }
+#             ]
+#         }
+#     ],
+#     "supports-uefi-secure-boot": true,
+#     "supports-amd-sev": true,
+#     "supports-acpi-s3": true
+# }
+#
+# {
+#     "executable": {
+#         "pathname": "/usr/share/AAVMF/AAVMF_CODE.fd",
+#         "description": "ARM64 UEFI firmware",
+#         "tags": [
+#             "AARCH64"
+#         ]
+#     },
+#     "type": "uefi",
+#     "targets": [
+#         "aarch64"
+#     ],
+#     "sysfw-map": {
+#         "device": "flash",
+#         "write": "denied"
+#     },
+#     "nvram-slots": [
+#         {
+#             "slot-id": 1,
+#             "nvram-map" : {
+#                 "device": "flash"
+#             },
+#             "templates": [
+#                 {
+#                     "pathname": "/usr/share/AAVMF/AAVMF_VARS.fd",
+#                     "description": "empty varstore template"
+#                 }
+#             ]
+#         }
+#     ]
+# }
+#
+# {
+#     "executable": {
+#         "pathname": "/usr/share/edk2.git/ovmf-ia32/OVMF_CODE-pure-efi.fd",
+#         "description": "32-bit OVMF with unprotected varstore and no Secure Boot",
+#         "tags": [
+#             "FD_SIZE_2MB",
+#             "IA32"
+#         ]
+#     },
+#     "type": "uefi",
+#     "targets": [
+#         "i386",
+#         "x86_64"
+#     ],
+#     "sysfw-map": {
+#         "device": "flash",
+#         "write": "denied"
+#     },
+#     "nvram-slots": [
+#         {
+#             "slot-id": 1,
+#             "nvram-map" : {
+#                 "device": "flash"
+#             },
+#             "templates": [
+#                 {
+#                     "pathname": "/usr/share/edk2.git/ovmf-ia32/OVMF_VARS-pure-efi.fd",
+#                     "description": "empty varstore template"
+#                 }
+#             ]
+#         }
+#     ],
+#     "supports-acpi-s3": true
+# }
+##
+{ 'struct' : 'SystemFirmware',
+  'data'   : { 'executable'                 : 'FirmwareFile',
+               'type'                       : 'SystemFirmwareType',
+               'targets'                    : [ 'str' ],
+               'sysfw-map'                  : 'FirmwareMapping',
+               '*nvram-slots'               : [ 'NVRAMSlot' ],
+               '*supports-uefi-secure-boot' : 'bool',
+               '*supports-amd-sev'          : 'bool',
+               '*supports-acpi-s3'          : 'bool',
+               '*supports-acpi-s4'          : 'bool' } }
+
+##
+# @x-check-firmware:
+#
+# Accept a @SystemFirmware object and do nothing, successfully. This command
+# can be used in the QMP shell to validate @SystemFirmware JSON against the
+# schema, and to pretty print it.
+#
+# @sysfw: ignored
+#
+# Since: 2.13
+##
+{ 'command' : 'x-check-firmware',
+  'data'    : { 'sysfw' : 'SystemFirmware' } }
diff --git a/qapi/qapi-schema.json b/qapi/qapi-schema.json
index 25bce78352b8..2d6339ca8c99 100644
--- a/qapi/qapi-schema.json
+++ b/qapi/qapi-schema.json
@@ -92,4 +92,5 @@
 { 'include': 'transaction.json' }
 { 'include': 'trace.json' }
 { 'include': 'introspect.json' }
+{ 'include': 'firmware.json' }
 { 'include': 'misc.json' }
diff --git a/qmp.c b/qmp.c
index f72261667f92..fc9df5c9b05b 100644
--- a/qmp.c
+++ b/qmp.c
@@ -34,6 +34,7 @@
 #include "qapi/qapi-commands-block-core.h"
 #include "qapi/qapi-commands-misc.h"
 #include "qapi/qapi-commands-ui.h"
+#include "qapi/qapi-commands-firmware.h"
 #include "qapi/qmp/qdict.h"
 #include "qapi/qmp/qerror.h"
 #include "qapi/qobject-input-visitor.h"
@@ -781,3 +782,7 @@ void qmp_x_oob_test(bool lock, Error **errp)
         qemu_sem_post(&x_oob_test_sem);
     }
 }
+
+void qmp_x_check_firmware(SystemFirmware *sysfw, Error **errp)
+{
+}
diff --git a/.gitignore b/.gitignore
index 4055e12ee85d..1d8d1066d3d1 100644
--- a/.gitignore
+++ b/.gitignore
@@ -35,6 +35,7 @@
 /qapi/qapi-commands-char.[ch]
 /qapi/qapi-commands-common.[ch]
 /qapi/qapi-commands-crypto.[ch]
+/qapi/qapi-commands-firmware.[ch]
 /qapi/qapi-commands-introspect.[ch]
 /qapi/qapi-commands-migration.[ch]
 /qapi/qapi-commands-misc.[ch]
@@ -52,6 +53,7 @@
 /qapi/qapi-events-char.[ch]
 /qapi/qapi-events-common.[ch]
 /qapi/qapi-events-crypto.[ch]
+/qapi/qapi-events-firmware.[ch]
 /qapi/qapi-events-introspect.[ch]
 /qapi/qapi-events-migration.[ch]
 /qapi/qapi-events-misc.[ch]
@@ -70,6 +72,7 @@
 /qapi/qapi-types-char.[ch]
 /qapi/qapi-types-common.[ch]
 /qapi/qapi-types-crypto.[ch]
+/qapi/qapi-types-firmware.[ch]
 /qapi/qapi-types-introspect.[ch]
 /qapi/qapi-types-migration.[ch]
 /qapi/qapi-types-misc.[ch]
@@ -87,6 +90,7 @@
 /qapi/qapi-visit-char.[ch]
 /qapi/qapi-visit-common.[ch]
 /qapi/qapi-visit-crypto.[ch]
+/qapi/qapi-visit-firmware.[ch]
 /qapi/qapi-visit-introspect.[ch]
 /qapi/qapi-visit-migration.[ch]
 /qapi/qapi-visit-misc.[ch]
-- 
2.14.1.3.gb7cf6e02401b
