Received: from eggs.gnu.org ([2001:4830:134:3::10]:48291)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1de5K4-0000TO-Jf
	for qemu-devel@nongnu.org; Sat, 05 Aug 2017 16:05:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1de5K1-0006ly-BU
	for qemu-devel@nongnu.org; Sat, 05 Aug 2017 16:05:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45926)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1de5K1-0006lZ-1Y
	for qemu-devel@nongnu.org; Sat, 05 Aug 2017 16:05:17 -0400
References: <20170804064540.10523-1-dhiru.kholia@gmail.com>
	<20170804110539.3885a22d@nial.brq.redhat.com>
	<CANO7a6x6EaWNZ8y=MvLU=w_LjRLXserO3NmsgHvaYE0aUCCWzg@mail.gmail.com>
	<20170804171406.367f2f64@nial.brq.redhat.com>
	<CANO7a6y7NFLviGjBQv82QfnnrXufpdEZwjV2yqohG9E9AAeeWQ@mail.gmail.com>
	<CANO7a6yZ-YitMa1r3jgUA=Xh-R98rT_PFHaBjXQKC4=JbC9_SA@mail.gmail.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <b0a52980-bb3a-e1f2-c6d8-9832cd2df9da@redhat.com>
Date: Sat, 5 Aug 2017 22:05:09 +0200
MIME-Version: 1.0
In-Reply-To: <CANO7a6yZ-YitMa1r3jgUA=Xh-R98rT_PFHaBjXQKC4=JbC9_SA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
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

On 08/05/17 13:46, Dhiru Kholia wrote:
> On Sat, Aug 5, 2017 at 2:00 PM, Dhiru Kholia <dhiru.kholia@gmail.com> wrote:
>> On Fri, Aug 4, 2017 at 8:44 PM, Igor Mammedov <imammedo@redhat.com> wrote:
>>> On Fri, 4 Aug 2017 16:17:07 +0530
>>> Dhiru Kholia <dhiru.kholia@gmail.com> wrote:
>>>
>>>> On Fri, Aug 4, 2017 at 2:35 PM, Igor Mammedov <imammedo@redhat.com> wrote:
>>>>> On Fri,  4 Aug 2017 12:15:40 +0530
>>>>> Dhiru Kholia <dhiru.kholia@gmail.com> wrote:
>>>>>
>>>>>> This was tested with macOS 10.12.5 and Clover r4114.
>>>>>>
>>>>>> Without this patch, the macOS boot process gets stuck at the Apple logo
>>>>>> without showing any progress bar.
>>>>>>
>>>>>> I have documented the process of running macOS on QEMU/KVM at,
>>>>>>
>>>>>> https://github.com/kholia/OSX-KVM/
>>>>>>
>>>>>> Instead of using this patch, adding an additional command-line knob
>>>>>> which exposes this setting (force_rev1_fadt) to the user might be a more
>>>>>> general solution.
>>>>>
>>>>> it's been reported that OVMF had issues that were fixed,
>>>>> you probably want to read this thread:
>>>>> https://www.mail-archive.com/qemu-devel@nongnu.org/msg468456.html
>>>>
>>>> Hi Igor,
>>>>
>>>> I have now tested various OVMF versions with the latest QEMU (commit
>>>> aaaec6acad7c).
>>>>
>>>> When using edk2.git-ovmf-x64-0-20170726.b2826.gbb4831c03d.noarch.rpm
>>>> from [1] macOS does not boot and gets stuck. The CPU usage goes to
>>>> 100%. I haven't confirmed this but this OVMF build should have both
>>>> 198a46d and 072060a edk2 commits in it, based on the build date.
>>>>
>>>> The OVMF blob from Gabriel Somlo [2] hangs on the OVMF logo screen and
>>>> it too results in 100% CPU usage after hanging.
>>>>
>>>> I am using "boot-clover.sh" script from my repository [4] to test the
>>>> various OVMF versions.
>>>>
>>>> The only OVMF blob which works with the current QEMU for booting macOS
>>>> is the one from Proxmox [3]. Unfortunately, I don't know the
>>>> corresponding commit in the edk2 repository for this working OVMF
>>>> blob.
>>> So it's guest side issue, I'd prefer if it fixed there if possible
>>> instead of adding new CLI options to QEMU to work around issue.
>>>
>>> Added to CC BALATON Zoltan for whom updating OVMF fixed the problem,
>>> perhaps you'll be able to figure out what your setup is missing.
>>
>> I ran git bisect on OVMF repository [5] to find the commit that broke
>> booting of macOS + Clover combination in QEMU/KVM.
>>
>> It seems that commit 805762252733bb is problematic for some reason.
>> Reverting this commit fixes the macOS booting problem.
>>
>> In summary, I am able to boot macOS 10.12.5 + Clover combination with
>> latest OVMF (commit 1fceaddb12b with 805762252733bb reverted) +
>> updated QEMU (commit aaaec6acad7c with patch from this thread
>> applied).
> 
> After some more testing,
> 
> I am also able to boot macOS 10.12.5 + Clover combination with latest
> OVMF (commit 1fceaddb12b with 805762252733bb reverted) + updated QEMU
> (commit ac44ed2afb7c60 *without* my patch from this thread).

I don't know how edk2 commit 805762252733 ("OvmfPkg/AcpiPlatformDxe:
save fw_cfg boot script with QemuFwCfgS3Lib", 2017-02-23) can cause your
symptoms.

Let me give you some background on this commit. (See also
<https://bugzilla.tianocore.org/show_bug.cgi?id=394>.)

The PI (Platform Init) spec defines a thing called "ACPI S3 Boot
Script", which is basically a simple / limited, opcode based script
language. (Think reading and writing memory or MMIO locations, reading
and writing IO ports, reading and writing PCI config space registers,
and such.) During normal boot, some DXE drivers (= platform drivers) in
the firmware configure low-level hardware, and they can "record" such
script fragments, to be replayed (executed) during S3 resume. The point
of this feature is that the S3 boot script is supposed to run in a lot
more limited environment (during S3 resume) than the full-blown DXE
("driver execution environment") where the normal boot time firmware
drivers run.

The commit you mention is (remotely) related to the WRITE_POINTER
command of QEMU's ACPI linker/loader. At normal boot, this linker/loader
command basically instructs the firmware to pass firmware-allocated
addresses back to QEMU. (The execution of a WRITE_POINTER command boils
down to "select", "skip" (= seek) and "write" fw_cfg DMA operations.)

Effectively a WRITE_POINTER command creates a guest RAM reference in
QEMU. Thus, when the guest is reset (and its memory contents are wholly
invalidated), QEMU forgets all these addresses.

Except, on S3 resume (which looks like a kind of reset to QEMU), the
guest memory contents remain valid / intact. Therefore the firmware has
to "replay" all WRITE_POINTER commands, in order to restore those guest
RAM references in QEMU.

In OvmfPkg, the DXE driver that handles WRITE_POINTER (among other
things) at normal boot is OvmfPkg/AcpiPlatformDxe. It also records an S3
boot script fragment so that at S3 resume, the WRITE_POINTER commands
can be replayed, via a series of fw_cfg DMA operations (encoded as S3
boot script opcodes).

Composing such opcodes in C source code is generally tedious, therefore
TianoCore BZ#394 aimed to simplify that activity for a particular subset
of operations, namely fw_cfg DMA actions. QemuFwCfgS3Lib was introduced,
which allows drivers like OvmfPkg/AcpiPlatformDxe to record their fw_cfg
DMA oriented boot script fragments more easily (for the human programmer
anyway).

The commit you identified is the last patch of the series that fixed
TianoCore BZ#394. Right before that commit the library is in place, and
the last patch in the series converts OvmfPkg/AcpiPlatformDxe from
manual opcode massaging to the new library APIs.

I don't understand how this could play any role in your symptoms,
because you most likely aren't using a device like VMGENID that produces
WRITE_POINTER commands for the firmware. Admittedly, even without
WRITE_POINTER commands, the driver conversion in said commit could
slightly change the UEFI memmap due to slightly different reserved
memory allocations. (Side remark: you can't allocate memory dynamically
during S3 resume, so all the work space for the S3-time fw_cfg DMA
opcodes has to be reserved in advance, during normal boot, when the
bootscript fragment is recorded.) But allocating some reserved memory
"differently from earlier" is totally normal for any such DXE driver.

Perhaps the ever-so-slightly different UEFI memmap tickles something in
Clover or OSX. Dunno.

You could try the following:

(1) Disable S3 support on the QEMU command line. OVMF will recognize
that, and skip all the S3 opcode recording (and memory reservation).
IIRC OSX requires Q35, so I'll give you the command line option for Q35:

  -global ICH9-LPC.disable_s3=1

The same can be done in the libvirt domain XML like this:

  <domain type='kvm'>
    <pm>
      <suspend-to-mem enabled='no'/>
    </pm>
  </domain>

(2) Set "PcdDebugPrintErrorLevel" in "OvmfPkg/OvmfPkgX64.dsc" to
0x8040004F, then rebuild OVMF. Additionally, append the following to the
QEMU command line:

  -debugcon file:ovmf.debug.log -global isa-debugcon.iobase=0x402

We can then look at the OVMF debug log.

The same can be done in the domain XML like this:

  <domain
   type='kvm'
   xmlns:qemu='http://libvirt.org/schemas/domain/qemu/1.0'
  >
    <qemu:commandline>
      <qemu:arg value='-global'/>
      <qemu:arg value='isa-debugcon.iobase=0x402'/>
      <qemu:arg value='-debugcon'/>
      <qemu:arg value='file:/tmp/ovmf.debug.log'/>
    </qemu:commandline>
  </domain>

(Note the "xmlns:qemu" attribute in the root element!)

(3) Hm... are you perhaps using the pc-q35-2.4 machine type? If so, can
you try pc-q35-2.5 or later?


... Yes, you are using pc-q35-2.4:
https://github.com/kholia/OSX-KVM/blob/master/boot-clover.sh
https://github.com/kholia/OSX-KVM/blob/master/boot-macOS.sh

Sigh, I see now what it is. It's indeed an OVMF bug, introduced in
commit 805762252733.

Basically what I think I messed up in 805762252733 is that if you have
S3 enabled, OvmfPkg/AcpiPlatformDxe will incorrectly / indirectly insist
that you also have the DMA feature for fw_cfg, even if you have zero
WRITE_POINTER commands. pc-q35-2.4 has no DMA for fw_cfg, and S3 is
enabled by default in upstream QEMU and libvirt. OvmfPkg/AcpiPlatformDxe
incorrectly thinks this is bad and rolls back all the ACPI linker/loader
stuff -- you end up with the built-in (very outdated) fallback ACPI tables.

I'll try to send out a patch next week and CC you for testing. Please
subscribe to edk2-devel at
<https://lists.01.org/mailman/listinfo/edk2-devel> first, otherwise the
list will drop your messages.

Just to confirm my suspicion, can you please do all three steps / checks
above?

Thanks! (Extra kudos for the bisection!)
Laszlo

> 
> However, macOS 10.12.5 + older Proxmox OVMF blob doesn't boot with the
> same QEMU version without my patch from this thread.
> 
> Overall, exposing this (force_rev1_fadt) setting to the user to might
> be necessary if maintaining compatibility with older OVMF blobs is
> required.
> 
> It would be great if someone else could reproduce my results, and
> ensure that they are correct.
> 
> Thanks,
> Dhiru
> 
>> I don't know what commit 805762252733bb does yet but I will look at it
>> again. I am CC'ing Laszlo Ersek, the author of this OVMF commit.
>>
>> [5] https://github.com/tianocore/edk2
>>
>>>> References,
>>>>
>>>> [1] https://www.kraxel.org/repos/jenkins/edk2/
>>>>
>>>> [2] https://www.contrib.andrew.cmu.edu/~somlo/OSXKVM/
>>>>
>>>> [3] https://git.proxmox.com/?p=pve-qemu-kvm.git;a=tree;f=debian
>>>>
>>>> [4] https://github.com/kholia/OSX-KVM/
