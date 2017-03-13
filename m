Received: from eggs.gnu.org ([2001:4830:134:3::10]:59879)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cnJt1-0003bv-5y
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 02:55:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cnJsx-0004Rk-9z
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 02:55:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49720)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1cnJsx-0004Re-4V
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 02:55:15 -0400
Received: from int-mx14.intmail.prod.int.phx2.redhat.com
	(int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 5A187C05AA41
	for <qemu-devel@nongnu.org>; Mon, 13 Mar 2017 06:55:14 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Mon, 13 Mar 2017 13:11:08 +0800
Message-Id: <20170313051108.26811-1-stefanha@redhat.com>
Subject: [Qemu-devel] [PATCH] qemu-img: show help for invalid global options
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

The qemu-img sub-command executes regardless of invalid global options:

  $ qemu-img --foo info test.img
  qemu-img: unrecognized option '--foo'
  image: test.img
  ...

The unrecognized option warning may be missed by the user.  This can
hide incorrect command-lines in scripts and confuse users.

This patch prints the help information and terminates instead of
executing the sub-command.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 qemu-img.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/qemu-img.c b/qemu-img.c
index 98b836b..ce293a4 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -4339,6 +4339,7 @@ int main(int argc, char **argv)
     while ((c = getopt_long(argc, argv, "+hVT:", long_options, NULL)) != -1) {
         switch (c) {
         case 'h':
+        case '?':
             help();
             return 0;
         case 'V':
-- 
2.9.3
