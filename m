Return-Path: <SRS0=1I+v=SH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ADD2C4360F
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Apr 2019 06:43:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3BAFB206DF
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Apr 2019 06:43:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BAFB206DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:36975 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hCIZp-0004Wl-BT
	for qemu-devel@archiver.kernel.org; Fri, 05 Apr 2019 02:43:49 -0400
Received: from eggs.gnu.org ([209.51.188.92]:58142)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richardw.yang@linux.intel.com>) id 1hCIY4-0003cb-Oy
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 02:42:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richardw.yang@linux.intel.com>) id 1hCIY3-0004PH-QV
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 02:42:00 -0400
Received: from mga07.intel.com ([134.134.136.100]:40758)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <richardw.yang@linux.intel.com>)
	id 1hCIY3-0004O6-Eb
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 02:41:59 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
	by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	04 Apr 2019 23:41:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,310,1549958400"; d="scan'208";a="128814018"
Received: from richard.sh.intel.com (HELO localhost) ([10.239.159.54])
	by orsmga007.jf.intel.com with ESMTP; 04 Apr 2019 23:41:56 -0700
From: Wei Yang <richardw.yang@linux.intel.com>
To: qemu-devel@nongnu.org
Date: Fri,  5 Apr 2019 14:41:18 +0800
Message-Id: <20190405064121.23662-2-richardw.yang@linux.intel.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190405064121.23662-1-richardw.yang@linux.intel.com>
References: <20190405064121.23662-1-richardw.yang@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 134.134.136.100
Subject: [Qemu-devel] [PATCH v2 1/4] vl.c: make find_default_machine() local
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: pbonzini@redhat.com, Wei Yang <richardw.yang@linux.intel.com>,
	ehabkost@redhat.com, armbru@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190405064118.9eCkI3t7VsA4OvzyxvuN1Z3GHqjffUr07SoeaPLiB3E@z>

Function find_default_machine() is introduced by commit 2c8cffa599b7
"vl: make find_default_machine externally visible", and it was used
outside of vl.c until commit a904410af5f1 "pc_sysfw: remove the rom_only
property".

Commit a904410af5f1 "pc_sysfw: remove the rom_only property" removed the
only user of find_default_machine() outside vl.c, but neglected to make
it static. Do that now.

Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>

---
v2:
  * refactor changelog as suggested by Markus
  * move one not related change to patch 2
---
 include/hw/boards.h | 1 -
 vl.c                | 2 +-
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/include/hw/boards.h b/include/hw/boards.h
index 21212f0859..e911d56c28 100644
--- a/include/hw/boards.h
+++ b/include/hw/boards.h
@@ -57,7 +57,6 @@ void memory_region_allocate_system_memory(MemoryRegion *mr, Object *owner,
 #define MACHINE_CLASS(klass) \
     OBJECT_CLASS_CHECK(MachineClass, (klass), TYPE_MACHINE)
 
-MachineClass *find_default_machine(void);
 extern MachineState *current_machine;
 
 void machine_run_board_init(MachineState *machine);
diff --git a/vl.c b/vl.c
index 502857a176..8a874e81a3 100644
--- a/vl.c
+++ b/vl.c
@@ -1441,7 +1441,7 @@ static MachineClass *find_machine(const char *name)
     return mc;
 }
 
-MachineClass *find_default_machine(void)
+static MachineClass *find_default_machine(void)
 {
     GSList *el, *machines = object_class_get_list(TYPE_MACHINE, false);
     MachineClass *mc = NULL;
-- 
2.19.1


