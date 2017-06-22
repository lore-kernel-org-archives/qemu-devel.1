Received: from eggs.gnu.org ([2001:4830:134:3::10]:56154)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dNsrq-0005fe-Gw
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 23:33:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dNsro-0004qj-4N
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 23:33:14 -0400
Received: from mail-qk0-x229.google.com ([2607:f8b0:400d:c09::229]:33918)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dNsrn-0004qF-W7
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 23:33:12 -0400
Received: by mail-qk0-x229.google.com with SMTP id d14so3032972qkb.1
	for <qemu-devel@nongnu.org>; Wed, 21 Jun 2017 20:33:11 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Thu, 22 Jun 2017 00:32:16 -0300
Message-Id: <20170622033231.19344-7-f4bug@amsat.org>
In-Reply-To: <20170622033231.19344-1-f4bug@amsat.org>
References: <20170622033231.19344-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 06/21] travis: Add config to do a Coverity
 Scan upload
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Fam Zheng <famz@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

From: Peter Maydell <peter.maydell@linaro.org>

Add config to travis to do a Coverity Scan build and upload, using
the new run-coverity-scan script.

There is an official integration between Travis and Coverity Scan:
 https://github.com/travis-ci/travis-build/blob/master/lib/travis/build/addons/coverity_scan.rb
which slurps values out of the .travis.yml and downloads a build
script from Coverity which does the bulk of the work:
 https://scan.coverity.com/scripts/travisci_build_coverity_scan.sh

However we choose to roll our own since this seems less
confusing and also allows us to include debug features
(notably the ability to do a "dry run" test which doesn't
actually upload anything).

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 .travis.yml | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/.travis.yml b/.travis.yml
index 0220f7472e..29c9ef72a4 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -218,3 +218,27 @@ matrix:
         - TEST_CMD=""
       before_script:
         - ./configure ${CONFIG} --extra-cflags="-g3 -O0 -fsanitize=thread -fuse-ld=gold" || cat config.log
+    # Build and upload to Coverity Scan.
+    # We do not impose any rate limiting here, but instead rely on the
+    # limiting done by the coverity servers, which for a project of QEMU's
+    # size means one build a day. The run-coverity-scan script will exit
+    # early if the limiter does not permit a new upload, so the effect will
+    # be that the first build (only) in each 24 hour period will be scanned.
+    # If we needed to apply a limit at the Travis end, the simplest approach
+    # would be to run the scan only if the branch was 'coverity-scan', and
+    # use a cron job to push master to the 'coverity-scan' branch periodically.
+    # We run on the trusty Travis hosts so that there's a wider set of
+    # dependencies satisfied to improve coverage.
+    - dist: trusty
+      env:
+        - COVERITY=1
+        - COVERITY_BUILD_CMD="make -j3"
+        - COVERITY_EMAIL=peter.maydell@linaro.org
+        # This 'secure' setting sets COVERITY_TOKEN=<secret token>
+        # and was created with travis encrypt -r qemu/qemu COVERITY_TOKEN=...
+        - secure: "D3E6E5bacui53fYBQrx0wQr8ZTvo6VIBPKfg0QHj2uwa6OPFkUlcMr/EHWvdbZNAa4Q1bv1vhlED5OPRfPmQYzxQNT4SAxDZeuZnikgIymfqQXNOjKw4kRUDO9P42QanyFd+EAu2JDVClAeJPgBpa/ns4CNrGDK+Q3coGndCP8o="
+      before_script:
+        - if [ "$TRAVIS_PULL_REQUEST" = "true" ]; then echo "Skipping Coverity (pullreq)"; exit 0; fi
+        - if [ "$TRAVIS_BRANCH" != "master" ]; then echo "Skipping Coverity (wrong branch)"; exit 0; fi
+      script:
+        - ./scripts/run-coverity-scan
-- 
2.11.0
