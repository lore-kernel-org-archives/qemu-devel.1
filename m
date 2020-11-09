Return-Path: <SRS0=6joO=EP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3C97C2D0A3
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 21:35:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0BE0021D40
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 21:35:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d4lHxRbe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0BE0021D40
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41578 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kcEop-0004OB-1v
	for qemu-devel@archiver.kernel.org; Mon, 09 Nov 2020 16:35:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33718)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kcEgD-00049B-AY
 for qemu-devel@nongnu.org; Mon, 09 Nov 2020 16:26:26 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:41435)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kcEgA-0005d6-M1
 for qemu-devel@nongnu.org; Mon, 09 Nov 2020 16:26:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604957181;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=R8K+X+Bhbl48vXNduSDuwR4SqZX1cMu+hzqYgTV7pDc=;
 b=d4lHxRbejLs2lbeg5nN4GinYLDeX4MMDgP0DYC4ZFkIyZyfNnuq7aGDnGdWkl6xeR5kAnc
 6gVNT82WuKX90YVWx70+HixoeEji4iixICwXVPK8S5ll4fzLTDCHaUq1H6vqToTFPFD6Ju
 J0JGz1R2+z8XQMLsw4h0lBcYi/metL4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-28-HM_aGxYsPV6QNELoi_6leA-1; Mon, 09 Nov 2020 16:26:12 -0500
X-MC-Unique: HM_aGxYsPV6QNELoi_6leA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4AC858030CE
 for <qemu-devel@nongnu.org>; Mon,  9 Nov 2020 21:26:11 +0000 (UTC)
Received: from localhost (ovpn-114-68.rdu2.redhat.com [10.10.114.68])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0BD3B5C639;
 Mon,  9 Nov 2020 21:26:10 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 7/8] qom: Make object_property_set_default() public
Date: Mon,  9 Nov 2020 16:25:55 -0500
Message-Id: <20201109212556.3934583-8-ehabkost@redhat.com>
In-Reply-To: <20201109212556.3934583-1-ehabkost@redhat.com>
References: <20201109212556.3934583-1-ehabkost@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ehabkost@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=63.128.21.124; envelope-from=ehabkost@redhat.com;
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The function will be used outside qom/object.c, to simplify the
field property code that sets the property default value.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 include/qom/object.h | 11 +++++++++++
 qom/object.c         |  2 +-
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/include/qom/object.h b/include/qom/object.h
index 2ab124b8f0..4234cc9b66 100644
--- a/include/qom/object.h
+++ b/include/qom/object.h
@@ -1090,6 +1090,17 @@ ObjectProperty *object_class_property_add(ObjectClass *klass, const char *name,
                                           ObjectPropertyRelease *release,
                                           void *opaque);
 
+/**
+ * object_property_set_default:
+ * @prop: the property to set
+ * @value: the value to be written to the property
+ *
+ * Set the property default value.
+ *
+ * Ownership of @value is transferred to the property.
+ */
+void object_property_set_default(ObjectProperty *prop, QObject *value);
+
 /**
  * object_property_set_default_bool:
  * @prop: the property to set
diff --git a/qom/object.c b/qom/object.c
index 7c11bcd3b1..6b0d9d8c79 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -1547,7 +1547,7 @@ static void object_property_init_defval(Object *obj, ObjectProperty *prop)
     visit_free(v);
 }
 
-static void object_property_set_default(ObjectProperty *prop, QObject *defval)
+void object_property_set_default(ObjectProperty *prop, QObject *defval)
 {
     assert(!prop->defval);
     assert(!prop->init);
-- 
2.28.0


