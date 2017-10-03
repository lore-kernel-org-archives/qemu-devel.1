Received: from eggs.gnu.org ([2001:4830:134:3::10]:49461)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1dzVFZ-00024Q-E1
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 18:01:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1dzVFW-0000BT-Bx
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 18:01:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54998)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
	id 1dzVFW-000099-5v
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 18:01:10 -0400
From: Alex Williamson <alex.williamson@redhat.com>
Date: Tue, 03 Oct 2017 16:00:59 -0600
Message-ID: <20171003220038.16762.20147.stgit@gimli.home>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH] Revert: checkpatch: check trace-events code
 style
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: vsementsov@virtuozzo.com, stefanha@redhat.com

Commit c3e5875afc0f ("checkpatch: check trace-events code style")
introduces a regression as reported:

https://lists.gnu.org/archive/html/qemu-devel/2017-08/msg05820.html

Bareword found where operator expected at ./scripts/checkpatch.pl line 1350, near "s/($hex[.:\/ ])+$hex//gr"
syntax error at ./scripts/checkpatch.pl line 1350, near "s/($hex[.:\/ ])+$hex//gr"
Execution of ./scripts/checkpatch.pl aborted due to compilation errors.

$ perl -v

This is perl, v5.10.1 (*) built for x86_64-linux-thread-multi

As no fix or discussion has resulted, revert the original patch.

Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>
Fixes: c3e5875afc0f ("checkpatch: check trace-events code style")
Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
---
 scripts/checkpatch.pl |   19 -------------------
 1 file changed, 19 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 3c0a28e644aa..f7e785d12a49 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -1422,25 +1422,6 @@ sub process {
 			$rpt_cleaners = 1;
 		}
 
-# checks for trace-events files
-		if ($realfile =~ /trace-events$/ && $line =~ /^\+/) {
-			if ($rawline =~ /%[-+ 0]*#/) {
-				ERROR("Don't use '#' flag of printf format ('%#') in " .
-				      "trace-events, use '0x' prefix instead\n" . $herecurr);
-			} else {
-				my $hex =
-					qr/%[-+ *.0-9]*([hljztL]|ll|hh)?(x|X|"\s*PRI[xX][^"]*"?)/;
-
-				# don't consider groups splitted by [.:/ ], like 2A.20:12ab
-				my $tmpline = $rawline =~ s/($hex[.:\/ ])+$hex//gr;
-
-				if ($tmpline =~ /(?<!0x)$hex/) {
-					ERROR("Hex numbers must be prefixed with '0x'\n" .
-					      $herecurr);
-				}
-			}
-		}
-
 # check we are in a valid source file if not then ignore this hunk
 		next if ($realfile !~ /\.(h|c|cpp|s|S|pl|py|sh)$/);
 
