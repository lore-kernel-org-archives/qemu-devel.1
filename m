Received: from eggs.gnu.org ([2001:4830:134:3::10]:42013)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1f5Zs6-00048q-C4
	for qemu-devel@nongnu.org; Mon, 09 Apr 2018 12:42:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1f5Zs1-0000wx-BX
	for qemu-devel@nongnu.org; Mon, 09 Apr 2018 12:42:22 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:46974 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1f5Zs1-0000wk-6x
	for qemu-devel@nongnu.org; Mon, 09 Apr 2018 12:42:17 -0400
References: <20180407000117.25640-1-lersek@redhat.com>
	<979bd720-cdb3-6468-1fbd-e8ec1c6c6c8d@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <8ddd0a2f-b9b1-08c0-0f4d-62e7aea7e96a@redhat.com>
Date: Mon, 9 Apr 2018 18:42:00 +0200
MIME-Version: 1.0
In-Reply-To: <979bd720-cdb3-6468-1fbd-e8ec1c6c6c8d@redhat.com>
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
Cc: "Daniel P. Berrange" <berrange@redhat.com>, Alexander Graf <agraf@suse.de>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, David Gibson <dgibson@redhat.com>, Eric Blake <eblake@redhat.com>, Gary Ching-Pang Lin <glin@suse.com>, Gerd Hoffmann <kraxel@redhat.com>, Kashyap Chamarthy <kchamart@redhat.com>, Markus Armbruster <armbru@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, Michal Privoznik <mprivozn@redhat.com>, Peter Krempa <pkrempa@redhat.com>, Peter Maydell <peter.maydell@linaro.org>

On 04/09/18 10:08, Thomas Huth wrote:
> On 07.04.2018 02:01, Laszlo Ersek wrote:
>> Add a schema that describes the properties of virtual machine firmware.
> [...]
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
> 
> Another thought: I think that "targets" field is not enough. You also
> need to map firmware images to certain machines.

I expected this :)

> For example, on
> aarch64, the AAVMF firmware only works on the "virt" machine, but not on
> "raspi2" (I guess). On ppc64, SLOF only works for "pseries", but not for
> the other machines like "mac99" or "g3beige". And on x86_64, EDK2 only
> works for "q35" and "pc-i440fx", but not for "isapc".

What's more, the SMM driver stack of edk2, when it's built into OVMF
(x86), doesn't work on i440fx at all; it requires Q35, and even from
that, a 2.4+ version (if memory serves).

Here's my problem with machine types in this schema (because, believe it
or not, I added such element(s) at first, but then gave up and killed them):

- if you add a *whitelist* of compatible machine types, then every time
you install a new QEMU version on the host (with a new, most-recent,
machine type), that machine type will not be on the whitelist (because,
remember, the JSON document comes with the firmware package). So, you'll
have to keep extending the JSON installed with the firmware image. Bad.

- if you add a *blacklist* of incompatible machine types, then the same
issue arises -- a new i440fx machine type, or even a completely new
machine type family, have to be blacklisted when they come out. They
should not be assumed SMM-compatible, for example, until proved so.

- I considered adding wildcards (say, blacklist "all" i440fx machtypes,
present and future, for SMM-requiring OVMF builds), but then you get
into version sorting and similar mess. I considered fnmatch() --
basically simple ? and * wildcards -- but that's not expressive enough.

So, my thinking was, all these "smarts" belong in actual libvirtd code
(C code), and the schema should only allow libvirtd to *recognize* what
is what.

Thanks,
Laszlo
