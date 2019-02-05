Received: from eggs.gnu.org ([209.51.188.92]:36461)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gr5Ge-0002dY-QD
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 13:16:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gr5Gc-00048o-Ou
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 13:16:20 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333]:54478)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1gr5Gc-00044i-DX
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 13:16:18 -0500
Received: by mail-wm1-x333.google.com with SMTP id a62so4680165wmh.4
	for <qemu-devel@nongnu.org>; Tue, 05 Feb 2019 10:16:14 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue,  5 Feb 2019 19:14:53 +0100
Message-Id: <1549390526-24246-44-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1549390526-24246-1-git-send-email-pbonzini@redhat.com>
References: <1549390526-24246-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 43/76] Remove deprecated -enable-hax option
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

Our command line interface is really quite overcrowded, we should avoid
duplicated options that do the same thing in just a slightly different
way. "-accel hax" is shorter and more generic that "-enable-hax", so
there is really no real usage for the latter option. "-enable-hax" has
been deprecated since two releases, and nobody complained so far, so
it's time to remove this now.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Message-Id: <1544790073-23049-1-git-send-email-thuth@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 qemu-deprecated.texi |  5 -----
 qemu-options.hx      | 11 -----------
 vl.c                 |  5 -----
 3 files changed, 21 deletions(-)

diff --git a/qemu-deprecated.texi b/qemu-deprecated.texi
index 8a6174d..dcf85a9 100644
--- a/qemu-deprecated.texi
+++ b/qemu-deprecated.texi
@@ -53,11 +53,6 @@ Option @option{-virtioconsole} has been replaced by
 The @code{-clock} option is ignored since QEMU version 1.7.0. There is no
 replacement since it is not needed anymore.
 
-@subsection -enable-hax (since 3.0.0)
-
-The @option{-enable-hax} option has been replaced by @option{-accel hax}.
-Both options have been introduced in QEMU version 2.9.0.
-
 @subsection -drive file=json:@{...@{'driver':'file'@}@} (since 3.0)
 
 The 'file' driver for drives is no longer appropriate for character or host
diff --git a/qemu-options.hx b/qemu-options.hx
index 521511e..8f34dce 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -3381,17 +3381,6 @@ Enable KVM full virtualization support. This option is only available
 if KVM support is enabled when compiling.
 ETEXI
 
-DEF("enable-hax", 0, QEMU_OPTION_enable_hax, \
-    "-enable-hax     enable HAX virtualization support\n", QEMU_ARCH_I386)
-STEXI
-@item -enable-hax
-@findex -enable-hax
-Enable HAX (Hardware-based Acceleration eXecution) support. This option
-is only available if HAX support is enabled when compiling. HAX is only
-applicable to MAC and Windows platform, and thus does not conflict with
-KVM. This option is deprecated, use @option{-accel hax} instead.
-ETEXI
-
 DEF("xen-domid", HAS_ARG, QEMU_OPTION_xen_domid,
     "-xen-domid id   specify xen guest domain id\n", QEMU_ARCH_ALL)
 DEF("xen-attach", 0, QEMU_OPTION_xen_attach,
diff --git a/vl.c b/vl.c
index 9cf0fbe..804fbdb 100644
--- a/vl.c
+++ b/vl.c
@@ -3655,11 +3655,6 @@ int main(int argc, char **argv, char **envp)
                 olist = qemu_find_opts("machine");
                 qemu_opts_parse_noisily(olist, "accel=kvm", false);
                 break;
-            case QEMU_OPTION_enable_hax:
-                warn_report("Option is deprecated, use '-accel hax' instead");
-                olist = qemu_find_opts("machine");
-                qemu_opts_parse_noisily(olist, "accel=hax", false);
-                break;
             case QEMU_OPTION_M:
             case QEMU_OPTION_machine:
                 olist = qemu_find_opts("machine");
-- 
1.8.3.1
