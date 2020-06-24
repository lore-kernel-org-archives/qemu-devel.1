Return-Path: <SRS0=4Hnu=AF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C27EAC433E1
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 16:58:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 92DBC2084D
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 16:58:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MiGYBnxB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92DBC2084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38784 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jo8il-0002ZQ-OW
	for qemu-devel@archiver.kernel.org; Wed, 24 Jun 2020 12:57:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51878)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jo8VW-0003xw-8o
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 12:44:18 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:40538
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jo8VC-00057B-AR
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 12:44:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593017035;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DcMFzyziydokhsV9qoeTIXwl2E0ZmcUgxi57DQEIc78=;
 b=MiGYBnxBEzSkHUHMrqvyWStiw18FhdLD826Y9Tc0MfjQ4KgP/rY1psjFJvU2t/Csvvrz90
 HLAhoPLwxQKTpzSQrhO1vXDeR44Owvixx3wUc4tf7A9EkJM7TJvNgzUknUQF/Rm4nvbPXd
 q22pmQcLmDSiPa7yCcaYnVrRU/I7s/E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-259-xqiG_esPMcK7PNUIOxaG8A-1; Wed, 24 Jun 2020 12:43:51 -0400
X-MC-Unique: xqiG_esPMcK7PNUIOxaG8A-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8770418585B2;
 Wed, 24 Jun 2020 16:43:50 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-121.ams2.redhat.com
 [10.36.112.121])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 55C695C662;
 Wed, 24 Jun 2020 16:43:50 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 2BB171138481; Wed, 24 Jun 2020 18:43:45 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 20/46] block: Avoid error accumulation in bdrv_img_create()
Date: Wed, 24 Jun 2020 18:43:18 +0200
Message-Id: <20200624164344.3778251-21-armbru@redhat.com>
In-Reply-To: <20200624164344.3778251-1-armbru@redhat.com>
References: <20200624164344.3778251-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/24 01:59:40
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
 ehabkost@redhat.com, qemu-block@nongnu.org, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

When creating an image fails because the format doesn't support option
"backing_file" or "backing_fmt", bdrv_img_create() first has
qemu_opt_set() put a generic error into @local_err, then puts the real
error into @errp with error_setg(), and then propagates the former to
the latter, which throws away the generic error.  A bit complicated,
but works.

Not that qemu_opt_set() returns a useful value, we can simply ignore
the generic error instead.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 block.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/block.c b/block.c
index 93a5fbf60a..2dcf9afd61 100644
--- a/block.c
+++ b/block.c
@@ -6087,7 +6087,7 @@ void bdrv_img_create(const char *filename, const char *fmt,
 
     if (base_filename) {
         if (!qemu_opt_set(opts, BLOCK_OPT_BACKING_FILE, base_filename,
-                          &local_err)) {
+                          NULL)) {
             error_setg(errp, "Backing file not supported for file format '%s'",
                        fmt);
             goto out;
@@ -6095,7 +6095,7 @@ void bdrv_img_create(const char *filename, const char *fmt,
     }
 
     if (base_fmt) {
-        if (!qemu_opt_set(opts, BLOCK_OPT_BACKING_FMT, base_fmt, &local_err)) {
+        if (!qemu_opt_set(opts, BLOCK_OPT_BACKING_FMT, base_fmt, NULL)) {
             error_setg(errp, "Backing file format not supported for file "
                              "format '%s'", fmt);
             goto out;
-- 
2.26.2


