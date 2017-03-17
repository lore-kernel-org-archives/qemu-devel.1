Received: from eggs.gnu.org ([2001:4830:134:3::10]:37113)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1copOO-0000nM-U2
	for qemu-devel@nongnu.org; Fri, 17 Mar 2017 06:46:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1copOO-0000Jz-37
	for qemu-devel@nongnu.org; Fri, 17 Mar 2017 06:45:56 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Fri, 17 Mar 2017 18:45:39 +0800
Message-Id: <20170317104541.28979-2-stefanha@redhat.com>
In-Reply-To: <20170317104541.28979-1-stefanha@redhat.com>
References: <20170317104541.28979-1-stefanha@redhat.com>
Subject: [Qemu-devel] [PATCH v2 1/3] qemu-img: show help for invalid global
 options
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, mreitz@redhat.com, Stefan Hajnoczi <stefanha@redhat.com>

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
