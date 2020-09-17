Return-Path: <SRS0=BocF=C2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD5AAC43461
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 10:25:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3735720678
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 10:25:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eDpOqIxQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3735720678
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36404 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIr6j-0001Wg-CL
	for qemu-devel@archiver.kernel.org; Thu, 17 Sep 2020 06:25:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60948)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1kIqv4-0004Nz-B1
 for qemu-devel@nongnu.org; Thu, 17 Sep 2020 06:13:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:48915)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1kIquy-0003oj-N1
 for qemu-devel@nongnu.org; Thu, 17 Sep 2020 06:13:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600337610;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=p3r3lgt/EHi24STsRj5t7j4/Qr/OSFHY6s4pJhVjn+s=;
 b=eDpOqIxQDfeY6WemGdzstyFjfqEjSC1RWp3wN6H61Qc/zjLtY7WfIhOgRlyqwbL35J0z8o
 ERCGLGjwSNwt+uFLUmXBy/7dmpZIc11CUwjGGRy8b2uY+0DO9snCVaP3F/Ksye6IqjMQi3
 0QaTsTtuOrgfDGZjXBvOJ2fwJHN60kw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-121-A0mr6awGPbC-c0yXO-BUvg-1; Thu, 17 Sep 2020 06:13:29 -0400
X-MC-Unique: A0mr6awGPbC-c0yXO-BUvg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2086E18B9F4B
 for <qemu-devel@nongnu.org>; Thu, 17 Sep 2020 10:13:28 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-112-85.ams2.redhat.com
 [10.36.112.85])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 549FE60CC0;
 Thu, 17 Sep 2020 10:13:21 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 809829CBC; Thu, 17 Sep 2020 12:13:20 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 2/4] chardev/spice: make qemu_chr_open_spice_port static
Date: Thu, 17 Sep 2020 12:13:18 +0200
Message-Id: <20200917101320.25285-3-kraxel@redhat.com>
In-Reply-To: <20200917101320.25285-1-kraxel@redhat.com>
References: <20200917101320.25285-1-kraxel@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kraxel@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/17 02:01:40
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.999,
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 include/chardev/spice.h | 3 ---
 chardev/spice.c         | 8 ++++----
 2 files changed, 4 insertions(+), 7 deletions(-)

diff --git a/include/chardev/spice.h b/include/chardev/spice.h
index 99f26aedde54..1115502cdfbd 100644
--- a/include/chardev/spice.h
+++ b/include/chardev/spice.h
@@ -24,7 +24,4 @@ typedef struct SpiceChardev SpiceChardev;
 DECLARE_INSTANCE_CHECKER(SpiceChardev, SPICE_CHARDEV,
                          TYPE_CHARDEV_SPICE)
 
-void qemu_chr_open_spice_port(Chardev *chr, ChardevBackend *backend,
-                              bool *be_opened, Error **errp);
-
 #endif
diff --git a/chardev/spice.c b/chardev/spice.c
index bf7ea1e2940d..051c23a84f4c 100644
--- a/chardev/spice.c
+++ b/chardev/spice.c
@@ -296,10 +296,10 @@ static void qemu_chr_open_spice_vmc(Chardev *chr,
     chr_open(chr, type);
 }
 
-void qemu_chr_open_spice_port(Chardev *chr,
-                              ChardevBackend *backend,
-                              bool *be_opened,
-                              Error **errp)
+static void qemu_chr_open_spice_port(Chardev *chr,
+                                     ChardevBackend *backend,
+                                     bool *be_opened,
+                                     Error **errp)
 {
     ChardevSpicePort *spiceport = backend->u.spiceport.data;
     const char *name = spiceport->fqdn;
-- 
2.27.0


