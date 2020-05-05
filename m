Return-Path: <SRS0=1jZz=6T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2306C47257
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 15:31:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8DE472078C
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 15:31:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FZ33xGND"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DE472078C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47980 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVzXW-00059l-J0
	for qemu-devel@archiver.kernel.org; Tue, 05 May 2020 11:31:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45934)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jVzVm-0003Jd-Dk
 for qemu-devel@nongnu.org; Tue, 05 May 2020 11:29:34 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:27276
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jVzVk-0007QI-R0
 for qemu-devel@nongnu.org; Tue, 05 May 2020 11:29:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588692570;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4RikHMQLXtDbA/cd7k4epxb/irkWDQhbyQSCKt0u3s4=;
 b=FZ33xGNDFB2jN+JFH3lg7rGB+wbw3xxd0GspgEv7G7xD5uiKBXUJP2tmtkop+sfP61TDzX
 Fs+zniiEq6oebwrAKjkLaGWATI3Cp+ynw6hSBOrGlQnn5BCa+HS0TUXfrOvsku6LB7soO6
 cbvxSnPO3NybvdTBj+6/nuUF7YQ7tt8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-303-QQEVX7dTMaCVCz-2VTwODg-1; Tue, 05 May 2020 11:29:28 -0400
X-MC-Unique: QQEVX7dTMaCVCz-2VTwODg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E6C3680183C
 for <qemu-devel@nongnu.org>; Tue,  5 May 2020 15:29:27 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-113-6.ams2.redhat.com [10.36.113.6])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id AEB141000232;
 Tue,  5 May 2020 15:29:27 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 3A4B111358C0; Tue,  5 May 2020 17:29:26 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 04/18] qom: Simplify object_property_get_enum()
Date: Tue,  5 May 2020 17:29:12 +0200
Message-Id: <20200505152926.18877-5-armbru@redhat.com>
In-Reply-To: <20200505152926.18877-1-armbru@redhat.com>
References: <20200505152926.18877-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.120; envelope-from=armbru@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/05 00:37:38
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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
Cc: pbonzini@redhat.com, berrange@redhat.com, ehabkost@redhat.com,
 philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Reuse object_property_get_str().  Switches from the string to the
qobject visitor under the hood.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 qom/object.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/qom/object.c b/qom/object.c
index 3d65658059..b374af302c 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -1521,8 +1521,6 @@ typedef struct EnumProperty {
 int object_property_get_enum(Object *obj, const char *name,
                              const char *typename, Error **errp)
 {
-    Error *err =3D NULL;
-    Visitor *v;
     char *str;
     int ret;
     ObjectProperty *prop =3D object_property_find(obj, name, errp);
@@ -1541,15 +1539,10 @@ int object_property_get_enum(Object *obj, const cha=
r *name,
=20
     enumprop =3D prop->opaque;
=20
-    v =3D string_output_visitor_new(false, &str);
-    object_property_get(obj, v, name, &err);
-    if (err) {
-        error_propagate(errp, err);
-        visit_free(v);
+    str =3D object_property_get_str(obj, name, errp);
+    if (!str) {
         return 0;
     }
-    visit_complete(v, &str);
-    visit_free(v);
=20
     ret =3D qapi_enum_parse(enumprop->lookup, str, -1, errp);
     g_free(str);
--=20
2.21.1


