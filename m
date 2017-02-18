Received: from eggs.gnu.org ([2001:4830:134:3::10]:54450)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ben@skyportsystems.com>) id 1cesgo-0003QY-11
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 19:15:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ben@skyportsystems.com>) id 1cesgj-0002pJ-Um
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 19:15:50 -0500
Received: from mail-pg0-x233.google.com ([2607:f8b0:400e:c05::233]:34169)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <ben@skyportsystems.com>)
	id 1cesgj-0002oj-IS
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 19:15:45 -0500
Received: by mail-pg0-x233.google.com with SMTP id z67so19348011pgb.1
	for <qemu-devel@nongnu.org>; Fri, 17 Feb 2017 16:15:45 -0800 (PST)
From: Ben Warren <ben@skyportsystems.com>
Message-Id: <A9F74577-5CDD-450E-A188-8879877CA1A2@skyportsystems.com>
Content-Type: multipart/signed;
	boundary="Apple-Mail=_C8ACC45F-56C7-4310-B8FF-4E5CAA7DB845";
	protocol="application/pkcs7-signature"; micalg=sha1
Mime-Version: 1.0 (Mac OS X Mail 10.2 \(3259\))
Date: Fri, 17 Feb 2017 16:15:42 -0800
In-Reply-To: <c052d05e-71a5-1a6a-f34f-17d14167c2f6@redhat.com>
References: <cover.1487286467.git.ben@skyportsystems.com>
	<88232638f9ff3b17b54987624468678ea14a3037.1487286467.git.ben@skyportsystems.com>
	<20170217114321.6c8577e1@nial.brq.redhat.com>
	<4F60B53E-1A5D-4D4C-954F-F1C3ED5B487C@skyportsystems.com>
	<de706a53-137c-a49d-5765-4afecc5ce3d8@redhat.com>
	<c052d05e-71a5-1a6a-f34f-17d14167c2f6@redhat.com>
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
To: Laszlo Ersek <lersek@redhat.com>
Cc: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org, mst@redhat.com


--Apple-Mail=_C8ACC45F-56C7-4310-B8FF-4E5CAA7DB845
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8


> On Feb 17, 2017, at 12:07 PM, Laszlo Ersek <lersek@redhat.com> wrote:
>=20
> On 02/17/17 17:03, Laszlo Ersek wrote:
>> On 02/17/17 16:33, Ben Warren wrote:
>>>=20
>>>> On Feb 17, 2017, at 2:43 AM, Igor Mammedov <imammedo@redhat.com
>>>> <mailto:imammedo@redhat.com>> wrote:
>>>>=20
>>>> On Thu, 16 Feb 2017 15:15:36 -0800
>>>> ben@skyportsystems.com <mailto:ben@skyportsystems.com> wrote:
>>>>=20
>>>>> From: Ben Warren <ben@skyportsystems.com =
<mailto:ben@skyportsystems.com>>
>>>>>=20
>>>>> This implements the VM Generation ID feature by passing a 128-bit
>>>>> GUID to the guest via a fw_cfg blob.
>>>>> Any time the GUID changes, an ACPI notify event is sent to the =
guest
>>>>>=20
>>>>> The user interface is a simple device with one parameter:
>>>>> - guid (string, must be "auto" or in UUID format
>>>>>  xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx)
>>>> I've given it some testing with WS2012R2 and v4 patches for =
Seabios,
>>>>=20
>>>> Windows is able to read initial GUID allocation and writeback
>>>> seems to work somehow:
>>>>=20
>>>> (qemu) info vm-generation-id
>>>> c109c09b-0e8b-42d5-9b33-8409c9dcd16c
>>>>=20
>>>> vmgenid client in Windows reads it as 2 following 64bit integers:
>>>> 42d50e8bc109c09b:6cd1dcc90984339b
>>>>=20
>>>> However update path/restore from snapshot doesn't
>>>> here is as I've tested it:
>>>>=20
>>>> qemu-system-x86_64 -device vmgenid,id=3Dtestvgid,guid=3Dauto =
-monitor stdio
>>>> (qemu) info vm-generation-id
>>>> c109c09b-0e8b-42d5-9b33-8409c9dcd16c
>>>> (qemu) stop
>>>> (qemu) migrate "exec:gzip -c > STATEFILE.gz"
>>>> (qemu) quit
>>>>=20
>>>> qemu-system-x86_64 -device vmgenid,id=3Dtestvgid,guid=3Dauto =
-monitor stdio
>>>> -incoming "exec: gzip -c -d STATEFILE.gz"
>>>> (qemu) info vm-generation-id
>>>> 28b587fa-991b-4267-80d7-9cf28b746fe9
>>>>=20
>>>> guest
>>>> 1. doesn't get GPE notification that it must receive
>>>> 2. vmgenid client in Windows reads the same value
>>>>     42d50e8bc109c09b:6cd1dcc90984339b
>>>>=20
>>> Strange, this was working for me, but with a slightly different test =
method:
>>>=20
>>>  * I use virsh save/restore
>>=20
>> Awesome, this actually what I should try. All my guests are managed =
by
>> libvirt (with the occasional <qemu:arg>, for development), and direct
>> QEMU monitor commands such as
>>=20
>>  virsh qemu-monitor-command ovmf.rhel7 --hmp 'info vm-generation-id'
>>=20
>> only work for me if they are reasonably non-intrusive.
>>=20
>>>  * While I do later testing with Windows, during development I use a
>>>    Linux kernel module I wrote that keeps track of GUID and
>>>    notifications.  I=E2=80=99m happy to share this with you if =
interested.
>>=20
>> Please do. If you have a public git repo somewhere, that would be
>> awesome. (Bonus points if the module builds out-of-tree, if the
>> kernel-devel package is installed.)
>>=20
>> NB: while the set-id monitor command was part of the series, I did =
test
>> it to the extent that I checked the SCI ("ACPI interrupt") count in =
the
>> guest, in /proc/interrupts. I did see it increase, so minimally the =
SCI
>> injection was fine.
>=20
> So, I did some testing with a RHEL-7 guest. I passed '-device
> vmgenid=3Dauto' to QEMU using the <qemu:arg> element in the domain =
XML.
>=20
> (1) I started the guest normally, and grepped /proc/interrupts for
> "acpi". Zero interrupts on either VCPU.
>=20
> (2) Dumped the guest RAM to a file with "virsh dump ... =
--memory-only",
> opened it with crash, and listed the 16 GUID bytes at the offset that
> the firmware (OVMF) reported at startup.
>=20
> (3) cycled through "virsh managedsave" and "virsh start"
>=20
> (4) grepped /proc/interrupts again for "acpi". One interrupt had been
> delivered to one of the VCPUs, all others were zero.
>=20
> (5) Repeated step (2). The bytes listed this time were different.
>=20
> (6) Issued "virsh qemu-monitor-command ovmf.rhel7 --hmp 'info
> vm-generation-id", and compared the output against the bytes dumped
> (with crash) from guest memory, in step 5. They were a match.
>=20
> So, to me it seems like the SCI is injected, and the memory contents =
are
> changed.
>=20
> ---*---
>=20
> Windows Server 2012 R2 test:
>=20
> (7) booted the guest similarly with '-device vmgenid=3Dauto' via
> <qemu:arg> in the domain XML.
>=20
> (8) Initial check from the host side:
>=20
> $ virsh qemu-monitor-command ovmf.win2012r2.q35 \
>    --hmp 'info vm-generation-id'
> a3f7c334-7dc4-4694-8b8f-abf52abb072f
>=20
> (9) Verifying the same from within, using Vadim's program (note: I
> logged into the VM with ssh, using Cygwin's SSHD in the guest):
>=20
> $ ./vmgenid.exe
> VmCounterValue: 46947dc4a3f7c334:2f07bb2af5ab8f8b
> 0x34 0xc3 0xf7 0xa3 0xc4 0x7d 0x94 0x46 0x8b 0x8f 0xab 0xf5 0x2a 0xbb
> 0x07 0x2f
>=20
> This is a match, so the initial setup works. (Look only at the raw =
byte
> dump in the second line -- it matches the Little Endian UUID
> representation as specified in the SMBIOS spec!)
>=20
> (10) Logged out of the guest (with ssh), cycled through "virsh
> managedsave" and "virsh start" for the domain, logged back in.
>=20
> (11) in the guest:
>=20
> $ ./vmgenid.exe
> VmCounterValue: 4a12296b382162da:6c00d1a52699b7bd
> 0xda 0x62 0x21 0x38 0x6b 0x29 0x12 0x4a 0xbd 0xb7 0x99 0x26 0xa5 0xd1
> 0x00 0x6c
>=20
> (12) on the host:
>=20
> $ virsh qemu-monitor-command ovmf.win2012r2.q35 \
>      --hmp 'info vm-generation-id'
> 382162da-296b-4a12-bdb7-9926a5d1006c
>=20
> This is again a match. (Again, look only at the raw byte dump from
> vmgenid.exe under (11), and consider the BE/LE conversion for the =
first
> three segments!)
>=20
> (13) Logged out of the guest with ssh, and started Vadim's other =
program
> (vmgenid_wait.exe), this time from a normal CMD window on the GUI. The
> program started, reproduced the above output (seen under (11)), and =
then
> went to sleep (waiting).
>=20
> (14) cycled through "virsh managedsave" and "virsh start" for the =
domain.
>=20
> (15) The domain resumed, and Vadim's vmgenid_wait.exe woke up, =
printing
> (manual transcript):
>=20
> VmCounterValue changed to: 495ba7807ed37772:195d0cff681f7a7
>=20
> Please refer to the following screenshot:
>=20
> =
http://people.redhat.com/~lersek/vmgenid-dd1f68c5-89b0-4458-84fa-de9e3d23f=
4cb/Screenshot_ovmf.win2012r2.q35_2017-02-17_20:34:41.png
>=20
> (16) on the host:
>=20
> $ virsh qemu-monitor-command ovmf.win2012r2.q35 \
>      --hmp 'info vm-generation-id'
>=20
> 7ed37772-a780-495b-a7f7-81f6cfd09501
>=20
> This is again a match. It is not easy to see, because Vadim's
> "vmgenid_wait.exe" does not print the raw byte dump after it wakes up;
> the raw byte dump is only printed before it goes to sleep. After =
wakeup,
> it only dumps the composed values. Somewhat more confusingly, the =
64-bit
> hex integers are not zero padded, we'll have to make up for that =
manually.
>=20
> So here goes:
>=20
>   [A]      [B]  [C]  [D]  [E]
>   7ed37772-a780-495b-a7f7-81f6cfd09501 (from the host)
>=20
>   [C]  [B]  [A]        [E']         [D']
>   495b a780 7ed37772 : 0195d0cff681 f7a7 (from vmgenid_wait.exe)
>                        ^
>                        zero padding added manually
>=20
> The parts marked with an apostrophe (') are reversed, byte-wise.
>=20
> So, I'm going to have to declare this "working by design".
>=20
> Confirming my earlier Tested-by (same patches as before):
>=20
> Tested-by: Laszlo Ersek <lersek@redhat.com>
>=20
> What could be the difference between Igor's setup and mine? Perhaps =
the
> BIOS? (Again, I used OVMF.)
>=20
> The "managedsave" command of virsh boils down to (see
> "src/qemu/qemu_driver.c" in the libvirt source):
>=20
> qemuDomainManagedSave()
>  qemuDomainSaveInternal()
>    qemuProcessStopCPUs()
>    qemuDomainSaveMemory()
>      qemuDomainSaveHeader()
>      qemuMigrationToFile()
>        qemuMonitorMigrateToFd()
>          ...
>    qemuProcessStop()
>=20
> I capture all traffic between libvirt and the QEMU monitor, and =
between
> libvirt and the QEMU guest agent, in the libvirt log file, as a rule, =
so
> I can paste the relevant lines:
>=20
> Libvirt sending the file descriptor to QEMU:
>=20
> 2017-02-17 19:31:54.305+0000: 16586: debug :
> qemuMonitorJSONCommandWithFd:296 : Send command
> =
'{"execute":"getfd","arguments":{"fdname":"migrate"},"id":"libvirt-30"}'
> for write with FD 26
>=20
> Libvirt starting the migration:
>=20
> 2017-02-17 19:31:54.306+0000: 16586: debug :
> qemuMonitorJSONCommandWithFd:296 : Send command
> =
'{"execute":"migrate","arguments":{"detach":true,"blk":false,"inc":false,"=
uri":"fd:migrate"},"id":"libvirt-31"}'
> for write with FD -1
>=20
> Then loading it:
>=20
> 2017-02-17 19:32:02.083+0000: 16585: debug :
> qemuMonitorJSONCommandWithFd:296 : Send command
> =
'{"execute":"migrate-incoming","arguments":{"uri":"fd:25"},"id":"libvirt-1=
7"}'
> for write with FD -1
>=20
> I don't have the slightest idea why it failed for Igor -- I can only
> suspect the SeaBIOS patches.
>=20
> Note that in the SeaBIOS discussion, Ben mentioned that he wasn't
> actually seeing the fw_cfg writes in QEMU on the S3 resume path, =
despite
> SeaBIOS attempting them. So, perhaps, is there a bug in the latest
> SeaBIOS patches that prevent fw_cfg writes completely, even on the
> normal boot path? That would be consistent with Igor's results: the
> initial download works (hence the first GUID can be seen), but then =
the
> update does not work (because QEMU has not received the address).
>=20
> Thanks
> Laszlo

My functional testing was also successful.  I did make the one SeaBIOS =
change suggested by Laszlo, which I=E2=80=99ll post in a minute as v5.

In my case, I used a Windows 2012R2 VM that is a fully-joined Active =
Directory Domain Controller, so was able to query some VM Generation =
ID-derived data via power shell.  This use case is the reason why VM =
Generation ID exists in the first place.
We manage the VM using libvirt with this extra snippet in the domain =
XML:

  <qemu:commandline>
    <qemu:arg value=3D'-device'/>
    <qemu:arg value=3D'vmgenid,guid=3Dauto'/>
  </qemu:commandline>

The commands I used within Windows are:

1.  repadmin /showrepl
	This shows the replication state of the Domain Controller, most =
importantly printing the =E2=80=9CDSA invocation ID=E2=80=9D.  This =
number is derived from VM Generation ID, and changes whenever Active =
Directory considers its local data dirty.  It=E2=80=99s an indicator the =
Windows detected a change in VM Generation ID.

2.  (Get-ADObject <x500 stuff> -server <domain controller> -property =
meds-generationid).=E2=80=99msds-generationid=E2=80=99
	This gets the least-significant 64 bits of the VM Generation ID =
GUID
=09
	http://blogs.metcorpconsulting.com/tech/?p=3D1594


Initial State:
=3D=3D=3D=3D=3D=3D=3D=3D=3D

virsh # qemu-monitor-command --hmp 20 info vm-generation-id
d43edc6c-9686-4bf3-8621-2a4be879eb22

PS C:\Users\bran> (Get-ADObject "cn=3Dwhiteharbor,ou=3DDomain =
Controllers,DC=3Dthenorth,dc=3Dws" -server whiteharbor.thenorth.ws
 -property msds-generationid).'msds-generationid'
108
220
62
212
134
150
243
75

***
NOTE:  108,220,62,212,212,134,150,243,75 =3D=3D 6c,dc,3e,d4,86,96,f3,4b  =
=3D=3D> The GUID shown in HMP in Little-endian format!
***

PS C:\Users\bran> repadmin /showrepl

Repadmin: running command /showrepl against full DC localhost
Default-First-Site-Name\WHITEHARBOR
DSA Options: IS_GC
Site Options: (none)
DSA object GUID: 3dcfed54-28d4-448e-9087-140dd251e1b4
DSA invocationID: 56ca3644-8bc3-4dd8-9860-df0b3f5ce06f

Reboot within Windows:
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Nothing changed


After virsh save, virsh restore:
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

virsh # qemu-monitor-command --hmp 22 info vm-generation-id
573a0dbc-6eca-49fd-a632-f4f1e016502a

PS C:\Users\bran> (Get-ADObject "cn=3Dwhiteharbor,ou=3DDomain =
Controllers,DC=3Dthenorth,dc=3Dws" -server whiteharbor.thenorth.ws
 -property msds-generationid).'msds-generationid'
188
13
58
87
202
110
253
73
PS C:\Users\bran> repadmin /showrepl

Repadmin: running command /showrepl against full DC localhost
Default-First-Site-Name\WHITEHARBOR
DSA Options: IS_GC
Site Options: (none)
DSA object GUID: 3dcfed54-28d4-448e-9087-140dd251e1b4
DSA invocationID: 7b6dda08-d23b-4ca2-982d-774f9c214442


I=E2=80=99m satisfied that the current patches work and don=E2=80=99t =
really understand Igor=E2=80=99s failure, other than maybe the SeaBIOS =
difference.

regards,
Ben



--Apple-Mail=_C8ACC45F-56C7-4310-B8FF-4E5CAA7DB845
Content-Disposition: attachment;
	filename=smime.p7s
Content-Type: application/pkcs7-signature;
	name=smime.p7s
Content-Transfer-Encoding: base64

MIAGCSqGSIb3DQEHAqCAMIACAQExCzAJBgUrDgMCGgUAMIAGCSqGSIb3DQEHAQAAoIIJ+zCCBK8w
ggOXoAMCAQICEQDgI8sVEoNTia1hbnpUZ2shMA0GCSqGSIb3DQEBCwUAMG8xCzAJBgNVBAYTAlNF
MRQwEgYDVQQKEwtBZGRUcnVzdCBBQjEmMCQGA1UECxMdQWRkVHJ1c3QgRXh0ZXJuYWwgVFRQIE5l
dHdvcmsxIjAgBgNVBAMTGUFkZFRydXN0IEV4dGVybmFsIENBIFJvb3QwHhcNMTQxMjIyMDAwMDAw
WhcNMjAwNTMwMTA0ODM4WjCBmzELMAkGA1UEBhMCR0IxGzAZBgNVBAgTEkdyZWF0ZXIgTWFuY2hl
c3RlcjEQMA4GA1UEBxMHU2FsZm9yZDEaMBgGA1UEChMRQ09NT0RPIENBIExpbWl0ZWQxQTA/BgNV
BAMTOENPTU9ETyBTSEEtMjU2IENsaWVudCBBdXRoZW50aWNhdGlvbiBhbmQgU2VjdXJlIEVtYWls
IENBMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAibEN2npTGU5wUh28VqYGJre4SeCW
51Gr8fBaE0kVo7SMG2C8elFCp3mMpCLfF2FOkdV2IwoU00oCf7YdCYBupQQ92bq7Fv6hh6kuQ1JD
FnyvMlDIpk9a6QjYz5MlnHuI6DBk5qT4VoD9KiQUMxeZrETlaYujRgZLwjPU6UCfBrCxrJNAubUI
kzqcKlOjENs9IGE8VQOO2U52JQIhKfqjfHF2T+7hX4Hp+1SA28N7NVK3hN4iPSwwLTF/Wb1SN7Az
aS1D6/rWpfGXd2dRjNnuJ+u8pQc4doykqTj/34z1A6xJvsr3c5k6DzKrnJU6Ez0ORjpXdGFQvsZA
P8vk4p+iIQIDAQABo4IBFzCCARMwHwYDVR0jBBgwFoAUrb2YejS0Jvf6xCZU7wO94CTLVBowHQYD
VR0OBBYEFJJha4LhoqCqT+xn8cKj97SAAMHsMA4GA1UdDwEB/wQEAwIBhjASBgNVHRMBAf8ECDAG
AQH/AgEAMB0GA1UdJQQWMBQGCCsGAQUFBwMCBggrBgEFBQcDBDARBgNVHSAECjAIMAYGBFUdIAAw
RAYDVR0fBD0wOzA5oDegNYYzaHR0cDovL2NybC51c2VydHJ1c3QuY29tL0FkZFRydXN0RXh0ZXJu
YWxDQVJvb3QuY3JsMDUGCCsGAQUFBwEBBCkwJzAlBggrBgEFBQcwAYYZaHR0cDovL29jc3AudXNl
cnRydXN0LmNvbTANBgkqhkiG9w0BAQsFAAOCAQEAGypurFXBOquIxdjtzVXzqmthK8AJECOZD8Vm
am+x9bS1d14PAmEA330F/hKzpICAAPz7HVtqcgIKQbwFusFY1SbC6tVNhPv+gpjPWBvjImOcUvi7
BTarfVil3qs7Y+Xa1XPv7OD7e+Kj//BCI5zKto1NPuRLGAOyqC3U2LtCS5BphRDbpjc06HvgARCl
nMo6x59PiDRuimXQGoq7qdzKyjbR9PzCZCk1r9axp3ER0gNDsY8+muyeMlP0dpLKhjQHuSzK5hxK
2JkNwYbikJL7WkJqIyEQ6WXH9dW7fuqMhSACYurROgcsWcWZM/I4ieW26RZ6H3kU9koQGib6fIr7
mzCCBUQwggQsoAMCAQICEQCWOeMVlifzA+PvGfHjMeybMA0GCSqGSIb3DQEBCwUAMIGbMQswCQYD
VQQGEwJHQjEbMBkGA1UECBMSR3JlYXRlciBNYW5jaGVzdGVyMRAwDgYDVQQHEwdTYWxmb3JkMRow
GAYDVQQKExFDT01PRE8gQ0EgTGltaXRlZDFBMD8GA1UEAxM4Q09NT0RPIFNIQS0yNTYgQ2xpZW50
IEF1dGhlbnRpY2F0aW9uIGFuZCBTZWN1cmUgRW1haWwgQ0EwHhcNMTYwNTE5MDAwMDAwWhcNMTcw
NTE5MjM1OTU5WjAnMSUwIwYJKoZIhvcNAQkBFhZiZW5Ac2t5cG9ydHN5c3RlbXMuY29tMIIBIjAN
BgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAryjnKj/3VRzbNXiWAp7RAZSzUCOzDG6WJ2ybuDWP
A7uDl48iX2v3ulbcZq8G0sL1nwGvBdSrmd5X3Qzirx0ti0Qe0mlAd22PEOL/xR5ChLDhNI6i43cM
R1qM1JNtuC5Dz8h2TfYbF/VuKkA1YVuXNguSP8Z1DQXptE1m3yS0gk9LLdDkqq7Vi/zfSmD1NYHN
gEGvtux/3lMp8pHgQiZo8PxKH2Y4zem0AiWtZ9fKZqYWRIhECJ+etvpGvh4dNIj8vdo/ig3uSwLv
ePX7rFz3C5WHOyKjl4VGHNOA5IRZjabp4bdAEIiMPU7lfWt0o4nCRtM/G/6FvFinR6PIHSma1wID
AQABo4IB9DCCAfAwHwYDVR0jBBgwFoAUkmFrguGioKpP7GfxwqP3tIAAwewwHQYDVR0OBBYEFJv6
uT+NCtbUQ0MHZLryEY65oKgbMA4GA1UdDwEB/wQEAwIFoDAMBgNVHRMBAf8EAjAAMCAGA1UdJQQZ
MBcGCCsGAQUFBwMEBgsrBgEEAbIxAQMFAjARBglghkgBhvhCAQEEBAMCBSAwRgYDVR0gBD8wPTA7
BgwrBgEEAbIxAQIBAQEwKzApBggrBgEFBQcCARYdaHR0cHM6Ly9zZWN1cmUuY29tb2RvLm5ldC9D
UFMwXQYDVR0fBFYwVDBSoFCgToZMaHR0cDovL2NybC5jb21vZG9jYS5jb20vQ09NT0RPU0hBMjU2
Q2xpZW50QXV0aGVudGljYXRpb25hbmRTZWN1cmVFbWFpbENBLmNybDCBkAYIKwYBBQUHAQEEgYMw
gYAwWAYIKwYBBQUHMAKGTGh0dHA6Ly9jcnQuY29tb2RvY2EuY29tL0NPTU9ET1NIQTI1NkNsaWVu
dEF1dGhlbnRpY2F0aW9uYW5kU2VjdXJlRW1haWxDQS5jcnQwJAYIKwYBBQUHMAGGGGh0dHA6Ly9v
Y3NwLmNvbW9kb2NhLmNvbTAhBgNVHREEGjAYgRZiZW5Ac2t5cG9ydHN5c3RlbXMuY29tMA0GCSqG
SIb3DQEBCwUAA4IBAQAwVeCMNqTr20+cqsHnSK2AtzxKZyVG9y51wB88lPnRGHe2m+qKGdPgAh/7
iDzEEXsy4sDwHVHVq4kLHW9lX7CvRTxCtmOAtsty5ePhJjh3CX+nsK2HKpi043E6azad6L64DNVN
dMZFwUrUu8dYjOp48TPpIhW13Sbu2t/SOZK4G8EZAaZPX8Dg34tyHRUvM/B/eaJuUgdM5qY2IU+F
7U2K4hBHkhJMJgQ7TyVe8GhdBMaztY4GHqhWP5cCgZBdC9QII8E5jqX7//FbBRB0zVHRVeBZO32H
TvapSOG8ZYd0n5l5j3rBQnLfHWsnQ07rL2+w8W9BBPSZBbciPuwOe3ksMYIDxjCCA8ICAQEwgbEw
gZsxCzAJBgNVBAYTAkdCMRswGQYDVQQIExJHcmVhdGVyIE1hbmNoZXN0ZXIxEDAOBgNVBAcTB1Nh
bGZvcmQxGjAYBgNVBAoTEUNPTU9ETyBDQSBMaW1pdGVkMUEwPwYDVQQDEzhDT01PRE8gU0hBLTI1
NiBDbGllbnQgQXV0aGVudGljYXRpb24gYW5kIFNlY3VyZSBFbWFpbCBDQQIRAJY54xWWJ/MD4+8Z
8eMx7JswCQYFKw4DAhoFAKCCAekwGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkqhkiG9w0B
CQUxDxcNMTcwMjE4MDAxNTQyWjAjBgkqhkiG9w0BCQQxFgQUyT+OkH/DncmnIoHFXQ3Tez/YdTIw
gcIGCSsGAQQBgjcQBDGBtDCBsTCBmzELMAkGA1UEBhMCR0IxGzAZBgNVBAgTEkdyZWF0ZXIgTWFu
Y2hlc3RlcjEQMA4GA1UEBxMHU2FsZm9yZDEaMBgGA1UEChMRQ09NT0RPIENBIExpbWl0ZWQxQTA/
BgNVBAMTOENPTU9ETyBTSEEtMjU2IENsaWVudCBBdXRoZW50aWNhdGlvbiBhbmQgU2VjdXJlIEVt
YWlsIENBAhEAljnjFZYn8wPj7xnx4zHsmzCBxAYLKoZIhvcNAQkQAgsxgbSggbEwgZsxCzAJBgNV
BAYTAkdCMRswGQYDVQQIExJHcmVhdGVyIE1hbmNoZXN0ZXIxEDAOBgNVBAcTB1NhbGZvcmQxGjAY
BgNVBAoTEUNPTU9ETyBDQSBMaW1pdGVkMUEwPwYDVQQDEzhDT01PRE8gU0hBLTI1NiBDbGllbnQg
QXV0aGVudGljYXRpb24gYW5kIFNlY3VyZSBFbWFpbCBDQQIRAJY54xWWJ/MD4+8Z8eMx7JswDQYJ
KoZIhvcNAQEBBQAEggEAesRMaPomJGc8qo7ATSaqTtS0A/XY/ccRtoTMy8Zw+3TVaQOUb+ktYkkh
arGkKQ2oQBgpJZlbBcdgTPK0HD0BNQz8gv8Xe+/qAJrvwmMS1E4PSaRJrFnTVirdhS9MD5DZrn0i
VLQeJdgWqSwHLs2FGW+cJ6RzBGONIl6U0XY9ZLqdRoEXTN0S2Elcc4hvAIDwLUWXx3bGcwajIYIU
VE4lXvGQlaS4ogY26hpETuls0BDYRPI3c/LzsF/2+E6B8I+q88a6cDJALaGLr+TU74G9QImAFCFn
bfv0iNks2HNX8o20moVWPLVxTbsuJ8Wib/Et5GCFYWBJ2ZvnF9jEfVZTMAAAAAAAAA==
--Apple-Mail=_C8ACC45F-56C7-4310-B8FF-4E5CAA7DB845--
