Received: from eggs.gnu.org ([2001:4830:134:3::10]:39456)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <douly.fnst@cn.fujitsu.com>) id 1dHmpG-0005UR-5m
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 03:53:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <douly.fnst@cn.fujitsu.com>) id 1dHmpD-00013M-36
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 03:53:22 -0400
Received: from [59.151.112.132] (port=43759 helo=heian.cn.fujitsu.com)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <douly.fnst@cn.fujitsu.com>) id 1dHmpC-0000uB-MC
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 03:53:19 -0400
From: Dou Liyang <douly.fnst@cn.fujitsu.com>
Message-ID: <1ee3ccf0-2d91-86ec-628c-d50ae3ffbe22@cn.fujitsu.com>
Date: Mon, 5 Jun 2017 15:53:02 +0800
MIME-Version: 1.0
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] Memory Hotplug : Does QEmu support cold-plugged memory?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel <qemu-devel@nongnu.org>
Cc: Eduardo Habkost <ehabkost@redhat.com>, Igor Mammedov <imammedo@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Andrew Jones <drjones@redhat.com>, Thomas Huth <thuth@redhat.com>

Hi all,

I want to boot up a system with some removable memory.

So, i used '-object' and '-device' to cold-plug memory
in QEmu as following :

./x86_64-softmmu/qemu-system-x86_64 \
	...
	-object memory-backend-ram,id=mem3,size=128M \
	-device pc-dimm,id=dimm3,memdev=mem3 \
	...

then i want to hot-remove this memory by 'device-del' and
'object-del'.

But, unfortunately, I can't remove the memory device.

And, in guest OS, I found the memory's removable feature is 0,
But, in QEmu monitor with 'info memory-devices', I found the
hotplugged is false and hotpluggable is true.

Could you help me:

1, Can the ram based memory-backend be plugged like above?

2, Does the 'info memory-devices' command show a wrong info?

3, Can file memory backend(memory-backend-file) be cold-plugged?


PS: here is my whole script:
----
gdb --arg ./x86_64-softmmu/qemu-system-x86_64 \
	-hda /image/fedora.img \
	-m 256M,slots=4,maxmem=1G \
	-enable-kvm \
	-smp 2,maxcpus=16,sockets=2,cores=2,threads=2\
	-object memory-backend-ram,id=mem1,size=128M \
	-object memory-backend-ram,id=mem2,size=128M \
	-object memory-backend-ram,id=mem3,size=128M \
	-device pc-dimm,id=dimm3,memdev=mem3 \
	-device qemu64-x86_64-cpu,id=cpu2,socket-id=0,core-id=1,thread-id=0 \
	-device qemu64-x86_64-cpu,id=cpu3,socket-id=0,core-id=1,thread-id=1 \
	-numa node,memdev=mem1,nodeid=0 \
	-numa node,memdev=mem2,nodeid=1 \
	-serial stdio \
	-monitor telnet:127.0.0.1:4444,server,nowait \
	-kernel /home/douly/openSource/orignal_linux/arch/x86_64/boot/bzImage \
	-append "root=/dev/mapper/fedora_s3101490-root mem=256M movable_node 
nokaslr earlyprintk=serial,ttyS0,115200" \
	-initrd /home/douly/openSource/initramfs_image/4.12.0-rc3.img \
----

Thanks,
	dou.
