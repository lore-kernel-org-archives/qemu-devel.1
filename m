Received: from eggs.gnu.org ([2001:4830:134:3::10]:55608)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dLtt3-0004U4-VW
	for qemu-devel@nongnu.org; Fri, 16 Jun 2017 12:14:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dLtt2-0002mc-Ss
	for qemu-devel@nongnu.org; Fri, 16 Jun 2017 12:14:17 -0400
Received: from mail-qt0-x22e.google.com ([2607:f8b0:400d:c0d::22e]:32893)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dLtt2-0002mW-Nu
	for qemu-devel@nongnu.org; Fri, 16 Jun 2017 12:14:16 -0400
Received: by mail-qt0-x22e.google.com with SMTP id u12so69342106qth.0
	for <qemu-devel@nongnu.org>; Fri, 16 Jun 2017 09:14:16 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Fri, 16 Jun 2017 13:13:33 -0300
Message-Id: <20170616161334.7492-11-f4bug@amsat.org>
In-Reply-To: <20170616161334.7492-1-f4bug@amsat.org>
References: <20170616161334.7492-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 10/11] travis: Add config to do a Coverity Scan
 upload
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
index 4c0f7f444e..fc91e2fd28 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -220,3 +220,27 @@ matrix:
         - RUN_TESTS="no"
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
