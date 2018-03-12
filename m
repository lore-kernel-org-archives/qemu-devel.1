Received: from eggs.gnu.org ([2001:4830:134:3::10]:50292)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1evSbX-0003VO-RB
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 14:55:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1evSbX-0001h8-5S
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 14:55:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42502)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1evSbX-0001gB-0B
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 14:55:27 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3493BC0587D5
	for <qemu-devel@nongnu.org>; Mon, 12 Mar 2018 18:55:26 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Mon, 12 Mar 2018 15:55:02 -0300
Message-Id: <20180312185503.5746-3-ehabkost@redhat.com>
In-Reply-To: <20180312185503.5746-1-ehabkost@redhat.com>
References: <20180312185503.5746-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PATCH 2/3] qmp.py: Encode json data before sending
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Luk=C3=A1=C5=A1=20Doktor?= <ldoktor@redhat.com>, Cleber Rosa <crosa@redhat.com>

On Python 3, json.dumps() return a str object, which can't be
sent directly through a socket and must be encoded into a bytes
object.  Use .encode('utf-8'), which will work on both Python 2
and Python 3.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 scripts/qmp/qmp.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/qmp/qmp.py b/scripts/qmp/qmp.py
index 07c9632e9e..5c8cf6a056 100644
--- a/scripts/qmp/qmp.py
+++ b/scripts/qmp/qmp.py
@@ -166,7 +166,7 @@ class QEMUMonitorProtocol(object):
         """
         self.logger.debug(">>> %s", qmp_cmd)
         try:
-            self.__sock.sendall(json.dumps(qmp_cmd))
+            self.__sock.sendall(json.dumps(qmp_cmd).encode('utf-8'))
         except socket.error as err:
             if err[0] == errno.EPIPE:
                 return
-- 
2.14.3
