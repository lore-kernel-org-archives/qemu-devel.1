Return-Path: <SRS0=7MIY=3D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0BD2C33CB1
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2020 11:50:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6BFA324676
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2020 11:50:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K71XJiIi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BFA324676
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37892 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1irKi7-0008BT-Q4
	for qemu-devel@archiver.kernel.org; Tue, 14 Jan 2020 06:50:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55738)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <quintela@redhat.com>) id 1irKZ4-0005eH-BP
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 06:40:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <quintela@redhat.com>) id 1irKZ0-0003Cz-LN
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 06:40:54 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:21981
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <quintela@redhat.com>) id 1irKZ0-0003Ch-HQ
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 06:40:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579002049;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YenyR+cDlGnKbLpY/elkWxAa8k3PezuARzjo1X24+Yw=;
 b=K71XJiIi+sXJdeF14lapyl97nH0ZNjPUF5S1L5bET1Z1CRFjT3DU7hJq2YQb1ZEsPBr8Ej
 gL9Rw235NI3Dinhx36alLZ1ItbfKXfVfIuti72cev951Oy6hBYMS0EWcx6kqBx8hHc2z5V
 Md9MGElMERM6NBxab1FJlNff9QtFnGQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-25-8fGRtCwAMV2KM030GiCjDA-1; Tue, 14 Jan 2020 06:40:48 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 33A5E18CA240;
 Tue, 14 Jan 2020 11:40:46 +0000 (UTC)
Received: from secure.mitica (ovpn-116-207.ams2.redhat.com [10.36.116.207])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D6FB65DA70;
 Tue, 14 Jan 2020 11:40:38 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 09/30] migration: Fix incorrect integer->float conversion
 caught by clang
Date: Tue, 14 Jan 2020 12:39:05 +0100
Message-Id: <20200114113926.3556-10-quintela@redhat.com>
In-Reply-To: <20200114113926.3556-1-quintela@redhat.com>
References: <20200114113926.3556-1-quintela@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: 8fGRtCwAMV2KM030GiCjDA-1
X-Mimecast-Spam-Score: 0
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Corey Minyard <cminyard@mvista.com>, Jason Wang <jasowang@redhat.com>,
 Juan Quintela <quintela@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Stefan Weil <sw@weilnetz.de>,
 Richard Henderson <richard.henderson@linaro.org>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-arm@nongnu.org,
 Richard Henderson <rth@twiddle.net>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Fangrui Song <i@maskray.me>, qemu-ppc@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Stefan Berger <stefanb@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Fangrui Song <i@maskray.me>

Clang does not like qmp_migrate_set_downtime()'s code to clamp double
@value to 0..INT64_MAX:

    qemu/migration/migration.c:2038:24: error: implicit conversion from 'lo=
ng' to 'double' changes value from 9223372036854775807 to 92233720368547758=
08 [-Werror,-Wimplicit-int-float-conversion]

The warning will be enabled by default in clang 10. It is not
available for clang <=3D 9.

The clamp is actually useless; @value is checked to be within
0..MAX_MIGRATE_DOWNTIME_SECONDS immediately before.  Delete it.

While there, make the conversion from double to int64_t explicit.

Signed-off-by: Fangrui Song <i@maskray.me>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Juan Quintela <quintela@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
[Patch split, commit message improved]
Signed-off-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 migration/migration.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index 27500d09a9..f79d0bf89a 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -2035,11 +2035,10 @@ void qmp_migrate_set_downtime(double value, Error *=
*errp)
     }
=20
     value *=3D 1000; /* Convert to milliseconds */
-    value =3D MAX(0, MIN(INT64_MAX, value));
=20
     MigrateSetParameters p =3D {
         .has_downtime_limit =3D true,
-        .downtime_limit =3D value,
+        .downtime_limit =3D (int64_t)value,
     };
=20
     qmp_migrate_set_parameters(&p, errp);
--=20
2.24.1


