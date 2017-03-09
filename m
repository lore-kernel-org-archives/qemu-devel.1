Received: from eggs.gnu.org ([2001:4830:134:3::10]:40260)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cm2gQ-0002l2-4P
	for qemu-devel@nongnu.org; Thu, 09 Mar 2017 13:21:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cm2gO-0004p7-SZ
	for qemu-devel@nongnu.org; Thu, 09 Mar 2017 13:21:02 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35158)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1cm2gO-0004ot-LB
	for qemu-devel@nongnu.org; Thu, 09 Mar 2017 13:21:00 -0500
Received: from int-mx14.intmail.prod.int.phx2.redhat.com
	(int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D4BE176F4
	for <qemu-devel@nongnu.org>; Thu,  9 Mar 2017 18:21:00 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Thu,  9 Mar 2017 15:20:49 -0300
Message-Id: <20170309182049.30040-3-ehabkost@redhat.com>
In-Reply-To: <20170309182049.30040-1-ehabkost@redhat.com>
References: <20170309182049.30040-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PATCH for-2.9? v2 2/2] vl: Print warning when a
 default config file is loaded
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

In case there were options set in the default config file, print
a warning so users can update their scripts.

If somebody wants to keep the config file as-is, avoid the
warning and use a command-line that will work in future QEMU
versions, they can use:

 $QEMU -nodefconfig -readconfig /etc/qemu/qemu.conf

I was going to add an additional message suggesting it as a
solution, but I thought it could make it more confusing. The
solution can be documented in the QEMU 2.9 ChangeLog.

Reviewed-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 vl.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/vl.c b/vl.c
index 7f1644a2be..dae86fd4a8 100644
--- a/vl.c
+++ b/vl.c
@@ -2939,6 +2939,12 @@ static int qemu_read_default_config_file(void)
         return ret;
     }
 
+    if (ret > 0) {
+        loc_set_none();
+        error_report("Warning: Future QEMU versions won't load %s automatically",
+                     CONFIG_QEMU_CONFDIR "/qemu.conf");
+    }
+
     return 0;
 }
 
-- 
2.11.0.259.g40922b1
