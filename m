Received: from eggs.gnu.org ([2001:4830:134:3::10]:45421)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gRMkW-00087x-Am
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 14:40:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gRMkS-0004fl-Rz
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 14:40:52 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e]:56081)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1gRMkS-0004ch-JJ
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 14:40:48 -0500
Received: by mail-wm1-x32e.google.com with SMTP id y139so19403397wmc.5
	for <qemu-devel@nongnu.org>; Mon, 26 Nov 2018 11:40:48 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 26 Nov 2018 20:40:27 +0100
Message-Id: <1543261235-2834-8-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1543261235-2834-1-git-send-email-pbonzini@redhat.com>
References: <1543261235-2834-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 07/15] vhost-user-bridge: fix recvmsg iovlen
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

From: Marc-André Lureau <marcandre.lureau@redhat.com>

After iov_discard_front(), the iov may be smaller than its initial
size. Fixes the heap-buffer-overflow spotted by ASAN:

==9036==ERROR: AddressSanitizer: heap-buffer-overflow on address 0x6060000001e0 at pc 0x7fe632eca3f0 bp 0x7ffddc4a05a0 sp 0x7ffddc49fd48
WRITE of size 32 at 0x6060000001e0 thread T0
    #0 0x7fe632eca3ef  (/lib64/libasan.so.5+0x773ef)
    #1 0x7fe632ecad23 in __interceptor_recvmsg (/lib64/libasan.so.5+0x77d23)
    #2 0x561e7491936b in vubr_backend_recv_cb /home/elmarco/src/qemu/tests/vhost-user-bridge.c:333
    #3 0x561e74917711 in dispatcher_wait /home/elmarco/src/qemu/tests/vhost-user-bridge.c:160
    #4 0x561e7491c3b5 in vubr_run /home/elmarco/src/qemu/tests/vhost-user-bridge.c:725
    #5 0x561e7491c85c in main /home/elmarco/src/qemu/tests/vhost-user-bridge.c:806
    #6 0x7fe631a6c412 in __libc_start_main (/lib64/libc.so.6+0x24412)
    #7 0x561e7491667d in _start (/home/elmarco/src/qemu/build/tests/vhost-user-bridge+0x3967d)

0x6060000001e0 is located 0 bytes to the right of 64-byte region [0x6060000001a0,0x6060000001e0)
allocated by thread T0 here:
    #0 0x7fe632f42848 in __interceptor_malloc (/lib64/libasan.so.5+0xef848)
    #1 0x561e7493acd8 in virtqueue_alloc_element /home/elmarco/src/qemu/contrib/libvhost-user/libvhost-user.c:1848
    #2 0x561e7493c2a8 in vu_queue_pop /home/elmarco/src/qemu/contrib/libvhost-user/libvhost-user.c:1954
    #3 0x561e749189bf in vubr_backend_recv_cb /home/elmarco/src/qemu/tests/vhost-user-bridge.c:297
    #4 0x561e74917711 in dispatcher_wait /home/elmarco/src/qemu/tests/vhost-user-bridge.c:160
    #5 0x561e7491c3b5 in vubr_run /home/elmarco/src/qemu/tests/vhost-user-bridge.c:725
    #6 0x561e7491c85c in main /home/elmarco/src/qemu/tests/vhost-user-bridge.c:806
    #7 0x7fe631a6c412 in __libc_start_main (/lib64/libc.so.6+0x24412)

SUMMARY: AddressSanitizer: heap-buffer-overflow (/lib64/libasan.so.5+0x773ef)
Shadow bytes around the buggy address:
  0x0c0c7fff7fe0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  0x0c0c7fff7ff0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  0x0c0c7fff8000: fa fa fa fa 00 00 00 00 00 00 05 fa fa fa fa fa
  0x0c0c7fff8010: 00 00 00 00 00 00 00 00 fa fa fa fa fd fd fd fd
  0x0c0c7fff8020: fd fd fd fd fa fa fa fa fd fd fd fd fd fd fd fd
=>0x0c0c7fff8030: fa fa fa fa 00 00 00 00 00 00 00 00[fa]fa fa fa
  0x0c0c7fff8040: fd fd fd fd fd fd fd fd fa fa fa fa fd fd fd fd
  0x0c0c7fff8050: fd fd fd fd fa fa fa fa fd fd fd fd fd fd fd fd
  0x0c0c7fff8060: fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa
  0x0c0c7fff8070: fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa
  0x0c0c7fff8080: fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-Id: <20181109173028.3372-1-marcandre.lureau@redhat.com>
---
 tests/vhost-user-bridge.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/vhost-user-bridge.c b/tests/vhost-user-bridge.c
index 0884294..0cf8d0b 100644
--- a/tests/vhost-user-bridge.c
+++ b/tests/vhost-user-bridge.c
@@ -323,7 +323,7 @@ vubr_backend_recv_cb(int sock, void *ctx)
             .msg_name = (struct sockaddr *) &vubr->backend_udp_dest,
             .msg_namelen = sizeof(struct sockaddr_in),
             .msg_iov = sg,
-            .msg_iovlen = elem->in_num,
+            .msg_iovlen = num,
             .msg_flags = MSG_DONTWAIT,
         };
         do {
-- 
1.8.3.1
