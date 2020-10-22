Return-Path: <SRS0=9x1+=D5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2F15C56201
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2020 22:37:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1B22F24658
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2020 22:37:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="faBRSKQM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B22F24658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57818 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVjCv-0001bp-2L
	for qemu-devel@archiver.kernel.org; Thu, 22 Oct 2020 18:37:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45092)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kVj7p-0006Jt-4F
 for qemu-devel@nongnu.org; Thu, 22 Oct 2020 18:32:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:35068)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kVj7m-0007qu-Px
 for qemu-devel@nongnu.org; Thu, 22 Oct 2020 18:32:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603405917;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CNrl9xgpABbIubEhK/YTHIB6JhzyiVoLX/QpInLarwk=;
 b=faBRSKQMy3+5R/e3hMHmNHUQv5MpYvqyyOs7GpDoAG3EqTK0x3+280CT6icZ1J89pivJ+p
 pQXxdod+pS5by7PyGUdvPzCfCHmrpKx1hJ2hft8TFk2IZHmt9NYVaN2CPVjYH84iTJZIpN
 N0vweswh5xSgTPw7eC1VzGVyTsbA5rU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-46-vULoavbYOYe8wtqTZWFm6A-1; Thu, 22 Oct 2020 18:31:55 -0400
X-MC-Unique: vULoavbYOYe8wtqTZWFm6A-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 12839107AFA5;
 Thu, 22 Oct 2020 22:31:54 +0000 (UTC)
Received: from localhost (ovpn-66-44.rdu2.redhat.com [10.10.66.44])
 by smtp.corp.redhat.com (Postfix) with ESMTP id EA07F5B4A2;
 Thu, 22 Oct 2020 22:31:50 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 2/4] autz/listfile: Use object_class_property_add_bool_ptr()
Date: Thu, 22 Oct 2020 18:31:38 -0400
Message-Id: <20201022223140.2083123-3-ehabkost@redhat.com>
In-Reply-To: <20201022223140.2083123-1-ehabkost@redhat.com>
References: <20201022223140.2083123-1-ehabkost@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ehabkost@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/22 08:09:01
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
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Markus Armbruster <armbru@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
Cc: "Daniel P. Berrangé" <berrange@redhat.com>
Cc: qemu-devel@nongnu.org
---
 authz/listfile.c | 27 +++------------------------
 1 file changed, 3 insertions(+), 24 deletions(-)

diff --git a/authz/listfile.c b/authz/listfile.c
index aaf930453d..911c4e45f2 100644
--- a/authz/listfile.c
+++ b/authz/listfile.c
@@ -184,27 +184,6 @@ qauthz_list_file_prop_get_filename(Object *obj,
 }
 
 
-static void
-qauthz_list_file_prop_set_refresh(Object *obj,
-                                  bool value,
-                                  Error **errp G_GNUC_UNUSED)
-{
-    QAuthZListFile *fauthz = QAUTHZ_LIST_FILE(obj);
-
-    fauthz->refresh = value;
-}
-
-
-static bool
-qauthz_list_file_prop_get_refresh(Object *obj,
-                                  Error **errp G_GNUC_UNUSED)
-{
-    QAuthZListFile *fauthz = QAUTHZ_LIST_FILE(obj);
-
-    return fauthz->refresh;
-}
-
-
 static void
 qauthz_list_file_finalize(Object *obj)
 {
@@ -227,9 +206,9 @@ qauthz_list_file_class_init(ObjectClass *oc, void *data)
     object_class_property_add_str(oc, "filename",
                                   qauthz_list_file_prop_get_filename,
                                   qauthz_list_file_prop_set_filename);
-    object_class_property_add_bool(oc, "refresh",
-                                   qauthz_list_file_prop_get_refresh,
-                                   qauthz_list_file_prop_set_refresh);
+    object_class_property_add_bool_ptr(oc, "refresh",
+                                       offsetof(QAuthZListFile, refresh),
+                                       OBJ_PROP_FLAG_READWRITE);
 
     authz->is_allowed = qauthz_list_file_is_allowed;
 }
-- 
2.28.0


