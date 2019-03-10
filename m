Received: from eggs.gnu.org ([209.51.188.92]:44636)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1h30Bj-0007MC-JL
	for qemu-devel@nongnu.org; Sun, 10 Mar 2019 11:16:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1h30Bi-0007uA-RO
	for qemu-devel@nongnu.org; Sun, 10 Mar 2019 11:16:31 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:40783)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1h30Bi-0007tn-L2
	for qemu-devel@nongnu.org; Sun, 10 Mar 2019 11:16:30 -0400
Received: by mail-wr1-f68.google.com with SMTP id t6so2354825wrw.7
	for <qemu-devel@nongnu.org>; Sun, 10 Mar 2019 08:16:30 -0700 (PDT)
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
References: <20190309004826.9027-1-lersek@redhat.com>
	<20190309004826.9027-7-lersek@redhat.com>
	<2d33be0b-aa53-2038-01b0-0afed368aea8@redhat.com>
	<d7a6faeb-069e-d715-ad3b-fb31511d16a1@redhat.com>
Message-ID: <02bc5772-d49e-adf4-ce75-5d93134dfc14@redhat.com>
Date: Sun, 10 Mar 2019 16:16:27 +0100
MIME-Version: 1.0
In-Reply-To: <d7a6faeb-069e-d715-ad3b-fb31511d16a1@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 06/10] roms/Makefile: replace the $(EFIROM)
 target with "edk2-basetools"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laszlo Ersek <lersek@redhat.com>, berrange@redhat.com, imammedo@redhat.com, kraxel@redhat.com, mst@redhat.com, qemu-devel@nongnu.org

On 3/9/19 2:53 AM, Philippe Mathieu-Daudé wrote:
> On 3/9/19 2:32 AM, Philippe Mathieu-Daudé wrote:
>> Hi Laszlo,
>>
>> On 3/9/19 1:48 AM, Laszlo Ersek wrote:
>>> We don't (can't) have a recipe for building just $(EFIROM); therefore,
>>> while we call the target $(EFIROM), we actually build all of the edk2
>>> BaseTools. Rename the target to edk2-basetools, and update the iPXE
>>> prerequisite accordingly. This will let other targets depend on
>>> "edk2-basetools", where an $(EFIROM) pre-requisite would be misleading.
>>>
>>> Signed-off-by: Laszlo Ersek <lersek@redhat.com>
>>> ---
>>>  roms/Makefile | 4 ++--
>>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/roms/Makefile b/roms/Makefile
>>> index 78d5dd18c301..2e83ececa25a 100644
>>> --- a/roms/Makefile
>>> +++ b/roms/Makefile
>>> @@ -102,7 +102,7 @@ pxe-rom-%: build-pxe-roms
>>>  
>>>  efirom: $(patsubst %,efi-rom-%,$(pxerom_variants))
>>>  
>>> -efi-rom-%: build-pxe-roms build-efi-roms $(EFIROM)
>>> +efi-rom-%: build-pxe-roms build-efi-roms edk2-basetools
>>>  	$(EFIROM) -f "0x$(VID)" -i "0x$(DID)" -l 0x02 \
>>>  		-b ipxe/src/bin/$(VID)$(DID).rom \
>>>  		-ec ipxe/src/bin-i386-efi/$(VID)$(DID).efidrv \
>>> @@ -120,7 +120,7 @@ build-efi-roms: build-pxe-roms
>>>  		$(patsubst %,bin-i386-efi/%.efidrv,$(pxerom_targets)) \
>>>  		$(patsubst %,bin-x86_64-efi/%.efidrv,$(pxerom_targets))
>>>  
>>> -$(EFIROM):
>>> +edk2-basetools:
>>
>> Should we add:
>>
>>         $(MAKE) -f Makefile.edk2 submodules
>>
>> from your next patch?
>>
>> There might be a circular dependency else, if the user doesn't init the
>> submodules manually.
>>
>> The next patch add a make dependency 'efi' -> 'edk2-basetools', but
>> 'edk2-basetools' build the BaseTools within edk2/.
>>
> 
> OK I mixed, the Makefile.edk2's submodules rules is for the edk2
> repository submodules, while by 'the user submodules' I mean the QEMU
> submodules...
> 
> So the user has to initialize the roms/edk2 submodule previous to run
> both efi/edk2-basetools rules of this Makefile.

Maybe we can 'test -e edk2/.git' and display an error "edk2 submodule
not initialized.", what do you think?

Regardless:
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>

>>>  	$(MAKE) -C edk2/BaseTools
>>>  
>>>  slof:
>>>
