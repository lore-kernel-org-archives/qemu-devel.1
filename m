Received: from eggs.gnu.org ([2001:4830:134:3::10]:44084)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1d5qpF-00043r-RN
	for qemu-devel@nongnu.org; Wed, 03 May 2017 05:44:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1d5qpB-0006lb-3z
	for qemu-devel@nongnu.org; Wed, 03 May 2017 05:44:01 -0400
Received: from mail-wm0-x243.google.com ([2a00:1450:400c:c09::243]:33053)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1d5qpA-0006ku-SJ
	for qemu-devel@nongnu.org; Wed, 03 May 2017 05:43:57 -0400
Received: by mail-wm0-x243.google.com with SMTP id y10so11381529wmh.0
	for <qemu-devel@nongnu.org>; Wed, 03 May 2017 02:43:56 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed,  3 May 2017 11:43:48 +0200
Message-Id: <20170503094351.5040-3-pbonzini@redhat.com>
In-Reply-To: <20170503094351.5040-1-pbonzini@redhat.com>
References: <20170503094351.5040-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 2/5] get_maintainer: Teach get_maintainer.pl
 about the new "R:" tag
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

We can now designate reviewers in the MAINTAINERS file with the new
"R:" tag, so this commit teaches get_maintainers.pl to add their
email addresses.

Cherry picked from Linux commit c1c3f2c906e35bcb6e4cdf5b8e077660fead14fe,
with fixes to avoid \C as in QEMU commit ba10f729f1 ("get_maintainer.pl:
\C is deprecated", 2015-09-25).

Signed-off-by: Joe Perches <joe@perches.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 scripts/get_maintainer.pl | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/scripts/get_maintainer.pl b/scripts/get_maintainer.pl
index 8261bcb1ad..2bde32f64b 100755
--- a/scripts/get_maintainer.pl
+++ b/scripts/get_maintainer.pl
@@ -21,6 +21,7 @@ my $lk_path = "./";
 my $email = 1;
 my $email_usename = 1;
 my $email_maintainer = 1;
+my $email_reviewer = 1;
 my $email_list = 1;
 my $email_subscriber_list = 0;
 my $email_git = 0;
@@ -180,6 +181,7 @@ if (!GetOptions(
 		'remove-duplicates!' => \$email_remove_duplicates,
 		'mailmap!' => \$email_use_mailmap,
 		'm!' => \$email_maintainer,
+		'r!' => \$email_reviewer,
 		'n!' => \$email_usename,
 		'l!' => \$email_list,
 		's!' => \$email_subscriber_list,
@@ -238,7 +240,8 @@ if ($sections) {
 }
 
 if ($email &&
-    ($email_maintainer + $email_list + $email_subscriber_list +
+    ($email_maintainer + $email_reviewer +
+     $email_list + $email_subscriber_list +
      $email_git + $email_git_blame) == 0) {
     die "$P: Please select at least 1 email option\n";
 }
@@ -718,6 +721,7 @@ MAINTAINER field selection options:
     --hg-since => hg history to use (default: $email_hg_since)
     --interactive => display a menu (mostly useful if used with the --git option)
     --m => include maintainer(s) if any
+    --r => include reviewer(s) if any
     --n => include name 'Full Name <addr\@domain.tld>'
     --l => include list(s) if any
     --s => include subscriber only list(s) if any
@@ -1022,6 +1026,22 @@ sub add_categories {
 		    my $role = get_maintainer_role($i);
 		    push_email_addresses($pvalue, $role);
 		}
+	    } elsif ($ptype eq "R") {
+		my ($name, $address) = parse_email($pvalue);
+		if ($name eq "") {
+		    if ($i > 0) {
+			my $tv = $typevalue[$i - 1];
+			if ($tv =~ m/^(.):\s*(.*)/) {
+			    if ($1 eq "P") {
+				$name = $2;
+				$pvalue = format_email($name, $address, $email_usename);
+			    }
+			}
+		    }
+		}
+		if ($email_reviewer) {
+		    push_email_addresses($pvalue, 'reviewer');
+		}
 	    } elsif ($ptype eq "T") {
 		push(@scm, $pvalue);
 	    } elsif ($ptype eq "W") {
-- 
2.12.2
