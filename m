Received: from eggs.gnu.org ([2001:4830:134:3::10]:36840)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1e6Ytp-0005y5-4G
	for qemu-devel@nongnu.org; Mon, 23 Oct 2017 05:19:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1e6Ytl-0005Yf-Dn
	for qemu-devel@nongnu.org; Mon, 23 Oct 2017 05:19:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58058)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1e6Ytl-0005YI-7b
	for qemu-devel@nongnu.org; Mon, 23 Oct 2017 05:19:53 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 5A5DE2D0FAE
	for <qemu-devel@nongnu.org>; Mon, 23 Oct 2017 09:19:52 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Mon, 23 Oct 2017 11:19:40 +0200
Message-Id: <20171023091947.20771-3-kraxel@redhat.com>
In-Reply-To: <20171023091947.20771-1-kraxel@redhat.com>
References: <20171023091947.20771-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PULL 2/9] ui: fix crash with sendkey and raw key
 numbers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Daniel P. Berrange" <berrange@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>

From: "Daniel P. Berrange" <berrange@redhat.com>

Previously we enforced that all key events are using QKeyCodes
at time they are sent:

  commit af07e5ff02ae6d4258fc5331007811d0b1c4d35a
  Author: Daniel P. Berrange <berrange@redhat.com>
  Date:   Fri Sep 29 11:12:00 2017 +0100

    ui: convert key events to QKeyCodes immediately

This commit forget to fix the code for the legacy 'sendkey'
command which still accepts key numbers from the user, which
then need converting to QKeyCodes

Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Message-id: 20171019142848.572-3-berrange@redhat.com
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 ui/input-legacy.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/ui/input-legacy.c b/ui/input-legacy.c
index 6bc3525499..c75aba1549 100644
--- a/ui/input-legacy.c
+++ b/ui/input-legacy.c
@@ -76,6 +76,11 @@ static KeyValue *copy_key_value(KeyValue *src)
 {
     KeyValue *dst = g_new(KeyValue, 1);
     memcpy(dst, src, sizeof(*src));
+    if (dst->type == KEY_VALUE_KIND_NUMBER) {
+        QKeyCode code = qemu_input_key_number_to_qcode(dst->u.number.data);
+        dst->type = KEY_VALUE_KIND_QCODE;
+        dst->u.qcode.data = code;
+    }
     return dst;
 }
 
-- 
2.9.3
