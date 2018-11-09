Received: from eggs.gnu.org ([2001:4830:134:3::10]:45042)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1gL8k7-0002Ea-Ru
	for qemu-devel@nongnu.org; Fri, 09 Nov 2018 10:30:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1gL8k6-0007xo-SD
	for qemu-devel@nongnu.org; Fri, 09 Nov 2018 10:30:43 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56192)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <crosa@redhat.com>) id 1gL8k6-0007wg-Kb
	for qemu-devel@nongnu.org; Fri, 09 Nov 2018 10:30:42 -0500
From: Cleber Rosa <crosa@redhat.com>
Date: Fri,  9 Nov 2018 10:30:02 -0500
Message-Id: <20181109153002.597-3-crosa@redhat.com>
In-Reply-To: <20181109153002.597-1-crosa@redhat.com>
References: <20181109153002.597-1-crosa@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [RFC PATCH 2/2] Travis CI: break down OSX+clang jobs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Eduardo Habkost <ehabkost@redhat.com>, programmingkidx@gmail.com, Wainer dos Santos Moschetta <wainersm@redhat.com>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Fam Zheng <famz@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Caio Carrara <ccarrara@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>, Cleber Rosa <crosa@redhat.com>

The OSX jobs were timing out on Travis, due to the long time they need
to run tests with all targets.  Let's break them down to avoid hitting
the time limit, and at the same time, give faster results.

Additionally the qtest based tests were hanging intermittently.  The
first debugging attempt involved making their execution verbose.  That
alone seemed to produce a positive effect and no hangs were observed
after that.  Given that Travis checks for output to decide if a test
is hung or not, it makes sense that a verbose execution minimizes
false positives.

Signed-off-by: Cleber Rosa <crosa@redhat.com>
---
 .travis.yml | 29 ++++++++++++++++++++++++++++-
 1 file changed, 28 insertions(+), 1 deletion(-)

diff --git a/.travis.yml b/.travis.yml
index aa49c7b114..505561aae6 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -107,7 +107,34 @@ matrix:
     - env: CONFIG=3D"--disable-tcg"
            TEST_CMD=3D""
       compiler: gcc
-    - env: CONFIG=3D""
+    # osx+clang jobs are broken in a number of target specific sets to
+    # allow jobs to finish before timing out
+    - env: CONFIG=3D"--target-list=3Daarch64-softmmu,alpha-softmmu,arm-s=
oftmmu,cris-softmmu"
+           TEST_CMD=3D"make V=3D1 check"
+      os: osx
+      compiler: clang
+    - env: CONFIG=3D"--target-list=3Di386-softmmu,lm32-softmmu,m68k-soft=
mmu,moxie-softmmu"
+           TEST_CMD=3D"make V=3D1 check"
+      os: osx
+      compiler: clang
+    - env: CONFIG=3D"--target-list=3Dmips-softmmu,mips64-softmmu,mips64e=
l-softmmu,mipsel-softmmu"
+           TEST_CMD=3D"make V=3D1 check"
+      os: osx
+      compiler: clang
+    - env: CONFIG=3D"--target-list=3Dnios2-softmmu,or1k-softmmu,ppc-soft=
mmu,ppc64-softmmu,riscv32-softmmu"
+           TEST_CMD=3D"make V=3D1 check"
+      os: osx
+      compiler: clang
+    - env: CONFIG=3D"--target-list=3Ds390x-softmmu,sh4-softmmu,sh4eb-sof=
tmmu,sparc-softmmu,sparc64-softmmu"
+           TEST_CMD=3D"make V=3D1 check"
+      os: osx
+      compiler: clang
+    - env: CONFIG=3D"--target-list=3Dunicore32-softmmu,x86_64-softmmu,xt=
ensa-softmmu,xtensaeb-softmmu"
+           TEST_CMD=3D"make V=3D1 check"
+      os: osx
+      compiler: clang
+    - env: CONFIG=3D"--target-list=3Dhppa-softmmu,microblaze-softmmu,mic=
roblazeel-softmmu,tricore-softmmu,riscv64-softmmu"
+           TEST_CMD=3D"make V=3D1 check"
       os: osx
       compiler: clang
     # Python builds
--=20
2.19.1
