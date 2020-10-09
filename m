Return-Path: <SRS0=T5iq=DQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B931C433E7
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 16:19:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A835B2225D
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 16:19:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cq852Zw4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A835B2225D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36682 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQv7J-00072I-RD
	for qemu-devel@archiver.kernel.org; Fri, 09 Oct 2020 12:19:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59078)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kQuq8-0003n2-RP
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 12:01:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:55194)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kQuq5-00019J-QE
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 12:01:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602259308;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ll32Ld3oaLI3mIkeWOiZjUATzrWwfL5tTQJloVNDuu4=;
 b=cq852Zw42g8Z/2aDAt3s7bFHSxCtIxiP3IaAO8htvpJ+Zbz9cXmQD+Pt9Q8WwAKGN1m0lT
 BNlhNptA7m2AZQSxsQeQsid/F74ZfGBkSmaaFlsE7K+dX3+G+PSq23y22l0mvMrGy6TNtA
 64iFfGUt/oB/CLAle7lKLkqQ8cUvFAg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-192-PN1-52c7PTq3oa1YV_cm-g-1; Fri, 09 Oct 2020 12:01:47 -0400
X-MC-Unique: PN1-52c7PTq3oa1YV_cm-g-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AF8AC107AFCC;
 Fri,  9 Oct 2020 16:01:45 +0000 (UTC)
Received: from localhost (ovpn-119-102.rdu2.redhat.com [10.10.119.102])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7F63D5D9F3;
 Fri,  9 Oct 2020 16:01:42 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 06/12] can_host: Use class properties
Date: Fri,  9 Oct 2020 12:01:16 -0400
Message-Id: <20201009160122.1662082-7-ehabkost@redhat.com>
In-Reply-To: <20201009160122.1662082-1-ehabkost@redhat.com>
References: <20201009160122.1662082-1-ehabkost@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ehabkost@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
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
Cc: Kevin Wolf <kwolf@redhat.com>, Vikram Garhwal <fnu.vikram@xilinx.com>,
 Jason Wang <jasowang@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 John Snow <jsnow@redhat.com>, Pavel Pisa <pisa@cmp.felk.cvut.cz>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Instance properties make introspection hard and are not shown by
"-object ...,help".  Convert them to class properties.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
Cc: Pavel Pisa <pisa@cmp.felk.cvut.cz>
Cc: Vikram Garhwal <fnu.vikram@xilinx.com>
Cc: Jason Wang <jasowang@redhat.com>
Cc: qemu-devel@nongnu.org
---
 net/can/can_host.c | 16 +++++-----------
 1 file changed, 5 insertions(+), 11 deletions(-)

diff --git a/net/can/can_host.c b/net/can/can_host.c
index be4547d913..bec88b9620 100644
--- a/net/can/can_host.c
+++ b/net/can/can_host.c
@@ -72,21 +72,16 @@ static void can_host_complete(UserCreatable *uc, Error **errp)
     can_host_connect(CAN_HOST(uc), errp);
 }
 
-static void can_host_instance_init(Object *obj)
-{
-    CanHostState *ch = CAN_HOST(obj);
-
-    object_property_add_link(obj, "canbus", TYPE_CAN_BUS,
-                             (Object **)&ch->bus,
-                             object_property_allow_set_link,
-                             OBJ_PROP_LINK_STRONG);
-}
-
 static void can_host_class_init(ObjectClass *klass,
                                 void *class_data G_GNUC_UNUSED)
 {
     UserCreatableClass *uc_klass = USER_CREATABLE_CLASS(klass);
 
+    object_class_property_add_link(klass, "canbus", TYPE_CAN_BUS,
+                                   offsetof(CanHostState, bus),
+                                   object_property_allow_set_link,
+                                   OBJ_PROP_LINK_STRONG);
+
     klass->unparent = can_host_unparent;
     uc_klass->complete = can_host_complete;
 }
@@ -97,7 +92,6 @@ static const TypeInfo can_host_info = {
     .instance_size = sizeof(CanHostState),
     .class_size = sizeof(CanHostClass),
     .abstract = true,
-    .instance_init = can_host_instance_init,
     .class_init = can_host_class_init,
     .interfaces = (InterfaceInfo[]) {
         { TYPE_USER_CREATABLE },
-- 
2.26.2


