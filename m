Received: from eggs.gnu.org ([2001:4830:134:3::10]:41762)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <danielhb@linux.vnet.ibm.com>) id 1edxza-0005V3-Bn
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 07:48:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <danielhb@linux.vnet.ibm.com>) id 1edxzX-0003K3-4H
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 07:47:58 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:57756)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <danielhb@linux.vnet.ibm.com>)
	id 1edxzW-0003JZ-RO
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 07:47:55 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w0NCkFPi101515
	for <qemu-devel@nongnu.org>; Tue, 23 Jan 2018 07:47:52 -0500
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2fp2wae93c-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 23 Jan 2018 07:47:51 -0500
Received: from localhost
	by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <danielhb@linux.vnet.ibm.com>;
	Tue, 23 Jan 2018 07:47:50 -0500
References: <20180123030528.GA5780@pacoca>
	<20180123123404.GA3765@pacoca.br.ibm.com>
From: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
Date: Tue, 23 Jan 2018 10:47:45 -0200
MIME-Version: 1.0
In-Reply-To: <20180123123404.GA3765@pacoca.br.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Message-Id: <2db504dd-fe54-b3e7-6121-ef5f6d6dd74a@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] virtio block device is not working
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: joserz@linux.vnet.ibm.com, ghammer@redhat.com, mst@redhat.com
Cc: qemu-devel@nongnu.org

Yeah, the problem looks like in virtio-pci-net. This is the output when=20
running in a Power 9
host:

sudo ./qemu-system-ppc64 -nographic -vga none -m 4G -M pseries,accel=3Dkv=
m=20
-netdev type=3Duser,id=3Dnet0 -device virtio-net-pci,netdev=3Dnet0


SLOF ********************************************************************=
**
QEMU Starting
 =C2=A0Build Date =3D Dec 18 2017 13:08:00
 =C2=A0FW Version =3D git-fa981320a1e0968d
 =C2=A0Press "s" to enter Open Firmware.

Populating /vdevice methods
Populating /vdevice/vty@71000000
Populating /vdevice/nvram@71000001
Populating /vdevice/v-scsi@71000002
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 SCSI: Looking for devices
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 8200000000000000 =
CD-ROM=C2=A0=C2=A0 : "QEMU=C2=A0=C2=A0=C2=A0=C2=A0 QEMU CD-ROM 2.5+"
Populating /pci@800000020000000
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 00 0000 (D) : 1af4 1000=C2=
=A0=C2=A0=C2=A0 virtio [ net ]
Aborted


As Ziviani mentioned, reverting 4fe6d78b2e fixes it:


$ git diff
diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 071f4f5..f290f48 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -812,10 +812,6 @@ static void kvm_mem_ioeventfd_del(MemoryListener=20
*listener,
 =C2=A0=C2=A0=C2=A0=C2=A0 if (r < 0) {
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 abort();
 =C2=A0=C2=A0=C2=A0=C2=A0 }
-
-=C2=A0=C2=A0=C2=A0 if (e->cleanup) {
-=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 e->cleanup(e);
-=C2=A0=C2=A0=C2=A0 }
 =C2=A0}

$ sudo ./qemu-system-ppc64 -nographic -vga none -m 4G -M=20
pseries,accel=3Dkvm -netdev type=3Duser,id=3Dnet0 -device=20
virtio-net-pci,netdev=3Dnet0


SLOF ********************************************************************=
**
QEMU Starting
 =C2=A0Build Date =3D Dec 18 2017 13:08:00
 =C2=A0FW Version =3D git-fa981320a1e0968d
 =C2=A0Press "s" to enter Open Firmware.

Populating /vdevice methods
Populating /vdevice/vty@71000000
Populating /vdevice/nvram@71000001
Populating /vdevice/v-scsi@71000002
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 SCSI: Looking for devices
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 8200000000000000 =
CD-ROM=C2=A0=C2=A0 : "QEMU=C2=A0=C2=A0=C2=A0=C2=A0 QEMU CD-ROM 2.5+"
Populating /pci@800000020000000
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 00 0000 (D) : 1af4 1000=C2=
=A0=C2=A0=C2=A0 virtio [ net ]
No NVRAM common partition, re-initializing...
Scanning USB
Using default console: /vdevice/vty@71000000

 =C2=A0 Welcome to Open Firmware

 =C2=A0 Copyright (c) 2004, 2017 IBM Corporation All rights reserved.
 =C2=A0 This program and the accompanying materials are made available
 =C2=A0 under the terms of the BSD License available at
 =C2=A0 http://www.opensource.org/licenses/bsd-license.php


Trying to load:=C2=A0 from: disk ...
E3405: No such device
Trying to load:=C2=A0 from: /vdevice/v-scsi@71000002/disk@820000000000000=
0=20
... No medium !

E3405: No such device
Trying to load:=C2=A0 from: /pci@800000020000000/ethernet@0 ...
 =C2=A0Initializing NIC
 =C2=A0 Reading MAC address from device: 52:54:00:12:34:56
 =C2=A0 Requesting information via DHCP: done
 =C2=A0 Using IPv4 address: 10.0.2.15
 =C2=A0 Requesting file "" via TFTP from 10.0.2.2
 =C2=A0 Receiving data:=C2=A0 0 KBytes
E3010 (net) TFTP access violation

E3407: Load failed

 =C2=A0 Type 'boot' and press return to continue booting the system.
 =C2=A0 Type 'reset-all' and press return to reboot the system.


Ready!
0 >



On 01/23/2018 10:34 AM, joserz@linux.vnet.ibm.com wrote:
> On Tue, Jan 23, 2018 at 01:05:28AM -0200, joserz@linux.vnet.ibm.com wro=
te:
>> Hello people!
>>
>> I'm not able to boot any guest that sets a virtio block device like:
>> (branch master)
>>
>> [PPC64]
>> qemu-system-ppc64 -cpu POWER8 -nographic -vga none -m 4G -M pseries,ac=
cel=3Dkvm,kvm-type=3DPR -drive file=3Ddisk.qcow2,if=3Dvirtio
> my bad, actually the command line is:
>
> qemu-system-ppc64 -cpu POWER8 -nographic -vga none -m 4G -M pseries,acc=
el=3Dkvm -netdev type=3Duser,id=3Dnet0 -device virtio-net-pci,netdev=3Dne=
t0 -drive file=3D../disk.qcow2,if=3Dvirtio
>
> and the problem seem to be in virtio-net-pci, not in the block device
>
>
>> QEMU Starting
>>   Build Date =3D Dec 18 2017 13:08:00
>>   FW Version =3D git-fa981320a1e0968d
>>   Press "s" to enter Open Firmware.
>>
>> Populating /vdevice methods
>> Populating /vdevice/vty@71000000
>> Populating /vdevice/nvram@71000001
>> Populating /vdevice/v-scsi@71000002
>>         SCSI: Looking for devices
>>            8200000000000000 CD-ROM   : "QEMU     QEMU CD-ROM      2.5+=
"
>> Populating /pci@800000020000000
>>                       00 0000 (D) : 1af4 1000    virtio [ net ]
>> Aborted
>>
>> [x86]
>>
>> qemu-system-x86_64 -m 4G -enable-kvm -drive file=3Dutil.qcow2,if=3Dvir=
tio
>> Running QEMU with GTK 2.x is deprecated, and will be removed
>> in a future release. Please switch to GTK 3.x instead
>> [1]    5282 abort
>>
>> [Cause]
>>
>> The commit 4fe6d78b2e introduces the
>>
>> ...
>> kvm_mem_ioeventfd_del(...) {
>>      ...
>>      r =3D kvm_set_ioeventfd_mmio(fd, ...
>>      if (r < 0) {
>>          abort();
>>      }
>>
>> +    if (e->cleanup) {
>> +        e->cleanup(e);
>> +    }
>> }
>>
>> For some reason, not yet clear to me, cleanup() calls the same
>> kvm_mem_ioeventfd_del again and again until kvm_set_ioeventfd_mmio
>> returns < 0 and abort().
>>
>> I was going to send a patch to revert that 'if ()' but I think it coul=
d
>> cause a regression. What do you guys think?
>>
>> Thanks,
>>
>> Jose Ricardo Ziviani
>>
>>
>
