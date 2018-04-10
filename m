Received: from eggs.gnu.org ([2001:4830:134:3::10]:57876)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1f5nxI-0001Lv-PY
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 03:44:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1f5nxH-0003eu-Kj
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 03:44:40 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:42182 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1f5nxH-0003eN-Dq
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 03:44:39 -0400
References: <20180407000117.25640-1-lersek@redhat.com>
	<bf5fc85b-0695-3bd0-117d-759d5dbd4546@redhat.com>
	<6bfdae78-909f-e7ad-b0f0-25f76dfd81f7@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <55471447-cabe-17ff-e4ef-95d31b8625e3@redhat.com>
Date: Tue, 10 Apr 2018 09:44:33 +0200
MIME-Version: 1.0
In-Reply-To: <6bfdae78-909f-e7ad-b0f0-25f76dfd81f7@redhat.com>
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
To: Laszlo Ersek <lersek@redhat.com>, qemu-devel@nongnu.org, libvir-list@redhat.com
Cc: "Daniel P. Berrange" <berrange@redhat.com>, Alexander Graf <agraf@suse.de>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, David Gibson <dgibson@redhat.com>, Eric Blake <eblake@redhat.com>, Gary Ching-Pang Lin <glin@suse.com>, Gerd Hoffmann <kraxel@redhat.com>, Kashyap Chamarthy <kchamart@redhat.com>, Markus Armbruster <armbru@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, Michal Privoznik <mprivozn@redhat.com>, Peter Krempa <pkrempa@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, David Gibson <david@gibson.dropbear.id.au>, Laurent Vivier <lvivier@redhat.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

On 09.04.2018 18:34, Laszlo Ersek wrote:
> On 04/09/18 09:26, Thomas Huth wrote:
>>  Hi Laszlo,
>>
>> On 07.04.2018 02:01, Laszlo Ersek wrote:
>>> Add a schema that describes the properties of virtual machine firmwar=
e.
>>>
>>> Each firmware executable installed on a host system should come with =
a
>>> JSON file that conforms to this schema, and informs the management
>>> applications about the firmware's properties.
>>>
>>> In addition, a configuration directory with symlinks to the JSON file=
s
>>> should exist, with the symlinks carefully named to reflect a priority
>>> order. Management applications can then search this directory in prio=
rity
>>> order for the first firmware executable that satisfies their search
>>> criteria. The found JSON file provides the management layer with doma=
in
>>> configuration bits that are required to run the firmware binary.
>> [...]
>>> +##
>>> +# @FirmwareDevice:
>>> +#
>>> +# Defines the device types that a firmware file can be mapped into.
>>> +#
>>> +# @memory: The firmware file is to be mapped into memory.
>>> +#
>>> +# @kernel: The firmware file is to be loaded like a Linux kernel. Th=
is is
>>> +#          similar to @memory but may imply additional processing th=
at is
>>> +#          specific to the target architecture.
>>> +#
>>> +# @flash: The firmware file is to be mapped into a pflash chip.
>>> +#
>>> +# Since: 2.13
>>> +##
>>> +{ 'enum' : 'FirmwareDevice',
>>> +  'data' : [ 'memory', 'kernel', 'flash' ] }
>>
>> This is not fully clear to me... what is this exactly good for? Is thi=
s
>> a way to say how the firmware should be loaded, i.e. via "-bios",
>> "-kernel" or "-pflash" parameter? If so, the term "memory" is quite
>> misleading since files that are loaded via -bios can also end up in an
>> emulated ROM chip.
>=20
> I threw in "-kernel" because, although it also (usually?) means
> "memory", I expected people would want it separate.
>=20
> Regarding memory vs. pflash, I thought that these two, combined with th=
e
> access permissions, could cover all of RAM, ROM, and read-only and
> read-write pflash too.
>=20
> So, "-bios" (-> ROM) boils down to "memory", with write access denied -=
-
> please see the SeaBIOS example near the end.

Let me ask the other way round: How does a high-level tool know whether
it should use "-bios", "-kernel", "-pflash", "-device generic-loader" or
"-younameit" for loading the firmware?

>>> +               'nvram-map' : 'FirmwareMapping',
>>> +               'templates' : [ 'FirmwareFile' ] } }
>>> +
>>> +##
>>> +# @SystemFirmwareType:
>>> +#
>>> +# Lists system firmware types commonly used with QEMU virtual machin=
es.
>>> +#
>>> +# @bios: The system firmware was built from the SeaBIOS project.
>>> +#
>>> +# @slof: The system firmware was built from the Slimline Open Firmwa=
re project.
>>> +#
>>> +# @uboot: The system firmware was built from the U-Boot project.
>>> +#
>>> +# @uefi: The system firmware was built from the edk2 (EFI Developmen=
t Kit II)
>>> +#        project.
>>> +#
>>> +# Since: 2.13
>>> +##
>>> +{ 'enum' : 'SystemFirmwareType',
>>> +  'data' : [ 'bios', 'slof', 'uboot', 'uefi' ] }
>>
>> The naming here is quite a bad mixture between firmware interface
>> ('bios', 'uefi') and firmware implementations ('slof', 'uboot'). There
>> could be other implementations of BIOS or UEFI than SeaBIOS and EDK2 .=
..
>> so I'd suggest to rather name them 'seabios' and 'edk2' here instead.
>=20
> Sure, I'm totally ready to follow community advice here (too).
>=20
> In fact this is the one element I dislike the most about the schema --
> it's the fuzziest part, yet it is the most important element for
> libvirt. Because users and higher level apps just want to say "give me
> UEFI". If I have to ask "OK, but UEFI built from edk2 or something
> else?", then it's a lost cause already.
>=20
> It's hard to find the right level of abstraction in the naming when the
> higher level tools (and/or ultimately the users) don't know enough to
> ask for specifics -- I'm not saying that's bad; it's quite natural, but
> makes things very difficult. So this enum aims to match the user story
> "gimme UEFI and be done with it". I figure users will just utter the
> most common buzzword form of the concept they have in mind. "edk2"
> doesn't tell them as much as "uefi".

OK, I see your point. But I still think we should not design fuzzy
interfaces here at this low level, this will only lead to other trouble
later. ... thinking about this again, users seem to mix up firmware
interfaces / families with concrete implementations. So maybe we need
something like:

 { 'enum' : 'SystemFirmwareType',
   'data' : [ 'seabios', 'slof', 'uboot', 'edk2', 'openbios' ] }

*and* :

 { 'enum' : 'SystemFirmwareInterface',  /* or: 'SystemFirmwareFamily' */
   'data' : [ 'bios', 'uefi', 'openfirmware' ] }

Then a high level tool can check both and pick the best match?

 Thomas
