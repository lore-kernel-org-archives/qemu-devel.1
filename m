Received: from eggs.gnu.org ([2001:4830:134:3::10]:59923)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=5980b9d75=Ian.Jackson@citrix.com>)
	id 1etzW3-0007Qc-1h
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 12:39:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=5980b9d75=Ian.Jackson@citrix.com>)
	id 1etzW1-0008Mr-Lv
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 12:39:43 -0500
Received: from smtp.citrix.com ([66.165.176.89]:42122)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <prvs=5980b9d75=Ian.Jackson@citrix.com>)
	id 1etzW1-0008JW-Dx
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 12:39:41 -0500
From: Ian Jackson <ian.jackson@eu.citrix.com>
Date: Thu, 8 Mar 2018 17:39:17 +0000
Message-ID: <1520530757-4477-12-git-send-email-ian.jackson@eu.citrix.com>
In-Reply-To: <1520530757-4477-1-git-send-email-ian.jackson@eu.citrix.com>
References: <1520530757-4477-1-git-send-email-ian.jackson@eu.citrix.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH 11/11] scripts/get_maintainer.pl: Print proper
 error message for missing $file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: xen-devel@lists.xenproject.org, Ian Jackson <ian.jackson@eu.citrix.com>, Ross Lagerwall <ross.lagerwall@citrix.com>, Anthony PERARD <anthony.perard@citrix.com>, Juergen Gross <jgross@suse.com>, Stefano Stabellini <sstabellini@kernel.org>, Ian Jackson <Ian.Jackson@eu.citrix.com>, Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

If you pass scripts/get_maintainer.pl the name of a FIFO or other
exciting object (/dev/stdin, for example), it would falsely print
"file not found".  Instead: stat the object rather than using -f so
that we do not mind if the object is not a file; and print the errno
value in the error message.

Signed-off-by: Ian Jackson <Ian.Jackson@eu.citrix.com>
CC: Thomas Huth <thuth@redhat.com>
CC: Paolo Bonzini <pbonzini@redhat.com>
CC: Stefano Stabellini <sstabellini@kernel.org>
CC: Anthony PERARD <anthony.perard@citrix.com>
---
v6: New patch in this version of the series
---
 scripts/get_maintainer.pl | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/scripts/get_maintainer.pl b/scripts/get_maintainer.pl
index 07369aa..43fb5f5 100755
--- a/scripts/get_maintainer.pl
+++ b/scripts/get_maintainer.pl
@@ -381,8 +381,8 @@ foreach my $file (@ARGV) {
 	##if $file is a directory and it lacks a trailing slash, add one
 	if ((-d $file)) {
 	    $file =~ s@([^/])$@$1/@;
-	} elsif (!(-f $file)) {
-	    die "$P: file '${file}' not found\n";
+	} elsif (!(stat $file)) {
+	    die "$P: file '${file}' not found: $!\n";
 	}
     }
     if ($from_filename) {
-- 
2.1.4
