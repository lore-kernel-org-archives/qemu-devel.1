Received: from eggs.gnu.org ([209.51.188.92]:50661)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gtBHg-0007Xq-Rw
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 08:06:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gtBHf-0004EC-4G
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 08:06:04 -0500
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b]:33567)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gtBHd-0003mF-8V
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 08:06:02 -0500
Received: by mail-wr1-x42b.google.com with SMTP id i12so267775wrw.0
	for <qemu-devel@nongnu.org>; Mon, 11 Feb 2019 05:05:15 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Mon, 11 Feb 2019 13:04:55 +0000
Message-Id: <20190211130507.8710-7-alex.bennee@linaro.org>
In-Reply-To: <20190211130507.8710-1-alex.bennee@linaro.org>
References: <20190211130507.8710-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 06/18] archive-source.sh: Clone the submodules
 locally
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

From: Philippe Mathieu-Daudé <philmd@redhat.com>

We cloned the QEMU repository from the local storage. Since the
submodules are also available there, clone them too. This is
quicker and reduce network use.

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
[AJB: incorporated review suggestions from danpb]
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

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
