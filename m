Return-Path: <SRS0=5yua=6H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17D10C54FD0
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 16:03:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D17E120728
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 16:03:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eiEDeWVC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D17E120728
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57684 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jReJt-00007L-Uw
	for qemu-devel@archiver.kernel.org; Thu, 23 Apr 2020 12:03:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59942)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jReHp-00067z-7Q
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 12:01:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jReHS-000254-EN
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 12:01:12 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:50671
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jReHQ-00020G-BR
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 12:00:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587657642;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xjFKudehGzq1k8YeO6haKGxkdO6BS87KYCXFNVbD73E=;
 b=eiEDeWVCJ6q5ZOyQDsHVoRN5Nj7KqL0c+B9k6WZ71V4Ubefw5lVj0UdFI7WoboFXf2e1W7
 ko/jxr5h9DYRc5JHIO1YOnFU/JkC+kl7qFuGppWflEE5xdyi0Il44AeFvdY2/iMbrjUv7G
 DIS4+CdgY7bVipJX1weUCc3Fa0UauJ0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-441-6dhV56N8MReEBy6bDdWcgg-1; Thu, 23 Apr 2020 12:00:41 -0400
X-MC-Unique: 6dhV56N8MReEBy6bDdWcgg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 031F9106B258;
 Thu, 23 Apr 2020 16:00:40 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-113-6.ams2.redhat.com [10.36.113.6])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7F63C1001920;
 Thu, 23 Apr 2020 16:00:39 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 73B8D11358C6; Thu, 23 Apr 2020 18:00:36 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 10/13] qapi: Clean up visitor's recovery from input with
 invalid type
Date: Thu, 23 Apr 2020 18:00:33 +0200
Message-Id: <20200423160036.7048-11-armbru@redhat.com>
In-Reply-To: <20200423160036.7048-1-armbru@redhat.com>
References: <20200423160036.7048-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
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

An alternate type's visit_type_FOO() fails when it runs into an
invalid ->type.  If it's an input visit, we then need to free the the
object we got from visit_start_alternate().  We do that with
qapi_free_FOO(), which uses the dealloc visitor.

Trouble is that object is in a bad state: its ->type is invalid.  So
the dealloc visitor will run into the same error again, and the error
recovery skips deallocating the alternate's (invalid) alternative.
This is a roundabout way to g_free() the alternate.

Simplify: replace the qapi_free_FOO() by g_free().

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 scripts/qapi/visit.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/qapi/visit.py b/scripts/qapi/visit.py
index e3467b770b..3b28ba93f3 100644
--- a/scripts/qapi/visit.py
+++ b/scripts/qapi/visit.py
@@ -238,7 +238,7 @@ void visit_type_%(c_name)s(Visitor *v, const char *name=
, %(c_name)s **obj, Error
 out_obj:
     visit_end_alternate(v, (void **)obj);
     if (err && visit_is_input(v)) {
-        qapi_free_%(c_name)s(*obj);
+        g_free(*obj);
         *obj =3D NULL;
     }
 out:
--=20
2.21.1


