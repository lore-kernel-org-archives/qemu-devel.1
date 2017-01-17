Received: from eggs.gnu.org ([2001:4830:134:3::10]:48165)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <douly.fnst@cn.fujitsu.com>) id 1cTUya-000274-T7
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 09:43:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <douly.fnst@cn.fujitsu.com>) id 1cTUyV-0001ar-Pz
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 09:43:08 -0500
Received: from [59.151.112.132] (port=22898 helo=heian.cn.fujitsu.com)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <douly.fnst@cn.fujitsu.com>) id 1cTUyV-0001RO-Ck
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 09:43:03 -0500
From: Dou Liyang <douly.fnst@cn.fujitsu.com>
Date: Tue, 17 Jan 2017 22:42:30 +0800
Message-ID: <1484664152-24446-1-git-send-email-douly.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH 0/2] vl: Ensure two functions in the
 appropriate location
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: stefanha@redhat.com, ehabkost@redhat.com, pbonzini@redhat.com, armbru@redhat.com, eblake@redhat.com
Cc: qemu-devel@nongnu.org, izumi.taku@jp.fujitsu.com, caoj.fnst@cn.fujitsu.com, fanc.fnst@cn.fujitsu.com, Dou Liyang <douly.fnst@cn.fujitsu.com>

I found and try to fix a bug, which shows below.

[Problem]
---------

As I use this command:
./x86_64-softmmu/qemu-system-x86_64 \
	-hda /image/fedora.img \
	-m 1G,slots=4,maxmem=4G \
	-enable-kvm \
	-smp 2,maxcpus=8,sockets=2,cores=2,threads=2 \
	-device qemu64-x86_64-cpu,id=cpu1,socket-id=0,core-id=1,thread-id=0 \
	-device qemu64-x86_64-cpu,id=cpu2,socket-id=0,core-id=1,thread-id=1 \
	-device qemu64-x86_64-cpu,id=cpu3,socket-id=1,core-id=0,thread-id=0 \
	-device qemu64-x86_64-cpu,id=cpu4,socket-id=1,core-id=0,thread-id=1 \
	-device qemu64-x86_64-cpu,id=cpu5,socket-id=1,core-id=1,thread-id=0 \
	-device qemu64-x86_64-cpu,id=cpu6,socket-id=1,core-id=1,thread-id=1 \
	-numa node,nodeid=0,cpus=0-1 \
	-numa node,nodeid=1,cpus=2-3 \
	-numa node,nodeid=2,cpus=4-5 \
	-numa node,nodeid=3,cpus=6-7 \
	-monitor stdio \

In Qemu monitor:

(qemu) info numa

4 nodes
node 0 cpus: 0 1 2 3 4 5 6 7
node 0 size: 256 MB
node 1 cpus:
node 1 size: 256 MB
node 2 cpus:
node 2 size: 256 MB
node 3 cpus:
node 3 size: 256 MB

* It is amazing that the cpus are all in node one. *

Then, I used the "numactl -H" in the guest, and found that the mapping is
right. So I guess it is not big problem, may has some bugs in the initialization.
I followed the initialization process and found it out. 

[Solution]
----------

Ensure the numa_post_machine_init func in the appropriate location.

After the patches:

(qemu) info numa 
4 nodes
node 0 cpus: 0 1
node 0 size: 256 MB
node 1 cpus: 2 3
node 1 size: 256 MB
node 2 cpus: 4 5
node 2 size: 256 MB
node 3 cpus: 6 7
node 3 size: 256 MB

Dou Liyang (2):
  vl: Ensure the numa_post_machine_init func in the appropriate location
  vl: Ensure the cpu_synchronize_all_post_init func in the appropriate
    location

 vl.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

-- 
2.5.5
