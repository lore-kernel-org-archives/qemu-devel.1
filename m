Received: from eggs.gnu.org ([2001:4830:134:3::10]:34284)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1dbRXR-0005Ho-21
	for qemu-devel@nongnu.org; Sat, 29 Jul 2017 09:12:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1dbRXN-00067e-Te
	for qemu-devel@nongnu.org; Sat, 29 Jul 2017 09:12:13 -0400
Received: from mailhub.sw.ru ([195.214.232.25]:25079 helo=relay.sw.ru)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1dbRXN-00062e-IE
	for qemu-devel@nongnu.org; Sat, 29 Jul 2017 09:12:09 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Sat, 29 Jul 2017 16:11:58 +0300
Message-Id: <20170729131159.24949-4-vsementsov@virtuozzo.com>
In-Reply-To: <20170729131159.24949-1-vsementsov@virtuozzo.com>
References: <20170729131159.24949-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH v2 3/4] checkpatch: check trace-events code
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
Cc: pbonzini@redhat.com, eblake@redhat.com, mreitz@redhat.com, jsnow@redhat.com, vsementsov@virtuozzo.com, den@openvz.org, stefanha@gmail.com, peter.maydell@linaro.org, berrange@redhat.com

Accordingly to CODING_STYLE, check that in trace-events:
1. hex numbers are prefixed with '0x'
2. '#' flag of printf is not used
3. The exclusion from 1. are period-separated groups of numbers

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
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
2.11.1
