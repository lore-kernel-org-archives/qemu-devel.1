Received: from eggs.gnu.org ([2001:4830:134:3::10]:45608)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jemmy858585@gmail.com>) id 1fFgZ7-0006xe-FT
	for qemu-devel@nongnu.org; Mon, 07 May 2018 09:52:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jemmy858585@gmail.com>) id 1fFgZ4-0006Kq-EY
	for qemu-devel@nongnu.org; Mon, 07 May 2018 09:52:33 -0400
Received: from mail-io0-x244.google.com ([2607:f8b0:4001:c06::244]:39817)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jemmy858585@gmail.com>)
	id 1fFgZ4-0006KK-99
	for qemu-devel@nongnu.org; Mon, 07 May 2018 09:52:30 -0400
Received: by mail-io0-x244.google.com with SMTP id r9-v6so33755658iod.6
	for <qemu-devel@nongnu.org>; Mon, 07 May 2018 06:52:30 -0700 (PDT)
From: Lidong Chen <jemmy858585@gmail.com>
Date: Mon,  7 May 2018 21:52:17 +0800
Message-Id: <1525701137-9384-2-git-send-email-lidongchen@tencent.com>
In-Reply-To: <1525701137-9384-1-git-send-email-lidongchen@tencent.com>
References: <1525701137-9384-1-git-send-email-lidongchen@tencent.com>
Subject: [Qemu-devel] [PATCH 2/2] migration: invoke qio_channel_yield only
 when qemu_in_coroutine()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: quintela@redhat.com, dgilbert@redhat.com, berrange@redhat.com
Cc: qemu-devel@nongnu.org, galsha@mellanox.com, aviadye@mellanox.com, adido@mellanox.com, Lidong Chen <lidongchen@tencent.com>

when qio_channel_read return QIO_CHANNEL_ERR_BLOCK, the source qemu crash.

The backtrace is:
    (gdb) bt
    #0  0x00007fb20aba91d7 in raise () from /lib64/libc.so.6
    #1  0x00007fb20abaa8c8 in abort () from /lib64/libc.so.6
    #2  0x00007fb20aba2146 in __assert_fail_base () from /lib64/libc.so.6
    #3  0x00007fb20aba21f2 in __assert_fail () from /lib64/libc.so.6
    #4  0x00000000008dba2d in qio_channel_yield (ioc=0x22f9e20, condition=G_IO_IN) at io/channel.c:460
    #5  0x00000000007a870b in channel_get_buffer (opaque=0x22f9e20, buf=0x3d54038 "", pos=0, size=32768)
        at migration/qemu-file-channel.c:83
    #6  0x00000000007a70f6 in qemu_fill_buffer (f=0x3d54000) at migration/qemu-file.c:299
    #7  0x00000000007a79d0 in qemu_peek_byte (f=0x3d54000, offset=0) at migration/qemu-file.c:562
    #8  0x00000000007a7a22 in qemu_get_byte (f=0x3d54000) at migration/qemu-file.c:575
    #9  0x00000000007a7c46 in qemu_get_be16 (f=0x3d54000) at migration/qemu-file.c:647
    #10 0x0000000000796db7 in source_return_path_thread (opaque=0x2242280) at migration/migration.c:1794
    #11 0x00000000009428fa in qemu_thread_start (args=0x3e58420) at util/qemu-thread-posix.c:504
    #12 0x00007fb20af3ddc5 in start_thread () from /lib64/libpthread.so.0
    #13 0x00007fb20ac6b74d in clone () from /lib64/libc.so.6

This patch fixed by invoke qio_channel_yield only when qemu_in_coroutine().

Signed-off-by: Lidong Chen <lidongchen@tencent.com>
---
 migration/qemu-file-channel.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/migration/qemu-file-channel.c b/migration/qemu-file-channel.c
index e202d73..8e639eb 100644
--- a/migration/qemu-file-channel.c
+++ b/migration/qemu-file-channel.c
@@ -49,7 +49,11 @@ static ssize_t channel_writev_buffer(void *opaque,
         ssize_t len;
         len = qio_channel_writev(ioc, local_iov, nlocal_iov, NULL);
         if (len == QIO_CHANNEL_ERR_BLOCK) {
-            qio_channel_wait(ioc, G_IO_OUT);
+            if (qemu_in_coroutine()) {
+                qio_channel_yield(ioc, G_IO_OUT);
+            } else {
+                qio_channel_wait(ioc, G_IO_OUT);
+            }
             continue;
         }
         if (len < 0) {
@@ -80,7 +84,11 @@ static ssize_t channel_get_buffer(void *opaque,
         ret = qio_channel_read(ioc, (char *)buf, size, NULL);
         if (ret < 0) {
             if (ret == QIO_CHANNEL_ERR_BLOCK) {
-                qio_channel_yield(ioc, G_IO_IN);
+                if (qemu_in_coroutine()) {
+                    qio_channel_yield(ioc, G_IO_IN);
+                } else {
+                    qio_channel_wait(ioc, G_IO_IN);
+                }
             } else {
                 /* XXX handle Error * object */
                 return -EIO;
-- 
1.8.3.1
