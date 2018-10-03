Received: from eggs.gnu.org ([2001:4830:134:3::10]:55575)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1g7UxG-0006BU-US
	for qemu-devel@nongnu.org; Tue, 02 Oct 2018 20:23:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1g7UxD-0003Lo-H3
	for qemu-devel@nongnu.org; Tue, 02 Oct 2018 20:23:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54994)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <crosa@redhat.com>) id 1g7UxD-0003K5-3v
	for qemu-devel@nongnu.org; Tue, 02 Oct 2018 20:23:51 -0400
References: <20180928003058.12786-1-philmd@redhat.com>
	<61123eb6-4263-4847-cb43-8160c99adb45@redhat.com>
From: Cleber Rosa <crosa@redhat.com>
Message-ID: <3a670f0b-069e-5713-da7a-dea46959ff8d@redhat.com>
Date: Tue, 2 Oct 2018 20:23:42 -0400
MIME-Version: 1.0
In-Reply-To: <61123eb6-4263-4847-cb43-8160c99adb45@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH 0/3] acceptance tests: Test firmware
 checking debug console output
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laszlo Ersek <lersek@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>, Caio Carrara <ccarrara@redhat.com>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Kashyap Chamarthy <kchamart@redhat.com>



On 9/28/18 6:51 AM, Laszlo Ersek wrote:
> Hi Phil,
>=20
> (+Daniel, +Kashyap)
>=20
> On 09/28/18 02:30, Philippe Mathieu-Daud=C3=A9 wrote:
>> Hi,
>>
>> This RFC series add simple acceptance tests which boot SeaBIOS and
>> EDK2 on Q35 and virt/aarch64.
>>
>> It is more of a proof of concept (to motivate the Avocado team ;) ).
>>
>> Regards,
>>
>> Phil.
>>
>> Philippe Mathieu-Daud=C3=A9 (3):
>>   acceptance tests: Add SeaBIOS boot and debug console checking test
>>   acceptance tests: Add EDK2 OVMF boot and debug console checking test
>>   acceptance tests: Add EDK2 AAVMF boot and console checking test
>>
>>  tests/acceptance/boot_firmware.py | 167 +++++++++++++++++++++++++++++=
+
>>  1 file changed, 167 insertions(+)
>>  create mode 100644 tests/acceptance/boot_firmware.py
>>
>=20
> I'm not experienced with Avocado, so I'm basically reading the patches
> as a "story". My comments are made at that level too. :)
>=20
> * In the blurb, you say "Q35". But the first two patches have
>=20
>   vm.set_machine('pc')
>=20
> * Please don't call the edk2 ArmVirtQemu platform AAVMF in upstream
>   patches :) Call it ArmVirtQemu pls.
>=20
> * Finding the right way to launch  OVMF and/or ArmVirtQemu firmware
>   images is complicated. (The right way is definitely not "-bios"!)
>=20
>   The general idea is that you need three files (and two pflash chips);
>   (a) a firmware executable mapped read-only, and (b) a variable store
>   file, mapped read-write, that was first copied from (c) a read-only
>   variable store *template* that is never itself mapped. And, this is
>   not the whole story.
>=20
>   Figuring out the options is complicated enough (for management tools
>   as well) that Daniel made us define a metadata schema for describing
>   firmware packages. Please see:
>=20
>   docs/interop/firmware.json
>=20
>   I'm not necessarily suggesting that Avocado be able to parse the
>   firmware descriptor metafiles that conform to this schema. I'm just
>   pointing out that the QEMU command line will depend on the exact buil=
d
>   of the firmware image under test. The pathname
>   "/usr/share/OVMF/OVMF_CODE.fd" and the URL
>   "https://snapshots.linaro.org/.../QEMU_EFI.img.gz" don't give us
>   enough information.
>=20
>   Therefore, if we want to keep the test case simple (=3D hard-wire the
>   command lines), then we'll have to refer to OVMF and ArmVirtQemu
>   images with precisely known build configs.
>=20
> * Looking for debug console messages as "vital signs" is brittle. For
>   example, the line "DetectSmbiosVersion: SMBIOS version from QEMU:
>   0x0208" will change if QEMU changes the SMBIOS version number in the
>   SMBIOS anchor that it generates. It's likely better to make the
>   firmware "do" something.
>=20
>   The simplest I can imagine is: prepare a virtual disk with a
>   "startup.nsh" UEFI shell script on it. The script can print a known
>   fixed string, and then power down the VM. (See the UEFI Shell
>   Specification for commands; <http://uefi.org/specifications>.)
>=20
>   I'm not sure if Avocado provides disk image preparation utilities, bu=
t
>   perhaps (a) we could use the vvfat driver (*shudder*) or (b) we could
>   preformat a small image, and track it as a binary file in git.
>=20

So far we've added support for generating ISO images (with pure Python).
 I'm not sure if that's useful here.  We can think about trying to add
the same thing for vvfat.

- Cleber.
