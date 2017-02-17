Received: from eggs.gnu.org ([2001:4830:134:3::10]:46886)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1ceoox-0007wW-DO
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 15:08:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1ceoos-0004Bl-9z
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 15:07:59 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39714)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1ceoos-00049j-18
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 15:07:54 -0500
References: <cover.1487286467.git.ben@skyportsystems.com>
	<88232638f9ff3b17b54987624468678ea14a3037.1487286467.git.ben@skyportsystems.com>
	<20170217114321.6c8577e1@nial.brq.redhat.com>
	<4F60B53E-1A5D-4D4C-954F-F1C3ED5B487C@skyportsystems.com>
	<de706a53-137c-a49d-5765-4afecc5ce3d8@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <c052d05e-71a5-1a6a-f34f-17d14167c2f6@redhat.com>
Date: Fri, 17 Feb 2017 21:07:49 +0100
MIME-Version: 1.0
In-Reply-To: <de706a53-137c-a49d-5765-4afecc5ce3d8@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v8 4/8] ACPI: Add Virtual Machine
 Generation ID support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ben Warren <ben@skyportsystems.com>, Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, mst@redhat.com

On 02/17/17 17:03, Laszlo Ersek wrote:
> On 02/17/17 16:33, Ben Warren wrote:
>>
>>> On Feb 17, 2017, at 2:43 AM, Igor Mammedov <imammedo@redhat.com
>>> <mailto:imammedo@redhat.com>> wrote:
>>>
>>> On Thu, 16 Feb 2017 15:15:36 -0800
>>> ben@skyportsystems.com <mailto:ben@skyportsystems.com> wrote:
>>>
>>>> From: Ben Warren <ben@skyportsystems.com <mailto:ben@skyportsystems.=
com>>
>>>>
>>>> This implements the VM Generation ID feature by passing a 128-bit
>>>> GUID to the guest via a fw_cfg blob.
>>>> Any time the GUID changes, an ACPI notify event is sent to the guest
>>>>
>>>> The user interface is a simple device with one parameter:
>>>> - guid (string, must be "auto" or in UUID format
>>>>   xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx)
>>> I've given it some testing with WS2012R2 and v4 patches for Seabios,
>>>
>>> Windows is able to read initial GUID allocation and writeback
>>> seems to work somehow:
>>>
>>> (qemu) info vm-generation-id
>>> c109c09b-0e8b-42d5-9b33-8409c9dcd16c
>>>
>>> vmgenid client in Windows reads it as 2 following 64bit integers:
>>> 42d50e8bc109c09b:6cd1dcc90984339b
>>>
>>> However update path/restore from snapshot doesn't
>>> here is as I've tested it:
>>>
>>> qemu-system-x86_64 -device vmgenid,id=3Dtestvgid,guid=3Dauto -monitor=
 stdio
>>> (qemu) info vm-generation-id
>>> c109c09b-0e8b-42d5-9b33-8409c9dcd16c
>>> (qemu) stop
>>> (qemu) migrate "exec:gzip -c > STATEFILE.gz"
>>> (qemu) quit
>>>
>>> qemu-system-x86_64 -device vmgenid,id=3Dtestvgid,guid=3Dauto -monitor=
 stdio
>>> -incoming "exec: gzip -c -d STATEFILE.gz"
>>> (qemu) info vm-generation-id
>>> 28b587fa-991b-4267-80d7-9cf28b746fe9
>>>
>>> guest
>>> 1. doesn't get GPE notification that it must receive
>>> 2. vmgenid client in Windows reads the same value
>>>      42d50e8bc109c09b:6cd1dcc90984339b
>>>
>> Strange, this was working for me, but with a slightly different test m=
ethod:
>>
>>   * I use virsh save/restore
>=20
> Awesome, this actually what I should try. All my guests are managed by
> libvirt (with the occasional <qemu:arg>, for development), and direct
> QEMU monitor commands such as
>=20
>   virsh qemu-monitor-command ovmf.rhel7 --hmp 'info vm-generation-id'
>=20
> only work for me if they are reasonably non-intrusive.
>=20
>>   * While I do later testing with Windows, during development I use a
>>     Linux kernel module I wrote that keeps track of GUID and
>>     notifications.  I=E2=80=99m happy to share this with you if intere=
sted.
>=20
> Please do. If you have a public git repo somewhere, that would be
> awesome. (Bonus points if the module builds out-of-tree, if the
> kernel-devel package is installed.)
>=20
> NB: while the set-id monitor command was part of the series, I did test
> it to the extent that I checked the SCI ("ACPI interrupt") count in the
> guest, in /proc/interrupts. I did see it increase, so minimally the SCI
> injection was fine.

So, I did some testing with a RHEL-7 guest. I passed '-device
vmgenid=3Dauto' to QEMU using the <qemu:arg> element in the domain XML.

(1) I started the guest normally, and grepped /proc/interrupts for
"acpi". Zero interrupts on either VCPU.

(2) Dumped the guest RAM to a file with "virsh dump ... --memory-only",
opened it with crash, and listed the 16 GUID bytes at the offset that
the firmware (OVMF) reported at startup.

(3) cycled through "virsh managedsave" and "virsh start"

(4) grepped /proc/interrupts again for "acpi". One interrupt had been
delivered to one of the VCPUs, all others were zero.

(5) Repeated step (2). The bytes listed this time were different.

(6) Issued "virsh qemu-monitor-command ovmf.rhel7 --hmp 'info
vm-generation-id", and compared the output against the bytes dumped
(with crash) from guest memory, in step 5. They were a match.

So, to me it seems like the SCI is injected, and the memory contents are
changed.

---*---

Windows Server 2012 R2 test:

(7) booted the guest similarly with '-device vmgenid=3Dauto' via
<qemu:arg> in the domain XML.

(8) Initial check from the host side:

$ virsh qemu-monitor-command ovmf.win2012r2.q35 \
    --hmp 'info vm-generation-id'
a3f7c334-7dc4-4694-8b8f-abf52abb072f

(9) Verifying the same from within, using Vadim's program (note: I
logged into the VM with ssh, using Cygwin's SSHD in the guest):

$ ./vmgenid.exe
VmCounterValue: 46947dc4a3f7c334:2f07bb2af5ab8f8b
0x34 0xc3 0xf7 0xa3 0xc4 0x7d 0x94 0x46 0x8b 0x8f 0xab 0xf5 0x2a 0xbb
0x07 0x2f

This is a match, so the initial setup works. (Look only at the raw byte
dump in the second line -- it matches the Little Endian UUID
representation as specified in the SMBIOS spec!)

(10) Logged out of the guest (with ssh), cycled through "virsh
managedsave" and "virsh start" for the domain, logged back in.

(11) in the guest:

$ ./vmgenid.exe
VmCounterValue: 4a12296b382162da:6c00d1a52699b7bd
0xda 0x62 0x21 0x38 0x6b 0x29 0x12 0x4a 0xbd 0xb7 0x99 0x26 0xa5 0xd1
0x00 0x6c

(12) on the host:

$ virsh qemu-monitor-command ovmf.win2012r2.q35 \
      --hmp 'info vm-generation-id'
382162da-296b-4a12-bdb7-9926a5d1006c

This is again a match. (Again, look only at the raw byte dump from
vmgenid.exe under (11), and consider the BE/LE conversion for the first
three segments!)

(13) Logged out of the guest with ssh, and started Vadim's other program
(vmgenid_wait.exe), this time from a normal CMD window on the GUI. The
program started, reproduced the above output (seen under (11)), and then
went to sleep (waiting).

(14) cycled through "virsh managedsave" and "virsh start" for the domain.

(15) The domain resumed, and Vadim's vmgenid_wait.exe woke up, printing
(manual transcript):

VmCounterValue changed to: 495ba7807ed37772:195d0cff681f7a7

Please refer to the following screenshot:

http://people.redhat.com/~lersek/vmgenid-dd1f68c5-89b0-4458-84fa-de9e3d23=
f4cb/Screenshot_ovmf.win2012r2.q35_2017-02-17_20:34:41.png

(16) on the host:

$ virsh qemu-monitor-command ovmf.win2012r2.q35 \
      --hmp 'info vm-generation-id'

7ed37772-a780-495b-a7f7-81f6cfd09501

This is again a match. It is not easy to see, because Vadim's
"vmgenid_wait.exe" does not print the raw byte dump after it wakes up;
the raw byte dump is only printed before it goes to sleep. After wakeup,
it only dumps the composed values. Somewhat more confusingly, the 64-bit
hex integers are not zero padded, we'll have to make up for that manually=
.

So here goes:

   [A]      [B]  [C]  [D]  [E]
   7ed37772-a780-495b-a7f7-81f6cfd09501 (from the host)

   [C]  [B]  [A]        [E']         [D']
   495b a780 7ed37772 : 0195d0cff681 f7a7 (from vmgenid_wait.exe)
                        ^
                        zero padding added manually

The parts marked with an apostrophe (') are reversed, byte-wise.

So, I'm going to have to declare this "working by design".

Confirming my earlier Tested-by (same patches as before):

Tested-by: Laszlo Ersek <lersek@redhat.com>

What could be the difference between Igor's setup and mine? Perhaps the
BIOS? (Again, I used OVMF.)

The "managedsave" command of virsh boils down to (see
"src/qemu/qemu_driver.c" in the libvirt source):

qemuDomainManagedSave()
  qemuDomainSaveInternal()
    qemuProcessStopCPUs()
    qemuDomainSaveMemory()
      qemuDomainSaveHeader()
      qemuMigrationToFile()
        qemuMonitorMigrateToFd()
          ...
    qemuProcessStop()

I capture all traffic between libvirt and the QEMU monitor, and between
libvirt and the QEMU guest agent, in the libvirt log file, as a rule, so
I can paste the relevant lines:

Libvirt sending the file descriptor to QEMU:

2017-02-17 19:31:54.305+0000: 16586: debug :
qemuMonitorJSONCommandWithFd:296 : Send command
'{"execute":"getfd","arguments":{"fdname":"migrate"},"id":"libvirt-30"}'
for write with FD 26

Libvirt starting the migration:

2017-02-17 19:31:54.306+0000: 16586: debug :
qemuMonitorJSONCommandWithFd:296 : Send command
'{"execute":"migrate","arguments":{"detach":true,"blk":false,"inc":false,=
"uri":"fd:migrate"},"id":"libvirt-31"}'
for write with FD -1

Then loading it:

2017-02-17 19:32:02.083+0000: 16585: debug :
qemuMonitorJSONCommandWithFd:296 : Send command
'{"execute":"migrate-incoming","arguments":{"uri":"fd:25"},"id":"libvirt-=
17"}'
for write with FD -1

I don't have the slightest idea why it failed for Igor -- I can only
suspect the SeaBIOS patches.

Note that in the SeaBIOS discussion, Ben mentioned that he wasn't
actually seeing the fw_cfg writes in QEMU on the S3 resume path, despite
SeaBIOS attempting them. So, perhaps, is there a bug in the latest
SeaBIOS patches that prevent fw_cfg writes completely, even on the
normal boot path? That would be consistent with Igor's results: the
initial download works (hence the first GUID can be seen), but then the
update does not work (because QEMU has not received the address).

Thanks
Laszlo
