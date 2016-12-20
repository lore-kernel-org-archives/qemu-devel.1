Received: from eggs.gnu.org ([2001:4830:134:3::10]:55809)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <douly.fnst@cn.fujitsu.com>) id 1cJH2I-0001RV-F9
	for qemu-devel@nongnu.org; Tue, 20 Dec 2016 04:48:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <douly.fnst@cn.fujitsu.com>) id 1cJH28-0008Df-Nh
	for qemu-devel@nongnu.org; Tue, 20 Dec 2016 04:48:42 -0500
Received: from [59.151.112.132] (port=1328 helo=heian.cn.fujitsu.com)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <douly.fnst@cn.fujitsu.com>) id 1cJH26-00089D-Qh
	for qemu-devel@nongnu.org; Tue, 20 Dec 2016 04:48:32 -0500
References: <1482137486-9843-1-git-send-email-douly.fnst@cn.fujitsu.com>
	<20161219150230.GA20757@stefanha-x1.localdomain>
	<20161219163214.GA9801@lemon>
From: Dou Liyang <douly.fnst@cn.fujitsu.com>
Message-ID: <9fdc9f2d-0af3-0a7e-db9c-ffb98281e6c4@cn.fujitsu.com>
Date: Tue, 20 Dec 2016 17:47:55 +0800
MIME-Version: 1.0
In-Reply-To: <20161219163214.GA9801@lemon>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH RFC v2 0/4] block/qapi: refactor and
 optimize the qmp_query_blockstats()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>
Cc: stefanha@redhat.com, kwolf@redhat.com, armbru@redhat.com, mreitz@redhat.com, eblake@redhat.com, izumi.taku@jp.fujitsu.com, caoj.fnst@cn.fujitsu.com, fanc.fnst@cn.fujitsu.com, qemu-devel@nongnu.org

Hi, Stefan, Fam,

At 12/20/2016 12:32 AM, Fam Zheng wrote:
> On Mon, 12/19 15:02, Stefan Hajnoczi wrote:
>> On Mon, Dec 19, 2016 at 04:51:22PM +0800, Dou Liyang wrote:
>>> These patches aim to refactor the qmp_query_blockstats() and
>>> improve the performance by reducing the running time of it.
>>>
>>> qmp_query_blockstats() is used to monitor the blockstats, it
>>> querys all the graph_bdrv_states or monitor_block_backends.
>>>
>>> There are the two jobs:
>>>
>>> 1 For the performance:
>>>
>>> 1.1 the time it takes(ns) in each time:
>>> the disk numbers     | 10    | 500
>>> -------------------------------------
>>> before these patches | 19429 | 667722
>>> after these patches  | 17516 | 557044
>>>
>>> 1.2 the I/O performance is degraded(%) during the monitor:
>>>
>>> the disk numbers     | 10    | 500
>>> -------------------------------------
>>> before these patches | 1.3   | 14.2
>>> after these patches  | 0.8   | 9.1
>>
>> Do you know what is consuming the remaining 9.1%?
>>

Yes, I guess it's probably because the thread that is assigned to
handles the I/O may compete with the main loop threads for the
system resource in host. They may run in the same cpu in host frequently 
as the limit of resource.

eg: my host have 4 cpus, the guest have 2 vcpus,

before the I/O:
[root@localhost qemu]# ps -eLo ruser,pid,ppid,lwp,psr | grep qemu | grep 
-v grep
qemu     16664     1 16664   1   /* main loop thread in cpu_id: 1*/
qemu     16664     1 16687   3
qemu     16664     1 16690   2  /* vcpu  thread in cpu_id: 2 */
qemu     16664     1 16691   2  /* vcpu  thread in cpu_id: 2 */
qemu     16664     1 16693   3

during the I/O:
[root@localhost qemu]# ps -eLo ruser,pid,ppid,lwp,psr | grep qemu | grep 
-v grep
qemu     16664     1 16664   1   /* main loop thread */
qemu     16664     1 16687   3
qemu     16664     1 16690   2
qemu     16664     1 16691   2
qemu     16664     1 16693   3
qemu     16664     1 19623   1   /* new thread for I/O*/

The reason:

In VirtIO:

the I/O and the command requests both need to be dispatched
by AIO in main loop, As Fam said, the main loop is stalled a
bit.

But In IDE :

the I/O requests is handled by the vcpu threads. it isn't
be disturbed. but its performance also degraded

And below is the script to query blockstats, With the increase of
sleep time (0.5, 1, 2, 4, 6) for decreasing the frequency of query.
At 6s, the performance degradation will disappear.

```
#!/bin/bash

domblkstat(){
	int=1
	while(( $int<=1000 ))
	do
		virsh  domblkstat rhel500
         	let "int++"
		sleep 0.5 # 1,2,4,8 will be set
	done	
}

echo "-----begin-----"
domblkstat
echo "-----end-----"

```

If we want to avoid the performance degradation in this situation, we 
may have to sacrifice the completeness.  it may like this:

  BlockStatsList *qmp_query_blockstats(bool has_query_nodes,
                                       bool query_nodes,
+                                     BlockBackend *query_blk,
                                       Error **errp)
  {
      BlockStatsList *head = NULL, **p_next = &head;

that is what I prepare to do in the next version if this is accepted. :)

>> I'm surprised to see such a high performance impact caused by a QMP
>> command.
>

This may be because the command is always executed with only a few
seconds apart, not just once.


> If it's "performance is 9.1% worse only during the 557044 ns when the QMP
> command is being processed", it's probably becaues the main loop is stalled a
> bit, and it's not a big problem. I'd be very surprised if the degradation is
> more longer than that.
>

Yes it is.

> Fam
>
>>
>> Please post your QEMU command-line.
>
the command-line is long, I use this script to generate, for each 
controller have 6 disks:

```
...
# body
while(($int<=500))
do

ctler=$[int/6+1]
mod=$[int%6]
bus=$[int/100]
ctlslot=$[(int-100*bus)/6+1]

if [ $mod == 0 ]
then
echo "
   <controller type='sata' index='${ctler}'>
      <address type='pci' domain='0x0000' bus='0x0$[bus+2]' 
slot='${ctlslot}' />
   </controller>";

fi


echo "  <disk type='file' device='disk'>
   <driver name='qemu' type='raw' cache='none'/>
     <source file='/home/image/rhel7.0-${int}.qcow2'/>
     <target dev='sd${int}' bus='sata'/>
     <address type='drive' controller='${ctler}' target='0' unit='${mod}'/>
   </disk>"

let "int++"

done
....
```

/usr/local/bin/qemu-system-x86_64 -name rhel500 -S -machine 
pc-i440fx-2.8,accel=kvm,usb=off -cpu Nehalem -m 2048 -realtime mlock=off 
-smp 4,sockets=4,cores=1,threads=1 -uuid 
c6feddc5-3458-444e-9374-5a0d82f4c949 -no-user-config -nodefaults 
-chardev 
socket,id=charmonitor,path=/var/lib/libvirt/qemu/domain-rhel500/monitor.sock,server,nowait 
-mon chardev=charmonitor,id=monitor,mode=control -rtc base=localtime 
-no-shutdown -boot strict=on -device 
pci-bridge,chassis_nr=1,id=pci.1,bus=pci.0,addr=0x2 -device 
pci-bridge,chassis_nr=2,id=pci.2,bus=pci.0,addr=0x3 -device 
pci-bridge,chassis_nr=3,id=pci.3,bus=pci.0,addr=0x4 -device 
pci-bridge,chassis_nr=4,id=pci.4,bus=pci.0,addr=0x5 -device 
pci-bridge,chassis_nr=5,id=pci.5,bus=pci.0,addr=0x6 -device 
pci-bridge,chassis_nr=6,id=pci.6,bus=pci.0,addr=0x8 -device 
piix3-usb-uhci,id=usb,bus=pci.0,addr=0x1.0x2 -device 
ahci,id=sata0,bus=pci.0,addr=0x9 -device 
ahci,id=sata1,bus=pci.2,addr=0x1 -device 
ahci,id=sata2,bus=pci.2,addr=0x2 -device 
ahci,id=sata3,bus=pci.2,addr=0x3 -device 
ahci,id=sata4,bus=pci.2,addr=0x4 -device 
ahci,id=sata5,bus=pci.2,addr=0x5 -device 
ahci,id=sata6,bus=pci.2,addr=0x6 -device 
ahci,id=sata7,bus=pci.2,addr=0x7 -device 
ahci,id=sata8,bus=pci.2,addr=0x8 -device 
ahci,id=sata9,bus=pci.2,addr=0x9 -device 
ahci,id=sata10,bus=pci.2,addr=0xa -device 
ahci,id=sata11,bus=pci.2,addr=0xb -device 
ahci,id=sata12,bus=pci.2,addr=0xc -device 
ahci,id=sata13,bus=pci.2,addr=0xd -device 
ahci,id=sata14,bus=pci.2,addr=0xe -device 
ahci,id=sata15,bus=pci.2,addr=0xf -device 
ahci,id=sata16,bus=pci.2,addr=0x10 -device 
ahci,id=sata17,bus=pci.2,addr=0x11 -device 
ahci,id=sata18,bus=pci.3,addr=0x1 -device 
ahci,id=sata19,bus=pci.3,addr=0x2 -device 
ahci,id=sata20,bus=pci.3,addr=0x3 -device 
ahci,id=sata21,bus=pci.3,addr=0x4 -device 
ahci,id=sata22,bus=pci.3,addr=0x5 -device 
ahci,id=sata23,bus=pci.3,addr=0x6 -device 
ahci,id=sata24,bus=pci.3,addr=0x7 -device 
ahci,id=sata25,bus=pci.3,addr=0x8 -device 
ahci,id=sata26,bus=pci.3,addr=0x9 -device 
ahci,id=sata27,bus=pci.3,addr=0xa -device 
ahci,id=sata28,bus=pci.3,addr=0xb -device 
ahci,id=sata29,bus=pci.3,addr=0xc -device 
ahci,id=sata30,bus=pci.3,addr=0xd -device 
ahci,id=sata31,bus=pci.3,addr=0xe -device 
ahci,id=sata32,bus=pci.3,addr=0xf -device 
ahci,id=sata33,bus=pci.3,addr=0x10 -device 
ahci,id=sata34,bus=pci.3,addr=0x11 -device 
ahci,id=sata35,bus=pci.4,addr=0x1 -device 
ahci,id=sata36,bus=pci.4,addr=0x2 -device 
ahci,id=sata37,bus=pci.4,addr=0x3 -device 
ahci,id=sata38,bus=pci.4,addr=0x4 -device 
ahci,id=sata39,bus=pci.4,addr=0x5 -device 
ahci,id=sata40,bus=pci.4,addr=0x6 -device 
ahci,id=sata41,bus=pci.4,addr=0x7 -device 
ahci,id=sata42,bus=pci.4,addr=0x8 -device 
ahci,id=sata43,bus=pci.4,addr=0x9 -device 
ahci,id=sata44,bus=pci.4,addr=0xa -device 
ahci,id=sata45,bus=pci.4,addr=0xb -device 
ahci,id=sata46,bus=pci.4,addr=0xc -device 
ahci,id=sata47,bus=pci.4,addr=0xd -device 
ahci,id=sata48,bus=pci.4,addr=0xe -device 
ahci,id=sata49,bus=pci.4,addr=0xf -device 
ahci,id=sata50,bus=pci.4,addr=0x10 -device 
ahci,id=sata51,bus=pci.5,addr=0x1 -device 
ahci,id=sata52,bus=pci.5,addr=0x2 -device 
ahci,id=sata53,bus=pci.5,addr=0x3 -device 
ahci,id=sata54,bus=pci.5,addr=0x4 -device 
ahci,id=sata55,bus=pci.5,addr=0x5 -device 
ahci,id=sata56,bus=pci.5,addr=0x6 -device 
ahci,id=sata57,bus=pci.5,addr=0x7 -device 
ahci,id=sata58,bus=pci.5,addr=0x8 -device 
ahci,id=sata59,bus=pci.5,addr=0x9 -device 
ahci,id=sata60,bus=pci.5,addr=0xa -device 
ahci,id=sata61,bus=pci.5,addr=0xb -device 
ahci,id=sata62,bus=pci.5,addr=0xc -device 
ahci,id=sata63,bus=pci.5,addr=0xd -device 
ahci,id=sata64,bus=pci.5,addr=0xe -device 
ahci,id=sata65,bus=pci.5,addr=0xf -device 
ahci,id=sata66,bus=pci.5,addr=0x10 -device 
ahci,id=sata67,bus=pci.5,addr=0x11 -device 
ahci,id=sata68,bus=pci.6,addr=0x1 -device 
ahci,id=sata69,bus=pci.6,addr=0x2 -device 
ahci,id=sata70,bus=pci.6,addr=0x3 -device 
ahci,id=sata71,bus=pci.6,addr=0x4 -device 
ahci,id=sata72,bus=pci.6,addr=0x5 -device 
ahci,id=sata73,bus=pci.6,addr=0x6 -device 
ahci,id=sata74,bus=pci.6,addr=0x7 -device 
ahci,id=sata75,bus=pci.6,addr=0x8 -device 
ahci,id=sata76,bus=pci.6,addr=0x9 -device 
ahci,id=sata77,bus=pci.6,addr=0xa -device 
ahci,id=sata78,bus=pci.6,addr=0xb -device 
ahci,id=sata79,bus=pci.6,addr=0xc -device 
ahci,id=sata80,bus=pci.6,addr=0xd -device 
ahci,id=sata81,bus=pci.6,addr=0xe -device 
ahci,id=sata82,bus=pci.6,addr=0xf -device 
ahci,id=sata83,bus=pci.6,addr=0x10 -device 
ahci,id=sata84,bus=pci.6,addr=0x11 -drive 
file=/var/lib/libvirt/images/rhel7.0.qcow2,if=none,id=drive-ide0-0-1,format=qcow2 
-device 
ide-hd,bus=ide.0,unit=1,drive=drive-ide0-0-1,id=ide0-0-1,bootindex=1 
-drive 
file=/home/image/rhel7.0-1.qcow2,if=none,id=drive-sata1-0-1,format=raw,cache=none 
-device ide-hd,bus=sata1.1,drive=drive-sata1-0-1,id=sata1-0-1 -drive 
file=/home/image/rhel7.0-2.qcow2,if=none,id=drive-sata1-0-2,format=raw,cache=none 
-device ide-hd,bus=sata1.2,drive=drive-sata1-0-2,id=sata1-0-2 -drive 
file=/home/image/rhel7.0-3.qcow2,if=none,id=drive-sata1-0-3,format=raw,cache=none 
-device ide-hd,bus=sata1.3,drive=drive-sata1-0-3,id=sata1-0-3 -drive 
file=/home/image/rhel7.0-4.qcow2,if=none,id=drive-sata1-0-4,format=raw,cache=none 
-device ide-hd,bus=sata1.4,drive=drive-sata1-0-4,id=sata1-0-4 -drive 
file=/home/image/rhel7.0-5.qcow2,if=none,id=drive-sata1-0-5,format=raw,cache=none 
-device ide-hd,bus=sata1.5,drive=drive-sata1-0-5,id=sata1-0-5 -drive 
file=/home/image/rhel7.0-6.qcow2,if=none,id=drive-sata2-0-0,format=raw,cache=none 
-device ide-hd,bus=sata2.0,drive=drive-sata2-0-0,id=sata2-0-0 -drive 
file=/home/image/rhel7.0-7.qcow2,if=none,id=drive-sata2-0-1,format=raw,cache=none 
-device ide-hd,bus=sata2.1,drive=drive-sata2-0-1,id=sata2-0-1 -drive 
file=/home/image/rhel7.0-8.qcow2,if=none,id=drive-sata2-0-2,format=raw,cache=none 
-device ide-hd,bus=sata2.2,drive=drive-sata2-0-2,id=sata2-0-2 -drive 
file=/home/image/rhel7.0-9.qcow2,if=none,id=drive-sata2-0-3,format=raw,cache=none 
-device ide-hd,bus=sata2.3,drive=drive-sata2-0-3,id=sata2-0-3 -drive 
file=/home/image/rhel7.0-10.qcow2,if=none,id=drive-sata2-0-4,format=raw,cache=none 
-device ide-hd,bus=sata2.4,drive=drive-sata2-0-4,id=sata2-0-4 -drive 
file=/home/image/rhel7.0-11.qcow2,if=none,id=drive-sata2-0-5,format=raw,cache=none 
-device ide-hd,bus=sata2.5,drive=drive-sata2-0-5,id=sata2-0-5 -drive 
file=/home/image/rhel7.0-12.qcow2,if=none,id=drive-sata3-0-0,format=raw,cache=none 
-device ide-hd,bus=sata3.0,drive=drive-sata3-0-0,id=sata3-0-0 -drive 
file=/home/image/rhel7.0-13.qcow2,if=none,id=drive-sata3-0-1,format=raw,cache=none 
-device ide-hd,bus=sata3.1,drive=drive-sata3-0-1,id=sata3-0-1 -drive 
file=/home/image/rhel7.0-14.qcow2,if=none,id=drive-sata3-0-2,format=raw,cache=none 
-device ide-hd,bus=sata3.2,drive=drive-sata3-0-2,id=sata3-0-2 -drive 
file=/home/image/rhel7.0-15.qcow2,if=none,id=drive-sata3-0-3,format=raw,cache=none 
-device ide-hd,bus=sata3.3,drive=drive-sata3-0-3,id=sata3-0-3 -drive 
file=/home/image/rhel7.0-16.qcow2,if=none,id=drive-sata3-0-4,format=raw,cache=none 
-device ide-hd,bus=sata3.4,drive=drive-sata3-0-4,id=sata3-0-4 -drive 
file=/home/image/rhel7.0-17.qcow2,if=none,id=drive-sata3-0-5,format=raw,cache=none 
-device ide-hd,bus=sata3.5,drive=drive-sata3-0-5,id=sata3-0-5 -drive 
file=/home/image/rhel7.0-18.qcow2,if=none,id=drive-sata4-0-0,format=raw,cache=none 
-device ide-hd,bus=sata4.0,drive=drive-sata4-0-0,id=sata4-0-0 -drive 
file=/home/image/rhel7.0-19.qcow2,if=none,id=drive-sata4-0-1,format=raw,cache=none 
-device ide-hd,bus=sata4.1,drive=drive-sata4-0-1,id=sata4-0-1 -drive 
file=/home/image/rhel7.0-20.qcow2,if=none,id=drive-sata4-0-2,format=raw,cache=none 
-device ide-hd,bus=sata4.2,drive=drive-sata4-0-2,id=sata4-0-2 -drive 
file=/home/image/rhel7.0-21.qcow2,if=none,id=drive-sata4-0-3,format=raw,cache=none 
-device ide-hd,bus=sata4.3,drive=drive-sata4-0-3,id=sata4-0-3 -drive 
file=/home/image/rhel7.0-22.qcow2,if=none,id=drive-sata4-0-4,format=raw,cache=none 
-device ide-hd,bus=sata4.4,drive=drive-sata4-0-4,id=sata4-0-4 -drive 
file=/home/image/rhel7.0-23.qcow2,if=none,id=drive-sata4-0-5,format=raw,cache=none 
-device ide-hd,bus=sata4.5,drive=drive-sata4-0-5,id=sata4-0-5 -drive 
file=/home/image/rhel7.0-24.qcow2,if=none,id=drive-sata5-0-0,format=raw,cache=none 
-device ide-hd,bus=sata5.0,drive=drive-sata5-0-0,id=sata5-0-0 -drive 
file=/home/image/rhel7.0-25.qcow2,if=none,id=drive-sata5-0-1,format=raw,cache=none 
-device ide-hd,bus=sata5.1,drive=drive-sata5-0-1,id=sata5-0-1 -drive 
file=/home/image/rhel7.0-26.qcow2,if=none,id=drive-sata5-0-2,format=raw,cache=none 
-device ide-hd,bus=sata5.2,drive=drive-sata5-0-2,id=sata5-0-2 -drive 
file=/home/image/rhel7.0-27.qcow2,if=none,id=drive-sata5-0-3,format=raw,cache=none 
-device ide-hd,bus=sata5.3,drive=drive-sata5-0-3,id=sata5-0-3 -drive 
file=/home/image/rhel7.0-28.qcow2,if=none,id=drive-sata5-0-4,format=raw,cache=none 
-device ide-hd,bus=sata5.4,drive=drive-sata5-0-4,id=sata5-0-4 -drive 
file=/home/image/rhel7.0-29.qcow2,if=none,id=drive-sata5-0-5,format=raw,cache=none 
-device ide-hd,bus=sata5.5,drive=drive-sata5-0-5,id=sata5-0-5 -drive 
file=/home/image/rhel7.0-30.qcow2,if=none,id=drive-sata6-0-0,format=raw,cache=none 
-device ide-hd,bus=sata6.0,drive=drive-sata6-0-0,id=sata6-0-0 -drive 
file=/home/image/rhel7.0-31.qcow2,if=none,id=drive-sata6-0-1,format=raw,cache=none 
-device ide-hd,bus=sata6.1,drive=drive-sata6-0-1,id=sata6-0-1 -drive 
file=/home/image/rhel7.0-32.qcow2,if=none,id=drive-sata6-0-2,format=raw,cache=none 
-device ide-hd,bus=sata6.2,drive=drive-sata6-0-2,id=sata6-0-2 -drive 
file=/home/image/rhel7.0-33.qcow2,if=none,id=drive-sata6-0-3,format=raw,cache=none 
-device ide-hd,bus=sata6.3,drive=drive-sata6-0-3,id=sata6-0-3 -drive 
file=/home/image/rhel7.0-34.qcow2,if=none,id=drive-sata6-0-4,format=raw,cache=none 
-device ide-hd,bus=sata6.4,drive=drive-sata6-0-4,id=sata6-0-4 -drive 
file=/home/image/rhel7.0-35.qcow2,if=none,id=drive-sata6-0-5,format=raw,cache=none 
-device ide-hd,bus=sata6.5,drive=drive-sata6-0-5,id=sata6-0-5 -drive 
file=/home/image/rhel7.0-36.qcow2,if=none,id=drive-sata7-0-0,format=raw,cache=none 
-device ide-hd,bus=sata7.0,drive=drive-sata7-0-0,id=sata7-0-0 -drive 
file=/home/image/rhel7.0-37.qcow2,if=none,id=drive-sata7-0-1,format=raw,cache=none 
-device ide-hd,bus=sata7.1,drive=drive-sata7-0-1,id=sata7-0-1 -drive 
file=/home/image/rhel7.0-38.qcow2,if=none,id=drive-sata7-0-2,format=raw,cache=none 
-device ide-hd,bus=sata7.2,drive=drive-sata7-0-2,id=sata7-0-2 -drive 
file=/home/image/rhel7.0-39.qcow2,if=none,id=drive-sata7-0-3,format=raw,cache=none 
-device ide-hd,bus=sata7.3,drive=drive-sata7-0-3,id=sata7-0-3 -drive 
file=/home/image/rhel7.0-40.qcow2,if=none,id=drive-sata7-0-4,format=raw,cache=none 
-device ide-hd,bus=sata7.4,drive=drive-sata7-0-4,id=sata7-0-4 -drive 
file=/home/image/rhel7.0-41.qcow2,if=none,id=drive-sata7-0-5,format=raw,cache=none 
-device ide-hd,bus=sata7.5,drive=drive-sata7-0-5,id=sata7-0-5 -drive 
file=/home/image/rhel7.0-42.qcow2,if=none,id=drive-sata8-0-0,format=raw,cache=none 
-device ide-hd,bus=sata8.0,drive=drive-sata8-0-0,id=sata8-0-0 -drive 
file=/home/image/rhel7.0-43.qcow2,if=none,id=drive-sata8-0-1,format=raw,cache=none 
-device ide-hd,bus=sata8.1,drive=drive-sata8-0-1,id=sata8-0-1 -drive 
file=/home/image/rhel7.0-44.qcow2,if=none,id=drive-sata8-0-2,format=raw,cache=none 
-device ide-hd,bus=sata8.2,drive=drive-sata8-0-2,id=sata8-0-2 -drive 
file=/home/image/rhel7.0-45.qcow2,if=none,id=drive-sata8-0-3,format=raw,cache=none 
-device ide-hd,bus=sata8.3,drive=drive-sata8-0-3,id=sata8-0-3 -drive 
file=/home/image/rhel7.0-46.qcow2,if=none,id=drive-sata8-0-4,format=raw,cache=none 
-device ide-hd,bus=sata8.4,drive=drive-sata8-0-4,id=sata8-0-4 -drive 
file=/home/image/rhel7.0-47.qcow2,if=none,id=drive-sata8-0-5,format=raw,cache=none 
-device ide-hd,bus=sata8.5,drive=drive-sata8-0-5,id=sata8-0-5 -drive 
file=/home/image/rhel7.0-48.qcow2,if=none,id=drive-sata9-0-0,format=raw,cache=none 
-device ide-hd,bus=sata9.0,drive=drive-sata9-0-0,id=sata9-0-0 -drive 
file=/home/image/rhel7.0-49.qcow2,if=none,id=drive-sata9-0-1,format=raw,cache=none 
-device ide-hd,bus=sata9.1,drive=drive-sata9-0-1,id=sata9-0-1 -drive 
file=/home/image/rhel7.0-50.qcow2,if=none,id=drive-sata9-0-2,format=raw,cache=none 
-device ide-hd,bus=sata9.2,drive=drive-sata9-0-2,id=sata9-0-2 -drive 
file=/home/image/rhel7.0-51.qcow2,if=none,id=drive-sata9-0-3,format=raw,cache=none 
-device ide-hd,bus=sata9.3,drive=drive-sata9-0-3,id=sata9-0-3 -drive 
file=/home/image/rhel7.0-52.qcow2,if=none,id=drive-sata9-0-4,format=raw,cache=none 
-device ide-hd,bus=sata9.4,drive=drive-sata9-0-4,id=sata9-0-4 -drive 
file=/home/image/rhel7.0-53.qcow2,if=none,id=drive-sata9-0-5,format=raw,cache=none 
-device ide-hd,bus=sata9.5,drive=drive-sata9-0-5,id=sata9-0-5 -drive 
file=/home/image/rhel7.0-54.qcow2,if=none,id=drive-sata10-0-0,format=raw,cache=none 
-device ide-hd,bus=sata10.0,drive=drive-sata10-0-0,id=sata10-0-0 -drive 
file=/home/image/rhel7.0-55.qcow2,if=none,id=drive-sata10-0-1,format=raw,cache=none 
-device ide-hd,bus=sata10.1,drive=drive-sata10-0-1,id=sata10-0-1 -drive 
file=/home/image/rhel7.0-56.qcow2,if=none,id=drive-sata10-0-2,format=raw,cache=none 
-device ide-hd,bus=sata10.2,drive=drive-sata10-0-2,id=sata10-0-2 -drive 
file=/home/image/rhel7.0-57.qcow2,if=none,id=drive-sata10-0-3,format=raw,cache=none 
-device ide-hd,bus=sata10.3,drive=drive-sata10-0-3,id=sata10-0-3 -drive 
file=/home/image/rhel7.0-58.qcow2,if=none,id=drive-sata10-0-4,format=raw,cache=none 
-device ide-hd,bus=sata10.4,drive=drive-sata10-0-4,id=sata10-0-4 -drive 
file=/home/image/rhel7.0-59.qcow2,if=none,id=drive-sata10-0-5,format=raw,cache=none 
-device ide-hd,bus=sata10.5,drive=drive-sata10-0-5,id=sata10-0-5 -drive 
file=/home/image/rhel7.0-60.qcow2,if=none,id=drive-sata11-0-0,format=raw,cache=none 
-device ide-hd,bus=sata11.0,drive=drive-sata11-0-0,id=sata11-0-0 -drive 
file=/home/image/rhel7.0-61.qcow2,if=none,id=drive-sata11-0-1,format=raw,cache=none 
-device ide-hd,bus=sata11.1,drive=drive-sata11-0-1,id=sata11-0-1 -drive 
file=/home/image/rhel7.0-62.qcow2,if=none,id=drive-sata11-0-2,format=raw,cache=none 
-device ide-hd,bus=sata11.2,drive=drive-sata11-0-2,id=sata11-0-2 -drive 
file=/home/image/rhel7.0-63.qcow2,if=none,id=drive-sata11-0-3,format=raw,cache=none 
-device ide-hd,bus=sata11.3,drive=drive-sata11-0-3,id=sata11-0-3 -drive 
file=/home/image/rhel7.0-64.qcow2,if=none,id=drive-sata11-0-4,format=raw,cache=none 
-device ide-hd,bus=sata11.4,drive=drive-sata11-0-4,id=sata11-0-4 -drive 
file=/home/image/rhel7.0-65.qcow2,if=none,id=drive-sata11-0-5,format=raw,cache=none 
-device ide-hd,bus=sata11.5,drive=drive-sata11-0-5,id=sata11-0-5 -drive 
file=/home/image/rhel7.0-66.qcow2,if=none,id=drive-sata12-0-0,format=raw,cache=none 
-device ide-hd,bus=sata12.0,drive=drive-sata12-0-0,id=sata12-0-0 -drive 
file=/home/image/rhel7.0-67.qcow2,if=none,id=drive-sata12-0-1,format=raw,cache=none 
-device ide-hd,bus=sata12.1,drive=drive-sata12-0-1,id=sata12-0-1 -drive 
file=/home/image/rhel7.0-68.qcow2,if=none,id=drive-sata12-0-2,format=raw,cache=none 
-device ide-hd,bus=sata12.2,drive=drive-sata12-0-2,id=sata12-0-2 -drive 
file=/home/image/rhel7.0-69.qcow2,if=none,id=drive-sata12-0-3,format=raw,cache=none 
-device ide-hd,bus=sata12.3,drive=drive-sata12-0-3,id=sata12-0-3 -drive 
file=/home/image/rhel7.0-70.qcow2,if=none,id=drive-sata12-0-4,format=raw,cache=none 
-device ide-hd,bus=sata12.4,drive=drive-sata12-0-4,id=sata12-0-4 -drive 
file=/home/image/rhel7.0-71.qcow2,if=none,id=drive-sata12-0-5,format=raw,cache=none 
-device ide-hd,bus=sata12.5,drive=drive-sata12-0-5,id=sata12-0-5 -drive 
file=/home/image/rhel7.0-72.qcow2,if=none,id=drive-sata13-0-0,format=raw,cache=none 
-device ide-hd,bus=sata13.0,drive=drive-sata13-0-0,id=sata13-0-0 -drive 
file=/home/image/rhel7.0-73.qcow2,if=none,id=drive-sata13-0-1,format=raw,cache=none 
-device ide-hd,bus=sata13.1,drive=drive-sata13-0-1,id=sata13-0-1 -drive 
file=/home/image/rhel7.0-74.qcow2,if=none,id=drive-sata13-0-2,format=raw,cache=none 
-device ide-hd,bus=sata13.2,drive=drive-sata13-0-2,id=sata13-0-2 -drive 
file=/home/image/rhel7.0-75.qcow2,if=none,id=drive-sata13-0-3,format=raw,cache=none 
-device ide-hd,bus=sata13.3,drive=drive-sata13-0-3,id=sata13-0-3 -drive 
file=/home/image/rhel7.0-76.qcow2,if=none,id=drive-sata13-0-4,format=raw,cache=none 
-device ide-hd,bus=sata13.4,drive=drive-sata13-0-4,id=sata13-0-4 -drive 
file=/home/image/rhel7.0-77.qcow2,if=none,id=drive-sata13-0-5,format=raw,cache=none 
-device ide-hd,bus=sata13.5,drive=drive-sata13-0-5,id=sata13-0-5 -drive 
file=/home/image/rhel7.0-78.qcow2,if=none,id=drive-sata14-0-0,format=raw,cache=none 
-device ide-hd,bus=sata14.0,drive=drive-sata14-0-0,id=sata14-0-0 -drive 
file=/home/image/rhel7.0-79.qcow2,if=none,id=drive-sata14-0-1,format=raw,cache=none 
-device ide-hd,bus=sata14.1,drive=drive-sata14-0-1,id=sata14-0-1 -drive 
file=/home/image/rhel7.0-80.qcow2,if=none,id=drive-sata14-0-2,format=raw,cache=none 
-device ide-hd,bus=sata14.2,drive=drive-sata14-0-2,id=sata14-0-2 -drive 
file=/home/image/rhel7.0-81.qcow2,if=none,id=drive-sata14-0-3,format=raw,cache=none 
-device ide-hd,bus=sata14.3,drive=drive-sata14-0-3,id=sata14-0-3 -drive 
file=/home/image/rhel7.0-82.qcow2,if=none,id=drive-sata14-0-4,format=raw,cache=none 
-device ide-hd,bus=sata14.4,drive=drive-sata14-0-4,id=sata14-0-4 -drive 
file=/home/image/rhel7.0-83.qcow2,if=none,id=drive-sata14-0-5,format=raw,cache=none 
-device ide-hd,bus=sata14.5,drive=drive-sata14-0-5,id=sata14-0-5 -drive 
file=/home/image/rhel7.0-84.qcow2,if=none,id=drive-sata15-0-0,format=raw,cache=none 
-device ide-hd,bus=sata15.0,drive=drive-sata15-0-0,id=sata15-0-0 -drive 
file=/home/image/rhel7.0-85.qcow2,if=none,id=drive-sata15-0-1,format=raw,cache=none 
-device ide-hd,bus=sata15.1,drive=drive-sata15-0-1,id=sata15-0-1 -drive 
file=/home/image/rhel7.0-86.qcow2,if=none,id=drive-sata15-0-2,format=raw,cache=none 
-device ide-hd,bus=sata15.2,drive=drive-sata15-0-2,id=sata15-0-2 -drive 
file=/home/image/rhel7.0-87.qcow2,if=none,id=drive-sata15-0-3,format=raw,cache=none 
-device ide-hd,bus=sata15.3,drive=drive-sata15-0-3,id=sata15-0-3 -drive 
file=/home/image/rhel7.0-88.qcow2,if=none,id=drive-sata15-0-4,format=raw,cache=none 
-device ide-hd,bus=sata15.4,drive=drive-sata15-0-4,id=sata15-0-4 -drive 
file=/home/image/rhel7.0-89.qcow2,if=none,id=drive-sata15-0-5,format=raw,cache=none 
-device ide-hd,bus=sata15.5,drive=drive-sata15-0-5,id=sata15-0-5 -drive 
file=/home/image/rhel7.0-90.qcow2,if=none,id=drive-sata16-0-0,format=raw,cache=none 
-device ide-hd,bus=sata16.0,drive=drive-sata16-0-0,id=sata16-0-0 -drive 
file=/home/image/rhel7.0-91.qcow2,if=none,id=drive-sata16-0-1,format=raw,cache=none 
-device ide-hd,bus=sata16.1,drive=drive-sata16-0-1,id=sata16-0-1 -drive 
file=/home/image/rhel7.0-92.qcow2,if=none,id=drive-sata16-0-2,format=raw,cache=none 
-device ide-hd,bus=sata16.2,drive=drive-sata16-0-2,id=sata16-0-2 -drive 
file=/home/image/rhel7.0-93.qcow2,if=none,id=drive-sata16-0-3,format=raw,cache=none 
-device ide-hd,bus=sata16.3,drive=drive-sata16-0-3,id=sata16-0-3 -drive 
file=/home/image/rhel7.0-94.qcow2,if=none,id=drive-sata16-0-4,format=raw,cache=none 
-device ide-hd,bus=sata16.4,drive=drive-sata16-0-4,id=sata16-0-4 -drive 
file=/home/image/rhel7.0-95.qcow2,if=none,id=drive-sata16-0-5,format=raw,cache=none 
-device ide-hd,bus=sata16.5,drive=drive-sata16-0-5,id=sata16-0-5 -drive 
file=/home/image/rhel7.0-96.qcow2,if=none,id=drive-sata17-0-0,format=raw,cache=none 
-device ide-hd,bus=sata17.0,drive=drive-sata17-0-0,id=sata17-0-0 -drive 
file=/home/image/rhel7.0-97.qcow2,if=none,id=drive-sata17-0-1,format=raw,cache=none 
-device ide-hd,bus=sata17.1,drive=drive-sata17-0-1,id=sata17-0-1 -drive 
file=/home/image/rhel7.0-98.qcow2,if=none,id=drive-sata17-0-2,format=raw,cache=none 
-device ide-hd,bus=sata17.2,drive=drive-sata17-0-2,id=sata17-0-2 -drive 
file=/home/image/rhel7.0-99.qcow2,if=none,id=drive-sata17-0-3,format=raw,cache=none 
-device ide-hd,bus=sata17.3,drive=drive-sata17-0-3,id=sata17-0-3 -drive 
file=/home/image/rhel7.0-100.qcow2,if=none,id=drive-sata17-0-4,format=raw,cache=none 
-device ide-hd,bus=sata17.4,drive=drive-sata17-0-4,id=sata17-0-4 -drive 
file=/home/image/rhel7.0-101.qcow2,if=none,id=drive-sata17-0-5,format=raw,cache=none 
-device ide-hd,bus=sata17.5,drive=drive-sata17-0-5,id=sata17-0-5 -drive 
file=/home/image/rhel7.0-102.qcow2,if=none,id=drive-sata18-0-0,format=raw,cache=none 
-device ide-hd,bus=sata18.0,drive=drive-sata18-0-0,id=sata18-0-0 -drive 
file=/home/image/rhel7.0-103.qcow2,if=none,id=drive-sata18-0-1,format=raw,cache=none 
-device ide-hd,bus=sata18.1,drive=drive-sata18-0-1,id=sata18-0-1 -drive 
file=/home/image/rhel7.0-104.qcow2,if=none,id=drive-sata18-0-2,format=raw,cache=none 
-device ide-hd,bus=sata18.2,drive=drive-sata18-0-2,id=sata18-0-2 -drive 
file=/home/image/rhel7.0-105.qcow2,if=none,id=drive-sata18-0-3,format=raw,cache=none 
-device ide-hd,bus=sata18.3,drive=drive-sata18-0-3,id=sata18-0-3 -drive 
file=/home/image/rhel7.0-106.qcow2,if=none,id=drive-sata18-0-4,format=raw,cache=none 
-device ide-hd,bus=sata18.4,drive=drive-sata18-0-4,id=sata18-0-4 -drive 
file=/home/image/rhel7.0-107.qcow2,if=none,id=drive-sata18-0-5,format=raw,cache=none 
-device ide-hd,bus=sata18.5,drive=drive-sata18-0-5,id=sata18-0-5 -drive 
file=/home/image/rhel7.0-108.qcow2,if=none,id=drive-sata19-0-0,format=raw,cache=none 
-device ide-hd,bus=sata19.0,drive=drive-sata19-0-0,id=sata19-0-0 -drive 
file=/home/image/rhel7.0-109.qcow2,if=none,id=drive-sata19-0-1,format=raw,cache=none 
-device ide-hd,bus=sata19.1,drive=drive-sata19-0-1,id=sata19-0-1 -drive 
file=/home/image/rhel7.0-110.qcow2,if=none,id=drive-sata19-0-2,format=raw,cache=none 
-device ide-hd,bus=sata19.2,drive=drive-sata19-0-2,id=sata19-0-2 -drive 
file=/home/image/rhel7.0-111.qcow2,if=none,id=drive-sata19-0-3,format=raw,cache=none 
-device ide-hd,bus=sata19.3,drive=drive-sata19-0-3,id=sata19-0-3 -drive 
file=/home/image/rhel7.0-112.qcow2,if=none,id=drive-sata19-0-4,format=raw,cache=none 
-device ide-hd,bus=sata19.4,drive=drive-sata19-0-4,id=sata19-0-4 -drive 
file=/home/image/rhel7.0-113.qcow2,if=none,id=drive-sata19-0-5,format=raw,cache=none 
-device ide-hd,bus=sata19.5,drive=drive-sata19-0-5,id=sata19-0-5 -drive 
file=/home/image/rhel7.0-114.qcow2,if=none,id=drive-sata20-0-0,format=raw,cache=none 
-device ide-hd,bus=sata20.0,drive=drive-sata20-0-0,id=sata20-0-0 -drive 
file=/home/image/rhel7.0-115.qcow2,if=none,id=drive-sata20-0-1,format=raw,cache=none 
-device ide-hd,bus=sata20.1,drive=drive-sata20-0-1,id=sata20-0-1 -drive 
file=/home/image/rhel7.0-116.qcow2,if=none,id=drive-sata20-0-2,format=raw,cache=none 
-device ide-hd,bus=sata20.2,drive=drive-sata20-0-2,id=sata20-0-2 -drive 
file=/home/image/rhel7.0-117.qcow2,if=none,id=drive-sata20-0-3,format=raw,cache=none 
-device ide-hd,bus=sata20.3,drive=drive-sata20-0-3,id=sata20-0-3 -drive 
file=/home/image/rhel7.0-118.qcow2,if=none,id=drive-sata20-0-4,format=raw,cache=none 
-device ide-hd,bus=sata20.4,drive=drive-sata20-0-4,id=sata20-0-4 -drive 
file=/home/image/rhel7.0-119.qcow2,if=none,id=drive-sata20-0-5,format=raw,cache=none 
-device ide-hd,bus=sata20.5,drive=drive-sata20-0-5,id=sata20-0-5 -drive 
file=/home/image/rhel7.0-120.qcow2,if=none,id=drive-sata21-0-0,format=raw,cache=none 
-device ide-hd,bus=sata21.0,drive=drive-sata21-0-0,id=sata21-0-0 -drive 
file=/home/image/rhel7.0-121.qcow2,if=none,id=drive-sata21-0-1,format=raw,cache=none 
-device ide-hd,bus=sata21.1,drive=drive-sata21-0-1,id=sata21-0-1 -drive 
file=/home/image/rhel7.0-122.qcow2,if=none,id=drive-sata21-0-2,format=raw,cache=none 
-device ide-hd,bus=sata21.2,drive=drive-sata21-0-2,id=sata21-0-2 -drive 
file=/home/image/rhel7.0-123.qcow2,if=none,id=drive-sata21-0-3,format=raw,cache=none 
-device ide-hd,bus=sata21.3,drive=drive-sata21-0-3,id=sata21-0-3 -drive 
file=/home/image/rhel7.0-124.qcow2,if=none,id=drive-sata21-0-4,format=raw,cache=none 
-device ide-hd,bus=sata21.4,drive=drive-sata21-0-4,id=sata21-0-4 -drive 
file=/home/image/rhel7.0-125.qcow2,if=none,id=drive-sata21-0-5,format=raw,cache=none 
-device ide-hd,bus=sata21.5,drive=drive-sata21-0-5,id=sata21-0-5 -drive 
file=/home/image/rhel7.0-126.qcow2,if=none,id=drive-sata22-0-0,format=raw,cache=none 
-device ide-hd,bus=sata22.0,drive=drive-sata22-0-0,id=sata22-0-0 -drive 
file=/home/image/rhel7.0-127.qcow2,if=none,id=drive-sata22-0-1,format=raw,cache=none 
-device ide-hd,bus=sata22.1,drive=drive-sata22-0-1,id=sata22-0-1 -drive 
file=/home/image/rhel7.0-128.qcow2,if=none,id=drive-sata22-0-2,format=raw,cache=none 
-device ide-hd,bus=sata22.2,drive=drive-sata22-0-2,id=sata22-0-2 -drive 
file=/home/image/rhel7.0-129.qcow2,if=none,id=drive-sata22-0-3,format=raw,cache=none 
-device ide-hd,bus=sata22.3,drive=drive-sata22-0-3,id=sata22-0-3 -drive 
file=/home/image/rhel7.0-130.qcow2,if=none,id=drive-sata22-0-4,format=raw,cache=none 
-device ide-hd,bus=sata22.4,drive=drive-sata22-0-4,id=sata22-0-4 -drive 
file=/home/image/rhel7.0-131.qcow2,if=none,id=drive-sata22-0-5,format=raw,cache=none 
-device ide-hd,bus=sata22.5,drive=drive-sata22-0-5,id=sata22-0-5 -drive 
file=/home/image/rhel7.0-132.qcow2,if=none,id=drive-sata23-0-0,format=raw,cache=none 
-device ide-hd,bus=sata23.0,drive=drive-sata23-0-0,id=sata23-0-0 -drive 
file=/home/image/rhel7.0-133.qcow2,if=none,id=drive-sata23-0-1,format=raw,cache=none 
-device ide-hd,bus=sata23.1,drive=drive-sata23-0-1,id=sata23-0-1 -drive 
file=/home/image/rhel7.0-134.qcow2,if=none,id=drive-sata23-0-2,format=raw,cache=none 
-device ide-hd,bus=sata23.2,drive=drive-sata23-0-2,id=sata23-0-2 -drive 
file=/home/image/rhel7.0-135.qcow2,if=none,id=drive-sata23-0-3,format=raw,cache=none 
-device ide-hd,bus=sata23.3,drive=drive-sata23-0-3,id=sata23-0-3 -drive 
file=/home/image/rhel7.0-136.qcow2,if=none,id=drive-sata23-0-4,format=raw,cache=none 
-device ide-hd,bus=sata23.4,drive=drive-sata23-0-4,id=sata23-0-4 -drive 
file=/home/image/rhel7.0-137.qcow2,if=none,id=drive-sata23-0-5,format=raw,cache=none 
-device ide-hd,bus=sata23.5,drive=drive-sata23-0-5,id=sata23-0-5 -drive 
file=/home/image/rhel7.0-138.qcow2,if=none,id=drive-sata24-0-0,format=raw,cache=none 
-device ide-hd,bus=sata24.0,drive=drive-sata24-0-0,id=sata24-0-0 -drive 
file=/home/image/rhel7.0-139.qcow2,if=none,id=drive-sata24-0-1,format=raw,cache=none 
-device ide-hd,bus=sata24.1,drive=drive-sata24-0-1,id=sata24-0-1 -drive 
file=/home/image/rhel7.0-140.qcow2,if=none,id=drive-sata24-0-2,format=raw,cache=none 
-device ide-hd,bus=sata24.2,drive=drive-sata24-0-2,id=sata24-0-2 -drive 
file=/home/image/rhel7.0-141.qcow2,if=none,id=drive-sata24-0-3,format=raw,cache=none 
-device ide-hd,bus=sata24.3,drive=drive-sata24-0-3,id=sata24-0-3 -drive 
file=/home/image/rhel7.0-142.qcow2,if=none,id=drive-sata24-0-4,format=raw,cache=none 
-device ide-hd,bus=sata24.4,drive=drive-sata24-0-4,id=sata24-0-4 -drive 
file=/home/image/rhel7.0-143.qcow2,if=none,id=drive-sata24-0-5,format=raw,cache=none 
-device ide-hd,bus=sata24.5,drive=drive-sata24-0-5,id=sata24-0-5 -drive 
file=/home/image/rhel7.0-144.qcow2,if=none,id=drive-sata25-0-0,format=raw,cache=none 
-device ide-hd,bus=sata25.0,drive=drive-sata25-0-0,id=sata25-0-0 -drive 
file=/home/image/rhel7.0-145.qcow2,if=none,id=drive-sata25-0-1,format=raw,cache=none 
-device ide-hd,bus=sata25.1,drive=drive-sata25-0-1,id=sata25-0-1 -drive 
file=/home/image/rhel7.0-146.qcow2,if=none,id=drive-sata25-0-2,format=raw,cache=none 
-device ide-hd,bus=sata25.2,drive=drive-sata25-0-2,id=sata25-0-2 -drive 
file=/home/image/rhel7.0-147.qcow2,if=none,id=drive-sata25-0-3,format=raw,cache=none 
-device ide-hd,bus=sata25.3,drive=drive-sata25-0-3,id=sata25-0-3 -drive 
file=/home/image/rhel7.0-148.qcow2,if=none,id=drive-sata25-0-4,format=raw,cache=none 
-device ide-hd,bus=sata25.4,drive=drive-sata25-0-4,id=sata25-0-4 -drive 
file=/home/image/rhel7.0-149.qcow2,if=none,id=drive-sata25-0-5,format=raw,cache=none 
-device ide-hd,bus=sata25.5,drive=drive-sata25-0-5,id=sata25-0-5 -drive 
file=/home/image/rhel7.0-150.qcow2,if=none,id=drive-sata26-0-0,format=raw,cache=none 
-device ide-hd,bus=sata26.0,drive=drive-sata26-0-0,id=sata26-0-0 -drive 
file=/home/image/rhel7.0-151.qcow2,if=none,id=drive-sata26-0-1,format=raw,cache=none 
-device ide-hd,bus=sata26.1,drive=drive-sata26-0-1,id=sata26-0-1 -drive 
file=/home/image/rhel7.0-152.qcow2,if=none,id=drive-sata26-0-2,format=raw,cache=none 
-device ide-hd,bus=sata26.2,drive=drive-sata26-0-2,id=sata26-0-2 -drive 
file=/home/image/rhel7.0-153.qcow2,if=none,id=drive-sata26-0-3,format=raw,cache=none 
-device ide-hd,bus=sata26.3,drive=drive-sata26-0-3,id=sata26-0-3 -drive 
file=/home/image/rhel7.0-154.qcow2,if=none,id=drive-sata26-0-4,format=raw,cache=none 
-device ide-hd,bus=sata26.4,drive=drive-sata26-0-4,id=sata26-0-4 -drive 
file=/home/image/rhel7.0-155.qcow2,if=none,id=drive-sata26-0-5,format=raw,cache=none 
-device ide-hd,bus=sata26.5,drive=drive-sata26-0-5,id=sata26-0-5 -drive 
file=/home/image/rhel7.0-156.qcow2,if=none,id=drive-sata27-0-0,format=raw,cache=none 
-device ide-hd,bus=sata27.0,drive=drive-sata27-0-0,id=sata27-0-0 -drive 
file=/home/image/rhel7.0-157.qcow2,if=none,id=drive-sata27-0-1,format=raw,cache=none 
-device ide-hd,bus=sata27.1,drive=drive-sata27-0-1,id=sata27-0-1 -drive 
file=/home/image/rhel7.0-158.qcow2,if=none,id=drive-sata27-0-2,format=raw,cache=none 
-device ide-hd,bus=sata27.2,drive=drive-sata27-0-2,id=sata27-0-2 -drive 
file=/home/image/rhel7.0-159.qcow2,if=none,id=drive-sata27-0-3,format=raw,cache=none 
-device ide-hd,bus=sata27.3,drive=drive-sata27-0-3,id=sata27-0-3 -drive 
file=/home/image/rhel7.0-160.qcow2,if=none,id=drive-sata27-0-4,format=raw,cache=none 
-device ide-hd,bus=sata27.4,drive=drive-sata27-0-4,id=sata27-0-4 -drive 
file=/home/image/rhel7.0-161.qcow2,if=none,id=drive-sata27-0-5,format=raw,cache=none 
-device ide-hd,bus=sata27.5,drive=drive-sata27-0-5,id=sata27-0-5 -drive 
file=/home/image/rhel7.0-162.qcow2,if=none,id=drive-sata28-0-0,format=raw,cache=none 
-device ide-hd,bus=sata28.0,drive=drive-sata28-0-0,id=sata28-0-0 -drive 
file=/home/image/rhel7.0-163.qcow2,if=none,id=drive-sata28-0-1,format=raw,cache=none 
-device ide-hd,bus=sata28.1,drive=drive-sata28-0-1,id=sata28-0-1 -drive 
file=/home/image/rhel7.0-164.qcow2,if=none,id=drive-sata28-0-2,format=raw,cache=none 
-device ide-hd,bus=sata28.2,drive=drive-sata28-0-2,id=sata28-0-2 -drive 
file=/home/image/rhel7.0-165.qcow2,if=none,id=drive-sata28-0-3,format=raw,cache=none 
-device ide-hd,bus=sata28.3,drive=drive-sata28-0-3,id=sata28-0-3 -drive 
file=/home/image/rhel7.0-166.qcow2,if=none,id=drive-sata28-0-4,format=raw,cache=none 
-device ide-hd,bus=sata28.4,drive=drive-sata28-0-4,id=sata28-0-4 -drive 
file=/home/image/rhel7.0-167.qcow2,if=none,id=drive-sata28-0-5,format=raw,cache=none 
-device ide-hd,bus=sata28.5,drive=drive-sata28-0-5,id=sata28-0-5 -drive 
file=/home/image/rhel7.0-168.qcow2,if=none,id=drive-sata29-0-0,format=raw,cache=none 
-device ide-hd,bus=sata29.0,drive=drive-sata29-0-0,id=sata29-0-0 -drive 
file=/home/image/rhel7.0-169.qcow2,if=none,id=drive-sata29-0-1,format=raw,cache=none 
-device ide-hd,bus=sata29.1,drive=drive-sata29-0-1,id=sata29-0-1 -drive 
file=/home/image/rhel7.0-170.qcow2,if=none,id=drive-sata29-0-2,format=raw,cache=none 
-device ide-hd,bus=sata29.2,drive=drive-sata29-0-2,id=sata29-0-2 -drive 
file=/home/image/rhel7.0-171.qcow2,if=none,id=drive-sata29-0-3,format=raw,cache=none 
-device ide-hd,bus=sata29.3,drive=drive-sata29-0-3,id=sata29-0-3 -drive 
file=/home/image/rhel7.0-172.qcow2,if=none,id=drive-sata29-0-4,format=raw,cache=none 
-device ide-hd,bus=sata29.4,drive=drive-sata29-0-4,id=sata29-0-4 -drive 
file=/home/image/rhel7.0-173.qcow2,if=none,id=drive-sata29-0-5,format=raw,cache=none 
-device ide-hd,bus=sata29.5,drive=drive-sata29-0-5,id=sata29-0-5 -drive 
file=/home/image/rhel7.0-174.qcow2,if=none,id=drive-sata30-0-0,format=raw,cache=none 
-device ide-hd,bus=sata30.0,drive=drive-sata30-0-0,id=sata30-0-0 -drive 
file=/home/image/rhel7.0-175.qcow2,if=none,id=drive-sata30-0-1,format=raw,cache=none 
-device ide-hd,bus=sata30.1,drive=drive-sata30-0-1,id=sata30-0-1 -drive 
file=/home/image/rhel7.0-176.qcow2,if=none,id=drive-sata30-0-2,format=raw,cache=none 
-device ide-hd,bus=sata30.2,drive=drive-sata30-0-2,id=sata30-0-2 -drive 
file=/home/image/rhel7.0-177.qcow2,if=none,id=drive-sata30-0-3,format=raw,cache=none 
-device ide-hd,bus=sata30.3,drive=drive-sata30-0-3,id=sata30-0-3 -drive 
file=/home/image/rhel7.0-178.qcow2,if=none,id=drive-sata30-0-4,format=raw,cache=none 
-device ide-hd,bus=sata30.4,drive=drive-sata30-0-4,id=sata30-0-4 -drive 
file=/home/image/rhel7.0-179.qcow2,if=none,id=drive-sata30-0-5,format=raw,cache=none 
-device ide-hd,bus=sata30.5,drive=drive-sata30-0-5,id=sata30-0-5 -drive 
file=/home/image/rhel7.0-180.qcow2,if=none,id=drive-sata31-0-0,format=raw,cache=none 
-device ide-hd,bus=sata31.0,drive=drive-sata31-0-0,id=sata31-0-0 -drive 
file=/home/image/rhel7.0-181.qcow2,if=none,id=drive-sata31-0-1,format=raw,cache=none 
-device ide-hd,bus=sata31.1,drive=drive-sata31-0-1,id=sata31-0-1 -drive 
file=/home/image/rhel7.0-182.qcow2,if=none,id=drive-sata31-0-2,format=raw,cache=none 
-device ide-hd,bus=sata31.2,drive=drive-sata31-0-2,id=sata31-0-2 -drive 
file=/home/image/rhel7.0-183.qcow2,if=none,id=drive-sata31-0-3,format=raw,cache=none 
-device ide-hd,bus=sata31.3,drive=drive-sata31-0-3,id=sata31-0-3 -drive 
file=/home/image/rhel7.0-184.qcow2,if=none,id=drive-sata31-0-4,format=raw,cache=none 
-device ide-hd,bus=sata31.4,drive=drive-sata31-0-4,id=sata31-0-4 -drive 
file=/home/image/rhel7.0-185.qcow2,if=none,id=drive-sata31-0-5,format=raw,cache=none 
-device ide-hd,bus=sata31.5,drive=drive-sata31-0-5,id=sata31-0-5 -drive 
file=/home/image/rhel7.0-186.qcow2,if=none,id=drive-sata32-0-0,format=raw,cache=none 
-device ide-hd,bus=sata32.0,drive=drive-sata32-0-0,id=sata32-0-0 -drive 
file=/home/image/rhel7.0-187.qcow2,if=none,id=drive-sata32-0-1,format=raw,cache=none 
-device ide-hd,bus=sata32.1,drive=drive-sata32-0-1,id=sata32-0-1 -drive 
file=/home/image/rhel7.0-188.qcow2,if=none,id=drive-sata32-0-2,format=raw,cache=none 
-device ide-hd,bus=sata32.2,drive=drive-sata32-0-2,id=sata32-0-2 -drive 
file=/home/image/rhel7.0-189.qcow2,if=none,id=drive-sata32-0-3,format=raw,cache=none 
-device ide-hd,bus=sata32.3,drive=drive-sata32-0-3,id=sata32-0-3 -drive 
file=/home/image/rhel7.0-190.qcow2,if=none,id=drive-sata32-0-4,format=raw,cache=none 
-device ide-hd,bus=sata32.4,drive=drive-sata32-0-4,id=sata32-0-4 -drive 
file=/home/image/rhel7.0-191.qcow2,if=none,id=drive-sata32-0-5,format=raw,cache=none 
-device ide-hd,bus=sata32.5,drive=drive-sata32-0-5,id=sata32-0-5 -drive 
file=/home/image/rhel7.0-192.qcow2,if=none,id=drive-sata33-0-0,format=raw,cache=none 
-device ide-hd,bus=sata33.0,drive=drive-sata33-0-0,id=sata33-0-0 -drive 
file=/home/image/rhel7.0-193.qcow2,if=none,id=drive-sata33-0-1,format=raw,cache=none 
-device ide-hd,bus=sata33.1,drive=drive-sata33-0-1,id=sata33-0-1 -drive 
file=/home/image/rhel7.0-194.qcow2,if=none,id=drive-sata33-0-2,format=raw,cache=none 
-device ide-hd,bus=sata33.2,drive=drive-sata33-0-2,id=sata33-0-2 -drive 
file=/home/image/rhel7.0-195.qcow2,if=none,id=drive-sata33-0-3,format=raw,cache=none 
-device ide-hd,bus=sata33.3,drive=drive-sata33-0-3,id=sata33-0-3 -drive 
file=/home/image/rhel7.0-196.qcow2,if=none,id=drive-sata33-0-4,format=raw,cache=none 
-device ide-hd,bus=sata33.4,drive=drive-sata33-0-4,id=sata33-0-4 -drive 
file=/home/image/rhel7.0-197.qcow2,if=none,id=drive-sata33-0-5,format=raw,cache=none 
-device ide-hd,bus=sata33.5,drive=drive-sata33-0-5,id=sata33-0-5 -drive 
file=/home/image/rhel7.0-198.qcow2,if=none,id=drive-sata34-0-0,format=raw,cache=none 
-device ide-hd,bus=sata34.0,drive=drive-sata34-0-0,id=sata34-0-0 -drive 
file=/home/image/rhel7.0-199.qcow2,if=none,id=drive-sata34-0-1,format=raw,cache=none 
-device ide-hd,bus=sata34.1,drive=drive-sata34-0-1,id=sata34-0-1 -drive 
file=/home/image/rhel7.0-200.qcow2,if=none,id=drive-sata34-0-2,format=raw,cache=none 
-device ide-hd,bus=sata34.2,drive=drive-sata34-0-2,id=sata34-0-2 -drive 
file=/home/image/rhel7.0-201.qcow2,if=none,id=drive-sata34-0-3,format=raw,cache=none 
-device ide-hd,bus=sata34.3,drive=drive-sata34-0-3,id=sata34-0-3 -drive 
file=/home/image/rhel7.0-202.qcow2,if=none,id=drive-sata34-0-4,format=raw,cache=none 
-device ide-hd,bus=sata34.4,drive=drive-sata34-0-4,id=sata34-0-4 -drive 
file=/home/image/rhel7.0-203.qcow2,if=none,id=drive-sata34-0-5,format=raw,cache=none 
-device ide-hd,bus=sata34.5,drive=drive-sata34-0-5,id=sata34-0-5 -drive 
file=/home/image/rhel7.0-204.qcow2,if=none,id=drive-sata35-0-0,format=raw,cache=none 
-device ide-hd,bus=sata35.0,drive=drive-sata35-0-0,id=sata35-0-0 -drive 
file=/home/image/rhel7.0-205.qcow2,if=none,id=drive-sata35-0-1,format=raw,cache=none 
-device ide-hd,bus=sata35.1,drive=drive-sata35-0-1,id=sata35-0-1 -drive 
file=/home/image/rhel7.0-206.qcow2,if=none,id=drive-sata35-0-2,format=raw,cache=none 
-device ide-hd,bus=sata35.2,drive=drive-sata35-0-2,id=sata35-0-2 -drive 
file=/home/image/rhel7.0-207.qcow2,if=none,id=drive-sata35-0-3,format=raw,cache=none 
-device ide-hd,bus=sata35.3,drive=drive-sata35-0-3,id=sata35-0-3 -drive 
file=/home/image/rhel7.0-208.qcow2,if=none,id=drive-sata35-0-4,format=raw,cache=none 
-device ide-hd,bus=sata35.4,drive=drive-sata35-0-4,id=sata35-0-4 -drive 
file=/home/image/rhel7.0-209.qcow2,if=none,id=drive-sata35-0-5,format=raw,cache=none 
-device ide-hd,bus=sata35.5,drive=drive-sata35-0-5,id=sata35-0-5 -drive 
file=/home/image/rhel7.0-210.qcow2,if=none,id=drive-sata36-0-0,format=raw,cache=none 
-device ide-hd,bus=sata36.0,drive=drive-sata36-0-0,id=sata36-0-0 -drive 
file=/home/image/rhel7.0-211.qcow2,if=none,id=drive-sata36-0-1,format=raw,cache=none 
-device ide-hd,bus=sata36.1,drive=drive-sata36-0-1,id=sata36-0-1 -drive 
file=/home/image/rhel7.0-212.qcow2,if=none,id=drive-sata36-0-2,format=raw,cache=none 
-device ide-hd,bus=sata36.2,drive=drive-sata36-0-2,id=sata36-0-2 -drive 
file=/home/image/rhel7.0-213.qcow2,if=none,id=drive-sata36-0-3,format=raw,cache=none 
-device ide-hd,bus=sata36.3,drive=drive-sata36-0-3,id=sata36-0-3 -drive 
file=/home/image/rhel7.0-214.qcow2,if=none,id=drive-sata36-0-4,format=raw,cache=none 
-device ide-hd,bus=sata36.4,drive=drive-sata36-0-4,id=sata36-0-4 -drive 
file=/home/image/rhel7.0-215.qcow2,if=none,id=drive-sata36-0-5,format=raw,cache=none 
-device ide-hd,bus=sata36.5,drive=drive-sata36-0-5,id=sata36-0-5 -drive 
file=/home/image/rhel7.0-216.qcow2,if=none,id=drive-sata37-0-0,format=raw,cache=none 
-device ide-hd,bus=sata37.0,drive=drive-sata37-0-0,id=sata37-0-0 -drive 
file=/home/image/rhel7.0-217.qcow2,if=none,id=drive-sata37-0-1,format=raw,cache=none 
-device ide-hd,bus=sata37.1,drive=drive-sata37-0-1,id=sata37-0-1 -drive 
file=/home/image/rhel7.0-218.qcow2,if=none,id=drive-sata37-0-2,format=raw,cache=none 
-device ide-hd,bus=sata37.2,drive=drive-sata37-0-2,id=sata37-0-2 -drive 
file=/home/image/rhel7.0-219.qcow2,if=none,id=drive-sata37-0-3,format=raw,cache=none 
-device ide-hd,bus=sata37.3,drive=drive-sata37-0-3,id=sata37-0-3 -drive 
file=/home/image/rhel7.0-220.qcow2,if=none,id=drive-sata37-0-4,format=raw,cache=none 
-device ide-hd,bus=sata37.4,drive=drive-sata37-0-4,id=sata37-0-4 -drive 
file=/home/image/rhel7.0-221.qcow2,if=none,id=drive-sata37-0-5,format=raw,cache=none 
-device ide-hd,bus=sata37.5,drive=drive-sata37-0-5,id=sata37-0-5 -drive 
file=/home/image/rhel7.0-222.qcow2,if=none,id=drive-sata38-0-0,format=raw,cache=none 
-device ide-hd,bus=sata38.0,drive=drive-sata38-0-0,id=sata38-0-0 -drive 
file=/home/image/rhel7.0-223.qcow2,if=none,id=drive-sata38-0-1,format=raw,cache=none 
-device ide-hd,bus=sata38.1,drive=drive-sata38-0-1,id=sata38-0-1 -drive 
file=/home/image/rhel7.0-224.qcow2,if=none,id=drive-sata38-0-2,format=raw,cache=none 
-device ide-hd,bus=sata38.2,drive=drive-sata38-0-2,id=sata38-0-2 -drive 
file=/home/image/rhel7.0-225.qcow2,if=none,id=drive-sata38-0-3,format=raw,cache=none 
-device ide-hd,bus=sata38.3,drive=drive-sata38-0-3,id=sata38-0-3 -drive 
file=/home/image/rhel7.0-226.qcow2,if=none,id=drive-sata38-0-4,format=raw,cache=none 
-device ide-hd,bus=sata38.4,drive=drive-sata38-0-4,id=sata38-0-4 -drive 
file=/home/image/rhel7.0-227.qcow2,if=none,id=drive-sata38-0-5,format=raw,cache=none 
-device ide-hd,bus=sata38.5,drive=drive-sata38-0-5,id=sata38-0-5 -drive 
file=/home/image/rhel7.0-228.qcow2,if=none,id=drive-sata39-0-0,format=raw,cache=none 
-device ide-hd,bus=sata39.0,drive=drive-sata39-0-0,id=sata39-0-0 -drive 
file=/home/image/rhel7.0-229.qcow2,if=none,id=drive-sata39-0-1,format=raw,cache=none 
-device ide-hd,bus=sata39.1,drive=drive-sata39-0-1,id=sata39-0-1 -drive 
file=/home/image/rhel7.0-230.qcow2,if=none,id=drive-sata39-0-2,format=raw,cache=none 
-device ide-hd,bus=sata39.2,drive=drive-sata39-0-2,id=sata39-0-2 -drive 
file=/home/image/rhel7.0-231.qcow2,if=none,id=drive-sata39-0-3,format=raw,cache=none 
-device ide-hd,bus=sata39.3,drive=drive-sata39-0-3,id=sata39-0-3 -drive 
file=/home/image/rhel7.0-232.qcow2,if=none,id=drive-sata39-0-4,format=raw,cache=none 
-device ide-hd,bus=sata39.4,drive=drive-sata39-0-4,id=sata39-0-4 -drive 
file=/home/image/rhel7.0-233.qcow2,if=none,id=drive-sata39-0-5,format=raw,cache=none 
-device ide-hd,bus=sata39.5,drive=drive-sata39-0-5,id=sata39-0-5 -drive 
file=/home/image/rhel7.0-234.qcow2,if=none,id=drive-sata40-0-0,format=raw,cache=none 
-device ide-hd,bus=sata40.0,drive=drive-sata40-0-0,id=sata40-0-0 -drive 
file=/home/image/rhel7.0-235.qcow2,if=none,id=drive-sata40-0-1,format=raw,cache=none 
-device ide-hd,bus=sata40.1,drive=drive-sata40-0-1,id=sata40-0-1 -drive 
file=/home/image/rhel7.0-236.qcow2,if=none,id=drive-sata40-0-2,format=raw,cache=none 
-device ide-hd,bus=sata40.2,drive=drive-sata40-0-2,id=sata40-0-2 -drive 
file=/home/image/rhel7.0-237.qcow2,if=none,id=drive-sata40-0-3,format=raw,cache=none 
-device ide-hd,bus=sata40.3,drive=drive-sata40-0-3,id=sata40-0-3 -drive 
file=/home/image/rhel7.0-238.qcow2,if=none,id=drive-sata40-0-4,format=raw,cache=none 
-device ide-hd,bus=sata40.4,drive=drive-sata40-0-4,id=sata40-0-4 -drive 
file=/home/image/rhel7.0-239.qcow2,if=none,id=drive-sata40-0-5,format=raw,cache=none 
-device ide-hd,bus=sata40.5,drive=drive-sata40-0-5,id=sata40-0-5 -drive 
file=/home/image/rhel7.0-240.qcow2,if=none,id=drive-sata41-0-0,format=raw,cache=none 
-device ide-hd,bus=sata41.0,drive=drive-sata41-0-0,id=sata41-0-0 -drive 
file=/home/image/rhel7.0-241.qcow2,if=none,id=drive-sata41-0-1,format=raw,cache=none 
-device ide-hd,bus=sata41.1,drive=drive-sata41-0-1,id=sata41-0-1 -drive 
file=/home/image/rhel7.0-242.qcow2,if=none,id=drive-sata41-0-2,format=raw,cache=none 
-device ide-hd,bus=sata41.2,drive=drive-sata41-0-2,id=sata41-0-2 -drive 
file=/home/image/rhel7.0-243.qcow2,if=none,id=drive-sata41-0-3,format=raw,cache=none 
-device ide-hd,bus=sata41.3,drive=drive-sata41-0-3,id=sata41-0-3 -drive 
file=/home/image/rhel7.0-244.qcow2,if=none,id=drive-sata41-0-4,format=raw,cache=none 
-device ide-hd,bus=sata41.4,drive=drive-sata41-0-4,id=sata41-0-4 -drive 
file=/home/image/rhel7.0-245.qcow2,if=none,id=drive-sata41-0-5,format=raw,cache=none 
-device ide-hd,bus=sata41.5,drive=drive-sata41-0-5,id=sata41-0-5 -drive 
file=/home/image/rhel7.0-246.qcow2,if=none,id=drive-sata42-0-0,format=raw,cache=none 
-device ide-hd,bus=sata42.0,drive=drive-sata42-0-0,id=sata42-0-0 -drive 
file=/home/image/rhel7.0-247.qcow2,if=none,id=drive-sata42-0-1,format=raw,cache=none 
-device ide-hd,bus=sata42.1,drive=drive-sata42-0-1,id=sata42-0-1 -drive 
file=/home/image/rhel7.0-248.qcow2,if=none,id=drive-sata42-0-2,format=raw,cache=none 
-device ide-hd,bus=sata42.2,drive=drive-sata42-0-2,id=sata42-0-2 -drive 
file=/home/image/rhel7.0-249.qcow2,if=none,id=drive-sata42-0-3,format=raw,cache=none 
-device ide-hd,bus=sata42.3,drive=drive-sata42-0-3,id=sata42-0-3 -drive 
file=/home/image/rhel7.0-250.qcow2,if=none,id=drive-sata42-0-4,format=raw,cache=none 
-device ide-hd,bus=sata42.4,drive=drive-sata42-0-4,id=sata42-0-4 -drive 
file=/home/image/rhel7.0-251.qcow2,if=none,id=drive-sata42-0-5,format=raw,cache=none 
-device ide-hd,bus=sata42.5,drive=drive-sata42-0-5,id=sata42-0-5 -drive 
file=/home/image/rhel7.0-252.qcow2,if=none,id=drive-sata43-0-0,format=raw,cache=none 
-device ide-hd,bus=sata43.0,drive=drive-sata43-0-0,id=sata43-0-0 -drive 
file=/home/image/rhel7.0-253.qcow2,if=none,id=drive-sata43-0-1,format=raw,cache=none 
-device ide-hd,bus=sata43.1,drive=drive-sata43-0-1,id=sata43-0-1 -drive 
file=/home/image/rhel7.0-254.qcow2,if=none,id=drive-sata43-0-2,format=raw,cache=none 
-device ide-hd,bus=sata43.2,drive=drive-sata43-0-2,id=sata43-0-2 -drive 
file=/home/image/rhel7.0-255.qcow2,if=none,id=drive-sata43-0-3,format=raw,cache=none 
-device ide-hd,bus=sata43.3,drive=drive-sata43-0-3,id=sata43-0-3 -drive 
file=/home/image/rhel7.0-256.qcow2,if=none,id=drive-sata43-0-4,format=raw,cache=none 
-device ide-hd,bus=sata43.4,drive=drive-sata43-0-4,id=sata43-0-4 -drive 
file=/home/image/rhel7.0-257.qcow2,if=none,id=drive-sata43-0-5,format=raw,cache=none 
-device ide-hd,bus=sata43.5,drive=drive-sata43-0-5,id=sata43-0-5 -drive 
file=/home/image/rhel7.0-258.qcow2,if=none,id=drive-sata44-0-0,format=raw,cache=none 
-device ide-hd,bus=sata44.0,drive=drive-sata44-0-0,id=sata44-0-0 -drive 
file=/home/image/rhel7.0-259.qcow2,if=none,id=drive-sata44-0-1,format=raw,cache=none 
-device ide-hd,bus=sata44.1,drive=drive-sata44-0-1,id=sata44-0-1 -drive 
file=/home/image/rhel7.0-260.qcow2,if=none,id=drive-sata44-0-2,format=raw,cache=none 
-device ide-hd,bus=sata44.2,drive=drive-sata44-0-2,id=sata44-0-2 -drive 
file=/home/image/rhel7.0-261.qcow2,if=none,id=drive-sata44-0-3,format=raw,cache=none 
-device ide-hd,bus=sata44.3,drive=drive-sata44-0-3,id=sata44-0-3 -drive 
file=/home/image/rhel7.0-262.qcow2,if=none,id=drive-sata44-0-4,format=raw,cache=none 
-device ide-hd,bus=sata44.4,drive=drive-sata44-0-4,id=sata44-0-4 -drive 
file=/home/image/rhel7.0-263.qcow2,if=none,id=drive-sata44-0-5,format=raw,cache=none 
-device ide-hd,bus=sata44.5,drive=drive-sata44-0-5,id=sata44-0-5 -drive 
file=/home/image/rhel7.0-264.qcow2,if=none,id=drive-sata45-0-0,format=raw,cache=none 
-device ide-hd,bus=sata45.0,drive=drive-sata45-0-0,id=sata45-0-0 -drive 
file=/home/image/rhel7.0-265.qcow2,if=none,id=drive-sata45-0-1,format=raw,cache=none 
-device ide-hd,bus=sata45.1,drive=drive-sata45-0-1,id=sata45-0-1 -drive 
file=/home/image/rhel7.0-266.qcow2,if=none,id=drive-sata45-0-2,format=raw,cache=none 
-device ide-hd,bus=sata45.2,drive=drive-sata45-0-2,id=sata45-0-2 -drive 
file=/home/image/rhel7.0-267.qcow2,if=none,id=drive-sata45-0-3,format=raw,cache=none 
-device ide-hd,bus=sata45.3,drive=drive-sata45-0-3,id=sata45-0-3 -drive 
file=/home/image/rhel7.0-268.qcow2,if=none,id=drive-sata45-0-4,format=raw,cache=none 
-device ide-hd,bus=sata45.4,drive=drive-sata45-0-4,id=sata45-0-4 -drive 
file=/home/image/rhel7.0-269.qcow2,if=none,id=drive-sata45-0-5,format=raw,cache=none 
-device ide-hd,bus=sata45.5,drive=drive-sata45-0-5,id=sata45-0-5 -drive 
file=/home/image/rhel7.0-270.qcow2,if=none,id=drive-sata46-0-0,format=raw,cache=none 
-device ide-hd,bus=sata46.0,drive=drive-sata46-0-0,id=sata46-0-0 -drive 
file=/home/image/rhel7.0-271.qcow2,if=none,id=drive-sata46-0-1,format=raw,cache=none 
-device ide-hd,bus=sata46.1,drive=drive-sata46-0-1,id=sata46-0-1 -drive 
file=/home/image/rhel7.0-272.qcow2,if=none,id=drive-sata46-0-2,format=raw,cache=none 
-device ide-hd,bus=sata46.2,drive=drive-sata46-0-2,id=sata46-0-2 -drive 
file=/home/image/rhel7.0-273.qcow2,if=none,id=drive-sata46-0-3,format=raw,cache=none 
-device ide-hd,bus=sata46.3,drive=drive-sata46-0-3,id=sata46-0-3 -drive 
file=/home/image/rhel7.0-274.qcow2,if=none,id=drive-sata46-0-4,format=raw,cache=none 
-device ide-hd,bus=sata46.4,drive=drive-sata46-0-4,id=sata46-0-4 -drive 
file=/home/image/rhel7.0-275.qcow2,if=none,id=drive-sata46-0-5,format=raw,cache=none 
-device ide-hd,bus=sata46.5,drive=drive-sata46-0-5,id=sata46-0-5 -drive 
file=/home/image/rhel7.0-276.qcow2,if=none,id=drive-sata47-0-0,format=raw,cache=none 
-device ide-hd,bus=sata47.0,drive=drive-sata47-0-0,id=sata47-0-0 -drive 
file=/home/image/rhel7.0-277.qcow2,if=none,id=drive-sata47-0-1,format=raw,cache=none 
-device ide-hd,bus=sata47.1,drive=drive-sata47-0-1,id=sata47-0-1 -drive 
file=/home/image/rhel7.0-278.qcow2,if=none,id=drive-sata47-0-2,format=raw,cache=none 
-device ide-hd,bus=sata47.2,drive=drive-sata47-0-2,id=sata47-0-2 -drive 
file=/home/image/rhel7.0-279.qcow2,if=none,id=drive-sata47-0-3,format=raw,cache=none 
-device ide-hd,bus=sata47.3,drive=drive-sata47-0-3,id=sata47-0-3 -drive 
file=/home/image/rhel7.0-280.qcow2,if=none,id=drive-sata47-0-4,format=raw,cache=none 
-device ide-hd,bus=sata47.4,drive=drive-sata47-0-4,id=sata47-0-4 -drive 
file=/home/image/rhel7.0-281.qcow2,if=none,id=drive-sata47-0-5,format=raw,cache=none 
-device ide-hd,bus=sata47.5,drive=drive-sata47-0-5,id=sata47-0-5 -drive 
file=/home/image/rhel7.0-282.qcow2,if=none,id=drive-sata48-0-0,format=raw,cache=none 
-device ide-hd,bus=sata48.0,drive=drive-sata48-0-0,id=sata48-0-0 -drive 
file=/home/image/rhel7.0-283.qcow2,if=none,id=drive-sata48-0-1,format=raw,cache=none 
-device ide-hd,bus=sata48.1,drive=drive-sata48-0-1,id=sata48-0-1 -drive 
file=/home/image/rhel7.0-284.qcow2,if=none,id=drive-sata48-0-2,format=raw,cache=none 
-device ide-hd,bus=sata48.2,drive=drive-sata48-0-2,id=sata48-0-2 -drive 
file=/home/image/rhel7.0-285.qcow2,if=none,id=drive-sata48-0-3,format=raw,cache=none 
-device ide-hd,bus=sata48.3,drive=drive-sata48-0-3,id=sata48-0-3 -drive 
file=/home/image/rhel7.0-286.qcow2,if=none,id=drive-sata48-0-4,format=raw,cache=none 
-device ide-hd,bus=sata48.4,drive=drive-sata48-0-4,id=sata48-0-4 -drive 
file=/home/image/rhel7.0-287.qcow2,if=none,id=drive-sata48-0-5,format=raw,cache=none 
-device ide-hd,bus=sata48.5,drive=drive-sata48-0-5,id=sata48-0-5 -drive 
file=/home/image/rhel7.0-288.qcow2,if=none,id=drive-sata49-0-0,format=raw,cache=none 
-device ide-hd,bus=sata49.0,drive=drive-sata49-0-0,id=sata49-0-0 -drive 
file=/home/image/rhel7.0-289.qcow2,if=none,id=drive-sata49-0-1,format=raw,cache=none 
-device ide-hd,bus=sata49.1,drive=drive-sata49-0-1,id=sata49-0-1 -drive 
file=/home/image/rhel7.0-290.qcow2,if=none,id=drive-sata49-0-2,format=raw,cache=none 
-device ide-hd,bus=sata49.2,drive=drive-sata49-0-2,id=sata49-0-2 -drive 
file=/home/image/rhel7.0-291.qcow2,if=none,id=drive-sata49-0-3,format=raw,cache=none 
-device ide-hd,bus=sata49.3,drive=drive-sata49-0-3,id=sata49-0-3 -drive 
file=/home/image/rhel7.0-292.qcow2,if=none,id=drive-sata49-0-4,format=raw,cache=none 
-device ide-hd,bus=sata49.4,drive=drive-sata49-0-4,id=sata49-0-4 -drive 
file=/home/image/rhel7.0-293.qcow2,if=none,id=drive-sata49-0-5,format=raw,cache=none 
-device ide-hd,bus=sata49.5,drive=drive-sata49-0-5,id=sata49-0-5 -drive 
file=/home/image/rhel7.0-294.qcow2,if=none,id=drive-sata50-0-0,format=raw,cache=none 
-device ide-hd,bus=sata50.0,drive=drive-sata50-0-0,id=sata50-0-0 -drive 
file=/home/image/rhel7.0-295.qcow2,if=none,id=drive-sata50-0-1,format=raw,cache=none 
-device ide-hd,bus=sata50.1,drive=drive-sata50-0-1,id=sata50-0-1 -drive 
file=/home/image/rhel7.0-296.qcow2,if=none,id=drive-sata50-0-2,format=raw,cache=none 
-device ide-hd,bus=sata50.2,drive=drive-sata50-0-2,id=sata50-0-2 -drive 
file=/home/image/rhel7.0-297.qcow2,if=none,id=drive-sata50-0-3,format=raw,cache=none 
-device ide-hd,bus=sata50.3,drive=drive-sata50-0-3,id=sata50-0-3 -drive 
file=/home/image/rhel7.0-298.qcow2,if=none,id=drive-sata50-0-4,format=raw,cache=none 
-device ide-hd,bus=sata50.4,drive=drive-sata50-0-4,id=sata50-0-4 -drive 
file=/home/image/rhel7.0-299.qcow2,if=none,id=drive-sata50-0-5,format=raw,cache=none 
-device ide-hd,bus=sata50.5,drive=drive-sata50-0-5,id=sata50-0-5 -drive 
file=/home/image/rhel7.0-300.qcow2,if=none,id=drive-sata51-0-0,format=raw,cache=none 
-device ide-hd,bus=sata51.0,drive=drive-sata51-0-0,id=sata51-0-0 -drive 
file=/home/image/rhel7.0-301.qcow2,if=none,id=drive-sata51-0-1,format=raw,cache=none 
-device ide-hd,bus=sata51.1,drive=drive-sata51-0-1,id=sata51-0-1 -drive 
file=/home/image/rhel7.0-302.qcow2,if=none,id=drive-sata51-0-2,format=raw,cache=none 
-device ide-hd,bus=sata51.2,drive=drive-sata51-0-2,id=sata51-0-2 -drive 
file=/home/image/rhel7.0-303.qcow2,if=none,id=drive-sata51-0-3,format=raw,cache=none 
-device ide-hd,bus=sata51.3,drive=drive-sata51-0-3,id=sata51-0-3 -drive 
file=/home/image/rhel7.0-304.qcow2,if=none,id=drive-sata51-0-4,format=raw,cache=none 
-device ide-hd,bus=sata51.4,drive=drive-sata51-0-4,id=sata51-0-4 -drive 
file=/home/image/rhel7.0-305.qcow2,if=none,id=drive-sata51-0-5,format=raw,cache=none 
-device ide-hd,bus=sata51.5,drive=drive-sata51-0-5,id=sata51-0-5 -drive 
file=/home/image/rhel7.0-306.qcow2,if=none,id=drive-sata52-0-0,format=raw,cache=none 
-device ide-hd,bus=sata52.0,drive=drive-sata52-0-0,id=sata52-0-0 -drive 
file=/home/image/rhel7.0-307.qcow2,if=none,id=drive-sata52-0-1,format=raw,cache=none 
-device ide-hd,bus=sata52.1,drive=drive-sata52-0-1,id=sata52-0-1 -drive 
file=/home/image/rhel7.0-308.qcow2,if=none,id=drive-sata52-0-2,format=raw,cache=none 
-device ide-hd,bus=sata52.2,drive=drive-sata52-0-2,id=sata52-0-2 -drive 
file=/home/image/rhel7.0-309.qcow2,if=none,id=drive-sata52-0-3,format=raw,cache=none 
-device ide-hd,bus=sata52.3,drive=drive-sata52-0-3,id=sata52-0-3 -drive 
file=/home/image/rhel7.0-310.qcow2,if=none,id=drive-sata52-0-4,format=raw,cache=none 
-device ide-hd,bus=sata52.4,drive=drive-sata52-0-4,id=sata52-0-4 -drive 
file=/home/image/rhel7.0-311.qcow2,if=none,id=drive-sata52-0-5,format=raw,cache=none 
-device ide-hd,bus=sata52.5,drive=drive-sata52-0-5,id=sata52-0-5 -drive 
file=/home/image/rhel7.0-312.qcow2,if=none,id=drive-sata53-0-0,format=raw,cache=none 
-device ide-hd,bus=sata53.0,drive=drive-sata53-0-0,id=sata53-0-0 -drive 
file=/home/image/rhel7.0-313.qcow2,if=none,id=drive-sata53-0-1,format=raw,cache=none 
-device ide-hd,bus=sata53.1,drive=drive-sata53-0-1,id=sata53-0-1 -drive 
file=/home/image/rhel7.0-314.qcow2,if=none,id=drive-sata53-0-2,format=raw,cache=none 
-device ide-hd,bus=sata53.2,drive=drive-sata53-0-2,id=sata53-0-2 -drive 
file=/home/image/rhel7.0-315.qcow2,if=none,id=drive-sata53-0-3,format=raw,cache=none 
-device ide-hd,bus=sata53.3,drive=drive-sata53-0-3,id=sata53-0-3 -drive 
file=/home/image/rhel7.0-316.qcow2,if=none,id=drive-sata53-0-4,format=raw,cache=none 
-device ide-hd,bus=sata53.4,drive=drive-sata53-0-4,id=sata53-0-4 -drive 
file=/home/image/rhel7.0-317.qcow2,if=none,id=drive-sata53-0-5,format=raw,cache=none 
-device ide-hd,bus=sata53.5,drive=drive-sata53-0-5,id=sata53-0-5 -drive 
file=/home/image/rhel7.0-318.qcow2,if=none,id=drive-sata54-0-0,format=raw,cache=none 
-device ide-hd,bus=sata54.0,drive=drive-sata54-0-0,id=sata54-0-0 -drive 
file=/home/image/rhel7.0-319.qcow2,if=none,id=drive-sata54-0-1,format=raw,cache=none 
-device ide-hd,bus=sata54.1,drive=drive-sata54-0-1,id=sata54-0-1 -drive 
file=/home/image/rhel7.0-320.qcow2,if=none,id=drive-sata54-0-2,format=raw,cache=none 
-device ide-hd,bus=sata54.2,drive=drive-sata54-0-2,id=sata54-0-2 -drive 
file=/home/image/rhel7.0-321.qcow2,if=none,id=drive-sata54-0-3,format=raw,cache=none 
-device ide-hd,bus=sata54.3,drive=drive-sata54-0-3,id=sata54-0-3 -drive 
file=/home/image/rhel7.0-322.qcow2,if=none,id=drive-sata54-0-4,format=raw,cache=none 
-device ide-hd,bus=sata54.4,drive=drive-sata54-0-4,id=sata54-0-4 -drive 
file=/home/image/rhel7.0-323.qcow2,if=none,id=drive-sata54-0-5,format=raw,cache=none 
-device ide-hd,bus=sata54.5,drive=drive-sata54-0-5,id=sata54-0-5 -drive 
file=/home/image/rhel7.0-324.qcow2,if=none,id=drive-sata55-0-0,format=raw,cache=none 
-device ide-hd,bus=sata55.0,drive=drive-sata55-0-0,id=sata55-0-0 -drive 
file=/home/image/rhel7.0-325.qcow2,if=none,id=drive-sata55-0-1,format=raw,cache=none 
-device ide-hd,bus=sata55.1,drive=drive-sata55-0-1,id=sata55-0-1 -drive 
file=/home/image/rhel7.0-326.qcow2,if=none,id=drive-sata55-0-2,format=raw,cache=none 
-device ide-hd,bus=sata55.2,drive=drive-sata55-0-2,id=sata55-0-2 -drive 
file=/home/image/rhel7.0-327.qcow2,if=none,id=drive-sata55-0-3,format=raw,cache=none 
-device ide-hd,bus=sata55.3,drive=drive-sata55-0-3,id=sata55-0-3 -drive 
file=/home/image/rhel7.0-328.qcow2,if=none,id=drive-sata55-0-4,format=raw,cache=none 
-device ide-hd,bus=sata55.4,drive=drive-sata55-0-4,id=sata55-0-4 -drive 
file=/home/image/rhel7.0-329.qcow2,if=none,id=drive-sata55-0-5,format=raw,cache=none 
-device ide-hd,bus=sata55.5,drive=drive-sata55-0-5,id=sata55-0-5 -drive 
file=/home/image/rhel7.0-330.qcow2,if=none,id=drive-sata56-0-0,format=raw,cache=none 
-device ide-hd,bus=sata56.0,drive=drive-sata56-0-0,id=sata56-0-0 -drive 
file=/home/image/rhel7.0-331.qcow2,if=none,id=drive-sata56-0-1,format=raw,cache=none 
-device ide-hd,bus=sata56.1,drive=drive-sata56-0-1,id=sata56-0-1 -drive 
file=/home/image/rhel7.0-332.qcow2,if=none,id=drive-sata56-0-2,format=raw,cache=none 
-device ide-hd,bus=sata56.2,drive=drive-sata56-0-2,id=sata56-0-2 -drive 
file=/home/image/rhel7.0-333.qcow2,if=none,id=drive-sata56-0-3,format=raw,cache=none 
-device ide-hd,bus=sata56.3,drive=drive-sata56-0-3,id=sata56-0-3 -drive 
file=/home/image/rhel7.0-334.qcow2,if=none,id=drive-sata56-0-4,format=raw,cache=none 
-device ide-hd,bus=sata56.4,drive=drive-sata56-0-4,id=sata56-0-4 -drive 
file=/home/image/rhel7.0-335.qcow2,if=none,id=drive-sata56-0-5,format=raw,cache=none 
-device ide-hd,bus=sata56.5,drive=drive-sata56-0-5,id=sata56-0-5 -drive 
file=/home/image/rhel7.0-336.qcow2,if=none,id=drive-sata57-0-0,format=raw,cache=none 
-device ide-hd,bus=sata57.0,drive=drive-sata57-0-0,id=sata57-0-0 -drive 
file=/home/image/rhel7.0-337.qcow2,if=none,id=drive-sata57-0-1,format=raw,cache=none 
-device ide-hd,bus=sata57.1,drive=drive-sata57-0-1,id=sata57-0-1 -drive 
file=/home/image/rhel7.0-338.qcow2,if=none,id=drive-sata57-0-2,format=raw,cache=none 
-device ide-hd,bus=sata57.2,drive=drive-sata57-0-2,id=sata57-0-2 -drive 
file=/home/image/rhel7.0-339.qcow2,if=none,id=drive-sata57-0-3,format=raw,cache=none 
-device ide-hd,bus=sata57.3,drive=drive-sata57-0-3,id=sata57-0-3 -drive 
file=/home/image/rhel7.0-340.qcow2,if=none,id=drive-sata57-0-4,format=raw,cache=none 
-device ide-hd,bus=sata57.4,drive=drive-sata57-0-4,id=sata57-0-4 -drive 
file=/home/image/rhel7.0-341.qcow2,if=none,id=drive-sata57-0-5,format=raw,cache=none 
-device ide-hd,bus=sata57.5,drive=drive-sata57-0-5,id=sata57-0-5 -drive 
file=/home/image/rhel7.0-342.qcow2,if=none,id=drive-sata58-0-0,format=raw,cache=none 
-device ide-hd,bus=sata58.0,drive=drive-sata58-0-0,id=sata58-0-0 -drive 
file=/home/image/rhel7.0-343.qcow2,if=none,id=drive-sata58-0-1,format=raw,cache=none 
-device ide-hd,bus=sata58.1,drive=drive-sata58-0-1,id=sata58-0-1 -drive 
file=/home/image/rhel7.0-344.qcow2,if=none,id=drive-sata58-0-2,format=raw,cache=none 
-device ide-hd,bus=sata58.2,drive=drive-sata58-0-2,id=sata58-0-2 -drive 
file=/home/image/rhel7.0-345.qcow2,if=none,id=drive-sata58-0-3,format=raw,cache=none 
-device ide-hd,bus=sata58.3,drive=drive-sata58-0-3,id=sata58-0-3 -drive 
file=/home/image/rhel7.0-346.qcow2,if=none,id=drive-sata58-0-4,format=raw,cache=none 
-device ide-hd,bus=sata58.4,drive=drive-sata58-0-4,id=sata58-0-4 -drive 
file=/home/image/rhel7.0-347.qcow2,if=none,id=drive-sata58-0-5,format=raw,cache=none 
-device ide-hd,bus=sata58.5,drive=drive-sata58-0-5,id=sata58-0-5 -drive 
file=/home/image/rhel7.0-348.qcow2,if=none,id=drive-sata59-0-0,format=raw,cache=none 
-device ide-hd,bus=sata59.0,drive=drive-sata59-0-0,id=sata59-0-0 -drive 
file=/home/image/rhel7.0-349.qcow2,if=none,id=drive-sata59-0-1,format=raw,cache=none 
-device ide-hd,bus=sata59.1,drive=drive-sata59-0-1,id=sata59-0-1 -drive 
file=/home/image/rhel7.0-350.qcow2,if=none,id=drive-sata59-0-2,format=raw,cache=none 
-device ide-hd,bus=sata59.2,drive=drive-sata59-0-2,id=sata59-0-2 -drive 
file=/home/image/rhel7.0-351.qcow2,if=none,id=drive-sata59-0-3,format=raw,cache=none 
-device ide-hd,bus=sata59.3,drive=drive-sata59-0-3,id=sata59-0-3 -drive 
file=/home/image/rhel7.0-352.qcow2,if=none,id=drive-sata59-0-4,format=raw,cache=none 
-device ide-hd,bus=sata59.4,drive=drive-sata59-0-4,id=sata59-0-4 -drive 
file=/home/image/rhel7.0-353.qcow2,if=none,id=drive-sata59-0-5,format=raw,cache=none 
-device ide-hd,bus=sata59.5,drive=drive-sata59-0-5,id=sata59-0-5 -drive 
file=/home/image/rhel7.0-354.qcow2,if=none,id=drive-sata60-0-0,format=raw,cache=none 
-device ide-hd,bus=sata60.0,drive=drive-sata60-0-0,id=sata60-0-0 -drive 
file=/home/image/rhel7.0-355.qcow2,if=none,id=drive-sata60-0-1,format=raw,cache=none 
-device ide-hd,bus=sata60.1,drive=drive-sata60-0-1,id=sata60-0-1 -drive 
file=/home/image/rhel7.0-356.qcow2,if=none,id=drive-sata60-0-2,format=raw,cache=none 
-device ide-hd,bus=sata60.2,drive=drive-sata60-0-2,id=sata60-0-2 -drive 
file=/home/image/rhel7.0-357.qcow2,if=none,id=drive-sata60-0-3,format=raw,cache=none 
-device ide-hd,bus=sata60.3,drive=drive-sata60-0-3,id=sata60-0-3 -drive 
file=/home/image/rhel7.0-358.qcow2,if=none,id=drive-sata60-0-4,format=raw,cache=none 
-device ide-hd,bus=sata60.4,drive=drive-sata60-0-4,id=sata60-0-4 -drive 
file=/home/image/rhel7.0-359.qcow2,if=none,id=drive-sata60-0-5,format=raw,cache=none 
-device ide-hd,bus=sata60.5,drive=drive-sata60-0-5,id=sata60-0-5 -drive 
file=/home/image/rhel7.0-360.qcow2,if=none,id=drive-sata61-0-0,format=raw,cache=none 
-device ide-hd,bus=sata61.0,drive=drive-sata61-0-0,id=sata61-0-0 -drive 
file=/home/image/rhel7.0-361.qcow2,if=none,id=drive-sata61-0-1,format=raw,cache=none 
-device ide-hd,bus=sata61.1,drive=drive-sata61-0-1,id=sata61-0-1 -drive 
file=/home/image/rhel7.0-362.qcow2,if=none,id=drive-sata61-0-2,format=raw,cache=none 
-device ide-hd,bus=sata61.2,drive=drive-sata61-0-2,id=sata61-0-2 -drive 
file=/home/image/rhel7.0-363.qcow2,if=none,id=drive-sata61-0-3,format=raw,cache=none 
-device ide-hd,bus=sata61.3,drive=drive-sata61-0-3,id=sata61-0-3 -drive 
file=/home/image/rhel7.0-364.qcow2,if=none,id=drive-sata61-0-4,format=raw,cache=none 
-device ide-hd,bus=sata61.4,drive=drive-sata61-0-4,id=sata61-0-4 -drive 
file=/home/image/rhel7.0-365.qcow2,if=none,id=drive-sata61-0-5,format=raw,cache=none 
-device ide-hd,bus=sata61.5,drive=drive-sata61-0-5,id=sata61-0-5 -drive 
file=/home/image/rhel7.0-366.qcow2,if=none,id=drive-sata62-0-0,format=raw,cache=none 
-device ide-hd,bus=sata62.0,drive=drive-sata62-0-0,id=sata62-0-0 -drive 
file=/home/image/rhel7.0-367.qcow2,if=none,id=drive-sata62-0-1,format=raw,cache=none 
-device ide-hd,bus=sata62.1,drive=drive-sata62-0-1,id=sata62-0-1 -drive 
file=/home/image/rhel7.0-368.qcow2,if=none,id=drive-sata62-0-2,format=raw,cache=none 
-device ide-hd,bus=sata62.2,drive=drive-sata62-0-2,id=sata62-0-2 -drive 
file=/home/image/rhel7.0-369.qcow2,if=none,id=drive-sata62-0-3,format=raw,cache=none 
-device ide-hd,bus=sata62.3,drive=drive-sata62-0-3,id=sata62-0-3 -drive 
file=/home/image/rhel7.0-370.qcow2,if=none,id=drive-sata62-0-4,format=raw,cache=none 
-device ide-hd,bus=sata62.4,drive=drive-sata62-0-4,id=sata62-0-4 -drive 
file=/home/image/rhel7.0-371.qcow2,if=none,id=drive-sata62-0-5,format=raw,cache=none 
-device ide-hd,bus=sata62.5,drive=drive-sata62-0-5,id=sata62-0-5 -drive 
file=/home/image/rhel7.0-372.qcow2,if=none,id=drive-sata63-0-0,format=raw,cache=none 
-device ide-hd,bus=sata63.0,drive=drive-sata63-0-0,id=sata63-0-0 -drive 
file=/home/image/rhel7.0-373.qcow2,if=none,id=drive-sata63-0-1,format=raw,cache=none 
-device ide-hd,bus=sata63.1,drive=drive-sata63-0-1,id=sata63-0-1 -drive 
file=/home/image/rhel7.0-374.qcow2,if=none,id=drive-sata63-0-2,format=raw,cache=none 
-device ide-hd,bus=sata63.2,drive=drive-sata63-0-2,id=sata63-0-2 -drive 
file=/home/image/rhel7.0-375.qcow2,if=none,id=drive-sata63-0-3,format=raw,cache=none 
-device ide-hd,bus=sata63.3,drive=drive-sata63-0-3,id=sata63-0-3 -drive 
file=/home/image/rhel7.0-376.qcow2,if=none,id=drive-sata63-0-4,format=raw,cache=none 
-device ide-hd,bus=sata63.4,drive=drive-sata63-0-4,id=sata63-0-4 -drive 
file=/home/image/rhel7.0-377.qcow2,if=none,id=drive-sata63-0-5,format=raw,cache=none 
-device ide-hd,bus=sata63.5,drive=drive-sata63-0-5,id=sata63-0-5 -drive 
file=/home/image/rhel7.0-378.qcow2,if=none,id=drive-sata64-0-0,format=raw,cache=none 
-device ide-hd,bus=sata64.0,drive=drive-sata64-0-0,id=sata64-0-0 -drive 
file=/home/image/rhel7.0-379.qcow2,if=none,id=drive-sata64-0-1,format=raw,cache=none 
-device ide-hd,bus=sata64.1,drive=drive-sata64-0-1,id=sata64-0-1 -drive 
file=/home/image/rhel7.0-380.qcow2,if=none,id=drive-sata64-0-2,format=raw,cache=none 
-device ide-hd,bus=sata64.2,drive=drive-sata64-0-2,id=sata64-0-2 -drive 
file=/home/image/rhel7.0-381.qcow2,if=none,id=drive-sata64-0-3,format=raw,cache=none 
-device ide-hd,bus=sata64.3,drive=drive-sata64-0-3,id=sata64-0-3 -drive 
file=/home/image/rhel7.0-382.qcow2,if=none,id=drive-sata64-0-4,format=raw,cache=none 
-device ide-hd,bus=sata64.4,drive=drive-sata64-0-4,id=sata64-0-4 -drive 
file=/home/image/rhel7.0-383.qcow2,if=none,id=drive-sata64-0-5,format=raw,cache=none 
-device ide-hd,bus=sata64.5,drive=drive-sata64-0-5,id=sata64-0-5 -drive 
file=/home/image/rhel7.0-384.qcow2,if=none,id=drive-sata65-0-0,format=raw,cache=none 
-device ide-hd,bus=sata65.0,drive=drive-sata65-0-0,id=sata65-0-0 -drive 
file=/home/image/rhel7.0-385.qcow2,if=none,id=drive-sata65-0-1,format=raw,cache=none 
-device ide-hd,bus=sata65.1,drive=drive-sata65-0-1,id=sata65-0-1 -drive 
file=/home/image/rhel7.0-386.qcow2,if=none,id=drive-sata65-0-2,format=raw,cache=none 
-device ide-hd,bus=sata65.2,drive=drive-sata65-0-2,id=sata65-0-2 -drive 
file=/home/image/rhel7.0-387.qcow2,if=none,id=drive-sata65-0-3,format=raw,cache=none 
-device ide-hd,bus=sata65.3,drive=drive-sata65-0-3,id=sata65-0-3 -drive 
file=/home/image/rhel7.0-388.qcow2,if=none,id=drive-sata65-0-4,format=raw,cache=none 
-device ide-hd,bus=sata65.4,drive=drive-sata65-0-4,id=sata65-0-4 -drive 
file=/home/image/rhel7.0-389.qcow2,if=none,id=drive-sata65-0-5,format=raw,cache=none 
-device ide-hd,bus=sata65.5,drive=drive-sata65-0-5,id=sata65-0-5 -drive 
file=/home/image/rhel7.0-390.qcow2,if=none,id=drive-sata66-0-0,format=raw,cache=none 
-device ide-hd,bus=sata66.0,drive=drive-sata66-0-0,id=sata66-0-0 -drive 
file=/home/image/rhel7.0-391.qcow2,if=none,id=drive-sata66-0-1,format=raw,cache=none 
-device ide-hd,bus=sata66.1,drive=drive-sata66-0-1,id=sata66-0-1 -drive 
file=/home/image/rhel7.0-392.qcow2,if=none,id=drive-sata66-0-2,format=raw,cache=none 
-device ide-hd,bus=sata66.2,drive=drive-sata66-0-2,id=sata66-0-2 -drive 
file=/home/image/rhel7.0-393.qcow2,if=none,id=drive-sata66-0-3,format=raw,cache=none 
-device ide-hd,bus=sata66.3,drive=drive-sata66-0-3,id=sata66-0-3 -drive 
file=/home/image/rhel7.0-394.qcow2,if=none,id=drive-sata66-0-4,format=raw,cache=none 
-device ide-hd,bus=sata66.4,drive=drive-sata66-0-4,id=sata66-0-4 -drive 
file=/home/image/rhel7.0-395.qcow2,if=none,id=drive-sata66-0-5,format=raw,cache=none 
-device ide-hd,bus=sata66.5,drive=drive-sata66-0-5,id=sata66-0-5 -drive 
file=/home/image/rhel7.0-396.qcow2,if=none,id=drive-sata67-0-0,format=raw,cache=none 
-device ide-hd,bus=sata67.0,drive=drive-sata67-0-0,id=sata67-0-0 -drive 
file=/home/image/rhel7.0-397.qcow2,if=none,id=drive-sata67-0-1,format=raw,cache=none 
-device ide-hd,bus=sata67.1,drive=drive-sata67-0-1,id=sata67-0-1 -drive 
file=/home/image/rhel7.0-398.qcow2,if=none,id=drive-sata67-0-2,format=raw,cache=none 
-device ide-hd,bus=sata67.2,drive=drive-sata67-0-2,id=sata67-0-2 -drive 
file=/home/image/rhel7.0-399.qcow2,if=none,id=drive-sata67-0-3,format=raw,cache=none 
-device ide-hd,bus=sata67.3,drive=drive-sata67-0-3,id=sata67-0-3 -drive 
file=/home/image/rhel7.0-400.qcow2,if=none,id=drive-sata67-0-4,format=raw,cache=none 
-device ide-hd,bus=sata67.4,drive=drive-sata67-0-4,id=sata67-0-4 -drive 
file=/home/image/rhel7.0-401.qcow2,if=none,id=drive-sata67-0-5,format=raw,cache=none 
-device ide-hd,bus=sata67.5,drive=drive-sata67-0-5,id=sata67-0-5 -drive 
file=/home/image/rhel7.0-402.qcow2,if=none,id=drive-sata68-0-0,format=raw,cache=none 
-device ide-hd,bus=sata68.0,drive=drive-sata68-0-0,id=sata68-0-0 -drive 
file=/home/image/rhel7.0-403.qcow2,if=none,id=drive-sata68-0-1,format=raw,cache=none 
-device ide-hd,bus=sata68.1,drive=drive-sata68-0-1,id=sata68-0-1 -drive 
file=/home/image/rhel7.0-404.qcow2,if=none,id=drive-sata68-0-2,format=raw,cache=none 
-device ide-hd,bus=sata68.2,drive=drive-sata68-0-2,id=sata68-0-2 -drive 
file=/home/image/rhel7.0-405.qcow2,if=none,id=drive-sata68-0-3,format=raw,cache=none 
-device ide-hd,bus=sata68.3,drive=drive-sata68-0-3,id=sata68-0-3 -drive 
file=/home/image/rhel7.0-406.qcow2,if=none,id=drive-sata68-0-4,format=raw,cache=none 
-device ide-hd,bus=sata68.4,drive=drive-sata68-0-4,id=sata68-0-4 -drive 
file=/home/image/rhel7.0-407.qcow2,if=none,id=drive-sata68-0-5,format=raw,cache=none 
-device ide-hd,bus=sata68.5,drive=drive-sata68-0-5,id=sata68-0-5 -drive 
file=/home/image/rhel7.0-408.qcow2,if=none,id=drive-sata69-0-0,format=raw,cache=none 
-device ide-hd,bus=sata69.0,drive=drive-sata69-0-0,id=sata69-0-0 -drive 
file=/home/image/rhel7.0-409.qcow2,if=none,id=drive-sata69-0-1,format=raw,cache=none 
-device ide-hd,bus=sata69.1,drive=drive-sata69-0-1,id=sata69-0-1 -drive 
file=/home/image/rhel7.0-410.qcow2,if=none,id=drive-sata69-0-2,format=raw,cache=none 
-device ide-hd,bus=sata69.2,drive=drive-sata69-0-2,id=sata69-0-2 -drive 
file=/home/image/rhel7.0-411.qcow2,if=none,id=drive-sata69-0-3,format=raw,cache=none 
-device ide-hd,bus=sata69.3,drive=drive-sata69-0-3,id=sata69-0-3 -drive 
file=/home/image/rhel7.0-412.qcow2,if=none,id=drive-sata69-0-4,format=raw,cache=none 
-device ide-hd,bus=sata69.4,drive=drive-sata69-0-4,id=sata69-0-4 -drive 
file=/home/image/rhel7.0-413.qcow2,if=none,id=drive-sata69-0-5,format=raw,cache=none 
-device ide-hd,bus=sata69.5,drive=drive-sata69-0-5,id=sata69-0-5 -drive 
file=/home/image/rhel7.0-414.qcow2,if=none,id=drive-sata70-0-0,format=raw,cache=none 
-device ide-hd,bus=sata70.0,drive=drive-sata70-0-0,id=sata70-0-0 -drive 
file=/home/image/rhel7.0-415.qcow2,if=none,id=drive-sata70-0-1,format=raw,cache=none 
-device ide-hd,bus=sata70.1,drive=drive-sata70-0-1,id=sata70-0-1 -drive 
file=/home/image/rhel7.0-416.qcow2,if=none,id=drive-sata70-0-2,format=raw,cache=none 
-device ide-hd,bus=sata70.2,drive=drive-sata70-0-2,id=sata70-0-2 -drive 
file=/home/image/rhel7.0-417.qcow2,if=none,id=drive-sata70-0-3,format=raw,cache=none 
-device ide-hd,bus=sata70.3,drive=drive-sata70-0-3,id=sata70-0-3 -drive 
file=/home/image/rhel7.0-418.qcow2,if=none,id=drive-sata70-0-4,format=raw,cache=none 
-device ide-hd,bus=sata70.4,drive=drive-sata70-0-4,id=sata70-0-4 -drive 
file=/home/image/rhel7.0-419.qcow2,if=none,id=drive-sata70-0-5,format=raw,cache=none 
-device ide-hd,bus=sata70.5,drive=drive-sata70-0-5,id=sata70-0-5 -drive 
file=/home/image/rhel7.0-420.qcow2,if=none,id=drive-sata71-0-0,format=raw,cache=none 
-device ide-hd,bus=sata71.0,drive=drive-sata71-0-0,id=sata71-0-0 -drive 
file=/home/image/rhel7.0-421.qcow2,if=none,id=drive-sata71-0-1,format=raw,cache=none 
-device ide-hd,bus=sata71.1,drive=drive-sata71-0-1,id=sata71-0-1 -drive 
file=/home/image/rhel7.0-422.qcow2,if=none,id=drive-sata71-0-2,format=raw,cache=none 
-device ide-hd,bus=sata71.2,drive=drive-sata71-0-2,id=sata71-0-2 -drive 
file=/home/image/rhel7.0-423.qcow2,if=none,id=drive-sata71-0-3,format=raw,cache=none 
-device ide-hd,bus=sata71.3,drive=drive-sata71-0-3,id=sata71-0-3 -drive 
file=/home/image/rhel7.0-424.qcow2,if=none,id=drive-sata71-0-4,format=raw,cache=none 
-device ide-hd,bus=sata71.4,drive=drive-sata71-0-4,id=sata71-0-4 -drive 
file=/home/image/rhel7.0-425.qcow2,if=none,id=drive-sata71-0-5,format=raw,cache=none 
-device ide-hd,bus=sata71.5,drive=drive-sata71-0-5,id=sata71-0-5 -drive 
file=/home/image/rhel7.0-426.qcow2,if=none,id=drive-sata72-0-0,format=raw,cache=none 
-device ide-hd,bus=sata72.0,drive=drive-sata72-0-0,id=sata72-0-0 -drive 
file=/home/image/rhel7.0-427.qcow2,if=none,id=drive-sata72-0-1,format=raw,cache=none 
-device ide-hd,bus=sata72.1,drive=drive-sata72-0-1,id=sata72-0-1 -drive 
file=/home/image/rhel7.0-428.qcow2,if=none,id=drive-sata72-0-2,format=raw,cache=none 
-device ide-hd,bus=sata72.2,drive=drive-sata72-0-2,id=sata72-0-2 -drive 
file=/home/image/rhel7.0-429.qcow2,if=none,id=drive-sata72-0-3,format=raw,cache=none 
-device ide-hd,bus=sata72.3,drive=drive-sata72-0-3,id=sata72-0-3 -drive 
file=/home/image/rhel7.0-430.qcow2,if=none,id=drive-sata72-0-4,format=raw,cache=none 
-device ide-hd,bus=sata72.4,drive=drive-sata72-0-4,id=sata72-0-4 -drive 
file=/home/image/rhel7.0-431.qcow2,if=none,id=drive-sata72-0-5,format=raw,cache=none 
-device ide-hd,bus=sata72.5,drive=drive-sata72-0-5,id=sata72-0-5 -drive 
file=/home/image/rhel7.0-432.qcow2,if=none,id=drive-sata73-0-0,format=raw,cache=none 
-device ide-hd,bus=sata73.0,drive=drive-sata73-0-0,id=sata73-0-0 -drive 
file=/home/image/rhel7.0-433.qcow2,if=none,id=drive-sata73-0-1,format=raw,cache=none 
-device ide-hd,bus=sata73.1,drive=drive-sata73-0-1,id=sata73-0-1 -drive 
file=/home/image/rhel7.0-434.qcow2,if=none,id=drive-sata73-0-2,format=raw,cache=none 
-device ide-hd,bus=sata73.2,drive=drive-sata73-0-2,id=sata73-0-2 -drive 
file=/home/image/rhel7.0-435.qcow2,if=none,id=drive-sata73-0-3,format=raw,cache=none 
-device ide-hd,bus=sata73.3,drive=drive-sata73-0-3,id=sata73-0-3 -drive 
file=/home/image/rhel7.0-436.qcow2,if=none,id=drive-sata73-0-4,format=raw,cache=none 
-device ide-hd,bus=sata73.4,drive=drive-sata73-0-4,id=sata73-0-4 -drive 
file=/home/image/rhel7.0-437.qcow2,if=none,id=drive-sata73-0-5,format=raw,cache=none 
-device ide-hd,bus=sata73.5,drive=drive-sata73-0-5,id=sata73-0-5 -drive 
file=/home/image/rhel7.0-438.qcow2,if=none,id=drive-sata74-0-0,format=raw,cache=none 
-device ide-hd,bus=sata74.0,drive=drive-sata74-0-0,id=sata74-0-0 -drive 
file=/home/image/rhel7.0-439.qcow2,if=none,id=drive-sata74-0-1,format=raw,cache=none 
-device ide-hd,bus=sata74.1,drive=drive-sata74-0-1,id=sata74-0-1 -drive 
file=/home/image/rhel7.0-440.qcow2,if=none,id=drive-sata74-0-2,format=raw,cache=none 
-device ide-hd,bus=sata74.2,drive=drive-sata74-0-2,id=sata74-0-2 -drive 
file=/home/image/rhel7.0-441.qcow2,if=none,id=drive-sata74-0-3,format=raw,cache=none 
-device ide-hd,bus=sata74.3,drive=drive-sata74-0-3,id=sata74-0-3 -drive 
file=/home/image/rhel7.0-442.qcow2,if=none,id=drive-sata74-0-4,format=raw,cache=none 
-device ide-hd,bus=sata74.4,drive=drive-sata74-0-4,id=sata74-0-4 -drive 
file=/home/image/rhel7.0-443.qcow2,if=none,id=drive-sata74-0-5,format=raw,cache=none 
-device ide-hd,bus=sata74.5,drive=drive-sata74-0-5,id=sata74-0-5 -drive 
file=/home/image/rhel7.0-444.qcow2,if=none,id=drive-sata75-0-0,format=raw,cache=none 
-device ide-hd,bus=sata75.0,drive=drive-sata75-0-0,id=sata75-0-0 -drive 
file=/home/image/rhel7.0-445.qcow2,if=none,id=drive-sata75-0-1,format=raw,cache=none 
-device ide-hd,bus=sata75.1,drive=drive-sata75-0-1,id=sata75-0-1 -drive 
file=/home/image/rhel7.0-446.qcow2,if=none,id=drive-sata75-0-2,format=raw,cache=none 
-device ide-hd,bus=sata75.2,drive=drive-sata75-0-2,id=sata75-0-2 -drive 
file=/home/image/rhel7.0-447.qcow2,if=none,id=drive-sata75-0-3,format=raw,cache=none 
-device ide-hd,bus=sata75.3,drive=drive-sata75-0-3,id=sata75-0-3 -drive 
file=/home/image/rhel7.0-448.qcow2,if=none,id=drive-sata75-0-4,format=raw,cache=none 
-device ide-hd,bus=sata75.4,drive=drive-sata75-0-4,id=sata75-0-4 -drive 
file=/home/image/rhel7.0-449.qcow2,if=none,id=drive-sata75-0-5,format=raw,cache=none 
-device ide-hd,bus=sata75.5,drive=drive-sata75-0-5,id=sata75-0-5 -drive 
file=/home/image/rhel7.0-450.qcow2,if=none,id=drive-sata76-0-0,format=raw,cache=none 
-device ide-hd,bus=sata76.0,drive=drive-sata76-0-0,id=sata76-0-0 -drive 
file=/home/image/rhel7.0-451.qcow2,if=none,id=drive-sata76-0-1,format=raw,cache=none 
-device ide-hd,bus=sata76.1,drive=drive-sata76-0-1,id=sata76-0-1 -drive 
file=/home/image/rhel7.0-452.qcow2,if=none,id=drive-sata76-0-2,format=raw,cache=none 
-device ide-hd,bus=sata76.2,drive=drive-sata76-0-2,id=sata76-0-2 -drive 
file=/home/image/rhel7.0-453.qcow2,if=none,id=drive-sata76-0-3,format=raw,cache=none 
-device ide-hd,bus=sata76.3,drive=drive-sata76-0-3,id=sata76-0-3 -drive 
file=/home/image/rhel7.0-454.qcow2,if=none,id=drive-sata76-0-4,format=raw,cache=none 
-device ide-hd,bus=sata76.4,drive=drive-sata76-0-4,id=sata76-0-4 -drive 
file=/home/image/rhel7.0-455.qcow2,if=none,id=drive-sata76-0-5,format=raw,cache=none 
-device ide-hd,bus=sata76.5,drive=drive-sata76-0-5,id=sata76-0-5 -drive 
file=/home/image/rhel7.0-456.qcow2,if=none,id=drive-sata77-0-0,format=raw,cache=none 
-device ide-hd,bus=sata77.0,drive=drive-sata77-0-0,id=sata77-0-0 -drive 
file=/home/image/rhel7.0-457.qcow2,if=none,id=drive-sata77-0-1,format=raw,cache=none 
-device ide-hd,bus=sata77.1,drive=drive-sata77-0-1,id=sata77-0-1 -drive 
file=/home/image/rhel7.0-458.qcow2,if=none,id=drive-sata77-0-2,format=raw,cache=none 
-device ide-hd,bus=sata77.2,drive=drive-sata77-0-2,id=sata77-0-2 -drive 
file=/home/image/rhel7.0-459.qcow2,if=none,id=drive-sata77-0-3,format=raw,cache=none 
-device ide-hd,bus=sata77.3,drive=drive-sata77-0-3,id=sata77-0-3 -drive 
file=/home/image/rhel7.0-460.qcow2,if=none,id=drive-sata77-0-4,format=raw,cache=none 
-device ide-hd,bus=sata77.4,drive=drive-sata77-0-4,id=sata77-0-4 -drive 
file=/home/image/rhel7.0-461.qcow2,if=none,id=drive-sata77-0-5,format=raw,cache=none 
-device ide-hd,bus=sata77.5,drive=drive-sata77-0-5,id=sata77-0-5 -drive 
file=/home/image/rhel7.0-462.qcow2,if=none,id=drive-sata78-0-0,format=raw,cache=none 
-device ide-hd,bus=sata78.0,drive=drive-sata78-0-0,id=sata78-0-0 -drive 
file=/home/image/rhel7.0-463.qcow2,if=none,id=drive-sata78-0-1,format=raw,cache=none 
-device ide-hd,bus=sata78.1,drive=drive-sata78-0-1,id=sata78-0-1 -drive 
file=/home/image/rhel7.0-464.qcow2,if=none,id=drive-sata78-0-2,format=raw,cache=none 
-device ide-hd,bus=sata78.2,drive=drive-sata78-0-2,id=sata78-0-2 -drive 
file=/home/image/rhel7.0-465.qcow2,if=none,id=drive-sata78-0-3,format=raw,cache=none 
-device ide-hd,bus=sata78.3,drive=drive-sata78-0-3,id=sata78-0-3 -drive 
file=/home/image/rhel7.0-466.qcow2,if=none,id=drive-sata78-0-4,format=raw,cache=none 
-device ide-hd,bus=sata78.4,drive=drive-sata78-0-4,id=sata78-0-4 -drive 
file=/home/image/rhel7.0-467.qcow2,if=none,id=drive-sata78-0-5,format=raw,cache=none 
-device ide-hd,bus=sata78.5,drive=drive-sata78-0-5,id=sata78-0-5 -drive 
file=/home/image/rhel7.0-468.qcow2,if=none,id=drive-sata79-0-0,format=raw,cache=none 
-device ide-hd,bus=sata79.0,drive=drive-sata79-0-0,id=sata79-0-0 -drive 
file=/home/image/rhel7.0-469.qcow2,if=none,id=drive-sata79-0-1,format=raw,cache=none 
-device ide-hd,bus=sata79.1,drive=drive-sata79-0-1,id=sata79-0-1 -drive 
file=/home/image/rhel7.0-470.qcow2,if=none,id=drive-sata79-0-2,format=raw,cache=none 
-device ide-hd,bus=sata79.2,drive=drive-sata79-0-2,id=sata79-0-2 -drive 
file=/home/image/rhel7.0-471.qcow2,if=none,id=drive-sata79-0-3,format=raw,cache=none 
-device ide-hd,bus=sata79.3,drive=drive-sata79-0-3,id=sata79-0-3 -drive 
file=/home/image/rhel7.0-472.qcow2,if=none,id=drive-sata79-0-4,format=raw,cache=none 
-device ide-hd,bus=sata79.4,drive=drive-sata79-0-4,id=sata79-0-4 -drive 
file=/home/image/rhel7.0-473.qcow2,if=none,id=drive-sata79-0-5,format=raw,cache=none 
-device ide-hd,bus=sata79.5,drive=drive-sata79-0-5,id=sata79-0-5 -drive 
file=/home/image/rhel7.0-474.qcow2,if=none,id=drive-sata80-0-0,format=raw,cache=none 
-device ide-hd,bus=sata80.0,drive=drive-sata80-0-0,id=sata80-0-0 -drive 
file=/home/image/rhel7.0-475.qcow2,if=none,id=drive-sata80-0-1,format=raw,cache=none 
-device ide-hd,bus=sata80.1,drive=drive-sata80-0-1,id=sata80-0-1 -drive 
file=/home/image/rhel7.0-476.qcow2,if=none,id=drive-sata80-0-2,format=raw,cache=none 
-device ide-hd,bus=sata80.2,drive=drive-sata80-0-2,id=sata80-0-2 -drive 
file=/home/image/rhel7.0-477.qcow2,if=none,id=drive-sata80-0-3,format=raw,cache=none 
-device ide-hd,bus=sata80.3,drive=drive-sata80-0-3,id=sata80-0-3 -drive 
file=/home/image/rhel7.0-478.qcow2,if=none,id=drive-sata80-0-4,format=raw,cache=none 
-device ide-hd,bus=sata80.4,drive=drive-sata80-0-4,id=sata80-0-4 -drive 
file=/home/image/rhel7.0-479.qcow2,if=none,id=drive-sata80-0-5,format=raw,cache=none 
-device ide-hd,bus=sata80.5,drive=drive-sata80-0-5,id=sata80-0-5 -drive 
file=/home/image/rhel7.0-480.qcow2,if=none,id=drive-sata81-0-0,format=raw,cache=none 
-device ide-hd,bus=sata81.0,drive=drive-sata81-0-0,id=sata81-0-0 -drive 
file=/home/image/rhel7.0-481.qcow2,if=none,id=drive-sata81-0-1,format=raw,cache=none 
-device ide-hd,bus=sata81.1,drive=drive-sata81-0-1,id=sata81-0-1 -drive 
file=/home/image/rhel7.0-482.qcow2,if=none,id=drive-sata81-0-2,format=raw,cache=none 
-device ide-hd,bus=sata81.2,drive=drive-sata81-0-2,id=sata81-0-2 -drive 
file=/home/image/rhel7.0-483.qcow2,if=none,id=drive-sata81-0-3,format=raw,cache=none 
-device ide-hd,bus=sata81.3,drive=drive-sata81-0-3,id=sata81-0-3 -drive 
file=/home/image/rhel7.0-484.qcow2,if=none,id=drive-sata81-0-4,format=raw,cache=none 
-device ide-hd,bus=sata81.4,drive=drive-sata81-0-4,id=sata81-0-4 -drive 
file=/home/image/rhel7.0-485.qcow2,if=none,id=drive-sata81-0-5,format=raw,cache=none 
-device ide-hd,bus=sata81.5,drive=drive-sata81-0-5,id=sata81-0-5 -drive 
file=/home/image/rhel7.0-486.qcow2,if=none,id=drive-sata82-0-0,format=raw,cache=none 
-device ide-hd,bus=sata82.0,drive=drive-sata82-0-0,id=sata82-0-0 -drive 
file=/home/image/rhel7.0-487.qcow2,if=none,id=drive-sata82-0-1,format=raw,cache=none 
-device ide-hd,bus=sata82.1,drive=drive-sata82-0-1,id=sata82-0-1 -drive 
file=/home/image/rhel7.0-488.qcow2,if=none,id=drive-sata82-0-2,format=raw,cache=none 
-device ide-hd,bus=sata82.2,drive=drive-sata82-0-2,id=sata82-0-2 -drive 
file=/home/image/rhel7.0-489.qcow2,if=none,id=drive-sata82-0-3,format=raw,cache=none 
-device ide-hd,bus=sata82.3,drive=drive-sata82-0-3,id=sata82-0-3 -drive 
file=/home/image/rhel7.0-490.qcow2,if=none,id=drive-sata82-0-4,format=raw,cache=none 
-device ide-hd,bus=sata82.4,drive=drive-sata82-0-4,id=sata82-0-4 -drive 
file=/home/image/rhel7.0-491.qcow2,if=none,id=drive-sata82-0-5,format=raw,cache=none 
-device ide-hd,bus=sata82.5,drive=drive-sata82-0-5,id=sata82-0-5 -drive 
file=/home/image/rhel7.0-492.qcow2,if=none,id=drive-sata83-0-0,format=raw,cache=none 
-device ide-hd,bus=sata83.0,drive=drive-sata83-0-0,id=sata83-0-0 -drive 
file=/home/image/rhel7.0-493.qcow2,if=none,id=drive-sata83-0-1,format=raw,cache=none 
-device ide-hd,bus=sata83.1,drive=drive-sata83-0-1,id=sata83-0-1 -drive 
file=/home/image/rhel7.0-494.qcow2,if=none,id=drive-sata83-0-2,format=raw,cache=none 
-device ide-hd,bus=sata83.2,drive=drive-sata83-0-2,id=sata83-0-2 -drive 
file=/home/image/rhel7.0-495.qcow2,if=none,id=drive-sata83-0-3,format=raw,cache=none 
-device ide-hd,bus=sata83.3,drive=drive-sata83-0-3,id=sata83-0-3 -drive 
file=/home/image/rhel7.0-496.qcow2,if=none,id=drive-sata83-0-4,format=raw,cache=none 
-device ide-hd,bus=sata83.4,drive=drive-sata83-0-4,id=sata83-0-4 -drive 
file=/home/image/rhel7.0-497.qcow2,if=none,id=drive-sata83-0-5,format=raw,cache=none 
-device ide-hd,bus=sata83.5,drive=drive-sata83-0-5,id=sata83-0-5 -drive 
file=/home/image/rhel7.0-498.qcow2,if=none,id=drive-sata84-0-0,format=raw,cache=none 
-device ide-hd,bus=sata84.0,drive=drive-sata84-0-0,id=sata84-0-0 -drive 
file=/home/image/rhel7.0-499.qcow2,if=none,id=drive-sata84-0-1,format=raw,cache=none 
-device ide-hd,bus=sata84.1,drive=drive-sata84-0-1,id=sata84-0-1 -drive 
file=/home/image/rhel7.0-500.qcow2,if=none,id=drive-virtio-disk0,format=raw 
-device 
virtio-blk-pci,scsi=off,bus=pci.0,addr=0xc,drive=drive-virtio-disk0,id=virtio-disk0 
-netdev tap,fd=24,id=hostnet0 -device 
rtl8139,netdev=hostnet0,id=net0,mac=52:54:00:c2:9d:dd,bus=pci.0,addr=0xb 
-vnc 0.0.0.0:0 -k en-us -device cirrus-vga,id=video0,bus=pci.0,addr=0x7 
-device virtio-balloon-pci,id=balloon0,bus=pci.0,addr=0xa -msg timestamp=on

>
>
>
>
