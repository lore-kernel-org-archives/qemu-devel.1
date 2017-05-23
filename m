Received: from eggs.gnu.org ([2001:4830:134:3::10]:37657)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maozy.fnst@cn.fujitsu.com>) id 1dD14n-0005Ak-7V
	for qemu-devel@nongnu.org; Tue, 23 May 2017 00:05:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <maozy.fnst@cn.fujitsu.com>) id 1dD14l-0004h2-8e
	for qemu-devel@nongnu.org; Tue, 23 May 2017 00:05:41 -0400
Received: from [59.151.112.132] (port=56572 helo=heian.cn.fujitsu.com)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maozy.fnst@cn.fujitsu.com>) id 1dD14k-0004eW-SD
	for qemu-devel@nongnu.org; Tue, 23 May 2017 00:05:39 -0400
From: Mao Zhongyi <maozy.fnst@cn.fujitsu.com>
Date: Tue, 23 May 2017 12:04:38 +0800
Message-ID: <d2b35b6077ffe9072f2b5924b02a75751ffc6031.1495508197.git.maozy.fnst@cn.fujitsu.com>
In-Reply-To: <cover.1495508197.git.maozy.fnst@cn.fujitsu.com>
References: <cover.1495508197.git.maozy.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v5 2/4] net/rocker: Plug memory leak in
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
Cc: armbru@redhat.com, jasowang@redhat.com, f4bug@amsat.org, jiri@resnulli.us

pci_rocker_init() leaks a World when the name more than 9 chars,
then return a negative value directly, doesn't make a correct
cleanup. So add a new goto label to fix it.

Signed-off-by: Mao Zhongyi <maozy.fnst@cn.fujitsu.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
---
 hw/net/rocker/rocker.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/hw/net/rocker/rocker.c b/hw/net/rocker/rocker.c
index d01ba9d..6d44f37 100644
--- a/hw/net/rocker/rocker.c
+++ b/hw/net/rocker/rocker.c
@@ -1357,7 +1357,8 @@ static int pci_rocker_init(PCIDevice *dev)
         fprintf(stderr,
                 "rocker: name too long; please shorten to at most %d chars\n",
                 MAX_ROCKER_NAME_LEN);
-        return -EINVAL;
+        err = -EINVAL;
+        goto err_name_too_long;
     }
 
     if (memcmp(&r->fp_start_macaddr, &zero, sizeof(zero)) == 0) {
@@ -1416,6 +1417,7 @@ static int pci_rocker_init(PCIDevice *dev)
 
     return 0;
 
+err_name_too_long:
 err_duplicate:
     rocker_msix_uninit(r);
 err_msix_init:
-- 
2.9.3
