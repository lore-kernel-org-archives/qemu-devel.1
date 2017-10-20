Received: from eggs.gnu.org ([2001:4830:134:3::10]:36318)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=4594c9e72=Ian.Jackson@citrix.com>)
	id 1e5XVc-0005A0-8A
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 09:38:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=4594c9e72=Ian.Jackson@citrix.com>)
	id 1e5XVY-0002ty-Iv
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 09:38:44 -0400
Received: from smtp02.citrix.com ([66.165.176.63]:19492)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <prvs=4594c9e72=Ian.Jackson@citrix.com>)
	id 1e5XVY-0002qS-Bb
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 09:38:40 -0400
From: Ian Jackson <ian.jackson@eu.citrix.com>
Date: Fri, 20 Oct 2017 14:38:22 +0100
Message-ID: <1508506702-17704-8-git-send-email-ian.jackson@eu.citrix.com>
In-Reply-To: <1508506702-17704-1-git-send-email-ian.jackson@eu.citrix.com>
References: <23017.64539.31230.43449@mariner.uk.xensource.com>
	<1508506702-17704-1-git-send-email-ian.jackson@eu.citrix.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v5.1 8/8] configure: do_compiler: Dump some
 extra info under bash
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Ross Lagerwall <ross.lagerwall@citrix.com>, Anthony PERARD <anthony.perard@citrix.com>, Juergen Gross <jgross@suse.com>, Stefano Stabellini <sstabellini@kernel.org>, xen-devel@lists.xenproject.org, Ian Jackson <ian.jackson@eu.citrix.com>, Ian Jackson <Ian.Jackson@eu.citrix.com>

This makes it much easier to find a particular thing in config.log.

The information may be lacking in other shells, resulting in harmless
empty output.  (This is why we don't use the proper ${FUNCNAME[*]}
array syntax - other shells will choke on that.)

The extra output is only printed if configure is run with bash.  The
something), it is necessary to say   bash ./configure  to get the extra
debug info in the log.

Signed-off-by: Ian Jackson <Ian.Jackson@eu.citrix.com>
---
v4: No longer tag this patch RFC.
---
 configure | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/configure b/configure
index 6f691df..21a2b15 100755
--- a/configure
+++ b/configure
@@ -60,6 +60,10 @@ do_compiler() {
     # is compiler binary to execute.
     local compiler="$1"
     shift
+    echo >>config.log "
+funcs: ${FUNCNAME}
+lines: ${BASH_LINENO}
+files: ${BASH_SOURCE}"
     echo $compiler "$@" >> config.log
     $compiler "$@" >> config.log 2>&1 || return $?
     # Test passed. If this is an --enable-werror build, rerun
-- 
2.1.4
