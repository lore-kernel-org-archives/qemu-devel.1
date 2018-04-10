Received: from eggs.gnu.org ([2001:4830:134:3::10]:55121)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1f5s9D-0004on-V3
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 08:13:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1f5s98-0006Zo-Sj
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 08:13:15 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:50878 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1f5s98-0006ZU-Nc
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 08:13:10 -0400
References: <20180407000117.25640-1-lersek@redhat.com>
	<20180410102033.GL5155@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <e91a7d90-7f15-d72e-f5dc-04925c9890dc@redhat.com>
Date: Tue, 10 Apr 2018 14:12:54 +0200
MIME-Version: 1.0
In-Reply-To: <20180410102033.GL5155@redhat.com>
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

On 04/10/18 12:20, Daniel P. Berrang=C3=A9 wrote:
> On Sat, Apr 07, 2018 at 02:01:17AM +0200, Laszlo Ersek wrote:

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

I think this looks very nice; with the addition of

- "requires-smm" to "SystemFirmwareFeature":

> { 'enum' : 'SystemFirmwareFeature',
>   'data': ['acpi-s3', 'acpi-s5', 'secure-boot', 'amd-sev' ]}

- and another feature flag (perhaps in SystemFirmwareFeature, perhaps in
SystemFirmwareBinaryFlashVars) for the cmdline option "-global
driver=3Dcfi.pflash01,property=3Dsecure,value=3Don",

this could be called a day as far as SeaBIOS and OVMF are concerned.

Thanks
Laszlo
