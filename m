Return-Path: <SRS0=HfOj=DH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7901C4727E
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 12:50:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 62A5F20657
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 12:50:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a5/jQIrU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62A5F20657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46004 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNbZD-0002YC-GJ
	for qemu-devel@archiver.kernel.org; Wed, 30 Sep 2020 08:50:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51178)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1kNbUx-0005ze-3M
 for qemu-devel@nongnu.org; Wed, 30 Sep 2020 08:46:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:58101)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1kNbUv-0001BO-CN
 for qemu-devel@nongnu.org; Wed, 30 Sep 2020 08:46:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601469976;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+LzaKCePxxqr3LcqlBWeOwHkCZdcYcEaXKeXs3/7ihE=;
 b=a5/jQIrUrkQvibafLeYxq7LXOv80aLw5kvQYQ95ev2kvVMliN6BkX8IPrPIowwGMrpu4tK
 KjnbvhT88J/f1DCIrtAtlQ3wF2msECAgCwGRXhpaDcFsbdG70nYyZDWzR1Av7+KfG02eC2
 pOIzgwgsJQTnBUFhy7fUbGHW24q06ls=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-65-0KlMQNwCPK6-LJK7K-KiQg-1; Wed, 30 Sep 2020 08:46:13 -0400
X-MC-Unique: 0KlMQNwCPK6-LJK7K-KiQg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 64377101FFA4;
 Wed, 30 Sep 2020 12:46:12 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-113-128.ams2.redhat.com
 [10.36.113.128])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 266826715F;
 Wed, 30 Sep 2020 12:46:11 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH v2 4/4] qemu-storage-daemon: Remove QemuOpts from --object
 parser
Date: Wed, 30 Sep 2020 14:45:57 +0200
Message-Id: <20200930124557.51835-5-kwolf@redhat.com>
In-Reply-To: <20200930124557.51835-1-kwolf@redhat.com>
References: <20200930124557.51835-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kwolf@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=216.205.24.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/30 00:26:33
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.469,
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
Cc: kwolf@redhat.com, qemu-devel@nongnu.org, armbru@redhat.com,
 mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The command line parser for --object parses the input twice: Once into
QemuOpts just for detecting help options, and then again into a QDict
using the keyval parser for actually creating the object.

Now that the keyval parser can also detect help options, we can simplify
this and remove the QemuOpts part.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 storage-daemon/qemu-storage-daemon.c | 15 ++++-----------
 1 file changed, 4 insertions(+), 11 deletions(-)

diff --git a/storage-daemon/qemu-storage-daemon.c b/storage-daemon/qemu-storage-daemon.c
index bb9cb740f0..7cbdbf0b23 100644
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


