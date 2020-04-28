Return-Path: <SRS0=buBk=6M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 141B0C83000
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 16:40:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D1DF3206D6
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 16:40:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ddvYl9mA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1DF3206D6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38656 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTTHI-0001TO-Rx
	for qemu-devel@archiver.kernel.org; Tue, 28 Apr 2020 12:40:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34294)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jTTF5-0006Pk-Ip
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 12:38:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jTTBi-0000rD-MN
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 12:37:55 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:45888
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jTTBi-0000qT-2Y
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 12:34:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588091664;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=u8v/o1yD6EIYmtZ00uyBlyRQQYey3kdtwTftHMyddgE=;
 b=ddvYl9mAz0zxX7gObfg+j8mgtALiQmFuh8ecysIrFr2ZnCwcUxVLP+l92OE4fEByQv5kuD
 FpWukDKSvcd5O2MepaT0hTfIoB8zw1CnaA01DLu1BQQYYXdT57eV6l6sjM5IM05El4V/Ho
 dDRR3oGRhyuZcjm3cXFh7DVFJhqNs1A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-438-0TDf-qJENZK8f8LBdWB-YQ-1; Tue, 28 Apr 2020 12:34:23 -0400
X-MC-Unique: 0TDf-qJENZK8f8LBdWB-YQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 55A41107ACCD
 for <qemu-devel@nongnu.org>; Tue, 28 Apr 2020 16:34:22 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-113-6.ams2.redhat.com [10.36.113.6])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8FE675D98F;
 Tue, 28 Apr 2020 16:34:21 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id F414311358BD; Tue, 28 Apr 2020 18:34:19 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 01/17] qom: Clearer reference counting in
 object_initialize_childv()
Date: Tue, 28 Apr 2020 18:34:03 +0200
Message-Id: <20200428163419.4483-2-armbru@redhat.com>
In-Reply-To: <20200428163419.4483-1-armbru@redhat.com>
References: <20200428163419.4483-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.120; envelope-from=armbru@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/28 02:16:38
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: pbonzini@redhat.com, berrange@redhat.com, ehabkost@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 qom/object.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/qom/object.c b/qom/object.c
index 1812f79224..e06c78f9a5 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -571,18 +571,18 @@ void object_initialize_childv(Object *parentobj, cons=
t char *propname,
         }
     }
=20
+out:
     /*
-     * Since object_property_add_child added a reference to the child obje=
ct,
-     * we can drop the reference added by object_initialize(), so the chil=
d
-     * property will own the only reference to the object.
+     * We want @obj's reference to be 1 on success, 0 on failure.
+     * On success, it's 2: one taken by object_initialize(), and one
+     * by object_property_add_child().
+     * On failure in object_initialize() or earlier, it's 1.
+     * On failure afterwards, it's also 1: object_unparent() releases
+     * the reference taken by object_property_add_child().
      */
     object_unref(obj);
=20
-out:
-    if (local_err) {
-        error_propagate(errp, local_err);
-        object_unref(obj);
-    }
+    error_propagate(errp, local_err);
 }
=20
 static inline bool object_property_is_child(ObjectProperty *prop)
--=20
2.21.1


