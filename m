Return-Path: <SRS0=U1cK=W6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37DA8C3A5A7
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 16:33:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0656323431
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 16:33:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="S3Sut9hL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0656323431
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=yandex-team.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49012 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5Bjm-0001h6-Jb
	for qemu-devel@archiver.kernel.org; Tue, 03 Sep 2019 12:32:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39736)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <yury-kotov@yandex-team.ru>) id 1i5BaD-0007SO-Uu
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 12:23:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <yury-kotov@yandex-team.ru>) id 1i5BaA-00038h-Ti
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 12:23:04 -0400
Received: from forwardcorp1o.mail.yandex.net ([95.108.205.193]:59092)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <yury-kotov@yandex-team.ru>)
 id 1i5BaA-00037n-Do
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 12:23:02 -0400
Received: from mxbackcorp2j.mail.yandex.net (mxbackcorp2j.mail.yandex.net
 [IPv6:2a02:6b8:0:1619::119])
 by forwardcorp1o.mail.yandex.net (Yandex) with ESMTP id B629E2E1A62;
 Tue,  3 Sep 2019 19:22:58 +0300 (MSK)
Received: from smtpcorp1j.mail.yandex.net (smtpcorp1j.mail.yandex.net
 [2a02:6b8:0:1619::137])
 by mxbackcorp2j.mail.yandex.net (nwsmtp/Yandex) with ESMTP id
 J6jqIXOprU-MwHCePmU; Tue, 03 Sep 2019 19:22:58 +0300
Precedence: bulk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; 
 t=1567527778; bh=RfLaBlEPI6MnPWvGLruW14dFethPiRdLhIDC3oOifJM=;
 h=In-Reply-To:Message-Id:References:Date:Subject:To:From:Cc;
 b=S3Sut9hLZXZdg/ExTBWZ4I2zju1AQ9rKizg+MwpvFzl0IGYq3EdgW7HUvr+cvGpTZ
 xL1caVpA6bHOEff2GHg+kM+dT7U34nRUxsrK+gfK0aBU6X9bAV0dnepbZlAgEaBHdE
 JR7x08ln9+1Y3F6WMgmt/zwAWFDwzeXWv2hfa1w0=
Authentication-Results: mxbackcorp2j.mail.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Received: from dynamic-red.dhcp.yndx.net (dynamic-red.dhcp.yndx.net
 [2a02:6b8:0:408:c43c:5d37:585c:b5d6])
 by smtpcorp1j.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id
 YFfYaDvJaP-MvfaZnfX; Tue, 03 Sep 2019 19:22:58 +0300
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (Client certificate not present)
From: Yury Kotov <yury-kotov@yandex-team.ru>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Eric Blake <eblake@redhat.com>, Juan Quintela <quintela@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Date: Tue,  3 Sep 2019 19:22:44 +0300
Message-Id: <20190903162246.18524-2-yury-kotov@yandex-team.ru>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190903162246.18524-1-yury-kotov@yandex-team.ru>
References: <20190903162246.18524-1-yury-kotov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 95.108.205.193
Subject: [Qemu-devel] [PATCH v2 1/3] migration: Add validate-uuid capability
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: qemu-devel@nongnu.org, yc-core@yandex-team.ru
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This capability realizes simple source validation by UUID.
It's useful for live migration between hosts.

Signed-off-by: Yury Kotov <yury-kotov@yandex-team.ru>
---
 migration/migration.c |  9 +++++++++
 migration/migration.h |  1 +
 migration/savevm.c    | 45 +++++++++++++++++++++++++++++++++++++++++++
 qapi/migration.json   |  5 ++++-
 4 files changed, 59 insertions(+), 1 deletion(-)

diff --git a/migration/migration.c b/migration/migration.c
index 8b9f2fe30a..2391a8d418 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -2140,6 +2140,15 @@ bool migrate_ignore_shared(void)
     return s->enabled_capabilities[MIGRATION_CAPABILITY_X_IGNORE_SHARED]=
;
 }
=20
+bool migrate_validate_uuid(void)
+{
+    MigrationState *s;
+
+    s =3D migrate_get_current();
+
+    return s->enabled_capabilities[MIGRATION_CAPABILITY_VALIDATE_UUID];
+}
+
 bool migrate_use_events(void)
 {
     MigrationState *s;
diff --git a/migration/migration.h b/migration/migration.h
index 3e1ea2b5dc..4f2fe193dc 100644
--- a/migration/migration.h
+++ b/migration/migration.h
@@ -290,6 +290,7 @@ bool migrate_postcopy_ram(void);
 bool migrate_zero_blocks(void);
 bool migrate_dirty_bitmaps(void);
 bool migrate_ignore_shared(void);
+bool migrate_validate_uuid(void);
=20
 bool migrate_auto_converge(void);
 bool migrate_use_multifd(void);
diff --git a/migration/savevm.c b/migration/savevm.c
index 4a86128ac4..493dc24fd2 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -256,6 +256,7 @@ typedef struct SaveState {
     uint32_t target_page_bits;
     uint32_t caps_count;
     MigrationCapability *capabilities;
+    QemuUUID uuid;
 } SaveState;
=20
 static SaveState savevm_state =3D {
@@ -307,6 +308,7 @@ static int configuration_pre_save(void *opaque)
             state->capabilities[j++] =3D i;
         }
     }
+    state->uuid =3D qemu_uuid;
=20
     return 0;
 }
@@ -464,6 +466,48 @@ static const VMStateDescription vmstate_capabilites =
=3D {
     }
 };
=20
+static bool vmstate_uuid_needed(void *opaque)
+{
+    return qemu_uuid_set && migrate_validate_uuid();
+}
+
+static int vmstate_uuid_post_load(void *opaque, int version_id)
+{
+    SaveState *state =3D opaque;
+    char uuid_src[UUID_FMT_LEN + 1];
+    char uuid_dst[UUID_FMT_LEN + 1];
+
+    if (!qemu_uuid_set) {
+        /*
+         * It's warning because user might not know UUID in some cases,
+         * e.g. load an old snapshot
+         */
+        qemu_uuid_unparse(&state->uuid, uuid_src);
+        warn_report("UUID is received %s, but local uuid isn't set",
+                     uuid_src);
+        return 0;
+    }
+    if (!qemu_uuid_is_equal(&state->uuid, &qemu_uuid)) {
+        qemu_uuid_unparse(&state->uuid, uuid_src);
+        qemu_uuid_unparse(&qemu_uuid, uuid_dst);
+        error_report("UUID received is %s and local is %s", uuid_src, uu=
id_dst);
+        return -EINVAL;
+    }
+    return 0;
+}
+
+static const VMStateDescription vmstate_uuid =3D {
+    .name =3D "configuration/uuid",
+    .version_id =3D 1,
+    .minimum_version_id =3D 1,
+    .needed =3D vmstate_uuid_needed,
+    .post_load =3D vmstate_uuid_post_load,
+    .fields =3D (VMStateField[]) {
+        VMSTATE_UINT8_ARRAY_V(uuid.data, SaveState, sizeof(QemuUUID), 1)=
,
+        VMSTATE_END_OF_LIST()
+    }
+};
+
 static const VMStateDescription vmstate_configuration =3D {
     .name =3D "configuration",
     .version_id =3D 1,
@@ -478,6 +522,7 @@ static const VMStateDescription vmstate_configuration=
 =3D {
     .subsections =3D (const VMStateDescription*[]) {
         &vmstate_target_page_bits,
         &vmstate_capabilites,
+        &vmstate_uuid,
         NULL
     }
 };
diff --git a/qapi/migration.json b/qapi/migration.json
index 9cfbaf8c6c..82feb5bd39 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -415,6 +415,9 @@
 #
 # @x-ignore-shared: If enabled, QEMU will not migrate shared memory (sin=
ce 4.0)
 #
+# @validate-uuid: Send the UUID of the source to allow the destination
+#                 to ensure it is the same. (since 4.2)
+#
 # Since: 1.2
 ##
 { 'enum': 'MigrationCapability',
@@ -422,7 +425,7 @@
            'compress', 'events', 'postcopy-ram', 'x-colo', 'release-ram'=
,
            'block', 'return-path', 'pause-before-switchover', 'multifd',
            'dirty-bitmaps', 'postcopy-blocktime', 'late-block-activate',
-           'x-ignore-shared' ] }
+           'x-ignore-shared', 'validate-uuid' ] }
=20
 ##
 # @MigrationCapabilityStatus:
--=20
2.17.1


