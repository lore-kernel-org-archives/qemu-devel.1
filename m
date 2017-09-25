Received: from eggs.gnu.org ([2001:4830:134:3::10]:56576)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=434883a06=anthony.perard@citrix.com>)
	id 1dwUty-0004Rt-2U
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 11:02:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=434883a06=anthony.perard@citrix.com>)
	id 1dwUtu-0006SD-6n
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 11:02:30 -0400
Received: from smtp02.citrix.com ([66.165.176.63]:23286)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <prvs=434883a06=anthony.perard@citrix.com>)
	id 1dwUtu-0006Rd-0L
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 11:02:26 -0400
Date: Mon, 25 Sep 2017 16:01:48 +0100
From: Anthony PERARD <anthony.perard@citrix.com>
Message-ID: <20170925150148.GG1859@perard.uk.xensource.com>
References: <1505498999-17427-1-git-send-email-ian.jackson@eu.citrix.com>
	<1505498999-17427-2-git-send-email-ian.jackson@eu.citrix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1505498999-17427-2-git-send-email-ian.jackson@eu.citrix.com>
Subject: Re: [Qemu-devel] [PATCH RFC 1/6] xen: link against xentoolcore
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ian Jackson <ian.jackson@eu.citrix.com>
Cc: qemu-devel@nongnu.org, Juergen Gross <jgross@suse.com>, Stefano Stabellini <sstabellini@kernel.org>, xen-devel@nongnu.org

On Fri, Sep 15, 2017 at 07:09:54PM +0100, Ian Jackson wrote:
> Signed-off-by: Ian Jackson <Ian.Jackson@eu.citrix.com>
> ---
>  configure | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 

Here is a patch that I think will work, if libxentoolcore is release in
Xen 4.10.

diff --git a/configure b/configure
index 133a5757ef..a22ff71294 100755
--- a/configure
+++ b/configure
@@ -2071,7 +2071,7 @@ if test "$xen" != "no" ; then
       $($pkg_config --modversion xencontrol | sed 's/\./ /g') )"
     xen=yes
     xen_pc="xencontrol xenstore xenguest xenforeignmemory xengnttab"
-    xen_pc="$xen_pc xenevtchn xendevicemodel"
+    xen_pc="$xen_pc xenevtchn xendevicemodel xentoolcore"
     QEMU_CFLAGS="$QEMU_CFLAGS $($pkg_config --cflags $xen_pc)"
     libs_softmmu="$($pkg_config --libs $xen_pc) $libs_softmmu"
     LDFLAGS="$($pkg_config --libs $xen_pc) $LDFLAGS"
@@ -2103,18 +2103,20 @@ EOF
         cat > $TMPC <<EOF &&
 #undef XC_WANT_COMPAT_MAP_FOREIGN_API
 #include <xenforeignmemory.h>
+#include <xentoolcore.h>
 int main(void) {
   xenforeignmemory_handle *xfmem;
 
   xfmem = xenforeignmemory_open(0, 0);
   xenforeignmemory_map2(xfmem, 0, 0, 0, 0, 0, 0, 0);
+  xentoolcore_restrict_all(0);
 
   return 0;
 }
 EOF
-        compile_prog "" "$xen_libs -lxendevicemodel $xen_stable_libs"
+        compile_prog "" "$xen_libs -lxendevicemodel $xen_stable_libs -lxentoolcore"
       then
-      xen_stable_libs="-lxendevicemodel $xen_stable_libs"
+      xen_stable_libs="-lxendevicemodel $xen_stable_libs -lxentoolcore"
       xen_ctrl_version=41000
       xen=yes
     elif


-- 
Anthony PERARD
