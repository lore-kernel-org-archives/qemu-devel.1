Return-Path: <SRS0=h+Ky=AR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8B84C433E0
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 08:39:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 72390206E9
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 08:39:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i3aOwEhF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72390206E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47168 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jsMfI-0000RP-Ph
	for qemu-devel@archiver.kernel.org; Mon, 06 Jul 2020 04:39:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58942)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jsMI9-0005Dx-R0
 for qemu-devel@nongnu.org; Mon, 06 Jul 2020 04:15:57 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:32509
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jsMI7-0004QZ-Us
 for qemu-devel@nongnu.org; Mon, 06 Jul 2020 04:15:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594023355;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DyYFikS632kM2CsDInBLimabKZipHM6vAi6PUxEmLz4=;
 b=i3aOwEhFBiSd6uRirizao0gDFhVuMo27sWCd081mlCQEPezz9jJmgm5NeYhC6lzUjBuT0V
 412Mgx55/E6n6Chxkk6eUWMyztG2SvX0piC31E6d3svXU1zuuXQnjislkA2898joOr4yAI
 NOpTrlwfCQptuI03eOZmjGCQbVU5hEM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-416-Nf7XyeU7P2ydz1sg4fAvug-1; Mon, 06 Jul 2020 04:15:51 -0400
X-MC-Unique: Nf7XyeU7P2ydz1sg4fAvug-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7574C64AD2;
 Mon,  6 Jul 2020 08:15:50 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-143.ams2.redhat.com
 [10.36.112.143])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 41D105C1D4;
 Mon,  6 Jul 2020 08:15:50 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 8FC321132FDA; Mon,  6 Jul 2020 10:09:51 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 42/44] qemu-img: Ignore Error objects where the return
 value suffices
Date: Mon,  6 Jul 2020 10:09:48 +0200
Message-Id: <20200706080950.403087-43-armbru@redhat.com>
In-Reply-To: <20200706080950.403087-1-armbru@redhat.com>
References: <20200706080950.403087-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=armbru@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/06 01:22:37
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: peter.maydell@linaro.org, vsementsov@virtuozzo.com, berrange@redhat.com,
 ehabkost@redhat.com, qemu-block@nongnu.org, groug@kaod.org,
 pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 qemu-img.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/qemu-img.c b/qemu-img.c
index fc405ee171..a6af0eaf80 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -464,22 +464,18 @@ static int add_old_style_options(const char *fmt, QemuOpts *opts,
                                  const char *base_filename,
                                  const char *base_fmt)
 {
-    Error *err = NULL;
-
     if (base_filename) {
         if (!qemu_opt_set(opts, BLOCK_OPT_BACKING_FILE, base_filename,
-                          &err)) {
+                          NULL)) {
             error_report("Backing file not supported for file format '%s'",
                          fmt);
-            error_free(err);
             return -1;
         }
     }
     if (base_fmt) {
-        if (!qemu_opt_set(opts, BLOCK_OPT_BACKING_FMT, base_fmt, &err)) {
+        if (!qemu_opt_set(opts, BLOCK_OPT_BACKING_FMT, base_fmt, NULL)) {
             error_report("Backing file format not supported for file "
                          "format '%s'", fmt);
-            error_free(err);
             return -1;
         }
     }
-- 
2.26.2


