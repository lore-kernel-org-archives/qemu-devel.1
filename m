Received: from eggs.gnu.org ([2001:4830:134:3::10]:49980)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1eMfCj-000100-6x
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 14:18:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1eMfCg-00012C-1t
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 14:18:01 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:47946)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1eMfCf-00010q-Nn
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 14:17:57 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	vB6JE45J043688
	for <qemu-devel@nongnu.org>; Wed, 6 Dec 2017 14:17:56 -0500
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2epmpw5emv-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 06 Dec 2017 14:17:56 -0500
Received: from localhost
	by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Wed, 6 Dec 2017 14:17:55 -0500
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Wed,  6 Dec 2017 13:16:42 -0600
In-Reply-To: <20171206191648.18208-1-mdroth@linux.vnet.ibm.com>
References: <20171206191648.18208-1-mdroth@linux.vnet.ibm.com>
Message-Id: <20171206191648.18208-50-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 49/55] nbd/server: CVE-2017-15118 Stack smash
 on large export name
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Eric Blake <eblake@redhat.com>

From: Eric Blake <eblake@redhat.com>

Introduced in commit f37708f6b8 (2.10).  The NBD spec says a client
can request export names up to 4096 bytes in length, even though
they should not expect success on names longer than 256.  However,
qemu hard-codes the limit of 256, and fails to filter out a client
that probes for a longer name; the result is a stack smash that can
potentially give an attacker arbitrary control over the qemu
process.

The smash can be easily demonstrated with this client:
$ qemu-io f raw nbd://localhost:10809/$(printf %3000d 1 | tr ' ' a)

If the qemu NBD server binary (whether the standalone qemu-nbd, or
the builtin server of QMP nbd-server-start) was compiled with
-fstack-protector-strong, the ability to exploit the stack smash
into arbitrary execution is a lot more difficult (but still
theoretically possible to a determined attacker, perhaps in
combination with other CVEs).  Still, crashing a running qemu (and
losing the VM) is bad enough, even if the attacker did not obtain
full execution control.

CC: qemu-stable@nongnu.org
Signed-off-by: Eric Blake <eblake@redhat.com>
(cherry picked from commit 51ae4f8455c9e32c54770c4ebc25bf86a8128183)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 nbd/server.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/nbd/server.c b/nbd/server.c
index b93cb88911..56aed3a735 100644
--- a/nbd/server.c
+++ b/nbd/server.c
@@ -393,6 +393,10 @@ static int nbd_negotiate_handle_info(NBDClient *client, uint32_t length,
         msg = "name length is incorrect";
         goto invalid;
     }
+    if (namelen >= sizeof(name)) {
+        msg = "name too long for qemu";
+        goto invalid;
+    }
     if (nbd_read(client->ioc, name, namelen, errp) < 0) {
         return -EIO;
     }
-- 
2.11.0
