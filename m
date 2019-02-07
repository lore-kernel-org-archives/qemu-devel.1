Received: from eggs.gnu.org ([209.51.188.92]:41014)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1groYk-0000Ii-0O
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 13:38:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1groYf-0007Ua-Mr
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 13:38:00 -0500
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:35984)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1groYe-0007K1-QL
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 13:37:57 -0500
Received: by mail-wm1-x343.google.com with SMTP id p6so952329wmc.1
	for <qemu-devel@nongnu.org>; Thu, 07 Feb 2019 10:37:52 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Thu,  7 Feb 2019 18:37:34 +0000
Message-Id: <20190207183744.5054-7-alex.bennee@linaro.org>
In-Reply-To: <20190207183744.5054-1-alex.bennee@linaro.org>
References: <20190207183744.5054-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 06/16] archive-source.sh: Clone the
 submodules locally
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

From: Philippe Mathieu-Daudé <philmd@redhat.com>

We cloned the QEMU repository from the local storage. Since the
submodules are also available there, clone them too. This is
quicker and reduce network use.

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
[AJB: incorporated review suggestions from danpb]
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 scripts/archive-source.sh | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/scripts/archive-source.sh b/scripts/archive-source.sh
index 6eed2a29bd..d3a88f71e9 100755
--- a/scripts/archive-source.sh
+++ b/scripts/archive-source.sh
@@ -38,6 +38,13 @@ else
 fi
 git clone --shared . "$vroot_dir"
 test $? -ne 0 && error "failed to clone into '$vroot_dir'"
+for sm in $submodules; do
+    if test -d "$sm/.git"
+    then
+       git clone --shared "$sm" "$vroot_dir/$sm"
+       test $? -ne 0 && error "failed to clone submodule $sm"
+    fi
+done
 
 cd "$vroot_dir"
 test $? -ne 0 && error "failed to change into '$vroot_dir'"
-- 
2.20.1
