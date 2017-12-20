Received: from eggs.gnu.org ([2001:4830:134:3::10]:55766)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1eRjaY-0002BT-VL
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 13:59:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1eRjaU-00064t-99
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 13:59:35 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57104)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1eRjaU-00063Z-2F
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 13:59:30 -0500
From: Markus Armbruster <armbru@redhat.com>
Date: Wed, 20 Dec 2017 19:59:24 +0100
Message-Id: <20171220185924.32756-14-armbru@redhat.com>
In-Reply-To: <20171220185924.32756-1-armbru@redhat.com>
References: <20171220185924.32756-1-armbru@redhat.com>
Subject: [Qemu-devel] [PULL 13/13] qmp: remove qmp_cpu
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>, Eric Blake <eblake@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>

From: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>

'qmp_cpu' was implemented in commit 755f196898 ("qapi: Convert the cpu
command") as a functional no-op, a QMP call that does nothing and
return success. The idea, apparently, was to provide a counterpart
for the HMP 'hmp_cpu' command, introduced in the same commit.

After 6 years of its creation, qmp_cpu remains a functional no-op
that does nothing, having no value for any caller/user. A proposal
was sent to implement qmp_cpu like hmp_cpu works, but it was denied
[1]. The reason is that QMP must be as stateless as possible and a
function that changes its state (the current CPU monitor in the case
of qmp_cpu) goes against it. Any QMP command that needs a specific
monitor CPU setup must provide it in its arguments, instead of relying
in the current QMP monitor state.

After discussions that happened in [2] it was decided that a command
that does nothing since its birth, no one uses for anything and will
not be implemented, should be deprecated and erased. Given that we will
*not* provide any replacement for qmp_cpu and we believe that there
is no user relying on it, there is no point in adding a deprecation
delay for it.

So, this patch nukes qmp_cpu from QEMU code, removing both its blank
implementation in qmp.c and its doc in qapi-schema.json.

[1] https://lists.gnu.org/archive/html/qemu-devel/2017-12/msg02283.html
[2] https://lists.gnu.org/archive/html/qemu-devel/2017-12/msg03696.html

Signed-off-by: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
CC: Markus Armbruster <armbru@redhat.com>
CC: Eric Blake <eblake@redhat.com>
CC: Daniel P. Berrange <berrange@redhat.com>
Message-Id: <20171220102304.8288-1-danielhb@linux.vnet.ibm.com>
Reviewed-by: Daniel P. Berrange <berrange@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 qapi-schema.json | 11 -----------
 qmp.c            |  5 -----
 2 files changed, 16 deletions(-)

diff --git a/qapi-schema.json b/qapi-schema.json
index ea3723f903..5c06745c79 100644
--- a/qapi-schema.json
+++ b/qapi-schema.json
@@ -1046,17 +1046,6 @@
 { 'command': 'system_powerdown' }
 
 ##
-# @cpu:
-#
-# This command is a nop that is only provided for the purposes of compatibility.
-#
-# Since: 0.14.0
-#
-# Notes: Do not use this command.
-##
-{ 'command': 'cpu', 'data': {'index': 'int'} }
-
-##
 # @cpu-add:
 #
 # Adds CPU with specified ID
diff --git a/qmp.c b/qmp.c
index e8c303116a..52cfd2d81c 100644
--- a/qmp.c
+++ b/qmp.c
@@ -113,11 +113,6 @@ void qmp_system_powerdown(Error **erp)
     qemu_system_powerdown_request();
 }
 
-void qmp_cpu(int64_t index, Error **errp)
-{
-    /* Just do nothing */
-}
-
 void qmp_cpu_add(int64_t id, Error **errp)
 {
     MachineClass *mc;
-- 
2.13.6
