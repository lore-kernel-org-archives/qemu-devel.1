Received: from eggs.gnu.org ([2001:4830:134:3::10]:44493)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <SRS0=SaHx=2L=redhat.com=mst@kernel.org>)
	id 1cjK6m-0001uT-Rl
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 01:21:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <SRS0=SaHx=2L=redhat.com=mst@kernel.org>)
	id 1cjK6h-0004D6-UI
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 01:21:00 -0500
Received: from mail.kernel.org ([198.145.29.136]:51382)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <SRS0=SaHx=2L=redhat.com=mst@kernel.org>)
	id 1cjK6h-0004CK-Mf
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 01:20:55 -0500
Date: Thu, 2 Mar 2017 08:20:51 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1488435591-17882-14-git-send-email-mst@redhat.com>
References: <1488435591-17882-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1488435591-17882-1-git-send-email-mst@redhat.com>
Subject: [Qemu-devel] [PULL 13/15] acpi: simplify _OSC
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>

Our _OSC method has a bunch of unused code loading data
into external CTRL and SUPP fields which are then never
used. Drop this in favor of a single local variable.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
---
 hw/i386/acpi-build.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index db04cf5..efbbfcb 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -1804,7 +1804,7 @@ static Aml *build_q35_osc_method(void)
     Aml *else_ctx;
     Aml *method;
     Aml *a_cwd1 = aml_name("CDW1");
-    Aml *a_ctrl = aml_name("CTRL");
+    Aml *a_ctrl = aml_local(0);
 
     method = aml_method("_OSC", 4, AML_NOTSERIALIZED);
     aml_append(method, aml_create_dword_field(aml_arg(3), aml_int(0), "CDW1"));
@@ -1814,7 +1814,6 @@ static Aml *build_q35_osc_method(void)
     aml_append(if_ctx, aml_create_dword_field(aml_arg(3), aml_int(4), "CDW2"));
     aml_append(if_ctx, aml_create_dword_field(aml_arg(3), aml_int(8), "CDW3"));
 
-    aml_append(if_ctx, aml_store(aml_name("CDW2"), aml_name("SUPP")));
     aml_append(if_ctx, aml_store(aml_name("CDW3"), a_ctrl));
 
     /*
@@ -1899,8 +1898,6 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
         aml_append(dev, aml_name_decl("_CID", aml_eisaid("PNP0A03")));
         aml_append(dev, aml_name_decl("_ADR", aml_int(0)));
         aml_append(dev, aml_name_decl("_UID", aml_int(1)));
-        aml_append(dev, aml_name_decl("SUPP", aml_int(0)));
-        aml_append(dev, aml_name_decl("CTRL", aml_int(0)));
         aml_append(dev, build_q35_osc_method());
         aml_append(sb_scope, dev);
         aml_append(dsdt, sb_scope);
-- 
MST
