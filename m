Received: from eggs.gnu.org ([2001:4830:134:3::10]:57096)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=5980b9d75=Ian.Jackson@citrix.com>)
	id 1eu0pT-0000rm-4e
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 14:03:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=5980b9d75=Ian.Jackson@citrix.com>)
	id 1eu0pR-0002i9-SR
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 14:03:51 -0500
Received: from smtp.citrix.com ([66.165.176.89]:61825)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <prvs=5980b9d75=Ian.Jackson@citrix.com>)
	id 1eu0pR-0002hC-NK
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 14:03:49 -0500
From: Ian Jackson <ian.jackson@eu.citrix.com>
Date: Thu, 8 Mar 2018 19:03:07 +0000
Message-ID: <1520535787-6223-13-git-send-email-ian.jackson@eu.citrix.com>
In-Reply-To: <1520535787-6223-1-git-send-email-ian.jackson@eu.citrix.com>
References: <1520535787-6223-1-git-send-email-ian.jackson@eu.citrix.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH 12/12] scripts/get_maintainer.pl: Print proper
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
Cc: Ross Lagerwall <ross.lagerwall@citrix.com>, Anthony PERARD <anthony.perard@citrix.com>, Juergen Gross <jgross@suse.com>, Stefano Stabellini <sstabellini@kernel.org>, xen-devel@lists.xenproject.org, Ian Jackson <ian.jackson@eu.citrix.com>, Ian Jackson <Ian.Jackson@eu.citrix.com>, Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

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
