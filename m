Received: from eggs.gnu.org ([2001:4830:134:3::10]:35770)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rjones@redhat.com>) id 1dSKHt-0004Ra-Kp
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 05:38:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rjones@redhat.com>) id 1dSKHs-00017n-QI
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 05:38:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59902)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <rjones@redhat.com>) id 1dSKHs-000179-Jz
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 05:38:28 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 7588BC058EC7
	for <qemu-devel@nongnu.org>; Tue,  4 Jul 2017 09:38:26 +0000 (UTC)
From: "Richard W.M. Jones" <rjones@redhat.com>
Date: Tue,  4 Jul 2017 10:38:15 +0100
Message-Id: <20170704093815.28285-1-rjones@redhat.com>
Subject: [Qemu-devel] [PATCH] checkpatch: Error if signal(2) is used
 non-portably.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, armbru@redhat.com, eblake@redhat.com, berrange@redhat.com

The only portable use for signal(2) is setting a signal to SIG_IGN or
SIG_DFL.  Everything else is a portability minefield.  This change
adds such a check to checkpatch.  It gives an error like this:

  ERROR: Use sigaction instead of signal, except when setting the handler to SIG_IGN or SIG_DFL
  #39: FILE: qemu-nbd.c:585:
  +    signal(SIGPIPE, foobar);

  total: 1 errors, 0 warnings, 10 lines checked

Signed-off-by: Richard W.M. Jones <rjones@redhat.com>
---
 scripts/checkpatch.pl | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 45027b9281..76a2a87b25 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -2593,6 +2593,15 @@ sub process {
 			$line =~ /\b(?:$non_exit_glib_asserts)\(/) {
 			ERROR("Use g_assert or g_assert_not_reached\n". $herecurr);
 		}
+
+# signal(2) can only portably be used for SIG_IGN or SIG_DFL.  For
+# everything else, sigaction should be used instead.
+                if ($line =~ /\bsignal\([^,]+, ([^,\)]+)/ &&
+                    $1 !~ /^SIG_(IGN|DFL)$/) {
+                    ERROR("Use sigaction instead of signal, ".
+                          "except when setting the handler to ".
+                          "SIG_IGN or SIG_DFL\n" . $herecurr);
+                }
 	}
 
 	# If we have no input at all, then there is nothing to report on
-- 
2.13.2
