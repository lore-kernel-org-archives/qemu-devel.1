Received: from eggs.gnu.org ([209.51.188.92]:43564)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hKOZo-0005eO-QV
	for qemu-devel@nongnu.org; Sat, 27 Apr 2019 10:45:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hKOVU-00053F-Nk
	for qemu-devel@nongnu.org; Sat, 27 Apr 2019 10:40:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36814)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hKOVT-0004yf-NF
	for qemu-devel@nongnu.org; Sat, 27 Apr 2019 10:40:47 -0400
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Date: Sat, 27 Apr 2019 16:40:25 +0200
Message-Id: <20190427144025.22880-4-philmd@redhat.com>
In-Reply-To: <20190427144025.22880-1-philmd@redhat.com>
References: <20190427144025.22880-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 3/3] hw/i386/acpi: Assert a pointer is not null
 BEFORE using it
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Igor Mammedov <imammedo@redhat.com>, Samuel Ortiz <sameo@linux.intel.com>, "Michael S. Tsirkin" <mst@redhat.com>, Yang Zhong <yang.zhong@intel.com>, Thomas Huth <thuth@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Richard Henderson <rth@twiddle.net>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>

Commit 72c194f7e75c added a non-null check on the 'obj' pointer.
Later, commit 500b11ea5095 added code which uses the 'obj'
pointer _before_ the assertion check. Move the assertion
_before_ the pointer use.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 hw/i386/acpi-build.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index 123ff2b8169..b4ec14e349f 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -186,6 +186,7 @@ static void acpi_get_pm_info(AcpiPmInfo *pm)
     pm->pcihp_io_base =3D 0;
     pm->pcihp_io_len =3D 0;
=20
+    assert(obj);
     init_common_fadt_data(obj, &pm->fadt);
     if (piix) {
         /* w2k requires FADT(rev1) or it won't boot, keep PC compatible =
*/
@@ -204,7 +205,6 @@ static void acpi_get_pm_info(AcpiPmInfo *pm)
         pm->fadt.flags |=3D 1 << ACPI_FADT_F_RESET_REG_SUP;
         pm->cpu_hp_io_base =3D ICH9_CPU_HOTPLUG_IO_BASE;
     }
-    assert(obj);
=20
     /* The above need not be conditional on machine type because the res=
et port
      * happens to be the same on PIIX (pc) and ICH9 (q35). */
--=20
2.20.1
