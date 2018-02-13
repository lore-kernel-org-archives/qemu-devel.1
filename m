Received: from eggs.gnu.org ([2001:4830:134:3::10]:41518)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1elZHA-0003xU-97
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 07:01:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1elZH6-0007US-Me
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 07:01:31 -0500
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:36561)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1elZH6-0007Ty-FC
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 07:01:28 -0500
Received: by mail-wm0-x242.google.com with SMTP id f3so15601269wmc.1
	for <qemu-devel@nongnu.org>; Tue, 13 Feb 2018 04:01:28 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 13 Feb 2018 13:00:05 +0100
Message-Id: <1518523252-49106-2-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1518523252-49106-1-git-send-email-pbonzini@redhat.com>
References: <1518523252-49106-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 01/48] Revert "build-sys: silence make by
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

From: "Daniel P. Berrange" <berrange@redhat.com>

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
Message-Id: <20180123164718.12714-2-berrange@redhat.com>
Tested-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 Makefile  | 2 +-
 rules.mak | 2 --
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/Makefile b/Makefile
index 4ec7a3c..9b4291b 100644
--- a/Makefile
+++ b/Makefile
@@ -294,7 +294,7 @@ else
 DOCS=
 endif
 
-SUBDIR_MAKEFLAGS=BUILD_DIR=$(BUILD_DIR)
+SUBDIR_MAKEFLAGS=$(if $(V),,--no-print-directory --quiet) BUILD_DIR=$(BUILD_DIR)
 SUBDIR_DEVICES_MAK=$(patsubst %, %/config-devices.mak, $(TARGET_DIRS))
 SUBDIR_DEVICES_MAK_DEP=$(patsubst %, %-config-devices.mak.d, $(TARGET_DIRS))
 
diff --git a/rules.mak b/rules.mak
index 5fb4951..6e94333 100644
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
1.8.3.1
