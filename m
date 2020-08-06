Return-Path: <SRS0=Z/nf=BQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECEADC433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 19:24:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E94762177B
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 19:24:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h7NlphrE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E94762177B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37218 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3lVA-0002l1-IJ
	for qemu-devel@archiver.kernel.org; Thu, 06 Aug 2020 15:24:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42538)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k3lNn-0003pe-Vf
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 15:16:55 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:52661
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k3lNl-0006OM-SG
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 15:16:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596741413;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5WIPWQa3/vbwLs70BJ9v/rXKDF6Elcew8UvMNUfoovA=;
 b=h7NlphrEkMRkywKShH97LI8PMAWvuXYMGYSrSNCaaJelc5FeCHherndTiMt3zA+ZaNyGWp
 VPtl5OVAZmUy7/cbaG+lqc5hl/xg3m8QKPtKbIxIQuBA9VE666M3eyIOrEJACRTaRNcQVO
 MnyBSMoUrDZ9+M5hK9ePbe6Dx2vQBjo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-205-N0ooJQ_xMvK0Ux3SANRVbA-1; Thu, 06 Aug 2020 15:16:50 -0400
X-MC-Unique: N0ooJQ_xMvK0Ux3SANRVbA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 76B4919200C2
 for <qemu-devel@nongnu.org>; Thu,  6 Aug 2020 19:16:49 +0000 (UTC)
Received: from 640k.localdomain.com (unknown [10.36.110.10])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 888185FC3B;
 Thu,  6 Aug 2020 19:16:48 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 015/143] build-sys: add meson submodule
Date: Thu,  6 Aug 2020 21:14:11 +0200
Message-Id: <1596741379-12902-16-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1596741379-12902-1-git-send-email-pbonzini@redhat.com>
References: <1596741379-12902-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/06 05:03:13
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
 .gitmodules               |  3 +++
 configure                 | 44 +++++++++++++++++++++++++++++++++++++++++---
 meson                     |  1 +
 scripts/archive-source.sh |  3 ++-
 4 files changed, 47 insertions(+), 4 deletions(-)
 create mode 160000 meson

diff --git a/.gitmodules b/.gitmodules
index 9c0501a..ce97939 100644
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
index 13db149..d87d544 100755
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
@@ -1965,9 +1984,28 @@ then
     error_exit "Python not found. Use --python=/path/to/python"
 fi
 
-if ! has "$meson"
-then
-    error_exit "Meson not found. Use --meson=/path/to/meson"
+if test -z "$meson" ; then
+    if has meson && version_ge "$(meson --version)" 0.55.0; then
+        meson=meson
+    elif test -e "${source_path}/.git" && test $git_update = 'yes' ; then
+        meson=git
+    elif test -e "${source_path}/meson/meson.py" ; then
+        meson=internal
+    fi
+fi
+
+case "$meson" in
+    git | internal)
+        if test "$meson" = git; then
+            git_submodules="${git_submodules} meson"
+            (cd "${source_path}" && GIT="$git" "./scripts/git-submodule.sh" update meson)
+        fi
+        meson="${source_path}/meson/meson.py"
+        ;;
+esac
+
+if ! has "$meson" ; then
+    error_exit "Meson not found. Use --meson=/path/to/meson|git|internal"
 fi
 meson=$(command -v $meson)
 
diff --git a/meson b/meson
new file mode 160000
index 0000000..d0c68dc
--- /dev/null
+++ b/meson
@@ -0,0 +1 @@
+Subproject commit d0c68dc11507a47b9b85de508e023d9590d60565
diff --git a/scripts/archive-source.sh b/scripts/archive-source.sh
index fb5d6b3..c6169db 100755
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
1.8.3.1



