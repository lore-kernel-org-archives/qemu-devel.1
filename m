Return-Path: <SRS0=yhYb=B3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3713FC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 14:44:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E0E5E2076E
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 14:44:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LLOaVJQn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0E5E2076E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46888 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k7gNP-0007WL-4A
	for qemu-devel@archiver.kernel.org; Mon, 17 Aug 2020 10:44:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40598)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <paolo.bonzini@gmail.com>)
 id 1k7gGj-0003f9-HZ
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 10:37:49 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:39303)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <paolo.bonzini@gmail.com>)
 id 1k7gGh-00063h-Fx
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 10:37:49 -0400
Received: by mail-wr1-x441.google.com with SMTP id a5so15256919wrm.6
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2020 07:37:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=A7aT8Lsvyvguxpc7XKTthGOqaaTVf42GL2XpGYgV4Bc=;
 b=LLOaVJQn96NjmAzOMVxfB7eXeARoiwoZ/q/JdKXl0RNx1ThXgVTCYV49/JLrsIQo9P
 j2GNHkN/zlXBYrxMDU6MHenXoOiwdL+O1tY4A+KW7KTqFKN8eX5eFaTg8xbI17fv4XhJ
 1ygsnQ/T4ZKjPlLYodfCoobnah8gbIQyOL5akgkbU/BDtbTXcJH94ZaQcBh3RHLOSGdM
 szCgt9PZnQ0xGbu0WHTk9k92Nrl/Hckivuiqhh5ncX6YuPvnZrLQYiIwB3F/8uGOM1FQ
 I+9+m5D+zQQwfVqPZfJ5K5JoIPuszqlU4U9eg09ojjt+RG4kTpVFHQ5nSTafB5FgZBuP
 YKbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=A7aT8Lsvyvguxpc7XKTthGOqaaTVf42GL2XpGYgV4Bc=;
 b=lZYiginnBX6HnC268DyyhykfTKUYd9py4s7sNCHrTZ2kD5OPs5FKplUJwwD/2/oZa/
 094LJIAIUKpJCYf+Df8ZcE9gVMjNzno7DKUeTTF77xfcFMx80daJkB3legAbyb7ekN5s
 VT4JuZv6bVqakbVgAY0N+2B8ES7uamU4f6MGkT0dykpSq11z30OutaHqbBss5faOBzVL
 R9RpGdgOdtkBizA5aS7APByqGFSlzz09KWKa8EbiF2jrOUhmp5g3VOiGCKcuJnFmIKQs
 WzE9XZdYx5vif6jq8ODHGqw6dbfpS5d49kUviJ5SMoqeNSoQodWBY9PV92ySXJoPJP8Q
 LOeA==
X-Gm-Message-State: AOAM532HvFAy7Q88GvV1GHtAk8EQI2tKqIbYrvmgNKqISKbnst1WKmlu
 qDm5X6OiHljDLZKwYhHZM12TNxRtUsI=
X-Google-Smtp-Source: ABdhPJy4RdemsMDT4TtB3Dq1coeHJoDQPPN4KIjQYmMo9kuC2teB9QLXJ8/0eE0bz1ldDW4EuMsjAQ==
X-Received: by 2002:adf:efd2:: with SMTP id i18mr15254882wrp.32.1597675065663; 
 Mon, 17 Aug 2020 07:37:45 -0700 (PDT)
Received: from donizetti.redhat.com ([2001:b07:6468:f312:a0d1:fc42:c610:f977])
 by smtp.gmail.com with ESMTPSA id
 i22sm34966603wrb.45.2020.08.17.07.37.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2020 07:37:44 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 018/150] build-sys: add meson submodule
Date: Mon, 17 Aug 2020 16:35:11 +0200
Message-Id: <20200817143723.343284-19-pbonzini@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200817143723.343284-1-pbonzini@redhat.com>
References: <20200817143723.343284-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=paolo.bonzini@gmail.com; helo=mail-wr1-x441.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=no autolearn_force=no
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
index 994e9844aa..45111a619d 100755
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



