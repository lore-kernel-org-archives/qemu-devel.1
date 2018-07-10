Received: from eggs.gnu.org ([2001:4830:134:3::10]:36026)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fcg62-00018B-MZ
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 20:01:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fcg61-0001oL-RV
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 20:01:34 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:41010 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1fcg61-0001oD-MU
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 20:01:33 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 34F7D87AC4
	for <qemu-devel@nongnu.org>; Tue, 10 Jul 2018 00:01:33 +0000 (UTC)
Date: Tue, 10 Jul 2018 03:01:32 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180710000024.542612-5-mst@redhat.com>
References: <20180710000024.542612-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180710000024.542612-1-mst@redhat.com>
Subject: [Qemu-devel] [PATCH hack dontapply v2 4/7] acpi: export
 acpi_checksum
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: ehabkost@redhat.com, imammedo@redhat.com, pbonzini@redhat.com

For most tables we supply to guests checksum is
calculated by the bios at load time.

However, when table needs to be changed later dynamically,
QEMU has to calculate the checksum.

Export acpi_checksum so ACPI generation code can re-use it.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/acpi/acpi.h | 2 ++
 hw/acpi/core.c         | 2 +-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/hw/acpi/acpi.h b/include/hw/acpi/acpi.h
index c20ace0d0b..957a064d58 100644
--- a/include/hw/acpi/acpi.h
+++ b/include/hw/acpi/acpi.h
@@ -148,6 +148,8 @@ struct ACPIREGS {
     Notifier wakeup;
 };
 
+int acpi_checksum(const uint8_t *data, int len);
+
 /* PM_TMR */
 void acpi_pm_tmr_update(ACPIREGS *ar, bool enable);
 void acpi_pm_tmr_calc_overflow_time(ACPIREGS *ar);
diff --git a/hw/acpi/core.c b/hw/acpi/core.c
index b8d39012cd..ae24d104d4 100644
--- a/hw/acpi/core.c
+++ b/hw/acpi/core.c
@@ -72,7 +72,7 @@ static void acpi_register_config(void)
 
 opts_init(acpi_register_config);
 
-static int acpi_checksum(const uint8_t *data, int len)
+int acpi_checksum(const uint8_t *data, int len)
 {
     int sum, i;
     sum = 0;
-- 
MST
