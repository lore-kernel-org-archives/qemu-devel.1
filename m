Return-Path: <SRS0=5yua=6H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CABEDC54FD0
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 16:09:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 964DB20728
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 16:09:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GiiVdRqw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 964DB20728
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58198 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRePp-0003Dv-N4
	for qemu-devel@archiver.kernel.org; Thu, 23 Apr 2020 12:09:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59946)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jReHp-000689-G2
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 12:01:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jReHa-0002DS-GC
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 12:01:13 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:51532
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jReHa-00026V-1t
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 12:00:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587657651;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2K7axtxXgjXDGGMpxgeovyJuxWoALcdT61SDt3E7mDA=;
 b=GiiVdRqwr+RB/dY+SW7e6NNr/n3eUjyzMFisU8jIs2M6kWuXSUFu3k4CvBgB+YWGCaBxpn
 jGm+Rix/KVVN/iepQhTwIq4FLESs9vJre8H3q8fcDGtgeurEmo86ht+r+bHWzOdhf6hK6i
 nh2/Ul0keDSFAPVfybAxbWa1MBDgrm0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-325-yjo7zZbmMR2IrdimW1V_tA-1; Thu, 23 Apr 2020 12:00:42 -0400
X-MC-Unique: yjo7zZbmMR2IrdimW1V_tA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4509A180F123;
 Thu, 23 Apr 2020 16:00:41 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-113-6.ams2.redhat.com [10.36.113.6])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 804615D76A;
 Thu, 23 Apr 2020 16:00:39 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 70A8411358C5; Thu, 23 Apr 2020 18:00:36 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 09/13] qapi: Assert non-input visitors see only valid narrow
 integers
Date: Thu, 23 Apr 2020 18:00:32 +0200
Message-Id: <20200423160036.7048-10-armbru@redhat.com>
In-Reply-To: <20200423160036.7048-1-armbru@redhat.com>
References: <20200423160036.7048-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.120; envelope-from=armbru@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/23 06:43:51
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: mdroth@linux.vnet.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

visit_type_intN() and visit_type_uintN() fail when the value is out of
bounds.

This is appropriate with an input visitor: the value comes from input,
and input may be bad.

It should never happen with the other visitors: the value comes from
the caller, and callers must keep it within bounds.  Assert that.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 qapi/qapi-visit-core.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/qapi/qapi-visit-core.c b/qapi/qapi-visit-core.c
index 80ca83bcb9..74aa9c04bd 100644
--- a/qapi/qapi-visit-core.c
+++ b/qapi/qapi-visit-core.c
@@ -160,10 +160,13 @@ static void visit_type_uintN(Visitor *v, uint64_t *ob=
j, const char *name,
     Error *err =3D NULL;
     uint64_t value =3D *obj;
=20
+    assert(v->type =3D=3D VISITOR_INPUT || value <=3D max);
+
     v->type_uint64(v, name, &value, &err);
     if (err) {
         error_propagate(errp, err);
     } else if (value > max) {
+        assert(v->type =3D=3D VISITOR_INPUT);
         error_setg(errp, QERR_INVALID_PARAMETER_VALUE,
                    name ? name : "null", type);
     } else {
@@ -219,10 +222,13 @@ static void visit_type_intN(Visitor *v, int64_t *obj,=
 const char *name,
     Error *err =3D NULL;
     int64_t value =3D *obj;
=20
+    assert(v->type =3D=3D VISITOR_INPUT || (value >=3D min && value <=3D m=
ax));
+
     v->type_int64(v, name, &value, &err);
     if (err) {
         error_propagate(errp, err);
     } else if (value < min || value > max) {
+        assert(v->type =3D=3D VISITOR_INPUT);
         error_setg(errp, QERR_INVALID_PARAMETER_VALUE,
                    name ? name : "null", type);
     } else {
--=20
2.21.1


