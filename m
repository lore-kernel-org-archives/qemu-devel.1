Received: from eggs.gnu.org ([209.51.188.92]:34093)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hL9eB-0004DT-OS
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 13:00:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hL9e7-0006Pj-Ca
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 13:00:54 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c]:51171)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hL9e4-00069k-1n
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 13:00:49 -0400
Received: by mail-wm1-x32c.google.com with SMTP id p21so185660wmc.0
	for <qemu-devel@nongnu.org>; Mon, 29 Apr 2019 10:00:37 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
	by smtp.gmail.com with ESMTPSA id a13sm36896wmj.39.2019.04.29.10.00.35
	for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 29 Apr 2019 10:00:35 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 29 Apr 2019 17:59:51 +0100
Message-Id: <20190429170030.11323-4-peter.maydell@linaro.org>
In-Reply-To: <20190429170030.11323-1-peter.maydell@linaro.org>
References: <20190429170030.11323-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 03/42] configure: Remove --source-path option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Normally configure identifies the source path by looking
at the location where the configure script itself exists.
We also provide a --source-path option which lets the user
manually override this.

There isn't really an obvious use case for the --source-path
option, and in commit 927128222b0a91f56c13a in 2017 we
accidentally added some logic that looks at $source_path
before the command line option that overrides it has been
processed.

The fact that nobody complained suggests that there isn't
any use of this option and we aren't testing it either;
remove it. This allows us to move the "make $source_path
absolute" logic up so that there is no window in the script
where $source_path is set but not yet absolute.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Message-id: 20190318134019.23729-1-peter.maydell@linaro.org
---
 configure | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/configure b/configure
index e1ad87b697e..60719ddcc5b 100755
--- a/configure
+++ b/configure
@@ -278,6 +278,8 @@ ld_has() {
 
 # default parameters
 source_path=$(dirname "$0")
+# make source path absolute
+source_path=$(cd "$source_path"; pwd)
 cpu=""
 iasl="iasl"
 interp_prefix="/usr/gnemul/qemu-%M"
@@ -520,8 +522,6 @@ for opt do
   ;;
   --cxx=*) CXX="$optarg"
   ;;
-  --source-path=*) source_path="$optarg"
-  ;;
   --cpu=*) cpu="$optarg"
   ;;
   --extra-cflags=*) QEMU_CFLAGS="$QEMU_CFLAGS $optarg"
@@ -600,9 +600,6 @@ if test "$debug_info" = "yes"; then
     LDFLAGS="-g $LDFLAGS"
 fi
 
-# make source path absolute
-source_path=$(cd "$source_path"; pwd)
-
 # running configure in the source tree?
 # we know that's the case if configure is there.
 if test -f "./configure"; then
@@ -946,8 +943,6 @@ for opt do
   ;;
   --interp-prefix=*) interp_prefix="$optarg"
   ;;
-  --source-path=*)
-  ;;
   --cross-prefix=*)
   ;;
   --cc=*)
@@ -1651,7 +1646,6 @@ $(echo Available targets: $default_target_list | \
   --target-list-exclude=LIST exclude a set of targets from the default target-list
 
 Advanced options (experts only):
-  --source-path=PATH       path of source code [$source_path]
   --cross-prefix=PREFIX    use PREFIX for compile tools [$cross_prefix]
   --cc=CC                  use C compiler CC [$cc]
   --iasl=IASL              use ACPI compiler IASL [$iasl]
-- 
2.20.1
