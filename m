Received: from eggs.gnu.org ([2001:4830:134:3::10]:42400)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1evS8O-0003Mj-Fu
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 14:25:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1evS8K-0000yA-Sx
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 14:25:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39942)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1evS8K-0000xr-Mf
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 14:25:16 -0400
Date: Mon, 12 Mar 2018 15:25:14 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180312182514.GD28578@localhost.localdomain>
References: <20180309202827.12085-1-ehabkost@redhat.com>
	<20180309202827.12085-9-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180309202827.12085-9-ehabkost@redhat.com>
Subject: [Qemu-devel] [PATCH v2 8/8] tests: Add check-device-crash-* rules
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, Cleber Rosa <crosa@redhat.com>

Add check-device-crash-quick and check-device-crash-full rules,
that can be used to run device-crash-test on the built QEMU
binaries.

The plan was to run check-device-crash-quick on "make check",
but qemu.py/qmp.py still don't work with Python 3.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
Changes v1 -> v2:
* Don't try to run the script on "make check" yet because it
  won't work if only Python 3 is available

---
 tests/Makefile.include | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/tests/Makefile.include b/tests/Makefile.include
index ef9b88c369..19f5ee73dc 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -942,6 +942,17 @@ check-decodetree:
           ./check.sh "$(PYTHON)" "$(SRC_PATH)/scripts/decodetree.py", \
           TEST, decodetree.py)
 
+CRASH_TEST = $(SRC_PATH)/scripts/device-crash-test
+CRASH_TEST_OPTIONS = $(if $(V),-v,-q)
+CRASH_TEST_BINARIES = $(foreach TARGET,$(TARGETS), $(TARGET)-softmmu/qemu-system-$(TARGET))
+
+.PHONY: check-device-crash-quick
+check-device-crash-quick:
+	$(CRASH_TEST) $(CRASH_TEST_OPTIONS) -t machine=DEFAULT accel=tcg -- $(CRASH_TEST_BINARIES)
+
+check-device-crash-full:
+	$(CRASH_TEST) $(CRASH_TEST_OPTIONS) -F $(CRASH_TEST_BINARIES)
+
 # Consolidated targets
 
 .PHONY: check-qapi-schema check-qtest check-unit check check-clean
-- 
2.14.3
