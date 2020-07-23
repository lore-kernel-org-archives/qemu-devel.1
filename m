Return-Path: <SRS0=cpkI=BC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B91FFC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 17:50:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 858A32065F
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 17:50:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h+0KgDzX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 858A32065F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54134 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyfMI-0002Va-PT
	for qemu-devel@archiver.kernel.org; Thu, 23 Jul 2020 13:50:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43426)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dinechin@redhat.com>)
 id 1jyfJ3-0005Kq-7x
 for qemu-devel@nongnu.org; Thu, 23 Jul 2020 13:46:57 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:21639
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dinechin@redhat.com>)
 id 1jyfJ1-0004Bc-Dr
 for qemu-devel@nongnu.org; Thu, 23 Jul 2020 13:46:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595526414;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Vh5y6IxFHd1mghC1947BBUvp4rrSDNgO8cJkedJIYaE=;
 b=h+0KgDzXtJi2Vo8l+NCfDFvUuCNWGSjAIjtZjuCR2KlAhFhLeHQY61ggorgsVuY1FX05To
 +sMVUEAf36MrLsaH3EWWfykybfGbPIJdXt9Kw0JdcKlpQgUH9H63d9YhkqgWXIYdvV3K5D
 3wRV75ROm5PDGeldNC5z2w1PBlsAFv0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-76-yUFXwX8qMN6cqWRTQ9Qgug-1; Thu, 23 Jul 2020 13:46:50 -0400
X-MC-Unique: yUFXwX8qMN6cqWRTQ9Qgug-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C86C480183C;
 Thu, 23 Jul 2020 17:46:49 +0000 (UTC)
Received: from turbo.com (ovpn-113-141.ams2.redhat.com [10.36.113.141])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4071E69316;
 Thu, 23 Jul 2020 17:46:36 +0000 (UTC)
From: Christophe de Dinechin <dinechin@redhat.com>
To: qemu-devel@nongnu.org,
	kraxel@redhat.com
Subject: [PATCH 2/7] build: fix device module builds
Date: Thu, 23 Jul 2020 19:46:10 +0200
Message-Id: <20200723174615.2370096-3-dinechin@redhat.com>
In-Reply-To: <20200723174615.2370096-1-dinechin@redhat.com>
References: <20200723174615.2370096-1-dinechin@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=dinechin@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=dinechin@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/23 06:04:25
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
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
Cc: Eduardo Habkost <ehabkost@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Gerd Hoffmann <kraxel@redhat.com>

See comment.  Feels quite hackish.  Better ideas anyone?

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Signed-off-by: Christophe de Dinechin <dinechin@redhat.com>
---
 dtc           | 2 +-
 roms/SLOF     | 2 +-
 roms/openbios | 2 +-
 roms/opensbi  | 2 +-
 roms/seabios  | 2 +-
 slirp         | 2 +-
 6 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/dtc b/dtc
index 85e5d83984..88f18909db 160000
--- a/dtc
+++ b/dtc
@@ -1 +1 @@
-Subproject commit 85e5d839847af54efab170f2b1331b2a6421e647
+Subproject commit 88f18909db731a627456f26d779445f84e449536
diff --git a/roms/SLOF b/roms/SLOF
index e18ddad851..9546892a80 160000
--- a/roms/SLOF
+++ b/roms/SLOF
@@ -1 +1 @@
-Subproject commit e18ddad8516ff2cfe36ec130200318f7251aa78c
+Subproject commit 9546892a80d5a4c73deea6719de46372f007f4a6
diff --git a/roms/openbios b/roms/openbios
index 75fbb41d28..7e5b89e429 160000
--- a/roms/openbios
+++ b/roms/openbios
@@ -1 +1 @@
-Subproject commit 75fbb41d2857d93208c74a8e0228b29fd7bf04c0
+Subproject commit 7e5b89e4295063d8eba55b9c8ce8bc681c2d129a
diff --git a/roms/opensbi b/roms/opensbi
index 9f1b72ce66..be92da280d 160000
--- a/roms/opensbi
+++ b/roms/opensbi
@@ -1 +1 @@
-Subproject commit 9f1b72ce66d659e91013b358939e832fb27223f5
+Subproject commit be92da280d87c38a2e0adc5d3f43bab7b5468f09
diff --git a/roms/seabios b/roms/seabios
index 88ab0c1552..f21b5a4aeb 160000
--- a/roms/seabios
+++ b/roms/seabios
@@ -1 +1 @@
-Subproject commit 88ab0c15525ced2eefe39220742efe4769089ad8
+Subproject commit f21b5a4aeb020f2a5e2c6503f906a9349dd2f069
diff --git a/slirp b/slirp
index 2faae0f778..126c04acba 160000
--- a/slirp
+++ b/slirp
@@ -1 +1 @@
-Subproject commit 2faae0f778f818fadc873308f983289df697eb93
+Subproject commit 126c04acbabd7ad32c2b018fe10dfac2a3bc1210
-- 
2.26.2


