Received: from eggs.gnu.org ([2001:4830:134:3::10]:38188)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fYdAo-0007QL-O0
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 16:05:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fYdAn-0000lF-Kr
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 16:05:46 -0400
Received: from mail-wr0-x22d.google.com ([2a00:1450:400c:c0c::22d]:44573)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1fYdAn-0000kZ-CZ
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 16:05:45 -0400
Received: by mail-wr0-x22d.google.com with SMTP id p12-v6so6676008wrn.11
	for <qemu-devel@nongnu.org>; Thu, 28 Jun 2018 13:05:45 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 28 Jun 2018 22:04:41 +0200
Message-Id: <1530216310-52873-32-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1530216310-52873-1-git-send-email-pbonzini@redhat.com>
References: <1530216310-52873-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 31/60] Deprecate the -enable-hax option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>

From: Thomas Huth <thuth@redhat.com>

We currently have got three ways of turning on the HAX accelerator:
"-machine accel=hax", "-accel hax" and "-enable-hax". That's really
confusing and overloaded. Since "-accel" is our preferred way to enable
an accelerator nowadays, and "-accel hax" is even less to type than
"-enable-hax", let's deprecate the "-enable-hax" option now.

Note: While "-enable-kvm" is available since a long time and can hardly be
removed since it is used in a lot of upper layer tools and scripts, the
"-enable-hax" option is still rather new and not very widespread yet, so
I think that it should be OK if we remove this in a couple of releases again
(we'll see whether someone complains after seeing the deprecation message -
then we could still reconsider to keep it if there a well-founded reasons).

Signed-off-by: Thomas Huth <thuth@redhat.com>
Message-Id: <1529950933-28347-1-git-send-email-thuth@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 qemu-doc.texi   | 5 +++++
 qemu-options.hx | 2 +-
 vl.c            | 1 +
 3 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/qemu-doc.texi b/qemu-doc.texi
index 16fcb47..1cb3ba4 100644
--- a/qemu-doc.texi
+++ b/qemu-doc.texi
@@ -2912,6 +2912,11 @@ Option @option{-virtioconsole} has been replaced by
 The @code{-clock} option is ignored since QEMU version 1.7.0. There is no
 replacement since it is not needed anymore.
 
+@subsection -enable-hax (since 3.0.0)
+
+The @option{-enable-hax} option has been replaced by @option{-accel hax}.
+Both options have been introduced in QEMU version 2.9.0.
+
 @section QEMU Machine Protocol (QMP) commands
 
 @subsection block-dirty-bitmap-add "autoload" parameter (since 2.12.0)
diff --git a/qemu-options.hx b/qemu-options.hx
index 2707728..3e45483 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -3421,7 +3421,7 @@ STEXI
 Enable HAX (Hardware-based Acceleration eXecution) support. This option
 is only available if HAX support is enabled when compiling. HAX is only
 applicable to MAC and Windows platform, and thus does not conflict with
-KVM.
+KVM. This option is deprecated, use @option{-accel hax} instead.
 ETEXI
 
 DEF("xen-domid", HAS_ARG, QEMU_OPTION_xen_domid,
diff --git a/vl.c b/vl.c
index d26f19b..7c9f19a 100644
--- a/vl.c
+++ b/vl.c
@@ -3581,6 +3581,7 @@ int main(int argc, char **argv, char **envp)
                 qemu_opts_parse_noisily(olist, "accel=kvm", false);
                 break;
             case QEMU_OPTION_enable_hax:
+                warn_report("Option is deprecated, use '-accel hax' instead");
                 olist = qemu_find_opts("machine");
                 qemu_opts_parse_noisily(olist, "accel=hax", false);
                 break;
-- 
1.8.3.1
