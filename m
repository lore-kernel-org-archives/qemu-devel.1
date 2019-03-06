Received: from eggs.gnu.org ([209.51.188.92]:47419)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1h1gR8-00038P-5w
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 18:59:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1h1gR7-0003mg-DY
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 18:58:58 -0500
Received: from hera.aquilenet.fr ([185.233.100.1]:43736)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <samuel.thibault@ens-lyon.org>)
	id 1h1gR7-0003lh-4X
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 18:58:57 -0500
From: Samuel Thibault <samuel.thibault@ens-lyon.org>
Date: Thu,  7 Mar 2019 00:58:48 +0100
Message-Id: <20190306235850.30110-11-samuel.thibault@ens-lyon.org>
In-Reply-To: <20190306235850.30110-1-samuel.thibault@ens-lyon.org>
References: <20190306235850.30110-1-samuel.thibault@ens-lyon.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 10/12] slirp: add a standalone Makefile
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, stefanha@redhat.com, jan.kiszka@siemens.com, Samuel Thibault <samuel.thibault@ens-lyon.org>

From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

Add a simple Makefile to build libslirp.a, a static library version of
libslirp, to be used by QEMU during a transition period, until a
shared library is available.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Message-Id: <20190212162524.31504-6-marcandre.lureau@redhat.com>
Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>
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
2.20.1
