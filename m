Received: from eggs.gnu.org ([2001:4830:134:3::10]:40889)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maozy.fnst@cn.fujitsu.com>) id 1daHSl-0001QX-Ri
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 04:14:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <maozy.fnst@cn.fujitsu.com>) id 1daHSh-0007H2-Pr
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 04:14:35 -0400
Received: from [59.151.112.132] (port=30802 helo=heian.cn.fujitsu.com)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maozy.fnst@cn.fujitsu.com>) id 1daHSh-0007El-Dy
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 04:14:31 -0400
From: Mao Zhongyi <maozy.fnst@cn.fujitsu.com>
Date: Wed, 26 Jul 2017 16:13:33 +0800
Message-ID: <08cf46e89ab0b97f09dbd98417d5d98a298b9d97.1501052660.git.maozy.fnst@cn.fujitsu.com>
MIME-Version: 1.0
In-Reply-To: <cover.1501052660.git.maozy.fnst@cn.fujitsu.com>
References: <cover.1501052660.git.maozy.fnst@cn.fujitsu.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v6 2/4] net/rocker: Plug memory leak in
 pci_rocker_init()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: jasowang@redhat.com, jiri@resnulli.us, armbru@redhat.com, f4bug@amsat.org

pci_rocker_init() leaks a World when the name more than 9 chars,
then return a negative value directly, doesn't make a correct
cleanup. So add a new goto label to fix it.

Cc: jasowang@redhat.com
Cc: jiri@resnulli.us
Cc: armbru@redhat.com
Cc: f4bug@amsat.org
Signed-off-by: Mao Zhongyi <maozy.fnst@cn.fujitsu.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/net/rocker/rocker.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/hw/net/rocker/rocker.c b/hw/net/rocker/rocker.c
index 7496752..9a538a9 100644
--- a/hw/net/rocker/rocker.c
+++ b/hw/net/rocker/rocker.c
@@ -1355,7 +1355,8 @@ static int pci_rocker_init(PCIDevice *dev)
         fprintf(stderr,
                 "rocker: name too long; please shorten to at most %d chars\n",
                 MAX_ROCKER_NAME_LEN);
-        return -EINVAL;
+        err = -EINVAL;
+        goto err_name_too_long;
     }
 
     if (memcmp(&r->fp_start_macaddr, &zero, sizeof(zero)) == 0) {
@@ -1414,6 +1415,7 @@ static int pci_rocker_init(PCIDevice *dev)
 
     return 0;
 
+err_name_too_long:
 err_duplicate:
     rocker_msix_uninit(r);
 err_msix_init:
-- 
2.9.4
