Received: from eggs.gnu.org ([2001:4830:134:3::10]:45151)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1ebuZG-00047n-Pn
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 15:44:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1ebuZE-00082K-8t
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 15:44:18 -0500
Received: from mail-pf0-x244.google.com ([2607:f8b0:400e:c00::244]:39413)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alistair23@gmail.com>)
	id 1ebuZE-000824-2T
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 15:44:16 -0500
Received: by mail-pf0-x244.google.com with SMTP id e11so12351079pff.6
	for <qemu-devel@nongnu.org>; Wed, 17 Jan 2018 12:44:15 -0800 (PST)
Sender: Alistair Francis <alistair23@gmail.com>
From: Alistair Francis <alistair.francis@xilinx.com>
Date: Wed, 17 Jan 2018 12:39:50 -0800
Message-Id: <bd66250ff262528199614f778a8323ced130a4db.1516221466.git.alistair.francis@xilinx.com>
Subject: [Qemu-devel] [PATCH v1 1/1] linux-user: Fix webkitgtk hangs on
 32-bit x86 target
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, rth@twiddle.net, richard.henderson@linaro.org
Cc: peter.maydell@linaro.org, alistair.francis@xilinx.com, alistair23@gmail.com, riku.voipio@iki.fi

Since commit "linux-user: Tidy and enforce reserved_va initialization"
(18e80c55bb6ec17c05ec0ba717ec83933c2bfc07) the Yocto webkitgtk build
hangs when cross compiling for 32-bit x86 on a 64-bit x86 machine using
musl.

To fix the issue reduce the MAX_RESERVED_VA macro to be a closer match
to what it was before the problematic commit.

Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>
---

 linux-user/main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/linux-user/main.c b/linux-user/main.c
index 450eb3ce65..c7cc0a184e 100644
--- a/linux-user/main.c
+++ b/linux-user/main.c
@@ -77,7 +77,7 @@ do {                                                                    \
       (TARGET_LONG_BITS == 32 || defined(TARGET_ABI32))
 /* There are a number of places where we assign reserved_va to a variable
    of type abi_ulong and expect it to fit.  Avoid the last page.  */
-#   define MAX_RESERVED_VA  (0xfffffffful & TARGET_PAGE_MASK)
+#   define MAX_RESERVED_VA  (0x7ffffffful & TARGET_PAGE_MASK)
 #  else
 #   define MAX_RESERVED_VA  (1ul << TARGET_VIRT_ADDR_SPACE_BITS)
 #  endif
-- 
2.14.1
