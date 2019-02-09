Received: from eggs.gnu.org ([209.51.188.92]:46625)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1gsJqA-00013h-C8
	for qemu-devel@nongnu.org; Fri, 08 Feb 2019 23:02:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1gsJq9-0000O2-IA
	for qemu-devel@nongnu.org; Fri, 08 Feb 2019 23:02:06 -0500
From: Cleber Rosa <crosa@redhat.com>
Date: Fri,  8 Feb 2019 23:01:32 -0500
Message-Id: <20190209040132.25573-3-crosa@redhat.com>
In-Reply-To: <20190209040132.25573-1-crosa@redhat.com>
References: <20190209040132.25573-1-crosa@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 2/2] qemu-iotests: add "make check-block" job
 to Travis
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org, Fam Zheng <fam@euphon.net>, Cleber Rosa <crosa@redhat.com>

I usually keep an eye if I'm breaking stuff by looking at Travis
(too).  So it seems like a good idea to add a job that will do that.

A few things deserve a better explanation:

  * test 233 requires "--enable-gnutls", and fails without it

  * QEMU seems unable to initialize sound devices on the environment
    given by Travis, and that's why it's compiled without any audio
    driver.

  * The syntax for setting an empty list of audio drivers possibly
    deserves some TLC (it's not currently possible to set it to an
    empty list with quotes, resulting in something like "Unknown
    driver '''' selected".

Signed-off-by: Cleber Rosa <crosa@redhat.com>
---
 .travis.yml | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/.travis.yml b/.travis.yml
index 87d9fa971c..6d60ae9762 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -196,6 +196,14 @@ matrix:
           packages:
             - python3-pip
             - python3.5-venv
+
+
+    # qemu-iotests
+    - env:
+        - CONFIG=3D"--target-list=3Dx86_64-softmmu --enable-gnutls --aud=
io-drv-list=3D"
+        - TEST_CMD=3D"make check-block"
+
+
     # Using newer GCC with sanitizers
     - addons:
         apt:
--=20
2.20.1
