Received: from eggs.gnu.org ([2001:4830:134:3::10]:48088)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sstabellini@kernel.org>) id 1czBke-0004nK-Iy
	for qemu-devel@nongnu.org; Fri, 14 Apr 2017 20:39:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sstabellini@kernel.org>) id 1czBkb-000651-DY
	for qemu-devel@nongnu.org; Fri, 14 Apr 2017 20:39:44 -0400
Received: from mail.kernel.org ([198.145.29.136]:44384)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sstabellini@kernel.org>)
	id 1czBkb-00064W-7c
	for qemu-devel@nongnu.org; Fri, 14 Apr 2017 20:39:41 -0400
Date: Fri, 14 Apr 2017 17:39:35 -0700 (PDT)
From: Stefano Stabellini <sstabellini@kernel.org>
In-Reply-To: <alpine.DEB.2.10.1704141429110.23677@sstabellini-ThinkPad-X260>
Message-ID: <alpine.DEB.2.10.1704141734161.23677@sstabellini-ThinkPad-X260>
References: <alpine.DEB.2.10.1704141429110.23677@sstabellini-ThinkPad-X260>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Subject: Re: [Qemu-devel] QEMU build breakage on ARM against Xen 4.9 caused
 by libxendevicemodel
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefano Stabellini <sstabellini@kernel.org>
Cc: paul.durrant@citrix.com, qemu-devel@nongnu.org, anthony.perard@citrix.com, wei.liu2@citrix.com, jgross@suse.com, julien.grall@arm.com, xen-devel@lists.xenproject.org

On Fri, 14 Apr 2017, Stefano Stabellini wrote:
> Hi Paul,
> 
> The following commit in my qemu "next" branch breaks the build on arm
> and arm64:
> 
> commit 670271647ad15e9d937ced7a72c892349c709216
> Author: Paul Durrant <paul.durrant@citrix.com>
> Date:   Tue Mar 7 10:55:34 2017 +0000
> 
>     xen: use libxendevicemodel when available
> 
> See the appended build log. Sorry for not realizing it sooner.

As I imagined, this bug is easy to solve. It is reproducible on x86 too,
if you pass -DXC_WANT_COMPAT_DEVICEMODEL_API=1 to configure and
forcefully disable Xen 4.9 detection in the configure script.

If QEMU detects xen_ctrl_version = 480, the build will fail against Xen
4.9, even when -DXC_WANT_COMPAT_DEVICEMODEL_API=1 is specified.

The appended patch solves the problem. However, Xen 4.9 detection and
compilation remain broken.

---

diff --git a/include/hw/xen/xen_common.h b/include/hw/xen/xen_common.h
index 274accc..b1f5f53 100644
--- a/include/hw/xen/xen_common.h
+++ b/include/hw/xen/xen_common.h
@@ -9,7 +9,6 @@
 #undef XC_WANT_COMPAT_EVTCHN_API
 #undef XC_WANT_COMPAT_GNTTAB_API
 #undef XC_WANT_COMPAT_MAP_FOREIGN_API
-#undef XC_WANT_COMPAT_DEVICEMODEL_API

 #include <xenctrl.h>
 #include <xenstore.h>
@@ -154,6 +153,7 @@ static inline int xendevicemodel_set_mem_type(

 #else /* CONFIG_XEN_CTRL_INTERFACE_VERSION >= 490 */

+#undef XC_WANT_COMPAT_DEVICEMODEL_API
 #include <xendevicemodel.h>

 #endif
