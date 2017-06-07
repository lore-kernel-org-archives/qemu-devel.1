Received: from eggs.gnu.org ([2001:4830:134:3::10]:57828)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dIVh4-0005rs-OO
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 03:47:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dIVgz-0006dH-RW
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 03:47:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50768)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1dIVgz-0006c8-JE
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 03:47:49 -0400
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Wed,  7 Jun 2017 11:46:31 +0400
Message-Id: <20170607074632.13162-5-marcandre.lureau@redhat.com>
In-Reply-To: <20170607074632.13162-1-marcandre.lureau@redhat.com>
References: <20170607074632.13162-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 4/5] Replace g_malloc()+memcpy() with g_memdup()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, peter.maydell@linaro.org, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

I found these pattern via grepping the source tree. I don't have a
coccinelle script for it!

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 hw/9pfs/9p-synth.c  | 3 +--
 hw/i386/multiboot.c | 3 +--
 hw/net/eepro100.c   | 3 +--
 tests/test-iov.c    | 3 +--
 4 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/hw/9pfs/9p-synth.c b/hw/9pfs/9p-synth.c
index 4b6d4e6a3f..df0a8de08a 100644
--- a/hw/9pfs/9p-synth.c
+++ b/hw/9pfs/9p-synth.c
@@ -494,8 +494,7 @@ static int synth_name_to_path(FsContext *ctx, V9fsPat=
h *dir_path,
     }
 out:
     /* Copy the node pointer to fid */
-    target->data =3D g_malloc(sizeof(void *));
-    memcpy(target->data, &node, sizeof(void *));
+    target->data =3D g_memdup(&node, sizeof(void *));
     target->size =3D sizeof(void *);
     return 0;
 }
diff --git a/hw/i386/multiboot.c b/hw/i386/multiboot.c
index f13e23139b..6001f4caa2 100644
--- a/hw/i386/multiboot.c
+++ b/hw/i386/multiboot.c
@@ -352,8 +352,7 @@ int load_multiboot(FWCfgState *fw_cfg,
     mb_debug("           mb_mods_count =3D %d\n", mbs.mb_mods_count);
=20
     /* save bootinfo off the stack */
-    mb_bootinfo_data =3D g_malloc(sizeof(bootinfo));
-    memcpy(mb_bootinfo_data, bootinfo, sizeof(bootinfo));
+    mb_bootinfo_data =3D g_memdup(bootinfo, sizeof(bootinfo));
=20
     /* Pass variables to option rom */
     fw_cfg_add_i32(fw_cfg, FW_CFG_KERNEL_ENTRY, mh_entry_addr);
diff --git a/hw/net/eepro100.c b/hw/net/eepro100.c
index 4bf71f2d85..7d3b2e52c7 100644
--- a/hw/net/eepro100.c
+++ b/hw/net/eepro100.c
@@ -1894,8 +1894,7 @@ static void e100_nic_realize(PCIDevice *pci_dev, Er=
ror **errp)
=20
     qemu_register_reset(nic_reset, s);
=20
-    s->vmstate =3D g_malloc(sizeof(vmstate_eepro100));
-    memcpy(s->vmstate, &vmstate_eepro100, sizeof(vmstate_eepro100));
+    s->vmstate =3D g_memdup(&vmstate_eepro100, sizeof(vmstate_eepro100))=
;
     s->vmstate->name =3D qemu_get_queue(s->nic)->model;
     vmstate_register(&pci_dev->qdev, -1, s->vmstate, s);
 }
diff --git a/tests/test-iov.c b/tests/test-iov.c
index a22d71fd2c..fa3d75aee1 100644
--- a/tests/test-iov.c
+++ b/tests/test-iov.c
@@ -167,8 +167,7 @@ static void test_io(void)
     }
     iov_from_buf(iov, niov, 0, buf, sz);
=20
-    siov =3D g_malloc(sizeof(*iov) * niov);
-    memcpy(siov, iov, sizeof(*iov) * niov);
+    siov =3D g_memdup(iov, sizeof(*iov) * niov);
=20
     if (socketpair(PF_UNIX, SOCK_STREAM, 0, sv) < 0) {
        perror("socketpair");
--=20
2.13.0.91.g00982b8dd
