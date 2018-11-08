Received: from eggs.gnu.org ([2001:4830:134:3::10]:51983)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gKi1x-0006Vq-6A
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 05:59:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gKi1t-0003EP-Bu
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 05:59:20 -0500
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:42935)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gKi1t-0003Dl-3E
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 05:59:17 -0500
Received: by mail-wr1-x441.google.com with SMTP id y15-v6so20733086wru.9
	for <qemu-devel@nongnu.org>; Thu, 08 Nov 2018 02:59:16 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Thu,  8 Nov 2018 10:59:04 +0000
Message-Id: <20181108105904.27980-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH] linux-users/syscall: make do_ioctl_rt safer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-trivial@nongnu.org, Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>

host_rt_dev_ptr is set while looping through a control structure. The
compiler can not know that all structures passed to do_ioctl_rt will
trigger the if clause so rightly complains with an --enable-sanitizers
build. To keep the compiler happy we default the host_rt_dev_ptr and
check it has been set before attempting to follow it.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
CC: qemu-trivial@nongnu.org
---
 linux-user/syscall.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 810a58b704..3a942f1f4a 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -4669,7 +4669,7 @@ static abi_long do_ioctl_rt(const IOCTLEntry *ie, uint8_t *buf_temp,
     int target_size;
     void *argptr;
     abi_ulong *target_rt_dev_ptr;
-    unsigned long *host_rt_dev_ptr;
+    unsigned long *host_rt_dev_ptr = NULL;
     abi_long ret;
     int i;
 
@@ -4715,7 +4715,7 @@ static abi_long do_ioctl_rt(const IOCTLEntry *ie, uint8_t *buf_temp,
     unlock_user(argptr, arg, 0);
 
     ret = get_errno(safe_ioctl(fd, ie->host_cmd, buf_temp));
-    if (*host_rt_dev_ptr != 0) {
+    if (host_rt_dev_ptr && *host_rt_dev_ptr != 0) {
         unlock_user((void *)*host_rt_dev_ptr,
                     *target_rt_dev_ptr, 0);
     }
-- 
2.17.1
