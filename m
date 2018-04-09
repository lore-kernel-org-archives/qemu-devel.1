Received: from eggs.gnu.org ([2001:4830:134:3::10]:35634)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1f5b3X-00071O-GA
	for qemu-devel@nongnu.org; Mon, 09 Apr 2018 13:58:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1f5b3U-0008RM-A0
	for qemu-devel@nongnu.org; Mon, 09 Apr 2018 13:58:15 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:54202 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1f5b3U-0008Qy-38
	for qemu-devel@nongnu.org; Mon, 09 Apr 2018 13:58:12 -0400
References: <20180407000117.25640-1-lersek@redhat.com>
	<20180409084940.GE18283@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <3381bdf1-62ea-9da7-c654-032c0c11fb4e@redhat.com>
Date: Mon, 9 Apr 2018 19:57:54 +0200
MIME-Version: 1.0
In-Reply-To: <20180409084940.GE18283@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [qemu RFC] qapi: add "firmware.json"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "=?UTF-8?Q?Daniel_P._Berrang=c3=a9?=" <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, libvir-list@redhat.com, Alexander Graf <agraf@suse.de>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, David Gibson <dgibson@redhat.com>, Eric Blake <eblake@redhat.com>, Gary Ching-Pang Lin <glin@suse.com>, Gerd Hoffmann <kraxel@redhat.com>, Kashyap Chamarthy <kchamart@redhat.com>, Markus Armbruster <armbru@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, Michal Privoznik <mprivozn@redhat.com>, Peter Krempa <pkrempa@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>

On 04/09/18 10:49, Daniel P. Berrang=C3=A9 wrote:
> On Sat, Apr 07, 2018 at 02:01:17AM +0200, Laszlo Ersek wrote:
>> Add a schema that describes the properties of virtual machine firmware=
.
>>
>> Each firmware executable installed on a host system should come with a
>> JSON file that conforms to this schema, and informs the management
>> applications about the firmware's properties.
>>
>> In addition, a configuration directory with symlinks to the JSON files
>> should exist, with the symlinks carefully named to reflect a priority
>> order. Management applications can then search this directory in prior=
ity
>> order for the first firmware executable that satisfies their search
>> criteria. The found JSON file provides the management layer with domai=
n
>> configuration bits that are required to run the firmware binary.
>>
>> Cc: "Daniel P. Berrange" <berrange@redhat.com>
>> Cc: Alexander Graf <agraf@suse.de>
>> Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
>> Cc: David Gibson <dgibson@redhat.com>
>> Cc: Eric Blake <eblake@redhat.com>
>> Cc: Gary Ching-Pang Lin <glin@suse.com>
>> Cc: Gerd Hoffmann <kraxel@redhat.com>
>> Cc: Kashyap Chamarthy <kchamart@redhat.com>
>> Cc: Markus Armbruster <armbru@redhat.com>
>> Cc: Michael Roth <mdroth@linux.vnet.ibm.com>
>> Cc: Michal Privoznik <mprivozn@redhat.com>
>> Cc: Peter Krempa <pkrempa@redhat.com>
>> Cc: Peter Maydell <peter.maydell@linaro.org>
>> Cc: Thomas Huth <thuth@redhat.com>
>> Signed-off-by: Laszlo Ersek <lersek@redhat.com>
>> ---
>>
>> Notes:
>>     Folks on the CC list, please try to see if the suggested schema is
>>     flexible enough to describe the virtual firmware(s) that you are
>>     familiar with. Thanks!
>>
>>  Makefile              |   9 ++
>>  Makefile.objs         |   4 +
>>  qapi/firmware.json    | 343 +++++++++++++++++++++++++++++++++++++++++=
+++++++++
>>  qapi/qapi-schema.json |   1 +
>>  qmp.c                 |   5 +
>>  .gitignore            |   4 +
>>  6 files changed, 366 insertions(+)
>>  create mode 100644 qapi/firmware.json
>>
>=20
>> diff --git a/qapi/firmware.json b/qapi/firmware.json
>> new file mode 100644
>> index 000000000000..f267240f44dd
>> --- /dev/null
>> +++ b/qapi/firmware.json
>> @@ -0,0 +1,343 @@
>> +# -*- Mode: Python -*-
>> +
>> +##
>> +# =3D Firmware
>> +##
>> +
>> +##
>> +# @FirmwareDevice:
>> +#
>> +# Defines the device types that a firmware file can be mapped into.
>> +#
>> +# @memory: The firmware file is to be mapped into memory.
>> +#
>> +# @kernel: The firmware file is to be loaded like a Linux kernel. Thi=
s is
>> +#          similar to @memory but may imply additional processing tha=
t is
>> +#          specific to the target architecture.
>> +#
>> +# @flash: The firmware file is to be mapped into a pflash chip.
>> +#
>> +# Since: 2.13
>> +##
>> +{ 'enum' : 'FirmwareDevice',
>> +  'data' : [ 'memory', 'kernel', 'flash' ] }
>> +
>> +##
>> +# @FirmwareAccess:
>> +#
>> +# Defines the possible permissions for a given access mode to a devic=
e that
>> +# maps a firmware file.
>> +#
>> +# @denied: The access is denied.
>> +#
>> +# @permitted: The access is permitted.
>> +#
>> +# @restricted-to-secure-context: The access is permitted for guest co=
de that
>> +#                                runs in a secure context; otherwise =
the access
>> +#                                is denied. The definition of "secure=
 context"
>> +#                                is specific to the target architectu=
re.
>> +#
>> +# Since: 2.13
>> +##
>> +{ 'enum' : 'FirmwareAccess',
>> +  'data' : [ 'denied', 'permitted', 'restricted-to-secure-context' ] =
}
>=20
> I'm not really understanding the purpose of this - what does it map to
> on the command line ?

That's difficult to answer generally, because -bios and -kernel have
different meanings per board type. So I didn't aim at command line
switches here; instead I tried to capture where and how the firmware
wants to "end up" in the virtual hardware. How that maps to a particular
board is a separate question.

For example, OVMF can be loaded in a multitude of ways:

(1) "OVMF.fd" (a unified image that contains an executable and a live
variable store too) can be loaded with "-bios". This will place the full
image into ROM (that is FirmwareDevice=3Dmemory, read and exec: permitted=
,
write: denied). This will not provide a spec-compatible UEFI variable
service to the guest, but many people use OVMF like this. The libvirt
domain XML can accommodate this case:

  <loader type=3D'rom'>OVMF.fd</loader>

(2) "OVMF.fd" can be loaded into a single pflash chip (single pflash
drive, read/write). The command line switch is "-drive
if=3Dpflash,format=3Draw,file=3DOVMF.fd,unit=3D0,readonly=3Doff". This gi=
ves the
guest a spec-compliant UEFI variable service; however, the variable
store is inseparable from the firmware binary, and upgrading the latter
without losing the former is not possible, from a packaging perspective.
This maps to FirmwareDevice=3Dflash, with all of
read/write/exec=3Dpermitted. Libvirt can describe this too in the domain =
XML:

  <loader type=3D'pflash' readonly=3D'no'>OVMF.fd</loader>

(3) Now we're coming to the split image, namely OVMF_CODE.fd, and a
*copy of* the OVMF_VARS.fd template. This is mapped with

  -drive if=3Dpflash,format=3Draw,file=3DOVMF_CODE.fd,unit=3D0,readonly=3D=
on \
  -drive if=3Dpflash,format=3Draw,file=3Dvarstore.fd,unit=3D1,readonly=3D=
off

To the guest, it looks like (2), but on the host side, it allows for
centralized firmware binary upgrades, while preserving the domains'
variable stores. This maps to (a) the system firwmare with
FirmwareDevice=3Dflash, read/exec: permitted, and write: denied; and (b)
one nvramslot with FirmwareDevice=3Dflash, and read/exec/write: permitted=
.

The domain XML fragment is

    <loader type=3D'pflash' readonly=3D'yes'>OVMF_CODE.fd</loader>
    <nvram>varstore.fd</nvram>

(4) An extension of (3) is when write accesses to the variable store are
restricted to code that runs in SMM. The QEMU options are:

  -drive if=3Dpflash,format=3Draw,file=3DOVMF_CODE.fd,unit=3D0,readonly=3D=
on \
  -drive if=3Dpflash,format=3Draw,file=3Dvarstore.fd,unit=3D1,readonly=3D=
off \
  -machine <pc-q35-2.4+>,smm=3Don \
  -global driver=3Dcfi.pflash01,property=3Dsecure,value=3Don \

This maps to (a) the system firwmare with FirmwareDevice=3Dflash,
read/exec: permitted, and write: denied; and (b) one nvramslot with
FirmwareDevice=3Dflash, read/exec: permitted, write:
restricted-to-secure-context.

The domain XML fragment is

  <os>
    <type arch=3D'x86_64' machine=3D'pc-q35-2.4+'>hvm</type>
    <loader type=3D'pflash' readonly=3D'yes'
     secure=3D'yes'>OVMF_CODE.fd</loader>
    <nvram>varstore.fd</nvram>
  </os>
  <features>
    <smm state=3D'on'/>
  </features>


On other target arches, "restricted-to-secure-context" may be defined
differently from "x86 SMM"; for example on aarch64, TrustZone / "secure
world" exist, as far as I know. (The edk2 project doesn't have any
upstream core code for supporting that though.) The command line
switches could be quite different.

So, the schema intends to describe the mapping that the firmware expects
from the board. How that is implemented on the QEMU command line is left
as an exercise to ... libvirtd. :)

>=20
>> +
>> +##
>> +# @FirmwareMapping:
>> +#
>> +# Collects the mapping device type and the access permissions to that=
 device
>> +# for system firmware and for NVRAM slots.
>> +#
>> +# @device: The system firmware or the NVRAM slot must reside in a dev=
ice of
>> +#          this type.
>> +#
>> +# @read: Permission for the guest to read the device that maps the fi=
rmware
>> +#        file. If the field is missing, @permitted is assumed.
>> +#
>> +# @write: Permission for the guest to write the device that maps the =
firmware
>> +#         file. If the field is missing, @permitted is assumed.
>> +#
>> +# @execute: Permission for the guest to execute code from the device =
that maps
>> +#           the firmware file. If the field is missing, @permitted is=
 assumed.
>> +#
>> +# Since: 2.13
>> +##
>> +{ 'struct' : 'FirmwareMapping',
>> +  'data'   : { 'device'   : 'FirmwareDevice',
>> +               '*read'    : 'FirmwareAccess',
>> +               '*write'   : 'FirmwareAccess',
>> +               '*execute' : 'FirmwareAccess' } }
>=20
> Again, what this this map to on the command line ?
>=20
>> +##
>> +# @FirmwareFile:
>> +#
>> +# Gathers the common traits of system firmware executables and NVRAM =
templates.
>> +#
>> +# @pathname: absolute pathname of the firmware file on the host files=
ystem
>> +#
>> +# @description: human-readable description of the firmware file
>> +#
>> +# @tags: a list of machine-readable strings providing additional info=
rmation
>=20
> This makes it look like this information is something applications shou=
ld be
> using when setting up firmwares, which is definitely not what we want. =
Lets
> rename this
>=20
>   "@build_options: arbitrary list of firmware specific build options, f=
or
>                    informative purposes only. Applications should not a=
ttempt
>                    to interpret / assign meaning to these options"

Hmmm, I agree with you half-way here. I'm not saying that applications
*should* consult the tags, but they might want let the user express a
search condition for the tags. Near the end of the RFC, there's an
example JSON where the sole nvramslot advertizes two variable store
templates (both of which are compatible with the firmware and the
nvramslot from a technical POV). However, one varstore template is
logically empty, and the other varstore template has the MS certificates
pre-enrolled and Secure Boot enabled. If the new domain is created with
an OS installer that is not signed at all, the choice of varstore
template can make a big difference. And, the way I could distinguish
these two templates from each other (in a machine readable format) is
the "tags" list -- pls. search the RFC for the string '"mscerts"'.

I figured either the apps or the user might want to decide about the
varstore template.

>=20
>> +# @format: If the @FirmwareDevice that this @FirmwareFile is mapped i=
nto is
>> +#          @flash, then @format describes the block format of the dri=
ve that
>> +#          backs the device. Otherwise, this field should be 'raw' or=
 absent.
>> +#          If the field is missing, 'raw' is assumed.
>=20
> Why does the format needed ?
>=20
> If the firmware is to be loaded via a block device driver, then it shou=
ld
> not matter what format is used. If the mgmt app wants to take the firmw=
are
> file and convert it to qcow2 format that's fine - the code loading this
> in QEMU will still see raw content.

The pflash device model has a backing drive, and the block format for
that drive can be qcow2 or raw (or other things), in theory anyway
(libvirt only supports raw now). Block format probing is discouraged, so
if the firmware package (on the host) provides the firmware binary
and/or the variable store template in qcow2 block format, then the tools
should know about that without probing.

Indeed it does not matter to the guest (the block format is a backend
property), but it's a detail that the firmware package should expose to
the host toolstack.

>=20
>> +#
>> +# Since: 2.13
>> +##
>> +{ 'struct' : 'FirmwareFile',
>> +  'data'   : { 'pathname'     : 'str',
>> +               '*description' : 'str',
>> +               '*tags'        : [ 'str' ],
>> +               '*format'      : 'str' } }
>> +
>> +##
>> +# @NVRAMSlot:
>> +#
>> +# Defines the mapping properties of an NVRAM slot, and associates com=
patible
>> +# NVRAM templates with the NVRAM slot.
>> +#
>> +# @slot-id: The numeric identifier of the NVRAM slot. The interpretat=
ion of
>> +#           @slot-id is specific to the target architecture and the c=
hosen
>> +#           system firmware.
>=20
> What does this correspond to at the CLI level ?  Is this the -drive uni=
t=3DNN
> option when loading via a block device ?

Yes, for i440fx and q35 with pflash, such a mapping makes sense. For
other target arches and board types, the mapping could be different (in
Thomas's example a uint64_t slot-id isn't even expressive enough).

Following your earlier advice, I tried to accommodate arches and boards
that I know nothing about :) , so I added the field mainly as a
placeholder, and to tell apart nvramslots. (In fact, nvram-slots,
*plural*, is already speculative generality, because I know of no board
that takes more than one nvram / pflash chip. But, turning that field
into a list wasn't too hard, and it can save us some headache down the
road. In turn I thought it prudent to add a slot-id, just to ensure some
kind of unicity.)

How slot-id is mapped to an actual board is left to libvirtd C code :)

>=20
>> +#
>> +# @nvram-map: the mapping requirements of this NVRAM slot
>> +#
>> +# @templates: A non-empty list of @FirmwareFile elements. Any @Firmwa=
reFile
>> +#             identified by this list as an NVRAM template can be cop=
ied to
>> +#             create an actual NVRAM file, and the NVRAM file can be =
mapped
>> +#             into the NVRAM slot identified by @slot-id, subject to =
the
>> +#             mapping requirements in @nvram-map.
>> +#
>> +# Since: 2.13
>> +##
>> +{ 'struct' : 'NVRAMSlot',
>> +  'data'   : { 'slot-id'   : 'uint64',
>> +               'nvram-map' : 'FirmwareMapping',
>> +               'templates' : [ 'FirmwareFile' ] } }
>> +
>> +##
>> +# @SystemFirmwareType:
>> +#
>> +# Lists system firmware types commonly used with QEMU virtual machine=
s.
>> +#
>> +# @bios: The system firmware was built from the SeaBIOS project.
>> +#
>> +# @slof: The system firmware was built from the Slimline Open Firmwar=
e project.
>> +#
>> +# @uboot: The system firmware was built from the U-Boot project.
>> +#
>> +# @uefi: The system firmware was built from the edk2 (EFI Development=
 Kit II)
>> +#        project.
>> +#
>> +# Since: 2.13
>> +##
>> +{ 'enum' : 'SystemFirmwareType',
>> +  'data' : [ 'bios', 'slof', 'uboot', 'uefi' ] }
>> +
>> +##
>> +# @SystemFirmware:
>> +#
>> +# Describes a system firmware binary and any NVRAM slots that it requ=
ires.
>> +#
>> +# @executable: Identifies the platform firmware executable.
>> +#
>> +# @type: The type by which the system firmware is commonly known. Thi=
s is the
>> +#        main search key by which management software looks up a syst=
em
>> +#        firmware image for a new domain.
>> +#
>> +# @targets: a non-empty list of target architectures that are capable=
 of
>> +#           executing the system firmware
>> +#
>> +# @sysfw-map: the mapping requirements of the system firmware binary
>> +#
>> +# @nvram-slots: A list of NVRAM slots that are required by the system=
 firmware.
>> +#               The @slot-id field must be unique across the list. Im=
portantly,
>> +#               if any @FirmwareAccess is @restricted-to-secure-conte=
xt in
>> +#               @sysfw-map or in any @nvram-map in @nvram-slots, then=
 (a) the
>> +#               virtual machine configuration is required to emulate =
the secure
>> +#               code execution context (as defined for @targets), and=
 (b) the
>> +#               virtual machine configuration is required to actually=
 restrict
>> +#               the access in question to the secure execution contex=
t.
>> +#
>> +# @supports-uefi-secure-boot: Whether the system firmware implements =
the
>> +#                             software interfaces for UEFI Secure Boo=
t, as
>> +#                             defined in the UEFI specification. If t=
he field
>> +#                             is missing, its assumed value is 'false=
'.
>> +#
>> +# @supports-amd-sev: Whether the system firmware supports running und=
er AMD
>> +#                    Secure Encrypted Virtualization, as specified in=
 the AMD64
>> +#                    Architecture Programmer's Manual. If the field i=
s missing,
>> +#                    its assumed value is 'false'.
>> +#
>> +# @supports-acpi-s3: Whether the system firmware supports S3 sleep (s=
uspend to
>> +#                    RAM), as defined in the ACPI specification. If t=
he field
>> +#                    is missing, its assumed value is 'false'.
>> +#
>> +# @supports-acpi-s4: Whether the system firmware supports S4 hibernat=
ion
>> +#                    (suspend to disk), as defined in the ACPI specif=
ication.
>> +#                    If the field is missing, its assumed value is 'f=
alse'.
>=20
> I think these should just be an enum again
>=20
>   "FirmwareFeatures": [ "secure-boot", "amd-sev", "acpi-s3", "acpi-s4" =
]

You mean a list of such enum constants? That makes sense. (I figured
individual fields would be easier to filter for, but I agree that a list
of enum constants is more frugal in the schema.)

>=20
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
>> +#             "CONFIG_ROM_SIZE=3D256"
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
>> +#         "description": "OVMF with Secure Boot and SMM-protected var=
store",
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
>> +#                     "pathname": "/usr/share/OVMF/OVMF_VARS.secboot.=
fd",
>> +#                     "description": "varstore template with the Micr=
osoft certificates enrolled for Secure Boot",
>> +#                     "tags": [
>> +#                         "mscerts"
>> +#                     ]
>=20
> The tags field is arbitrary firmware specific strings with no pre-decla=
red
> meaning. So we need to provide a explicit way to represent features aga=
inst
> this, such that libvirt can determine the secure boot vars file.

Right. So I guess I should keep the "tags" fields (with free-form
strings), but also introduce at least two enum types, one with "system
firmware features" and another with "nvramslot template features". And
then use lists of those.

Any advice on how to separate these enum types? For example, can we
assume that two enum types in total will suffice, because we can lump
the features for all templates of all nvram slots of all boards of all
architectures into a single NVRAMSlotTemplateFeature enum type?

>=20
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
>> +#         "pathname": "/usr/share/edk2.git/ovmf-ia32/OVMF_CODE-pure-e=
fi.fd",
>> +#         "description": "32-bit OVMF with unprotected varstore and n=
o Secure Boot",
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
>> +#                     "pathname": "/usr/share/edk2.git/ovmf-ia32/OVMF=
_VARS-pure-efi.fd",
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
>> +# Accept a @SystemFirmware object and do nothing, successfully. This =
command
>> +# can be used in the QMP shell to validate @SystemFirmware JSON again=
st the
>> +# schema, and to pretty print it.
>> +#
>> +# @sysfw: ignored
>> +#
>> +# Since: 2.13
>> +##
>> +{ 'command' : 'x-check-firmware',
>> +  'data'    : { 'sysfw' : 'SystemFirmware' } }
>=20
> The "json_reformat" command line tool can be used for reformatting

Awesome, thanks for the tip!

> I wonder if we could usefully provide a command line tool for qemu to
> validate against qapi schemas ? eg something like
>=20
>    qemu-qapi-validate --type=3DSystemFirmware /path/to/schema /path/to/=
document

That would be a useful tool; I'd use it if it existed :)

If I must, I can tack it to my todo list. It wouldn't be my preference
right now.

Thanks
Laszlo
