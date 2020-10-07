Return-Path: <SRS0=37Ja=DO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42863C41604
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 16:57:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8719F20739
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 16:57:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C6Yk7uDa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8719F20739
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51112 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQCkw-0001gS-GU
	for qemu-devel@archiver.kernel.org; Wed, 07 Oct 2020 12:57:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48182)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1kQCcy-0000xk-0D
 for qemu-devel@nongnu.org; Wed, 07 Oct 2020 12:49:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:59086)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1kQCcv-0002Hh-Up
 for qemu-devel@nongnu.org; Wed, 07 Oct 2020 12:49:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602089357;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0BmOmIIAwXFUASJ/6L++9i0/+tRzTllg+jM96vXHsns=;
 b=C6Yk7uDaDP/nmlasbdI/Mh3inzIsZ5Bp41p/Xp2xb63uH/Cf1qyBPeRzB2b54YxK5HSwzQ
 6M4Qvxs/emKP2BDvzAbXFyqCj3Z5mfBXdg26ZmXJqgqA1YCf/dn7FSJ+kbKgBCaEUnNksL
 1FdiN1RZRfE1dIk84ZTlKCLWInTIKuk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-117-UmcvboC8PRuxmTaI1tDyFQ-1; Wed, 07 Oct 2020 12:49:15 -0400
X-MC-Unique: UmcvboC8PRuxmTaI1tDyFQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A437810BBED2;
 Wed,  7 Oct 2020 16:49:14 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-113-169.ams2.redhat.com
 [10.36.113.169])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CC89A5D9DD;
 Wed,  7 Oct 2020 16:49:11 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH v3 3/4] qom: Add user_creatable_print_help_from_qdict()
Date: Wed,  7 Oct 2020 18:49:02 +0200
Message-Id: <20201007164903.282198-4-kwolf@redhat.com>
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
Cc: kwolf@redhat.com, armbru@redhat.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This adds a function that, given a QDict of non-help options, prints
help for user creatable objects.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
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
2.25.4


