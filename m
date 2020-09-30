Return-Path: <SRS0=HfOj=DH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 918B0C47420
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 12:47:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB19620789
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 12:47:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W1lsQPRO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB19620789
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37486 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNbWS-0007SE-PN
	for qemu-devel@archiver.kernel.org; Wed, 30 Sep 2020 08:47:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51154)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1kNbUw-0005zA-73
 for qemu-devel@nongnu.org; Wed, 30 Sep 2020 08:46:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:41405)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1kNbUt-0001B4-IT
 for qemu-devel@nongnu.org; Wed, 30 Sep 2020 08:46:17 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601469973;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AOCG3yx142Vn4Zm36ciK2UKGuyDIp7ek+VRYOsioH7g=;
 b=W1lsQPROV0ENMl4vDnEwsVR/s62sU9uytNCvISAyStE7utc61/XCjkd9kcrSy60aJkuaRT
 xiHwB0F1islp++F3IfWUFyLMFrvwxnSC61CKTacddkAMGfCe2qC5aMgzRQoNbsGrWVHgwz
 61ewyDP+GXrvQf55oyjvsD0hlkv18YU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-199-woezYpeMN1m7C58EwDpNRw-1; Wed, 30 Sep 2020 08:46:11 -0400
X-MC-Unique: woezYpeMN1m7C58EwDpNRw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D27FE1084D8A;
 Wed, 30 Sep 2020 12:46:10 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-113-128.ams2.redhat.com
 [10.36.113.128])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 941C160C05;
 Wed, 30 Sep 2020 12:46:09 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH v2 3/4] qom: Add user_creatable_print_help_from_qdict()
Date: Wed, 30 Sep 2020 14:45:56 +0200
Message-Id: <20200930124557.51835-4-kwolf@redhat.com>
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

This adds a function that, given a QDict of non-help options, prints
help for user creatable objects.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 include/qom/object_interfaces.h | 9 +++++++++
 qom/object_interfaces.c         | 9 +++++++++
 2 files changed, 18 insertions(+)

diff --git a/include/qom/object_interfaces.h b/include/qom/object_interfaces.h
index f118fb516b..53b114b11a 100644
--- a/include/qom/object_interfaces.h
+++ b/include/qom/object_interfaces.h
@@ -161,6 +161,15 @@ int user_creatable_add_opts_foreach(void *opaque,
  */
 bool user_creatable_print_help(const char *type, QemuOpts *opts);
 
+/**
+ * user_creatable_print_help_from_qdict:
+ * @args: options to create
+ *
+ * Prints help considering the other options given in @args (if "qom-type" is
+ * given and valid, print properties for the type, otherwise print valid types)
+ */
+void user_creatable_print_help_from_qdict(QDict *args);
+
 /**
  * user_creatable_del:
  * @id: the unique ID for the object
diff --git a/qom/object_interfaces.c b/qom/object_interfaces.c
index 3fd1da157e..ed896fe764 100644
--- a/qom/object_interfaces.c
+++ b/qom/object_interfaces.c
@@ -279,6 +279,15 @@ bool user_creatable_print_help(const char *type, QemuOpts *opts)
     return false;
 }
 
+void user_creatable_print_help_from_qdict(QDict *args)
+{
+    const char *type = qdict_get_try_str(args, "qom-type");
+
+    if (!type || !user_creatable_print_type_properites(type)) {
+        user_creatable_print_types();
+    }
+}
+
 bool user_creatable_del(const char *id, Error **errp)
 {
     Object *container;
-- 
2.25.4


