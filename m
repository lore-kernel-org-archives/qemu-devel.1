Received: from eggs.gnu.org ([2001:4830:134:3::10]:38362)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cYCDM-0005Gd-2E
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 08:41:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cYCDK-0006wM-Ue
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 08:41:48 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48942)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1cYCDK-0006w9-MG
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 08:41:46 -0500
Received: from int-mx14.intmail.prod.int.phx2.redhat.com
	(int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D1ADD201FB
	for <qemu-devel@nongnu.org>; Mon, 30 Jan 2017 13:41:46 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Mon, 30 Jan 2017 17:39:34 +0400
Message-Id: <20170130133954.31353-22-marcandre.lureau@redhat.com>
In-Reply-To: <20170130133954.31353-1-marcandre.lureau@redhat.com>
References: <20170130133954.31353-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 21/41] char: create chardev-obj-y
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, eblake@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

This will help to split char.c in several units without having to
reference them all everywhere. This is useful in particular for tests.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 Makefile               | 4 +++-
 Makefile.objs          | 5 +++--
 Makefile.target        | 3 +++
 chardev/Makefile.objs  | 2 +-
 tests/Makefile.include | 9 +++++----
 5 files changed, 15 insertions(+), 8 deletions(-)

diff --git a/Makefile b/Makefile
index 1e5cb1934d..aef76221f5 100644
--- a/Makefile
+++ b/Makefile
@@ -147,6 +147,7 @@ endif
=20
 dummy :=3D $(call unnest-vars,, \
                 stub-obj-y \
+                chardev-obj-y \
                 util-obj-y \
                 qga-obj-y \
                 ivshmem-client-obj-y \
@@ -223,7 +224,8 @@ subdir-dtc:dtc/libfdt dtc/tests
 dtc/%:
 	mkdir -p $@
=20
-$(SUBDIR_RULES): libqemuutil.a libqemustub.a $(common-obj-y) $(qom-obj-y=
) $(crypto-aes-obj-$(CONFIG_USER_ONLY))
+$(SUBDIR_RULES): libqemuutil.a libqemustub.a $(common-obj-y) $(chardev-o=
bj-y) \
+	$(qom-obj-y) $(crypto-aes-obj-$(CONFIG_USER_ONLY))
=20
 ROMSUBDIR_RULES=3D$(patsubst %,romsubdir-%, $(ROMS))
 # Only keep -O and -g cflags
diff --git a/Makefile.objs b/Makefile.objs
index cad4c54740..91a4794f28 100644
--- a/Makefile.objs
+++ b/Makefile.objs
@@ -51,8 +51,7 @@ common-obj-$(CONFIG_POSIX) +=3D os-posix.o
 common-obj-$(CONFIG_LINUX) +=3D fsdev/
=20
 common-obj-y +=3D migration/
-common-obj-y +=3D chardev/ #aio.o
-common-obj-y +=3D page_cache.o
+common-obj-y +=3D page_cache.o #aio.o
=20
 common-obj-$(CONFIG_SPICE) +=3D spice-qemu-char.o
=20
@@ -79,6 +78,8 @@ common-obj-$(CONFIG_SECCOMP) +=3D qemu-seccomp.o
=20
 common-obj-$(CONFIG_FDT) +=3D device_tree.o
=20
+chardev-obj-y =3D chardev/
+
 ######################################################################
 # qapi
=20
diff --git a/Makefile.target b/Makefile.target
index fa2b151caa..5a487b5187 100644
--- a/Makefile.target
+++ b/Makefile.target
@@ -172,12 +172,14 @@ all-obj-y :=3D $(obj-y)
 target-obj-y :=3D
 block-obj-y :=3D
 common-obj-y :=3D
+chardev-obj-y :=3D
 include $(SRC_PATH)/Makefile.objs
 dummy :=3D $(call unnest-vars,,target-obj-y)
 target-obj-y-save :=3D $(target-obj-y)
 dummy :=3D $(call unnest-vars,.., \
                block-obj-y \
                block-obj-m \
+               chardev-obj-y \
                crypto-obj-y \
                crypto-aes-obj-y \
                qom-obj-y \
@@ -186,6 +188,7 @@ dummy :=3D $(call unnest-vars,.., \
                common-obj-m)
 target-obj-y :=3D $(target-obj-y-save)
 all-obj-y +=3D $(common-obj-y)
+all-obj-y +=3D $(chardev-obj-y)
 all-obj-y +=3D $(target-obj-y)
 all-obj-y +=3D $(qom-obj-y)
 all-obj-$(CONFIG_SOFTMMU) +=3D $(block-obj-y)
diff --git a/chardev/Makefile.objs b/chardev/Makefile.objs
index 3fc5539518..8bf131b461 100644
--- a/chardev/Makefile.objs
+++ b/chardev/Makefile.objs
@@ -1 +1 @@
-common-obj-y +=3D char.o
+chardev-obj-y +=3D char.o
diff --git a/tests/Makefile.include b/tests/Makefile.include
index 2145b9877d..ad35a6494b 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -510,8 +510,8 @@ tests/check-qjson$(EXESUF): tests/check-qjson.o $(tes=
t-util-obj-y)
 tests/check-qom-interface$(EXESUF): tests/check-qom-interface.o $(test-q=
om-obj-y)
 tests/check-qom-proplist$(EXESUF): tests/check-qom-proplist.o $(test-qom=
-obj-y)
=20
-tests/test-char$(EXESUF): tests/test-char.o chardev/char.o qemu-timer.o =
\
-	$(test-util-obj-y) $(qtest-obj-y) $(test-block-obj-y)
+tests/test-char$(EXESUF): tests/test-char.o qemu-timer.o \
+	$(test-util-obj-y) $(qtest-obj-y) $(test-block-obj-y) $(chardev-obj-y)
 tests/test-coroutine$(EXESUF): tests/test-coroutine.o $(test-block-obj-y=
)
 tests/test-aio$(EXESUF): tests/test-aio.o $(test-block-obj-y)
 tests/test-throttle$(EXESUF): tests/test-throttle.o $(test-block-obj-y)
@@ -704,8 +704,9 @@ tests/usb-hcd-ehci-test$(EXESUF): tests/usb-hcd-ehci-=
test.o $(libqos-usb-obj-y)
 tests/usb-hcd-xhci-test$(EXESUF): tests/usb-hcd-xhci-test.o $(libqos-usb=
-obj-y)
 tests/pc-cpu-test$(EXESUF): tests/pc-cpu-test.o
 tests/postcopy-test$(EXESUF): tests/postcopy-test.o
-tests/vhost-user-test$(EXESUF): tests/vhost-user-test.o chardev/char.o q=
emu-timer.o \
-	$(qtest-obj-y) $(test-io-obj-y) $(libqos-virtio-obj-y) $(libqos-pc-obj-=
y)
+tests/vhost-user-test$(EXESUF): tests/vhost-user-test.o qemu-timer.o \
+	$(qtest-obj-y) $(test-io-obj-y) $(libqos-virtio-obj-y) $(libqos-pc-obj-=
y) \
+	$(chardev-obj-y)
 tests/qemu-iotests/socket_scm_helper$(EXESUF): tests/qemu-iotests/socket=
_scm_helper.o
 tests/test-qemu-opts$(EXESUF): tests/test-qemu-opts.o $(test-util-obj-y)
 tests/test-write-threshold$(EXESUF): tests/test-write-threshold.o $(test=
-block-obj-y)
--=20
2.11.0.295.gd7dffce1c.dirty
