Received: from eggs.gnu.org ([2001:4830:134:3::10]:36748)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fXW85-0006KG-BX
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 14:22:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fXW80-0003P5-CW
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 14:22:21 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:41930 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1fXW80-0003Oi-7S
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 14:22:16 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A1A4B2FB73
	for <qemu-devel@nongnu.org>; Mon, 25 Jun 2018 18:22:15 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
Date: Mon, 25 Jun 2018 20:22:13 +0200
Message-Id: <1529950933-28347-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH] Deprecate the -enable-hax option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>

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
---
 Let's give this a try at least :-)

 qemu-doc.texi   | 4 ++++
 qemu-options.hx | 2 +-
 vl.c            | 1 +
 3 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/qemu-doc.texi b/qemu-doc.texi
index 16fcb47..ac5ca34 100644
--- a/qemu-doc.texi
+++ b/qemu-doc.texi
@@ -2912,6 +2912,10 @@ Option @option{-virtioconsole} has been replaced by
 The @code{-clock} option is ignored since QEMU version 1.7.0. There is no
 replacement since it is not needed anymore.
 
+@subsection -enable-hax (since 3.0.0)
+
+The @option{-enable-hax} option has been replaced by @option{-accel hax}.
+
 @section QEMU Machine Protocol (QMP) commands
 
 @subsection block-dirty-bitmap-add "autoload" parameter (since 2.12.0)
diff --git a/qemu-options.hx b/qemu-options.hx
index d5b0c26..d811072 100644
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
index 5d8a9df..c13d589 100644
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
