Received: from eggs.gnu.org ([2001:4830:134:3::10]:59392)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=5995bc012=Ian.Jackson@citrix.com>)
	id 1euKd5-0004qB-Sz
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 11:12:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=5995bc012=Ian.Jackson@citrix.com>)
	id 1euKd1-0002yb-EG
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 11:12:23 -0500
Received: from smtp.citrix.com ([66.165.176.89]:57590)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <prvs=5995bc012=Ian.Jackson@citrix.com>)
	id 1euKd1-0002yE-5S
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 11:12:19 -0500
From: Ian Jackson <ian.jackson@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-ID: <23202.45661.318179.372531@mariner.uk.xensource.com>
Date: Fri, 9 Mar 2018 16:12:13 +0000
In-Reply-To: <20180309154431.GJ1921@perard.uk.xensource.com>
References: <1520535787-6223-1-git-send-email-ian.jackson@eu.citrix.com>
	<1520535787-6223-11-git-send-email-ian.jackson@eu.citrix.com>
	<20180309154431.GJ1921@perard.uk.xensource.com>
Subject: Re: [Qemu-devel] [PATCH 10/12] xen: Use newly added dmops for
 mapping VGA memory
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Anthony PERARD <anthony.perard@citrix.com>
Cc: qemu-devel@nongnu.org, Ross Lagerwall <ross.lagerwall@citrix.com>, Juergen Gross <jgross@suse.com>, Stefano Stabellini <sstabellini@kernel.org>, xen-devel@lists.xenproject.org

Anthony PERARD writes ("Re: [PATCH 10/12] xen: Use newly added dmops for mapping VGA memory"):
> This patch seems to remove the last users of
> xen_xc_domain_add_to_physmap(). Can it be remove from xen_common.h?
> 
> With that:
> Acked-by: Anthony PERARD <anthony.perard@citrix.com>

Have added a separate patch for that.

>From 15dedc627cad96301e4015f1f777fcab3906aba7 Mon Sep 17 00:00:00 2001
From: Ian Jackson <ian.jackson@eu.citrix.com>
Date: Fri, 27 Oct 2017 11:23:10 +0100
Subject: [PATCH 5/5] scripts/get_maintainer.pl: Print proper error message for
 missing $file

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
