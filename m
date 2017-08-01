Received: from eggs.gnu.org ([2001:4830:134:3::10]:47629)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dcX2a-0001kY-Si
	for qemu-devel@nongnu.org; Tue, 01 Aug 2017 09:16:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dcX2Z-0005Yw-MD
	for qemu-devel@nongnu.org; Tue, 01 Aug 2017 09:16:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43452)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1dcX2Z-0005YV-FB
	for qemu-devel@nongnu.org; Tue, 01 Aug 2017 09:16:51 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Tue,  1 Aug 2017 14:16:16 +0100
Message-Id: <20170801131618.27332-8-stefanha@redhat.com>
In-Reply-To: <20170801131618.27332-1-stefanha@redhat.com>
References: <20170801131618.27332-1-stefanha@redhat.com>
Subject: [Qemu-devel] [PULL 7/9] checkpatch: check trace-events code style
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, Stefan Hajnoczi <stefanha@redhat.com>

From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

According to CODING_STYLE, check that in trace-events:
1. hex numbers are prefixed with '0x'
2. '#' flag of printf is not used
3. The exclusion from 1. are period-separated groups of numbers

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Message-id: 20170731160135.12101-4-vsementsov@virtuozzo.com
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 scripts/checkpatch.pl | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 4e91122813..fa478074b8 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -1337,6 +1337,25 @@ sub process {
 			$rpt_cleaners = 1;
 		}
 
+# checks for trace-events files
+		if ($realfile =~ /trace-events$/ && $line =~ /^\+/) {
+			if ($rawline =~ /%[-+ 0]*#/) {
+				ERROR("Don't use '#' flag of printf format ('%#') in " .
+				      "trace-events, use '0x' prefix instead\n" . $herecurr);
+			} else {
+				my $hex =
+					qr/%[-+ *.0-9]*([hljztL]|ll|hh)?(x|X|"\s*PRI[xX][^"]*"?)/;
+
+				# don't consider groups splitted by [.:/ ], like 2A.20:12ab
+				my $tmpline = $rawline =~ s/($hex[.:\/ ])+$hex//gr;
+
+				if ($tmpline =~ /(?<!0x)$hex/) {
+					ERROR("Hex numbers must be prefixed with '0x'\n" .
+					      $herecurr);
+				}
+			}
+		}
+
 # check we are in a valid source file if not then ignore this hunk
 		next if ($realfile !~ /\.(h|c|cpp|s|S|pl|py|sh)$/);
 
-- 
2.13.3
