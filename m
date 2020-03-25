Return-Path: <SRS0=PjAl=5K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38C32C1975A
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 13:20:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0378B2078E
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 13:20:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i6lPXk3Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0378B2078E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36160 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jH5wu-0003Pq-4L
	for qemu-devel@archiver.kernel.org; Wed, 25 Mar 2020 09:20:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53083)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1jH5u2-00074M-F3
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 09:17:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1jH5u1-0006Nb-8g
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 09:17:02 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:50209)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1jH5u1-0006NO-5B
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 09:17:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585142220;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZdQEFDx+CXSDBGvTAB5sIDuw+cC9KWpbTVeUiMmRYAc=;
 b=i6lPXk3YqZcPPi7TKPr9q8eLOs0Ce+tbSkPNIVP0Kuc/1nM1dHesxIYOUFPOHWFwvFxHoB
 PbNQR5Agg+TTM3nAnlordkngNseLey1Bh+nrRaNE/3wf9o+cpn0zyr7NNK6dKt+Lg0jrkT
 41/C0POjvi5DIMzheMLjetzX/8yyA50=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-89-C4MujUplNGiLL0boZWio2w-1; Wed, 25 Mar 2020 09:16:58 -0400
X-MC-Unique: C4MujUplNGiLL0boZWio2w-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 72898802687;
 Wed, 25 Mar 2020 13:16:57 +0000 (UTC)
Received: from dgilbert-t580.localhost (ovpn-114-213.ams2.redhat.com
 [10.36.114.213])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1C84E5C298;
 Wed, 25 Mar 2020 13:16:55 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org, pannengyuan@huawei.com,
 maozhongyi@cmss.chinamobile.com, vsementsov@virtuozzo.com,
 imammedo@redhat.com, philmd@redhat.com
Subject: [PULL 9/9] migration: use "" instead of (null) for tls-authz
Date: Wed, 25 Mar 2020 13:16:32 +0000
Message-Id: <20200325131632.311034-10-dgilbert@redhat.com>
In-Reply-To: <20200325131632.311034-1-dgilbert@redhat.com>
References: <20200325131632.311034-1-dgilbert@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
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

From: Mao Zhongyi <maozhongyi@cmss.chinamobile.com>

run:
(qemu) info migrate_parameters
announce-initial: 50 ms
...
announce-max: 550 ms
multifd-compression: none
xbzrle-cache-size: 4194304
max-postcopy-bandwidth: 0
 tls-authz: '(null)'

Migration parameter 'tls-authz' is used to provide the QOM ID
of a QAuthZ subclass instance that provides the access control
check, default is NULL. But the empty string is not a valid
object ID, so use "" instead of the default. Although it will
fail when lookup an object with ID "", it is harmless, just
consistent with tls_creds.

As a bonus, this patch also fixed the bad indentation on the
last line and removed 'has_tls_authz' redundant check in
'hmp_info_migrate_parameters'.

Signed-off-by: Mao Zhongyi <maozhongyi@cmss.chinamobile.com>
Message-Id: <119f539a9f4d198bc3bcced46b8280520d60bc51.1585100802.git.maozho=
ngyi@cmss.chinamobile.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 migration/migration.c | 3 ++-
 monitor/hmp-cmds.c    | 4 ++--
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index 4b26110d57..c4c9aee15e 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -790,7 +790,8 @@ MigrationParameters *qmp_query_migrate_parameters(Error=
 **errp)
     params->has_tls_hostname =3D true;
     params->tls_hostname =3D g_strdup(s->parameters.tls_hostname);
     params->has_tls_authz =3D true;
-    params->tls_authz =3D g_strdup(s->parameters.tls_authz);
+    params->tls_authz =3D g_strdup(s->parameters.tls_authz ?
+                                 s->parameters.tls_authz : "");
     params->has_max_bandwidth =3D true;
     params->max_bandwidth =3D s->parameters.max_bandwidth;
     params->has_downtime_limit =3D true;
diff --git a/monitor/hmp-cmds.c b/monitor/hmp-cmds.c
index 04ca342c51..9b94e67879 100644
--- a/monitor/hmp-cmds.c
+++ b/monitor/hmp-cmds.c
@@ -459,9 +459,9 @@ void hmp_info_migrate_parameters(Monitor *mon, const QD=
ict *qdict)
         monitor_printf(mon, "%s: %" PRIu64 "\n",
             MigrationParameter_str(MIGRATION_PARAMETER_MAX_POSTCOPY_BANDWI=
DTH),
             params->max_postcopy_bandwidth);
-        monitor_printf(mon, " %s: '%s'\n",
+        monitor_printf(mon, "%s: '%s'\n",
             MigrationParameter_str(MIGRATION_PARAMETER_TLS_AUTHZ),
-            params->has_tls_authz ? params->tls_authz : "");
+            params->tls_authz);
     }
=20
     qapi_free_MigrationParameters(params);
--=20
2.25.1


