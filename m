Received: from eggs.gnu.org ([209.51.188.92]:54867)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1gkdYv-0005Ll-Bl
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 18:28:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1gkdYo-0002O1-Sg
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 18:28:30 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43810)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1gkdYl-0002Gu-1e
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 18:28:23 -0500
References: <1547566866-129386-1-git-send-email-imammedo@redhat.com>
	<1547566866-129386-11-git-send-email-imammedo@redhat.com>
	<15698cec-79eb-7a17-cf70-3a8fcb7962a6@redhat.com>
	<20190116113227.47ebdea2@redhat.com>
	<314cffa2-f153-011a-9c6e-01e94c73590a@redhat.com>
	<20190116115217.jduhqrwbjhuibmoq@sirius.home.kraxel.org>
	<20190116133133.3c43531f@redhat.com>
	<ad76d8d9-fd8e-c7ef-405a-5eb9adf8f3a0@redhat.com>
	<20190117161122.457fb2f3@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <cc072ba3-b49b-7b6b-fa32-8fad3d404316@redhat.com>
Date: Sat, 19 Jan 2019 00:28:08 +0100
MIME-Version: 1.0
In-Reply-To: <20190117161122.457fb2f3@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 10/14] tests: acpi: ignore SMBIOS tests
 when UEFI firmware is used
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>, Andrew Jones <drjones@redhat.com>, Samuel Ortiz <sameo@linux.intel.com>, "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org, Shannon Zhao <shannon.zhaosl@gmail.com>, Gonglei <arei.gonglei@huawei.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>

On 01/17/19 16:11, Igor Mammedov wrote:
> On Wed, 16 Jan 2019 17:22:31 +0100
> Laszlo Ersek <lersek@redhat.com> wrote:
> 
>> On 01/16/19 13:31, Igor Mammedov wrote:
>>> On Wed, 16 Jan 2019 12:52:17 +0100
>>> Gerd Hoffmann <kraxel@redhat.com> wrote:
>>>   
>>>>   Hi,
>>>>  
>>>>> This approach allows the UEFI app source to live in the QEMU tree, and
>>>>> the affected maintainer(s) would be personally responsible for setting
>>>>> up their edk2 clones, and compilers. (The edk2 clone could even be a
>>>>> submodule of QEMU, for example at roms/edk2.) For example,
>>>>> "roms/Makefile" already calls an external EFIROM utility (also from
>>>>> edk2) in order to build the combined iPXE option ROMs.
>>>>>
>>>>> And yes, we could turn the UEFI binaries into bootable ISO images at once.
>>>>>
>>>>> I'll try to post some patches soon (or not so soon). I think the app's
>>>>> source code, and the edk2 submodule, should live under roms/, and the
>>>>> bootable images should live under pc-bios/.
>>>>>
>>>>> (In fact we could use this opportunity to build & bundle OVMF itself...
>>>>> not sure if that's in scope for now. Gerd, what's your take?)    
>>>>
>>>> Well, there is still the idea to move over firmware submodules and
>>>> prebuilt firmware blobs to a separate repo.  Expermimental repo:
>>>> https://git.kraxel.org/cgit/qemu-firmware/.  Not touched for more than a
>>>> year due to being busy with other stuff.  Oh well ...
>>>>
>>>> (if someone feels like picking this up feel free to do so).
>>>>
>>>> I think adding edk2 as submodule below roms/ makes sense.  Adding rules
>>>> to roms/Makefile to build the blobs makes sense too.  Not sure we want
>>>> the binaries actually copied over to pc-bios/ and commited as the uefi
>>>> firmware is pretty big ...
>>>>
>>>> Not sure what a good place for the uefi app would be.  I'd tend to not
>>>> use roms/, that is the place for firmware submodules.  
>>
>> I figured the source code for the UEFI app would fit due to the script
>> "configure-seabios.sh" and some actual config files being there already.
>> But, I'm happy to follow directions. :)
>>
>>>>  contrib/ or test/ maybe?  
>>
>>> Could be tests/data/acpi in this case  
>>
>> If "tests/data/acpi" is appropriate for source code, that works for me.
>> We already have "rebuild-expected-aml.sh" there, so I guess another
>> build script and the UEFI app source code would fit there too.
> I suggested tests/data/acpi for binary EFI app blobs
> For EFI app source maybe just 'tests' or sub-directory there and make
> 'make check-efi-app' build EFI app (doing all needed magic and asking for things that missing)
> if source is newer than blobs.

I've been busy all day hacking and staying away from email, so when you see that my patches didn't follow this closely in the end, please know that I didn't deliberately ignore your point -- I'm just getting to it now. Let's continue the discussion under

  [qemu-devel] [PATCH 0/5] add the BiosTablesTest UEFI app, build it with the new roms/edk2 submodule

Thanks!
Laszlo

> 
>>
>> It would be nice if I could get around submitting some patches this
>> week. Sigh. :/
>>
>> Thanks,
>> Laszlo
>>
> 
