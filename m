Return-Path: <SRS0=2niX=33=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD874C352A2
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 11:28:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AB05120726
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 11:28:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cvoVraEV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB05120726
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54472 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j01oR-0002v0-Sv
	for qemu-devel@archiver.kernel.org; Fri, 07 Feb 2020 06:28:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33518)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j01nS-00021B-6f
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 06:27:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j01nR-0001j1-8X
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 06:27:42 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:56806
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j01nR-0001iW-1h
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 06:27:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581074860;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=G95PTwCCtptgBScLxDFzyGKSIIGgkKDhimn6aS+h6BE=;
 b=cvoVraEVAepSt38VeFrcwmVvNOQ+jo9AvIh49kNRgGXumLjGcLOfreUU9P+N3GKYqDzH6m
 +0Kzb1j+01/VR5WJxerFr+LUDI4kdUTefEsh3H9YqfoREgEMEBO0qinYRvWtch94fDYSWb
 oB6mlcsi7ahdxHyxpjUrtxU5KMxlcmQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-130-c65g2vG9MV684VY8JlABuQ-1; Fri, 07 Feb 2020 06:27:39 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A34F98010D6;
 Fri,  7 Feb 2020 11:27:37 +0000 (UTC)
Received: from x1w.redhat.com (ovpn-204-120.brq.redhat.com [10.40.204.120])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6498A790E7;
 Fri,  7 Feb 2020 11:27:31 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2] vl: Abort if multiple machines are registered as default
Date: Fri,  7 Feb 2020 12:27:29 +0100
Message-Id: <20200207112729.28554-1-philmd@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: c65g2vG9MV684VY8JlABuQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: qemu-trivial@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@gmail.com>,
 Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

It would be confusing to have multiple default machines.
Abort if this ever occurs.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
v2: Use assert() instead of human friendly message (Marc-Andr=C3=A9)

Cc: Marc-Andr=C3=A9 Lureau <marcandre.lureau@gmail.com>
Cc: Laurent Vivier <laurent@vivier.eu>
---
 vl.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/vl.c b/vl.c
index 7dcb0879c4..b3e0f7af25 100644
--- a/vl.c
+++ b/vl.c
@@ -2354,6 +2354,8 @@ static MachineClass *machine_parse(const char *name, =
GSList *machines)
     GSList *el;
=20
     if (is_help_option(name)) {
+        int default_count =3D 0;
+
         printf("Supported machines are:\n");
         machines =3D g_slist_sort(machines, machine_class_cmp);
         for (el =3D machines; el; el =3D el->next) {
@@ -2364,7 +2366,9 @@ static MachineClass *machine_parse(const char *name, =
GSList *machines)
             printf("%-20s %s%s%s\n", mc->name, mc->desc,
                    mc->is_default ? " (default)" : "",
                    mc->deprecation_reason ? " (deprecated)" : "");
+            default_count +=3D !!mc->is_default;
         }
+        assert(default_count <=3D 1);
         exit(0);
     }
=20
--=20
2.21.1


