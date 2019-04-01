Received: from eggs.gnu.org ([209.51.188.92]:46931)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1hAxgh-0006VD-Bs
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 10:13:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1hAxgf-00072t-Ms
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 10:13:23 -0400
From: Laurent Vivier <lvivier@redhat.com>
Date: Mon,  1 Apr 2019 16:12:22 +0200
Message-Id: <20190401141222.30034-6-lvivier@redhat.com>
In-Reply-To: <20190401141222.30034-1-lvivier@redhat.com>
References: <20190401141222.30034-1-lvivier@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 5/5] build: don't build hardware objects
 with linux-user
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, qemu-s390x@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Thomas Huth <thuth@redhat.com>, David Hildenbrand <david@redhat.com>, Richard Henderson <rth@twiddle.net>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Laurent Vivier <laurent@vivier.eu>

Some objects are only needed for system emulation and tools.
We can ignore them for the user mode case

Update tests to run accordingly: conditionally build some tests
on CONFIG_BLOCK.

Some tests use components that are only built when softmmu or
block tools are enabled, not for linux-user. So, if these components
are not available, disable the tests.

Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 Makefile               |  4 ++
 Makefile.objs          | 14 ++++---
 tests/Makefile.include | 90 +++++++++++++++++++++---------------------
 3 files changed, 58 insertions(+), 50 deletions(-)

diff --git a/Makefile b/Makefile
index d2de0b6e56cc..ab6e8d00979b 100644
--- a/Makefile
+++ b/Makefile
@@ -87,6 +87,10 @@ endif
=20
 include $(SRC_PATH)/rules.mak
=20
+# notempy and lor are defined in rules.mak
+CONFIG_TOOLS :=3D $(call notempty,$(TOOLS))
+CONFIG_BLOCK :=3D $(call lor,$(CONFIG_SOFTMMU),$(CONFIG_TOOLS))
+
 # Create QEMU_PKGVERSION and FULL_VERSION strings
 # If PKGVERSION is set, use that; otherwise get version and -dirty statu=
s from git
 QEMU_PKGVERSION :=3D $(if $(PKGVERSION),$(PKGVERSION),$(shell \
diff --git a/Makefile.objs b/Makefile.objs
index 43c9e4503297..2b0793ecc9ff 100644
--- a/Makefile.objs
+++ b/Makefile.objs
@@ -127,9 +127,17 @@ rdmacm-mux-obj-y =3D contrib/rdmacm-mux/
 trace-events-subdirs =3D
 trace-events-subdirs +=3D accel/kvm
 trace-events-subdirs +=3D accel/tcg
+trace-events-subdirs +=3D crypto
+ifeq ($(CONFIG_USER_ONLY),y)
+trace-events-subdirs +=3D linux-user
+endif
+ifeq ($(CONFIG_BLOCK),y)
 trace-events-subdirs +=3D authz
 trace-events-subdirs +=3D block
-trace-events-subdirs +=3D crypto
+trace-events-subdirs +=3D io
+trace-events-subdirs +=3D nbd
+trace-events-subdirs +=3D scsi
+endif
 ifeq ($(CONFIG_SOFTMMU),y)
 trace-events-subdirs +=3D chardev
 trace-events-subdirs +=3D audio
@@ -178,12 +186,8 @@ trace-events-subdirs +=3D net
 trace-events-subdirs +=3D ui
 endif
 trace-events-subdirs +=3D hw/display
-trace-events-subdirs +=3D io
-trace-events-subdirs +=3D linux-user
-trace-events-subdirs +=3D nbd
 trace-events-subdirs +=3D qapi
 trace-events-subdirs +=3D qom
-trace-events-subdirs +=3D scsi
 trace-events-subdirs +=3D target/arm
 trace-events-subdirs +=3D target/hppa
 trace-events-subdirs +=3D target/i386
diff --git a/tests/Makefile.include b/tests/Makefile.include
index 428a9eaaf762..3be3be0b13cb 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -45,7 +45,7 @@ SYSEMU_TARGET_LIST :=3D $(subst -softmmu.mak,,$(notdir =
\
=20
 check-unit-y +=3D tests/check-qdict$(EXESUF)
 check-unit-y +=3D tests/check-block-qdict$(EXESUF)
-check-unit-y +=3D tests/test-char$(EXESUF)
+check-unit-$(CONFIG_SOFTMMU) +=3D tests/test-char$(EXESUF)
 check-unit-y +=3D tests/check-qnum$(EXESUF)
 check-unit-y +=3D tests/check-qstring$(EXESUF)
 check-unit-y +=3D tests/check-qlist$(EXESUF)
@@ -61,21 +61,21 @@ check-unit-y +=3D tests/test-string-input-visitor$(EX=
ESUF)
 check-unit-y +=3D tests/test-string-output-visitor$(EXESUF)
 check-unit-y +=3D tests/test-qmp-event$(EXESUF)
 check-unit-y +=3D tests/test-opts-visitor$(EXESUF)
-check-unit-y +=3D tests/test-coroutine$(EXESUF)
+check-unit-$(CONFIG_BLOCK) +=3D tests/test-coroutine$(EXESUF)
 check-unit-y +=3D tests/test-visitor-serialization$(EXESUF)
 check-unit-y +=3D tests/test-iov$(EXESUF)
-check-unit-y +=3D tests/test-aio$(EXESUF)
-check-unit-y +=3D tests/test-aio-multithread$(EXESUF)
-check-unit-y +=3D tests/test-throttle$(EXESUF)
-check-unit-y +=3D tests/test-thread-pool$(EXESUF)
-check-unit-y +=3D tests/test-hbitmap$(EXESUF)
-check-unit-y +=3D tests/test-bdrv-drain$(EXESUF)
-check-unit-y +=3D tests/test-bdrv-graph-mod$(EXESUF)
-check-unit-y +=3D tests/test-blockjob$(EXESUF)
-check-unit-y +=3D tests/test-blockjob-txn$(EXESUF)
-check-unit-y +=3D tests/test-block-backend$(EXESUF)
-check-unit-y +=3D tests/test-block-iothread$(EXESUF)
-check-unit-y +=3D tests/test-image-locking$(EXESUF)
+check-unit-$(CONFIG_BLOCK) +=3D tests/test-aio$(EXESUF)
+check-unit-$(CONFIG_BLOCK) +=3D tests/test-aio-multithread$(EXESUF)
+check-unit-$(CONFIG_BLOCK) +=3D tests/test-throttle$(EXESUF)
+check-unit-$(CONFIG_BLOCK) +=3D tests/test-thread-pool$(EXESUF)
+check-unit-$(CONFIG_BLOCK) +=3D tests/test-hbitmap$(EXESUF)
+check-unit-$(CONFIG_BLOCK) +=3D tests/test-bdrv-drain$(EXESUF)
+check-unit-$(CONFIG_BLOCK) +=3D tests/test-bdrv-graph-mod$(EXESUF)
+check-unit-$(CONFIG_BLOCK) +=3D tests/test-blockjob$(EXESUF)
+check-unit-$(CONFIG_BLOCK) +=3D tests/test-blockjob-txn$(EXESUF)
+check-unit-$(CONFIG_BLOCK) +=3D tests/test-block-backend$(EXESUF)
+check-unit-$(CONFIG_BLOCK) +=3D tests/test-block-iothread$(EXESUF)
+check-unit-$(CONFIG_BLOCK) +=3D tests/test-image-locking$(EXESUF)
 check-unit-y +=3D tests/test-x86-cpuid$(EXESUF)
 # all code tested by test-x86-cpuid is inside topology.h
 ifeq ($(CONFIG_SOFTMMU),y)
@@ -101,40 +101,40 @@ check-unit-y +=3D tests/check-qom-interface$(EXESUF=
)
 check-unit-y +=3D tests/check-qom-proplist$(EXESUF)
 check-unit-y +=3D tests/test-qemu-opts$(EXESUF)
 check-unit-y +=3D tests/test-keyval$(EXESUF)
-check-unit-y +=3D tests/test-write-threshold$(EXESUF)
-check-unit-y +=3D tests/test-crypto-hash$(EXESUF)
-check-speed-y +=3D tests/benchmark-crypto-hash$(EXESUF)
-check-unit-y +=3D tests/test-crypto-hmac$(EXESUF)
-check-speed-y +=3D tests/benchmark-crypto-hmac$(EXESUF)
-check-unit-y +=3D tests/test-crypto-cipher$(EXESUF)
-check-speed-y +=3D tests/benchmark-crypto-cipher$(EXESUF)
-check-unit-y +=3D tests/test-crypto-secret$(EXESUF)
-check-unit-$(CONFIG_GNUTLS) +=3D tests/test-crypto-tlscredsx509$(EXESUF)
-check-unit-$(CONFIG_GNUTLS) +=3D tests/test-crypto-tlssession$(EXESUF)
+check-unit-$(CONFIG_BLOCK) +=3D tests/test-write-threshold$(EXESUF)
+check-unit-$(CONFIG_BLOCK) +=3D tests/test-crypto-hash$(EXESUF)
+check-speed-$(CONFIG_BLOCK) +=3D tests/benchmark-crypto-hash$(EXESUF)
+check-unit-$(CONFIG_BLOCK) +=3D tests/test-crypto-hmac$(EXESUF)
+check-speed-$(CONFIG_BLOCK) +=3D tests/benchmark-crypto-hmac$(EXESUF)
+check-unit-$(CONFIG_BLOCK) +=3D tests/test-crypto-cipher$(EXESUF)
+check-speed-$(CONFIG_BLOCK) +=3D tests/benchmark-crypto-cipher$(EXESUF)
+check-unit-$(CONFIG_BLOCK) +=3D tests/test-crypto-secret$(EXESUF)
+check-unit-$(call land,$(CONFIG_BLOCK),$(CONFIG_GNUTLS)) +=3D tests/test=
-crypto-tlscredsx509$(EXESUF)
+check-unit-$(call land,$(CONFIG_BLOCK),$(CONFIG_GNUTLS)) +=3D tests/test=
-crypto-tlssession$(EXESUF)
 ifneq (,$(findstring qemu-ga,$(TOOLS)))
 check-unit-$(call land,$(CONFIG_LINUX),$(CONFIG_VIRTIO_SERIAL)) +=3D tes=
ts/test-qga$(EXESUF)
 endif
 check-unit-y +=3D tests/test-timed-average$(EXESUF)
 check-unit-$(CONFIG_INOTIFY1) +=3D tests/test-util-filemonitor$(EXESUF)
 check-unit-y +=3D tests/test-util-sockets$(EXESUF)
-check-unit-y +=3D tests/test-authz-simple$(EXESUF)
-check-unit-y +=3D tests/test-authz-list$(EXESUF)
-check-unit-y +=3D tests/test-authz-listfile$(EXESUF)
-check-unit-$(CONFIG_AUTH_PAM) +=3D tests/test-authz-pam$(EXESUF)
-check-unit-y +=3D tests/test-io-task$(EXESUF)
-check-unit-y +=3D tests/test-io-channel-socket$(EXESUF)
-check-unit-y +=3D tests/test-io-channel-file$(EXESUF)
-check-unit-$(CONFIG_GNUTLS) +=3D tests/test-io-channel-tls$(EXESUF)
-check-unit-y +=3D tests/test-io-channel-command$(EXESUF)
-check-unit-y +=3D tests/test-io-channel-buffer$(EXESUF)
+check-unit-$(CONFIG_BLOCK) +=3D tests/test-authz-simple$(EXESUF)
+check-unit-$(CONFIG_BLOCK) +=3D tests/test-authz-list$(EXESUF)
+check-unit-$(CONFIG_BLOCK) +=3D tests/test-authz-listfile$(EXESUF)
+check-unit-$(call land,$(CONFIG_BLOCK),$(CONFIG_AUTH_PAM)) +=3D tests/te=
st-authz-pam$(EXESUF)
+check-unit-$(CONFIG_BLOCK) +=3D tests/test-io-task$(EXESUF)
+check-unit-$(CONFIG_BLOCK) +=3D tests/test-io-channel-socket$(EXESUF)
+check-unit-$(CONFIG_BLOCK) +=3D tests/test-io-channel-file$(EXESUF)
+check-unit-$(call land,$(CONFIG_BLOCK),$(CONFIG_GNUTLS)) +=3D tests/test=
-io-channel-tls$(EXESUF)
+check-unit-$(CONFIG_BLOCK) +=3D tests/test-io-channel-command$(EXESUF)
+check-unit-$(CONFIG_BLOCK) +=3D tests/test-io-channel-buffer$(EXESUF)
 check-unit-y +=3D tests/test-base64$(EXESUF)
-check-unit-$(if $(CONFIG_NETTLE),y,$(CONFIG_GCRYPT)) +=3D tests/test-cry=
pto-pbkdf$(EXESUF)
-check-unit-y +=3D tests/test-crypto-ivgen$(EXESUF)
-check-unit-y +=3D tests/test-crypto-afsplit$(EXESUF)
-check-unit-y +=3D tests/test-crypto-xts$(EXESUF)
-check-unit-y +=3D tests/test-crypto-block$(EXESUF)
+check-unit-$(call land,$(CONFIG_BLOCK),$(if $(CONFIG_NETTLE),y,$(CONFIG_=
GCRYPT))) +=3D tests/test-crypto-pbkdf$(EXESUF)
+check-unit-$(CONFIG_BLOCK) +=3D tests/test-crypto-ivgen$(EXESUF)
+check-unit-$(CONFIG_BLOCK)  +=3D tests/test-crypto-afsplit$(EXESUF)
+check-unit-$(CONFIG_BLOCK)  +=3D tests/test-crypto-xts$(EXESUF)
+check-unit-$(CONFIG_BLOCK)  +=3D tests/test-crypto-block$(EXESUF)
 check-unit-y +=3D tests/test-logging$(EXESUF)
-check-unit-$(CONFIG_REPLICATION) +=3D tests/test-replication$(EXESUF)
+check-unit-$(call land,$(CONFIG_BLOCK),$(CONFIG_REPLICATION)) +=3D tests=
/test-replication$(EXESUF)
 check-unit-y +=3D tests/test-bufferiszero$(EXESUF)
 check-unit-y +=3D tests/test-uuid$(EXESUF)
 check-unit-y +=3D tests/ptimer-test$(EXESUF)
@@ -515,11 +515,11 @@ test-qapi-obj-y =3D tests/test-qapi-types.o \
 	tests/test-qapi-visit-sub-sub-module.o \
 	tests/test-qapi-introspect.o \
 	$(test-qom-obj-y)
-benchmark-crypto-obj-y =3D $(authz-obj-y) $(crypto-obj-y) $(test-qom-obj=
-y)
-test-crypto-obj-y =3D $(authz-obj-y) $(crypto-obj-y) $(test-qom-obj-y)
-test-io-obj-y =3D $(io-obj-y) $(test-crypto-obj-y)
-test-authz-obj-y =3D $(test-qom-obj-y) $(authz-obj-y)
-test-block-obj-y =3D $(block-obj-y) $(test-io-obj-y) tests/iothread.o
+benchmark-crypto-obj-$(CONFIG_BLOCK) =3D $(authz-obj-y) $(crypto-obj-y) =
$(test-qom-obj-y)
+test-crypto-obj-$(CONFIG_BLOCK) =3D $(authz-obj-y) $(crypto-obj-y) $(tes=
t-qom-obj-y)
+test-io-obj-$(CONFIG_BLOCK) =3D $(io-obj-y) $(test-crypto-obj-y)
+test-authz-obj-$(CONFIG_BLOCK) =3D $(test-qom-obj-y) $(authz-obj-y)
+test-block-obj-$(CONFIG_BLOCK) =3D $(block-obj-y) $(test-io-obj-y) tests=
/iothread.o
=20
 tests/check-qnum$(EXESUF): tests/check-qnum.o $(test-util-obj-y)
 tests/check-qstring$(EXESUF): tests/check-qstring.o $(test-util-obj-y)
--=20
2.20.1
