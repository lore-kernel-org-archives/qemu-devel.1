Received: from eggs.gnu.org ([2001:4830:134:3::10]:57996)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liujunjie23@huawei.com>) id 1fgVAd-0000hZ-CS
	for qemu-devel@nongnu.org; Fri, 20 Jul 2018 09:10:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liujunjie23@huawei.com>) id 1fgVAY-0004MH-IY
	for qemu-devel@nongnu.org; Fri, 20 Jul 2018 09:10:07 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:2636 helo=huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <liujunjie23@huawei.com>)
	id 1fgVAY-0004IJ-4J
	for qemu-devel@nongnu.org; Fri, 20 Jul 2018 09:10:02 -0400
From: liujunjie <liujunjie23@huawei.com>
Date: Fri, 20 Jul 2018 21:09:28 +0800
Message-ID: <20180720130928.6696-1-liujunjie23@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH] qstring: Fix integer overflow
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: armbru@redhat.com
Cc: arei.gonglei@huawei.com, wangxinxin.wang@huawei.com, weidong.huang@huawei.com, qemu-devel@nongnu.org, l00425170 <liujunjie23@huawei.com>

From: l00425170 <liujunjie23@huawei.com>

The incoming parameters "start" and "end" is int type in
qstring_from_substr(), but this function can be called by
qstring_from_str, which is size_t type in strlen(str).
It may result in coredump when called g_malloc later.
One scene to triger is to call hmp "into tlb", which may have
too long length of string.

Signed-off-by: l00425170 <liujunjie23@huawei.com>
---
 include/qapi/qmp/qstring.h | 2 +-
 qobject/qstring.c          | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/qapi/qmp/qstring.h b/include/qapi/qmp/qstring.h
index b3b3d44..3e83e3a 100644
--- a/include/qapi/qmp/qstring.h
+++ b/include/qapi/qmp/qstring.h
@@ -24,7 +24,7 @@ struct QString {
 
 QString *qstring_new(void);
 QString *qstring_from_str(const char *str);
-QString *qstring_from_substr(const char *str, int start, int end);
+QString *qstring_from_substr(const char *str, size_t start, size_t end);
 size_t qstring_get_length(const QString *qstring);
 const char *qstring_get_str(const QString *qstring);
 const char *qstring_get_try_str(const QString *qstring);
diff --git a/qobject/qstring.c b/qobject/qstring.c
index afca54b..18b8eb8 100644
--- a/qobject/qstring.c
+++ b/qobject/qstring.c
@@ -37,7 +37,7 @@ size_t qstring_get_length(const QString *qstring)
  *
  * Return string reference
  */
-QString *qstring_from_substr(const char *str, int start, int end)
+QString *qstring_from_substr(const char *str, size_t start, size_t end)
 {
     QString *qstring;
 
-- 
1.8.3.1
