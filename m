Received: from eggs.gnu.org ([209.51.188.92]:45857)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gqfaU-00066m-H2
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 09:51:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gqfTd-0005iJ-Uc
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 09:44:03 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:41083)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1gqfTc-0005hO-Th
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 09:44:01 -0500
Received: by mail-qt1-f195.google.com with SMTP id b15so73634qto.8
	for <qemu-devel@nongnu.org>; Mon, 04 Feb 2019 06:44:00 -0800 (PST)
Date: Mon, 4 Feb 2019 09:43:57 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20190204142638.27021-21-mst@redhat.com>
References: <20190204142638.27021-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190204142638.27021-1-mst@redhat.com>
Subject: [Qemu-devel] [PULL 20/25] fw_cfg: fix the life cycle and the name
 of "qemu_extra_params_fw"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Laszlo Ersek <lersek@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Markus Armbruster <armbru@redhat.com>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>, Li Qiang <liq3ea@gmail.com>, Stefano Garzarella <sgarzare@redhat.com>

From: Laszlo Ersek <lersek@redhat.com>

Commit 19bcc4bc3213 ("fw_cfg: Make qemu_extra_params_fw locally",
2019-01-04) changed the storage duration of the "qemu_extra_params_fw"
array from static to automatic. This broke the interface contract on the
fw_cfg_add_file() function, which is documented as follows, in
"include/hw/nvram/fw_cfg.h":

> [...] The data referenced by the starting pointer is only linked, NOT
> copied, into the data structure of the fw_cfg device. [...]

As a result, when guest firmware fetches the "etc/boot-menu-wait" fw_cfg
file, it now sees garbage. Fix the regression by changing the storage
duration to allocated. (The call is reached at most once, on the realize
path of the board-specific fw_cfg sysbus device.)

While at it, clean up the name and the assignment of the object as well.

Cc: Gerd Hoffmann <kraxel@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>
Cc: Philippe Mathieu-Daudé <philmd@redhat.com>
Fixes: 19bcc4bc3213e78c303ad480a7a578f62258252d
Signed-off-by: Laszlo Ersek <lersek@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Gerd Hoffmann <kraxel@redhat.com>
Reviewed-by: Li Qiang <liq3ea@gmail.com>
Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 hw/nvram/fw_cfg.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/hw/nvram/fw_cfg.c b/hw/nvram/fw_cfg.c
index 53e8e010a8..7fdf04adc9 100644
--- a/hw/nvram/fw_cfg.c
+++ b/hw/nvram/fw_cfg.c
@@ -118,7 +118,6 @@ static void fw_cfg_bootsplash(FWCfgState *s)
 {
     const char *boot_splash_filename = NULL;
     const char *boot_splash_time = NULL;
-    uint8_t qemu_extra_params_fw[2];
     char *filename, *file_data;
     gsize file_size;
     int file_type;
@@ -132,6 +131,8 @@ static void fw_cfg_bootsplash(FWCfgState *s)
     /* insert splash time if user configurated */
     if (boot_splash_time) {
         int64_t bst_val = qemu_opt_get_number(opts, "splash-time", -1);
+        uint16_t bst_le16;
+
         /* validate the input */
         if (bst_val < 0 || bst_val > 0xffff) {
             error_report("splash-time is invalid,"
@@ -139,9 +140,9 @@ static void fw_cfg_bootsplash(FWCfgState *s)
             exit(1);
         }
         /* use little endian format */
-        qemu_extra_params_fw[0] = (uint8_t)(bst_val & 0xff);
-        qemu_extra_params_fw[1] = (uint8_t)((bst_val >> 8) & 0xff);
-        fw_cfg_add_file(s, "etc/boot-menu-wait", qemu_extra_params_fw, 2);
+        bst_le16 = cpu_to_le16(bst_val);
+        fw_cfg_add_file(s, "etc/boot-menu-wait",
+                        g_memdup(&bst_le16, sizeof bst_le16), sizeof bst_le16);
     }
 
     /* insert splash file if user configurated */
-- 
MST
