Return-Path: <SRS0=ACoC=7J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B4E8C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 08:48:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CC23F206F1
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 08:48:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KbQKoTpB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC23F206F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59322 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdrjy-0006pU-Us
	for qemu-devel@archiver.kernel.org; Wed, 27 May 2020 04:48:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33090)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jdrjE-00061g-AI
 for qemu-devel@nongnu.org; Wed, 27 May 2020 04:48:00 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:58389
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jdrjD-00031J-Fg
 for qemu-devel@nongnu.org; Wed, 27 May 2020 04:48:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590569278;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=R5Xq5LtAdo4VohauqlB8fTjE8gYsLljSmhT1/DYk5rs=;
 b=KbQKoTpB9Sl/Ix9TYqe7XilfXLSYS+hBn7Ldryb01EC7wVCef03C2jocYXn62RjAu2YkJO
 ltkkTOyRTmCPvkPYlz3s64i1zm0S3ZdnJ1NF1wcqVqdeMQqWHzRoU2+pFlZfcFjgCWrYzj
 hLiaueEC69A6rQpTG/XjBG1rGpliLXM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-109-DgYStBbjPc2FxXf5hsyYQw-1; Wed, 27 May 2020 04:47:57 -0400
X-MC-Unique: DgYStBbjPc2FxXf5hsyYQw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 06004100A61D;
 Wed, 27 May 2020 08:47:56 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-32.ams2.redhat.com
 [10.36.112.32])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C766198A21;
 Wed, 27 May 2020 08:47:55 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 2BC2F11386A0; Wed, 27 May 2020 10:47:54 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/2] qom: Constify object_get_canonical_path{,
 _component}()'s parameter
Date: Wed, 27 May 2020 10:47:53 +0200
Message-Id: <20200527084754.7531-2-armbru@redhat.com>
In-Reply-To: <20200527084754.7531-1-armbru@redhat.com>
References: <20200527084754.7531-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/27 00:45:05
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: berrange@redhat.com, ehabkost@redhat.com, philmd@redhat.com,
 mark.cave-ayland@ilande.co.uk, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Suggested-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 include/qom/object.h | 4 ++--
 qom/object.c         | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/qom/object.h b/include/qom/object.h
index fd453dc8d6..b3eb05d65d 100644
--- a/include/qom/object.h
+++ b/include/qom/object.h
@@ -1406,7 +1406,7 @@ Object *object_get_internal_root(void);
  * path is the path within the composition tree starting from the root.
  * %NULL if the object doesn't have a parent (and thus a canonical path).
  */
-char *object_get_canonical_path_component(Object *obj);
+char *object_get_canonical_path_component(const Object *obj);
 
 /**
  * object_get_canonical_path:
@@ -1414,7 +1414,7 @@ char *object_get_canonical_path_component(Object *obj);
  * Returns: The canonical path for a object.  This is the path within the
  * composition tree starting from the root.
  */
-char *object_get_canonical_path(Object *obj);
+char *object_get_canonical_path(const Object *obj);
 
 /**
  * object_resolve_path:
diff --git a/qom/object.c b/qom/object.c
index d0be42c8d6..c02487ec1a 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -1883,7 +1883,7 @@ object_property_add_const_link(Object *obj, const char *name,
                                 NULL, OBJ_PROP_LINK_DIRECT);
 }
 
-char *object_get_canonical_path_component(Object *obj)
+char *object_get_canonical_path_component(const Object *obj)
 {
     ObjectProperty *prop = NULL;
     GHashTableIter iter;
@@ -1908,7 +1908,7 @@ char *object_get_canonical_path_component(Object *obj)
     return NULL;
 }
 
-char *object_get_canonical_path(Object *obj)
+char *object_get_canonical_path(const Object *obj)
 {
     Object *root = object_get_root();
     char *newpath, *path = NULL;
-- 
2.21.3


