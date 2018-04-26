Received: from eggs.gnu.org ([2001:4830:134:3::10]:34736)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=647a3a28a=Ian.Jackson@citrix.com>)
	id 1fBjGU-00018X-At
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 11:56:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=647a3a28a=Ian.Jackson@citrix.com>)
	id 1fBjGR-0003jz-8C
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 11:56:58 -0400
Received: from smtp03.citrix.com ([162.221.156.55]:29416)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <prvs=647a3a28a=Ian.Jackson@citrix.com>)
	id 1fBjGQ-0003i7-UI
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 11:56:55 -0400
From: Ian Jackson <ian.jackson@eu.citrix.com>
Date: Thu, 26 Apr 2018 16:56:27 +0100
Message-ID: <1524758187-9351-17-git-send-email-ian.jackson@eu.citrix.com>
In-Reply-To: <1524758187-9351-1-git-send-email-ian.jackson@eu.citrix.com>
References: <1524758187-9351-1-git-send-email-ian.jackson@eu.citrix.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PULL 16/16] configure: do_compiler: Dump some extra
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
Cc: Ross Lagerwall <ross.lagerwall@citrix.com>, Anthony PERARD <anthony.perard@citrix.com>, Juergen Gross <jgross@suse.com>, Stefano Stabellini <sstabellini@kernel.org>, xen-devel@lists.xenproject.org, Ian Jackson <ian.jackson@eu.citrix.com>, Ian Jackson <Ian.Jackson@eu.citrix.com>, "Kent R. Spillner" <kspillner@acm.org>, Janosch Frank <frankja@linux.vnet.ibm.com>, Thomas Huth <thuth@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>

This makes it much easier to find a particular thing in config.log.

We have to use the ${BASH_LINENO[*]} syntax which is a syntax error in
other shells, so test what shell we are running and use eval.

The extra output is only printed if configure is run with bash.  On
systems where /bin/sh is not bash, it is necessary to say bash
./configure to get the extra debug info in the log.

Suggested-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Ian Jackson <Ian.Jackson@eu.citrix.com>
CC: Kent R. Spillner <kspillner@acm.org>
CC: Janosch Frank <frankja@linux.vnet.ibm.com>
CC: Thomas Huth <thuth@redhat.com>
CC: Peter Maydell <peter.maydell@linaro.org>
CC: Paolo Bonzini <pbonzini@redhat.com>
Tested-by: Thomas Huth <thuth@redhat.com>
---
 configure | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/configure b/configure
index aa35aef..f9ba9ea 100755
--- a/configure
+++ b/configure
@@ -60,6 +60,11 @@ do_compiler() {
     # is compiler binary to execute.
     local compiler="$1"
     shift
+    if test -n "$BASH_VERSION"; then eval '
+        echo >>config.log "
+funcs: ${FUNCNAME[*]}
+lines: ${BASH_LINENO[*]}"
+    '; fi
     echo $compiler "$@" >> config.log
     $compiler "$@" >> config.log 2>&1 || return $?
     # Test passed. If this is an --enable-werror build, rerun
-- 
2.1.4
