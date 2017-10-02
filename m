Received: from eggs.gnu.org ([2001:4830:134:3::10]:38632)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dz2bZ-0007x0-EM
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 11:26:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dz2bW-0007rb-5d
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 11:26:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38332)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dz2bV-0007rD-W9
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 11:25:58 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Mon,  2 Oct 2017 17:25:22 +0200
Message-Id: <20171002152552.27999-3-armbru@redhat.com>
In-Reply-To: <20171002152552.27999-1-armbru@redhat.com>
References: <20171002152552.27999-1-armbru@redhat.com>
Subject: [Qemu-devel] [RFC PATCH 02/32] texi2pod: Support @verbatim
 environment
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: mdroth@linux.vnet.ibm.com, marcandre.lureau@redhat.com, eblake@redhat.com
List-ID: <qemu-devel.nongnu.org>

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 scripts/texi2pod.pl | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/scripts/texi2pod.pl b/scripts/texi2pod.pl
index 39ce584a32..2171f8b819 100755
--- a/scripts/texi2pod.pl
+++ b/scripts/texi2pod.pl
@@ -85,6 +85,13 @@ if (defined $out) {
 
 while(defined $inf) {
 while(<$inf>) {
+    # Verbatim environment
+    if (defined $endw and $endw eq "verbatim"
+	and not (/^\@end\s+([a-z]+)/ and $1 eq $endw)) {
+	$section .= "\t".$_;
+	next;
+    }
+
     # Certain commands are discarded without further processing.
     /^\@(?:
 	 [a-z]+index		# @*index: useful only in complete manual
@@ -165,7 +172,7 @@ while(<$inf>) {
 	if ($ended =~ /^(?:ifset|ifclear|ignore|menu|iftex)$/) {
 	    $skipping = pop @skstack;
 	    next;
-	} elsif ($ended =~ /^(?:example|smallexample|display
+	} elsif ($ended =~ /^(?:example|smallexample|display|verbatim
                             |quotation|deftp|deftypefn)$/x) {
 	    $shift = "";
 	    $_ = "";	# need a paragraph break
@@ -311,7 +318,7 @@ while(<$inf>) {
 	$_ = "\n=over 4\n";
     };
 
-    /^\@((?:small)?example|display)/ and do {
+    /^\@((?:small)?example|display|verbatim)/ and do {
 	push @endwstack, $endw;
 	$endw = $1;
 	$shift = "\t";
-- 
2.13.6
