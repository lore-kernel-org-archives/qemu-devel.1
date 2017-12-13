Received: from eggs.gnu.org ([2001:4830:134:3::10]:51593)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ePEhh-00012m-N4
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 16:36:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ePEhe-0002HW-JF
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 16:36:37 -0500
Received: from mail-qk0-x244.google.com ([2607:f8b0:400d:c09::244]:46671)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ePEhe-0002H2-F9
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 16:36:34 -0500
Received: by mail-qk0-x244.google.com with SMTP id b184so3858984qkc.13
	for <qemu-devel@nongnu.org>; Wed, 13 Dec 2017 13:36:34 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Wed, 13 Dec 2017 18:35:57 -0300
Message-Id: <20171213213557.26561-7-f4bug@amsat.org>
In-Reply-To: <20171213213557.26561-1-f4bug@amsat.org>
References: <20171213213557.26561-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 6/6] tests: add a Makefile rule to run Python
 qtests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@xilinx.com>, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Cleber Rosa <crosa@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, John Snow <jsnow@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, =?UTF-8?q?Luk=C3=A1=C5=A1=20Doktor?= <ldoktor@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Eric Blake <eblake@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <famz@redhat.com>, Thomas Huth <thuth@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org

We can now add Python qtests to the common $(check-qtest-y) /
$(check-qtest-$(TARGET)-y) variable.

Using the $(filter...) function, the check-qtest-% rule splits between C/Python
qtests and can run both types.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 tests/Makefile.include | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/tests/Makefile.include b/tests/Makefile.include
index c002352134..13673f6d1d 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -828,7 +828,7 @@ endif
 TARGETS=$(patsubst %-softmmu,%, $(filter %-softmmu,$(TARGET_DIRS)))
 ifeq ($(CONFIG_POSIX),y)
 QTEST_TARGETS = $(TARGETS)
-check-qtest-y=$(foreach TARGET,$(TARGETS), $(check-qtest-$(TARGET)-y))
+check-qtest-y=$(foreach TARGET,$(TARGETS), $(filter-out %.py, $(check-qtest-$(TARGET)-y)))
 check-qtest-y += $(check-qtest-generic-y)
 else
 QTEST_TARGETS =
@@ -843,6 +843,7 @@ tests/test-qga$(EXESUF): tests/test-qga.o $(qtest-obj-y)
 SPEED = quick
 GTESTER_OPTIONS = -k $(if $(V),--verbose,-q)
 GCOV_OPTIONS = -n $(if $(V),-f,)
+QPYTHONS_OPTIONS = $(if $(V),-v,)
 
 # gtester tests, possibly with verbose output
 
@@ -852,11 +853,15 @@ $(patsubst %, check-qtest-%, $(QTEST_TARGETS)): check-qtest-%: subdir-%-softmmu
 	$(call quiet-command,QTEST_QEMU_BINARY=$*-softmmu/qemu-system-$* \
 		QTEST_QEMU_IMG=qemu-img$(EXESUF) \
 		MALLOC_PERTURB_=$${MALLOC_PERTURB_:-$$(( $${RANDOM:-0} % 255 + 1))} \
-		gtester $(GTESTER_OPTIONS) -m=$(SPEED) $(check-qtest-$*-y) $(check-qtest-generic-y),"GTESTER","$@")
+		gtester $(GTESTER_OPTIONS) -m=$(SPEED) $(filter-out %.py,$(check-qtest-$*-y) $(check-qtest-generic-y)),"GTESTER","$@")
 	$(if $(CONFIG_GCOV),@for f in $(gcov-files-$*-y) $(gcov-files-generic-y); do \
 	  echo Gcov report for $$f:;\
 	  $(GCOV) $(GCOV_OPTIONS) $$f -o `dirname $$f`; \
 	done,)
+	$(if $(filter %.py,$(check-qtest-$*-y)), \
+		$(call quiet-command,PYTHONPATH=$(SRC_PATH)/scripts \
+			QEMU_PROG=$*-softmmu/qemu-system-$* \
+			$(PYTHON) $(SRC_PATH)/$(filter %.py,$(check-qtest-$*-y)) $(QPYTHONS_OPTIONS),"PYTEST","$@"),)
 
 .PHONY: $(patsubst %, check-%, $(check-unit-y) $(check-speed-y))
 $(patsubst %, check-%, $(check-unit-y) $(check-speed-y)): check-%: %
@@ -874,7 +879,7 @@ $(patsubst %, check-%, $(check-unit-y) $(check-speed-y)): check-%: %
 $(patsubst %, check-report-qtest-%.xml, $(QTEST_TARGETS)): check-report-qtest-%.xml: $(check-qtest-y)
 	$(call quiet-command,QTEST_QEMU_BINARY=$*-softmmu/qemu-system-$* \
 		QTEST_QEMU_IMG=qemu-img$(EXESUF) \
-	  gtester -q $(GTESTER_OPTIONS) -o $@ -m=$(SPEED) $(check-qtest-$*-y) $(check-qtest-generic-y),"GTESTER","$@")
+	  gtester -q $(GTESTER_OPTIONS) -o $@ -m=$(SPEED) $(filter-out %.py,$(check-qtest-$*-y) $(check-qtest-generic-y)),"GTESTER","$@")
 
 check-report-unit.xml: $(check-unit-y)
 	$(call quiet-command,gtester -q $(GTESTER_OPTIONS) -o $@ -m=$(SPEED) $^,"GTESTER","$@")
-- 
2.15.1
