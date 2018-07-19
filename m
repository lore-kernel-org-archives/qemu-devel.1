Received: from eggs.gnu.org ([2001:4830:134:3::10]:48665)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <walling@linux.ibm.com>) id 1fgAT4-00016o-Ne
	for qemu-devel@nongnu.org; Thu, 19 Jul 2018 11:03:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <walling@linux.ibm.com>) id 1fgAT1-0001jH-Jy
	for qemu-devel@nongnu.org; Thu, 19 Jul 2018 11:03:46 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:22947
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <walling@linux.ibm.com>)
	id 1fgAT1-0001iy-DU
	for qemu-devel@nongnu.org; Thu, 19 Jul 2018 11:03:43 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w6JEs3Bd115285
	for <qemu-devel@nongnu.org>; Thu, 19 Jul 2018 11:03:41 -0400
Received: from e15.ny.us.ibm.com (e15.ny.us.ibm.com [129.33.205.205])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2katuh6q1p-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 19 Jul 2018 11:03:40 -0400
Received: from localhost
	by e15.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <walling@linux.ibm.com>;
	Thu, 19 Jul 2018 11:03:40 -0400
Received: from b01ledav002.gho.pok.ibm.com (b01ledav002.gho.pok.ibm.com
	[9.57.199.107])
	by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
	w6JF3bnI63504440
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256
	verify=FAIL)
	for <qemu-devel@nongnu.org>; Thu, 19 Jul 2018 15:03:37 GMT
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CCF7D124053
	for <qemu-devel@nongnu.org>; Thu, 19 Jul 2018 12:05:06 -0400 (EDT)
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B7A9012405A
	for <qemu-devel@nongnu.org>; Thu, 19 Jul 2018 12:05:06 -0400 (EDT)
Received: from collin-ThinkPad-W541.pok.ibm.com (unknown [9.56.58.118])
	by b01ledav002.gho.pok.ibm.com (Postfix) with ESMTP
	for <qemu-devel@nongnu.org>; Thu, 19 Jul 2018 12:05:06 -0400 (EDT)
From: Collin Walling <walling@linux.ibm.com>
Date: Thu, 19 Jul 2018 11:03:37 -0400
Message-Id: <1532012617-16777-1-git-send-email-walling@linux.ibm.com>
Subject: [Qemu-devel] [PATCH] monitor: print message when using 'help' with
 an unknown command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

When typing 'help' followed by an unknown command, QEMU will
not print anything to the command line to let the user know
they typed a bad command. Let's fix this by printing a message
to the monitor when this happens. For example:

    (qemu) help xyz
    unknown command: 'xyz'

Reported-by: Stefan Zimmermann <stzi@linux.ibm.com>
Signed-off-by: Collin Walling <walling@linux.ibm.com>
---
 monitor.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/monitor.c b/monitor.c
index 7af1f18..7942f9f 100644
--- a/monitor.c
+++ b/monitor.c
@@ -1034,9 +1034,12 @@ static void help_cmd_dump(Monitor *mon, const mon_cmd_t *cmds,
             } else {
                 help_cmd_dump_one(mon, cmd, args, arg_index);
             }
-            break;
+            return;
         }
     }
+
+    /* Entry not found */
+    monitor_printf(mon, "unknown command: '%s'\n", args[arg_index]);
 }
 
 static void help_cmd(Monitor *mon, const char *name)
-- 
2.7.4
