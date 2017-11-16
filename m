Received: from eggs.gnu.org ([2001:4830:134:3::10]:36111)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <caoxinhua@huawei.com>) id 1eFChU-0005gg-Il
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 00:26:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <caoxinhua@huawei.com>) id 1eFChP-0002TR-K4
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 00:26:56 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:2354)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <caoxinhua@huawei.com>) id 1eFChO-00020o-PN
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 00:26:51 -0500
From: "xinhua.Cao" <caoxinhua@huawei.com>
Date: Thu, 16 Nov 2017 13:25:11 +0800
Message-ID: <20171116052511.16236-1-caoxinhua@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH] ipmi: check ibe status before ibe outlen at
 ipmi_bmc_extern_handle_command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, marcandre.lureau@redhat.com, f4bug@amsat.org, anton.nefedov@virtuozzo.com, pbonzini@redhat.com, vsementsov@virtuozzo.com
Cc: weidong.huang@huawei.com, yanqiangjun@huawei.com, weifuqiang@huawei.com, king.wang@huawei.com, arei.gonglei@huawei.com, "xinhua.Cao" <caoxinhua@huawei.com>

When we always kill vm's ipmi_sim program. qemu will do handling chr_event
to reconnect ipmi_sim. handling chain is chr_event -> continue_send ->
qemu_chr_fe_write. if ipmi_sim program was killed again. then qemu_chr_fe_write
will failed. then ibe's outlen and outbuf will not cleared. so if vcpu handle
a ipmi_bmc_extern_handle_command. qemu aborted. here is backtrace.

(gdb) bt
0  0x00007f3d9f4181d7 in raise () from /usr/lib64/libc.so.6
1  0x00007f3d9f4198c8 in abort () from /usr/lib64/libc.so.6
2  0x0000000000635c20 in ipmi_bmc_extern_handle_command (b=<optimized out>,
   cmd=0x4290198 "\030\001\004\001", cmd_len=2,
   max_cmd_len=300, msg_id=39 '\'') at hw/ipmi/ipmi_bmc_extern.c:586
3  0x0000000000636e1d in ipmi_kcs_signal (ii=0x428fea0, ik=<optimized out>)
   at hw/ipmi/isa_ipmi_kcs.c:126
4  0x000000000047341a in memory_region_write_accessor (mr=0x428ff60, addr=0,
   value=<optimized out>, size=1, shift=<optimized out>, mask=<optimized out>,
   attrs=...) at /root/rpmbuild/BUILD/qemu-kvm-2.8.1/memory.c:527
5  0x000000000047221f in access_with_adjusted_size (addr=addr@entry=0,
   value=value@entry=0x7f3d8affc838, size=size@entry=1,
   access_size_min=<optimized out>, access_size_max=<optimized out>,
   access=access@entry=0x4733a0 <memory_region_write_accessor>,
   mr=mr@entry=0x428ff60, attrs=attrs@entry=...)
   at /root/rpmbuild/BUILD/qemu-kvm-2.8.1/memory.c:593
6  0x0000000000473e4d in memory_region_dispatch_write (mr=mr@entry=0x428ff60,
   addr=addr@entry=0, data=1, size=size@entry=1, attrs=attrs@entry=...) at
   /root/rpmbuild/BUILD/qemu-kvm-2.8.1/memory.c:1334
7  0x000000000042c2ed in address_space_write_continue (as=as@entry=0xecb400
   <address_space_io>, addr=addr@entry=3234, attrs=..., attrs@entry=...,
   buf=buf@entry=0x7f3da59fe000 <Address 0x7f3da59fe000 out of bounds>, len=len@entry=1,
   addr1=0, l=1, mr=0x428ff60) at /root/rpmbuild/BUILD/qemu-kvm-2.8.1/exec.c:2998
8  0x000000000042de66 in address_space_write (as=0xecb400 <address_space_io>,
   addr=3234, attrs=...,buf=0x7f3da59fe000 <Address 0x7f3da59fe000 out of bounds>,
   len=1) at /root/rpmbuild/BUILD/qemu-kvm-2.8.1/exec.c:3043
9  0x000000000042e34d in address_space_rw (as=<optimized out>, addr=addr@entry=3234,
   attrs=..., attrs@entry=..., buf=buf@entry=0x7f3da59fe000 <Address 0x7f3da59fe000
   out of bounds>, len=len@entry=1, is_write=is_write@entry=true)
   at /root/rpmbuild/BUILD/qemu-kvm-2.8.1/exec.c:3145
10 0x000000000046b751 in kvm_handle_io (port=3234, attrs=attrs@entry=...,
   data=<optimized out>, direction=<optimized out>, size=1, count=1)
   at /root/rpmbuild/BUILD/qemu-kvm-2.8.1/kvm_all.c:1822
11 0x000000000046f4a7 in kvm_cpu_exec (cpu=cpu@entry=0x36f3060)
   at /root/rpmbuild/BUILD/qemu-kvm-2.8.1/kvm_all.c:1980
12 0x0000000000459cf5 in qemu_kvm_cpu_thread_fn (arg=arg@entry=0x36f3060)
   at /root/rpmbuild/BUILD/qemu-kvm-2.8.1/cpus.c:1072
13 0x0000000000848818 in thread_entry_for_hotfix (pthread_cb=<optimized out>)
   at uvp/hotpatch/qemu_hotpatch_helper.c:502
14 0x00007f3d9f7acdc5 in start_thread () from /usr/lib64/libpthread.so.0
15 0x00007f3d9f4da6fd in clone () from /usr/lib64/libc.so.6

we check ibe status before ibe outlen at ipmi_bmc_extern_handle_command to fix this abort.
---
 hw/ipmi/ipmi_bmc_extern.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/hw/ipmi/ipmi_bmc_extern.c b/hw/ipmi/ipmi_bmc_extern.c
index abab3bb..7a49050 100644
--- a/hw/ipmi/ipmi_bmc_extern.c
+++ b/hw/ipmi/ipmi_bmc_extern.c
@@ -192,13 +192,6 @@ static void ipmi_bmc_extern_handle_command(IPMIBmc *b,
     uint8_t err = 0, csum;
     unsigned int i;
 
-    if (ibe->outlen) {
-        /* We already have a command queued.  Shouldn't ever happen. */
-        fprintf(stderr, "IPMI KCS: Got command when not finished with the"
-                " previous command\n");
-        abort();
-    }
-
     /* If it's too short or it was truncated, return an error. */
     if (cmd_len < 2) {
         err = IPMI_CC_REQUEST_DATA_LENGTH_INVALID;
@@ -206,7 +199,10 @@ static void ipmi_bmc_extern_handle_command(IPMIBmc *b,
         err = IPMI_CC_REQUEST_DATA_TRUNCATED;
     } else if (!ibe->connected) {
         err = IPMI_CC_BMC_INIT_IN_PROGRESS;
+    } else if (ibe->wdt_state.trans_fail) {
+        err = IPMI_CC_BMC_INIT_IN_PROGRESS;
     }
+
     if (err) {
         IPMIInterfaceClass *k = IPMI_INTERFACE_GET_CLASS(s);
         unsigned char rsp[3];
@@ -218,6 +214,12 @@ static void ipmi_bmc_extern_handle_command(IPMIBmc *b,
         goto out;
     }
 
+    if (ibe->outlen) {
+        /* We already have a command queued.  Shouldn't ever happen. */
+        QEMU_LOG(LOG_ERR, "IPMI KCS: Got command when not finished with the previous command\n");
+        abort();
+    }
+
     addchar(ibe, msg_id);
     for (i = 0; i < cmd_len; i++) {
         addchar(ibe, cmd[i]);
@@ -390,6 +392,7 @@ static void chr_event(void *opaque, int event)
 
     switch (event) {
     case CHR_EVENT_OPENED:
+        QEMU_LOG(LOG_INFO, "open ipmi device\n");
         ibe->connected = true;
         ibe->outpos = 0;
         ibe->outlen = 0;
-- 
2.8.3
