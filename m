Received: from eggs.gnu.org ([2001:4830:134:3::10]:41592)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1drQMo-0007TU-W6
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 11:11:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1drQMl-00037Q-RI
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 11:11:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43238)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1drQMl-00036w-IF
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 11:11:15 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 837E0B5C1B
	for <qemu-devel@nongnu.org>; Mon, 11 Sep 2017 15:11:14 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Mon, 11 Sep 2017 17:11:06 +0200
Message-Id: <20170911151106.20734-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2] build-sys: generate tests/.gitignore
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: eblake@redhat.com, thuth@redhat.com, armbru@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

tests/.gitignore is often out of date. Let's generate it based on the
files and directories to clean. Generate it by default only when doing
in-tree build.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 Makefile                   |  9 ++++-
 tests/.gitignore           | 97 ----------------------------------------=
------
 tests/Makefile.include     | 38 ++++++++++++++++--
 tests/migration/.gitignore |  2 -
 4 files changed, 42 insertions(+), 104 deletions(-)
 delete mode 100644 tests/.gitignore
 delete mode 100644 tests/migration/.gitignore


v2:
 - only generate when doing in-tree builds
 - fix wrong ignore of tests/qemu-iotests-quick.sh

diff --git a/Makefile b/Makefile
index 81447b1f08..2ccb98cd64 100644
--- a/Makefile
+++ b/Makefile
@@ -6,7 +6,7 @@ BUILD_DIR=3D$(CURDIR)
 # Before including a proper config-host.mak, assume we are in the source=
 tree
 SRC_PATH=3D.
=20
-UNCHECKED_GOALS :=3D %clean TAGS cscope ctags docker docker-%
+UNCHECKED_GOALS :=3D %clean TAGS cscope ctags docker docker-% gitignore
=20
 # All following code might depend on configuration variables
 ifneq ($(wildcard config-host.mak),)
@@ -14,6 +14,13 @@ ifneq ($(wildcard config-host.mak),)
 all:
 include config-host.mak
=20
+.PHONY: gitignore
+ifneq ($(filter-out $(UNCHECKED_GOALS),$(MAKECMDGOALS)),$(if $(MAKECMDGO=
ALS),,fail))
+ifeq ($(BUILD_DIR),$(SRC_PATH))
+all $(MAKECMDGOALS): gitignore
+endif
+endif
+
 # Check that we're not trying to do an out-of-tree build from
 # a tree that's been used for an in-tree build.
 ifneq ($(realpath $(SRC_PATH)),$(realpath .))
diff --git a/tests/.gitignore b/tests/.gitignore
deleted file mode 100644
index fed0189a5a..0000000000
--- a/tests/.gitignore
+++ /dev/null
@@ -1,97 +0,0 @@
-atomic_add-bench
-benchmark-crypto-cipher
-benchmark-crypto-hash
-benchmark-crypto-hmac
-check-qdict
-check-qnum
-check-qjson
-check-qlist
-check-qnull
-check-qstring
-check-qom-interface
-check-qom-proplist
-qht-bench
-rcutorture
-test-aio
-test-aio-multithread
-test-arm-mptimer
-test-base64
-test-bitops
-test-bitcnt
-test-blockjob
-test-blockjob-txn
-test-bufferiszero
-test-char
-test-clone-visitor
-test-coroutine
-test-crypto-afsplit
-test-crypto-block
-test-crypto-cipher
-test-crypto-hash
-test-crypto-hmac
-test-crypto-ivgen
-test-crypto-pbkdf
-test-crypto-secret
-test-crypto-tlscredsx509
-test-crypto-tlscredsx509-work/
-test-crypto-tlscredsx509-certs/
-test-crypto-tlssession
-test-crypto-tlssession-work/
-test-crypto-tlssession-client/
-test-crypto-tlssession-server/
-test-crypto-xts
-test-cutils
-test-hbitmap
-test-hmp
-test-int128
-test-iov
-test-io-channel-buffer
-test-io-channel-command
-test-io-channel-command.fifo
-test-io-channel-file
-test-io-channel-file.txt
-test-io-channel-socket
-test-io-channel-tls
-test-io-task
-test-keyval
-test-logging
-test-mul64
-test-opts-visitor
-test-qapi-event.[ch]
-test-qapi-types.[ch]
-test-qapi-util
-test-qapi-visit.[ch]
-test-qdev-global-props
-test-qemu-opts
-test-qdist
-test-qga
-test-qht
-test-qht-par
-test-qmp-commands
-test-qmp-commands.h
-test-qmp-event
-test-qobject-input-strict
-test-qobject-input-visitor
-test-qmp-introspect.[ch]
-test-qmp-marshal.c
-test-qobject-output-visitor
-test-rcu-list
-test-replication
-test-shift128
-test-string-input-visitor
-test-string-output-visitor
-test-thread-pool
-test-throttle
-test-timed-average
-test-uuid
-test-visitor-serialization
-test-vmstate
-test-write-threshold
-test-x86-cpuid
-test-x86-cpuid-compat
-test-xbzrle
-test-netfilter
-test-filter-mirror
-test-filter-redirector
-*-test
-qapi-schema/*.test.*
diff --git a/tests/Makefile.include b/tests/Makefile.include
index f08b7418f0..29d8e4ebf4 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -901,8 +901,33 @@ $(patsubst %, check-%, $(check-qapi-schema-y)): chec=
k-%.json: $(SRC_PATH)/%.json
 check-tests/qapi-schema/doc-good.texi: tests/qapi-schema/doc-good.test.t=
exi
 	@diff -q $(SRC_PATH)/tests/qapi-schema/doc-good.texi $<
=20
-# Consolidated targets
+tests-cleanfiles =3D *.o
+tests-cleanfiles +=3D .gitignore
+tests-cleanfiles +=3D qht-bench$(EXESUF)
+tests-cleanfiles +=3D qapi-schema/*.test.*
+tests-cleanfiles +=3D test-qapi-event.[ch]
+tests-cleanfiles +=3D test-qapi-types.[ch]
+tests-cleanfiles +=3D test-qapi-visit.[ch]
+tests-cleanfiles +=3D test-qmp-introspect.[ch]
+tests-cleanfiles +=3D test-qmp-commands.h
+tests-cleanfiles +=3D test-qmp-marshal.c
+tests-cleanfiles +=3D $(subst tests/,,$(check-unit-y))
+tests-cleanfiles +=3D $(subst tests/,,$(check-speed-y))
+tests-cleanfiles +=3D $(subst tests/,,$(check-qtest-y))
+tests-cleanfiles +=3D $(subst tests/,,$(QEMU_IOTESTS_HELPERS-y))
+tests-cleanfiles +=3D migration/initrd-stress.img
+tests-cleanfiles +=3D migration/stress$(EXESUF)
+tests-cleanfiles +=3D atomic_add-bench$(EXESUF)
+tests-cleanfiles +=3D test-io-channel-file.txt
+tests-cleanfiles +=3D test-io-channel-command.fifo
+
+tests-cleandirs +=3D test-crypto-tlscredsx509-certs/
+tests-cleandirs +=3D test-crypto-tlscredsx509-work/
+tests-cleandirs +=3D test-crypto-tlssession-client/
+tests-cleandirs +=3D test-crypto-tlssession-server/
+tests-cleandirs +=3D test-crypto-tlssession-work/
=20
+# Consolidated targets
 .PHONY: check-qapi-schema check-qtest check-unit check check-clean
 check-qapi-schema: $(patsubst %,check-%, $(check-qapi-schema-y)) check-t=
ests/qapi-schema/doc-good.texi
 check-qtest: $(patsubst %,check-qtest-%, $(QTEST_TARGETS))
@@ -912,15 +937,20 @@ check-block: $(patsubst %,check-%, $(check-block-y)=
)
 check: check-qapi-schema check-unit check-qtest
 check-clean:
 	$(MAKE) -C tests/tcg clean
-	rm -rf $(check-unit-y) tests/*.o $(QEMU_IOTESTS_HELPERS-y)
-	rm -rf $(sort $(foreach target,$(SYSEMU_TARGET_LIST), $(check-qtest-$(t=
arget)-y)) $(check-qtest-generic-y))
-
+	rm -f $(addprefix tests/, $(tests-cleanfiles))
+	rm -rf $(addprefix tests/, $(tests-cleandirs))
 clean: check-clean
=20
 # Build the help program automatically
=20
 all: $(QEMU_IOTESTS_HELPERS-y)
=20
+$(SRC_PATH)/tests/.gitignore: $(MAKEFILE_LIST)
+	$(call quiet-command, echo "$(tests-cleanfiles)" "$(tests-cleandirs)" |=
 \
+		xargs -n1 | sort | uniq | sed -e s:^:/: > $@,"GEN","$(@F)")
+
+gitignore: $(SRC_PATH)/tests/.gitignore
+
 -include $(wildcard tests/*.d)
 -include $(wildcard tests/libqos/*.d)
=20
diff --git a/tests/migration/.gitignore b/tests/migration/.gitignore
deleted file mode 100644
index 84f37552e4..0000000000
--- a/tests/migration/.gitignore
+++ /dev/null
@@ -1,2 +0,0 @@
-initrd-stress.img
-stress
--=20
2.14.1.146.gd35faa819
