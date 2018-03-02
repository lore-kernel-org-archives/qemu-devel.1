Received: from eggs.gnu.org ([2001:4830:134:3::10]:38072)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jusual@mail.ru>) id 1eriAJ-00014c-N5
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 05:43:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jusual@mail.ru>) id 1eriAG-000813-JJ
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 05:43:51 -0500
Received: from smtp2.mail.ru ([94.100.179.91]:48570)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jusual@mail.ru>) id 1eriAG-00080W-6w
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 05:43:48 -0500
From: Julia Suvorova <jusual@mail.ru>
Date: Fri,  2 Mar 2018 13:43:19 +0300
Message-Id: <1519987399-19160-1-git-send-email-jusual@mail.ru>
Subject: [Qemu-devel] [PATCH v2] checkpatch: add a warning for
 basename/dirname
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@gmail.com>
Cc: Jim Mussared <jim@groklearning.com>, Joel Stanley <joel@jms.id.au>, Paolo Bonzini <pbonzini@redhat.com>, Cornelia Huck <cohuck@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Julia Suvorova <jusual@mail.ru>

g_path_get_* do the same as g_strdup(basename/dirname(...)) but
without modifying the argument.

Signed-off-by: Julia Suvorova <jusual@mail.ru>
---
 scripts/checkpatch.pl | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 1b4b812..a88af61 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -2584,6 +2584,11 @@ sub process {
 			ERROR("__func__ should be used instead of gcc specific __FUNCTION__\n"  . $herecurr);
 		}
 
+# recommend g_path_get_* over g_strdup(basename/dirname(...))
+		if ($line =~ /\bg_strdup\s*\(\s*(basename|dirname)\s*\(/) {
+			WARN("consider using g_path_get_$1() in preference to g_strdup($1())\n" . $herecurr);
+		}
+
 # recommend qemu_strto* over strto* for numeric conversions
 		if ($line =~ /\b(strto[^kd].*?)\s*\(/) {
 			ERROR("consider using qemu_$1 in preference to $1\n" . $herecurr);
-- 
2.1.4
