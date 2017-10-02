Received: from eggs.gnu.org ([2001:4830:134:3::10]:38819)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dz2be-0007zA-FC
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 11:26:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dz2bc-0007yD-1c
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 11:26:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56122)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dz2bb-0007we-PO
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 11:26:03 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Mon,  2 Oct 2017 17:25:49 +0200
Message-Id: <20171002152552.27999-30-armbru@redhat.com>
In-Reply-To: <20171002152552.27999-1-armbru@redhat.com>
References: <20171002152552.27999-1-armbru@redhat.com>
Subject: [Qemu-devel] [RFC PATCH 29/32] qapi/options: QAPIfy --echr argument
 type
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

Bonus: more rigorous error checking.  Crap like '-echar 666' and
'-echar 0x' are now rejected.

FIXME the error messages are crap:
qemu-system-x86_64: -echr 666: Parameter 'null' expects int8_t
qemu-system-x86_64: -echr 0x: Parameter '<anonymous>' expects integer

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 qapi/options.json |  2 +-
 vl.c              | 10 ++--------
 2 files changed, 3 insertions(+), 9 deletions(-)

diff --git a/qapi/options.json b/qapi/options.json
index 5a8fdc04ad..853908560d 100644
--- a/qapi/options.json
+++ b/qapi/options.json
@@ -3892,7 +3892,7 @@
 # !end texinfo
 ##
 { 'option': '--echr',
-  'data': 'str',                # FIXME int
+  'data': 'int8',
   'help': "-echr chr       set terminal escape character instead of ctrl-a" }
 
 ##
diff --git a/vl.c b/vl.c
index b9524f7e11..4af2905c60 100644
--- a/vl.c
+++ b/vl.c
@@ -3574,14 +3574,8 @@ int main(int argc, char **argv, char **envp)
                 }
                 break;
             case QAPI_OPTION_KIND_ECHR:
-                {
-                    char *r;
-                    term_escape_char = strtol(qopt[i].u.echr.data, &r, 0);
-                    if (r == qopt[i].u.echr.data) {
-                        printf("Bad argument to echr\n");
-                    }
-                    break;
-                }
+                term_escape_char = qopt[i].u.echr.data;
+                break;
             case QAPI_OPTION_KIND_MONITOR:
                 default_monitor = 0;
                 if (strncmp(qopt[i].u.monitor.data, "none", 4)) {
-- 
2.13.6
