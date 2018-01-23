Received: from eggs.gnu.org ([2001:4830:134:3::10]:54122)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1ee1jR-0008P5-3Y
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 11:47:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1ee1jP-0002a0-Aa
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 11:47:33 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57418)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1ee1jP-0002Zb-54
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 11:47:31 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 4EC88C0578FB
	for <qemu-devel@nongnu.org>; Tue, 23 Jan 2018 16:47:30 +0000 (UTC)
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Tue, 23 Jan 2018 16:47:17 +0000
Message-Id: <20180123164718.12714-2-berrange@redhat.com>
In-Reply-To: <20180123164718.12714-1-berrange@redhat.com>
References: <20180123164718.12714-1-berrange@redhat.com>
Subject: [Qemu-devel] [PATCH v1 1/2] Revert "build-sys: silence make by
 default or V=0"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>

This reverts commit 42a77f1ce4934b243df003f95bda88530631387a.

The primary intention of this change was to silence messages
like

  make[1]: '/home/berrange/src/virt/qemu/capstone/libcapstone.a' is up to date.

which we get when calling make recursively with explicit
targets.

The problem is that this change affected every make target,
not merely the targets that triggered these "is up to date"
messages. As a result any targets that were not invoking
commands via "$(call quiet-command ...)" suddenly become
silent. This is particularly bad for "make install" which
now appears todo nothing.

Rather than go through every make rule and try to identify
places where we now need to explicitly print a message to
show work taking place, just revert the change.

To address the original problem of silencing "is up to date"
messages, we simply add --quiet to the SUBDIR_MAKEVARS
variable, so it only affects us on recursive make calls.

Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
---
 Makefile  | 2 +-
 rules.mak | 2 --
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/Makefile b/Makefile
index f26ef1b1df..c263190b8d 100644
--- a/Makefile
+++ b/Makefile
@@ -280,7 +280,7 @@ else
 DOCS=
 endif
 
-SUBDIR_MAKEFLAGS=BUILD_DIR=$(BUILD_DIR)
+SUBDIR_MAKEFLAGS=$(if $(V),,--no-print-directory --quiet) BUILD_DIR=$(BUILD_DIR)
 SUBDIR_DEVICES_MAK=$(patsubst %, %/config-devices.mak, $(TARGET_DIRS))
 SUBDIR_DEVICES_MAK_DEP=$(patsubst %, %-config-devices.mak.d, $(TARGET_DIRS))
 
diff --git a/rules.mak b/rules.mak
index 5fb4951561..6e943335f3 100644
--- a/rules.mak
+++ b/rules.mak
@@ -131,8 +131,6 @@ modules:
 # If called with only a single argument, will print nothing in quiet mode.
 quiet-command = $(if $(V),$1,$(if $(2),@printf "  %-7s %s\n" $2 $3 && $1, @$1))
 
-MAKEFLAGS += $(if $(V),,--no-print-directory --quiet)
-
 # cc-option
 # Usage: CFLAGS+=$(call cc-option, -falign-functions=0, -malign-functions=0)
 
-- 
2.14.3
