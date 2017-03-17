Received: from eggs.gnu.org ([2001:4830:134:3::10]:33383)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1copFx-00063d-N1
	for qemu-devel@nongnu.org; Fri, 17 Mar 2017 06:37:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1copFt-0003vf-M4
	for qemu-devel@nongnu.org; Fri, 17 Mar 2017 06:37:13 -0400
Received: from 5.mo69.mail-out.ovh.net ([46.105.43.105]:45160)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1copFt-0003uc-G3
	for qemu-devel@nongnu.org; Fri, 17 Mar 2017 06:37:09 -0400
Received: from player738.ha.ovh.net (b7.ovh.net [213.186.33.57])
	by mo69.mail-out.ovh.net (Postfix) with ESMTP id 0FE551DE2E
	for <qemu-devel@nongnu.org>; Fri, 17 Mar 2017 11:37:06 +0100 (CET)
From: Greg Kurz <groug@kaod.org>
Date: Fri, 17 Mar 2017 11:36:59 +0100
Message-ID: <148974701986.29545.5414999102981738774.stgit@bahia>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH] checkpatch: allow longer lines for logging
 functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>

Commit f1e155bbf863a removed a bunch of stuff that really don't make sense
outside the linux kernel. An exception though is logging functions: it is
convenient to be able to grep error messages in the code. For this to work,
error strings mustn't be broken down on multiple lines, and therefore are
likely to overcome the 90 characters limit, and make checkpatch unhappy.

This patch reverts the change for logging functions and adapts it to QEMU.

Signed-off-by: Greg Kurz <groug@kaod.org>
---
 scripts/checkpatch.pl |    8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index f0845429342a..cc2796238170 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -192,6 +192,11 @@ our $typeTypedefs = qr{(?x:
         | QEMUBH                            # all uppercase
 )};
 
+our $logFunctions = qr{(?x:
+       error_report|
+       error_printf
+)};
+
 our @typeList = (
 	qr{void},
 	qr{(?:unsigned\s+)?char},
@@ -1341,7 +1346,8 @@ sub process {
 
 #90 column limit
 		if ($line =~ /^\+/ &&
-		    !($line =~ /^\+\s*"[^"]*"\s*(?:\s*|,|\)\s*;)\s*$/) &&
+		    !($line =~ /^\+\s*$logFunctions\s*\(\s*(?:([^"]*))?"[X\t]*"\s*(?:,|\)\s*;)\s*$/ ||
+		      $line =~ /^\+\s*"[^"]*"\s*(?:\s*|,|\)\s*;)\s*$/) &&
 		    $length > 80)
 		{
 			if ($length > 90) {
