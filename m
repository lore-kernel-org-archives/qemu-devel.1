Return-Path: <SRS0=ff1W=CL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NORMAL_HTTP_TO_IP,NUMERIC_HTTP_ADDR,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C51E8C433E7
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 13:13:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4823C20829
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 13:13:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BOC0fNh5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4823C20829
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54868 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDSZd-00082U-3P
	for qemu-devel@archiver.kernel.org; Wed, 02 Sep 2020 09:13:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37180)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kDSMs-0006ux-T4
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 09:00:02 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:32603
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kDSMn-0007Co-UJ
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 09:00:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599051597;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8h3AAHc1LO1DpZPMv2lF1h83yhx+jCG7f2kXp2CU/CY=;
 b=BOC0fNh5Mj1pipQtauP6y5D7cAlrVS6sxVSSVvKQlVLUQ2Imj66J+9bY9mC59zBpE7zPoF
 zkYOTjaInV+3HydcbuhtWlEa3vaCf1XgvV6h7B9BZ6ZjVHoknmIIfzgV2O34YK0FINyo5m
 35qHmRefK8E6785s+Pbwk9LE4YgBS3E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-450-7KLz2AjvOyiovvuwvczbtA-1; Wed, 02 Sep 2020 08:59:38 -0400
X-MC-Unique: 7KLz2AjvOyiovvuwvczbtA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EAB21107AD64
 for <qemu-devel@nongnu.org>; Wed,  2 Sep 2020 12:59:34 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B8E415D9CC
 for <qemu-devel@nongnu.org>; Wed,  2 Sep 2020 12:59:34 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 35/39] configure: do not look for install(1)
Date: Wed,  2 Sep 2020 08:59:13 -0400
Message-Id: <20200902125917.26021-36-pbonzini@redhat.com>
In-Reply-To: <20200902125917.26021-1-pbonzini@redhat.com>
References: <20200902125917.26021-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0.0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/02 02:26:30
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

It is not used anymore, so there is no Solaris-specific check to
perform.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 configure                   | 53 ++-----------------------------------
 docs/devel/build-system.rst |  4 ---
 meson.build                 |  1 -
 3 files changed, 2 insertions(+), 56 deletions(-)

diff --git a/configure b/configure
index adb5abe0c0..d148242c9a 100755
--- a/configure
+++ b/configure
@@ -174,36 +174,6 @@ has() {
     type "$1" >/dev/null 2>&1
 }
 
-# search for an executable in PATH
-path_of() {
-    local_command="$1"
-    local_ifs="$IFS"
-    local_dir=""
-
-    # pathname has a dir component?
-    if [ "${local_command#*/}" != "$local_command" ]; then
-        if [ -x "$local_command" ] && [ ! -d "$local_command" ]; then
-            echo "$local_command"
-            return 0
-        fi
-    fi
-    if [ -z "$local_command" ]; then
-        return 1
-    fi
-
-    IFS=:
-    for local_dir in $PATH; do
-        if [ -x "$local_dir/$local_command" ] && [ ! -d "$local_dir/$local_command" ]; then
-            echo "$local_dir/$local_command"
-            IFS="${local_ifs:-$(printf ' \t\n')}"
-            return 0
-        fi
-    done
-    # not found
-    IFS="${local_ifs:-$(printf ' \t\n')}"
-    return 1
-}
-
 version_ge () {
     local_ver1=`echo $1 | tr . ' '`
     local_ver2=`echo $2 | tr . ' '`
@@ -893,7 +863,6 @@ Darwin)
 SunOS)
   solaris="yes"
   make="${MAKE-gmake}"
-  install="${INSTALL-ginstall}"
   smbd="${SMBD-/usr/sfw/sbin/smbd}"
   if test -f /usr/include/sys/soundcard.h ; then
     audio_drv_list="oss try-sdl"
@@ -929,7 +898,7 @@ if [ "$bsd" = "yes" ] ; then
 fi
 
 : ${make=${MAKE-make}}
-: ${install=${INSTALL-install}}
+
 # We prefer python 3.x. A bare 'python' is traditionally
 # python 2.x, but some distros have it as python 3.x, so
 # we check that too
@@ -1016,7 +985,7 @@ for opt do
   ;;
   --make=*) make="$optarg"
   ;;
-  --install=*) install="$optarg"
+  --install=*)
   ;;
   --python=*) python="$optarg" ; explicit_python=yes
   ;;
@@ -1797,7 +1766,6 @@ Advanced options (experts only):
   --cross-cc-ARCH=CC       use compiler when building ARCH guest test cases
   --cross-cc-flags-ARCH=   use compiler flags when building ARCH guest tests
   --make=MAKE              use specified make [$make]
-  --install=INSTALL        use specified install [$install]
   --python=PYTHON          use specified python [$python]
   --sphinx-build=SPHINX    use specified sphinx-build [$sphinx_build]
   --meson=MESON            use specified meson [$meson]
@@ -2315,18 +2283,6 @@ fi
 # Solaris specific configure tool chain decisions
 
 if test "$solaris" = "yes" ; then
-  if has $install; then
-    :
-  else
-    error_exit "Solaris install program not found. Use --install=/usr/ucb/install or" \
-        "install fileutils from www.blastwave.org using pkg-get -i fileutils" \
-        "to get ginstall which is used by default (which lives in /opt/csw/bin)"
-  fi
-  if test "$(path_of $install)" = "/usr/sbin/install" ; then
-    error_exit "Solaris /usr/sbin/install is not an appropriate install program." \
-        "try ginstall from the GNU fileutils available from www.blastwave.org" \
-        "using pkg-get -i fileutils, or use --install=/usr/ucb/install"
-  fi
   if has ar; then
     :
   else
@@ -7433,11 +7389,6 @@ fi
 
 echo "ROMS=$roms" >> $config_host_mak
 echo "MAKE=$make" >> $config_host_mak
-echo "INSTALL=$install" >> $config_host_mak
-echo "INSTALL_DIR=$install -d -m 0755" >> $config_host_mak
-echo "INSTALL_DATA=$install -c -m 0644" >> $config_host_mak
-echo "INSTALL_PROG=$install -c -m 0755" >> $config_host_mak
-echo "INSTALL_LIB=$install -c -m 0644" >> $config_host_mak
 echo "PYTHON=$python" >> $config_host_mak
 echo "SPHINX_BUILD=$sphinx_build" >> $config_host_mak
 echo "GENISOIMAGE=$genisoimage" >> $config_host_mak
diff --git a/docs/devel/build-system.rst b/docs/devel/build-system.rst
index 55f0576c07..28492cfcae 100644
--- a/docs/devel/build-system.rst
+++ b/docs/devel/build-system.rst
@@ -136,10 +136,6 @@ developers in checking for system features:
    Determine if $COMMAND exists in the current environment, either as a
    shell builtin, or executable binary, returning 0 on success.
 
-`path_of $COMMAND`
-   Return the fully qualified path of $COMMAND, printing it to stdout,
-   and returning 0 on success.
-
 `check_define $NAME`
    Determine if the macro $NAME is defined by the system C compiler
 
diff --git a/meson.build b/meson.build
index 0452de8d0e..2455eb5e1a 100644
--- a/meson.build
+++ b/meson.build
@@ -1352,7 +1352,6 @@ summary_info += {'CFLAGS':            config_host['CFLAGS']}
 summary_info += {'QEMU_CFLAGS':       config_host['QEMU_CFLAGS']}
 summary_info += {'QEMU_LDFLAGS':      config_host['QEMU_LDFLAGS']}
 summary_info += {'make':              config_host['MAKE']}
-summary_info += {'install':           config_host['INSTALL']}
 summary_info += {'python':            '@0@ (version: @1@)'.format(python.full_path(), python.language_version())}
 summary_info += {'sphinx-build':      config_host['SPHINX_BUILD']}
 summary_info += {'genisoimage':       config_host['GENISOIMAGE']}
-- 
2.26.2



