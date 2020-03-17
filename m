Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C0EDC10F29
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 12:19:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C574520735
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 12:19:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KOC0zyl+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C574520735
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60352 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEBCI-0008OQ-NJ
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 08:19:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35405)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1jEB0w-0005aN-HB
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 08:08:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1jEB0v-0001QE-C1
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 08:08:06 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:29953)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1jEB0v-0001NY-7M
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 08:08:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584446884;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=85UA8eN3Fx/37KkDpbibaVHK721nHlHEAF75KDVHNvA=;
 b=KOC0zyl+srAoQL//galTAnCf3zGwZ0EHDU0o5lm8NqjTQd78WW9ipL4Zke/bU9yKZa947g
 coXrTcfxoMPY+iUg5Ug+IlPPB8d7NE8V8ZosBTo8pP+6dOXYbmekzeGjfuGKtIvT3t+mm0
 c4BdalIi7mX9p7DPazkXqF3eQ7A9Wpg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-211-ah7nfDc4Pmmb3J2mRLGW5A-1; Tue, 17 Mar 2020 08:08:02 -0400
X-MC-Unique: ah7nfDc4Pmmb3J2mRLGW5A-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CCD09107B26F
 for <qemu-devel@nongnu.org>; Tue, 17 Mar 2020 12:08:01 +0000 (UTC)
Received: from dgilbert-t580.localhost (ovpn-114-234.ams2.redhat.com
 [10.36.114.234])
 by smtp.corp.redhat.com (Postfix) with ESMTP id EF6825DA7B;
 Tue, 17 Mar 2020 12:08:00 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org,
	imammedo@redhat.com,
	pbonzini@redhat.com
Subject: [PATCH] vl.c/memdev: Error on bad memory backend
Date: Tue, 17 Mar 2020 12:07:59 +0000
Message-Id: <20200317120759.49367-1-dgilbert@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 216.205.24.74
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

If memory-backend is a non-existent object, qemu crashes.
Check that the backend actually resolves.

e.g.   ./qemu-system-x86_64 -machine pc,accel=3Dkvm,memory-backend=3Dfoo

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 softmmu/vl.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/softmmu/vl.c b/softmmu/vl.c
index ff2685dff8..76507e99c4 100644
--- a/softmmu/vl.c
+++ b/softmmu/vl.c
@@ -4288,6 +4288,11 @@ void qemu_init(int argc, char **argv, char **envp)
=20
         backend =3D object_resolve_path_type(current_machine->ram_memdev_i=
d,
                                            TYPE_MEMORY_BACKEND, NULL);
+        if (!backend) {
+            error_report("Unknown memory backend object id '%s'",
+                         current_machine->ram_memdev_id);
+            exit(EXIT_FAILURE);
+        }
         backend_size =3D object_property_get_uint(backend, "size",  &error=
_abort);
         if (have_custom_ram_size && backend_size !=3D ram_size) {
                 error_report("Size specified by -m option must match size =
of "
--=20
2.24.1


