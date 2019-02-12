Received: from eggs.gnu.org ([209.51.188.92]:35713)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gtb2Z-0005OV-Q9
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 11:36:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gtasU-0000uO-20
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 11:25:48 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57714)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1gtasS-0000cC-4u
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 11:25:44 -0500
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 12 Feb 2019 17:25:22 +0100
Message-Id: <20190212162524.31504-6-marcandre.lureau@redhat.com>
In-Reply-To: <20190212162524.31504-1-marcandre.lureau@redhat.com>
References: <20190212162524.31504-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 5/7] slirp: add a standalone Makefile
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: samuel.thibault@ens-lyon.org, peter.maydell@linaro.org

Add a simple Makefile to build libslirp.a, a static library version of
libslirp, to be used by QEMU during a transition period, until a
shared library is available.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 slirp/Makefile | 47 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)
 create mode 100644 slirp/Makefile

diff --git a/slirp/Makefile b/slirp/Makefile
new file mode 100644
index 0000000000..6d48f626ba
--- /dev/null
+++ b/slirp/Makefile
@@ -0,0 +1,47 @@
+ROOT_DIR :=3D $(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))
+BUILD_DIR ?=3D .
+
+LIBSLIRP =3D $(BUILD_DIR)/libslirp.a
+
+all: $(LIBSLIRP)
+
+SRCS :=3D $(wildcard src/*.c)
+OBJS :=3D $(SRCS:%.c=3D$(BUILD_DIR)/%.o)
+DEPS :=3D $(OBJS:%.o=3D%.d)
+
+INC_DIRS :=3D $(BUILD_DIR)/src
+INC_FLAGS :=3D $(addprefix -I,$(INC_DIRS))
+
+override CFLAGS +=3D					\
+	-DG_LOG_DOMAIN=3D'"Slirp"'			\
+	$(shell $(PKG_CONFIG) --cflags glib-2.0)	\
+	$(INC_FLAGS)					\
+	-MMD -MP
+override LDFLAGS +=3D $(shell $(PKG_CONFIG) --libs glib-2.0)
+
+$(LIBSLIRP): $(OBJS)
+
+.PHONY: clean
+
+clean:
+	rm -r $(OBJS) $(DEPS) $(LIBSLIRP)
+
+$(BUILD_DIR)/src/%.o: $(ROOT_DIR)/src/%.c
+	@$(MKDIR_P) $(dir $@)
+	$(call quiet-command,$(CC) $(CFLAGS) -c -o $@ $<,"CC","$@")
+
+%.a:
+	$(call quiet-command,rm -f $@ && $(AR) rcs $@ $^,"AR","$@")
+
+PKG_CONFIG ?=3D pkg-config
+MKDIR_P ?=3D mkdir -p
+quiet-command-run =3D $(if $(V),,$(if $2,printf "  %-7s %s\n" $2 $3 && )=
)$1
+quiet-@ =3D $(if $(V),,@)
+quiet-command =3D $(quiet-@)$(call quiet-command-run,$1,$2,$3)
+
+print-%:
+	@echo '$*=3D$($*)'
+
+.SUFFIXES:
+
+-include $(DEPS)
--=20
2.21.0.rc0.1.g036caf7885
