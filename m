Received: from eggs.gnu.org ([2001:4830:134:3::10]:40885)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dLSP5-0008Fg-J0
	for qemu-devel@nongnu.org; Thu, 15 Jun 2017 06:53:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dLSP1-0007Yi-Mc
	for qemu-devel@nongnu.org; Thu, 15 Jun 2017 06:53:31 -0400
Received: from mail-wr0-x241.google.com ([2a00:1450:400c:c0c::241]:36474)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1dLSP1-0007YV-GE
	for qemu-devel@nongnu.org; Thu, 15 Jun 2017 06:53:27 -0400
Received: by mail-wr0-x241.google.com with SMTP id 77so2746759wrb.3
	for <qemu-devel@nongnu.org>; Thu, 15 Jun 2017 03:53:27 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 15 Jun 2017 12:52:34 +0200
Message-Id: <1497523981-38449-15-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1497523981-38449-1-git-send-email-pbonzini@redhat.com>
References: <1497523981-38449-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 14/41] Makefile: Do not generate files if
 "configure" has not been run yet
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

When doing a "make -j10" in the vanilla QEMU source tree (without
running "configure" first), the Makefile currently generates two
files already, qemu-version.h and qemu-options.def. This should not
happen, so let's only build the generated files if config-host.mak
is available (i.e. "configure" has been run already).

Signed-off-by: Thomas Huth <thuth@redhat.com>
Message-Id: <1496926799-13040-1-git-send-email-thuth@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 Makefile | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Makefile b/Makefile
index c830d7a..32d4441 100644
--- a/Makefile
+++ b/Makefile
@@ -791,9 +791,11 @@ endif # CONFIG_WIN
 
 # Add a dependency on the generated files, so that they are always
 # rebuilt before other object files
+ifneq ($(wildcard config-host.mak),)
 ifneq ($(filter-out $(UNCHECKED_GOALS),$(MAKECMDGOALS)),$(if $(MAKECMDGOALS),,fail))
 Makefile: $(GENERATED_FILES)
 endif
+endif
 
 .SECONDARY: $(TRACE_HEADERS) $(TRACE_HEADERS:%=%-timestamp) \
 	$(TRACE_SOURCES) $(TRACE_SOURCES:%=%-timestamp) \
-- 
1.8.3.1
