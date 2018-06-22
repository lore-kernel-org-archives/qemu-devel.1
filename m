Received: from eggs.gnu.org ([2001:4830:134:3::10]:49965)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fWBgu-00020t-UC
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 22:20:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fWBgr-00053Q-MK
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 22:20:48 -0400
Received: from mail-qt0-x232.google.com ([2607:f8b0:400d:c0d::232]:34439)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fWBgr-00053L-H2
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 22:20:45 -0400
Received: by mail-qt0-x232.google.com with SMTP id d3-v6so4779648qto.1
	for <qemu-devel@nongnu.org>; Thu, 21 Jun 2018 19:20:45 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Thu, 21 Jun 2018 23:20:35 -0300
Message-Id: <20180622022035.18490-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RFC PATCH] Makefile: Enable synchronized parallel
 output when possible
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Peter Maydell <peter.maydell@linaro.org>, Fam Zheng <famz@redhat.com>, Eric Blake <eblake@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, "Daniel P . Berrange" <berrange@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

The '--output-sync' option is available since GNU make 4.0.

  5.4.1 Output During Parallel Execution

  When running several recipes in parallel the output from each
  recipe appears as soon as it is generated, with the result that
  messages from different recipes may be interspersed, sometimes
  even appearing on the same line. This can make reading the output
  very difficult.

  To avoid this you can use the ‘--output-sync’ (‘-O’) option. This
  option instructs make to save the output from the commands it
  invokes and print it all once the commands are completed.
  Additionally, if there are multiple recursive make invocations
  running in parallel, they will communicate so that only one of
  them is generating output at a time.

  There are four levels of granularity when synchronizing output,
  specified by giving an argument to the option (e.g., ‘-Oline’
  or ‘--output-sync=recurse’).

    none
      This is the default: all output is sent directly as it is
      generated and no synchronization is performed.

    line
      Output from each individual line of the recipe is grouped
      and printed as soon as that line is complete. If a recipe
      consists of multiple lines, they may be interspersed with
      lines from other recipes.

    target
      Output from the entire recipe for each target is grouped and
      printed once the target is complete. This is the default if
      the --output-sync or -O option is given with no argument.

    recurse
      Output from each recursive invocation of make is grouped and
      printed once the recursive invocation is complete.

  Regardless of the mode chosen, the total build time will be the
  same. The only difference is in how the output appears.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
Maybe 'line' is better for workstation and 'target/recurse' for
unattended builds.

doc: https://www.gnu.org/software/make/manual/html_node/Parallel-Output.html
---
 Makefile | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Makefile b/Makefile
index e46f2b625a..e94c687afe 100644
--- a/Makefile
+++ b/Makefile
@@ -367,6 +367,10 @@ DOCS=
 endif
 
 SUBDIR_MAKEFLAGS=$(if $(V),,--no-print-directory --quiet) BUILD_DIR=$(BUILD_DIR)
+ifeq ($(shell test $(firstword $(subst ., ,$(MAKE_VERSION))) -ge 4; echo $$?),0)
+SUBDIR_MAKEFLAGS+=--output-sync=target
+endif
+
 SUBDIR_DEVICES_MAK=$(patsubst %, %/config-devices.mak, $(TARGET_LIST))
 SUBDIR_DEVICES_MAK_DEP=$(patsubst %, %-config-devices.mak.d, $(TARGET_LIST))
 
-- 
2.18.0.rc2
