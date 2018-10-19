Received: from eggs.gnu.org ([2001:4830:134:3::10]:47427)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1gDY5n-0001LN-8Y
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 12:57:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1gDY5m-0001qM-Gb
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 12:57:43 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:51970)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1gDY5m-0001jg-6u
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 12:57:42 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1gDY5i-0006fK-Mg
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 17:57:38 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 19 Oct 2018 17:56:51 +0100
Message-Id: <20181019165735.22511-2-peter.maydell@linaro.org>
In-Reply-To: <20181019165735.22511-1-peter.maydell@linaro.org>
References: <20181019165735.22511-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 01/45] ssi-sd: Make devices picking up backends
 unavailable with -device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Markus Armbruster <armbru@redhat.com>

Device models aren't supposed to go on fishing expeditions for
backends.  They should expose suitable properties for the user to set.
For onboard devices, board code sets them.

Device ssi-sd picks up its block backend in its init() method with
drive_get_next() instead.  This mistake is already marked FIXME since
commit af9e40a.

Unset user_creatable to remove the mistake from our external
interface.  Since the SSI bus doesn't support hotplug, only -device
can be affected.  Only certain ARM machines have ssi-sd and provide an
SSI bus for it; this patch breaks -device ssi-sd for these machines.
No actual use of -device ssi-sd is known.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Acked-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Acked-by: Thomas Huth <thuth@redhat.com>
Message-id: 20181009060835.4608-1-armbru@redhat.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/sd/ssi-sd.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/sd/ssi-sd.c b/hw/sd/ssi-sd.c
index 95a143bfba1..623d0333e86 100644
--- a/hw/sd/ssi-sd.c
+++ b/hw/sd/ssi-sd.c
@@ -284,6 +284,8 @@ static void ssi_sd_class_init(ObjectClass *klass, void *data)
     k->cs_polarity = SSI_CS_LOW;
     dc->vmsd = &vmstate_ssi_sd;
     dc->reset = ssi_sd_reset;
+    /* Reason: init() method uses drive_get_next() */
+    dc->user_creatable = false;
 }
 
 static const TypeInfo ssi_sd_info = {
-- 
2.19.1
