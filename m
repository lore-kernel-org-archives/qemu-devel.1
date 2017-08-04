Received: from eggs.gnu.org ([2001:4830:134:3::10]:59797)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ddRNR-0008IR-0s
	for qemu-devel@nongnu.org; Thu, 03 Aug 2017 21:26:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ddRNQ-0003tf-7Y
	for qemu-devel@nongnu.org; Thu, 03 Aug 2017 21:26:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59236)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1ddRNP-0003sj-M3
	for qemu-devel@nongnu.org; Thu, 03 Aug 2017 21:26:08 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id AF828883AB
	for <qemu-devel@nongnu.org>; Fri,  4 Aug 2017 01:26:06 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
Date: Thu,  3 Aug 2017 20:25:37 -0500
Message-Id: <20170804012551.2714-9-eblake@redhat.com>
In-Reply-To: <20170804012551.2714-1-eblake@redhat.com>
References: <20170804012551.2714-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH v4 08/22] qtest: Avoid passing raw strings
 through hmp()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

The next patch will add __attribute__((__format__)) to hmp(), which
in turn causes gcc to warn about non-literal format strings.  Rather
than risk an arbitrary string containing % being mis-handled, always
pass variable strings along with a %s format.  It also makes it
easier to prove correctness locally, rather than auditing all the
source strings.

Signed-off-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Message-Id: <20170720214008.28494-4-eblake@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 tests/test-hmp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/test-hmp.c b/tests/test-hmp.c
index 729c0339f7..4aadd6a432 100644
--- a/tests/test-hmp.c
+++ b/tests/test-hmp.c
@@ -80,7 +80,7 @@ static void test_commands(void)
         if (verbose) {
             fprintf(stderr, "\t%s\n", hmp_cmds[i]);
         }
-        response = hmp(hmp_cmds[i]);
+        response = hmp("%s", hmp_cmds[i]);
         g_free(response);
     }

@@ -103,7 +103,7 @@ static void test_info_commands(void)
         if (verbose) {
             fprintf(stderr, "\t%s\n", info);
         }
-        resp = hmp(info);
+        resp = hmp("%s", info);
         g_free(resp);
         /* And move forward to the next line */
         info = strchr(endp + 1, '\n');
-- 
2.13.3
