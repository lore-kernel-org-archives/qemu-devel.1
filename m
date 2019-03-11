Received: from eggs.gnu.org ([209.51.188.92]:47711)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jandryuk@gmail.com>) id 1h3PHA-0003Ag-4Z
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 14:03:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jandryuk@gmail.com>) id 1h3PH8-0002h7-6S
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 14:03:47 -0400
Received: from mail-qk1-x743.google.com ([2607:f8b0:4864:20::743]:35270)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jandryuk@gmail.com>) id 1h3PH6-0002RB-3Z
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 14:03:46 -0400
Received: by mail-qk1-x743.google.com with SMTP id z13so3276184qki.2
	for <qemu-devel@nongnu.org>; Mon, 11 Mar 2019 11:03:25 -0700 (PDT)
From: Jason Andryuk <jandryuk@gmail.com>
Date: Mon, 11 Mar 2019 14:02:14 -0400
Message-Id: <20190311180216.18811-5-jandryuk@gmail.com>
In-Reply-To: <20190311180216.18811-1-jandryuk@gmail.com>
References: <20190311180216.18811-1-jandryuk@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 4/6] xen: Set HVM_PARAM_DM_DOMAIN for stubdom
 on older Xen
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: xen-devel@lists.xenproject.org, marmarek@invisiblethingslab.com, Jason Andryuk <jandryuk@gmail.com>, Stefano Stabellini <sstabellini@kernel.org>, Anthony Perard <anthony.perard@citrix.com>, Paul Durrant <paul.durrant@citrix.com>

When running in a stubdom, we have to inform the hypervisor that the
stubdom and not dom0 is handling the device model.  Explicitly created
ioreq servers are fine, but a call to HVM_PARAM_DM_DOMAIN is needed for
the default ioreq server.

Xen 4.12 removes the default ioreq server.  With that, Xen started
returning an error when setting HVM_PARAM_DM_DOMAIN.  Put the
HVM_PARAM_DM_DOMAIN call in the version compatibility header.  When we
fallback to the default ioreq server, issue the call and don't bother to
check the return value.

Original patch by Anthony PERARD <anthony.perard@citrix.com>

Signed-off-by: Jason Andryuk <jandryuk@gmail.com>
---
 include/hw/xen/xen_common.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/hw/xen/xen_common.h b/include/hw/xen/xen_common.h
index 9a8155e172..f59f841a43 100644
--- a/include/hw/xen/xen_common.h
+++ b/include/hw/xen/xen_common.h
@@ -616,6 +616,11 @@ static inline void xen_create_ioreq_server(domid_t dom,
 
     *ioservid = 0;
     use_default_ioreq_server = true;
+
+    if (xen_stubdom_enabled()) {
+        xc_hvm_param_set(xen_xc, xen_domid, HVM_PARAM_DM_DOMAIN, DOMID_SELF);
+    }
+
     trace_xen_default_ioreq_server();
 }
 
-- 
2.20.1
