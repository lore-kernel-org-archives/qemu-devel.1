Received: from eggs.gnu.org ([209.51.188.92]:54693)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1h1DHf-0001gv-J1
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 11:51:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1h1DHe-00011v-QM
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 11:51:15 -0500
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436]:36419)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1h1DHe-0000zo-Ig
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 11:51:14 -0500
Received: by mail-wr1-x436.google.com with SMTP id o17so10263426wrw.3
	for <qemu-devel@nongnu.org>; Tue, 05 Mar 2019 08:51:14 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
	by smtp.gmail.com with ESMTPSA id 2sm10071495wrg.89.2019.03.05.08.51.12
	for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 05 Mar 2019 08:51:12 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue,  5 Mar 2019 16:50:46 +0000
Message-Id: <20190305165051.26860-18-peter.maydell@linaro.org>
In-Reply-To: <20190305165051.26860-1-peter.maydell@linaro.org>
References: <20190305165051.26860-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 17/22] vl: Set machine ram_size,
 maxram_size and ram_slots earlier
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Eric Auger <eric.auger@redhat.com>

The machine RAM attributes will need to be analyzed during the
configure_accelerator() process. especially kvm_type() arm64
machine callback will use them to know how many IPA/GPA bits are
needed to model the whole RAM range. So let's assign those machine
state fields before calling configure_accelerator.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Message-id: 20190304101339.25970-7-eric.auger@redhat.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 vl.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/vl.c b/vl.c
index 502857a1769..fd0d51320d8 100644
--- a/vl.c
+++ b/vl.c
@@ -4239,6 +4239,9 @@ int main(int argc, char **argv, char **envp)
     machine_opts = qemu_get_machine_opts();
     qemu_opt_foreach(machine_opts, machine_set_property, current_machine,
                      &error_fatal);
+    current_machine->ram_size = ram_size;
+    current_machine->maxram_size = maxram_size;
+    current_machine->ram_slots = ram_slots;
 
     configure_accelerator(current_machine, argv[0]);
 
@@ -4434,9 +4437,6 @@ int main(int argc, char **argv, char **envp)
     replay_checkpoint(CHECKPOINT_INIT);
     qdev_machine_init();
 
-    current_machine->ram_size = ram_size;
-    current_machine->maxram_size = maxram_size;
-    current_machine->ram_slots = ram_slots;
     current_machine->boot_order = boot_order;
 
     /* parse features once if machine provides default cpu_type */
-- 
2.20.1
