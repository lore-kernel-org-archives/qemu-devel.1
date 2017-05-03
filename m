Received: from eggs.gnu.org ([2001:4830:134:3::10]:44109)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1d5qpI-000445-Px
	for qemu-devel@nongnu.org; Wed, 03 May 2017 05:44:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1d5qpE-0006n9-34
	for qemu-devel@nongnu.org; Wed, 03 May 2017 05:44:04 -0400
Received: from mail-wr0-x242.google.com ([2a00:1450:400c:c0c::242]:35341)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1d5qpD-0006mg-S3
	for qemu-devel@nongnu.org; Wed, 03 May 2017 05:44:00 -0400
Received: by mail-wr0-x242.google.com with SMTP id g12so21848373wrg.2
	for <qemu-devel@nongnu.org>; Wed, 03 May 2017 02:43:59 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed,  3 May 2017 11:43:51 +0200
Message-Id: <20170503094351.5040-6-pbonzini@redhat.com>
In-Reply-To: <20170503094351.5040-1-pbonzini@redhat.com>
References: <20170503094351.5040-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 5/5] get_maintainer: add subsystem to reviewer
 output
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com, thuth@redhat.com, pavel.dovgaluk@ispras.ru

From: Joe Perches <joe@perches.com>

Reviewer output currently does not include the subsystem
that matched.  Add it.

Miscellanea:

o Add a get_subsystem_name routine to centralize this

Cherry picked from Linux commit 2a7cb1dc82fc2a52e747b4c496c13f6575fb1790.

Signed-off-by: Joe Perches <joe@perches.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 scripts/get_maintainer.pl | 31 ++++++++++++++++---------------
 1 file changed, 16 insertions(+), 15 deletions(-)

diff --git a/scripts/get_maintainer.pl b/scripts/get_maintainer.pl
index bf210c7fa6..63257965ce 100755
--- a/scripts/get_maintainer.pl
+++ b/scripts/get_maintainer.pl
@@ -896,20 +896,29 @@ sub find_ending_index {
     return $index;
 }
 
-sub get_maintainer_role {
+sub get_subsystem_name {
     my ($index) = @_;
 
-    my $i;
     my $start = find_starting_index($index);
-    my $end = find_ending_index($index);
 
-    my $role = "unknown";
     my $subsystem = $typevalue[$start];
     if (length($subsystem) > 20) {
 	$subsystem = substr($subsystem, 0, 17);
 	$subsystem =~ s/\s*$//;
 	$subsystem = $subsystem . "...";
     }
+    return $subsystem;
+}
+
+sub get_maintainer_role {
+    my ($index) = @_;
+
+    my $i;
+    my $start = find_starting_index($index);
+    my $end = find_ending_index($index);
+
+    my $role = "unknown";
+    my $subsystem = get_subsystem_name($index);
 
     for ($i = $start + 1; $i < $end; $i++) {
 	my $tv = $typevalue[$i];
@@ -943,16 +952,7 @@ sub get_maintainer_role {
 sub get_list_role {
     my ($index) = @_;
 
-    my $i;
-    my $start = find_starting_index($index);
-    my $end = find_ending_index($index);
-
-    my $subsystem = $typevalue[$start];
-    if (length($subsystem) > 20) {
-	$subsystem = substr($subsystem, 0, 17);
-	$subsystem =~ s/\s*$//;
-	$subsystem = $subsystem . "...";
-    }
+    my $subsystem = get_subsystem_name($index);
 
     if ($subsystem eq "THE REST") {
 	$subsystem = "";
@@ -1040,7 +1040,8 @@ sub add_categories {
 		    }
 		}
 		if ($email_reviewer) {
-		    push_email_addresses($pvalue, 'reviewer');
+		    my $subsystem = get_subsystem_name($i);
+		    push_email_addresses($pvalue, "reviewer:$subsystem");
 		}
 	    } elsif ($ptype eq "T") {
 		push(@scm, $pvalue);
-- 
2.12.2
