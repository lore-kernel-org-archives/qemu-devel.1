Received: from eggs.gnu.org ([2001:4830:134:3::10]:37711)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fZ95t-0003yK-KU
	for qemu-devel@nongnu.org; Sat, 30 Jun 2018 02:10:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fZ95q-0001dH-0j
	for qemu-devel@nongnu.org; Sat, 30 Jun 2018 02:10:49 -0400
Received: from mail-wr0-x233.google.com ([2a00:1450:400c:c0c::233]:32913)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1fZ95p-0001cg-Pn
	for qemu-devel@nongnu.org; Sat, 30 Jun 2018 02:10:45 -0400
Received: by mail-wr0-x233.google.com with SMTP id k7-v6so7155239wrq.0
	for <qemu-devel@nongnu.org>; Fri, 29 Jun 2018 23:10:45 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Sat, 30 Jun 2018 08:09:55 +0200
Message-Id: <20180630061040.6018-3-pbonzini@redhat.com>
In-Reply-To: <20180630061040.6018-1-pbonzini@redhat.com>
References: <20180630061040.6018-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 02/47] configure: add sanity check to catch
 builds from "git archive"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Daniel P. Berrangé <berrange@redhat.com>

The "git archive" feature creates tarballs which are missing all
submodule content. GitHub unhelpfully provides users with "Download"
links that claim to give them valid source release tarballs. These
GitHub archives will not be buildable as they are created by the
"git archive" feature and so are missing content. The user gets
unhelpful messages from make such as:

  fatal error: ui/input-keymap-atset1-to-qcode.c: No such file or directory

By adding a sanity check we can give users an informative message about
what they've done wrong.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
Message-Id: <20180418171151.5263-1-berrange@redhat.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Tested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 configure | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/configure b/configure
index ca7de4f..4b489fe 100755
--- a/configure
+++ b/configure
@@ -300,6 +300,24 @@ then
 else
     git_update=no
     git_submodules=""
+
+    if ! test -f "$source_path/ui/keycodemapdb/README"
+    then
+        echo
+        echo "ERROR: missing file $source_path/ui/keycodemapdb/README"
+        echo
+        echo "This is not a GIT checkout but module content appears to"
+        echo "be missing. Do not use 'git archive' or GitHub download links"
+        echo "to acquire QEMU source archives. Non-GIT builds are only"
+        echo "supported with source archives linked from:"
+        echo
+        echo "  https://www.qemu.org/download/"
+        echo
+        echo "Developers working with GIT can use scripts/archive-source.sh"
+        echo "if they need to create valid source archives."
+        echo
+        exit 1
+    fi
 fi
 git="git"
 
-- 
1.8.3.1
