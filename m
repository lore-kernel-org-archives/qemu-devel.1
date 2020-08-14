Return-Path: <SRS0=5nOY=BY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0000DC433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2020 09:21:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BDF4F2074D
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2020 09:21:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AG9PL+5Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BDF4F2074D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59824 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k6Vtj-0000y3-RT
	for qemu-devel@archiver.kernel.org; Fri, 14 Aug 2020 05:21:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42676)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k6Vma-00059J-Gy
 for qemu-devel@nongnu.org; Fri, 14 Aug 2020 05:13:52 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:58042
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k6VmT-0002qb-Oh
 for qemu-devel@nongnu.org; Fri, 14 Aug 2020 05:13:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597396425;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=A0PyUK3LwFNOLZuQB716DGk+9XTGNcESv8Tm8i3AYDo=;
 b=AG9PL+5Y/puCBPwdAJj9fUr+gj2DfodWxhIHW2xr3/8gy++5/oRuX0QzIZCeVYBn9jQkIM
 YQlGd5Ogrs8FbfumJ7vgSBPW3vzcBoouiSdY76yuB4eir5wVzvfi9G8zaz+GGco2nv7Em5
 DlJ13u1srM9ccXfRsQ84dgXCa6F85dM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-308-Dres8EbvNnii7IYakqcC_A-1; Fri, 14 Aug 2020 05:13:42 -0400
X-MC-Unique: Dres8EbvNnii7IYakqcC_A-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 78A701015DBC
 for <qemu-devel@nongnu.org>; Fri, 14 Aug 2020 09:13:41 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2A1E2709D2;
 Fri, 14 Aug 2020 09:13:41 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 019/150] build-sys: add meson submodule
Date: Fri, 14 Aug 2020 05:11:15 -0400
Message-Id: <20200814091326.16173-20-pbonzini@redhat.com>
In-Reply-To: <20200814091326.16173-1-pbonzini@redhat.com>
References: <20200814091326.16173-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/14 01:57:54
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 .gitmodules               |  3 ++
 configure                 | 73 ++++++++++++++++++++++++++++++++++-----
 meson                     |  1 +
 scripts/archive-source.sh |  3 +-
 4 files changed, 71 insertions(+), 9 deletions(-)
 create mode 160000 meson

diff --git a/.gitmodules b/.gitmodules
index 9c0501a4d4..ce979398a8 100644
--- a/.gitmodules
+++ b/.gitmodules
@@ -58,3 +58,6 @@
 [submodule "roms/qboot"]
 	path = roms/qboot
 	url = https://github.com/bonzini/qboot
+[submodule "meson"]
+	path = meson
+	url = https://github.com/mesonbuild/meson/
diff --git a/configure b/configure
index c9f36153dd..bbbb213d8d 100755
--- a/configure
+++ b/configure
@@ -174,6 +174,25 @@ path_of() {
     return 1
 }
 
+version_ge () {
+    local_ver1=`echo $1 | tr . ' '`
+    local_ver2=`echo $2 | tr . ' '`
+    while true; do
+        set x $local_ver1
+        local_first=${2-0}
+        # shift 2 does nothing if there are less than 2 arguments
+        shift; shift
+        local_ver1=$*
+        set x $local_ver2
+        # the second argument finished, the first must be greater or equal
+        test $# = 1 && return 0
+        test $local_first -lt $2 && return 1
+        test $local_first -gt $2 && return 0
+        shift; shift
+        local_ver2=$*
+    done
+}
+
 have_backend () {
     echo "$trace_backends" | grep "$1" >/dev/null
 }
@@ -506,7 +525,7 @@ fuzzing="no"
 rng_none="no"
 secret_keyring=""
 libdaxctl=""
-meson=meson
+meson=""
 
 supported_cpu="no"
 supported_os="no"
@@ -916,6 +935,7 @@ fi
 # python 2.x, but some distros have it as python 3.x, so
 # we check that too
 python=
+explicit_python=no
 for binary in "${PYTHON-python3}" python
 do
     if has "$binary"
@@ -999,7 +1019,7 @@ for opt do
   ;;
   --install=*) install="$optarg"
   ;;
-  --python=*) python="$optarg"
+  --python=*) python="$optarg" ; explicit_python=yes
   ;;
   --sphinx-build=*) sphinx_build="$optarg"
   ;;
@@ -1978,15 +1998,52 @@ python_version=$($python -c 'import sys; print("%d.%d.%d" % (sys.version_info[0]
 # Suppress writing compiled files
 python="$python -B"
 
-if ! has "$meson"
-then
-    error_exit "Meson not found. Use --meson=/path/to/meson"
+if test -z "$meson"; then
+    if test "$explicit_python" = no && has meson && version_ge "$(meson --version)" 0.55.0; then
+        meson=meson
+    elif test -e "${source_path}/.git" && test $git_update = 'yes' ; then
+        meson=git
+    elif test -e "${source_path}/meson/meson.py" ; then
+        meson=internal
+    else
+        if test "$explicit_python" = yes; then
+            error_exit "--python requires using QEMU's embedded Meson distribution, but it was not found."
+        else
+            error_exit "Meson not found.  Use --meson=/path/to/meson"
+        fi
+    fi
+else
+    # Meson uses its own Python interpreter to invoke other Python scripts,
+    # but the user wants to use the one they specified with --python.
+    #
+    # We do not want to override the distro Python interpreter (and sometimes
+    # cannot: for example in Homebrew /usr/bin/meson is a bash script), so
+    # just require --meson=git|internal together with --python.
+    if test "$explicit_python" = yes; then
+        case "$meson" in
+            git | internal) ;;
+            *) error_exit "--python requires using QEMU's embedded Meson distribution." ;;
+        esac
+    fi
 fi
-meson=$(command -v $meson)
 
-if ! $python -c 'import pkg_resources' > /dev/null 2>&1; then
-  error_exit "Python setuptools not found"
+if test "$meson" = git; then
+    git_submodules="${git_submodules} meson"
 fi
+if test "$git_update" = yes; then
+    (cd "${source_path}" && GIT="$git" "./scripts/git-submodule.sh" update "$git_submodules")
+fi
+
+case "$meson" in
+    git | internal)
+        if ! $python -c 'import pkg_resources' > /dev/null 2>&1; then
+            error_exit "Python setuptools not found"
+        fi
+        meson="$python ${source_path}/meson/meson.py"
+        ;;
+    *) meson=$(command -v meson) ;;
+esac
+
 
 # Check that the C compiler works. Doing this here before testing
 # the host CPU ensures that we had a valid CC to autodetect the
diff --git a/meson b/meson
new file mode 160000
index 0000000000..d0c68dc115
--- /dev/null
+++ b/meson
@@ -0,0 +1 @@
+Subproject commit d0c68dc11507a47b9b85de508e023d9590d60565
diff --git a/scripts/archive-source.sh b/scripts/archive-source.sh
index fb5d6b3918..c6169db69f 100755
--- a/scripts/archive-source.sh
+++ b/scripts/archive-source.sh
@@ -26,7 +26,8 @@ sub_file="${sub_tdir}/submodule.tar"
 # independent of what the developer currently has initialized
 # in their checkout, because the build environment is completely
 # different to the host OS.
-submodules="dtc slirp ui/keycodemapdb tests/fp/berkeley-softfloat-3 tests/fp/berkeley-testfloat-3"
+submodules="dtc slirp meson ui/keycodemapdb"
+submodules="$submodules tests/fp/berkeley-softfloat-3 tests/fp/berkeley-testfloat-3"
 sub_deinit=""
 
 function cleanup() {
-- 
2.26.2



