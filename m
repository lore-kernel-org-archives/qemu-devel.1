Received: from eggs.gnu.org ([2001:4830:134:3::10]:40192)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dL8rg-0005rz-LU
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 10:01:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dL8ra-0008Fi-KY
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 10:01:44 -0400
Received: from mail-wr0-x22d.google.com ([2a00:1450:400c:c0c::22d]:35522)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1dL8ra-0008FK-El
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 10:01:38 -0400
Received: by mail-wr0-x22d.google.com with SMTP id q97so1982885wrb.2
	for <qemu-devel@nongnu.org>; Wed, 14 Jun 2017 07:01:38 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Wed, 14 Jun 2017 15:02:07 +0100
Message-Id: <20170614140209.29847-2-alex.bennee@linaro.org>
In-Reply-To: <20170614140209.29847-1-alex.bennee@linaro.org>
References: <20170614140209.29847-1-alex.bennee@linaro.org>
Subject: [Qemu-devel] [PATCH v1 1/3] vl: Fix broken thread=xxx option of the
 --accel parameter
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org, pbonzini@redhat.com, rth@twiddle.net, cota@braap.org
Cc: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>

From: Thomas Huth <thuth@redhat.com>

Commit bde4d9205 ("Fix the -accel parameter and the documentation for
'hax'") introduced a regression by adding a new local accel_opts
variable which shadows the variable with the same name that is
declared at the beginning of the main() scope. This causes the
qemu_tcg_configure() call later to be always called with NULL, so
that the thread=xxx option gets ignored. Fix it by removing the
local accel_opts variable and use "opts" instead, which is meant
for storing temporary QemuOpts values.
And while we're at it, also change the exit(1) here to exit(0)
since asking for help is not an error.

Fixes: bde4d9205ee9def98852ff6054cdef4efd74e1f8
Reported-by: Markus Armbruster <armbru@redhat.com>
Reported-by: Emilio G. Cota <cota@braap.org>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 vl.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/vl.c b/vl.c
index 32db19e3b9..59fea15488 100644
--- a/vl.c
+++ b/vl.c
@@ -3757,21 +3757,18 @@ int main(int argc, char **argv, char **envp)
                 qdev_prop_register_global(&kvm_pit_lost_tick_policy);
                 break;
             }
-            case QEMU_OPTION_accel: {
-                QemuOpts *accel_opts;
-
+            case QEMU_OPTION_accel:
                 accel_opts = qemu_opts_parse_noisily(qemu_find_opts("accel"),
                                                      optarg, true);
                 optarg = qemu_opt_get(accel_opts, "accel");
                 if (!optarg || is_help_option(optarg)) {
                     error_printf("Possible accelerators: kvm, xen, hax, tcg\n");
-                    exit(1);
+                    exit(0);
                 }
-                accel_opts = qemu_opts_create(qemu_find_opts("machine"), NULL,
-                                              false, &error_abort);
-                qemu_opt_set(accel_opts, "accel", optarg, &error_abort);
+                opts = qemu_opts_create(qemu_find_opts("machine"), NULL,
+                                        false, &error_abort);
+                qemu_opt_set(opts, "accel", optarg, &error_abort);
                 break;
-            }
             case QEMU_OPTION_usb:
                 olist = qemu_find_opts("machine");
                 qemu_opts_parse_noisily(olist, "usb=on", false);
-- 
2.13.0
