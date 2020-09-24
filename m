Return-Path: <SRS0=QZTr=DB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BFFFC4363D
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 10:16:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F075223600
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 10:16:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DhxP+TNh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F075223600
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41874 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLOIB-0001tc-Qz
	for qemu-devel@archiver.kernel.org; Thu, 24 Sep 2020 06:15:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39338)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kLNU4-0001p5-VT
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 05:24:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:45902)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kLNU0-00068s-JY
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 05:24:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600939447;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ePBDsxuwy2/CAn6zK7MxY8WVOmUABshE8nLPlwXqj18=;
 b=DhxP+TNh6ZkDR7rb3gH2h/NF1yx/bCW6hsRtZl7KMaRypbZ/c2j37rjejkZJaqiWU4O4h5
 kDs0ULakwCT6L2nmsbhQmFriTefOe36rgCRZKBBxPSfogt1xCg5WvhdAyaX6adiSG67M0g
 /9xIXIl0VqzzhoKfebhlTKDpH3GIC9Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-437-oaK21n4PN_2Mn0amIK-7vQ-1; Thu, 24 Sep 2020 05:24:04 -0400
X-MC-Unique: oaK21n4PN_2Mn0amIK-7vQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 069F11891E80;
 Thu, 24 Sep 2020 09:24:03 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B96CC60CCC;
 Thu, 24 Sep 2020 09:24:02 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 60/92] configure: cleanup CFLAGS and LDFLAGS for submodules
Date: Thu, 24 Sep 2020 05:22:42 -0400
Message-Id: <20200924092314.1722645-61-pbonzini@redhat.com>
In-Reply-To: <20200924092314.1722645-1-pbonzini@redhat.com>
References: <20200924092314.1722645-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/22 23:02:20
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.228,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Richard Henderson <richard.henderson@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The -g and -O2 flags that configure adds to CFLAGS are only used by submodules,
so do not put anymore the confusing CFLAGS variable in config-host.mak and
replace it with more explicit SUBMODULE_CFLAGS variable.

There was also no equivalent SUBMODULE_LDFLAGS variable, add it.  This would
theoretically help with LTO if we want -g and -O2 options on the command line.
I say "theoretically" because submodules should not be linking anything; but
since we were passing an "LD" variable we might as well get its flags right.

CFLAGS are now synthesized in the configuration summary as a quick way to present
--enable-debug and --enable-debug-info.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 Makefile    |  1 -
 configure   | 20 ++++++++++++++++----
 meson.build |  3 ++-
 3 files changed, 18 insertions(+), 6 deletions(-)

diff --git a/Makefile b/Makefile
index f83226e0e1..61ab93f05a 100644
--- a/Makefile
+++ b/Makefile
@@ -137,7 +137,6 @@ configure: ;
 .PHONY: all clean distclean install \
 	recurse-all dist msi FORCE
 
-SUBMODULE_CFLAGS = $(QEMU_CFLAGS) $(CFLAGS)
 SUBDIR_MAKEFLAGS = $(if $(V),,--no-print-directory --quiet)
 SUBDIR_HOST_VARS = 							\
 	PKG_CONFIG="$(PKG_CONFIG)" 					\
diff --git a/configure b/configure
index ac0dfdfac5..9b7232f9d2 100755
--- a/configure
+++ b/configure
@@ -6112,12 +6112,23 @@ elif test "$fortify_source" = "yes" ; then
   QEMU_CFLAGS="-U_FORTIFY_SOURCE -D_FORTIFY_SOURCE=2 $QEMU_CFLAGS"
   debug=no
 fi
+
+SUBMODULE_CFLAGS=-Wall
+SUBMODULE_LDFLAGS=
+if test "$pie" = "yes"; then
+  SUBMODULE_CFLAGS="$SUBMODULE_CFLAGS -fPIE"
+  SUBMODULE_LDFLAGS="$SUBMODULE_LDFLAGS -pie"
+else
+  SUBMODULE_CFLAGS="$SUBMODULE_CFLAGS $CFLAGS_NOPIE"
+  SUBMODULE_LDFLAGS="$SUBMODULE_LDFLAGS $LDFLAGS_NOPIE"
+fi
 if test "$debug_info" = "yes"; then
-  CFLAGS="-g $CFLAGS"
-  LDFLAGS="-g $LDFLAGS"
+  SUBMODULE_CFLAGS="$SUBMODULE_CFLAGS -g"
+  SUBMODULE_LDFLAGS="$SUBMODULE_LDFLAGS -g"
 fi
 if test "$debug" = "no"; then
-  CFLAGS="-O2 $CFLAGS"
+  SUBMODULE_CFLAGS="$SUBMODULE_CFLAGS -O2"
+  SUBMODULE_LDFLAGS="$SUBMODULE_LDFLAGS -O2"
 fi
 
 case "$ARCH" in
@@ -7292,7 +7303,8 @@ echo "RANLIB=$ranlib" >> $config_host_mak
 echo "NM=$nm" >> $config_host_mak
 echo "PKG_CONFIG=$pkg_config_exe" >> $config_host_mak
 echo "WINDRES=$windres" >> $config_host_mak
-echo "CFLAGS=$CFLAGS" >> $config_host_mak
+echo "SUBMODULE_CFLAGS=$CFLAGS \$(QEMU_CFLAGS) $SUBMODULE_CFLAGS" >> $config_host_mak
+echo "SUBMODULE_LDFLAGS=$LDFLAGS \$(QEMU_LDFLAGS) $SUBMODULE_LDFLAGS" >> $config_host_mak
 echo "CFLAGS_NOPIE=$CFLAGS_NOPIE" >> $config_host_mak
 echo "QEMU_CFLAGS=$QEMU_CFLAGS" >> $config_host_mak
 echo "QEMU_CXXFLAGS=$QEMU_CXXFLAGS" >> $config_host_mak
diff --git a/meson.build b/meson.build
index 9aeefa60fb..cb0113ee90 100644
--- a/meson.build
+++ b/meson.build
@@ -1471,7 +1471,8 @@ if targetos == 'darwin'
   summary_info += {'Objective-C compiler': meson.get_compiler('objc').cmd_array()[0]}
 endif
 summary_info += {'ARFLAGS':           config_host['ARFLAGS']}
-summary_info += {'CFLAGS':            config_host['CFLAGS']}
+summary_info += {'CFLAGS':            '-O' + get_option('optimization')
+                                           + (get_option('debug') ? ' -g' : '')}
 summary_info += {'QEMU_CFLAGS':       config_host['QEMU_CFLAGS']}
 summary_info += {'QEMU_LDFLAGS':      config_host['QEMU_LDFLAGS']}
 summary_info += {'make':              config_host['MAKE']}
-- 
2.26.2



