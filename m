Received: from eggs.gnu.org ([2001:4830:134:3::10]:34467)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cTqj4-0006H9-Tp
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 08:56:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cTqj4-0008AF-6v
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 08:56:34 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43382)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1cTqj4-00089y-1E
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 08:56:34 -0500
Received: from smtp.corp.redhat.com (int-mx16.intmail.prod.int.phx2.redhat.com
	[10.5.11.28])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1B8E72192B
	for <qemu-devel@nongnu.org>; Wed, 18 Jan 2017 13:56:34 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Wed, 18 Jan 2017 11:56:24 -0200
Message-Id: <20170118135624.17368-3-ehabkost@redhat.com>
In-Reply-To: <20170118135624.17368-1-ehabkost@redhat.com>
References: <20170118135624.17368-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PATCH 2/2] vl: Print warning when a default config
 file is loaded
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>

In case there were options set in the default config file, print
a warning so users can update their scripts.

If somebody wants to keep the config file as-is, avoid the
warning and use a command-line that will work in future QEMU
versions, they can use:

 $QEMU -nodefconfig -readconfig /etc/qemu/qemu.conf

I was going to add an additional message suggesting it as a
solution, but I thought it could make it more confusing. The
solution can be documented in the QEMU 2.9 ChangeLog.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 vl.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/vl.c b/vl.c
index b563f9b924..e80b6da4bd 100644
--- a/vl.c
+++ b/vl.c
@@ -2999,6 +2999,12 @@ static int qemu_read_default_config_file(void)
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
