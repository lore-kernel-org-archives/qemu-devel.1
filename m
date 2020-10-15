Return-Path: <SRS0=muvY=DW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F27CFC433E7
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 14:54:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 663E121D7F
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 14:54:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CMk37vwl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 663E121D7F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44994 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kT4eb-0001V3-4w
	for qemu-devel@archiver.kernel.org; Thu, 15 Oct 2020 10:54:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42306)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1kT4a8-0004eY-Cf
 for qemu-devel@nongnu.org; Thu, 15 Oct 2020 10:50:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:60070)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1kT4a6-0001iV-8s
 for qemu-devel@nongnu.org; Thu, 15 Oct 2020 10:50:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602773413;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=stV52gVCaiFh9WEkxR8O3GXle/EMo4IaLgXYIaMTEBY=;
 b=CMk37vwlSTuhjmoay41VL2KtBShYLdXYvquMkxPTo9sEo6fK7abHbvLniJvlHWl3JNknDk
 JMxQ0yyf7v41Lqxf8tt45NTNG3JeTovX9heOmabJUWfuH8ghnQbD3mazQHmg58DbPnUJZv
 HhfAYslW5AJq+B0RNapFapGLS1g+DFc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-148-o8BrDN52Od2ZgcQiZSW3lQ-1; Thu, 15 Oct 2020 10:50:09 -0400
X-MC-Unique: o8BrDN52Od2ZgcQiZSW3lQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4E9CEADC34;
 Thu, 15 Oct 2020 14:50:08 +0000 (UTC)
Received: from merkur.redhat.com (ovpn-114-163.ams2.redhat.com [10.36.114.163])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5367160C07;
 Thu, 15 Oct 2020 14:50:07 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 06/10] qom: Add user_creatable_print_help_from_qdict()
Date: Thu, 15 Oct 2020 16:49:48 +0200
Message-Id: <20201015144952.388043-7-kwolf@redhat.com>
In-Reply-To: <20201015144952.388043-1-kwolf@redhat.com>
References: <20201015144952.388043-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kwolf@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=63.128.21.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/15 02:10:02
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
Cc: kwolf@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This adds a function that, given a QDict of non-help options, prints
help for user creatable objects.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Message-Id: <20201007164903.282198-4-kwolf@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 include/qom/object_interfaces.h | 21 ++++++++++++++++++---
 qom/object_interfaces.c         |  9 +++++++++
 2 files changed, 27 insertions(+), 3 deletions(-)

diff --git a/include/qom/object_interfaces.h b/include/qom/object_interfaces.h
index f118fb516b..07d5cc8832 100644
--- a/include/qom/object_interfaces.h
+++ b/include/qom/object_interfaces.h
@@ -154,13 +154,28 @@ int user_creatable_add_opts_foreach(void *opaque,
  * @type: the QOM type to be added
  * @opts: options to create
  *
- * Prints help if requested in @opts.
+ * Prints help if requested in @type or @opts. Note that if @type is neither
+ * "help"/"?" nor a valid user creatable type, no help will be printed
+ * regardless of @opts.
  *
- * Returns: true if @opts contained a help option and help was printed, false
- * if no help option was found.
+ * Returns: true if a help option was found and help was printed, false
+ * otherwise.
  */
 bool user_creatable_print_help(const char *type, QemuOpts *opts);
 
+/**
+ * user_creatable_print_help_from_qdict:
+ * @args: options to create
+ *
+ * Prints help considering the other options given in @args (if "qom-type" is
+ * given and valid, print properties for the type, otherwise print valid types)
+ *
+ * In contrast to user_creatable_print_help(), this function can't return that
+ * no help was requested. It should only be called if we know that help is
+ * requested and it will always print some help.
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
2.28.0


