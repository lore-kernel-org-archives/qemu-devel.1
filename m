Received: from eggs.gnu.org ([209.51.188.92]:59403)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1glePb-0003RD-W0
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 13:35:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1glePa-0001oO-Sm
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 13:35:07 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55440)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1glePa-0001ld-Io
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 13:35:06 -0500
References: <20190118223400.24311-1-lersek@redhat.com>
	<20190118223400.24311-3-lersek@redhat.com>
	<63cb176b-64ba-6938-2a95-464f60883281@redhat.com>
	<4f92eff3-29cd-25e4-6bc2-cd0e067d5132@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <685378ac-dac8-62d4-c4c9-b31f6424780c@redhat.com>
Date: Mon, 21 Jan 2019 19:34:49 +0100
MIME-Version: 1.0
In-Reply-To: <4f92eff3-29cd-25e4-6bc2-cd0e067d5132@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 2/5] roms: build the EfiRom utility from
 the roms/edk2 submodule
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu devel list <qemu-devel@nongnu.org>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Igor Mammedov <imammedo@redhat.com>, Shannon Zhao <shannon.zhaosl@gmail.com>

On 01/21/19 12:37, Philippe Mathieu-Daud=C3=A9 wrote:
> On 1/21/19 12:27 PM, Philippe Mathieu-Daud=C3=A9 wrote:
>> Hi Laszlo,
>>
>> On 1/18/19 11:33 PM, Laszlo Ersek wrote:
>>> Building the EfiRom utility from "roms/edk2/BaseTools" should make
>>> "roms/Makefile" more self-contained. Otherwise, we'd call the system-=
wide
>>> EfiRom for building the combined iPXE option ROMs, but call the sibli=
ng
>>> utilities from "roms/edk2/BaseTools" for building "roms/edk2" content=
.
>>>
>>> Cc: "Michael S. Tsirkin" <mst@redhat.com>
>>> Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
>>> Cc: Gerd Hoffmann <kraxel@redhat.com>
>>> Cc: Igor Mammedov <imammedo@redhat.com>
>>> Cc: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>>> Cc: Shannon Zhao <shannon.zhaosl@gmail.com>
>>> Signed-off-by: Laszlo Ersek <lersek@redhat.com>
>>> ---
>>>  roms/Makefile | 13 ++++++-------
>>>  1 file changed, 6 insertions(+), 7 deletions(-)
>>>
>>> diff --git a/roms/Makefile b/roms/Makefile
>>> index a6043eff37e9..78d5dd18c301 100644
>>> --- a/roms/Makefile
>>> +++ b/roms/Makefile
>>> @@ -47,10 +47,7 @@ SEABIOS_EXTRAVERSION=3D"-prebuilt.qemu.org"
>>>  # We need that to combine multiple images (legacy bios,
>>>  # efi ia32, efi x64) into a single rom binary.
>>>  #
>>> -# We try to find it in the path.  You can also pass the location on
>>> -# the command line, i.e. "make EFIROM=3D/path/to/EfiRom efirom"
>>> -#
>>> -EFIROM ?=3D $(shell which EfiRom 2>/dev/null)
>>> +EFIROM =3D edk2/BaseTools/Source/C/bin/EfiRom
>>> =20
>>>  default:
>>>  	@echo "nothing is build by default"
>>> @@ -59,8 +56,7 @@ default:
>>>  	@echo "  vgabios        -- update vgabios binaries (seabios)"
>>>  	@echo "  sgabios        -- update sgabios binaries"
>>>  	@echo "  pxerom         -- update nic roms (bios only)"
>>> -	@echo "  efirom         -- update nic roms (bios+efi, this needs"
>>> -	@echo "                    the EfiRom utility from edk2 / tianocore=
)"
>>> +	@echo "  efirom         -- update nic roms (bios+efi)"
>>>  	@echo "  slof           -- update slof.bin"
>>>  	@echo "  skiboot        -- update skiboot.lid"
>>>  	@echo "  u-boot.e500    -- update u-boot.e500"
>>> @@ -106,7 +102,7 @@ pxe-rom-%: build-pxe-roms
>>> =20
>>>  efirom: $(patsubst %,efi-rom-%,$(pxerom_variants))
>>> =20
>>> -efi-rom-%: build-pxe-roms build-efi-roms
>>> +efi-rom-%: build-pxe-roms build-efi-roms $(EFIROM)
>>>  	$(EFIROM) -f "0x$(VID)" -i "0x$(DID)" -l 0x02 \
>>>  		-b ipxe/src/bin/$(VID)$(DID).rom \
>>>  		-ec ipxe/src/bin-i386-efi/$(VID)$(DID).efidrv \
>>> @@ -124,6 +120,8 @@ build-efi-roms: build-pxe-roms
>>>  		$(patsubst %,bin-i386-efi/%.efidrv,$(pxerom_targets)) \
>>>  		$(patsubst %,bin-x86_64-efi/%.efidrv,$(pxerom_targets))
>>> =20
>>> +$(EFIROM):
>>> +	$(MAKE) -C edk2/BaseTools
>>
>> Since this is a single tool/file, can we simply use:
>>
>>         $(MAKE) -C edk2/BaseTools/Source/C/EfiRom
>=20
> Also, note that this doesn't work for out-of-tree builds, but this
> problem is pre-existent to your series.

Right, "roms/Makefile" is unrelated to building QEMU itself (which is
supposed to work outside of the source tree); it is for maintainers when
they intend to refresh the bundled fw stuff.

Thanks
Laszlo

>=20
>>
>>> =20
>>>  slof:
>>>  	$(MAKE) -C SLOF CROSS=3D$(powerpc64_cross_prefix) qemu
>>> @@ -150,6 +148,7 @@ clean:
>>>  	$(MAKE) -C sgabios clean
>>>  	rm -f sgabios/.depend
>>>  	$(MAKE) -C ipxe/src veryclean
>>> +	$(MAKE) -C edk2/BaseTools clean
>>
>> Ditto.
>>
>>>  	$(MAKE) -C SLOF clean
>>>  	rm -rf u-boot/build.e500
>>>  	$(MAKE) -C u-boot-sam460ex distclean
>>>
>>
>> Whichever path used:
>> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>> Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>>
