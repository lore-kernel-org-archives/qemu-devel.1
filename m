Return-Path: <SRS0=Y1tr=UJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEA48C28CC7
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Jun 2019 13:38:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9292E20859
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Jun 2019 13:38:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9292E20859
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46566 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1haKV2-0000mp-Lw
	for qemu-devel@archiver.kernel.org; Mon, 10 Jun 2019 09:38:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47396)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <lizhengui@huawei.com>) id 1haKSj-0007TR-46
 for qemu-devel@nongnu.org; Mon, 10 Jun 2019 09:35:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <lizhengui@huawei.com>) id 1haKSh-0000QF-Lm
 for qemu-devel@nongnu.org; Mon, 10 Jun 2019 09:35:49 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:2174 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <lizhengui@huawei.com>)
 id 1haKSL-00008R-Bh; Mon, 10 Jun 2019 09:35:30 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id 7358E5FE7A8A56D645A7;
 Mon, 10 Jun 2019 21:35:14 +0800 (CST)
Received: from HGHY1l002846723.china.huawei.com (10.177.251.193) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.439.0; Mon, 10 Jun 2019 21:35:07 +0800
From: Zhengui li <lizhengui@huawei.com>
To: <pbonzini@redhat.com>, <stefanha@redhat.com>, <mreitz@redhat.com>,
 <kwolf@redhat.com>
Date: Mon, 10 Jun 2019 21:34:44 +0800
Message-ID: <1560173684-6264-1-git-send-email-lizhengui@huawei.com>
X-Mailer: git-send-email 2.7.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.177.251.193]
X-CFilter-Loop: Reflected
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 45.249.212.190
Subject: [Qemu-devel] [PATCH] file-posix: unlock qemu_global_mutex before
 pread when attach disk
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: lizhengui@huawei.com, qemu-block@nongnu.org, eric.fangyi@huawei.com,
 qemu-devel@nongnu.org, jiangyiwen@huawei.com, wangjie88@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

virtual machine cpu soft lockup when attach a disk to the vm in the case
that backend storage network has a large delay or IO pressure is too large.

The bt of qemu main thread:
#0 0x0000ffff9d78402c in pread64 () from /lib64/libpthread.so.0
#1 0x0000aaaace3357d8 in pread64 (__offset=0, __nbytes=4096, __buf=0xaaaad47a5200, __fd=202) at /usr/include/bits/unistd.h:99
#2 raw_is_io_aligned (fd=fd@entry=202, buf=buf@entry=0xaaaad47a5200, len=len@entry=4096) at block/raw_posix.c:294
#3 0x0000aaaace33597c in raw_probe_alignment (bs=bs@entry=0xaaaad32ea920, fd=202, errp=errp@entry=0xfffffef7a330) at block/raw_posix.c:349
#4 0x0000aaaace335a48 in raw_refresh_limits (bs=0xaaaad32ea920, errp=0xfffffef7a330) at block/raw_posix.c:811
#5 0x0000aaaace3404b0 in bdrv_refresh_limits (bs=0xaaaad32ea920, errp=0xfffffef7a330, errp@entry=0xfffffef7a360) at block/io.c:122
#6 0x0000aaaace340504 in bdrv_refresh_limits (bs=bs@entry=0xaaaad09ce800, errp=errp@entry=0xfffffef7a3b0) at block/io.c:97
#7 0x0000aaaace2eb9f0 in bdrv_open_common (bs=bs@entry=0xaaaad09ce800, file=file@entry=0xaaaad0e89800, options=<optimized out>, errp=errp@entry=0xfffffef7a450)
at block.c:1194
#8 0x0000aaaace2eedec in bdrv_open_inherit (filename=<optimized out>, filename@entry=0xaaaad25f92d0 "/dev/mapper/36384c4f100630193359db7a80000011d",
reference=reference@entry=0x0, options=<optimized out>, options@entry=0xaaaad3d0f4b0, flags=<optimized out>, flags@entry=128, parent=parent@entry=0x0,
child_role=child_role@entry=0x0, errp=errp@entry=0xfffffef7a710) at block.c:1895
#9 0x0000aaaace2ef510 in bdrv_open (filename=filename@entry=0xaaaad25f92d0 "/dev/mapper/36384c4f100630193359db7a80000011d", reference=reference@entry=0x0,
options=options@entry=0xaaaad3d0f4b0, flags=flags@entry=128, errp=errp@entry=0xfffffef7a710) at block.c:1979
#10 0x0000aaaace331ef0 in blk_new_open (filename=filename@entry=0xaaaad25f92d0 "/dev/mapper/36384c4f100630193359db7a80000011d", reference=reference@entry=0x0,
options=options@entry=0xaaaad3d0f4b0, flags=128, errp=errp@entry=0xfffffef7a710) at block/block_backend.c:213
#11 0x0000aaaace0da1f4 in blockdev_init (file=file@entry=0xaaaad25f92d0 "/dev/mapper/36384c4f100630193359db7a80000011d", bs_opts=bs_opts@entry=0xaaaad3d0f4b0,
errp=errp@entry=0xfffffef7a710) at blockdev.c:603
#12 0x0000aaaace0dc478 in drive_new (all_opts=all_opts@entry=0xaaaad4dc31d0, block_default_type=<optimized out>) at blockdev.c:1116
#13 0x0000aaaace0e3ee0 in add_init_drive (
optstr=optstr@entry=0xaaaad0872ec0 "file=/dev/mapper/36384c4f100630193359db7a80000011d,format=raw,if=none,id=drive-scsi0-0-0-3,cache=none,aio=native")
at device_hotplug.c:46
#14 0x0000aaaace0e3f78 in hmp_drive_add (mon=0xfffffef7a810, qdict=0xaaaad0c8f000) at device_hotplug.c:67
#15 0x0000aaaacdf7d688 in handle_hmp_command (mon=0xfffffef7a810, cmdline=<optimized out>) at /usr/src/debug/qemu-kvm-2.8.1/monitor.c:3199
#16 0x0000aaaacdf7d778 in qmp_human_monitor_command (
command_line=0xaaaacfc8e3c0 "drive_add dummy file=/dev/mapper/36384c4f100630193359db7a80000011d,format=raw,if=none,id=drive-scsi0-0-0-3,cache=none,aio=native",
has_cpu_index=false, cpu_index=0, errp=errp@entry=0xfffffef7a968) at /usr/src/debug/qemu-kvm-2.8.1/monitor.c:660
#17 0x0000aaaace0fdb30 in qmp_marshal_human_monitor_command (args=<optimized out>, ret=0xfffffef7a9e0, errp=0xfffffef7a9d8) at qmp-marshal.c:2223
#18 0x0000aaaace3b6ad0 in do_qmp_dispatch (request=<optimized out>, errp=0xfffffef7aa20, errp@entry=0xfffffef7aa40) at qapi/qmp_dispatch.c:115
#19 0x0000aaaace3b6d58 in qmp_dispatch (request=<optimized out>) at qapi/qmp_dispatch.c:142
#20 0x0000aaaacdf79398 in handle_qmp_command (parser=<optimized out>, tokens=<optimized out>) at /usr/src/debug/qemu-kvm-2.8.1/monitor.c:4010
#21 0x0000aaaace3bd6c0 in json_message_process_token (lexer=0xaaaacf834c80, input=<optimized out>, type=JSON_RCURLY, x=214, y=274) at qobject/json_streamer.c:105
#22 0x0000aaaace3f3d4c in json_lexer_feed_char (lexer=lexer@entry=0xaaaacf834c80, ch=<optimized out>, flush=flush@entry=false) at qobject/json_lexer.c:319
#23 0x0000aaaace3f3e6c in json_lexer_feed (lexer=0xaaaacf834c80, buffer=<optimized out>, size=<optimized out>) at qobject/json_lexer.c:369
#24 0x0000aaaacdf77c64 in monitor_qmp_read (opaque=<optimized out>, buf=<optimized out>, size=<optimized out>) at /usr/src/debug/qemu-kvm-2.8.1/monitor.c:4040
#25 0x0000aaaace0eab18 in tcp_chr_read (chan=<optimized out>, cond=<optimized out>, opaque=0xaaaacf90b280) at qemu_char.c:3260
#26 0x0000ffff9dadf200 in g_main_context_dispatch () from /lib64/libglib-2.0.so.0
#27 0x0000aaaace3c4a00 in glib_pollfds_poll () at util/main_loop.c:230
--Type <RET> for more, q to quit, c to continue without paging--
#28 0x0000aaaace3c4a88 in os_host_main_loop_wait (timeout=<optimized out>) at util/main_loop.c:278
#29 0x0000aaaace3c4bf0 in main_loop_wait (nonblocking=<optimized out>) at util/main_loop.c:534
#30 0x0000aaaace0f5d08 in main_loop () at vl.c:2120
#31 0x0000aaaacdf3a770 in main (argc=<optimized out>, argv=<optimized out>, envp=<optimized out>) at vl.c:5017

when do qmp sush as drive_add,  qemu main thread locks the qemu_global_mutex  and do pread in raw_probe_alignmen. Pread
is a synchronous operation. If backend storage network has a large delay or IO pressure is too large,  the pread operation will not return for a long time, which
make vcpu thread can't acquire qemu_global_mutex for a long time and make the vcpu thread unable to be scheduled for a long time.  So virtual machine cpu soft lockup happened.

qemu main thread should not hold qemu_global_mutex for a long time when do qmp that involving IO synchronous operation sush pread , ioctl, etc.
So this patch unlock qemu_global_mutex before IO synchronous operation sush pread.
---
 block/file-posix.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/block/file-posix.c b/block/file-posix.c
index 1cf4ee4..192c779 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -297,7 +297,9 @@ static int probe_physical_blocksize(int fd, unsigned int *blk_size)
  */
 static bool raw_is_io_aligned(int fd, void *buf, size_t len)
 {
+    qemu_mutex_unlock_iothread();
     ssize_t ret = pread(fd, buf, len, 0);
+    qemu_mutex_lock_iothread();
 
     if (ret >= 0) {
         return true;
-- 
2.7.2.windows.1



