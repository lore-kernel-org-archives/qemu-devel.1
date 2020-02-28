Return-Path: <SRS0=EIn8=4Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02195C3F2CD
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 21:05:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BFB13246AE
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 21:05:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gDlnRH3Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFB13246AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53922 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7mpW-0002m4-Rt
	for qemu-devel@archiver.kernel.org; Fri, 28 Feb 2020 16:05:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60168)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ehabkost@redhat.com>) id 1j7moQ-0001Dv-7h
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 16:04:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ehabkost@redhat.com>) id 1j7moP-0005M9-6i
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 16:04:46 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:32719
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1j7moP-0005Lx-3E
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 16:04:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582923884;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IoIxPFqCfBCDJiA8MKkIVdnI0zwyrcJ48E1TknAl5qg=;
 b=gDlnRH3ZaBBq+vi3nNDSok281x9dT6yjzgouebhsJ2JJ15gU4/rxD6RgSP+IoIMkbnoqp6
 Qb4PnfFrIaQLHzY8k+/CR1HKsQBE+zjJncZOMKyCtCwjIj8XkbxmNzIMg9q6ydwtpQ/y4s
 3DqJ+AuwHhFNPdJnNDQxavuBR2DiOkk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-151-wZJJyrxoNhSk4PZkNvMQwA-1; Fri, 28 Feb 2020 16:04:41 -0500
X-MC-Unique: wZJJyrxoNhSk4PZkNvMQwA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6E6C21005510;
 Fri, 28 Feb 2020 21:04:40 +0000 (UTC)
Received: from localhost (unused-10-15-17-6.yyz.redhat.com [10.15.17.6])
 by smtp.corp.redhat.com (Postfix) with ESMTP id AED2C92D01;
 Fri, 28 Feb 2020 21:04:37 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>,
	qemu-devel@nongnu.org
Subject: [PULL 4/4] vl: Abort if multiple machines are registered as default
Date: Fri, 28 Feb 2020 16:04:27 -0500
Message-Id: <20200228210427.474606-5-ehabkost@redhat.com>
In-Reply-To: <20200228210427.474606-1-ehabkost@redhat.com>
References: <20200228210427.474606-1-ehabkost@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

It would be confusing to have multiple default machines.
Abort if this ever occurs.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Message-Id: <20200207161948.15972-4-philmd@redhat.com>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Tested-by: Laurent Vivier <laurent@vivier.eu>
---
 softmmu/vl.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/softmmu/vl.c b/softmmu/vl.c
index 705ee6f841..5549f4b619 100644
--- a/softmmu/vl.c
+++ b/softmmu/vl.c
@@ -1163,16 +1163,18 @@ static MachineClass *find_machine(const char *name,=
 GSList *machines)
 static MachineClass *find_default_machine(GSList *machines)
 {
     GSList *el;
+    MachineClass *default_machineclass =3D NULL;
=20
     for (el =3D machines; el; el =3D el->next) {
         MachineClass *mc =3D el->data;
=20
         if (mc->is_default) {
-            return mc;
+            assert(default_machineclass =3D=3D NULL && "Multiple default m=
achines");
+            default_machineclass =3D mc;
         }
     }
=20
-    return NULL;
+    return default_machineclass;
 }
=20
 static int machine_help_func(QemuOpts *opts, MachineState *machine)
--=20
2.24.1


