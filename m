Received: from eggs.gnu.org ([2001:4830:134:3::10]:58403)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Dahir.Osman@windriver.com>) id 1cHuWD-0007zA-LH
	for qemu-devel@nongnu.org; Fri, 16 Dec 2016 10:34:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Dahir.Osman@windriver.com>) id 1cHuW7-0008Aq-9k
	for qemu-devel@nongnu.org; Fri, 16 Dec 2016 10:33:57 -0500
Received: from mail5.windriver.com ([192.103.53.11]:48366 helo=mail5.wrs.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <Dahir.Osman@windriver.com>)
	id 1cHuW6-000890-TC
	for qemu-devel@nongnu.org; Fri, 16 Dec 2016 10:33:51 -0500
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail5.wrs.com (8.15.2/8.15.2) with ESMTPS id uBGFXk8O019756
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=OK)
	for <qemu-devel@nongnu.org>; Fri, 16 Dec 2016 07:33:47 -0800
From: "Osman, Dahir" <Dahir.Osman@windriver.com>
Date: Fri, 16 Dec 2016 15:33:43 +0000
Message-ID: <AD37E09707B87D4C9082212028D72B3EC295F2FC@ALA-MBA.corp.ad.wrs.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Qemu-devel] Issue with librte_vhost backed virtio and device
 plug/unplug
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

Hi,

We are using dpdk's librte_vhost for the vhost-user backend of Virtio.

If the guest's memory map changes after the virtio device was started, qemu=
 can
send the vhost-user backend a VHOST_USER_SET_MEM_TABLE message.=20
=20
We observed this case in the following scenarios:=20
=20
    - We have a PCI passthrough or SR-IOV device along with a virtio device=
 and=20
      we do a suspend/resume.   We see the extra VHOST_USER_SET_MEM_TABLE o=
n the=20
      suspend and on the resume.

    - We plug/unplug a device while the VM is running.=20

DPDK's librte_vhost removes the device from the dataplane so it can update =
the=20
device with the new memory map. It also removes the old mapping and remaps =
the=20
new guest memory.

We observed 2 issues after this scenario:

    - The vhost-user backend needs a new VHOST_SET_VRING_ADDR so it can upd=
ate=20
      its qemu VA to vhost VA translation based on the new memory map.

    - The vhost-user backend needs a way to re-start the device.

Below is the librte_vhost library logs.

-------
#INTIAL VM START

2016-12-14T16:49:38.000 info VHOST_CONFIG:vhost_user.c:903: read message VH=
OST_USER_SET_VRING_ENABLE
2016-12-14T16:49:38.000 info VHOST_CONFIG:vhost_user.c:720: set queue enabl=
e: 1 to qp idx: 0
2016-12-14T16:49:38.000 info VHOST_CONFIG:vhost_user.c:903: read message VH=
OST_USER_SET_VRING_ENABLE
2016-12-14T16:49:38.000 info VHOST_CONFIG:vhost_user.c:720: set queue enabl=
e: 1 to qp idx: 0
2016-12-14T16:49:38.000 info VHOST_CONFIG:vhost_user.c:903: read message VH=
OST_USER_SET_VRING_ENABLE
2016-12-14T16:49:38.000 info VHOST_CONFIG:vhost_user.c:720: set queue enabl=
e: 1 to qp idx: 1
2016-12-14T16:49:38.000 info VHOST_CONFIG:vhost_user.c:903: read message VH=
OST_USER_SET_VRING_ENABLE
2016-12-14T16:49:38.000 info VHOST_CONFIG:vhost_user.c:720: set queue enabl=
e: 1 to qp idx: 1
2016-12-14T16:49:38.000 info VHOST_CONFIG:vhost_user.c:903: read message VH=
OST_USER_SET_VRING_CALL
2016-12-14T16:49:38.000 info VHOST_CONFIG:vhost_user.c:627: vring call idx:=
0 file:36
2016-12-14T16:49:38.000 info VHOST_CONFIG:vhost_user.c:903: read message VH=
OST_USER_SET_VRING_CALL
2016-12-14T16:49:38.000 info VHOST_CONFIG:vhost_user.c:627: vring call idx:=
0 file:32
2016-12-14T16:49:38.000 info VHOST_CONFIG:vhost_user.c:903: read message VH=
OST_USER_SET_VRING_CALL
2016-12-14T16:49:38.000 info VHOST_CONFIG:vhost_user.c:627: vring call idx:=
1 file:34
2016-12-14T16:49:38.000 info VHOST_CONFIG:vhost_user.c:903: read message VH=
OST_USER_SET_VRING_CALL
2016-12-14T16:49:38.000 info VHOST_CONFIG:vhost_user.c:627: vring call idx:=
1 file:33
2016-12-14T16:49:38.000 info VHOST_CONFIG:vhost_user.c:903: read message VH=
OST_USER_SET_FEATURES
2016-12-14T16:49:38.000 info VHOST_CONFIG:vhost_user.c:903: read message VH=
OST_USER_SET_FEATURES
2016-12-14T16:49:38.000 info VHOST_CONFIG:vhost_user.c:903: read message VH=
OST_USER_SET_MEM_TABLE
2016-12-14T16:49:38.000 info VHOST_CONFIG:vhost_user.c:570: guest memory re=
gion 0, size: 0xa0000
	 guest physical addr: 0x0
	 guest virtual  addr: 0x2aaaaac00000
	 host  virtual  addr: 0x2aaaaac00000
	 mmap addr : 0x2aaaaac00000
	 mmap size : 0x200000
	 mmap align: 0x200000
	 mmap off  : 0x0
2016-12-14T16:49:38.000 info VHOST_CONFIG:vhost_user.c:570: guest memory re=
gion 1, size: 0x1ff40000
	 guest physical addr: 0xc0000
	 guest virtual  addr: 0x2aaaaacc0000
	 host  virtual  addr: 0x2aaaaaec0000
	 mmap addr : 0x2aaaaae00000
	 mmap size : 0x20000000
	 mmap align: 0x200000
	 mmap off  : 0xc0000
2016-12-14T16:49:38.000 info VHOST_CONFIG:vhost_user.c:903: read message VH=
OST_USER_SET_MEM_TABLE
2016-12-14T16:49:38.000 info VHOST_CONFIG:vhost_user.c:570: guest memory re=
gion 0, size: 0xa0000
	 guest physical addr: 0x0
	 guest virtual  addr: 0x2aaaaac00000
	 host  virtual  addr: 0x2aaacae00000
	 mmap addr : 0x2aaacae00000
	 mmap size : 0x200000
	 mmap align: 0x200000
	 mmap off  : 0x0
2016-12-14T16:49:38.000 info VHOST_CONFIG:vhost_user.c:570: guest memory re=
gion 1, size: 0x1ff40000
	 guest physical addr: 0xc0000
	 guest virtual  addr: 0x2aaaaacc0000
	 host  virtual  addr: 0x2aaacb0c0000
	 mmap addr : 0x2aaacb000000
	 mmap size : 0x20000000
	 mmap align: 0x200000
	 mmap off  : 0xc0000
2016-12-14T16:49:38.000 info VHOST_CONFIG:vhost_user.c:903: read message VH=
OST_USER_SET_VRING_NUM
2016-12-14T16:49:38.000 info VHOST_CONFIG:vhost_user.c:903: read message VH=
OST_USER_SET_VRING_NUM
2016-12-14T16:49:38.000 info VHOST_CONFIG:vhost_user.c:903: read message VH=
OST_USER_SET_VRING_BASE
2016-12-14T16:49:38.000 info VHOST_CONFIG:vhost_user.c:903: read message VH=
OST_USER_SET_VRING_BASE
2016-12-14T16:49:38.000 info VHOST_CONFIG:vhost_user.c:903: read message VH=
OST_USER_SET_VRING_ADDR
2016-12-14T16:49:38.000 info VHOST_CONFIG:vhost_user.c:361: (0) mapped addr=
ess desc: 0x2aaaca698000 -> 0x2aaaca898000
2016-12-14T16:49:38.000 info VHOST_CONFIG:vhost_user.c:363: (0) mapped addr=
ess avail: 0x2aaaca69a000 -> 0x2aaaca89a000
2016-12-14T16:49:38.000 info VHOST_CONFIG:vhost_user.c:365: (0) mapped addr=
ess used: 0x2aaaca69b000 -> 0x2aaaca89b000
2016-12-14T16:49:38.000 info VHOST_CONFIG:vhost_user.c:367: (0) log_guest_a=
ddr: 1fa9b000
2016-12-14T16:49:38.000 info VHOST_CONFIG:vhost_user.c:903: read message VH=
OST_USER_SET_VRING_ADDR
2016-12-14T16:49:38.000 info VHOST_CONFIG:vhost_user.c:361: (1) mapped addr=
ess desc: 0x2aaaca7a8000 -> 0x2aaaeaba8000
2016-12-14T16:49:38.000 info VHOST_CONFIG:vhost_user.c:363: (1) mapped addr=
ess avail: 0x2aaaca7aa000 -> 0x2aaaeabaa000
2016-12-14T16:49:38.000 info VHOST_CONFIG:vhost_user.c:365: (1) mapped addr=
ess used: 0x2aaaca7ab000 -> 0x2aaaeabab000
2016-12-14T16:49:38.000 info VHOST_CONFIG:vhost_user.c:367: (1) log_guest_a=
ddr: 1fbab000
2016-12-14T16:49:38.000 info VHOST_CONFIG:vhost_user.c:903: read message VH=
OST_USER_SET_VRING_KICK
2016-12-14T16:49:38.000 info VHOST_CONFIG:vhost_user.c:664: vring kick idx:=
0 file:40
2016-12-14T16:49:38.000 info VHOST_CONFIG:vhost_user.c:604: virtio is not r=
eady for processing.
2016-12-14T16:49:38.000 info VHOST_CONFIG:vhost_user.c:903: read message VH=
OST_USER_SET_VRING_KICK
2016-12-14T16:49:38.000 info VHOST_CONFIG:vhost_user.c:664: vring kick idx:=
0 file:41
2016-12-14T16:49:38.000 info VHOST_CONFIG:vhost_user.c:604: virtio is not r=
eady for processing.
2016-12-14T16:49:38.000 info VHOST_CONFIG:vhost_user.c:903: read message VH=
OST_USER_SET_VRING_NUM
2016-12-14T16:49:38.000 info VHOST_CONFIG:vhost_user.c:903: read message VH=
OST_USER_SET_VRING_NUM
2016-12-14T16:49:38.000 info VHOST_CONFIG:vhost_user.c:903: read message VH=
OST_USER_SET_VRING_BASE
2016-12-14T16:49:38.000 info VHOST_CONFIG:vhost_user.c:903: read message VH=
OST_USER_SET_VRING_BASE
2016-12-14T16:49:38.000 info VHOST_CONFIG:vhost_user.c:903: read message VH=
OST_USER_SET_VRING_ADDR
2016-12-14T16:49:38.000 info VHOST_CONFIG:vhost_user.c:361: (0) mapped addr=
ess desc: 0x2aaaca6a8000 -> 0x2aaaca8a8000
2016-12-14T16:49:38.000 info VHOST_CONFIG:vhost_user.c:363: (0) mapped addr=
ess avail: 0x2aaaca6aa000 -> 0x2aaaca8aa000
2016-12-14T16:49:38.000 info VHOST_CONFIG:vhost_user.c:365: (0) mapped addr=
ess used: 0x2aaaca6ab000 -> 0x2aaaca8ab000
2016-12-14T16:49:38.000 info VHOST_CONFIG:vhost_user.c:367: (0) log_guest_a=
ddr: 1faab000
2016-12-14T16:49:38.000 info VHOST_CONFIG:vhost_user.c:903: read message VH=
OST_USER_SET_VRING_ADDR
2016-12-14T16:49:38.000 info VHOST_CONFIG:vhost_user.c:361: (1) mapped addr=
ess desc: 0x2aaaca7b0000 -> 0x2aaaeabb0000
2016-12-14T16:49:38.000 info VHOST_CONFIG:vhost_user.c:363: (1) mapped addr=
ess avail: 0x2aaaca7b2000 -> 0x2aaaeabb2000
2016-12-14T16:49:38.000 info VHOST_CONFIG:vhost_user.c:365: (1) mapped addr=
ess used: 0x2aaaca7b3000 -> 0x2aaaeabb3000
2016-12-14T16:49:38.000 info VHOST_CONFIG:vhost_user.c:367: (1) log_guest_a=
ddr: 1fbb3000
2016-12-14T16:49:38.000 info VHOST_CONFIG:vhost_user.c:903: read message VH=
OST_USER_SET_VRING_KICK
2016-12-14T16:49:38.000 info VHOST_CONFIG:vhost_user.c:664: vring kick idx:=
1 file:42
2016-12-14T16:49:38.000 info VHOST_CONFIG:vhost_user.c:610: virtio is now r=
eady for processing.
2016-12-14T16:49:38.000 info VHOST_CONFIG:vhost_user.c:903: read message VH=
OST_USER_SET_VRING_KICK
2016-12-14T16:49:38.000 info VHOST_CONFIG:vhost_user.c:664: vring kick idx:=
1 file:43
2016-12-14T16:49:38.000 info VHOST_CONFIG:vhost_user.c:610: virtio is now r=
eady for processing.
2016-12-14T16:49:38.000 info VHOST_CONFIG:vhost_user.c:903: read message VH=
OST_USER_SET_VRING_ENABLE
2016-12-14T16:49:38.000 info VHOST_CONFIG:vhost_user.c:720: set queue enabl=
e: 1 to qp idx: 0
2016-12-14T16:49:38.000 info VHOST_CONFIG:vhost_user.c:903: read message VH=
OST_USER_SET_VRING_ENABLE
2016-12-14T16:49:38.000 info VHOST_CONFIG:vhost_user.c:720: set queue enabl=
e: 1 to qp idx: 0
2016-12-14T16:49:38.000 info VHOST_CONFIG:vhost_user.c:903: read message VH=
OST_USER_SET_VRING_ENABLE
2016-12-14T16:49:38.000 info VHOST_CONFIG:vhost_user.c:720: set queue enabl=
e: 1 to qp idx: 1
2016-12-14T16:49:38.000 info VHOST_CONFIG:vhost_user.c:903: read message VH=
OST_USER_SET_VRING_ENABLE
2016-12-14T16:49:38.000 info VHOST_CONFIG:vhost_user.c:720: set queue enabl=
e: 1 to qp idx: 1

# VM SUSPEND
2016-12-14T16:53:27.000 info VHOST_CONFIG:vhost_user.c:903: read message VH=
OST_USER_SET_MEM_TABLE
2016-12-14T16:53:27.000 info VHOST_CONFIG:vhost_user.c:570: guest memory re=
gion 0, size: 0xa0000
	 guest physical addr: 0x0
	 guest virtual  addr: 0x2aaaaac00000
	 host  virtual  addr: 0x2aaaaac00000
	 mmap addr : 0x2aaaaac00000
	 mmap size : 0x200000
	 mmap align: 0x200000
	 mmap off  : 0x0
2016-12-14T16:53:27.000 info VHOST_CONFIG:vhost_user.c:570: guest memory re=
gion 1, size: 0x1ff40000
	 guest physical addr: 0xc0000
	 guest virtual  addr: 0x2aaaaacc0000
	 host  virtual  addr: 0x2aaaeb0c0000
	 mmap addr : 0x2aaaeb000000
	 mmap size : 0x20000000
	 mmap align: 0x200000
	 mmap off  : 0xc0000
2016-12-14T16:53:27.000 info VHOST_CONFIG:vhost_user.c:903: read message VH=
OST_USER_SET_MEM_TABLE
2016-12-14T16:53:27.000 info VHOST_CONFIG:vhost_user.c:570: guest memory re=
gion 0, size: 0xa0000
	 guest physical addr: 0x0
	 guest virtual  addr: 0x2aaaaac00000
	 host  virtual  addr: 0x2aaaaae00000
	 mmap addr : 0x2aaaaae00000
	 mmap size : 0x200000
	 mmap align: 0x200000
	 mmap off  : 0x0
2016-12-14T16:53:27.000 info VHOST_CONFIG:vhost_user.c:570: guest memory re=
gion 1, size: 0x1ff40000
	 guest physical addr: 0xc0000
	 guest virtual  addr: 0x2aaaaacc0000
	 host  virtual  addr: 0x2aaaab0c0000
	 mmap addr : 0x2aaaab000000
	 mmap size : 0x20000000
	 mmap align: 0x200000
	 mmap off  : 0xc0000
2016-12-14T16:53:27.000 info VHOST_CONFIG:vhost_user.c:903: read message VH=
OST_USER_SET_MEM_TABLE
2016-12-14T16:53:27.000 info VHOST_CONFIG:vhost_user.c:570: guest memory re=
gion 0, size: 0xa0000
	 guest physical addr: 0x0
	 guest virtual  addr: 0x2aaaaac00000
	 host  virtual  addr: 0x2aaacb000000
	 mmap addr : 0x2aaacb000000
	 mmap size : 0x200000
	 mmap align: 0x200000
	 mmap off  : 0x0
2016-12-14T16:53:27.000 info VHOST_CONFIG:vhost_user.c:570: guest memory re=
gion 1, size: 0x1ff40000
	 guest physical addr: 0xc0000
	 guest virtual  addr: 0x2aaaaacc0000
	 host  virtual  addr: 0x2aaacb2c0000
	 mmap addr : 0x2aaacb200000
	 mmap size : 0x20000000
	 mmap align: 0x200000
	 mmap off  : 0xc0000
2016-12-14T16:53:27.000 info VHOST_CONFIG:vhost_user.c:903: read message VH=
OST_USER_SET_MEM_TABLE
2016-12-14T16:53:27.000 info VHOST_CONFIG:vhost_user.c:570: guest memory re=
gion 0, size: 0xa0000
	 guest physical addr: 0x0
	 guest virtual  addr: 0x2aaaaac00000
	 host  virtual  addr: 0x2aaaaac00000
	 mmap addr : 0x2aaaaac00000
	 mmap size : 0x200000
	 mmap align: 0x200000
	 mmap off  : 0x0
2016-12-14T16:53:27.000 info VHOST_CONFIG:vhost_user.c:570: guest memory re=
gion 1, size: 0x1ff40000
	 guest physical addr: 0xc0000
	 guest virtual  addr: 0x2aaaaacc0000
	 host  virtual  addr: 0x2aaaaaec0000
	 mmap addr : 0x2aaaaae00000
	 mmap size : 0x20000000
	 mmap align: 0x200000
	 mmap off  : 0xc0000
2016-12-14T16:53:27.000 info VHOST_CONFIG:vhost_user.c:903: read message VH=
OST_USER_GET_VRING_BASE
2016-12-14T16:53:27.000 info VHOST_CONFIG:vhost_user.c:694: vring base idx:=
0 file:34
2016-12-14T16:53:27.000 info VHOST_CONFIG:vhost_user.c:903: read message VH=
OST_USER_GET_VRING_BASE
2016-12-14T16:53:27.000 info VHOST_CONFIG:vhost_user.c:694: vring base idx:=
1 file:0
2016-12-14T16:53:27.000 info VHOST_CONFIG:vhost_user.c:903: read message VH=
OST_USER_SET_VRING_ENABLE
2016-12-14T16:53:27.000 info VHOST_CONFIG:vhost_user.c:720: set queue enabl=
e: 0 to qp idx: 0
2016-12-14T16:53:27.000 info VHOST_CONFIG:vhost_user.c:903: read message VH=
OST_USER_SET_VRING_ENABLE
2016-12-14T16:53:27.000 info VHOST_CONFIG:vhost_user.c:720: set queue enabl=
e: 0 to qp idx: 1
2016-12-14T16:53:27.000 info VHOST_CONFIG:vhost_user.c:903: read message VH=
OST_USER_SET_VRING_CALL
2016-12-14T16:53:27.000 info VHOST_CONFIG:vhost_user.c:627: vring call idx:=
0 file:35
2016-12-14T16:53:27.000 info VHOST_CONFIG:vhost_user.c:903: read message VH=
OST_USER_SET_VRING_CALL
2016-12-14T16:53:27.000 info VHOST_CONFIG:vhost_user.c:627: vring call idx:=
1 file:32
2016-12-14T16:53:27.000 info VHOST_CONFIG:vhost_user.c:903: read message VH=
OST_USER_GET_VRING_BASE
2016-12-14T16:53:27.000 info VHOST_CONFIG:vhost_user.c:694: vring base idx:=
0 file:86
2016-12-14T16:53:27.000 info VHOST_CONFIG:vhost_user.c:903: read message VH=
OST_USER_GET_VRING_BASE
2016-12-14T16:53:27.000 info VHOST_CONFIG:vhost_user.c:694: vring base idx:=
1 file:33
2016-12-14T16:53:27.000 info VHOST_CONFIG:vhost_user.c:903: read message VH=
OST_USER_SET_VRING_ENABLE
2016-12-14T16:53:27.000 info VHOST_CONFIG:vhost_user.c:720: set queue enabl=
e: 0 to qp idx: 0
2016-12-14T16:53:27.000 info VHOST_CONFIG:vhost_user.c:903: read message VH=
OST_USER_SET_VRING_ENABLE
2016-12-14T16:53:27.000 info VHOST_CONFIG:vhost_user.c:720: set queue enabl=
e: 0 to qp idx: 1
2016-12-14T16:53:27.000 info VHOST_CONFIG:vhost_user.c:903: read message VH=
OST_USER_SET_VRING_CALL
2016-12-14T16:53:27.000 info VHOST_CONFIG:vhost_user.c:627: vring call idx:=
0 file:33
2016-12-14T16:53:27.000 info VHOST_CONFIG:vhost_user.c:903: read message VH=
OST_USER_SET_VRING_CALL
2016-12-14T16:53:27.000 info VHOST_CONFIG:vhost_user.c:627: vring call idx:=
1 file:36
2016-12-14T16:53:28.000 controller-0 lldpd[9534]: warning error while recei=
ving frame on ens786f0: Network is down
2016-12-14T16:53:28.000 info VHOST_CONFIG:vhost_user.c:894: vhost peer clos=
ed
2016-12-14T16:53:28.000 info VHOST_CONFIG:vhost_user.c:894: vhost peer clos=
ed

# VM RESUME
2016-12-14T16:53:41.000 info VHOST_CONFIG:socket.c:241: new vhost user conn=
ection is 30
2016-12-14T16:53:41.000 info VHOST_CONFIG:socket.c:210: new device, handle =
is 0
2016-12-14T16:53:41.000 info VHOST_CONFIG:socket.c:241: new vhost user conn=
ection is 31
2016-12-14T16:53:41.000 info VHOST_CONFIG:socket.c:210: new device, handle =
is 1
2016-12-14T16:53:42.000 info VHOST_CONFIG:vhost_user.c:903: read message VH=
OST_USER_GET_FEATURES
2016-12-14T16:53:42.000 info VHOST_CONFIG:vhost_user.c:903: read message VH=
OST_USER_GET_PROTOCOL_FEATURES
2016-12-14T16:53:42.000 info VHOST_CONFIG:vhost_user.c:903: read message VH=
OST_USER_SET_PROTOCOL_FEATURES
2016-12-14T16:53:42.000 info VHOST_CONFIG:vhost_user.c:903: read message VH=
OST_USER_GET_QUEUE_NUM
2016-12-14T16:53:42.000 info VHOST_CONFIG:vhost_user.c:903: read message VH=
OST_USER_SET_OWNER
2016-12-14T16:53:42.000 info VHOST_CONFIG:vhost_user.c:903: read message VH=
OST_USER_GET_FEATURES
2016-12-14T16:53:42.000 info VHOST_CONFIG:vhost_user.c:903: read message VH=
OST_USER_SET_VRING_CALL
2016-12-14T16:53:42.000 info VHOST_CONFIG:vhost_user.c:627: vring call idx:=
0 file:32
2016-12-14T16:53:42.000 info VHOST_CONFIG:vhost_user.c:903: read message VH=
OST_USER_SET_VRING_CALL
2016-12-14T16:53:42.000 info VHOST_CONFIG:vhost_user.c:627: vring call idx:=
1 file:33
2016-12-14T16:53:42.000 info VHOST_CONFIG:vhost_user.c:903: read message VH=
OST_USER_GET_FEATURES
2016-12-14T16:53:42.000 info VHOST_CONFIG:vhost_user.c:903: read message VH=
OST_USER_GET_PROTOCOL_FEATURES
2016-12-14T16:53:42.000 info VHOST_CONFIG:vhost_user.c:903: read message VH=
OST_USER_SET_PROTOCOL_FEATURES
2016-12-14T16:53:42.000 info VHOST_CONFIG:vhost_user.c:903: read message VH=
OST_USER_GET_QUEUE_NUM
2016-12-14T16:53:42.000 info VHOST_CONFIG:vhost_user.c:903: read message VH=
OST_USER_SET_OWNER
2016-12-14T16:53:42.000 info VHOST_CONFIG:vhost_user.c:903: read message VH=
OST_USER_GET_FEATURES
2016-12-14T16:53:42.000 info VHOST_CONFIG:vhost_user.c:903: read message VH=
OST_USER_SET_VRING_CALL
2016-12-14T16:53:42.000 info VHOST_CONFIG:vhost_user.c:627: vring call idx:=
0 file:34
2016-12-14T16:53:42.000 info VHOST_CONFIG:vhost_user.c:903: read message VH=
OST_USER_SET_VRING_CALL
2016-12-14T16:53:42.000 info VHOST_CONFIG:vhost_user.c:627: vring call idx:=
1 file:35
2016-12-14T16:53:42.000 info VHOST_CONFIG:vhost_user.c:903: read message VH=
OST_USER_SET_VRING_ENABLE
2016-12-14T16:53:42.000 info VHOST_CONFIG:vhost_user.c:720: set queue enabl=
e: 1 to qp idx: 0
2016-12-14T16:53:42.000 info VHOST_CONFIG:vhost_user.c:903: read message VH=
OST_USER_SET_VRING_ENABLE
2016-12-14T16:53:42.000 info VHOST_CONFIG:vhost_user.c:720: set queue enabl=
e: 1 to qp idx: 0
2016-12-14T16:53:42.000 info VHOST_CONFIG:vhost_user.c:903: read message VH=
OST_USER_SET_VRING_ENABLE
2016-12-14T16:53:42.000 info VHOST_CONFIG:vhost_user.c:720: set queue enabl=
e: 1 to qp idx: 1
2016-12-14T16:53:42.000 info VHOST_CONFIG:vhost_user.c:903: read message VH=
OST_USER_SET_VRING_ENABLE
2016-12-14T16:53:42.000 info VHOST_CONFIG:vhost_user.c:720: set queue enabl=
e: 1 to qp idx: 1
2016-12-14T16:53:42.000 info VHOST_CONFIG:vhost_user.c:903: read message VH=
OST_USER_SET_VRING_ENABLE
2016-12-14T16:53:42.000 info VHOST_CONFIG:vhost_user.c:720: set queue enabl=
e: 1 to qp idx: 0
2016-12-14T16:53:42.000 info VHOST_CONFIG:vhost_user.c:903: read message VH=
OST_USER_SET_VRING_ENABLE
2016-12-14T16:53:42.000 info VHOST_CONFIG:vhost_user.c:720: set queue enabl=
e: 1 to qp idx: 0
2016-12-14T16:53:42.000 info VHOST_CONFIG:vhost_user.c:903: read message VH=
OST_USER_SET_VRING_ENABLE
2016-12-14T16:53:42.000 info VHOST_CONFIG:vhost_user.c:720: set queue enabl=
e: 1 to qp idx: 1
2016-12-14T16:53:42.000 info VHOST_CONFIG:vhost_user.c:903: read message VH=
OST_USER_SET_VRING_ENABLE
2016-12-14T16:53:42.000 info VHOST_CONFIG:vhost_user.c:720: set queue enabl=
e: 1 to qp idx: 1
2016-12-14T16:53:42.000 info VHOST_CONFIG:vhost_user.c:903: read message VH=
OST_USER_SET_VRING_CALL
2016-12-14T16:53:42.000 info VHOST_CONFIG:vhost_user.c:627: vring call idx:=
0 file:36
2016-12-14T16:53:42.000 info VHOST_CONFIG:vhost_user.c:903: read message VH=
OST_USER_SET_VRING_CALL
2016-12-14T16:53:42.000 info VHOST_CONFIG:vhost_user.c:627: vring call idx:=
1 file:34
2016-12-14T16:53:42.000 info VHOST_CONFIG:vhost_user.c:903: read message VH=
OST_USER_SET_FEATURES
2016-12-14T16:53:42.000 info VHOST_CONFIG:vhost_user.c:903: read message VH=
OST_USER_SET_MEM_TABLE
2016-12-14T16:53:42.000 info VHOST_CONFIG:vhost_user.c:570: guest memory re=
gion 0, size: 0x1ff40000
	 guest physical addr: 0xc0000
	 guest virtual  addr: 0x2aaaaacc0000
	 host  virtual  addr: 0x2aaaaacc0000
	 mmap addr : 0x2aaaaac00000
	 mmap size : 0x20000000
	 mmap align: 0x200000
	 mmap off  : 0xc0000
2016-12-14T16:53:42.000 info VHOST_CONFIG:vhost_user.c:570: guest memory re=
gion 1, size: 0xa0000
	 guest physical addr: 0x0
	 guest virtual  addr: 0x2aaaaac00000
	 host  virtual  addr: 0x2aaacac00000
	 mmap addr : 0x2aaacac00000
	 mmap size : 0x200000
	 mmap align: 0x200000
	 mmap off  : 0x0
2016-12-14T16:53:42.000 info VHOST_CONFIG:vhost_user.c:903: read message VH=
OST_USER_SET_VRING_NUM
2016-12-14T16:53:42.000 info VHOST_CONFIG:vhost_user.c:903: read message VH=
OST_USER_SET_VRING_CALL
2016-12-14T16:53:42.000 info VHOST_CONFIG:vhost_user.c:627: vring call idx:=
0 file:38
2016-12-14T16:53:42.000 info VHOST_CONFIG:vhost_user.c:903: read message VH=
OST_USER_SET_VRING_BASE
2016-12-14T16:53:42.000 info VHOST_CONFIG:vhost_user.c:903: read message VH=
OST_USER_SET_VRING_CALL
2016-12-14T16:53:42.000 info VHOST_CONFIG:vhost_user.c:627: vring call idx:=
1 file:32
2016-12-14T16:53:42.000 info VHOST_CONFIG:vhost_user.c:903: read message VH=
OST_USER_SET_VRING_ADDR
2016-12-14T16:53:42.000 info VHOST_CONFIG:vhost_user.c:361: (1) mapped addr=
ess desc: 0x2aaaca7a8000 -> 0x2aaaca7a8000
2016-12-14T16:53:42.000 info VHOST_CONFIG:vhost_user.c:363: (1) mapped addr=
ess avail: 0x2aaaca7aa000 -> 0x2aaaca7aa000
2016-12-14T16:53:42.000 info VHOST_CONFIG:vhost_user.c:365: (1) mapped addr=
ess used: 0x2aaaca7ab000 -> 0x2aaaca7ab000
2016-12-14T16:53:42.000 info VHOST_CONFIG:vhost_user.c:367: (1) log_guest_a=
ddr: 1fbab000
2016-12-14T16:53:42.000 info VHOST_CONFIG:vhost_user.c:903: read message VH=
OST_USER_SET_FEATURES
2016-12-14T16:53:42.000 info VHOST_CONFIG:vhost_user.c:903: read message VH=
OST_USER_SET_VRING_KICK
2016-12-14T16:53:42.000 info VHOST_CONFIG:vhost_user.c:664: vring kick idx:=
0 file:33
2016-12-14T16:53:42.000 info VHOST_CONFIG:vhost_user.c:604: virtio is not r=
eady for processing.
2016-12-14T16:53:42.000 info VHOST_CONFIG:vhost_user.c:903: read message VH=
OST_USER_SET_MEM_TABLE
2016-12-14T16:53:42.000 info VHOST_CONFIG:vhost_user.c:570: guest memory re=
gion 0, size: 0x1ff40000
	 guest physical addr: 0xc0000
	 guest virtual  addr: 0x2aaaaacc0000
	 host  virtual  addr: 0x2aaacaec0000
	 mmap addr : 0x2aaacae00000
	 mmap size : 0x20000000
	 mmap align: 0x200000
	 mmap off  : 0xc0000
2016-12-14T16:53:42.000 info VHOST_CONFIG:vhost_user.c:570: guest memory re=
gion 1, size: 0xa0000
	 guest physical addr: 0x0
	 guest virtual  addr: 0x2aaaaac00000
	 host  virtual  addr: 0x2aaaeae00000
	 mmap addr : 0x2aaaeae00000
	 mmap size : 0x200000
	 mmap align: 0x200000
	 mmap off  : 0x0
2016-12-14T16:53:42.000 info VHOST_CONFIG:vhost_user.c:903: read message VH=
OST_USER_SET_VRING_NUM
2016-12-14T16:53:42.000 info VHOST_CONFIG:vhost_user.c:903: read message VH=
OST_USER_SET_VRING_NUM
2016-12-14T16:53:42.000 info VHOST_CONFIG:vhost_user.c:903: read message VH=
OST_USER_SET_VRING_BASE
2016-12-14T16:53:42.000 info VHOST_CONFIG:vhost_user.c:903: read message VH=
OST_USER_SET_VRING_BASE
2016-12-14T16:53:42.000 info VHOST_CONFIG:vhost_user.c:903: read message VH=
OST_USER_SET_VRING_ADDR
2016-12-14T16:53:42.000 info VHOST_CONFIG:vhost_user.c:361: (1) mapped addr=
ess desc: 0x2aaaca7b0000 -> 0x2aaaca7b0000
2016-12-14T16:53:42.000 info VHOST_CONFIG:vhost_user.c:363: (1) mapped addr=
ess avail: 0x2aaaca7b2000 -> 0x2aaaca7b2000
2016-12-14T16:53:42.000 info VHOST_CONFIG:vhost_user.c:365: (1) mapped addr=
ess used: 0x2aaaca7b3000 -> 0x2aaaca7b3000
2016-12-14T16:53:42.000 info VHOST_CONFIG:vhost_user.c:367: (1) log_guest_a=
ddr: 1fbb3000
2016-12-14T16:53:42.000 info VHOST_CONFIG:vhost_user.c:903: read message VH=
OST_USER_SET_VRING_ADDR
2016-12-14T16:53:42.000 info VHOST_CONFIG:vhost_user.c:361: (0) mapped addr=
ess desc: 0x2aaaca698000 -> 0x2aaaea898000
2016-12-14T16:53:42.000 info VHOST_CONFIG:vhost_user.c:363: (0) mapped addr=
ess avail: 0x2aaaca69a000 -> 0x2aaaea89a000
2016-12-14T16:53:42.000 info VHOST_CONFIG:vhost_user.c:365: (0) mapped addr=
ess used: 0x2aaaca69b000 -> 0x2aaaea89b000
2016-12-14T16:53:42.000 info VHOST_CONFIG:vhost_user.c:367: (0) log_guest_a=
ddr: 1fa9b000
2016-12-14T16:53:42.000 info VHOST_CONFIG:vhost_user.c:903: read message VH=
OST_USER_SET_VRING_KICK
2016-12-14T16:53:42.000 info VHOST_CONFIG:vhost_user.c:664: vring kick idx:=
1 file:41
2016-12-14T16:53:42.000 info VHOST_CONFIG:vhost_user.c:610: virtio is now r=
eady for processing.
2016-12-14T16:53:42.000 info VHOST_CONFIG:vhost_user.c:903: read message VH=
OST_USER_SET_VRING_KICK
2016-12-14T16:53:42.000 info VHOST_CONFIG:vhost_user.c:664: vring kick idx:=
0 file:42
2016-12-14T16:53:42.000 info VHOST_CONFIG:vhost_user.c:604: virtio is not r=
eady for processing.
2016-12-14T16:53:42.000 info VHOST_CONFIG:vhost_user.c:903: read message VH=
OST_USER_SET_VRING_ENABLE
2016-12-14T16:53:42.000 info VHOST_CONFIG:vhost_user.c:720: set queue enabl=
e: 1 to qp idx: 0
2016-12-14T16:53:42.000 info VHOST_CONFIG:vhost_user.c:903: read message VH=
OST_USER_SET_VRING_NUM
2016-12-14T16:53:42.000 info VHOST_CONFIG:vhost_user.c:903: read message VH=
OST_USER_SET_VRING_ENABLE
2016-12-14T16:53:42.000 info VHOST_CONFIG:vhost_user.c:720: set queue enabl=
e: 1 to qp idx: 1
2016-12-14T16:53:42.000 info VHOST_CONFIG:vhost_user.c:903: read message VH=
OST_USER_SET_VRING_BASE
2016-12-14T16:53:42.000 info VHOST_CONFIG:vhost_user.c:903: read message VH=
OST_USER_SET_VRING_ADDR
2016-12-14T16:53:42.000 info VHOST_CONFIG:vhost_user.c:361: (0) mapped addr=
ess desc: 0x2aaaca6a8000 -> 0x2aaaea8a8000
2016-12-14T16:53:42.000 info VHOST_CONFIG:vhost_user.c:363: (0) mapped addr=
ess avail: 0x2aaaca6aa000 -> 0x2aaaea8aa000
2016-12-14T16:53:42.000 info VHOST_CONFIG:vhost_user.c:365: (0) mapped addr=
ess used: 0x2aaaca6ab000 -> 0x2aaaea8ab000
2016-12-14T16:53:42.000 info VHOST_CONFIG:vhost_user.c:367: (0) log_guest_a=
ddr: 1faab000
2016-12-14T16:53:42.000 info VHOST_CONFIG:vhost_user.c:903: read message VH=
OST_USER_SET_VRING_KICK
2016-12-14T16:53:42.000 info VHOST_CONFIG:vhost_user.c:664: vring kick idx:=
1 file:43
2016-12-14T16:53:42.000 info VHOST_CONFIG:vhost_user.c:610: virtio is now r=
eady for processing.
2016-12-14T16:53:42.000 info VHOST_CONFIG:vhost_user.c:903: read message VH=
OST_USER_SET_VRING_ENABLE
2016-12-14T16:53:42.000 info VHOST_CONFIG:vhost_user.c:720: set queue enabl=
e: 1 to qp idx: 0
2016-12-14T16:53:42.000 info VHOST_CONFIG:vhost_user.c:903: read message VH=
OST_USER_SET_VRING_ENABLE
2016-12-14T16:53:42.000 info VHOST_CONFIG:vhost_user.c:720: set queue enabl=
e: 1 to qp idx: 1
2016-12-14T16:53:42.000 info VHOST_CONFIG:vhost_user.c:903: read message VH=
OST_USER_SEND_RARP
2016-12-14T16:53:42.000 info VHOST_CONFIG:vhost_user.c:610: virtio is now r=
eady for processing.
2016-12-14T16:53:42.000 info VHOST_CONFIG:vhost_user.c:903: read message VH=
OST_USER_SEND_RARP
2016-12-14T16:53:42.000 info VHOST_CONFIG:vhost_user.c:610: virtio is now r=
eady for processing.
2016-12-14T16:53:42.000 info VHOST_CONFIG:vhost_user.c:903: read message VH=
OST_USER_SEND_RARP
2016-12-14T16:53:42.000 info VHOST_CONFIG:vhost_user.c:610: virtio is now r=
eady for processing.
2016-12-14T16:53:42.000 info VHOST_CONFIG:vhost_user.c:903: read message VH=
OST_USER_SEND_RARP
2016-12-14T16:53:42.000 info VHOST_CONFIG:vhost_user.c:610: virtio is now r=
eady for processing.
2016-12-14T16:53:42.000 info VHOST_CONFIG:vhost_user.c:903: read message VH=
OST_USER_SET_MEM_TABLE
2016-12-14T16:53:42.000 info VHOST_CONFIG:vhost_user.c:570: guest memory re=
gion 0, size: 0x1ff40000
	 guest physical addr: 0xc0000
	 guest virtual  addr: 0x2aaaaacc0000
	 host  virtual  addr: 0x2aaacaec0000
	 mmap addr : 0x2aaacae00000
	 mmap size : 0x20000000
	 mmap align: 0x200000
	 mmap off  : 0xc0000
2016-12-14T16:53:42.000 info VHOST_CONFIG:vhost_user.c:570: guest memory re=
gion 1, size: 0xa0000
	 guest physical addr: 0x0
	 guest virtual  addr: 0x2aaaaac00000
	 host  virtual  addr: 0x2aaaeae00000
	 mmap addr : 0x2aaaeae00000
	 mmap size : 0x200000
	 mmap align: 0x200000
	 mmap off  : 0x0
2016-12-14T16:53:42.000 info VHOST_CONFIG:vhost_user.c:903: read message VH=
OST_USER_SET_MEM_TABLE
2016-12-14T16:53:42.000 info VHOST_CONFIG:vhost_user.c:570: guest memory re=
gion 0, size: 0x1ff40000
	 guest physical addr: 0xc0000
	 guest virtual  addr: 0x2aaaaacc0000
	 host  virtual  addr: 0x2aaaaacc0000
	 mmap addr : 0x2aaaaac00000
	 mmap size : 0x20000000
	 mmap align: 0x200000
	 mmap off  : 0xc0000
2016-12-14T16:53:42.000 info VHOST_CONFIG:vhost_user.c:570: guest memory re=
gion 1, size: 0xa0000
	 guest physical addr: 0x0
	 guest virtual  addr: 0x2aaaaac00000
	 host  virtual  addr: 0x2aaaeb000000
	 mmap addr : 0x2aaaeb000000
	 mmap size : 0x200000
	 mmap align: 0x200000
	 mmap off  : 0x0
2016-12-14T16:53:42.000 info VHOST_CONFIG:vhost_user.c:903: read message VH=
OST_USER_SET_MEM_TABLE
2016-12-14T16:53:42.000 info VHOST_CONFIG:vhost_user.c:570: guest memory re=
gion 0, size: 0x1ff40000
	 guest physical addr: 0xc0000
	 guest virtual  addr: 0x2aaaaacc0000
	 host  virtual  addr: 0x2aaacacc0000
	 mmap addr : 0x2aaacac00000
	 mmap size : 0x20000000
	 mmap align: 0x200000
	 mmap off  : 0xc0000
2016-12-14T16:53:42.000 info VHOST_CONFIG:vhost_user.c:570: guest memory re=
gion 1, size: 0xa0000
	 guest physical addr: 0x0
	 guest virtual  addr: 0x2aaaaac00000
	 host  virtual  addr: 0x2aaaeac00000
	 mmap addr : 0x2aaaeac00000
	 mmap size : 0x200000
	 mmap align: 0x200000
	 mmap off  : 0x0
2016-12-14T16:53:42.000 info VHOST_CONFIG:vhost_user.c:903: read message VH=
OST_USER_SET_MEM_TABLE
2016-12-14T16:53:42.000 info VHOST_CONFIG:vhost_user.c:570: guest memory re=
gion 0, size: 0x1ff40000
	 guest physical addr: 0xc0000
	 guest virtual  addr: 0x2aaaaacc0000
	 host  virtual  addr: 0x2aaaeaec0000
	 mmap addr : 0x2aaaeae00000
	 mmap size : 0x20000000
	 mmap align: 0x200000
	 mmap off  : 0xc0000
2016-12-14T16:53:42.000 info VHOST_CONFIG:vhost_user.c:570: guest memory re=
gion 1, size: 0xa0000
	 guest physical addr: 0x0
	 guest virtual  addr: 0x2aaaaac00000
	 host  virtual  addr: 0x2aaaaac00000
	 mmap addr : 0x2aaaaac00000
	 mmap size : 0x200000
	 mmap align: 0x200000
	 mmap off  : 0x0
-------

Dahir -
