Received: from eggs.gnu.org ([2001:4830:134:3::10]:47309)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1d1H7r-0002AH-H6
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 14:48:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1d1H7o-0004cQ-Gr
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 14:48:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58014)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1d1H7o-0004cL-A5
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 14:48:16 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Thu, 20 Apr 2017 15:47:01 -0300
Message-Id: <20170420184705.25018-12-ehabkost@redhat.com>
In-Reply-To: <20170420184705.25018-1-ehabkost@redhat.com>
References: <20170420184705.25018-1-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 11/15] hw/core/null-machine: Print error message
 when using the -kernel parameter
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Thomas Huth <thuth@redhat.com>

From: Thomas Huth <thuth@redhat.com>

If the user currently tries to use the -kernel parameter, simply nothing
happens, and the user might get confused that there is nothing loaded
to memory, but also no error message has been issued. Since there is no
real generic way to load a kernel on all CPU types (but on some targets,
the generic loader can be used instead), issue an appropriate error
message here now to avoid the possible confusion.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Message-Id: <1488271971-12624-1-git-send-email-thuth@redhat.com>
Reviewed-by: Marcel Apfelbaum <marcel@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 hw/core/null-machine.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/hw/core/null-machine.c b/hw/core/null-machine.c
index 27c8369b57..864832db34 100644
--- a/hw/core/null-machine.c
+++ b/hw/core/null-machine.c
@@ -40,6 +40,12 @@ static void machine_none_init(MachineState *mch)
         memory_region_allocate_system_memory(ram, NULL, "ram", mch->ram_=
size);
         memory_region_add_subregion(get_system_memory(), 0, ram);
     }
+
+    if (mch->kernel_filename) {
+        error_report("The -kernel parameter is not supported "
+                     "(use the generic 'loader' device instead).");
+        exit(1);
+    }
 }
=20
 static void machine_none_machine_init(MachineClass *mc)
--=20
2.11.0.259.g40922b1
