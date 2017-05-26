Received: from eggs.gnu.org ([2001:4830:134:3::10]:40445)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dEMbF-0000Td-U4
	for qemu-devel@nongnu.org; Fri, 26 May 2017 17:16:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dEMbF-0008Hx-0n
	for qemu-devel@nongnu.org; Fri, 26 May 2017 17:16:45 -0400
Received: from mail-qt0-x243.google.com ([2607:f8b0:400d:c0d::243]:34649)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dEMbE-0008Hp-SO
	for qemu-devel@nongnu.org; Fri, 26 May 2017 17:16:44 -0400
Received: by mail-qt0-x243.google.com with SMTP id l39so2852177qtb.1
	for <qemu-devel@nongnu.org>; Fri, 26 May 2017 14:16:44 -0700 (PDT)
Received: from bigtime.twiddle.net.com
	([2602:47:d954:1500:5e51:4fff:fe40:9c64])
	by smtp.gmail.com with ESMTPSA id
	u19sm1262380qtc.64.2017.05.26.14.16.43 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 26 May 2017 14:16:43 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Fri, 26 May 2017 14:16:14 -0700
Message-Id: <20170526211638.32301-3-rth@twiddle.net>
In-Reply-To: <20170526211638.32301-1-rth@twiddle.net>
References: <20170526211638.32301-1-rth@twiddle.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v7 02/26] tcg/sparc: Use the proper compilation
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

We have required a v9 cpu since 9b9c37c36439ee0452632253dac7a31897f27f70.
However, the flags we were using did not reliably enable v8plus, which
meant that the compiler didn't know it could inline 64-bit atomics.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 configure | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/configure b/configure
index 1a5ee4b..376c48e 100755
--- a/configure
+++ b/configure
@@ -1212,12 +1212,12 @@ case "$cpu" in
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
