Received: from eggs.gnu.org ([209.51.188.92]:47753)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jandryuk@gmail.com>) id 1h3PHB-0003Ai-EX
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 14:03:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jandryuk@gmail.com>) id 1h3PHA-0002id-Ge
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 14:03:49 -0400
Received: from mail-qt1-x843.google.com ([2607:f8b0:4864:20::843]:35005)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jandryuk@gmail.com>) id 1h3PHA-0002Ue-AG
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 14:03:48 -0400
Received: by mail-qt1-x843.google.com with SMTP id b16so5030812qtt.2
	for <qemu-devel@nongnu.org>; Mon, 11 Mar 2019 11:03:28 -0700 (PDT)
From: Jason Andryuk <jandryuk@gmail.com>
Date: Mon, 11 Mar 2019 14:02:15 -0400
Message-Id: <20190311180216.18811-6-jandryuk@gmail.com>
In-Reply-To: <20190311180216.18811-1-jandryuk@gmail.com>
References: <20190311180216.18811-1-jandryuk@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 5/6] xen-pt: Hide MSI-X from xen stubdoms
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: xen-devel@lists.xenproject.org, marmarek@invisiblethingslab.com, Jason Andryuk <jandryuk@gmail.com>, James McKenzie <james.mckenzie@bromium.com>, Stefano Stabellini <sstabellini@kernel.org>, Anthony Perard <anthony.perard@citrix.com>, Paul Durrant <paul.durrant@citrix.com>

MSI-X is not supported in Xen stubdoms, so it must be disabled.  Use the
existing xen_pt_hide_dev_cap to hide when running under -xen-stubdom.

A compile-time patch was originally written by James McKenzie
<james.mckenzie@bromium.com>

Signed-off-by: Jason Andryuk <jandryuk@gmail.com>
---
 hw/xen/xen_pt_config_init.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/hw/xen/xen_pt_config_init.c b/hw/xen/xen_pt_config_init.c
index 31ec5add1d..b827a493ea 100644
--- a/hw/xen/xen_pt_config_init.c
+++ b/hw/xen/xen_pt_config_init.c
@@ -54,6 +54,9 @@ static int xen_pt_hide_dev_cap(const XenHostPCIDevice *d, uint8_t grp_id)
             return 1;
         }
         break;
+    case PCI_CAP_ID_MSIX:
+        /* stubdoms don't support MSI-X so skip it. */
+        return xen_stubdom_enabled();
     }
     return 0;
 }
-- 
2.20.1
