Received: from eggs.gnu.org ([2001:4830:134:3::10]:43496)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1cHKCP-0004xz-8c
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 19:47:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1cHKCM-0001hm-MP
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 19:47:05 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:50719)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1cHKCM-0001h4-CF
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 19:47:02 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
	uBF0ha7C016242
	for <qemu-devel@nongnu.org>; Wed, 14 Dec 2016 19:47:01 -0500
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
	by mx0a-001b2d01.pphosted.com with ESMTP id 27bdm515um-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 14 Dec 2016 19:47:01 -0500
Received: from localhost
	by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Wed, 14 Dec 2016 17:47:00 -0700
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Wed, 14 Dec 2016 18:44:55 -0600
In-Reply-To: <1481762701-4587-1-git-send-email-mdroth@linux.vnet.ibm.com>
References: <1481762701-4587-1-git-send-email-mdroth@linux.vnet.ibm.com>
Message-Id: <1481762701-4587-62-git-send-email-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 61/67] rules.mak: Use -r instead of -Wl,
 -r to fix building when PIE is default
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Adrian Bunk <bunk@stusta.de>, Paolo Bonzini <pbonzini@redhat.com>

From: Adrian Bunk <bunk@stusta.de>

Building qemu fails in distributions where gcc enables PIE by default
(e.g. Debian unstable) with:

/usr/bin/ld: -r and -pie may not be used together

Use -r instead of -Wl,-r to avoid gcc passing -pie to the linker
when PIE is enabled and a relocatable object is passed.

Signed-off-by: Adrian Bunk <bunk@stusta.de>
Message-Id: <20161127162817.15144-1-bunk@stusta.de>
Cc: qemu-stable@nongnu.org
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
(cherry picked from commit c96f0ee6a67ca6277366e78ce5d84d5c20dd596f)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 rules.mak | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/rules.mak b/rules.mak
index 99cd0b3..97f1aa1 100644
--- a/rules.mak
+++ b/rules.mak
@@ -92,7 +92,7 @@ module-common.o: CFLAGS += $(DSO_OBJ_CFLAGS)
 	$(if $(findstring /,$@),$(call quiet-command,cp $@ $(subst /,-,$@), "  CP    $(subst /,-,$@)"))
 
 
-LD_REL := $(CC) -nostdlib -Wl,-r $(LD_REL_FLAGS)
+LD_REL := $(CC) -nostdlib -r $(LD_REL_FLAGS)
 
 %.mo:
 	$(call quiet-command,$(LD_REL) -o $@ $^,"  LD -r $(TARGET_DIR)$@")
-- 
1.9.1
