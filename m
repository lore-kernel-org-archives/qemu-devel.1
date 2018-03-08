Received: from eggs.gnu.org ([2001:4830:134:3::10]:59913)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=5980b9d75=Ian.Jackson@citrix.com>)
	id 1etzW2-0007QZ-Rk
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 12:39:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=5980b9d75=Ian.Jackson@citrix.com>)
	id 1etzW1-0008Mm-Ki
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 12:39:42 -0500
Received: from smtp.citrix.com ([66.165.176.89]:31749)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <prvs=5980b9d75=Ian.Jackson@citrix.com>)
	id 1etzW1-0008KY-DL
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 12:39:41 -0500
From: Ian Jackson <ian.jackson@eu.citrix.com>
Date: Thu, 8 Mar 2018 17:39:14 +0000
Message-ID: <1520530757-4477-9-git-send-email-ian.jackson@eu.citrix.com>
In-Reply-To: <1520530757-4477-1-git-send-email-ian.jackson@eu.citrix.com>
References: <1520530757-4477-1-git-send-email-ian.jackson@eu.citrix.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH 08/11] configure: do_compiler: Dump some extra
 info under bash
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: xen-devel@lists.xenproject.org, Ian Jackson <ian.jackson@eu.citrix.com>, Ross Lagerwall <ross.lagerwall@citrix.com>, Anthony PERARD <anthony.perard@citrix.com>, Juergen Gross <jgross@suse.com>, Stefano Stabellini <sstabellini@kernel.org>, Ian Jackson <Ian.Jackson@eu.citrix.com>, "Kent R. Spillner" <kspillner@acm.org>, Janosch Frank <frankja@linux.vnet.ibm.com>, Thomas Huth <thuth@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>

This makes it much easier to find a particular thing in config.log.

The information may be lacking in other shells, resulting in harmless
empty output.  (This is why we don't use the proper ${FUNCNAME[*]}
array syntax - other shells will choke on that.)

The extra output is only printed if configure is run with bash.  On
systems where /bin/sh is not bash, it is necessary to say bash
./configure to get the extra debug info in the log.

Signed-off-by: Ian Jackson <Ian.Jackson@eu.citrix.com>
CC: Kent R. Spillner <kspillner@acm.org>
CC: Janosch Frank <frankja@linux.vnet.ibm.com>
CC: Thomas Huth <thuth@redhat.com>
CC: Peter Maydell <peter.maydell@linaro.org>
CC: Paolo Bonzini <pbonzini@redhat.com>
---
v6: Fix commit message wording.
v4: No longer tag this patch RFC.
---
 configure | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/configure b/configure
index 0a8059f..841c146 100755
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
