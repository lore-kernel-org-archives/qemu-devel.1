Received: from eggs.gnu.org ([2001:4830:134:3::10]:51834)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <apahim@redhat.com>) id 1eENAS-0003NW-A1
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 17:25:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <apahim@redhat.com>) id 1eENAP-0000Sq-5R
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 17:25:24 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43840)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <apahim@redhat.com>) id 1eENAO-0000SW-PA
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 17:25:20 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 0A3B3FEB4
	for <qemu-devel@nongnu.org>; Mon, 13 Nov 2017 22:25:20 +0000 (UTC)
From: Amador Pahim <apahim@redhat.com>
Date: Mon, 13 Nov 2017 23:23:57 +0100
Message-Id: <20171113222358.30967-8-apahim@redhat.com>
In-Reply-To: <20171113222358.30967-1-apahim@redhat.com>
References: <20171113222358.30967-1-apahim@redhat.com>
Subject: [Qemu-devel] [PATCH v10 7/8] qemu.py: launch vm only if it's not
 running
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: famz@redhat.com, crosa@redhat.com, ehabkost@redhat.com, Amador Pahim <apahim@redhat.com>

If we allow launching VM again we will loose track of the first launched
VM.

Reviewed-by: Fam Zheng <famz@redhat.com>
Signed-off-by: Amador Pahim <apahim@redhat.com>
---
 scripts/qemu.py | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/scripts/qemu.py b/scripts/qemu.py
index df2fca9e71..ab172c3670 100644
--- a/scripts/qemu.py
+++ b/scripts/qemu.py
@@ -207,6 +207,9 @@ class QEMUMachine(object):
         Launch the VM and make sure we cleanup and expose the
         command line/output in case of exception
         """
+        if self.is_running():
+            raise QEMUMachineError('VM already running')
+
         self._iolog = None
         self._qemu_full_args = None
         try:
-- 
2.13.6
