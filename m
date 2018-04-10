Received: from eggs.gnu.org ([2001:4830:134:3::10]:40825)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1f5qOX-0003eS-3p
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 06:20:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1f5qOT-0003F4-2r
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 06:20:57 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:49180 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1f5qOS-0003Eg-T2
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 06:20:53 -0400
Date: Tue, 10 Apr 2018 11:20:33 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180410102033.GL5155@redhat.com>
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

> diff --git a/qapi/firmware.json b/qapi/firmware.json
> new file mode 100644
> index 000000000000..f267240f44dd
> --- /dev/null
> +++ b/qapi/firmware.json

[snip]

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

Elsewhere in the thread I mentioned that I think we should try to use a
union approach to isolate which information is relevant to "flash" loader
format and which is relevant to "memory" and "kernel". To try to illustrate
what I mean by that I've knocked up an alternative structure. I also
incorporated the points about features & target/machine types.  I've left
out the read/write/etc fields, but they could be put back in at the
relevant position


{ 'enum' : 'SystemFirmwareType',
  'data' : [ 'bios', 'slof', 'uboot', 'uefi' ] }

{ 'enum' : 'SystemFirmwareDevice',
  'data' : [ 'memory', 'kernel', 'flash' ] }

{ 'enum' : 'SystemFirmwareArchitecture',
  'data':  ['x86_64', 'i386', ..etc.. ] }
  
{ 'enum' : 'SystemFirmwareFeature',
  'data': ['acpi-s3', 'acpi-s5', 'secure-boot', 'amd-sev' ]}


## Struct(s) for device==memory

{ 'struct': 'SystemFirmwareBinaryMemory',
  'data': { 'pathname': 'str' } }


## Struct(s) for device==kernel

{ 'struct': 'SystemFirmwareBinaryKernel',
  'data': { 'pathname': 'str' } }


## Struct(s) for device==flash

{ 'struct': 'SystemFirmwareBinaryFlashFile',
  'data':  { 'filename': 'str',
             'format': 'BlockdevDriver' } }

{ 'struct': 'SystemFirmwareBinaryFlashCode',
  'base': 'SystemFirmwareBinaryFlashFile' }

{ 'struct': 'SystemFirmwareBinaryFlashVars',
  'base': 'SystemFirmwareBinaryFlashFile',
  'data': { 'secure-boot-key-enroll': 'bool' } }

{ 'struct': 'SystemFirmwareBinaryFlash',
  'data': { 'code': 'SystemFirmwareBinaryFlashCode',
            'vars': ['SystemFirmwareBinaryFlashVars' ] } }


## Discriminated struct for different loading approaches

{ 'union': 'SystemFirmwareBinary',
  'base': { 'device': 'SystemFirmwareDevice' },
  'discriminator': 'device',
  'data': { 'memory': 'SystemFirmwareBinaryMemory',
            'kernel': 'SystemFirmwareBinaryKernel',
            'flash': 'SystemFirmwareBinaryFlash' } }



{ 'struct' : 'SystemFirmwareTarget',
  'data': { 'architecture': 'SystemFirmwareArchitecture',
            'machines': [ 'str' ] } }


{ 'struct' : 'SystemFirmware',
  'data'   : {
      'description'  : 'str',
      'type'         : 'SystemFirmwareType',
      'binary'       : 'SystemFirmwareBinary',
      'targets'      : [ 'SystemFirmwareTarget' ],
      'features'     : ['SystemFirmwareFeature'] } } 



# Examples:
#
# {
#    'description': 'SeaBIOS 256k',
#    'type': 'bios',
#    'binary': {
#        'type': 'memory',
#        'filename': '/path/to/seabios/rom-256k',
#    }
#    'targets':  {
#        'x86_64': [ "pc", "q35"],
#        'i386': [ "pc", "q35"],
#    }
#    'features': ['acpi-s3', 'acpi-s5'],
# }
# {
#    'description': 'SeaBIOS 128k',
#    'type': 'bios',
#    'binary': {
#        'type': 'memory',
#        'filename': '/path/to/seabios/rom-128k',
#    }
#    'targets':  {
#        'x86_64': [ "isapc"],
#        'i386': [ "isapc"],
#    }
#    'features': [],
# }
# {
#    'description': 'OVMF',
#    'type': 'uefi'
#    'binary': {
#        'type': 'flash',
#        'code': {
#          'filename': '/usr/share/OVMF/OVMF_CODE.secboot.fd',
#          'format': 'raw',
#        },
#        'vars': [
#           {
#              'filename': '/usr/share/OVMF/OVMF_VARS.fd',
#              'format': 'raw',
#              'secure=boot-key-enroll': false,
#           },
#           {
#              'filename': '/usr/share/OVMF/OVMF_VARS.secboot.fd',
#              'format': 'raw',
#              'secure=boot-key-enroll': true,
#           }
#        ],
#    },
#    'targets':  {
#        'x86_64': [ "q35"],
#    }
#    'features': ['acpi-s3', 'acpi-s5', 'secure-boot'],
# }
#


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
