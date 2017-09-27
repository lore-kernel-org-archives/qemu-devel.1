Received: from eggs.gnu.org ([2001:4830:134:3::10]:59982)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dxJ9X-0000m2-Px
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 16:41:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dxJ9X-0004DI-1b
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 16:41:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58782)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1dxJ9W-0004Cv-RL
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 16:41:54 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D5EE613D9E8
	for <qemu-devel@nongnu.org>; Wed, 27 Sep 2017 20:41:53 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Wed, 27 Sep 2017 17:41:48 -0300
Message-Id: <20170927204148.2311-3-ehabkost@redhat.com>
In-Reply-To: <20170927204148.2311-1-ehabkost@redhat.com>
References: <20170927204148.2311-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PATCH v3 2/2] vl: Print warning when a default config
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
Cc: Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

In case there were options set in the default config file, print
a warning so users can update their scripts.

If somebody wants to keep the config file as-is, avoid the
warning and use a command-line that will work in future QEMU
versions, they can use:

 $QEMU -no-user-config -readconfig /etc/qemu/qemu.conf

I was going to add an additional message suggesting it as a
solution, but I thought it could make it more confusing. The
solution can be documented in the QEMU 2.11 ChangeLog.

Reviewed-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
Changes v2 -> v3:
* Rebase (no code changes)
* Commit message update: suggest -no-user-config
---
 vl.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/vl.c b/vl.c
index 4fd01fda91..888649bbd1 100644
--- a/vl.c
+++ b/vl.c
@@ -3048,6 +3048,12 @@ static int qemu_read_default_config_file(void)
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
2.13.5
