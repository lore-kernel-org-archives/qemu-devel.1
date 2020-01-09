Return-Path: <SRS0=I8Mx=26=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F319C282DD
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2020 15:32:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1247620721
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2020 15:32:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LUYQVGDx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1247620721
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34214 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipZn4-0002wR-Hi
	for qemu-devel@archiver.kernel.org; Thu, 09 Jan 2020 10:32:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40807)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1ipZe1-0007TH-70
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 10:22:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1ipZdz-00051L-2G
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 10:22:44 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:33502
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1ipZdy-0004yw-Tk
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 10:22:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578583362;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QE12T9YoIYg3KiaFxYrMJ0Yi0XSnGIdy/p9v0TlJLU8=;
 b=LUYQVGDxFAnmlIiseUs6xK8lp4hk3/WqcCptjQ8uZdsFqBUHBMv0q7gVKUcHxOPGBaTZtS
 QOoI4AtgQ0Seaue4wVckJdeHLvw2CCKVFAqIGmmSYVeRpXCfglYnglugGXItuSSk/svsmr
 OwPYYd1Oz1ojLiOmTYgjBo5wXXrSd1I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-232-3uSQJtr2O2yD9tYK2nha0g-1; Thu, 09 Jan 2020 10:22:38 -0500
X-MC-Unique: 3uSQJtr2O2yD9tYK2nha0g-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2E55D84E291;
 Thu,  9 Jan 2020 15:22:37 +0000 (UTC)
Received: from x1w.redhat.com (ovpn-204-180.brq.redhat.com [10.40.204.180])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D285C1CB;
 Thu,  9 Jan 2020 15:22:31 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 06/15] migration/savevm: Replace current_machine by
 qdev_get_machine()
Date: Thu,  9 Jan 2020 16:21:24 +0100
Message-Id: <20200109152133.23649-7-philmd@redhat.com>
In-Reply-To: <20200109152133.23649-1-philmd@redhat.com>
References: <20200109152133.23649-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <ehabkost@redhat.com>, kvm@vger.kernel.org,
 Juan Quintela <quintela@redhat.com>, qemu-ppc@nongnu.org,
 Marcelo Tosatti <mtosatti@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-arm@nongnu.org,
 Alistair Francis <alistair.francis@wdc.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

As we want to remove the global current_machine,
replace MACHINE_GET_CLASS(current_machine) by
MACHINE_GET_CLASS(qdev_get_machine()).

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 migration/savevm.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/migration/savevm.c b/migration/savevm.c
index 59efc1981d..0e8b6a4715 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -292,7 +292,8 @@ static uint32_t get_validatable_capabilities_count(vo=
id)
 static int configuration_pre_save(void *opaque)
 {
     SaveState *state =3D opaque;
-    const char *current_name =3D MACHINE_GET_CLASS(current_machine)->nam=
e;
+    MachineClass *mc =3D MACHINE_GET_CLASS(qdev_get_machine());
+    const char *current_name =3D mc->name;
     MigrationState *s =3D migrate_get_current();
     int i, j;
=20
@@ -362,7 +363,8 @@ static bool configuration_validate_capabilities(SaveS=
tate *state)
 static int configuration_post_load(void *opaque, int version_id)
 {
     SaveState *state =3D opaque;
-    const char *current_name =3D MACHINE_GET_CLASS(current_machine)->nam=
e;
+    MachineClass *mc =3D MACHINE_GET_CLASS(qdev_get_machine());
+    const char *current_name =3D mc->name;
=20
     if (strncmp(state->name, current_name, state->len) !=3D 0) {
         error_report("Machine type received is '%.*s' and local is '%s'"=
,
@@ -615,9 +617,7 @@ static void dump_vmstate_vmsd(FILE *out_file,
=20
 static void dump_machine_type(FILE *out_file)
 {
-    MachineClass *mc;
-
-    mc =3D MACHINE_GET_CLASS(current_machine);
+    MachineClass *mc =3D MACHINE_GET_CLASS(qdev_get_machine());
=20
     fprintf(out_file, "  \"vmschkmachine\": {\n");
     fprintf(out_file, "    \"Name\": \"%s\"\n", mc->name);
--=20
2.21.1


