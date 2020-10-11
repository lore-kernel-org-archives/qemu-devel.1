Return-Path: <SRS0=+Fwv=DS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1362DC433DF
	for <qemu-devel@archiver.kernel.org>; Sun, 11 Oct 2020 20:41:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A91CA207FB
	for <qemu-devel@archiver.kernel.org>; Sun, 11 Oct 2020 20:41:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NfInWK1b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A91CA207FB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40070 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kRi9k-0000hZ-QU
	for qemu-devel@archiver.kernel.org; Sun, 11 Oct 2020 16:41:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57660)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1kRi5b-0001sq-L6
 for qemu-devel@nongnu.org; Sun, 11 Oct 2020 16:37:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:54990)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1kRi5Z-0005Xk-Vl
 for qemu-devel@nongnu.org; Sun, 11 Oct 2020 16:37:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602448624;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=69CoiKyBWo9QUtUgrmlNSSXEFQ/HwyM1UPy3Ni4+k5o=;
 b=NfInWK1bam9QojfNajg3sJMDbKwHKUwr6lo6I/EvbaK2X8e8zWIa9ouurNPSad0ZHaDZ8s
 ZxT+R35i+PMeqkM79AQK9ZBM4bBjEXbgPJyH9NMiSsRIjEgffFWWgPdJ5Vqpkno4A5XT0S
 LGwGWh40P4rM2smraTo9Q0J4cAkT3uA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-318-6spTaWbmOBi5GRZj5l5xsw-1; Sun, 11 Oct 2020 16:37:01 -0400
X-MC-Unique: 6spTaWbmOBi5GRZj5l5xsw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E3F4B107ACF5
 for <qemu-devel@nongnu.org>; Sun, 11 Oct 2020 20:37:00 +0000 (UTC)
Received: from localhost (unknown [10.36.110.19])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4C5097512E;
 Sun, 11 Oct 2020 20:36:53 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Subject: [PoCv2 10/15] qga/rust: build Rust types
Date: Mon, 12 Oct 2020 00:35:08 +0400
Message-Id: <20201011203513.1621355-11-marcandre.lureau@redhat.com>
In-Reply-To: <20201011203513.1621355-1-marcandre.lureau@redhat.com>
References: <20201011203513.1621355-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=marcandre.lureau@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/11 16:23:51
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: pbonzini@redhat.com, berrange@redhat.com, armbru@redhat.com,
 stefanha@redhat.com,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 qga/lib.rs      | 1 +
 qga/meson.build | 1 +
 qga/qapi.rs     | 6 ++++++
 3 files changed, 8 insertions(+)
 create mode 100644 qga/qapi.rs

diff --git a/qga/lib.rs b/qga/lib.rs
index 050a47e2a3..bff4107569 100644
--- a/qga/lib.rs
+++ b/qga/lib.rs
@@ -1 +1,2 @@
+mod qapi;
 mod qapi_sys;
diff --git a/qga/meson.build b/qga/meson.build
index dbc8f1623b..aedbd07a04 100644
--- a/qga/meson.build
+++ b/qga/meson.build
@@ -49,6 +49,7 @@ qga_rs = declare_dependency()
 if with_rust
   qga_qapi_rs_outputs = [
     'qga-qapi-sys-types.rs',
+    'qga-qapi-types.rs',
   ]
 
   qapi_gen_rs_files = custom_target('QGA QAPI Rust bindings',
diff --git a/qga/qapi.rs b/qga/qapi.rs
new file mode 100644
index 0000000000..e4b9113300
--- /dev/null
+++ b/qga/qapi.rs
@@ -0,0 +1,6 @@
+#![allow(dead_code)]
+use common::*;
+
+new_ptr!();
+
+include!(concat!(env!("MESON_BUILD_ROOT"), "/qga/qga-qapi-types.rs"));
-- 
2.28.0


