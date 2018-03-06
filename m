Received: from eggs.gnu.org ([2001:4830:134:3::10]:47990)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1etCVN-0004lX-28
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 08:19:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1etCVL-0006Dg-HO
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 08:19:45 -0500
Received: from mail-wr0-x241.google.com ([2a00:1450:400c:c0c::241]:34163)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1etCVL-0006D3-AK
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 08:19:43 -0500
Received: by mail-wr0-x241.google.com with SMTP id o8so9403293wra.1
	for <qemu-devel@nongnu.org>; Tue, 06 Mar 2018 05:19:43 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue,  6 Mar 2018 14:19:03 +0100
Message-Id: <1520342370-123606-8-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1520342370-123606-1-git-send-email-pbonzini@redhat.com>
References: <1520342370-123606-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 07/34] Document --rtc-td-hack,
 --localtime and --startdate as deprecated
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

These options have been marked in a comment in qemu-options.hx as
deprecated in 2009 already (see commit 1ed2fc1fa35fadc0d6), but we
never informed the users about these deprecations. Let's catch up
on that omission now.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Message-Id: <1519138892-12836-1-git-send-email-thuth@redhat.com>
[Fix messages. - Paolo]
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 qemu-doc.texi | 16 +++++++++++-----
 vl.c          |  5 +++++
 2 files changed, 16 insertions(+), 5 deletions(-)

diff --git a/qemu-doc.texi b/qemu-doc.texi
index fb6fac5..589519a 100644
--- a/qemu-doc.texi
+++ b/qemu-doc.texi
@@ -2723,12 +2723,18 @@ filesystem test suite. Also it requires the CAP_DAC_READ_SEARCH capability,
 which is not the recommended way to run QEMU. This backend should not be
 used and it will be removed with no replacement.
 
-@subsection -no-frame (since 2.12.0)
+@subsection -rtc-td-hack (since 2.12.0)
 
-The ``-no-frame'' argument works with SDL 1.2 only.  SDL 2.0 lacks
-support for frameless windows, and the other user interfaces never
-implemented this in the first place.  So this will be removed together
-with SDL 1.2 support.
+The @code{-rtc-td-hack} option has been replaced by
+@code{-rtc driftfix=slew}.
+
+@subsection -localtime (since 2.12.0)
+
+The @code{-localtime} option has been replaced by @code{-rtc base=localtime}.
+
+@subsection -startdate (since 2.12.0)
+
+The @code{-startdate} option has been replaced by @code{-rtc base=@var{date}}.
 
 @section qemu-img command line arguments
 
diff --git a/vl.c b/vl.c
index 6e4f1a2..e648bed 100644
--- a/vl.c
+++ b/vl.c
@@ -3406,6 +3406,8 @@ int main(int argc, char **argv, char **envp)
                 break;
             case QEMU_OPTION_localtime:
                 rtc_utc = 0;
+                warn_report("This option is deprecated, "
+                            "use '-rtc base=localtime' instead.");
                 break;
             case QEMU_OPTION_vga:
                 vga_model = optarg;
@@ -3665,6 +3667,8 @@ int main(int argc, char **argv, char **envp)
                 };
 
                 qdev_prop_register_global(&slew_lost_ticks);
+                warn_report("This option is deprecated, "
+                            "use '-rtc driftfix=slew' instead.");
                 break;
             }
             case QEMU_OPTION_acpitable:
@@ -3866,6 +3870,7 @@ int main(int argc, char **argv, char **envp)
                  */
                 break;
             case QEMU_OPTION_startdate:
+                warn_report("This option is deprecated, use '-rtc base=' instead.");
                 configure_rtc_date_offset(optarg, 1);
                 break;
             case QEMU_OPTION_rtc:
-- 
1.8.3.1
