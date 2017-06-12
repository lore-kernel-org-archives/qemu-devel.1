Received: from eggs.gnu.org ([2001:4830:134:3::10]:42357)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dKRQ9-0002Be-UQ
	for qemu-devel@nongnu.org; Mon, 12 Jun 2017 11:38:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dKRQ7-0007Kv-Qk
	for qemu-devel@nongnu.org; Mon, 12 Jun 2017 11:38:25 -0400
Received: from mail-wr0-x243.google.com ([2a00:1450:400c:c0c::243]:36186)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1dKRQ7-0007KY-Jr
	for qemu-devel@nongnu.org; Mon, 12 Jun 2017 11:38:23 -0400
Received: by mail-wr0-x243.google.com with SMTP id e23so22871780wre.3
	for <qemu-devel@nongnu.org>; Mon, 12 Jun 2017 08:38:23 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 12 Jun 2017 17:38:16 +0200
Message-Id: <20170612153816.15266-3-pbonzini@redhat.com>
In-Reply-To: <20170612153816.15266-1-pbonzini@redhat.com>
References: <20170612153816.15266-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 2/2] qemu-doc: include version number
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, thuth@redhat.com

Note that TEXI2POD doesn't support @set/@clear, so pass the value
manually on the command line.

This patch partially undoes commit bd7f974796 ("qapi: Clean up build of
generated documentation", 2017-03-16).

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 Makefile      | 17 +++++------------
 qemu-doc.texi |  5 +++--
 2 files changed, 8 insertions(+), 14 deletions(-)

diff --git a/Makefile b/Makefile
index c27389af28..b017e3abf8 100644
--- a/Makefile
+++ b/Makefile
@@ -669,33 +669,26 @@ ui/console-gl.o: $(SRC_PATH)/ui/console-gl.c \
 MAKEINFO=makeinfo
 MAKEINFOINCLUDES= -I docs -I $(<D) -I $(@D)
 MAKEINFOFLAGS=--no-split --number-sections $(MAKEINFOINCLUDES)
-TEXI2PODFLAGS=$(MAKEINFOINCLUDES)
+TEXI2PODFLAGS=$(MAKEINFOINCLUDES) "-DVERSION=$(VERSION)"
 TEXI2PDFFLAGS=$(if $(V),,--quiet) -I $(SRC_PATH) $(MAKEINFOINCLUDES)
 
 docs/version.texi: $(SRC_PATH)/VERSION
 	$(call quiet-command,echo "@set VERSION $(VERSION)" > $@,"GEN","$@")
 
-%.html: %.texi
+%.html: %.texi docs/version.texi
 	$(call quiet-command,LC_ALL=C $(MAKEINFO) $(MAKEINFOFLAGS) --no-headers \
 	--html $< -o $@,"GEN","$@")
 
-%.info: %.texi
+%.info: %.texi docs/version.texi
 	$(call quiet-command,$(MAKEINFO) $(MAKEINFOFLAGS) $< -o $@,"GEN","$@")
 
-%.txt: %.texi
+%.txt: %.texi docs/version.texi
 	$(call quiet-command,LC_ALL=C $(MAKEINFO) $(MAKEINFOFLAGS) --no-headers \
 	--plaintext $< -o $@,"GEN","$@")
 
-%.pdf: %.texi
+%.pdf: %.texi docs/version.texi
 	$(call quiet-command,texi2pdf $(TEXI2PDFFLAGS) $< -o $@,"GEN","$@")
 
-docs/interop/qemu-ga-ref.html docs/interop/qemu-ga-ref.info \
-    docs/interop/qemu-ga-ref.txt docs/interop/qemu-ga-ref.pdf \
-    docs/interop/qemu-ga-ref.7.pod: docs/version.texi
-docs/interop/qemu-qmp-ref.html docs/interop/qemu-qmp-ref.info \
-    docs/interop/qemu-qmp-ref.txt docs/interop/qemu-qmp-ref.pdf \
-    docs/interop/qemu-qmp-ref.pod: docs/version.texi
-
 qemu-options.texi: $(SRC_PATH)/qemu-options.hx $(SRC_PATH)/scripts/hxtool
 	$(call quiet-command,sh $(SRC_PATH)/scripts/hxtool -t < $< > $@,"GEN","$@")
 
diff --git a/qemu-doc.texi b/qemu-doc.texi
index 965ba5929e..21079fd675 100644
--- a/qemu-doc.texi
+++ b/qemu-doc.texi
@@ -1,11 +1,12 @@
 \input texinfo @c -*- texinfo -*-
 @c %**start of header
 @setfilename qemu-doc.info
+@include version.texi
 
 @documentlanguage en
 @documentencoding UTF-8
 
-@settitle QEMU Emulator User Documentation
+@settitle QEMU version @value{VERSION} User Documentation
 @exampleindent 0
 @paragraphindent 0
 @c %**end of header
@@ -19,7 +20,7 @@
 @iftex
 @titlepage
 @sp 7
-@center @titlefont{QEMU Emulator}
+@center @titlefont{QEMU version @value{VERSION}}
 @sp 1
 @center @titlefont{User Documentation}
 @sp 3
-- 
2.13.0
