Received: from eggs.gnu.org ([2001:4830:134:3::10]:56380)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dHvFC-00040i-QZ
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 12:52:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dHvFB-0003aj-OI
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 12:52:42 -0400
Received: from mail-qt0-x244.google.com ([2607:f8b0:400d:c0d::244]:36086)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dHvFB-0003aY-JB
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 12:52:41 -0400
Received: by mail-qt0-x244.google.com with SMTP id s33so9905731qtg.3
	for <qemu-devel@nongnu.org>; Mon, 05 Jun 2017 09:52:41 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Mon,  5 Jun 2017 09:52:09 -0700
Message-Id: <20170605165233.4135-3-rth@twiddle.net>
In-Reply-To: <20170605165233.4135-1-rth@twiddle.net>
References: <20170605165233.4135-1-rth@twiddle.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 02/26] tcg/sparc: Use the proper compilation
 flags for 32-bit
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org

We have required a v9 cpu since 9b9c37c36439ee0452632253dac7a31897f27f70.
However, the flags we were using did not reliably enable v8plus, which
meant that the compiler didn't know it could inline 64-bit atomics.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 configure | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/configure b/configure
index fbb6a93..13e040d 100755
--- a/configure
+++ b/configure
@@ -1213,12 +1213,12 @@ case "$cpu" in
            LDFLAGS="-m64 $LDFLAGS"
            ;;
     sparc)
-           LDFLAGS="-m32 $LDFLAGS"
-           CPU_CFLAGS="-m32 -mcpu=ultrasparc"
+           CPU_CFLAGS="-m32 -mv8plus -mcpu=ultrasparc"
+           LDFLAGS="-m32 -mv8plus $LDFLAGS"
            ;;
     sparc64)
-           LDFLAGS="-m64 $LDFLAGS"
            CPU_CFLAGS="-m64 -mcpu=ultrasparc"
+           LDFLAGS="-m64 $LDFLAGS"
            ;;
     s390)
            CPU_CFLAGS="-m31"
-- 
2.9.4
