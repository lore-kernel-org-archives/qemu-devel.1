Received: from eggs.gnu.org ([209.51.188.92]:59246)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1hHMmc-00055k-26
	for qemu-devel@nongnu.org; Fri, 19 Apr 2019 02:13:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1hHMmb-0004l9-4n
	for qemu-devel@nongnu.org; Fri, 19 Apr 2019 02:13:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50586)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1hHMma-0004kq-VQ
	for qemu-devel@nongnu.org; Fri, 19 Apr 2019 02:13:57 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Fri, 19 Apr 2019 03:13:34 -0300
Message-Id: <20190419061349.17094-3-ehabkost@redhat.com>
In-Reply-To: <20190419061349.17094-1-ehabkost@redhat.com>
References: <20190419061349.17094-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PATCH 02/17] vl.c: make find_default_machine() local
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Richard Henderson <rth@twiddle.net>, Igor Mammedov <imammedo@redhat.com>, Wei Yang <richardw.yang@linux.intel.com>

From: Wei Yang <richardw.yang@linux.intel.com>

Function find_default_machine() is introduced by commit 2c8cffa599b7
"vl: make find_default_machine externally visible", and it was used
outside of vl.c until commit a904410af5f1 "pc_sysfw: remove the rom_only
property".

Commit a904410af5f1 "pc_sysfw: remove the rom_only property" removed the
only user of find_default_machine() outside vl.c, but neglected to make
it static. Do that now.

Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>

Message-Id: <20190405064121.23662-2-richardw.yang@linux.intel.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 include/hw/boards.h | 1 -
 vl.c                | 2 +-
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/include/hw/boards.h b/include/hw/boards.h
index fe1885cbff..6f7916f88f 100644
--- a/include/hw/boards.h
+++ b/include/hw/boards.h
@@ -57,7 +57,6 @@ void memory_region_allocate_system_memory(MemoryRegion *mr, Object *owner,
 #define MACHINE_CLASS(klass) \
     OBJECT_CLASS_CHECK(MachineClass, (klass), TYPE_MACHINE)
 
-MachineClass *find_default_machine(void);
 extern MachineState *current_machine;
 
 void machine_run_board_init(MachineState *machine);
diff --git a/vl.c b/vl.c
index c696ad2a13..9d6a519d74 100644
--- a/vl.c
+++ b/vl.c
@@ -1488,7 +1488,7 @@ static MachineClass *find_machine(const char *name)
     return mc;
 }
 
-MachineClass *find_default_machine(void)
+static MachineClass *find_default_machine(void)
 {
     GSList *el, *machines = object_class_get_list(TYPE_MACHINE, false);
     MachineClass *mc = NULL;
-- 
2.18.0.rc1.1.g3f1ff2140
