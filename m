Received: from eggs.gnu.org ([2001:4830:134:3::10]:56301)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fZ0Nv-0008D6-EG
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 16:52:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fZ0Nu-0006ch-EQ
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 16:52:51 -0400
Received: from mail-wm0-x236.google.com ([2a00:1450:400c:c09::236]:40226)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fZ0Nu-0006bK-7C
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 16:52:50 -0400
Received: by mail-wm0-x236.google.com with SMTP id z13-v6so3291238wma.5
	for <qemu-devel@nongnu.org>; Fri, 29 Jun 2018 13:52:49 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Fri, 29 Jun 2018 21:52:32 +0100
Message-Id: <20180629205232.27190-22-alex.bennee@linaro.org>
In-Reply-To: <20180629205232.27190-1-alex.bennee@linaro.org>
References: <20180629205232.27190-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 21/21] .shippable.yml: add linux-user
 cross-build for ppc-softmmu
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: cota@braap.org, famz@redhat.com, berrange@redhat.com, f4bug@amsat.org, richard.henderson@linaro.org, balrogg@gmail.com, aurelien@aurel32.net, agraf@suse.de
Cc: pbonzini@redhat.com, qemu-devel@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

Use our new ability to use linux-user powered docker images to build
ppc-softmmu.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 .shippable.yml | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/.shippable.yml b/.shippable.yml
index f74a3de3ff..12f9d3b221 100644
--- a/.shippable.yml
+++ b/.shippable.yml
@@ -25,6 +25,14 @@ env:
       TARGET_LIST=mips64el-softmmu,mips64el-linux-user
     - IMAGE=debian-ppc64el-cross
       TARGET_LIST=ppc64-softmmu,ppc64-linux-user,ppc64abi32-linux-user
+    include:
+      # Additional linux-user cross build
+      - pre_ci:
+          - ./configure --target-list=ppc-linux-user --static
+          - make -j$(($(getconf _NPROCESSORS_ONLN) + 1))
+          - make docker-image-powerpc-user-cross
+        env: IMAGE=debian-image-powerpc-user-cross
+             TARGET_LIST=ppc-softmmu
 build:
   pre_ci:
     - make docker-image-${IMAGE} V=1
-- 
2.17.1
