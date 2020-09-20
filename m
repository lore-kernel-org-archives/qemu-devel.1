Return-Path: <SRS0=9ZvH=C5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BAB4C43465
	for <qemu-devel@archiver.kernel.org>; Sun, 20 Sep 2020 09:31:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E3BC820EDD
	for <qemu-devel@archiver.kernel.org>; Sun, 20 Sep 2020 09:31:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fy5CsPSD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3BC820EDD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42496 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJvhM-0000Jo-Vp
	for qemu-devel@archiver.kernel.org; Sun, 20 Sep 2020 05:31:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55810)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kJvfu-00072i-AI
 for qemu-devel@nongnu.org; Sun, 20 Sep 2020 05:30:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:34370)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kJvfs-0002l1-DW
 for qemu-devel@nongnu.org; Sun, 20 Sep 2020 05:30:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600594223;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LHBJDxC5tsf8NwakBt/hHSljlYUWYdVMRcAk6Ejn8bU=;
 b=fy5CsPSDlRtLvg2FjdwBQO7nHek437F7Ia2IJb53X1s/MgDb2kSOoqbw/OyuO2jNKWaZnN
 ZUm+mpWgphUCyZvzB05yHvTAZjDfl2fWWgE6JUua8l3aGZvkDqSYtp9tGJ7bZ929u6BbiQ
 9aYN6+doe6SScmzLJhUPzQ2b3/e/98w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-395--gmcDuq6NY-SqaugJ090qQ-1; Sun, 20 Sep 2020 05:30:19 -0400
X-MC-Unique: -gmcDuq6NY-SqaugJ090qQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 94B6E8030C7
 for <qemu-devel@nongnu.org>; Sun, 20 Sep 2020 09:30:18 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 617B7100164C
 for <qemu-devel@nongnu.org>; Sun, 20 Sep 2020 09:30:18 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 4/4] configure: consistently pass CFLAGS/CXXFLAGS/LDFLAGS to
 meson
Date: Sun, 20 Sep 2020 05:30:16 -0400
Message-Id: <20200920093016.1150346-5-pbonzini@redhat.com>
In-Reply-To: <20200920093016.1150346-1-pbonzini@redhat.com>
References: <20200920093016.1150346-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/20 03:58:12
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
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

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 configure   |  4 ++++
 meson.build | 14 ++++++++++++--
 2 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/configure b/configure
index 9a0bbd2a69..952a7479ab 100755
--- a/configure
+++ b/configure
@@ -7794,6 +7794,10 @@ meson_quote() {
 echo "# Automatically generated by configure - do not modify" > $cross
 echo "[properties]" >> $cross
 test -z "$cxx" && echo "link_language = 'c'" >> $cross
+echo "c_args = $(meson_quote $CFLAGS)" >> $cross
+echo "cpp_args = $(meson_quote $CXXFLAGS)" >> $cross
+echo "c_link_args = $(meson_quote $LDFLAGS)" >> $cross
+echo "cpp_link_args = $(meson_quote $LDFLAGS)" >> $cross
 echo "[binaries]" >> $cross
 echo "c = $(meson_quote $cc)" >> $cross
 test -n "$cxx" && echo "cpp = $(meson_quote $cxx)" >> $cross
diff --git a/meson.build b/meson.build
index 1099f2a87c..4d6ef64adf 100644
--- a/meson.build
+++ b/meson.build
@@ -1476,8 +1476,18 @@ if targetos == 'darwin'
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


