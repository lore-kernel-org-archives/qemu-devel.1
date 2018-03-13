Received: from eggs.gnu.org ([2001:4830:134:3::10]:55570)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1evnog-00006a-Rs
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 13:34:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1evnoe-0007wT-6e
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 13:34:26 -0400
Received: from mout.kundenserver.de ([212.227.126.133]:46463)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1evnod-0007ug-T8
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 13:34:24 -0400
From: Laurent Vivier <laurent@vivier.eu>
Date: Tue, 13 Mar 2018 18:33:50 +0100
Message-Id: <20180313173355.4468-14-laurent@vivier.eu>
In-Reply-To: <20180313173355.4468-1-laurent@vivier.eu>
References: <20180313173355.4468-1-laurent@vivier.eu>
Subject: [Qemu-devel] [PULL 13/18] linux-user: init_guest_space: Correctly
 handle guest_start in commpage initialization
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Riku Voipio <riku.voipio@iki.fi>, Luke Shumaker <lukeshu@parabola.nu>

From: Luke Shumaker <lukeshu@parabola.nu>

init_guest_commpage  needs to check if the mapped space, which ends at
real_start+real_size overlaps with where it needs to put the commpage,
which is (assuming sane qemu_host_page_size) guest_base + 0xffff000, where
guest_base is real_start - guest_start.

    [guest_base][       0xffff0000      ][commpage]
    [guest_base][guest_start][real_size] [commpage]
    [       real_start      ][real_size] [commpage]
                                        ^
                                 fail if this gap < 0

Since init_guest_commpage wants to do everything relative to guest_base
(rather than real_start), it obviously needs to be comparing 0xffff0000
against guest_start+real_size, not just real_size.

This bug has been present since 806d102141b99d4f1e55a97d68b7ea8c8ba3129f in
2012, but guest_start is usually 0, and prior to v2.11 real_size was
usually much smaller than 0xffff0000, so it was uncommon for it to have
made a difference.

Signed-off-by: Luke Shumaker <lukeshu@parabola.nu>
Message-Id: <20171228180814.9749-5-lukeshu@lukeshu.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/elfload.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index dcdd756908..feecbd4163 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -1856,7 +1856,7 @@ unsigned long init_guest_space(unsigned long host_start,
 #if defined(TARGET_ARM) && !defined(TARGET_AARCH64)
             /* On 32-bit ARM, we need to also be able to map the commpage.  */
             int valid = init_guest_commpage(real_start - guest_start,
-                                            real_size);
+                                            real_size + guest_start);
             if (valid == 1) {
                 break;
             } else if (valid == -1) {
-- 
2.14.3
