Received: from eggs.gnu.org ([2001:4830:134:3::10]:45041)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1f8qcl-0006eN-UI
	for qemu-devel@nongnu.org; Wed, 18 Apr 2018 13:12:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1f8qch-0002FW-Rr
	for qemu-devel@nongnu.org; Wed, 18 Apr 2018 13:12:03 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:54126 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1f8qch-0002FA-Nd
	for qemu-devel@nongnu.org; Wed, 18 Apr 2018 13:11:59 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 41A00406E8B9
	for <qemu-devel@nongnu.org>; Wed, 18 Apr 2018 17:11:56 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Date: Wed, 18 Apr 2018 18:11:51 +0100
Message-Id: <20180418171151.5263-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2] configure: add sanity check to catch builds
 from "git archive"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

The "git archive" feature creates tarballs which are missing all
submodule content. GitHub unhelpfully provides users with "Download"
links that claim to give them valid source release tarballs. These
GitHub archives will not be buildable as they are created by the
"git archive" feature and so are missing content. The user gets
unhelpful messages from make such as:

  fatal error: ui/input-keymap-atset1-to-qcode.c: No such file or directo=
ry

By adding a sanity check we can give users an informative message about
what they've done wrong.

Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
---
 configure | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/configure b/configure
index 0a19b033bc..089b00068c 100755
--- a/configure
+++ b/configure
@@ -296,6 +296,24 @@ then
 else
     git_update=3Dno
     git_submodules=3D""
+
+    if ! test -f "$source_path/ui/keycodemapdb/README"
+    then
+        echo
+        echo "ERROR: missing file $source_path/ui/keycodemapdb/README"
+        echo
+        echo "This is not a GIT checkout but module content appears to"
+        echo "be missing. Do not use 'git archive' or GitHub download li=
nks"
+        echo "to acquire QEMU source archives. Non-GIT builds are only"
+        echo "supported with source archives linked from:"
+        echo
+        echo "  https://www.qemu.org/download/"
+        echo
+        echo "Developers working with GIT can use scripts/archive-source=
.sh"
+        echo "if they need to create valid source archives."
+        echo
+        exit 1
+    fi
 fi
 git=3D"git"
=20
--=20
2.14.3
