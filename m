Received: from eggs.gnu.org ([2001:4830:134:3::10]:54993)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fVd2N-0007yB-Dw
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 09:20:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fVd2L-0002kw-NE
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 09:20:39 -0400
Received: from mail-wm0-x22f.google.com ([2a00:1450:400c:c09::22f]:37754)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fVd2L-0002kS-Fb
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 09:20:37 -0400
Received: by mail-wm0-x22f.google.com with SMTP id r125-v6so6890114wmg.2
	for <qemu-devel@nongnu.org>; Wed, 20 Jun 2018 06:20:37 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Wed, 20 Jun 2018 14:20:30 +0100
Message-Id: <20180620132032.12952-4-alex.bennee@linaro.org>
In-Reply-To: <20180620132032.12952-1-alex.bennee@linaro.org>
References: <20180620132032.12952-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RFC PATCH 3/5] .travis.yml: add gcovr summary for
 GCOV build
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: cota@braap.org, famz@redhat.com, berrange@redhat.com, f4bug@amsat.org, richard.henderson@linaro.org, balrogg@gmail.com, aurelien@aurel32.net, agraf@suse.de
Cc: qemu-devel@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

This gives a more useful summary, sorted by descending % coverage,
after the tests have run. The final numbers will give an idea if our
coverage is getting better or worse.

As quite a lot of lines don't get covered at all we filter out all the
0% lines. If the file doesn't appear it is not being exercised.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 .travis.yml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/.travis.yml b/.travis.yml
index fabfe9ec34..83e0577464 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -38,6 +38,7 @@ addons:
       - libvte-2.90-dev
       - sparse
       - uuid-dev
+      - gcovr
 
 # The channel name "irc.oftc.net#qemu" is encrypted against qemu/qemu
 # to prevent IRC notifications from forks. This was created using:
@@ -81,6 +82,8 @@ matrix:
       compiler: clang
     # gprof/gcov are GCC features
     - env: CONFIG="--enable-gprof --enable-gcov --disable-pie --target-list=aarch64-softmmu,arm-softmmu,i386-softmmu,mips-softmmu,mips64-softmmu,ppc64-softmmu,riscv64-softmmu,s390x-softmmu,x86_64-softmmu"
+      after_success:
+        - gcovr -p  | grep -v "0%" | sed s/[0-9]\*[,-]//g
       compiler: gcc
     # We manually include builds which we disable "make check" for
     - env: CONFIG="--enable-debug --enable-tcg-interpreter"
-- 
2.17.1
