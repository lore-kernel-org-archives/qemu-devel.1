Received: from eggs.gnu.org ([2001:4830:134:3::10]:45107)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fjJT2-0006HL-AV
	for qemu-devel@nongnu.org; Sat, 28 Jul 2018 03:16:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fjJSz-0007mM-7t
	for qemu-devel@nongnu.org; Sat, 28 Jul 2018 03:16:44 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:60870 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fjJSz-0007l1-35
	for qemu-devel@nongnu.org; Sat, 28 Jul 2018 03:16:41 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Sat, 28 Jul 2018 09:16:36 +0200
Message-Id: <20180728071638.17077-2-armbru@redhat.com>
In-Reply-To: <20180728071638.17077-1-armbru@redhat.com>
References: <20180728071638.17077-1-armbru@redhat.com>
Subject: [Qemu-devel] [PULL v2 1/3] qstring: Fix qstring_from_substr() not
 to provoke int overflow
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: liujunjie <liujunjie23@huawei.com>

From: liujunjie <liujunjie23@huawei.com>

qstring_from_substr() parameters @start and @end are of type int.
blkdebug_parse_filename(), blkverify_parse_filename(), nbd_parse_uri(),
and qstring_from_str() pass @end values of type size_t or ptrdiff_t.
Values exceeding INT_MAX get truncated, with possibly disastrous
results.

Such huge substrings seem unlikely, but we found one in a core dump,
where "info tlb" executed via QMP's human-monitor-command apparently
produced 35 GiB of output.

Fix by changing the parameters size_t.

Signed-off-by: liujunjie <liujunjie23@huawei.com>
Message-Id: <20180724134339.17832-1-liujunjie23@huawei.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 include/qapi/qmp/qstring.h | 2 +-
 qobject/qstring.c          | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/qapi/qmp/qstring.h b/include/qapi/qmp/qstring.h
index b3b3d444d2..3e83e3a95d 100644
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
index afca54b47a..18b8eb82f8 100644
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
2.17.1
