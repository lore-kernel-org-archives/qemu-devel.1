Return-Path: <SRS0=T5iq=DQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73A6CC433E7
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 16:13:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 20E182225D
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 16:13:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bEF6P2Rw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20E182225D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48634 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQv17-0008K0-C0
	for qemu-devel@archiver.kernel.org; Fri, 09 Oct 2020 12:13:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59264)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kQuqe-000407-Si
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 12:02:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:60878)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kQuqX-0001E0-8E
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 12:02:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602259334;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3K8tXU6aq8VGFAZW5fsFeYLPxQQLh3GInrtH5l6YUng=;
 b=bEF6P2RwoiK6L52FliD1MYg7EEaX/SV1jAbY7Wyv5g9LytYkHJxi+L5lvQ3qDzYoFpxBO2
 WEo68/lbhw/d7t70gA+AMZ9enSUjXXLaN17K68GfHWGNulWLr1OeNv2FF0/nOcBnaBnahS
 Md0KBaUSJ8nuutX9Lgt0OGWvINyN6uY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-234-N57T0fw8MyKAWd0hLA-Seg-1; Fri, 09 Oct 2020 12:02:11 -0400
X-MC-Unique: N57T0fw8MyKAWd0hLA-Seg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C6EA518A073A
 for <qemu-devel@nongnu.org>; Fri,  9 Oct 2020 16:02:10 +0000 (UTC)
Received: from localhost (ovpn-119-102.rdu2.redhat.com [10.10.119.102])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9AA2460BE2;
 Fri,  9 Oct 2020 16:02:07 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 12/12] [RFC] qom: Lock properties of all TYPE_USER_CREATABLE
 types
Date: Fri,  9 Oct 2020 12:01:22 -0400
Message-Id: <20201009160122.1662082-13-ehabkost@redhat.com>
In-Reply-To: <20201009160122.1662082-1-ehabkost@redhat.com>
References: <20201009160122.1662082-1-ehabkost@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ehabkost@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/09 02:34:40
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

TYPE_USER_CREATABLE types expose all QOM properties through
`-object` and `object-add`.  Lock the properties on
TYPE_USER_CREATABLE so we will never add new writable instance
properties to those types.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: "Daniel P. Berrangé" <berrange@redhat.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>
Cc: qemu-devel@nongnu.org
---
 qom/object_interfaces.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/qom/object_interfaces.c b/qom/object_interfaces.c
index e8e1523960..40123d4b50 100644
--- a/qom/object_interfaces.c
+++ b/qom/object_interfaces.c
@@ -293,6 +293,16 @@ bool user_creatable_del(const char *id, Error **errp)
     return true;
 }
 
+static void user_creatable_class_init(ObjectClass *klass, void *data)
+{
+    /*
+     * User-creatable QOM types expose all writable QOM properties
+     * to the external world through `-object` and `object-add`,
+     * so all writable properties must be registered at class level.
+     */
+    object_class_lock_properties(klass);
+}
+
 void user_creatable_cleanup(void)
 {
     object_unparent(object_get_objects_root());
@@ -304,6 +314,7 @@ static void register_types(void)
         .name          = TYPE_USER_CREATABLE,
         .parent        = TYPE_INTERFACE,
         .class_size = sizeof(UserCreatableClass),
+        .class_init    = user_creatable_class_init,
     };
 
     type_register_static(&uc_interface_info);
-- 
2.26.2


