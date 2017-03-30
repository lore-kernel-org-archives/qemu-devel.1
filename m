Received: from eggs.gnu.org ([2001:4830:134:3::10]:36412)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1ctckP-0002N5-4d
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 12:16:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1ctckO-0002Bt-Ao
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 12:16:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58442)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1ctckO-0002B1-5Q
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 12:16:28 -0400
Date: Thu, 30 Mar 2017 19:16:26 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1490890571-2786-3-git-send-email-mst@redhat.com>
References: <1490890571-2786-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1490890571-2786-1-git-send-email-mst@redhat.com>
Subject: [Qemu-devel] [PULL 2/2] tests/acpi: don't pack a structure
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Igor Mammedov <imammedo@redhat.com>

There's no reason to pack structures where we don't care about size or
padding, this applies to AcpiStdTable in tests/acpi-utils.h.

OTOH bios-tables-test happens to be passing the address of a field in
this  struct to a function that expects a pointer to normally aligned
data which results in a SIGBUS on architectures like SPARC that have
strict alignment requirements.

Fixes: 9e8458c02 ("acpi unit-test: compare DSDT and SSDT tables against expected values")
Reported-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Tested-by: Peter Maydell <peter.maydell@linaro.org>
---
 tests/acpi-utils.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/acpi-utils.h b/tests/acpi-utils.h
index 9f9a2d5..348e4d7 100644
--- a/tests/acpi-utils.h
+++ b/tests/acpi-utils.h
@@ -26,7 +26,7 @@ typedef struct {
     gsize asl_len;
     gchar *asl_file;
     bool tmp_files_retain;   /* do not delete the temp asl/aml */
-} QEMU_PACKED AcpiSdtTable;
+} AcpiSdtTable;
 
 #define ACPI_READ_FIELD(field, addr)           \
     do {                                       \
-- 
MST
