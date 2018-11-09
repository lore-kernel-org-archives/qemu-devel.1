Received: from eggs.gnu.org ([2001:4830:134:3::10]:58447)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gLAfJ-0002L3-RU
	for qemu-devel@nongnu.org; Fri, 09 Nov 2018 12:33:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gLAcQ-0001WH-CH
	for qemu-devel@nongnu.org; Fri, 09 Nov 2018 12:30:57 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39114)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1gLAcP-0001Qj-W4
	for qemu-devel@nongnu.org; Fri, 09 Nov 2018 12:30:54 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C8BAA3082143
	for <qemu-devel@nongnu.org>; Fri,  9 Nov 2018 17:30:52 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Fri,  9 Nov 2018 21:30:28 +0400
Message-Id: <20181109173028.3372-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH] vhost-user-bridge: fix recvmsg iovlen
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: victork@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

After iov_discard_front(), the iov may be smaller than its initial
size. Fixes the heap-buffer-overflow spotted by ASAN:

=3D=3D9036=3D=3DERROR: AddressSanitizer: heap-buffer-overflow on address =
0x6060000001e0 at pc 0x7fe632eca3f0 bp 0x7ffddc4a05a0 sp 0x7ffddc49fd48
WRITE of size 32 at 0x6060000001e0 thread T0
    #0 0x7fe632eca3ef  (/lib64/libasan.so.5+0x773ef)
    #1 0x7fe632ecad23 in __interceptor_recvmsg (/lib64/libasan.so.5+0x77d=
23)
    #2 0x561e7491936b in vubr_backend_recv_cb /home/elmarco/src/qemu/test=
s/vhost-user-bridge.c:333
    #3 0x561e74917711 in dispatcher_wait /home/elmarco/src/qemu/tests/vho=
st-user-bridge.c:160
    #4 0x561e7491c3b5 in vubr_run /home/elmarco/src/qemu/tests/vhost-user=
-bridge.c:725
    #5 0x561e7491c85c in main /home/elmarco/src/qemu/tests/vhost-user-bri=
dge.c:806
    #6 0x7fe631a6c412 in __libc_start_main (/lib64/libc.so.6+0x24412)
    #7 0x561e7491667d in _start (/home/elmarco/src/qemu/build/tests/vhost=
-user-bridge+0x3967d)

0x6060000001e0 is located 0 bytes to the right of 64-byte region [0x60600=
00001a0,0x6060000001e0)
allocated by thread T0 here:
    #0 0x7fe632f42848 in __interceptor_malloc (/lib64/libasan.so.5+0xef84=
8)
    #1 0x561e7493acd8 in virtqueue_alloc_element /home/elmarco/src/qemu/c=
ontrib/libvhost-user/libvhost-user.c:1848
    #2 0x561e7493c2a8 in vu_queue_pop /home/elmarco/src/qemu/contrib/libv=
host-user/libvhost-user.c:1954
    #3 0x561e749189bf in vubr_backend_recv_cb /home/elmarco/src/qemu/test=
s/vhost-user-bridge.c:297
    #4 0x561e74917711 in dispatcher_wait /home/elmarco/src/qemu/tests/vho=
st-user-bridge.c:160
    #5 0x561e7491c3b5 in vubr_run /home/elmarco/src/qemu/tests/vhost-user=
-bridge.c:725
    #6 0x561e7491c85c in main /home/elmarco/src/qemu/tests/vhost-user-bri=
dge.c:806
    #7 0x7fe631a6c412 in __libc_start_main (/lib64/libc.so.6+0x24412)

SUMMARY: AddressSanitizer: heap-buffer-overflow (/lib64/libasan.so.5+0x77=
3ef)
Shadow bytes around the buggy address:
  0x0c0c7fff7fe0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  0x0c0c7fff7ff0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  0x0c0c7fff8000: fa fa fa fa 00 00 00 00 00 00 05 fa fa fa fa fa
  0x0c0c7fff8010: 00 00 00 00 00 00 00 00 fa fa fa fa fd fd fd fd
  0x0c0c7fff8020: fd fd fd fd fa fa fa fa fd fd fd fd fd fd fd fd
=3D>0x0c0c7fff8030: fa fa fa fa 00 00 00 00 00 00 00 00[fa]fa fa fa
  0x0c0c7fff8040: fd fd fd fd fd fd fd fd fa fa fa fa fd fd fd fd
  0x0c0c7fff8050: fd fd fd fd fa fa fa fa fd fd fd fd fd fd fd fd
  0x0c0c7fff8060: fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa
  0x0c0c7fff8070: fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa
  0x0c0c7fff8080: fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 tests/vhost-user-bridge.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/vhost-user-bridge.c b/tests/vhost-user-bridge.c
index a07ce0f917..0033b61f2e 100644
--- a/tests/vhost-user-bridge.c
+++ b/tests/vhost-user-bridge.c
@@ -323,7 +323,7 @@ vubr_backend_recv_cb(int sock, void *ctx)
             .msg_name =3D (struct sockaddr *) &vubr->backend_udp_dest,
             .msg_namelen =3D sizeof(struct sockaddr_in),
             .msg_iov =3D sg,
-            .msg_iovlen =3D elem->in_num,
+            .msg_iovlen =3D num,
             .msg_flags =3D MSG_DONTWAIT,
         };
         do {
--=20
2.19.1.708.g4ede3d42df
