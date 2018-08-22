Received: from eggs.gnu.org ([2001:4830:134:3::10]:33882)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fsPqV-0007YG-UP
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 05:54:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fsPqU-0004nl-2O
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 05:54:35 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:42466 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1fsPqT-0004n5-TQ
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 05:54:33 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E90727A7EA
	for <qemu-devel@nongnu.org>; Wed, 22 Aug 2018 09:54:32 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Wed, 22 Aug 2018 11:54:13 +0200
Message-Id: <20180822095421.11765-3-quintela@redhat.com>
In-Reply-To: <20180822095421.11765-1-quintela@redhat.com>
References: <20180822095421.11765-1-quintela@redhat.com>
Subject: [Qemu-devel] [PATCH v3 02/10] check: Use land/lor when possible
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: dgilbert@redhat.com, lvivier@redhat.com, peterx@redhat.com

So everythig is (a bit) more consistent

Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 tests/Makefile.include | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/tests/Makefile.include b/tests/Makefile.include
index 6dc8d06f4c..a705793381 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -98,11 +98,9 @@ check-unit-y += tests/test-block-backend$(EXESUF)
 check-unit-y += tests/test-x86-cpuid$(EXESUF)
 # all code tested by test-x86-cpuid is inside topology.h
 gcov-files-test-x86-cpuid-y =
-ifeq ($(CONFIG_SOFTMMU),y)
-check-unit-y += tests/test-xbzrle$(EXESUF)
-gcov-files-test-xbzrle-y = migration/xbzrle.c
-check-unit-$(CONFIG_POSIX) += tests/test-vmstate$(EXESUF)
-endif
+check-unit-$(CONFIG_SOFTMMU) += tests/test-xbzrle$(EXESUF)
+gcov-files-test-xbzrle-$(CONFIG_SOFTMMU) = migration/xbzrle.c
+check-unit-$(call land, $(CONFIG_SOFTMMU), $(CONFIG_POSIX)) += tests/test-vmstate$(EXESUF)
 check-unit-y += tests/test-cutils$(EXESUF)
 gcov-files-test-cutils-y += util/cutils.c
 check-unit-y += tests/test-shift128$(EXESUF)
@@ -299,9 +297,7 @@ check-qtest-i386-y += tests/q35-test$(EXESUF)
 check-qtest-i386-y += tests/vmgenid-test$(EXESUF)
 gcov-files-i386-y += hw/pci-host/q35.c
 check-qtest-i386-$(CONFIG_VHOST_USER_NET_TEST_i386) += tests/vhost-user-test$(EXESUF)
-ifeq ($(CONFIG_VHOST_USER_NET_TEST_i386),)
-check-qtest-x86_64-$(CONFIG_VHOST_USER_NET_TEST_x86_64) += tests/vhost-user-test$(EXESUF)
-endif
+check-qtest-x86_64-$(call lor, $(CONFIG_VHOST_USER_NET_TEST_i386), $(CONFIG_VHOST_USER_NET_TEST_x86_64)) += tests/vhost-user-test$(EXESUF)
 check-qtest-i386-$(CONFIG_TPM_CRB) += tests/tpm-crb-swtpm-test$(EXESUF)
 check-qtest-i386-$(CONFIG_TPM_CRB) += tests/tpm-crb-test$(EXESUF)
 check-qtest-i386-$(CONFIG_TPM_TIS) += tests/tpm-tis-swtpm-test$(EXESUF)
-- 
2.17.1
