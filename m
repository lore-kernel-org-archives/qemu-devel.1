Received: from eggs.gnu.org ([2001:4830:134:3::10]:52144)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1f5SUy-0006jS-GZ
	for qemu-devel@nongnu.org; Mon, 09 Apr 2018 04:50:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1f5SUv-0002c9-9l
	for qemu-devel@nongnu.org; Mon, 09 Apr 2018 04:50:00 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:38150 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1f5SUv-0002bd-1l
	for qemu-devel@nongnu.org; Mon, 09 Apr 2018 04:49:57 -0400
Date: Mon, 9 Apr 2018 09:49:40 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180409084940.GE18283@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20180407000117.25640-1-lersek@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180407000117.25640-1-lersek@redhat.com>
Subject: Re: [Qemu-devel] [qemu RFC] qapi: add "firmware.json"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laszlo Ersek <lersek@redhat.com>
Cc: qemu-devel@nongnu.org, libvir-list@redhat.com, Alexander Graf <agraf@suse.de>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, David Gibson <dgibson@redhat.com>, Eric Blake <eblake@redhat.com>, Gary Ching-Pang Lin <glin@suse.com>, Gerd Hoffmann <kraxel@redhat.com>, Kashyap Chamarthy <kchamart@redhat.com>, Markus Armbruster <armbru@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, Michal Privoznik <mprivozn@redhat.com>, Peter Krempa <pkrempa@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>

On Sat, Apr 07, 2018 at 02:01:17AM +0200, Laszlo Ersek wrote:
> Add a schema that describes the properties of virtual machine firmware.
> 
> Each firmware executable installed on a host system should come with a
> JSON file that conforms to this schema, and informs the management
> applications about the firmware's properties.
> 
> In addition, a configuration directory with symlinks to the JSON files
> should exist, with the symlinks carefully named to reflect a priority
> order. Management applications can then search this directory in priority
> order for the first firmware executable that satisfies their search
> criteria. The found JSON file provides the management layer with domain
> configuration bits that are required to run the firmware binary.
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
> Cc: Peter Krempa <pkrempa@redhat.com>
> Cc: Peter Maydell <peter.maydell@linaro.org>
> Cc: Thomas Huth <thuth@redhat.com>
> Signed-off-by: Laszlo Ersek <lersek@redhat.com>
> ---
> 
> Notes:
>     Folks on the CC list, please try to see if the suggested schema is
>     flexible enough to describe the virtual firmware(s) that you are
>     familiar with. Thanks!
> 
>  Makefile              |   9 ++
>  Makefile.objs         |   4 +
>  qapi/firmware.json    | 343 ++++++++++++++++++++++++++++++++++++++++++++++++++
>  qapi/qapi-schema.json |   1 +
>  qmp.c                 |   5 +
>  .gitignore            |   4 +
>  6 files changed, 366 insertions(+)
>  create mode 100644 qapi/firmware.json
> 

> diff --git a/qapi/firmware.json b/qapi/firmware.json
> new file mode 100644
> index 000000000000..f267240f44dd
> --- /dev/null
> +++ b/qapi/firmware.json
> @@ -0,0 +1,343 @@
> +# -*- Mode: Python -*-
> +
> +##
> +# = Firmware
> +##
> +
> +##
> +# @FirmwareDevice:
> +#
> +# Defines the device types that a firmware file can be mapped into.
> +#
> +# @memory: The firmware file is to be mapped into memory.
> +#
> +# @kernel: The firmware file is to be loaded like a Linux kernel. This is
> +#          similar to @memory but may imply additional processing that is
> +#          specific to the target architecture.
> +#
> +# @flash: The firmware file is to be mapped into a pflash chip.
> +#
> +# Since: 2.13
> +##
> +{ 'enum' : 'FirmwareDevice',
> +  'data' : [ 'memory', 'kernel', 'flash' ] }
> +
> +##
> +# @FirmwareAccess:
> +#
> +# Defines the possible permissions for a given access mode to a device that
> +# maps a firmware file.
> +#
> +# @denied: The access is denied.
> +#
> +# @permitted: The access is permitted.
> +#
> +# @restricted-to-secure-context: The access is permitted for guest code that
> +#                                runs in a secure context; otherwise the access
> +#                                is denied. The definition of "secure context"
> +#                                is specific to the target architecture.
> +#
> +# Since: 2.13
> +##
> +{ 'enum' : 'FirmwareAccess',
> +  'data' : [ 'denied', 'permitted', 'restricted-to-secure-context' ] }

I'm not really understanding the purpose of this - what does it map to
on the command line ?

> +
> +##
> +# @FirmwareMapping:
> +#
> +# Collects the mapping device type and the access permissions to that device
> +# for system firmware and for NVRAM slots.
> +#
> +# @device: The system firmware or the NVRAM slot must reside in a device of
> +#          this type.
> +#
> +# @read: Permission for the guest to read the device that maps the firmware
> +#        file. If the field is missing, @permitted is assumed.
> +#
> +# @write: Permission for the guest to write the device that maps the firmware
> +#         file. If the field is missing, @permitted is assumed.
> +#
> +# @execute: Permission for the guest to execute code from the device that maps
> +#           the firmware file. If the field is missing, @permitted is assumed.
> +#
> +# Since: 2.13
> +##
> +{ 'struct' : 'FirmwareMapping',
> +  'data'   : { 'device'   : 'FirmwareDevice',
> +               '*read'    : 'FirmwareAccess',
> +               '*write'   : 'FirmwareAccess',
> +               '*execute' : 'FirmwareAccess' } }

Again, what this this map to on the command line ?

> +##
> +# @FirmwareFile:
> +#
> +# Gathers the common traits of system firmware executables and NVRAM templates.
> +#
> +# @pathname: absolute pathname of the firmware file on the host filesystem
> +#
> +# @description: human-readable description of the firmware file
> +#
> +# @tags: a list of machine-readable strings providing additional information

This makes it look like this information is something applications should be
using when setting up firmwares, which is definitely not what we want. Lets
rename this

  "@build_options: arbitrary list of firmware specific build options, for
                   informative purposes only. Applications should not attempt
                   to interpret / assign meaning to these options"

> +# @format: If the @FirmwareDevice that this @FirmwareFile is mapped into is
> +#          @flash, then @format describes the block format of the drive that
> +#          backs the device. Otherwise, this field should be 'raw' or absent.
> +#          If the field is missing, 'raw' is assumed.

Why does the format needed ?

If the firmware is to be loaded via a block device driver, then it should
not matter what format is used. If the mgmt app wants to take the firmware
file and convert it to qcow2 format that's fine - the code loading this
in QEMU will still see raw content.

> +#
> +# Since: 2.13
> +##
> +{ 'struct' : 'FirmwareFile',
> +  'data'   : { 'pathname'     : 'str',
> +               '*description' : 'str',
> +               '*tags'        : [ 'str' ],
> +               '*format'      : 'str' } }
> +
> +##
> +# @NVRAMSlot:
> +#
> +# Defines the mapping properties of an NVRAM slot, and associates compatible
> +# NVRAM templates with the NVRAM slot.
> +#
> +# @slot-id: The numeric identifier of the NVRAM slot. The interpretation of
> +#           @slot-id is specific to the target architecture and the chosen
> +#           system firmware.

What does this correspond to at the CLI level ?  Is this the -drive unit=NN
option when loading via a block device ?

> +#
> +# @nvram-map: the mapping requirements of this NVRAM slot
> +#
> +# @templates: A non-empty list of @FirmwareFile elements. Any @FirmwareFile
> +#             identified by this list as an NVRAM template can be copied to
> +#             create an actual NVRAM file, and the NVRAM file can be mapped
> +#             into the NVRAM slot identified by @slot-id, subject to the
> +#             mapping requirements in @nvram-map.
> +#
> +# Since: 2.13
> +##
> +{ 'struct' : 'NVRAMSlot',
> +  'data'   : { 'slot-id'   : 'uint64',
> +               'nvram-map' : 'FirmwareMapping',
> +               'templates' : [ 'FirmwareFile' ] } }
> +
> +##
> +# @SystemFirmwareType:
> +#
> +# Lists system firmware types commonly used with QEMU virtual machines.
> +#
> +# @bios: The system firmware was built from the SeaBIOS project.
> +#
> +# @slof: The system firmware was built from the Slimline Open Firmware project.
> +#
> +# @uboot: The system firmware was built from the U-Boot project.
> +#
> +# @uefi: The system firmware was built from the edk2 (EFI Development Kit II)
> +#        project.
> +#
> +# Since: 2.13
> +##
> +{ 'enum' : 'SystemFirmwareType',
> +  'data' : [ 'bios', 'slof', 'uboot', 'uefi' ] }
> +
> +##
> +# @SystemFirmware:
> +#
> +# Describes a system firmware binary and any NVRAM slots that it requires.
> +#
> +# @executable: Identifies the platform firmware executable.
> +#
> +# @type: The type by which the system firmware is commonly known. This is the
> +#        main search key by which management software looks up a system
> +#        firmware image for a new domain.
> +#
> +# @targets: a non-empty list of target architectures that are capable of
> +#           executing the system firmware
> +#
> +# @sysfw-map: the mapping requirements of the system firmware binary
> +#
> +# @nvram-slots: A list of NVRAM slots that are required by the system firmware.
> +#               The @slot-id field must be unique across the list. Importantly,
> +#               if any @FirmwareAccess is @restricted-to-secure-context in
> +#               @sysfw-map or in any @nvram-map in @nvram-slots, then (a) the
> +#               virtual machine configuration is required to emulate the secure
> +#               code execution context (as defined for @targets), and (b) the
> +#               virtual machine configuration is required to actually restrict
> +#               the access in question to the secure execution context.
> +#
> +# @supports-uefi-secure-boot: Whether the system firmware implements the
> +#                             software interfaces for UEFI Secure Boot, as
> +#                             defined in the UEFI specification. If the field
> +#                             is missing, its assumed value is 'false'.
> +#
> +# @supports-amd-sev: Whether the system firmware supports running under AMD
> +#                    Secure Encrypted Virtualization, as specified in the AMD64
> +#                    Architecture Programmer's Manual. If the field is missing,
> +#                    its assumed value is 'false'.
> +#
> +# @supports-acpi-s3: Whether the system firmware supports S3 sleep (suspend to
> +#                    RAM), as defined in the ACPI specification. If the field
> +#                    is missing, its assumed value is 'false'.
> +#
> +# @supports-acpi-s4: Whether the system firmware supports S4 hibernation
> +#                    (suspend to disk), as defined in the ACPI specification.
> +#                    If the field is missing, its assumed value is 'false'.

I think these should just be an enum again

  "FirmwareFeatures": [ "secure-boot", "amd-sev", "acpi-s3", "acpi-s4" ]

> +#
> +# Since: 2.13
> +#
> +# Examples:
> +#
> +# {
> +#     "executable": {
> +#         "pathname": "/usr/share/seabios/bios-256k.bin",
> +#         "description": "SeaBIOS",
> +#         "tags": [
> +#             "CONFIG_ROM_SIZE=256"
> +#         ]
> +#     },
> +#     "type": "bios",
> +#     "targets": [
> +#         "i386",
> +#         "x86_64"
> +#     ],
> +#     "sysfw-map": {
> +#         "device": "memory",
> +#         "write": "denied"
> +#     },
> +#     "supports-acpi-s3": true,
> +#     "supports-acpi-s4": true
> +# }
> +#
> +# {
> +#     "executable": {
> +#         "pathname": "/usr/share/OVMF/OVMF_CODE.secboot.fd",
> +#         "description": "OVMF with Secure Boot and SMM-protected varstore",
> +#         "tags": [
> +#             "FD_SIZE_4MB",
> +#             "IA32X64",
> +#             "SECURE_BOOT_ENABLE",
> +#             "SMM_REQUIRE"
> +#         ]
> +#     },
> +#     "type": "uefi",
> +#     "targets": [
> +#         "x86_64"
> +#     ],
> +#     "sysfw-map": {
> +#         "device": "flash",
> +#         "write": "denied"
> +#     },
> +#     "nvram-slots": [
> +#         {
> +#             "slot-id": 1,
> +#             "nvram-map" : {
> +#                 "device": "flash",
> +#                 "write": "restricted-to-secure-context"
> +#             },
> +#             "templates": [
> +#                 {
> +#                     "pathname": "/usr/share/OVMF/OVMF_VARS.fd",
> +#                     "description": "empty varstore template"
> +#                 },
> +#                 {
> +#                     "pathname": "/usr/share/OVMF/OVMF_VARS.secboot.fd",
> +#                     "description": "varstore template with the Microsoft certificates enrolled for Secure Boot",
> +#                     "tags": [
> +#                         "mscerts"
> +#                     ]

The tags field is arbitrary firmware specific strings with no pre-declared
meaning. So we need to provide a explicit way to represent features against
this, such that libvirt can determine the secure boot vars file.

> +#                 }
> +#             ]
> +#         }
> +#     ],
> +#     "supports-uefi-secure-boot": true,
> +#     "supports-amd-sev": true,
> +#     "supports-acpi-s3": true
> +# }
> +#
> +# {
> +#     "executable": {
> +#         "pathname": "/usr/share/AAVMF/AAVMF_CODE.fd",
> +#         "description": "ARM64 UEFI firmware",
> +#         "tags": [
> +#             "AARCH64"
> +#         ]
> +#     },
> +#     "type": "uefi",
> +#     "targets": [
> +#         "aarch64"
> +#     ],
> +#     "sysfw-map": {
> +#         "device": "flash",
> +#         "write": "denied"
> +#     },
> +#     "nvram-slots": [
> +#         {
> +#             "slot-id": 1,
> +#             "nvram-map" : {
> +#                 "device": "flash"
> +#             },
> +#             "templates": [
> +#                 {
> +#                     "pathname": "/usr/share/AAVMF/AAVMF_VARS.fd",
> +#                     "description": "empty varstore template"
> +#                 }
> +#             ]
> +#         }
> +#     ]
> +# }
> +#
> +# {
> +#     "executable": {
> +#         "pathname": "/usr/share/edk2.git/ovmf-ia32/OVMF_CODE-pure-efi.fd",
> +#         "description": "32-bit OVMF with unprotected varstore and no Secure Boot",
> +#         "tags": [
> +#             "FD_SIZE_2MB",
> +#             "IA32"
> +#         ]
> +#     },
> +#     "type": "uefi",
> +#     "targets": [
> +#         "i386",
> +#         "x86_64"
> +#     ],
> +#     "sysfw-map": {
> +#         "device": "flash",
> +#         "write": "denied"
> +#     },
> +#     "nvram-slots": [
> +#         {
> +#             "slot-id": 1,
> +#             "nvram-map" : {
> +#                 "device": "flash"
> +#             },
> +#             "templates": [
> +#                 {
> +#                     "pathname": "/usr/share/edk2.git/ovmf-ia32/OVMF_VARS-pure-efi.fd",
> +#                     "description": "empty varstore template"
> +#                 }
> +#             ]
> +#         }
> +#     ],
> +#     "supports-acpi-s3": true
> +# }
> +##
> +{ 'struct' : 'SystemFirmware',
> +  'data'   : { 'executable'                 : 'FirmwareFile',
> +               'type'                       : 'SystemFirmwareType',
> +               'targets'                    : [ 'str' ],
> +               'sysfw-map'                  : 'FirmwareMapping',
> +               '*nvram-slots'               : [ 'NVRAMSlot' ],
> +               '*supports-uefi-secure-boot' : 'bool',
> +               '*supports-amd-sev'          : 'bool',
> +               '*supports-acpi-s3'          : 'bool',
> +               '*supports-acpi-s4'          : 'bool' } }
> +
> +##
> +# @x-check-firmware:
> +#
> +# Accept a @SystemFirmware object and do nothing, successfully. This command
> +# can be used in the QMP shell to validate @SystemFirmware JSON against the
> +# schema, and to pretty print it.
> +#
> +# @sysfw: ignored
> +#
> +# Since: 2.13
> +##
> +{ 'command' : 'x-check-firmware',
> +  'data'    : { 'sysfw' : 'SystemFirmware' } }

The "json_reformat" command line tool can be used for reformatting

I wonder if we could usefully provide a command line tool for qemu to
validate against qapi schemas ? eg something like

   qemu-qapi-validate --type=SystemFirmware /path/to/schema /path/to/document

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
