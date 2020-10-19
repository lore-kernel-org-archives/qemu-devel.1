Return-Path: <SRS0=qJMs=D2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AB0FC433E7
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 11:44:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CC3E22177B
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 11:44:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GeuYlfg+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC3E22177B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54060 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUTaq-000281-QF
	for qemu-devel@archiver.kernel.org; Mon, 19 Oct 2020 07:44:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47456)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kUTXX-0007ob-Ta
 for qemu-devel@nongnu.org; Mon, 19 Oct 2020 07:41:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:26229)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kUTXR-0008G1-Ue
 for qemu-devel@nongnu.org; Mon, 19 Oct 2020 07:41:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603107673;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=imURWLYKJS+A51CJcY/PS/bBsr96bRuJgtDpMzjyaU4=;
 b=GeuYlfg+sO5hFccVP/Ce+cI9OJfku7tin0qYpr8dH9blvLwHFNhl2ASB5zVbLnAmXsCCXu
 +E5GoxzEAK6AgznL8qOmzs6Ao2xYLOyv+jetxK+i/ymaKjhTMm09EZGpEkMrJYCrtAg9U2
 IcENSArsuwNv22zUwteOvv4G2zFJSGE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-58-hjm_bP6ePjGMfc1Q1Q6GSg-1; Mon, 19 Oct 2020 07:41:10 -0400
X-MC-Unique: hjm_bP6ePjGMfc1Q1Q6GSg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 424259CC0D
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2020 11:41:09 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0F4555C1A3
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2020 11:41:09 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] meson: use b_staticpic=false for meson >=0.56.0
Date: Mon, 19 Oct 2020 07:41:08 -0400
Message-Id: <20201019114108.1779369-2-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=63.128.21.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/19 02:32:01
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

Meson 0.56.0 correctly builds non-PIC static libraries with -fPIE if
b_pie=true.  We do not have to pass b_staticpic=true if PIE is requested
if Meson is new-enough, which improves performance.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 configure   | 6 +++++-
 meson.build | 4 ++--
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/configure b/configure
index 7b0589a0c4..b7253b1b8e 100755
--- a/configure
+++ b/configure
@@ -6987,6 +6987,10 @@ fi
 mv $cross config-meson.cross
 
 rm -rf meson-private meson-info meson-logs
+unset staticpic
+if ! version_ge "$($meson --version)" 0.56.0; then
+  staticpic=$(if test "$pie" = yes; then echo true; else echo false; fi)
+fi
 NINJA=$ninja $meson setup \
         --prefix "$prefix" \
         --libdir "$libdir" \
@@ -7004,7 +7008,7 @@ NINJA=$ninja $meson setup \
         -Dwerror=$(if test "$werror" = yes; then echo true; else echo false; fi) \
         -Dstrip=$(if test "$strip_opt" = yes; then echo true; else echo false; fi) \
         -Db_pie=$(if test "$pie" = yes; then echo true; else echo false; fi) \
-        -Db_staticpic=$(if test "$pie" = yes; then echo true; else echo false; fi) \
+        ${staticpic:+-Db_staticpic=$staticpic} \
         -Db_coverage=$(if test "$gcov" = yes; then echo true; else echo false; fi) \
         -Dmalloc=$malloc -Dmalloc_trim=$malloc_trim -Dsparse=$sparse \
         -Dkvm=$kvm -Dhax=$hax -Dwhpx=$whpx -Dhvf=$hvf \
diff --git a/meson.build b/meson.build
index d1155aea65..88eb4a6b7a 100644
--- a/meson.build
+++ b/meson.build
@@ -1,6 +1,6 @@
 project('qemu', ['c'], meson_version: '>=0.55.0',
-        default_options: ['warning_level=1', 'c_std=gnu99', 'cpp_std=gnu++11',
-                          'b_colorout=auto'],
+        default_options: ['warning_level=1', 'c_std=gnu99', 'cpp_std=gnu++11', 'b_colorout=auto'] +
+                         (meson.version().version_compare('>=0.56.0') ? [ 'b_staticpic=false' ] : []),
         version: run_command('head', meson.source_root() / 'VERSION').stdout().strip())
 
 not_found = dependency('', required: false)
-- 
2.26.2


