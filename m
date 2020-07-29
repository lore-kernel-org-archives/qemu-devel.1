Return-Path: <SRS0=FCxk=BI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81A82C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2020 22:19:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 508DF20656
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2020 22:19:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ho444FRQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 508DF20656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37324 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0uPo-0003IX-Im
	for qemu-devel@archiver.kernel.org; Wed, 29 Jul 2020 18:19:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55552)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vgoyal@redhat.com>) id 1k0uLV-0003eh-KB
 for qemu-devel@nongnu.org; Wed, 29 Jul 2020 18:14:45 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:41367
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <vgoyal@redhat.com>) id 1k0uLS-0001B1-BE
 for qemu-devel@nongnu.org; Wed, 29 Jul 2020 18:14:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596060880;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jhjZBzKdUPWmQBoGYYNmaWrngqD0E272Oq6g881pzZA=;
 b=Ho444FRQkwAr264d9A0hYBt09+WzksEIw3DSNR5y+iZDns+Ad8ErFi3g4myqm2GVJU55gM
 nQ7mPcedSC63omr8g28jLv8WVlR/QJrhbGt7YlfaW9YWXoETd5CnyFjtI5XHu00hPq2Uef
 uCIZGTjyzrxaOQkJORtr/AFvhtXLNxs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-302-rQpeOYq-ObySeWVV-Vg0BA-1; Wed, 29 Jul 2020 18:14:38 -0400
X-MC-Unique: rQpeOYq-ObySeWVV-Vg0BA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0D5C959
 for <qemu-devel@nongnu.org>; Wed, 29 Jul 2020 22:14:38 +0000 (UTC)
Received: from horse.redhat.com (ovpn-116-149.rdu2.redhat.com [10.10.116.149])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4F9971DB;
 Wed, 29 Jul 2020 22:14:32 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
 id D090D223D08; Wed, 29 Jul 2020 18:14:31 -0400 (EDT)
From: Vivek Goyal <vgoyal@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 4/5] virtiofsd: Open lo->source while setting up root in
 sandbox=NONE mode
Date: Wed, 29 Jul 2020 18:14:09 -0400
Message-Id: <20200729221410.147556-5-vgoyal@redhat.com>
In-Reply-To: <20200729221410.147556-1-vgoyal@redhat.com>
References: <20200729221410.147556-1-vgoyal@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=vgoyal@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/29 09:18:45
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
Cc: berrange@redhat.com, vromanso@redhat.com, dgilbert@redhat.com,
 virtio-fs@redhat.com, stefanha@redhat.com, vgoyal@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

In sandbox=NONE mode, lo->source points to the directory which is being
exported. We have not done any chroot()/pivot_root(). So open lo->source.

Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
---
 tools/virtiofsd/passthrough_ll.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/virtiofsd/passthrough_ll.c b/tools/virtiofsd/passthrough_ll.c
index 76ef891105..a6fa816b6c 100644
--- a/tools/virtiofsd/passthrough_ll.c
+++ b/tools/virtiofsd/passthrough_ll.c
@@ -3209,7 +3209,10 @@ static void setup_root(struct lo_data *lo, struct lo_inode *root)
     int fd, res;
     struct stat stat;
 
-    fd = open("/", O_PATH);
+    if (lo->sandbox == SANDBOX_NONE)
+        fd = open(lo->source, O_PATH);
+    else
+        fd = open("/", O_PATH);
     if (fd == -1) {
         fuse_log(FUSE_LOG_ERR, "open(%s, O_PATH): %m\n", lo->source);
         exit(1);
-- 
2.25.4


