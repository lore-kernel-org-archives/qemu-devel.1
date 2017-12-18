Received: from eggs.gnu.org ([2001:4830:134:3::10]:60769)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1eR4Az-0003SW-31
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 17:46:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1eR4Au-0000BS-2x
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 17:46:25 -0500
From: David Hildenbrand <david@redhat.com>
Date: Mon, 18 Dec 2017 23:46:14 +0100
Message-Id: <20171218224616.21030-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v1 0/2] s390x/tcg: TEST PROTECTION and memory
 hotplug
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Richard Henderson <rth@twiddle.net>, Alexander Graf <agraf@suse.de>

While trying to fix TCG so I can properly detect memory in kvm-unit-tests
... looks like I accidentally made memory hotplug under TCG work (whoops).

qemu-system-s390x ... -m 2048,maxmem=4096M,slots=4 ...

[root@localhost ~]# cat /proc/meminfo
MemTotal:        4143632 kB
MemFree:         3845248 kB
MemAvailable:    3947932 kB

[root@localhost ~]# lsmem
RANGE                                  SIZE  STATE REMOVABLE BLOCK
0x0000000000000000-0x000000000fffffff  256M online        no     0
0x0000000010000000-0x000000006fffffff  1.5G online       yes   1-6
0x0000000070000000-0x00000000ffffffff  2.3G online        no  7-15

Memory block size:       256M
Total online memory:       4G
Total offline memory:      0B

I am not sure if we want to have memory hotplug in its current form later
on (the guest can hotplug memory itself). This is different compared to
all other architectures. E.g. when booting Fedora 27, it will simply
hotplug and add all memory. This doesn't make any sense in the context of
VMs where you want to be able to control from the outside, when and how
much more memory is given to a VM. But anyhow, seems to work ...


David Hildenbrand (2):
  s390x/tcg: implement TEST PROTECTION
  s390x/sclp: fix missing be conversion

 hw/s390x/sclp.c           |  4 ++--
 target/s390x/helper.h     |  2 +-
 target/s390x/mem_helper.c | 41 +++++++++++++++++++++++++++++++++++++++--
 target/s390x/translate.c  |  2 +-
 4 files changed, 43 insertions(+), 6 deletions(-)

-- 
2.14.3
