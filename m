Received: from eggs.gnu.org ([2001:4830:134:3::10]:57098)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1f0SIw-0006UJ-E0
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 09:36:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1f0SIr-0006rJ-Ey
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 09:36:54 -0400
Received: from mail-wr0-x22f.google.com ([2a00:1450:400c:c0c::22f]:46543)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1f0SIr-0006r0-81
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 09:36:49 -0400
Received: by mail-wr0-x22f.google.com with SMTP id d1so6939212wrj.13
	for <qemu-devel@nongnu.org>; Mon, 26 Mar 2018 06:36:49 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 26 Mar 2018 15:36:28 +0200
Message-Id: <1522071403-52486-2-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1522071403-52486-1-git-send-email-pbonzini@redhat.com>
References: <1522071403-52486-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 01/16] scripts/get_maintainer.pl: Print proper
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
Cc: Ian Jackson <ian.jackson@eu.citrix.com>, Ian Jackson <Ian.Jackson@eu.citrix.com>, Thomas Huth <thuth@redhat.com>, Stefano Stabellini <sstabellini@kernel.org>, Anthony PERARD <anthony.perard@citrix.com>

From: Ian Jackson <ian.jackson@eu.citrix.com>

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
Message-Id: <1520535787-6223-13-git-send-email-ian.jackson@eu.citrix.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Ian Jackson <ian.jackson@eu.citrix.com>
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
1.8.3.1
