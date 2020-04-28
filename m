Return-Path: <SRS0=buBk=6M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBE9CC83001
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 16:52:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 995B82063A
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 16:52:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HHw9cNXt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 995B82063A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39630 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTTTB-0006FE-Dk
	for qemu-devel@archiver.kernel.org; Tue, 28 Apr 2020 12:52:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34394)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jTTFG-0006ls-Lj
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 12:38:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jTTBo-0000tX-34
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 12:38:06 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:34021
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jTTBn-0000t8-K8
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 12:34:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588091670;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cnNsMekgRnqDnpykk6bN9r6dKCrQkcHisa/B6Io0xnU=;
 b=HHw9cNXtpMFe7w0bVJhOSdZ73oe9jsdU3NVx+E3MozFXav3nTzoKitwSzaGPsLxW5S6KQw
 pOz6+oFbYsf6kQJiyNX5XGmxElT0rtyxgH5WxyYIVik/8GytGSPFUaqUOnSpwbG8TxThk/
 aZ3bGwWG4dDuYAI1qwSb9s/pW0IH9EM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-451-AN8aSZmTNOCpfo2T1qSFKw-1; Tue, 28 Apr 2020 12:34:27 -0400
X-MC-Unique: AN8aSZmTNOCpfo2T1qSFKw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8EC2E189595E
 for <qemu-devel@nongnu.org>; Tue, 28 Apr 2020 16:34:26 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-113-6.ams2.redhat.com [10.36.113.6])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B653E6607C;
 Tue, 28 Apr 2020 16:34:24 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 1FA1F11358C6; Tue, 28 Apr 2020 18:34:20 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 10/17] e1000: Don't run e1000_instance_init() twice
Date: Tue, 28 Apr 2020 18:34:12 +0200
Message-Id: <20200428163419.4483-11-armbru@redhat.com>
In-Reply-To: <20200428163419.4483-1-armbru@redhat.com>
References: <20200428163419.4483-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.120; envelope-from=armbru@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/28 04:15:05
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
Cc: pbonzini@redhat.com, Jason Wang <jasowang@redhat.com>, berrange@redhat.com,
 ehabkost@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

QOM object initialization runs .instance_init() for the type and all
its supertypes; see object_init_with_type().

Both TYPE_E1000_BASE and its concrete subtypes set .instance_init() to
e1000_instance_init().  For the concrete subtypes, it duly gets run
twice.  The second run fails, but the error gets ignored (a later
commit will change that).

Remove it from the subtypes.

Cc: Jason Wang <jasowang@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 hw/net/e1000.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/hw/net/e1000.c b/hw/net/e1000.c
index 2a69eee63f..0d2c2759e3 100644
--- a/hw/net/e1000.c
+++ b/hw/net/e1000.c
@@ -1824,7 +1824,6 @@ static void e1000_register_types(void)
         type_info.parent =3D TYPE_E1000_BASE;
         type_info.class_data =3D (void *)info;
         type_info.class_init =3D e1000_class_init;
-        type_info.instance_init =3D e1000_instance_init;
=20
         type_register(&type_info);
     }
--=20
2.21.1


