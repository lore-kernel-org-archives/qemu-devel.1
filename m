Return-Path: <SRS0=UzyQ=DA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C575C2D0A8
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 09:29:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A61AD2137B
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 09:29:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K0ZbUfwd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A61AD2137B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47338 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kL15a-0006YK-PW
	for qemu-devel@archiver.kernel.org; Wed, 23 Sep 2020 05:29:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57314)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kL12n-0002cR-F0
 for qemu-devel@nongnu.org; Wed, 23 Sep 2020 05:26:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:43791)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kL12f-0004YY-UY
 for qemu-devel@nongnu.org; Wed, 23 Sep 2020 05:26:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600853185;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4M1byqklBkCEe+ean50U/60cDUM1sFdV+S1+041K3nQ=;
 b=K0ZbUfwd8KpTdRZXq6P+VRGTKiNAopOQj3dVW97w0U19VhFySOye5zEPu50S0JbvAOjRQa
 +NNNaTxAkWSCTEUcbKu65X4VQNPGafiKfs/61FGxjk3fy5VL+FCE41Vir2P31wqHA26Xju
 PMEZ7OoOAmpMEXkKv8vVtGZxDA9Yi4c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-85-GIJXpJNlPRi6sh3w5QHpLA-1; Wed, 23 Sep 2020 05:26:21 -0400
X-MC-Unique: GIJXpJNlPRi6sh3w5QHpLA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 797D5104D3E2;
 Wed, 23 Sep 2020 09:26:20 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 373DB60BF1;
 Wed, 23 Sep 2020 09:26:20 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 4/4] configure: consistently pass CFLAGS/CXXFLAGS/LDFLAGS
 to meson
Date: Wed, 23 Sep 2020 05:26:17 -0400
Message-Id: <20200923092617.1593722-5-pbonzini@redhat.com>
In-Reply-To: <20200923092617.1593722-1-pbonzini@redhat.com>
References: <20200923092617.1593722-1-pbonzini@redhat.com>
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
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.455,
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

Environment variables like CFLAGS are easy to accidentally change.  Meson
warns if that happens, but in a project with a lot of configuration that
is easy to lose.  It is also surprising behavior since meson caches -D
options and remembers those on reconfiguration (which we rely on,
since configure options become -D options).

By placing the user-provided CFLAGS, CXXFLAGS and LDFLAGS in the
cross file, we at least get consistent behavior.  These environment
variables are still ugly and not really recommended, but there are
distros that rely on them.  For the gory details, refer to
https://github.com/mesonbuild/meson/issues/4664.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 configure   | 25 +++++++++++++++----------
 meson.build | 14 ++++++++++++--
 2 files changed, 27 insertions(+), 12 deletions(-)

diff --git a/configure b/configure
index d68a33e3c7..c2aa1885c3 100755
--- a/configure
+++ b/configure
@@ -7798,24 +7798,29 @@ echo "export PYTHON='$python'" >> "$iotests_common_env"
 if test "$skip_meson" = no; then
 cross="config-meson.cross.new"
 meson_quote() {
-    echo "['$(echo $* | sed "s/ /','/g")']"
+    echo "'$(echo $* | sed "s/ /','/g")'"
 }
 
 echo "# Automatically generated by configure - do not modify" > $cross
 echo "[properties]" >> $cross
 test -z "$cxx" && echo "link_language = 'c'" >> $cross
+echo "[built-in options]" >> $cross
+echo "c_args = [${CFLAGS:+$(meson_quote $CFLAGS)}]" >> $cross
+echo "cpp_args = [${CXXFLAGS:+$(meson_quote $CXXFLAGS)}]" >> $cross
+echo "c_link_args = [${LDFLAGS:+$(meson_quote $LDFLAGS)}]" >> $cross
+echo "cpp_link_args = [${LDFLAGS:+$(meson_quote $LDFLAGS)}]" >> $cross
 echo "[binaries]" >> $cross
-echo "c = $(meson_quote $cc)" >> $cross
-test -n "$cxx" && echo "cpp = $(meson_quote $cxx)" >> $cross
-echo "ar = $(meson_quote $ar)" >> $cross
-echo "nm = $(meson_quote $nm)" >> $cross
-echo "pkgconfig = $(meson_quote $pkg_config_exe)" >> $cross
-echo "ranlib = $(meson_quote $ranlib)" >> $cross
+echo "c = [$(meson_quote $cc)]" >> $cross
+test -n "$cxx" && echo "cpp = [$(meson_quote $cxx)]" >> $cross
+echo "ar = [$(meson_quote $ar)]" >> $cross
+echo "nm = [$(meson_quote $nm)]" >> $cross
+echo "pkgconfig = [$(meson_quote $pkg_config_exe)]" >> $cross
+echo "ranlib = [$(meson_quote $ranlib)]" >> $cross
 if has $sdl2_config; then
-  echo "sdl2-config = $(meson_quote $sdl2_config)" >> $cross
+  echo "sdl2-config = [$(meson_quote $sdl2_config)]" >> $cross
 fi
-echo "strip = $(meson_quote $strip)" >> $cross
-echo "windres = $(meson_quote $windres)" >> $cross
+echo "strip = [$(meson_quote $strip)]" >> $cross
+echo "windres = [$(meson_quote $windres)]" >> $cross
 if test -n "$cross_prefix"; then
     cross_arg="--cross-file config-meson.cross"
     echo "[host_machine]" >> $cross
diff --git a/meson.build b/meson.build
index cb0113ee90..4c73f4093a 100644
--- a/meson.build
+++ b/meson.build
@@ -1471,8 +1471,18 @@ if targetos == 'darwin'
   summary_info += {'Objective-C compiler': meson.get_compiler('objc').cmd_array()[0]}
 endif
 summary_info += {'ARFLAGS':           config_host['ARFLAGS']}
-summary_info += {'CFLAGS':            '-O' + get_option('optimization')
-                                           + (get_option('debug') ? ' -g' : '')}
+summary_info += {'CFLAGS':            ' '.join(get_option('c_args')
+                                               + ['-O' + get_option('optimization')]
+                                               + (get_option('debug') ? ['-g'] : []))}
+if link_language == 'cpp'
+  summary_info += {'CXXFLAGS':        ' '.join(get_option('cpp_args')
+                                               + ['-O' + get_option('optimization')]
+                                               + (get_option('debug') ? ['-g'] : []))}
+endif
+link_args = get_option(link_language + '_link_args')
+if link_args.length() > 0
+  summary_info += {'LDFLAGS':         ' '.join(link_args)}
+endif
 summary_info += {'QEMU_CFLAGS':       config_host['QEMU_CFLAGS']}
 summary_info += {'QEMU_LDFLAGS':      config_host['QEMU_LDFLAGS']}
 summary_info += {'make':              config_host['MAKE']}
-- 
2.26.2


