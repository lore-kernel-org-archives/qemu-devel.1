Received: from eggs.gnu.org ([2001:4830:134:3::10]:53780)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fQBst-0000SG-HM
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 09:20:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fQBsn-0006VZ-U5
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 09:20:23 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:45920 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1fQBsn-0006Uy-J9
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 09:20:17 -0400
From: Peter Xu <peterx@redhat.com>
Date: Tue,  5 Jun 2018 21:19:43 +0800
Message-Id: <20180605131944.14649-3-peterx@redhat.com>
In-Reply-To: <20180605131944.14649-1-peterx@redhat.com>
References: <20180605131944.14649-1-peterx@redhat.com>
Subject: [Qemu-devel] [RFC 2/3] memory: add MemTxAttrs to IOMMUTLBEntry
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Eric Auger <eric.auger@redhat.com>, Richard Henderson <rth@twiddle.net>, David Gibson <david@gibson.dropbear.id.au>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, peterx@redhat.com, Alex Williamson <alex.williamson@redhat.com>, Peter Maydell <peter.maydell@linaro.org>

It should never be used for translate() calls since the caller should be
the one who passes in the MemTxAttrs.  However it could be used when we
want to generate an IOMMU translation notification with specific
translation attributes.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/exec/memory.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/include/exec/memory.h b/include/exec/memory.h
index 6b0ced554d..12865a4890 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -72,6 +72,13 @@ struct IOMMUTLBEntry {
     hwaddr           translated_addr;
     hwaddr           addr_mask;  /* 0xfff = 4k translation */
     IOMMUAccessFlags perm;
+    /*
+     * Attributes that were bound to the DMA translation.  Note that
+     * this field is meaningless when the IOMMUTLBENtry is generated
+     * by a translate() call.  It can be used as a hint when we want
+     * to send IOMMU notifications with specific permission flags.
+     */
+    MemTxAttrs       attrs;
 };
 
 /*
-- 
2.17.0
