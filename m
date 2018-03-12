Received: from eggs.gnu.org ([2001:4830:134:3::10]:56706)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1evVfU-0000ao-M6
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 18:11:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1evVfT-0002Ch-Si
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 18:11:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59938)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1evVfT-0002C5-N0
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 18:11:43 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Mon, 12 Mar 2018 19:11:31 -0300
Message-Id: <20180312221132.14141-4-ehabkost@redhat.com>
In-Reply-To: <20180312221132.14141-1-ehabkost@redhat.com>
References: <20180312221132.14141-1-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 3/4] qmp.py: Encode json data before sending
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Cleber Rosa <crosa@redhat.com>

On Python 3, json.dumps() return a str object, which can't be
sent directly through a socket and must be encoded into a bytes
object.  Use .encode('utf-8'), which will work on both Python 2
and Python 3.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
Message-Id: <20180312185503.5746-3-ehabkost@redhat.com>
Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
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
             if err[0] =3D=3D errno.EPIPE:
                 return
--=20
2.14.3
