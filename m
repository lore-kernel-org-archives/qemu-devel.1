Received: from eggs.gnu.org ([2001:4830:134:3::10]:44713)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1eimSI-0004TM-PM
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 14:29:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1eimSF-0004zf-TI
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 14:29:30 -0500
Received: from mail-wm0-x243.google.com ([2a00:1450:400c:c09::243]:35284)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1eimSF-0004zV-LB
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 14:29:27 -0500
Received: by mail-wm0-x243.google.com with SMTP id r78so28126347wme.0
	for <qemu-devel@nongnu.org>; Mon, 05 Feb 2018 11:29:27 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon,  5 Feb 2018 20:28:32 +0100
Message-Id: <1517858941-5538-19-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1517858941-5538-1-git-send-email-pbonzini@redhat.com>
References: <1517858941-5538-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 18/47] exynos4210: workaround UBSAN compilation
 error
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

From: Marc-André Lureau <marcandre.lureau@redhat.com>

gcc 5.4.0-6ubuntu1~16.04.5 build with UBSAN enabled error:

  CC      hw/display/exynos4210_fimd.o
/home/petmay01/linaro/qemu-for-merges/hw/display/exynos4210_fimd.c: In
function ‘fimd_get_buffer_id’:
/home/petmay01/linaro/qemu-for-merges/hw/display/exynos4210_fimd.c:1105:5:
error: case label does not reduce to an integer constant
     case FIMD_WINCON_BUF2_STAT:

Because FIMD_WINCON_BUF2_STAT case contains an integer
overflow, use U suffix to get the unsigned type.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-Id: <20180116151152.4040-2-marcandre.lureau@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/display/exynos4210_fimd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/display/exynos4210_fimd.c b/hw/display/exynos4210_fimd.c
index fd0b2be..86e37e9 100644
--- a/hw/display/exynos4210_fimd.c
+++ b/hw/display/exynos4210_fimd.c
@@ -98,7 +98,7 @@
 #define FIMD_WINCON_BUFSTATUS       ((1 << 21) | (1 << 31))
 #define FIMD_WINCON_BUF0_STAT       ((0 << 21) | (0 << 31))
 #define FIMD_WINCON_BUF1_STAT       ((1 << 21) | (0 << 31))
-#define FIMD_WINCON_BUF2_STAT       ((0 << 21) | (1 << 31))
+#define FIMD_WINCON_BUF2_STAT       ((0 << 21) | (1U << 31))
 #define FIMD_WINCON_BUFSELECT       ((1 << 20) | (1 << 30))
 #define FIMD_WINCON_BUF0_SEL        ((0 << 20) | (0 << 30))
 #define FIMD_WINCON_BUF1_SEL        ((1 << 20) | (0 << 30))
-- 
1.8.3.1
