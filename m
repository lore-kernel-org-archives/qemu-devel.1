Received: from eggs.gnu.org ([2001:4830:134:3::10]:41817)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dzZlr-0002nQ-Rv
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 22:50:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dzZlq-0005i9-VC
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 22:50:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34930)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1dzZlq-0005hG-Pb
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 22:50:50 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C9846882FF
	for <qemu-devel@nongnu.org>; Wed,  4 Oct 2017 02:50:49 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Tue,  3 Oct 2017 23:50:43 -0300
Message-Id: <20171004025043.3788-3-ehabkost@redhat.com>
In-Reply-To: <20171004025043.3788-1-ehabkost@redhat.com>
References: <20171004025043.3788-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PATCH v4 2/2] vl: Deprecate auto-loading of qemu.conf
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>

In case there were options set in the default config file, print
a warning so users can update their scripts.

If somebody wants to keep the config file as-is, avoid the
warning and use a command-line that will work in future QEMU
versions, they can use:

 $QEMU -no-user-config -readconfig /etc/qemu/qemu.conf

I was going to include the suggestion in the warning message, but
I thought it could make it more confusing.  The suggestion is
documented in qemu-doc.texi.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
Changes v3 -> v4:
* Use warn_report() instead of error_report("warning: ...")
  (Eric Blake)
* Document as a deprecated feature in qemu-doc.texi
* Update subject line
  (was: "vl: Print warning when a default config file is loaded")

Changes v2 -> v3:
* Rebase (no code changes)
* Commit message update: suggest -no-user-config
---
 vl.c          | 6 ++++++
 qemu-doc.texi | 8 ++++++++
 2 files changed, 14 insertions(+)

diff --git a/vl.c b/vl.c
index 3fed457921..1b0ecdf74e 100644
--- a/vl.c
+++ b/vl.c
@@ -3066,6 +3066,12 @@ static int qemu_read_default_config_file(void)
         return ret;
     }
 
+    if (ret > 0) {
+        loc_set_none();
+        warn_report("Future QEMU versions won't load %s automatically",
+                     CONFIG_QEMU_CONFDIR "/qemu.conf");
+    }
+
     return 0;
 }
 
diff --git a/qemu-doc.texi b/qemu-doc.texi
index ecd186a159..a81a09d05c 100644
--- a/qemu-doc.texi
+++ b/qemu-doc.texi
@@ -2370,6 +2370,14 @@ they were first deprecated in the 2.10.0 release.
 What follows is a list of all features currently marked as
 deprecated.
 
+@section Automatic loading of @file{qemu.conf} (since 2.11.0)
+
+The automatic loading of an user-provided @file{qemu.conf} file from the QEMU
+config directory is deprecated and behavior will change in future QEMU versions.
+To load an user-provided @file{qemu.conf} file and keep compatibility with
+future versions, the arguments @samp{-no-user-config -readconfig
+@var{CONFDIR}/qemu.conf} may be used.
+
 @section System emulator command line arguments
 
 @subsection -drive boot=on|off (since 1.3.0)
-- 
2.13.5
