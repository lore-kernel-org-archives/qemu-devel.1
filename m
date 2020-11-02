Return-Path: <SRS0=N3Ri=EI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0BF1C388F2
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2020 16:23:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A584208B6
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2020 16:23:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q5YgaSjg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A584208B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57850 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZccK-0003o6-7y
	for qemu-devel@archiver.kernel.org; Mon, 02 Nov 2020 11:23:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41110)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kZcYm-0007aR-Ov
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 11:19:56 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:57711)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kZcYl-0007Yl-1f
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 11:19:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604333993;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tSs/fF2vJ+XmomqVGy1BSiw3GVKqorgi9TmtIO5OVsw=;
 b=Q5YgaSjgDd3gnTgedlKCcF+17RmmqOXf4Edw9/uIvWyf30gNSst3sn+lTaBjuTJT7/DP8w
 y2+BCu4EIPAHWlaa2HF9dWMnMBEiwjqixONzqSq5xnSpPL/dvN8ODnQXxJQ00Uu5a2+hCT
 z3baXk4yOoEl8uCg6AfvLSScKi7esio=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-428-ip8uuORHOImARpK-a4-Zuw-1; Mon, 02 Nov 2020 11:19:50 -0500
X-MC-Unique: ip8uuORHOImARpK-a4-Zuw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D9E1080EF8B
 for <qemu-devel@nongnu.org>; Mon,  2 Nov 2020 16:19:41 +0000 (UTC)
Received: from localhost (unknown [10.40.194.3])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 674B01E8;
 Mon,  2 Nov 2020 16:19:41 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 3/7] meson.build: Check for statx()
Date: Mon,  2 Nov 2020 17:18:55 +0100
Message-Id: <20201102161859.156603-4-mreitz@redhat.com>
In-Reply-To: <20201102161859.156603-1-mreitz@redhat.com>
References: <20201102161859.156603-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mreitz@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=63.128.21.124; envelope-from=mreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/02 03:02:24
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
Cc: Miklos Szeredi <mszeredi@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Max Reitz <mreitz@redhat.com>,
 virtio-fs@redhat.com, Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Check whether the glibc provides statx() and if so, define CONFIG_STATX.

Signed-off-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 meson.build | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/meson.build b/meson.build
index 47e32e1fcb..39ac5cf6d8 100644
--- a/meson.build
+++ b/meson.build
@@ -736,6 +736,21 @@ if not has_malloc_trim and get_option('malloc_trim').enabled()
   endif
 endif
 
+# Check whether the glibc provides statx()
+
+statx_test = '''
+  #ifndef _GNU_SOURCE
+  #define _GNU_SOURCE
+  #endif
+  #include <sys/stat.h>
+  int main(void) {
+    struct statx statxbuf;
+    statx(0, "", 0, STATX_BASIC_STATS, &statxbuf);
+    return 0;
+  }'''
+
+has_statx = cc.links(statx_test)
+
 #################
 # config-host.h #
 #################
@@ -768,6 +783,7 @@ config_host_data.set('CONFIG_XKBCOMMON', xkbcommon.found())
 config_host_data.set('CONFIG_KEYUTILS', keyutils.found())
 config_host_data.set('CONFIG_GETTID', has_gettid)
 config_host_data.set('CONFIG_MALLOC_TRIM', has_malloc_trim)
+config_host_data.set('CONFIG_STATX', has_statx)
 config_host_data.set('QEMU_VERSION', '"@0@"'.format(meson.project_version()))
 config_host_data.set('QEMU_VERSION_MAJOR', meson.project_version().split('.')[0])
 config_host_data.set('QEMU_VERSION_MINOR', meson.project_version().split('.')[1])
-- 
2.26.2


