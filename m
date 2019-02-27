Received: from eggs.gnu.org ([209.51.188.92]:38679)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gyxP5-0000bC-BF
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 06:29:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gyxAJ-0006Ik-6L
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 06:14:19 -0500
From: David Hildenbrand <david@redhat.com>
Date: Wed, 27 Feb 2019 12:14:10 +0100
Message-Id: <20190227111411.22890-2-david@redhat.com>
In-Reply-To: <20190227111411.22890-1-david@redhat.com>
References: <20190227111411.22890-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH RFC 1/2] tests/tcg: Allow targets to set the
 optimization level
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Thomas Huth <thuth@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Richard Henderson <rth@twiddle.net>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, David Hildenbrand <david@redhat.com>

We sometimes want basic optimizations, e.g. for constant propagation
into inlined functions.

Especially for inline asm with immediates;

static inline void some_instr(uint8_t imm)
{
    asm volatile("...", :: "i" (imm));
}

static void test()
{
    some_instr(1);
}

Which is impossible with -O0. So make -O0 the default but let
targets override it.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 tests/tcg/Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/tcg/Makefile b/tests/tcg/Makefile
index bf06415390..bd0bace0d5 100644
--- a/tests/tcg/Makefile
+++ b/tests/tcg/Makefile
@@ -47,7 +47,7 @@ skip-test = @printf "  SKIPPED %s on $(TARGET_NAME) because %s\n" $1 $2
 TESTS=
 
 # Start with a blank slate, the build targets get to add stuff first
-CFLAGS=
+CFLAGS=-O0
 QEMU_CFLAGS=
 LDFLAGS=
 
@@ -70,7 +70,7 @@ ifneq ($(TARGET_BASE_ARCH),$(TARGET_NAME))
 endif
 
 # Add the common build options
-CFLAGS+=-Wall -O0 -g -fno-strict-aliasing
+CFLAGS+=-Wall -g -fno-strict-aliasing
 ifeq ($(BUILD_STATIC),y)
 LDFLAGS+=-static
 endif
-- 
2.17.2
