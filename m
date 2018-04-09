Received: from eggs.gnu.org ([2001:4830:134:3::10]:37572)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1f5Zkw-0001LG-4o
	for qemu-devel@nongnu.org; Mon, 09 Apr 2018 12:35:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1f5Zks-0004sj-RF
	for qemu-devel@nongnu.org; Mon, 09 Apr 2018 12:34:58 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:51604 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1f5Zks-0004sW-KN
	for qemu-devel@nongnu.org; Mon, 09 Apr 2018 12:34:54 -0400
References: <20180407000117.25640-1-lersek@redhat.com>
	<bf5fc85b-0695-3bd0-117d-759d5dbd4546@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <6bfdae78-909f-e7ad-b0f0-25f76dfd81f7@redhat.com>
Date: Mon, 9 Apr 2018 18:34:41 +0200
MIME-Version: 1.0
In-Reply-To: <bf5fc85b-0695-3bd0-117d-759d5dbd4546@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [qemu RFC] qapi: add "firmware.json"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, libvir-list@redhat.com
Cc: "Daniel P. Berrange" <berrange@redhat.com>, Alexander Graf <agraf@suse.de>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, David Gibson <dgibson@redhat.com>, Eric Blake <eblake@redhat.com>, Gary Ching-Pang Lin <glin@suse.com>, Gerd Hoffmann <kraxel@redhat.com>, Kashyap Chamarthy <kchamart@redhat.com>, Markus Armbruster <armbru@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, Michal Privoznik <mprivozn@redhat.com>, Peter Krempa <pkrempa@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, David Gibson <david@gibson.dropbear.id.au>, Laurent Vivier <lvivier@redhat.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

On 04/09/18 09:26, Thomas Huth wrote:
>  Hi Laszlo,
> 
> On 07.04.2018 02:01, Laszlo Ersek wrote:
>> Add a schema that describes the properties of virtual machine firmware.
>>
>> Each firmware executable installed on a host system should come with a
>> JSON file that conforms to this schema, and informs the management
>> applications about the firmware's properties.
>>
>> In addition, a configuration directory with symlinks to the JSON files
>> should exist, with the symlinks carefully named to reflect a priority
>> order. Management applications can then search this directory in priority
>> order for the first firmware executable that satisfies their search
>> criteria. The found JSON file provides the management layer with domain
>> configuration bits that are required to run the firmware binary.
> [...]
>> +##
>> +# @FirmwareDevice:
>> +#
>> +# Defines the device types that a firmware file can be mapped into.
>> +#
>> +# @memory: The firmware file is to be mapped into memory.
>> +#
>> +# @kernel: The firmware file is to be loaded like a Linux kernel. This is
>> +#          similar to @memory but may imply additional processing that is
>> +#          specific to the target architecture.
>> +#
>> +# @flash: The firmware file is to be mapped into a pflash chip.
>> +#
>> +# Since: 2.13
>> +##
>> +{ 'enum' : 'FirmwareDevice',
>> +  'data' : [ 'memory', 'kernel', 'flash' ] }
> 
> This is not fully clear to me... what is this exactly good for? Is this
> a way to say how the firmware should be loaded, i.e. via "-bios",
> "-kernel" or "-pflash" parameter? If so, the term "memory" is quite
> misleading since files that are loaded via -bios can also end up in an
> emulated ROM chip.

I threw in "-kernel" because, although it also (usually?) means
"memory", I expected people would want it separate.

Regarding memory vs. pflash, I thought that these two, combined with the
access permissions, could cover all of RAM, ROM, and read-only and
read-write pflash too.

So, "-bios" (-> ROM) boils down to "memory", with write access denied --
please see the SeaBIOS example near the end.

> 
> [...]
>> +##
>> +# @NVRAMSlot:
>> +#
>> +# Defines the mapping properties of an NVRAM slot, and associates compatible
>> +# NVRAM templates with the NVRAM slot.
>> +#
>> +# @slot-id: The numeric identifier of the NVRAM slot. The interpretation of
>> +#           @slot-id is specific to the target architecture and the chosen
>> +#           system firmware.
>> +#
>> +# @nvram-map: the mapping requirements of this NVRAM slot
>> +#
>> +# @templates: A non-empty list of @FirmwareFile elements. Any @FirmwareFile
>> +#             identified by this list as an NVRAM template can be copied to
>> +#             create an actual NVRAM file, and the NVRAM file can be mapped
>> +#             into the NVRAM slot identified by @slot-id, subject to the
>> +#             mapping requirements in @nvram-map.
>> +#
>> +# Since: 2.13
>> +##
>> +{ 'struct' : 'NVRAMSlot',
>> +  'data'   : { 'slot-id'   : 'uint64',
> 
> Not sure whether I've got the idea here right, so take this with a grain
> of salt: Maybe 'uint64' is not flexible enough here. PAPR uses both, an
> ID and a name (string), see chapter 8.3 in
> https://members.openpowerfoundation.org/document/dl/469 ... but I guess
> we could start with the 'slot-id' here and add a name field later if
> necessary.

I only added "slot-id" as an initial place holder for telling apart the
individual NVRAMSlot elements in "SystemFirmware.nvram-slots". I
expected a scalar wouldn't be expressive enough for all arches, but, as
you say, it can be extended later.

> 
>> +               'nvram-map' : 'FirmwareMapping',
>> +               'templates' : [ 'FirmwareFile' ] } }
>> +
>> +##
>> +# @SystemFirmwareType:
>> +#
>> +# Lists system firmware types commonly used with QEMU virtual machines.
>> +#
>> +# @bios: The system firmware was built from the SeaBIOS project.
>> +#
>> +# @slof: The system firmware was built from the Slimline Open Firmware project.
>> +#
>> +# @uboot: The system firmware was built from the U-Boot project.
>> +#
>> +# @uefi: The system firmware was built from the edk2 (EFI Development Kit II)
>> +#        project.
>> +#
>> +# Since: 2.13
>> +##
>> +{ 'enum' : 'SystemFirmwareType',
>> +  'data' : [ 'bios', 'slof', 'uboot', 'uefi' ] }
> 
> The naming here is quite a bad mixture between firmware interface
> ('bios', 'uefi') and firmware implementations ('slof', 'uboot'). There
> could be other implementations of BIOS or UEFI than SeaBIOS and EDK2 ...
> so I'd suggest to rather name them 'seabios' and 'edk2' here instead.

Sure, I'm totally ready to follow community advice here (too).

In fact this is the one element I dislike the most about the schema --
it's the fuzziest part, yet it is the most important element for
libvirt. Because users and higher level apps just want to say "give me
UEFI". If I have to ask "OK, but UEFI built from edk2 or something
else?", then it's a lost cause already.

It's hard to find the right level of abstraction in the naming when the
higher level tools (and/or ultimately the users) don't know enough to
ask for specifics -- I'm not saying that's bad; it's quite natural, but
makes things very difficult. So this enum aims to match the user story
"gimme UEFI and be done with it". I figure users will just utter the
most common buzzword form of the concept they have in mind. "edk2"
doesn't tell them as much as "uefi".

> QEMU also ships with a couple of OpenBIOS images, so you should include
> that in this list here, too.

Sure thing.

> 
> And since the SystemFirmwareType field in the SystemFirmware struct
> below is not optional, you should also include an 'other' type here. Or
> make the SystemFirmwareType in SystemFirmware optional. Otherwise it's
> not possible to specify other firmware implementations with this scheme.

That's actually a feature, not a bug. Whenever a new firmware *type*
surfaces in our communities, such that libvirt should integrate it, it
has to become addressible by a simple "type" moniker. That's the entire
goal of this exercise -- the initial domain XML wants to say "gimme
FOOBAR", and FOOBAR it shall be, whatever it takes. Not "other". Nobody
will say 'give me a VM with "other" firmware'.

> 
>> +##
>> +# @SystemFirmware:
>> +#
>> +# Describes a system firmware binary and any NVRAM slots that it requires.
>> +#
>> +# @executable: Identifies the platform firmware executable.
>> +#
>> +# @type: The type by which the system firmware is commonly known. This is the
>> +#        main search key by which management software looks up a system
>> +#        firmware image for a new domain.
>> +#
>> +# @targets: a non-empty list of target architectures that are capable of
>> +#           executing the system firmware
>> +#
>> +# @sysfw-map: the mapping requirements of the system firmware binary
>> +#
>> +# @nvram-slots: A list of NVRAM slots that are required by the system firmware.
>> +#               The @slot-id field must be unique across the list. Importantly,
>> +#               if any @FirmwareAccess is @restricted-to-secure-context in
>> +#               @sysfw-map or in any @nvram-map in @nvram-slots, then (a) the
>> +#               virtual machine configuration is required to emulate the secure
>> +#               code execution context (as defined for @targets), and (b) the
>> +#               virtual machine configuration is required to actually restrict
>> +#               the access in question to the secure execution context.
>> +#
>> +# @supports-uefi-secure-boot: Whether the system firmware implements the
>> +#                             software interfaces for UEFI Secure Boot, as
>> +#                             defined in the UEFI specification. If the field
>> +#                             is missing, its assumed value is 'false'.
>> +#
>> +# @supports-amd-sev: Whether the system firmware supports running under AMD
>> +#                    Secure Encrypted Virtualization, as specified in the AMD64
>> +#                    Architecture Programmer's Manual. If the field is missing,
>> +#                    its assumed value is 'false'.
>> +#
>> +# @supports-acpi-s3: Whether the system firmware supports S3 sleep (suspend to
>> +#                    RAM), as defined in the ACPI specification. If the field
>> +#                    is missing, its assumed value is 'false'.
>> +#
>> +# @supports-acpi-s4: Whether the system firmware supports S4 hibernation
>> +#                    (suspend to disk), as defined in the ACPI specification.
>> +#                    If the field is missing, its assumed value is 'false'.
>> +#
>> +# Since: 2.13
>> +#
>> +# Examples:
>> +#
>> +# {
>> +#     "executable": {
>> +#         "pathname": "/usr/share/seabios/bios-256k.bin",
>> +#         "description": "SeaBIOS",
>> +#         "tags": [
>> +#             "CONFIG_ROM_SIZE=256"
>> +#         ]
>> +#     },
>> +#     "type": "bios",
>> +#     "targets": [
>> +#         "i386",
>> +#         "x86_64"
>> +#     ],
>> +#     "sysfw-map": {
>> +#         "device": "memory",
>> +#         "write": "denied"
>> +#     },
>> +#     "supports-acpi-s3": true,
>> +#     "supports-acpi-s4": true
>> +# }
>> +#
>> +# {
>> +#     "executable": {
>> +#         "pathname": "/usr/share/OVMF/OVMF_CODE.secboot.fd",
>> +#         "description": "OVMF with Secure Boot and SMM-protected varstore",
>> +#         "tags": [
>> +#             "FD_SIZE_4MB",
>> +#             "IA32X64",
>> +#             "SECURE_BOOT_ENABLE",
>> +#             "SMM_REQUIRE"
>> +#         ]
>> +#     },
>> +#     "type": "uefi",
>> +#     "targets": [
>> +#         "x86_64"
>> +#     ],
>> +#     "sysfw-map": {
>> +#         "device": "flash",
>> +#         "write": "denied"
>> +#     },
>> +#     "nvram-slots": [
>> +#         {
>> +#             "slot-id": 1,
>> +#             "nvram-map" : {
>> +#                 "device": "flash",
>> +#                 "write": "restricted-to-secure-context"
>> +#             },
>> +#             "templates": [
>> +#                 {
>> +#                     "pathname": "/usr/share/OVMF/OVMF_VARS.fd",
>> +#                     "description": "empty varstore template"
>> +#                 },
>> +#                 {
>> +#                     "pathname": "/usr/share/OVMF/OVMF_VARS.secboot.fd",
>> +#                     "description": "varstore template with the Microsoft certificates enrolled for Secure Boot",
>> +#                     "tags": [
>> +#                         "mscerts"
>> +#                     ]
>> +#                 }
>> +#             ]
>> +#         }
>> +#     ],
>> +#     "supports-uefi-secure-boot": true,
>> +#     "supports-amd-sev": true,
>> +#     "supports-acpi-s3": true
>> +# }
>> +#
>> +# {
>> +#     "executable": {
>> +#         "pathname": "/usr/share/AAVMF/AAVMF_CODE.fd",
>> +#         "description": "ARM64 UEFI firmware",
>> +#         "tags": [
>> +#             "AARCH64"
>> +#         ]
>> +#     },
>> +#     "type": "uefi",
>> +#     "targets": [
>> +#         "aarch64"
>> +#     ],
>> +#     "sysfw-map": {
>> +#         "device": "flash",
>> +#         "write": "denied"
>> +#     },
>> +#     "nvram-slots": [
>> +#         {
>> +#             "slot-id": 1,
>> +#             "nvram-map" : {
>> +#                 "device": "flash"
>> +#             },
>> +#             "templates": [
>> +#                 {
>> +#                     "pathname": "/usr/share/AAVMF/AAVMF_VARS.fd",
>> +#                     "description": "empty varstore template"
>> +#                 }
>> +#             ]
>> +#         }
>> +#     ]
>> +# }
>> +#
>> +# {
>> +#     "executable": {
>> +#         "pathname": "/usr/share/edk2.git/ovmf-ia32/OVMF_CODE-pure-efi.fd",
>> +#         "description": "32-bit OVMF with unprotected varstore and no Secure Boot",
>> +#         "tags": [
>> +#             "FD_SIZE_2MB",
>> +#             "IA32"
>> +#         ]
>> +#     },
>> +#     "type": "uefi",
>> +#     "targets": [
>> +#         "i386",
>> +#         "x86_64"
>> +#     ],
>> +#     "sysfw-map": {
>> +#         "device": "flash",
>> +#         "write": "denied"
>> +#     },
>> +#     "nvram-slots": [
>> +#         {
>> +#             "slot-id": 1,
>> +#             "nvram-map" : {
>> +#                 "device": "flash"
>> +#             },
>> +#             "templates": [
>> +#                 {
>> +#                     "pathname": "/usr/share/edk2.git/ovmf-ia32/OVMF_VARS-pure-efi.fd",
>> +#                     "description": "empty varstore template"
>> +#                 }
>> +#             ]
>> +#         }
>> +#     ],
>> +#     "supports-acpi-s3": true
>> +# }
>> +##
>> +{ 'struct' : 'SystemFirmware',
>> +  'data'   : { 'executable'                 : 'FirmwareFile',
>> +               'type'                       : 'SystemFirmwareType',
>> +               'targets'                    : [ 'str' ],
>> +               'sysfw-map'                  : 'FirmwareMapping',
>> +               '*nvram-slots'               : [ 'NVRAMSlot' ],
>> +               '*supports-uefi-secure-boot' : 'bool',
>> +               '*supports-amd-sev'          : 'bool',
>> +               '*supports-acpi-s3'          : 'bool',
>> +               '*supports-acpi-s4'          : 'bool' } }
>> +
>> +##
>> +# @x-check-firmware:
>> +#
>> +# Accept a @SystemFirmware object and do nothing, successfully. This command
>> +# can be used in the QMP shell to validate @SystemFirmware JSON against the
>> +# schema, and to pretty print it.
>> +#
>> +# @sysfw: ignored
>> +#
>> +# Since: 2.13
>> +##
>> +{ 'command' : 'x-check-firmware',
>> +  'data'    : { 'sysfw' : 'SystemFirmware' } }
> 
> Maybe it would be more useful to have a way to load a firmware image via
> such a json file? E.g. run "qemu-system-x86_64 -bios seabios.json" or
> something similar?

I think that's very much out of scope... for me anyway :)

I believe (but I could be wrong) that the *only* reason I posted this
patch for QEMU is that QEMU is the one project with schema
administration / coordination. I don't really think QEMU actually has to
implement any features around this, it just has to manage the schema and
ensure well-formedness. I remain somewhat unconvinced QEMU is the best
place for this schema, but I couldn't suggest anything better.

Basically the producers of JSON documents that conform to this schema
are the firmware packages that get installed on host systems. The
consumer is libvirtd (to my understanding), and through libvirtd, higher
level applications. I don't fully know with what project that leaves us
for hosting the schema itself. I originally thought QEMU had nothing to
do with it, but that seemed counter to the consensus :)

> Or a QAPI command that can be used to load a firmware image this way?
> (which would only work before the guest has been started of course)

Thanks!
Laszlo
