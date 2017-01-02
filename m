Received: from eggs.gnu.org ([2001:4830:134:3::10]:48283)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <harrynjit@gmail.com>) id 1cNvIe-000241-Qb
	for qemu-devel@nongnu.org; Mon, 02 Jan 2017 00:36:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <harrynjit@gmail.com>) id 1cNvIe-0000fi-0h
	for qemu-devel@nongnu.org; Mon, 02 Jan 2017 00:36:48 -0500
Received: from mail-qk0-x22c.google.com ([2607:f8b0:400d:c09::22c]:34224)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <harrynjit@gmail.com>) id 1cNvId-0000en-SX
	for qemu-devel@nongnu.org; Mon, 02 Jan 2017 00:36:47 -0500
Received: by mail-qk0-x22c.google.com with SMTP id h201so203944005qke.1
	for <qemu-devel@nongnu.org>; Sun, 01 Jan 2017 21:36:46 -0800 (PST)
MIME-Version: 1.0
From: Weiwei Jia <harrynjit@gmail.com>
Date: Mon, 2 Jan 2017 00:36:45 -0500
Message-ID: <CA+scX6n=pgc1_rd5Zf_T2mZMSWSZn2Ez85mdaci9VtoaqfbN4Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: [Qemu-devel] Throughput confusion with data plane
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-devel@nongnu.org

Hi,

I run one I/O thread (sequential read 4 KB each time and read 8 GB in
total) in host OS, the throughput is around 420 MB/s. However, when I
run this I/O thread in one VM (no other VM is created and data-plane
is enabled) with dedicated hardware, the throughput will be around 350
MB/s. The VM's experiment setting is as follows.

In the VM, there are 15 vCPUs (vCPU0 - vCPU14); each vCPU is pinned to
corresponding dedicated pCPU (for example, vCPU 0 is pinned to pCPU0
... vCPU 14 is pinned to pCPU 14); "Idle=poll" is added in the VM's
boot grub so that the vCPU will not be idle; in the VM, all the
interrupts are pinned to vCPU0 to guarantee these interrupts can be
responded on time; the I/O thread is executed on one of the vCPU
except vCPU0.

In the host OS, there are 16 pCPUs (pCPU0 - pCPU15); pCPU 0 - pCPU 14
are used for vCPU0 - vCPU 14 in the VM dedicatedly; pCPU 15 is used by
QEMU IOthread (data-plane) to handle I/O read requests from VM
dedicatedly.

Kernel version: 3.16.39
QEMU version: 2.4.1


I don't know why there is 70 MB/s difference between host OS and guest
OS as above experiment. Does anyone have same experiences? Any
comments? Thank you in advance.

BTW, I have checked several times about my hardware configuration and
I think the throughput difference as above should be related to QEMU.
Maybe, I miss any configuration about QEMU.


Best,
Weiwei Jia
