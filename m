Received: from eggs.gnu.org ([209.51.188.92]:44065)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1h1pvs-00047t-Sk
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 05:07:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1h1pvr-0007WV-Aa
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 05:07:20 -0500
Received: from mout.kundenserver.de ([217.72.192.74]:52225)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1h1pvq-0007VE-Tl
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 05:07:19 -0500
From: Laurent Vivier <laurent@vivier.eu>
Date: Thu,  7 Mar 2019 11:06:54 +0100
Message-Id: <20190307100656.14044-8-laurent@vivier.eu>
In-Reply-To: <20190307100656.14044-1-laurent@vivier.eu>
References: <20190307100656.14044-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 7/9] linux-user: fix "may be used uninitialized"
 warnings
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Riku Voipio <riku.voipio@iki.fi>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Fixes:

/home/elmarco/src/qemu/linux-user/syscall.c: In function ‘do_ioctl_rt’:
/home/elmarco/src/qemu/linux-user/syscall.c:4773:9: error: ‘host_rt_dev_ptr’ may be used uninitialized in this function [-Werror=maybe-uninitialized]
     if (*host_rt_dev_ptr != 0) {
         ^~~~~~~~~~~~~~~~
/home/elmarco/src/qemu/linux-user/syscall.c:4774:9: error: ‘target_rt_dev_ptr’ may be used uninitialized in this function [-Werror=maybe-uninitialized]
         unlock_user((void *)*host_rt_dev_ptr,
         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
                     *target_rt_dev_ptr, 0);
                     ~~~~~~~~~~~~~~~~~~~~~~

Based on previous discussion from patch "linux-users/syscall: make
do_ioctl_rt safer" by Alex Bennée.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Message-Id: <20190305151500.25038-1-marcandre.lureau@redhat.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/syscall.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 9f7eb7d7a896..208fd1813d6a 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -4733,8 +4733,8 @@ static abi_long do_ioctl_rt(const IOCTLEntry *ie, uint8_t *buf_temp,
     const int *dst_offsets, *src_offsets;
     int target_size;
     void *argptr;
-    abi_ulong *target_rt_dev_ptr;
-    unsigned long *host_rt_dev_ptr;
+    abi_ulong *target_rt_dev_ptr = NULL;
+    unsigned long *host_rt_dev_ptr = NULL;
     abi_long ret;
     int i;
 
@@ -4780,6 +4780,9 @@ static abi_long do_ioctl_rt(const IOCTLEntry *ie, uint8_t *buf_temp,
     unlock_user(argptr, arg, 0);
 
     ret = get_errno(safe_ioctl(fd, ie->host_cmd, buf_temp));
+
+    assert(host_rt_dev_ptr != NULL);
+    assert(target_rt_dev_ptr != NULL);
     if (*host_rt_dev_ptr != 0) {
         unlock_user((void *)*host_rt_dev_ptr,
                     *target_rt_dev_ptr, 0);
-- 
2.20.1
