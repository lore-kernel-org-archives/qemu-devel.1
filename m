Return-Path: <SRS0=e3er=AV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FD20C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 13:32:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A63420578
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 13:32:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T0sSoQAC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A63420578
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57916 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtt8P-0001ho-7Z
	for qemu-devel@archiver.kernel.org; Fri, 10 Jul 2020 09:32:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54996)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jtt7U-0008U6-HY
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 09:31:16 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:57048
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jtt7S-0004we-R9
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 09:31:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594387874;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=I4+HnPP1f1tMMpNtpx9BGyQrgcXkarfb15T16l0lHrA=;
 b=T0sSoQACKQWqMuG9KwYDHmVF4+OFabtbGvvI+TJ1mY/1Na30oCib5u4NhXgQ/d/EcokI3z
 vwCFOd7phfYZGQ+DtckQforBYM80H2PfxYBDlzlSDrvXrY5v68K83W9FNPf2SjwaKYlZWD
 uk6A3FW8wwGnzUxiGFSOcg37qljYImQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-396-chrTTQL_O4G9mnewThrVvw-1; Fri, 10 Jul 2020 09:31:12 -0400
X-MC-Unique: chrTTQL_O4G9mnewThrVvw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 28D838027E4;
 Fri, 10 Jul 2020 13:31:11 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-143.ams2.redhat.com
 [10.36.112.143])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id ED07961982;
 Fri, 10 Jul 2020 13:31:04 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 7D56211328A3; Fri, 10 Jul 2020 15:31:03 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v2 43/53] qemu-img: Ignore Error objects where the return value
 suffices
Date: Fri, 10 Jul 2020 15:31:02 +0200
Message-Id: <20200710133103.2153250-4-armbru@redhat.com>
In-Reply-To: <20200710133103.2153250-1-armbru@redhat.com>
References: <20200710133103.2153250-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=armbru@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/10 04:36:30
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
Cc: peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Message-Id: <20200707160613.848843-44-armbru@redhat.com>
[One more in img_amend() due to commit 0bc2a50e17 "qemu-option: Use
returned bool to check for failure"]
---
 qemu-img.c | 15 +++------------
 1 file changed, 3 insertions(+), 12 deletions(-)

diff --git a/qemu-img.c b/qemu-img.c
index 41d2b91091..498fbf42fe 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -465,22 +465,18 @@ static int add_old_style_options(const char *fmt, QemuOpts *opts,
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
@@ -4214,17 +4210,12 @@ static int img_amend(int argc, char **argv)
     opts = qemu_opts_create(amend_opts, NULL, 0, &error_abort);
     if (!qemu_opts_do_parse(opts, options, NULL, &err)) {
         /* Try to parse options using the create options */
-        Error *err1 = NULL;
         amend_opts = qemu_opts_append(amend_opts, bs->drv->create_opts);
         qemu_opts_del(opts);
         opts = qemu_opts_create(amend_opts, NULL, 0, &error_abort);
-        qemu_opts_do_parse(opts, options, NULL, &err1);
-
-        if (!err1) {
+        if (qemu_opts_do_parse(opts, options, NULL, NULL)) {
             error_append_hint(&err,
                               "This option is only supported for image creation\n");
-        } else {
-            error_free(err1);
         }
 
         error_report_err(err);
-- 
2.26.2


