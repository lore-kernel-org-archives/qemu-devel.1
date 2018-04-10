Received: from eggs.gnu.org ([2001:4830:134:3::10]:40427)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1f5r4S-0001Gr-5K
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 07:04:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1f5r4L-0003Od-VE
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 07:04:16 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:59918 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1f5r4L-0003OI-Pb
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 07:04:09 -0400
Date: Tue, 10 Apr 2018 12:03:57 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180410110357.GP5155@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20180407000117.25640-1-lersek@redhat.com>
	<20180410102033.GL5155@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180410102033.GL5155@redhat.com>
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
To: Laszlo Ersek <lersek@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, Peter Krempa <pkrempa@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, libvir-list@redhat.com, Markus Armbruster <armbru@redhat.com>, Kashyap Chamarthy <kchamart@redhat.com>, qemu-devel@nongnu.org, Alexander Graf <agraf@suse.de>, Gary Ching-Pang Lin <glin@suse.com>, Gerd Hoffmann <kraxel@redhat.com>, Michal Privoznik <mprivozn@redhat.com>, David Gibson <dgibson@redhat.com>

On Tue, Apr 10, 2018 at 11:20:33AM +0100, Daniel P. Berrang=C3=A9 wrote:
> On Sat, Apr 07, 2018 at 02:01:17AM +0200, Laszlo Ersek wrote:
> > Add a schema that describes the properties of virtual machine firmwar=
e.
> >=20
> > Each firmware executable installed on a host system should come with =
a
> > JSON file that conforms to this schema, and informs the management
> > applications about the firmware's properties.
> >=20
> > In addition, a configuration directory with symlinks to the JSON file=
s
> > should exist, with the symlinks carefully named to reflect a priority
> > order. Management applications can then search this directory in prio=
rity
> > order for the first firmware executable that satisfies their search
> > criteria. The found JSON file provides the management layer with doma=
in
> > configuration bits that are required to run the firmware binary.
> >=20
>=20
> > diff --git a/qapi/firmware.json b/qapi/firmware.json
> > new file mode 100644
> > index 000000000000..f267240f44dd
> > --- /dev/null
> > +++ b/qapi/firmware.json
>=20
> [snip]
>=20
> > +{ 'struct' : 'SystemFirmware',
> > +  'data'   : { 'executable'                 : 'FirmwareFile',
> > +               'type'                       : 'SystemFirmwareType',
> > +               'targets'                    : [ 'str' ],
> > +               'sysfw-map'                  : 'FirmwareMapping',
> > +               '*nvram-slots'               : [ 'NVRAMSlot' ],
> > +               '*supports-uefi-secure-boot' : 'bool',
> > +               '*supports-amd-sev'          : 'bool',
> > +               '*supports-acpi-s3'          : 'bool',
> > +               '*supports-acpi-s4'          : 'bool' } }
>=20
> Elsewhere in the thread I mentioned that I think we should try to use a
> union approach to isolate which information is relevant to "flash" load=
er
> format and which is relevant to "memory" and "kernel". To try to illust=
rate
> what I mean by that I've knocked up an alternative structure. I also
> incorporated the points about features & target/machine types.  I've le=
ft
> out the read/write/etc fields, but they could be put back in at the
> relevant position
>=20
>=20
> { 'enum' : 'SystemFirmwareType',
>   'data' : [ 'bios', 'slof', 'uboot', 'uefi' ] }
>=20
> { 'enum' : 'SystemFirmwareDevice',
>   'data' : [ 'memory', 'kernel', 'flash' ] }
>=20
> { 'enum' : 'SystemFirmwareArchitecture',
>   'data':  ['x86_64', 'i386', ..etc.. ] }
>  =20
> { 'enum' : 'SystemFirmwareFeature',
>   'data': ['acpi-s3', 'acpi-s5', 'secure-boot', 'amd-sev' ]}
>=20
>=20
> ## Struct(s) for device=3D=3Dmemory
>=20
> { 'struct': 'SystemFirmwareBinaryMemory',
>   'data': { 'pathname': 'str' } }
>=20
>=20
> ## Struct(s) for device=3D=3Dkernel
>=20
> { 'struct': 'SystemFirmwareBinaryKernel',
>   'data': { 'pathname': 'str' } }
>=20
>=20
> ## Struct(s) for device=3D=3Dflash
>=20
> { 'struct': 'SystemFirmwareBinaryFlashFile',
>   'data':  { 'filename': 'str',
>              'format': 'BlockdevDriver' } }
>=20
> { 'struct': 'SystemFirmwareBinaryFlashCode',
>   'base': 'SystemFirmwareBinaryFlashFile' }
>=20
> { 'struct': 'SystemFirmwareBinaryFlashVars',
>   'base': 'SystemFirmwareBinaryFlashFile',
>   'data': { 'secure-boot-key-enroll': 'bool' } }
>=20
> { 'struct': 'SystemFirmwareBinaryFlash',
>   'data': { 'code': 'SystemFirmwareBinaryFlashCode',
>             'vars': ['SystemFirmwareBinaryFlashVars' ] } }
>=20
>=20
> ## Discriminated struct for different loading approaches
>=20
> { 'union': 'SystemFirmwareBinary',
>   'base': { 'device': 'SystemFirmwareDevice' },
>   'discriminator': 'device',
>   'data': { 'memory': 'SystemFirmwareBinaryMemory',
>             'kernel': 'SystemFirmwareBinaryKernel',
>             'flash': 'SystemFirmwareBinaryFlash' } }
>=20
>=20
>=20
> { 'struct' : 'SystemFirmwareTarget',
>   'data': { 'architecture': 'SystemFirmwareArchitecture',
>             'machines': [ 'str' ] } }
>=20
>=20
> { 'struct' : 'SystemFirmware',
>   'data'   : {
>       'description'  : 'str',
>       'type'         : 'SystemFirmwareType',
>       'binary'       : 'SystemFirmwareBinary',
>       'targets'      : [ 'SystemFirmwareTarget' ],
>       'features'     : ['SystemFirmwareFeature'] } }=20
>=20
>=20
>=20
> # Examples:
> #
> # {
> #    'description': 'SeaBIOS 256k',
> #    'type': 'bios',
> #    'binary': {
> #        'type': 'memory',
> #        'filename': '/path/to/seabios/rom-256k',
> #    }
> #    'targets':  {
> #        'x86_64': [ "pc", "q35"],
> #        'i386': [ "pc", "q35"],
> #    }
> #    'features': ['acpi-s3', 'acpi-s5'],
> # }
> # {
> #    'description': 'SeaBIOS 128k',
> #    'type': 'bios',
> #    'binary': {
> #        'type': 'memory',
> #        'filename': '/path/to/seabios/rom-128k',
> #    }
> #    'targets':  {
> #        'x86_64': [ "isapc"],
> #        'i386': [ "isapc"],
> #    }
> #    'features': [],
> # }
> # {
> #    'description': 'OVMF',
> #    'type': 'uefi'
> #    'binary': {
> #        'type': 'flash',
> #        'code': {
> #          'filename': '/usr/share/OVMF/OVMF_CODE.secboot.fd',
> #          'format': 'raw',
> #        },
> #        'vars': [
> #           {
> #              'filename': '/usr/share/OVMF/OVMF_VARS.fd',
> #              'format': 'raw',
> #              'secure=3Dboot-key-enroll': false,
> #           },
> #           {
> #              'filename': '/usr/share/OVMF/OVMF_VARS.secboot.fd',
> #              'format': 'raw',
> #              'secure=3Dboot-key-enroll': true,
> #           }

It occurs to me that we are actually over-thinking things, by making it
possible to list a choice of vars files per firmware. We could remove thi=
s
special case by just having separate tpo level firmware entries and a mai=
n
feature flag to say if it is enrolled or not - see below example

> #        ],
> #    },
> #    'targets':  {
> #        'x86_64': [ "q35"],
> #    }
> #    'features': ['acpi-s3', 'acpi-s5', 'secure-boot'],
> # }
> #


{
   'description': 'OVMF secboot',
   'type': 'uefi'
   'binary': {
       'type': 'flash',
       'code': {
         'filename': '/usr/share/OVMF/OVMF_CODE.secboot.fd',
         'format': 'raw',
       },
       'vars': {
         'filename': '/usr/share/OVMF/OVMF_VARS.fd',
         'format': 'raw',
       },
   },
   'targets':  {
       'x86_64': [ "q35"],
   }
   'features': ['acpi-s3', 'acpi-s5', 'secure-boot'],
}

{
   'description': 'OVMF secboot enrolled',
   'type': 'uefi'
   'binary': {
       'type': 'flash',
       'code': {
         'filename': '/usr/share/OVMF/OVMF_CODE.secboot.fd',
         'format': 'raw',
       },
       'vars': {
         'filename': '/usr/share/OVMF/OVMF_VARS.secboot.fd',
         'format': 'raw',
       }
   },
   'targets':  {
       'x86_64': [ "q35"],
   }
   'features': ['acpi-s3', 'acpi-s5', 'secure-boot', "secure-boot-enrolle=
d-keys"],
}

Avoiding recording the notion of secureboot enrollment against the VARs
files, means that you have more flexibility. One could just have a single
file containing both CODE+VARS, which is enrolled instead of separating
them.


Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
