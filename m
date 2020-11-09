Return-Path: <SRS0=6joO=EP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B7EEC56201
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 13:41:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 979552068D
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 13:41:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F99VY0dk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 979552068D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57868 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kc7QN-0006cF-Io
	for qemu-devel@archiver.kernel.org; Mon, 09 Nov 2020 08:41:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58926)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kc7OV-0004rC-TN
 for qemu-devel@nongnu.org; Mon, 09 Nov 2020 08:39:39 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:21839)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kc7OS-0000ht-Lh
 for qemu-devel@nongnu.org; Mon, 09 Nov 2020 08:39:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604929175;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2CZ8yQvg+xOXbKZkzH788ZtdLmpBFxm4fzdsBms74W4=;
 b=F99VY0dkVD6WLFD7ddCd13TxBKJekM0w6QoBEn9zsO4e2oln8Y6iXIl0cvJKpGIpypARf0
 QRwV8UJdX1HiluHs7u+xKBK7nWcI4uoPsKlX0Y9SkuaOYatGIwKUEDVGQ+Icvqbb7Hj0rS
 JQAyNi3yLjOHGCJEEyK+zzF+6P1lIQU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-340-_SG1m1LNNxWqg3_vvL0Upg-1; Mon, 09 Nov 2020 08:39:34 -0500
X-MC-Unique: _SG1m1LNNxWqg3_vvL0Upg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 39329800683
 for <qemu-devel@nongnu.org>; Mon,  9 Nov 2020 13:39:33 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DFB2D6EF40;
 Mon,  9 Nov 2020 13:39:32 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 2/6] qemu-option: pass QemuOptsList to opts_accepts_any
Date: Mon,  9 Nov 2020 08:39:27 -0500
Message-Id: <20201109133931.979563-3-pbonzini@redhat.com>
In-Reply-To: <20201109133931.979563-1-pbonzini@redhat.com>
References: <20201109133931.979563-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=63.128.21.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/09 01:25:23
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
Cc: armbru@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

A QemuOptsList can be of one of two kinds: either it is pre-validated, or
it accepts any key and validation happens somewhere else (typically in
a Visitor or against a list of QOM properties).  opts_accepts_any
returns true if a QemuOpts instance was created from a QemuOptsList of
the latter kind, but there is no function to do the check on a QemuOptsList.

We will need it in the next patch; since almost all callers of
opts_accepts_any use opts->list anyway, simply repurpose it instead
of adding a new function.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 util/qemu-option.c | 23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/util/qemu-option.c b/util/qemu-option.c
index ab3b58599e..59be4f9d21 100644
--- a/util/qemu-option.c
+++ b/util/qemu-option.c
@@ -460,16 +460,16 @@ static bool qemu_opt_parse(QemuOpt *opt, Error **errp)
     }
 }
 
-static bool opts_accepts_any(const QemuOpts *opts)
+static bool opts_accepts_any(const QemuOptsList *list)
 {
-    return opts->list->desc[0].name == NULL;
+    return list->desc[0].name == NULL;
 }
 
 int qemu_opt_unset(QemuOpts *opts, const char *name)
 {
     QemuOpt *opt = qemu_opt_find(opts, name);
 
-    assert(opts_accepts_any(opts));
+    assert(opts_accepts_any(opts->list));
 
     if (opt == NULL) {
         return -1;
@@ -500,9 +500,10 @@ static bool opt_validate(QemuOpt *opt, bool *help_wanted,
                          Error **errp)
 {
     const QemuOptDesc *desc;
+    const QemuOptsList *list = opt->opts->list;
 
-    desc = find_desc_by_name(opt->opts->list->desc, opt->name);
-    if (!desc && !opts_accepts_any(opt->opts)) {
+    desc = find_desc_by_name(list->desc, opt->name);
+    if (!desc && !opts_accepts_any(list)) {
         error_setg(errp, QERR_INVALID_PARAMETER, opt->name);
         if (help_wanted && is_help_option(opt->name)) {
             *help_wanted = true;
@@ -535,9 +536,10 @@ bool qemu_opt_set_bool(QemuOpts *opts, const char *name, bool val,
 {
     QemuOpt *opt;
     const QemuOptDesc *desc;
+    const QemuOptsList *list = opts->list;
 
-    desc = find_desc_by_name(opts->list->desc, name);
-    if (!desc && !opts_accepts_any(opts)) {
+    desc = find_desc_by_name(list->desc, name);
+    if (!desc && !opts_accepts_any(list)) {
         error_setg(errp, QERR_INVALID_PARAMETER, name);
         return false;
     }
@@ -557,9 +559,10 @@ bool qemu_opt_set_number(QemuOpts *opts, const char *name, int64_t val,
 {
     QemuOpt *opt;
     const QemuOptDesc *desc;
+    const QemuOptsList *list = opts->list;
 
-    desc = find_desc_by_name(opts->list->desc, name);
-    if (!desc && !opts_accepts_any(opts)) {
+    desc = find_desc_by_name(list->desc, name);
+    if (!desc && !opts_accepts_any(list)) {
         error_setg(errp, QERR_INVALID_PARAMETER, name);
         return false;
     }
@@ -1110,7 +1113,7 @@ bool qemu_opts_validate(QemuOpts *opts, const QemuOptDesc *desc, Error **errp)
 {
     QemuOpt *opt;
 
-    assert(opts_accepts_any(opts));
+    assert(opts_accepts_any(opts->list));
 
     QTAILQ_FOREACH(opt, &opts->head, next) {
         opt->desc = find_desc_by_name(desc, opt->name);
-- 
2.26.2



