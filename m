Received: from eggs.gnu.org ([209.51.188.92]:52186)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1glXtq-0005jn-2f
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 06:37:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1glXtp-0004E3-2V
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 06:37:54 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:34942)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1glXto-0004DV-Sx
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 06:37:53 -0500
Received: by mail-wm1-f65.google.com with SMTP id t200so10481261wmt.0
	for <qemu-devel@nongnu.org>; Mon, 21 Jan 2019 03:37:52 -0800 (PST)
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
References: <20190118223400.24311-1-lersek@redhat.com>
	<20190118223400.24311-3-lersek@redhat.com>
	<63cb176b-64ba-6938-2a95-464f60883281@redhat.com>
Message-ID: <4f92eff3-29cd-25e4-6bc2-cd0e067d5132@redhat.com>
Date: Mon, 21 Jan 2019 12:37:50 +0100
MIME-Version: 1.0
In-Reply-To: <63cb176b-64ba-6938-2a95-464f60883281@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
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
To: Laszlo Ersek <lersek@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu devel list <qemu-devel@nongnu.org>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Igor Mammedov <imammedo@redhat.com>, Shannon Zhao <shannon.zhaosl@gmail.com>

On 1/21/19 12:27 PM, Philippe Mathieu-Daudé wrote:
> Hi Laszlo,
> 
> On 1/18/19 11:33 PM, Laszlo Ersek wrote:
>> Building the EfiRom utility from "roms/edk2/BaseTools" should make
>> "roms/Makefile" more self-contained. Otherwise, we'd call the system-wide
>> EfiRom for building the combined iPXE option ROMs, but call the sibling
>> utilities from "roms/edk2/BaseTools" for building "roms/edk2" content.
>>
>> Cc: "Michael S. Tsirkin" <mst@redhat.com>
>> Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
>> Cc: Gerd Hoffmann <kraxel@redhat.com>
>> Cc: Igor Mammedov <imammedo@redhat.com>
>> Cc: Philippe Mathieu-Daudé <philmd@redhat.com>
>> Cc: Shannon Zhao <shannon.zhaosl@gmail.com>
>> Signed-off-by: Laszlo Ersek <lersek@redhat.com>
>> ---
>>  roms/Makefile | 13 ++++++-------
>>  1 file changed, 6 insertions(+), 7 deletions(-)
>>
>> diff --git a/roms/Makefile b/roms/Makefile
>> index a6043eff37e9..78d5dd18c301 100644
>> --- a/roms/Makefile
>> +++ b/roms/Makefile
>> @@ -47,10 +47,7 @@ SEABIOS_EXTRAVERSION="-prebuilt.qemu.org"
>>  # We need that to combine multiple images (legacy bios,
>>  # efi ia32, efi x64) into a single rom binary.
>>  #
>> -# We try to find it in the path.  You can also pass the location on
>> -# the command line, i.e. "make EFIROM=/path/to/EfiRom efirom"
>> -#
>> -EFIROM ?= $(shell which EfiRom 2>/dev/null)
>> +EFIROM = edk2/BaseTools/Source/C/bin/EfiRom
>>  
>>  default:
>>  	@echo "nothing is build by default"
>> @@ -59,8 +56,7 @@ default:
>>  	@echo "  vgabios        -- update vgabios binaries (seabios)"
>>  	@echo "  sgabios        -- update sgabios binaries"
>>  	@echo "  pxerom         -- update nic roms (bios only)"
>> -	@echo "  efirom         -- update nic roms (bios+efi, this needs"
>> -	@echo "                    the EfiRom utility from edk2 / tianocore)"
>> +	@echo "  efirom         -- update nic roms (bios+efi)"
>>  	@echo "  slof           -- update slof.bin"
>>  	@echo "  skiboot        -- update skiboot.lid"
>>  	@echo "  u-boot.e500    -- update u-boot.e500"
>> @@ -106,7 +102,7 @@ pxe-rom-%: build-pxe-roms
>>  
>>  efirom: $(patsubst %,efi-rom-%,$(pxerom_variants))
>>  
>> -efi-rom-%: build-pxe-roms build-efi-roms
>> +efi-rom-%: build-pxe-roms build-efi-roms $(EFIROM)
>>  	$(EFIROM) -f "0x$(VID)" -i "0x$(DID)" -l 0x02 \
>>  		-b ipxe/src/bin/$(VID)$(DID).rom \
>>  		-ec ipxe/src/bin-i386-efi/$(VID)$(DID).efidrv \
>> @@ -124,6 +120,8 @@ build-efi-roms: build-pxe-roms
>>  		$(patsubst %,bin-i386-efi/%.efidrv,$(pxerom_targets)) \
>>  		$(patsubst %,bin-x86_64-efi/%.efidrv,$(pxerom_targets))
>>  
>> +$(EFIROM):
>> +	$(MAKE) -C edk2/BaseTools
> 
> Since this is a single tool/file, can we simply use:
> 
>         $(MAKE) -C edk2/BaseTools/Source/C/EfiRom

Also, note that this doesn't work for out-of-tree builds, but this
problem is pre-existent to your series.

> 
>>  
>>  slof:
>>  	$(MAKE) -C SLOF CROSS=$(powerpc64_cross_prefix) qemu
>> @@ -150,6 +148,7 @@ clean:
>>  	$(MAKE) -C sgabios clean
>>  	rm -f sgabios/.depend
>>  	$(MAKE) -C ipxe/src veryclean
>> +	$(MAKE) -C edk2/BaseTools clean
> 
> Ditto.
> 
>>  	$(MAKE) -C SLOF clean
>>  	rm -rf u-boot/build.e500
>>  	$(MAKE) -C u-boot-sam460ex distclean
>>
> 
> Whichever path used:
> Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> 
