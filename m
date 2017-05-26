Received: from eggs.gnu.org ([2001:4830:134:3::10]:53900)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1dEC26-0005Lo-ME
	for qemu-devel@nongnu.org; Fri, 26 May 2017 05:59:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1dEC22-0001GZ-DB
	for qemu-devel@nongnu.org; Fri, 26 May 2017 05:59:46 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:4002)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1dEC21-0001F3-Pu
	for qemu-devel@nongnu.org; Fri, 26 May 2017 05:59:42 -0400
From: "Gonglei (Arei)" <arei.gonglei@huawei.com>
Date: Fri, 26 May 2017 09:59:02 +0000
Message-ID: <33183CC9F5247A488A2544077AF19020DA2B906D@DGGEMA505-MBX.china.huawei.com>
Content-Language: zh-CN
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Qemu-devel] [RFC] Is it useful to create a seperate address space
 for cpu-memory on x86 platform?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, "peter.crosthwaite@xilinx.com" <peter.crosthwaite@xilinx.com>, "peter.maydell@linaro.org" <peter.maydell@linaro.org>, "edgar.iglesias@xilinx.com" <edgar.iglesias@xilinx.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "Huangweidong (C)" <weidong.huang@huawei.com>

Hi all,

I found that the memory consumption increase about 5M since below commit on=
 Qemu process.

commit 6731d864f80938e404dc3e5eb7f6b76b891e3e43
Author: Peter Crosthwaite <peter.crosthwaite@xilinx.com>
Date:   Thu Jan 21 14:15:06 2016 +0000

    qom/cpu: Add MemoryRegion property
   =20
    Add a MemoryRegion property, which if set is used to construct
    the CPU's initial (default) AddressSpace.
   =20
    Signed-off-by: Peter Crosthwaite <peter.crosthwaite@xilinx.com>
    [PMM: code is moved from qom/cpu.c to exec.c to avoid having to
     make qom/cpu.o be a non-common object file; code to use the
     MemoryRegion and to default it to system_memory added.]
    Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
    Acked-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>

The result before this commit:

linux-arei:/mnt/sdb/gonglei/opensource/qemu # ps aux|grep qemu
root     12658 17.2  0.0 375996 21412 pts/1    Sl+  12:53   0:00 ./x86_64-s=
oftmmu/qemu-system-x86_64 -machine pc-i440fx-2.5,accel=3Dkvm,usb=3Doff -nod=
efaults

after the commit:
=20
linux-arei:/mnt/sdb/gonglei/opensource/qemu # ps aux|grep qemu
root     23201 17.2  0.0 384196 25736 pts/1    Sl+  12:54   0:00 ./x86_64-s=
oftmmu/qemu-system-x86_64 -machine pc-i440fx-2.5,accel=3Dkvm,usb=3Doff -nod=
efaults

I couldn't find any benefits on x86 platform (I'm not familiar with ARM), a=
m I missing something?

And It works well if I revert this commit. Can I?

Thanks,
-Gonglei
