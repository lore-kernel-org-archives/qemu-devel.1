Received: from eggs.gnu.org ([2001:4830:134:3::10]:36966)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ross.zwisler@linux.intel.com>) id 1fR3RJ-00012X-8I
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 18:31:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ross.zwisler@linux.intel.com>) id 1fR3RG-00051i-Ed
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 18:31:29 -0400
Received: from mga09.intel.com ([134.134.136.24]:60811)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ross.zwisler@linux.intel.com>)
	id 1fR3RG-00050W-4X
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 18:31:26 -0400
From: Ross Zwisler <ross.zwisler@linux.intel.com>
Date: Thu,  7 Jun 2018 16:31:08 -0600
Message-Id: <20180607223111.27792-2-ross.zwisler@linux.intel.com>
In-Reply-To: <20180607223111.27792-1-ross.zwisler@linux.intel.com>
References: <20180607223111.27792-1-ross.zwisler@linux.intel.com>
Subject: [Qemu-devel] [qemu PATCH 2/5] acpi: "make check" should fail on asl
 mismatch
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Ross Zwisler <ross.zwisler@linux.intel.com>, Dan Williams <dan.j.williams@intel.com>, Eduardo Habkost <ehabkost@redhat.com>, linux-nvdimm <linux-nvdimm@lists.01.org>, Qemu Developers <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>, Igor Mammedov <imammedo@redhat.com>

Currently if "make check" detects a mismatch in the ASL generated during
testing, we print an error such as:

  acpi-test: Warning! SSDT mismatch. Actual [asl:/tmp/asl-QZDWJZ.dsl,
  aml:/tmp/aml-T8JYJZ], Expected [asl:/tmp/asl-DTWVJZ.dsl,
  aml:tests/acpi-test-data/q35/SSDT.dimmpxm].

but the testing still exits with good shell status.  This is wrong, and
makes bisecting such a failure difficult.

Signed-off-by: Ross Zwisler <ross.zwisler@linux.intel.com>
---
 tests/bios-tables-test.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/bios-tables-test.c b/tests/bios-tables-test.c
index 256d463cb8..9b5db1ee8f 100644
--- a/tests/bios-tables-test.c
+++ b/tests/bios-tables-test.c
@@ -469,6 +469,7 @@ static void test_acpi_asl(test_data *data)
                     }
                 }
           }
+          g_test_fail();
         }
         g_string_free(asl, true);
         g_string_free(exp_asl, true);
-- 
2.14.4
