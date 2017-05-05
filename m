Received: from eggs.gnu.org ([2001:4830:134:3::10]:47110)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1d6aFH-0002Lj-Tv
	for qemu-devel@nongnu.org; Fri, 05 May 2017 06:13:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1d6aFG-0006eL-4P
	for qemu-devel@nongnu.org; Fri, 05 May 2017 06:13:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60366)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1d6aFF-0006e8-Td
	for qemu-devel@nongnu.org; Fri, 05 May 2017 06:13:54 -0400
Received: from int-mx10.intmail.prod.int.phx2.redhat.com
	(int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E80F815D9
	for <qemu-devel@nongnu.org>; Fri,  5 May 2017 10:13:52 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri,  5 May 2017 12:13:27 +0200
Message-Id: <20170505101337.4650-12-pbonzini@redhat.com>
In-Reply-To: <20170505101337.4650-1-pbonzini@redhat.com>
References: <20170505101337.4650-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 11/21] checkpatch: Disallow glib asserts in main
 code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Glib commit a6a875068779 (from 2013) made many of the glib assert
macros non-fatal if a flag is set.
This causes two problems:
  a) Compilers moan that your code is unsafe even though you've
     put an assert in before the point of use.
  b) Someone evil could, in a library, call
     g_test_set_nonfatal_assertions() and cause our assertions in
     important places not to fail and potentially allow memory overruns.

Ban most of the glib assertion functions (basically everything except
g_assert and g_assert_not_reached) except in tests/

This makes checkpatch gives an error such as:

  ERROR: Use g_assert or g_assert_not_reached
  #77: FILE: vl.c:4725:
  +    g_assert_cmpstr("Chocolate", >, "Cheese");

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Message-Id: <20170427165526.19836-1-dgilbert@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 scripts/checkpatch.pl | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index f084542934..73cee81b79 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -2571,6 +2571,27 @@ sub process {
 		if ($line =~ /\bbzero\(/) {
 			ERROR("use memset() instead of bzero()\n" . $herecurr);
 		}
+		my $non_exit_glib_asserts = qr{g_assert_cmpstr|
+						g_assert_cmpint|
+						g_assert_cmpuint|
+						g_assert_cmphex|
+						g_assert_cmpfloat|
+						g_assert_true|
+						g_assert_false|
+						g_assert_nonnull|
+						g_assert_null|
+						g_assert_no_error|
+						g_assert_error|
+						g_test_assert_expected_messages|
+						g_test_trap_assert_passed|
+						g_test_trap_assert_stdout|
+						g_test_trap_assert_stdout_unmatched|
+						g_test_trap_assert_stderr|
+						g_test_trap_assert_stderr_unmatched}x;
+		if ($realfile !~ /^tests\// &&
+			$line =~ /\b(?:$non_exit_glib_asserts)\(/) {
+			ERROR("Use g_assert or g_assert_not_reached\n". $herecurr);
+		}
 	}
 
 	# If we have no input at all, then there is nothing to report on
-- 
2.12.2
