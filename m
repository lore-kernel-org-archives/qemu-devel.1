Received: from eggs.gnu.org ([2001:4830:134:3::10]:38821)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dz2be-0007zF-Il
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 11:26:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dz2bc-0007yL-3D
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 11:26:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34840)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dz2bb-0007wl-Oc
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 11:26:03 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Mon,  2 Oct 2017 17:25:50 +0200
Message-Id: <20171002152552.27999-31-armbru@redhat.com>
In-Reply-To: <20171002152552.27999-1-armbru@redhat.com>
References: <20171002152552.27999-1-armbru@redhat.com>
Subject: [Qemu-devel] [RFC PATCH 30/32] qapi/options: QAPIfy
 --watchdog-action argument type
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: mdroth@linux.vnet.ibm.com, marcandre.lureau@redhat.com, eblake@redhat.com
List-ID: <qemu-devel.nongnu.org>

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 qapi/options.json | 2 +-
 vl.c              | 7 ++-----
 2 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/qapi/options.json b/qapi/options.json
index 853908560d..eb1a3e2dde 100644
--- a/qapi/options.json
+++ b/qapi/options.json
@@ -3868,7 +3868,7 @@
 # !end texinfo
 ##
 { 'option': '--watchdog-action',
-  'data': 'str',                # FIXME enum
+  'data': 'WatchdogAction',
   'help': [
 "-watchdog-action reset|shutdown|poweroff|inject-nmi|pause|debug|none",
 "                action when watchdog fires [default=reset]"] }
diff --git a/vl.c b/vl.c
index 4af2905c60..1814a53337 100644
--- a/vl.c
+++ b/vl.c
@@ -3724,11 +3724,8 @@ int main(int argc, char **argv, char **envp)
                 watchdog = qopt[i].u.watchdog.data;
                 break;
             case QAPI_OPTION_KIND_WATCHDOG_ACTION:
-                if (select_watchdog_action(qopt[i].u.watchdog_action.data)
-                    == -1) {
-                    error_report("unknown -watchdog-action parameter");
-                    exit(1);
-                }
+                qmp_watchdog_set_action(qopt[i].u.watchdog_action.data,
+                                        &error_abort);
                 break;
             case QAPI_OPTION_KIND_VIRTIOCONSOLE:
                 add_device_config(DEV_VIRTCON, qopt[i].u.virtioconsole.data);
-- 
2.13.6
