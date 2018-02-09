Received: from eggs.gnu.org ([2001:4830:134:3::10]:38893)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1ekDQX-0003De-Fj
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 13:29:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1ekDQT-0007DI-DN
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 13:29:37 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:43162 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1ekDQT-0007DB-8n
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 13:29:33 -0500
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Fri,  9 Feb 2018 19:29:20 +0100
Message-Id: <20180209182920.29711-2-marcandre.lureau@redhat.com>
In-Reply-To: <20180209182920.29711-1-marcandre.lureau@redhat.com>
References: <20180209182920.29711-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 2/2] 9p: fix leak in synth_name_to_path()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Greg Kurz <groug@kaod.org>

Leak found thanks to ASAN:

Direct leak of 8 byte(s) in 1 object(s) allocated from:
    #0 0x55995789ac90 in __interceptor_malloc (/home/elmarco/src/qemu/bui=
ld/x86_64-softmmu/qemu-system-x86_64+0x1510c90)
    #1 0x7f0a91190f0c in g_malloc /home/elmarco/src/gnome/glib/builddir/.=
./glib/gmem.c:94
    #2 0x5599580a281c in v9fs_path_copy /home/elmarco/src/qemu/hw/9pfs/9p=
.c:196:17
    #3 0x559958f9ec5d in coroutine_trampoline /home/elmarco/src/qemu/util=
/coroutine-ucontext.c:116:9
    #4 0x7f0a8766ebbf  (/lib64/libc.so.6+0x50bbf)

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 hw/9pfs/9p-synth.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/9pfs/9p-synth.c b/hw/9pfs/9p-synth.c
index 18082dffe8..54239c9bbf 100644
--- a/hw/9pfs/9p-synth.c
+++ b/hw/9pfs/9p-synth.c
@@ -495,6 +495,7 @@ static int synth_name_to_path(FsContext *ctx, V9fsPat=
h *dir_path,
     }
 out:
     /* Copy the node pointer to fid */
+    g_free(target->data);
     target->data =3D g_memdup(&node, sizeof(void *));
     target->size =3D sizeof(void *);
     return 0;
--=20
2.16.1.73.g5832b7e9f2
