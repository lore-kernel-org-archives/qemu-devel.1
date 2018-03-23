Received: from eggs.gnu.org ([2001:4830:134:3::10]:59047)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lizhijian@cn.fujitsu.com>) id 1ezI9y-0000FK-2R
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 04:34:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lizhijian@cn.fujitsu.com>) id 1ezI9u-0007Kz-7m
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 04:34:50 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:33259
	helo=heian.cn.fujitsu.com) by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lizhijian@cn.fujitsu.com>) id 1ezI9t-0007K3-3s
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 04:34:46 -0400
From: Li Zhijian <lizhijian@cn.fujitsu.com>
References: <152056405865.7543.8980677605113063936.malonedeb@wampee.canonical.com>
	<152142533512.7381.1938340023148732379.malone@soybean.canonical.com>
	<CAK3tnvK-zMB1t7+jdxa0o+4f1c05=sbuDpRw0QWGot0CW-ZFUw@mail.gmail.com>
	<83fccfcd-f3d5-95cf-5d2f-87c29ac6f9f0@cn.fujitsu.com>
Message-ID: <1bf88958-e3d1-d456-96f0-464cfcdb6212@cn.fujitsu.com>
Date: Fri, 23 Mar 2018 16:34:36 +0800
MIME-Version: 1.0
In-Reply-To: <83fccfcd-f3d5-95cf-5d2f-87c29ac6f9f0@cn.fujitsu.com>
Content-Type: multipart/mixed; boundary="------------C89AD310A4777CE142EFCBFB"
Content-Language: en-US
Subject: Re: [Qemu-devel] [Bug 1754542] Re: colo: vm crash with segmentation
 fault
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Zhang Chen <zhangckid@gmail.com>, Bug 1754542 <1754542@bugs.launchpad.net>, qemu-devel@nongnu.org, zhang.zhanghailiang@huawei.com, Lukas Straub <lukasstraub2@web.de>

--------------C89AD310A4777CE142EFCBFB
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit

Just noticed that's a little old, you may need to rebase it


Thanks


On 03/23/2018 11:51 AM, Li Zhijian wrote:
>
>
> On 03/21/2018 02:04 PM, Zhang Chen wrote:
>> Hi Suiheng,
>>
>> I made a new guest image and retest it, and got the same bug from latest branch.
>> I found that after the COLO checkpoint begin, the secondary guest always send
>> reset request to Qemu like someone still push the reset button in the guest.
>> And this bug occurred in COLO frame related codes. This part of codes wrote
>> by Li zhijian and Zhang hailiang and currently maintained by Zhang hailiang.
>> So, I add them to this thread.
>>
>> CC Zhijian and Hailiang:
>> Any idea or comments about this bug?
>
> One clue is the memory of SVM not is same with PVM.
> we can try to compare the memory after checkpoint, i had a draft patch to do this before.
>
>
> Thanks
>
>
>
>
>>
>> If you want to test COLO currently, you can try the old version of COLO:
>> https://github.com/zhangckid/qemu/tree/qemu-colo-18mar10-legacy
>>
>>
>> Thanks
>> Zhang Chen
>>
>> On Mon, Mar 19, 2018 at 10:08 AM, 李穗恒 <1754542@bugs.launchpad.net <mailto:1754542@bugs.launchpad.net>> wrote:
>>
>>     Hi Zhang Chen，
>>     I follow the https://wiki.qemu.org/Features/COLO <https://wiki.qemu.org/Features/COLO>, And Vm no crash.
>>     But SVM rebooting constantly after print RESET, PVM normal startup.
>>
>>     Secondary:
>>     {"timestamp": {"seconds": 1521421788, "microseconds": 541058}, "event": "RESUME"}
>>     {"timestamp": {"seconds": 1521421808, "microseconds": 493484}, "event": "STOP"}
>>     {"timestamp": {"seconds": 1521421808, "microseconds": 686466}, "event": "RESUME"}
>>     {"timestamp": {"seconds": 1521421808, "microseconds": 696152}, "event": "RESET", "data": {"guest": true}}
>>     {"timestamp": {"seconds": 1521421808, "microseconds": 740653}, "event": "RESET", "data": {"guest": true}}
>>     {"timestamp": {"seconds": 1521421818, "microseconds": 742222}, "event": "STOP"}
>>     {"timestamp": {"seconds": 1521421818, "microseconds": 969883}, "event": "RESUME"}
>>     {"timestamp": {"seconds": 1521421818, "microseconds": 979986}, "event": "RESET", "data": {"guest": true}}
>>     {"timestamp": {"seconds": 1521421819, "microseconds": 22652}, "event": "RESET", "data": {"guest": true}}
>>
>>
>>     The command(I run two VM in sample machine):
>>
>>     Primary:
>>     sudo /home/lee/Documents/qemu/x86_64-softmmu/qemu-system-x86_64 -enable-kvm -boot c -m 2048 -smp 2 -qmp stdio  -name primary -cpu qemu64,+kvmclock -device piix3-usb-uhci -device usb-tablet \
>>         -netdev tap,id=hn0,vhost=off,script=/etc/qemu-ifup,downscript=/etc/qemu-ifdown -device rtl8139,id=e0,netdev=hn0 \
>>         -chardev socket,id=mirror0,host=192.168.0.33,port=9003,server,nowait \
>>         -chardev socket,id=compare1,host=192.168.0.33,port=9004,server,wait \
>>         -chardev socket,id=compare0,host=192.168.0.33,port=9001,server,nowait \
>>         -chardev socket,id=compare0-0,host=192.168.0.33,port=9001 \
>>         -chardev socket,id=compare_out,host=192.168.0.33,port=9005,server,nowait \
>>         -chardev socket,id=compare_out0,host=192.168.0.33,port=9005 \
>>         -object filter-mirror,id=m0,netdev=hn0,queue=tx,outdev=mirror0 \
>>         -object filter-redirector,netdev=hn0,id=redire0,queue=rx,indev=compare_out \
>>         -object filter-redirector,netdev=hn0,id=redire1,queue=rx,outdev=compare0 \
>>         -object iothread,id=iothread1 \
>>         -object colo-compare,id=comp0,primary_in=compare0-0,secondary_in=compare1,outdev=compare_out0,iothread=iothread1 \
>>         -drive if=ide,id=colo-disk0,driver=quorum,read-pattern=fifo,vote-threshold=1,children.0.file.filename=/var/lib/libvirt/images/1.raw,children.0.driver=raw -S
>>
>>     Secondary:
>>     sudo /home/lee/Documents/qemu/x86_64-softmmu/qemu-system-x86_64 -boot c -m 2048 -smp 2 -qmp stdio  -name secondary -enable-kvm -cpu qemu64,+kvmclock \
>>         -device piix3-usb-uhci -device usb-tablet \
>>         -netdev tap,id=hn0,vhost=off,script=/etc/qemu-ifup,downscript=/etc/qemu-ifdown \
>>         -device rtl8139,netdev=hn0 \
>>         -chardev socket,id=red0,host=192.168.0.33,port=9003,reconnect=1 \
>>         -chardev socket,id=red1,host=192.168.0.33,port=9004,reconnect=1 \
>>         -object filter-redirector,id=f1,netdev=hn0,queue=tx,indev=red0 \
>>         -object filter-redirector,id=f2,netdev=hn0,queue=rx,outdev=red1 \
>>         -object filter-rewriter,id=rew0,netdev=hn0,queue=all \
>>         -drive if=none,id=colo-disk0,file.filename=/var/lib/libvirt/images/2.raw,driver=raw,node-name=node0 \
>>         -drive if=ide,id=active-disk0,driver=replication,mode=secondary,file.driver=qcow2,top-id=active-disk0,file.file.filename=/mnt/ramfs/active_disk.img,file.backing.driver=qcow2,file.backing.file.filename=/mnt/ramfs/hidden_disk.img,file.backing.backing=colo-disk0 \
>>         -incoming tcp:0:8888
>>
>>     Secondary:
>>       {'execute':'qmp_capabilities'}
>>       { 'execute': 'nbd-server-start',
>>         'arguments': {'addr': {'type': 'inet', 'data': {'host': '192.168.0.33', 'port': '8889'} } }
>>       }
>>       {'execute': 'nbd-server-add', 'arguments': {'device': 'colo-disk0', 'writable': true } }
>>       {'execute': 'trace-event-set-state', 'arguments': {'name': 'colo*', 'enable': true} }
>>
>>
>>     Primary:
>>       {'execute':'qmp_capabilities'}
>>       { 'execute': 'human-monitor-command',
>>         'arguments': {'command-line': 'drive_add -n buddy driver=replication,mode=primary,file.driver=nbd,file.host=192.168.0.33,file.port=8889,file.export=colo-disk0,node-name=node0'}}
>>       { 'execute':'x-blockdev-change', 'arguments':{'parent': 'colo-disk0', 'node': 'node0' } }
>>       { 'execute': 'migrate-set-capabilities',
>>             'arguments': {'capabilities': [ {'capability': 'x-colo', 'state': true } ] } }
>>       { 'execute': 'migrate', 'arguments': {'uri': 'tcp:192.168.0.33:8888 <http://192.168.0.33:8888>' } }
>>
>>     Thanks
>>     Suiheng
>>
>>     --
>>     You received this bug notification because you are subscribed to the bug
>>     report.
>>     https://bugs.launchpad.net/bugs/1754542 <https://bugs.launchpad.net/bugs/1754542>
>>
>>     Title:
>>       colo:  vm crash with segmentation fault
>>
>>     Status in QEMU:
>>       New
>>
>>     Bug description:
>>       I use Arch Linux x86_64
>>       Zhang Chen's(https://github.com/zhangckid/qemu/tree/qemu-colo-18mar10 <https://github.com/zhangckid/qemu/tree/qemu-colo-18mar10>)
>>       Following document 'COLO-FT.txt',
>>       I test colo feature on my hosts
>>
>>       I run this command
>>       Primary:
>>       sudo /usr/local/bin/qemu-system-x86_64 -enable-kvm -m 2048 -smp 2 -qmp stdio -name primary \
>>       -device piix3-usb-uhci \
>>       -device usb-tablet -netdev tap,id=hn0,vhost=off \
>>       -device virtio-net-pci,id=net-pci0,netdev=hn0 \
>>       -drive if=virtio,id=primary-disk0,driver=quorum,read-pattern=fifo,vote-threshold=1,\
>>       children.0.file.filename=/var/lib/libvirt/images/1.raw,\
>>       children.0.driver=raw -S
>>
>>       Secondary:
>>       sudo /usr/local/bin/qemu-system-x86_64 -enable-kvm -m 2048 -smp 2 -qmp stdio -name secondary \
>>       -device piix3-usb-uhci \
>>       -device usb-tablet -netdev tap,id=hn0,vhost=off \
>>       -device virtio-net-pci,id=net-pci0,netdev=hn0 \
>>       -drive if=none,id=secondary-disk0,file.filename=/var/lib/libvirt/images/2.raw,driver=raw,node-name=node0 \
>>       -drive if=virtio,id=active-disk0,driver=replication,mode=secondary,\
>>       file.driver=qcow2,top-id=active-disk0,\
>>       file.file.filename=/mnt/ramfs/active_disk.img,\
>>       file.backing.driver=qcow2,\
>>       file.backing.file.filename=/mnt/ramfs/hidden_disk.img,\
>>       file.backing.backing=secondary-disk0 \
>>       -incoming tcp:0:8888
>>
>>       Secondary:
>>       {'execute':'qmp_capabilities'}
>>       { 'execute': 'nbd-server-start',
>>         'arguments': {'addr': {'type': 'inet', 'data': {'host': '192.168.0.34', 'port': '8889'} } }
>>       }
>>       {'execute': 'nbd-server-add', 'arguments': {'device': 'secondary-disk0', 'writable': true } }
>>
>>       Primary:
>>       {'execute':'qmp_capabilities'}
>>       { 'execute': 'human-monitor-command',
>>         'arguments': {'command-line': 'drive_add -n buddy driver=replication,mode=primary,file.driver=nbd,file.host=192.168.0.34,file.port=8889,file.export=secondary-disk0,node-name=nbd_client0'}}
>>       { 'execute':'x-blockdev-change', 'arguments':{'parent': 'primary-disk0', 'node': 'nbd_client0' } }
>>       { 'execute': 'migrate-set-capabilities',
>>             'arguments': {'capabilities': [ {'capability': 'x-colo', 'state': true } ] } }
>>       { 'execute': 'migrate', 'arguments': {'uri': 'tcp:192.168.0.34:8888 <http://192.168.0.34:8888>' } }
>>       And two VM with cash
>>       Primary:
>>       {"timestamp": {"seconds": 1520763655, "microseconds": 511415}, "event": "RESUME"}
>>       [1]    329 segmentation fault  sudo /usr/local/bin/qemu-system-x86_64 -boot c -enable-kvm -m 2048 -smp 2 -qm
>>
>>       Secondary:
>>       {"timestamp": {"seconds": 1520763655, "microseconds": 510907}, "event": "RESUME"}
>>       [1]    367 segmentation fault  sudo /usr/local/bin/qemu-system-x86_64 -boot c -enable-kvm -m 2048 -smp 2 -qm
>>
>>     To manage notifications about this bug go to:
>>     https://bugs.launchpad.net/qemu/+bug/1754542/+subscriptions <https://bugs.launchpad.net/qemu/+bug/1754542/+subscriptions>
>>
>>
>

-- 
Best regards.
Li Zhijian (8528)




--------------C89AD310A4777CE142EFCBFB
Content-Type: text/x-patch;
	name="0001-check-block-host-md5sum-between-migration-source-and.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename*0="0001-check-block-host-md5sum-between-migration-source-and.pa";
	filename*1="tch"

>From ecb789cf7f383b112da3cce33eb9822a94b9497a Mon Sep 17 00:00:00 2001
From: Li Zhijian <lizhijian@cn.fujitsu.com>
Date: Tue, 24 Mar 2015 21:53:26 -0400
Subject: [PATCH] check pc.ram block md5sum between migration Source and
 Destination

Signed-off-by: Li Zhijian <lizhijian@cn.fujitsu.com>
---
 savevm.c | 42 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)
 mode change 100644 => 100755 savevm.c

diff --git a/savevm.c b/savevm.c
old mode 100644
new mode 100755
index 3b0e222..3d431dc
--- a/savevm.c
+++ b/savevm.c
@@ -51,6 +51,26 @@
 #define ARP_PTYPE_IP 0x0800
 #define ARP_OP_REQUEST_REV 0x3
 
+#include "qemu/rcu_queue.h"
+#include <openssl/md5.h>
+
+static void check_host_md5(void)
+{
+    int i;
+    unsigned char md[MD5_DIGEST_LENGTH];
+    MD5_CTX ctx;
+    RAMBlock *block = QLIST_FIRST_RCU(&ram_list.blocks);/* Only check 'pc.ram' block */
+
+    MD5_Init(&ctx);
+    MD5_Update(&ctx, (void *)block->host, block->used_length);
+    MD5_Final(md, &ctx);
+    printf("md_host : ");
+    for(i = 0; i < MD5_DIGEST_LENGTH; i++) {
+        fprintf(stderr, "%02x", md[i]);
+    }
+    fprintf(stderr, "\n");
+}
+
 static int announce_self_create(uint8_t *buf,
                                 uint8_t *mac_addr)
 {
@@ -741,7 +761,13 @@ void qemu_savevm_state_complete(QEMUFile *f)
         qemu_put_byte(f, QEMU_VM_SECTION_END);
         qemu_put_be32(f, se->section_id);
 
+        printf("before saving %s complete\n", se->idstr);
+        check_host_md5();
+
         ret = se->ops->save_live_complete(f, se->opaque);
+        printf("after saving %s complete\n", se->idstr);
+        check_host_md5();
+
         trace_savevm_section_end(se->idstr, se->section_id, ret);
         if (ret < 0) {
             qemu_file_set_error(f, ret);
@@ -1007,6 +1033,13 @@ int qemu_loadvm_state(QEMUFile *f)
             QLIST_INSERT_HEAD(&loadvm_handlers, le, entry);
 
             ret = vmstate_load(f, le->se, le->version_id);
+#if 0
+            if (section_type == QEMU_VM_SECTION_FULL) {
+                printf("QEMU_VM_SECTION_FULL, after loading %s\n", le->se->idstr);
+                check_host_md5();
+            }
+#endif
+
             if (ret < 0) {
                 error_report("error while loading state for instance 0x%x of"
                              " device '%s'", instance_id, idstr);
@@ -1030,6 +1063,11 @@ int qemu_loadvm_state(QEMUFile *f)
             }
 
             ret = vmstate_load(f, le->se, le->version_id);
+            if (section_type == QEMU_VM_SECTION_END) {
+                printf("QEMU_VM_SECTION_END, after loading %s\n", le->se->idstr);
+                check_host_md5();
+            }
+
             if (ret < 0) {
                 error_report("error while loading state section id %d(%s)",
                              section_id, le->se->idstr);
@@ -1061,7 +1099,11 @@ int qemu_loadvm_state(QEMUFile *f)
         g_free(buf);
     }
 
+    printf("after loading all vmstate\n");
+    check_host_md5();
     cpu_synchronize_all_post_init();
+    printf("after cpu_synchronize_all_post_init\n");
+    check_host_md5();
 
     ret = 0;
 
-- 
1.7.12.4


--------------C89AD310A4777CE142EFCBFB--
