Received: from eggs.gnu.org ([2001:4830:134:3::10]:59416)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1d5Uhn-0005mp-1P
	for qemu-devel@nongnu.org; Tue, 02 May 2017 06:06:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1d5Uhh-0007jT-Vy
	for qemu-devel@nongnu.org; Tue, 02 May 2017 06:06:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33562)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1d5Uhh-0007ik-QZ
	for qemu-devel@nongnu.org; Tue, 02 May 2017 06:06:45 -0400
From: Thomas Huth <thuth@redhat.com>
Date: Tue,  2 May 2017 12:06:40 +0200
Message-Id: <1493719600-30853-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH] Deprecate '-enable-kvm' and '-enable-hax' in
 favour of '-accel'
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Vincent Palatin <vpalatin@chromium.org>

The '-enable-...' option do not make too much sense: They do not
allow additional parameters, using '-accel xxx' is shorter than
'-enable-xxx' and we're also inconsistent here, since there is
no '-enable-xen' option available. So let's try to convince the
users to use '-accel xxx' instead.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 qemu-options.hx | 5 +++--
 vl.c            | 4 ++++
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/qemu-options.hx b/qemu-options.hx
index c7b1d2d..eb33286 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -3367,7 +3367,8 @@ STEXI
 @item -enable-kvm
 @findex -enable-kvm
 Enable KVM full virtualization support. This option is only available
-if KVM support is enabled when compiling.
+if KVM support is enabled when compiling. Note: This option is deprecated,
+please use @code{-accel kvm} instead.
 ETEXI
 
 DEF("enable-hax", 0, QEMU_OPTION_enable_hax, \
@@ -3378,7 +3379,7 @@ STEXI
 Enable HAX (Hardware-based Acceleration eXecution) support. This option
 is only available if HAX support is enabled when compiling. HAX is only
 applicable to MAC and Windows platform, and thus does not conflict with
-KVM.
+KVM. Note: This option is deprecated, please use @code{-accel hax} instead.
 ETEXI
 
 DEF("xen-domid", HAS_ARG, QEMU_OPTION_xen_domid,
diff --git a/vl.c b/vl.c
index d5e88fb..d5ec87e 100644
--- a/vl.c
+++ b/vl.c
@@ -3690,10 +3690,14 @@ int main(int argc, char **argv, char **envp)
                 }
                 break;
             case QEMU_OPTION_enable_kvm:
+                error_report("'-enable-kvm' is depreacted, please use "
+                             "'-accel kvm' instead");
                 olist = qemu_find_opts("machine");
                 qemu_opts_parse_noisily(olist, "accel=kvm", false);
                 break;
             case QEMU_OPTION_enable_hax:
+                error_report("'-enable-hax' is depreacted, please use "
+                             "'-accel hax' instead");
                 olist = qemu_find_opts("machine");
                 qemu_opts_parse_noisily(olist, "accel=hax", false);
                 break;
-- 
1.8.3.1
