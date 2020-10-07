Return-Path: <SRS0=37Ja=DO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79C57C41604
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 16:58:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CCA4720739
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 16:58:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O1aTllDQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CCA4720739
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54514 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQClu-000336-LS
	for qemu-devel@archiver.kernel.org; Wed, 07 Oct 2020 12:58:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48210)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1kQCd0-000149-An
 for qemu-devel@nongnu.org; Wed, 07 Oct 2020 12:49:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:35676)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1kQCcx-0002I7-Uy
 for qemu-devel@nongnu.org; Wed, 07 Oct 2020 12:49:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602089359;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=04Hf6/p666vizBL9fgE3OdVFlK2TM9dt/U3TjIOJOGU=;
 b=O1aTllDQqo9cjcYSGQfltWr7XZYDpGfgG76z4cKWsskM4IDkh3Zlz7Zm/h19B4WGBkC1bE
 JvKRTOfAWO7LkH3bVIZekB9/LSAQ25Du/EowZZGxI6kc2dJ405YWksvwqjADSgJBdC3iQu
 rGnZ9kLbAhKpfGcgVLT26Lu2oJBm5xg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-569-5em6sWtlOI2-OQA5wt1rDg-1; Wed, 07 Oct 2020 12:49:17 -0400
X-MC-Unique: 5em6sWtlOI2-OQA5wt1rDg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4597E81EE94;
 Wed,  7 Oct 2020 16:49:16 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-113-169.ams2.redhat.com
 [10.36.113.169])
 by smtp.corp.redhat.com (Postfix) with ESMTP id ECD6D5D9DD;
 Wed,  7 Oct 2020 16:49:14 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH v3 4/4] qemu-storage-daemon: Remove QemuOpts from --object
 parser
Date: Wed,  7 Oct 2020 18:49:03 +0200
Message-Id: <20201007164903.282198-5-kwolf@redhat.com>
In-Reply-To: <20201007164903.282198-1-kwolf@redhat.com>
References: <20201007164903.282198-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kwolf@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=216.205.24.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/07 00:54:30
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.742,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: kwolf@redhat.com, armbru@redhat.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The command line parser for --object parses the input twice: Once into
QemuOpts just for detecting help options, and then again into a QDict
using the keyval parser for actually creating the object.

Now that the keyval parser can also detect help options, we can simplify
this and remove the QemuOpts part.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
---
 storage-daemon/qemu-storage-daemon.c | 15 ++++-----------
 1 file changed, 4 insertions(+), 11 deletions(-)

diff --git a/storage-daemon/qemu-storage-daemon.c b/storage-daemon/qemu-storage-daemon.c
index 6f0e0cfb36..e419ba9f19 100644
--- a/storage-daemon/qemu-storage-daemon.c
+++ b/storage-daemon/qemu-storage-daemon.c
@@ -264,21 +264,14 @@ static void process_options(int argc, char *argv[])
             }
         case OPTION_OBJECT:
             {
-                QemuOpts *opts;
-                const char *type;
                 QDict *args;
+                bool help;
 
-                /* FIXME The keyval parser rejects 'help' arguments, so we must
-                 * unconditionall try QemuOpts first. */
-                opts = qemu_opts_parse(&qemu_object_opts,
-                                       optarg, true, &error_fatal);
-                type = qemu_opt_get(opts, "qom-type");
-                if (type && user_creatable_print_help(type, opts)) {
+                args = keyval_parse(optarg, "qom-type", &help, &error_fatal);
+                if (help) {
+                    user_creatable_print_help_from_qdict(args);
                     exit(EXIT_SUCCESS);
                 }
-                qemu_opts_del(opts);
-
-                args = keyval_parse(optarg, "qom-type", NULL, &error_fatal);
                 user_creatable_add_dict(args, true, &error_fatal);
                 qobject_unref(args);
                 break;
-- 
2.25.4


