Received: from eggs.gnu.org ([2001:4830:134:3::10]:54773)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1deI4F-0003Aj-Un
	for qemu-devel@nongnu.org; Sun, 06 Aug 2017 05:41:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1deI4C-00056n-Q4
	for qemu-devel@nongnu.org; Sun, 06 Aug 2017 05:41:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42334)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1deI4C-00054u-Fq
	for qemu-devel@nongnu.org; Sun, 06 Aug 2017 05:41:48 -0400
References: <20170804064540.10523-1-dhiru.kholia@gmail.com>
	<20170804110539.3885a22d@nial.brq.redhat.com>
	<CANO7a6x6EaWNZ8y=MvLU=w_LjRLXserO3NmsgHvaYE0aUCCWzg@mail.gmail.com>
	<20170804171406.367f2f64@nial.brq.redhat.com>
	<CANO7a6y7NFLviGjBQv82QfnnrXufpdEZwjV2yqohG9E9AAeeWQ@mail.gmail.com>
	<CANO7a6yZ-YitMa1r3jgUA=Xh-R98rT_PFHaBjXQKC4=JbC9_SA@mail.gmail.com>
	<b0a52980-bb3a-e1f2-c6d8-9832cd2df9da@redhat.com>
	<20170806073836.GA23008@lonestar>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <d1fb5cf1-0a80-ef87-d2d1-4004930b810d@redhat.com>
Date: Sun, 6 Aug 2017 11:35:04 +0200
MIME-Version: 1.0
In-Reply-To: <20170806073836.GA23008@lonestar>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] pc/acpi: Fix booting of macOS with Clover
 EFI bootloader
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Dhiru Kholia <dhiru.kholia@gmail.com>
Cc: Igor Mammedov <imammedo@redhat.com>, Pankaj Gupta <pagupta@redhat.com>, Gabriel Somlo <somlo@cmu.edu>, qemu-devel@nongnu.org, Phil Dennis-Jordan <lists@philjordan.eu>, BALATON Zoltan <balaton@eik.bme.hu>, Programmingkid <programmingkidx@gmail.com>

On 08/06/17 09:38, Dhiru Kholia wrote:
> On Sat, Aug 05, 2017 at 10:05:09PM +0200, Laszlo Ersek wrote:
>> On 08/05/17 13:46, Dhiru Kholia wrote:
>>> On Sat, Aug 5, 2017 at 2:00 PM, Dhiru Kholia <dhiru.kholia@gmail.com> wrote:
>>>> I ran git bisect on OVMF repository [5] to find the commit that broke
>>>> booting of macOS + Clover combination in QEMU/KVM.
>>>>
>>>> It seems that commit 805762252733bb is problematic for some reason.
>>>> Reverting this commit fixes the macOS booting problem.
>>>>
>>>> In summary, I am able to boot macOS 10.12.5 + Clover combination with
>>>> latest OVMF (commit 1fceaddb12b with 805762252733bb reverted) +
>>>> updated QEMU (commit aaaec6acad7c with patch from this thread
>>>> applied).
>>>
>>> After some more testing,
>>>
>>> I am also able to boot macOS 10.12.5 + Clover combination with latest
>>> OVMF (commit 1fceaddb12b with 805762252733bb reverted) + updated QEMU
>>> (commit ac44ed2afb7c60 *without* my patch from this thread).
>>
>> I don't know how edk2 commit 805762252733 ("OvmfPkg/AcpiPlatformDxe:
>> save fw_cfg boot script with QemuFwCfgS3Lib", 2017-02-23) can cause your
>> symptoms.
>>
>> (snipped)
> 
> Hi Laszlo,
> 
> Thanks a lot for your detailed answers, and great tips.
> 
> For all of the following results, I have used OVMF commit 1fceaddb12b59,
> without any patches reverted.
> 
>> You could try the following:
>>
>> (1) Disable S3 support on the QEMU command line. OVMF will recognize
>> that, and skip all the S3 opcode recording (and memory reservation).
>> IIRC OSX requires Q35, so I'll give you the command line option for Q35:
>>
>>   -global ICH9-LPC.disable_s3=1
> 
> -machine pc-q35-2.4 -global ICH9-LPC.disable_s3=1
> 
> This combination works fine. I was able to boot macOS 10.12.5 + Clover with
> it.
> 
>> (2) Set "PcdDebugPrintErrorLevel" in "OvmfPkg/OvmfPkgX64.dsc" to
>> 0x8040004F, then rebuild OVMF. Additionally, append the following to the
>> QEMU command line:
>>
>>   -debugcon file:ovmf.debug.log -global isa-debugcon.iobase=0x402
>>
>> We can then look at the OVMF debug log.
> 
> I have attached the compressed logs to this email.
> 
> q35-2.4-ovmf.debug.log.tar.gz is for "pc-q35-2.4" machine type

Yup, the log says

"AcpiPlatform: QemuFwCfgS3CallWhenBootScriptReady: fw_cfg DMA unavailable"

> and q35-2.5-ovmf.debug.log.tar.gz is for "pc-q35-2.5".

whereas this one says

"InstallQemuFwCfgTables: installed 6 tables"

Thank you for confirming the analysis. (Also thanks for the careful
testing; it's nice to see when someone takes care to isolate the moving
parts from each other.) I'll send the patch soon and CC you.

Sorry about the regression.

Cheers,
Laszlo

> 
> The "pc-q35-2.4" machine doesn't boot but "pc-q35-2.5" works fine.
> 
> I did not use the "ICH9-LPC.disable_s3=1" option for these results.
> 
>> (3) Hm... are you perhaps using the pc-q35-2.4 machine type? If so, can
>> you try pc-q35-2.5 or later?
>>
>> ... Yes, you are using pc-q35-2.4:
>> https://github.com/kholia/OSX-KVM/blob/master/boot-clover.sh
>> https://github.com/kholia/OSX-KVM/blob/master/boot-macOS.sh
> 
> The "pc-q35-2.5" machine type works great without any extra options with
> pristine latest QEMU and OVMF sources! I will update my macOS boot
> script to use this (or higher) machine type.
> 
>> Sigh, I see now what it is. It's indeed an OVMF bug, introduced in
>> commit 805762252733.
>>
>> Basically what I think I messed up in 805762252733 is that if you have
>> S3 enabled, OvmfPkg/AcpiPlatformDxe will incorrectly / indirectly insist
>> that you also have the DMA feature for fw_cfg, even if you have zero
>> WRITE_POINTER commands. pc-q35-2.4 has no DMA for fw_cfg, and S3 is
>> enabled by default in upstream QEMU and libvirt. OvmfPkg/AcpiPlatformDxe
>> incorrectly thinks this is bad and rolls back all the ACPI linker/loader
>> stuff -- you end up with the built-in (very outdated) fallback ACPI tables.
>>
>> I'll try to send out a patch next week and CC you for testing. Please
>> subscribe to edk2-devel at
>> <https://lists.01.org/mailman/listinfo/edk2-devel> first, otherwise the
>> list will drop your messages.
>>
>> Just to confirm my suspicion, can you please do all three steps / checks
>> above?
> 
> I have subscribed to the edk2-devel list now. I would be happy to test
> your upcoming patch.
> 
> I believe that you have already figured out this whole thing :-)
> 
> Thanks,
> Dhiru
> 
