Received: from eggs.gnu.org ([2001:4830:134:3::10]:49662)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1f8mOb-000834-SB
	for qemu-devel@nongnu.org; Wed, 18 Apr 2018 08:41:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1f8mOX-0000Nt-0A
	for qemu-devel@nongnu.org; Wed, 18 Apr 2018 08:41:09 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:35208 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1f8mOW-0000Mk-RC
	for qemu-devel@nongnu.org; Wed, 18 Apr 2018 08:41:04 -0400
References: <20180417224054.26363-1-lersek@redhat.com>
	<c5e3f942-2c0e-9809-32ae-df97eaf2b7cd@redhat.com>
	<762b3dc8-a86f-a21f-1e21-334ec46677ef@redhat.com>
	<20180418120320.GH27579@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <f16c1406-78ac-d275-63e9-90de3beac9f0@redhat.com>
Date: Wed, 18 Apr 2018 14:40:55 +0200
MIME-Version: 1.0
In-Reply-To: <20180418120320.GH27579@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [qemu RFC v2] qapi: add "firmware.json"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "=?UTF-8?Q?Daniel_P._Berrang=c3=a9?=" <berrange@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org, libvir-list@redhat.com, Alexander Graf <agraf@suse.de>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, David Gibson <dgibson@redhat.com>, Eric Blake <eblake@redhat.com>, Gary Ching-Pang Lin <glin@suse.com>, Gerd Hoffmann <kraxel@redhat.com>, Kashyap Chamarthy <kchamart@redhat.com>, Markus Armbruster <armbru@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, Michal Privoznik <mprivozn@redhat.com>, Peter Krempa <pkrempa@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>

On 04/18/18 14:03, Daniel P. Berrang=C3=A9 wrote:
> On Wed, Apr 18, 2018 at 01:52:19PM +0200, Laszlo Ersek wrote:
>> On 04/18/18 11:43, Paolo Bonzini wrote:
>>> On 18/04/2018 00:40, Laszlo Ersek wrote:
>>>> +#
>>>> +# Lists firmware types commonly used with QEMU virtual machines.
>>>> +#
>>>> +# @bios: The firmware was built from the SeaBIOS project.
>>>> +#
>>>> +# @slof: The firmware was built from the Slimline Open Firmware pro=
ject.
>>>> +#
>>>> +# @uboot: The firmware was built from the U-Boot project.
>>>> +#
>>>> +# @uefi: The firmware was built from the edk2 (EFI Development Kit =
II) project.
>>>> +#
>>>> +# Since: 2.13
>>>> +##
>>>> +{ 'enum' : 'FirmwareType',
>>>> +  'data' : [ 'bios', 'slof', 'uboot', 'uefi' ] }
>>>
>>> A very basic question (so not likely a suggestion for change).  Why
>>> wouldn't these be features too?  For example a UEFI with CSM could
>>> expose both uefi and bios, a u-boot with UEFI support could expose bo=
th
>>> uboot and uefi, etc.
>>
>> Good point. I considered "type" to be a given, from the initial
>> brainstorming, but if Dan is OK with your suggestion, I can turn these
>> into features as well.
>>
>>> Perhaps there are two dimensions, the FirmwareType tells you how to
>>> configure it and the FirmwareFeature tells you the APIs it exposes to
>>> the guest?
>>
>> I don't know enough firmware types to answer this :) I believe I agree
>> about the FirmwareFeature statement (if we also include "platform
>> requirements" there), but I have no clue about any generalizations for
>> firmware configuration.
>=20
> IIUC Paolo is basically suggesting
>=20
>    {
>        "description": "OVMF firmware"
>        "type": "uefi",
>        "features": [
>           "uefi",
> 	  "bios"
>        ],
>    }
>=20
> where 'bios' is only listed if CSM is enabled in the OVMF build. I tend
> to think that is redundant and we could just do
>=20
>=20
>    {
>        "description": "OVMF firmware"
>        "features": [
>           "uefi",
> 	  "bios"
>        ],
>    }

Actually, this is how I interpreted Paolo's idea at once. I agree the
"type" member can be dropped.

>=20
> And declare the order of "features" list is significant. ie
>=20
>        "features": [
>           "uefi",
> 	  "bios"
>        ],
>=20
>=20
> means a UEFI firmware which has back compat for BIOS (ie OVMF with CSM)
> while
>=20
>        "features": [
> 	  "bios"
>           "uefi",
>        ],
>=20
> means a traditional BIOS firmware with compat for UEFI (thinking uboot
> being able to include uefi support in this case)

Is it guaranteed that lists in JSON keep the order of the elements?
Because, dictionaries definitely don't promise any ordering between the
keys.

Thanks,
Laszlo
