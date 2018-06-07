Received: from eggs.gnu.org ([2001:4830:134:3::10]:46003)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fQzJP-00025T-PW
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 14:07:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fQzJO-0004Sx-TO
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 14:07:03 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Thu,  7 Jun 2018 15:06:38 -0300
Message-Id: <20180607180641.874-5-f4bug@amsat.org>
In-Reply-To: <20180607180641.874-1-f4bug@amsat.org>
References: <20180607180641.874-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 4/7] sdcard: Disable SEND_IF_COND (CMD8) for
 Spec v1
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair@alistair23.me>, Peter Maydell <peter.maydell@linaro.org>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, qemu-arm@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Paul Brook <paul@codesourcery.com>

CMD8 is "Reserved" in Spec v1.10.

Spec v2.00 introduces the SEND_IF_COND command:

  6.4.1 Power Up

    CMD8 is newly added in the Physical Layer Specification Version
    2.00 to support multiple voltage ranges and used to check whether
    the card supports supplied voltage. The version 2.00 or later host
    shall issue CMD8 and verify voltage before card initialization.
    The host that does not support CMD8 shall supply high voltage range.

Message-Id: 201204252110.20873.paul@codesourcery.com
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/sd/sd.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 1ae085de69..3ec0f71f24 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -1018,7 +1018,9 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
         break;
 
     case 8:	/* CMD8:   SEND_IF_COND */
-        /* Physical Layer Specification Version 2.00 command */
+        if (sd->spec_version < SD_PHY_SPECv2_00_VERS) {
+            break;
+        }
         if (sd->state != sd_idle_state) {
             break;
         }
-- 
2.17.1
