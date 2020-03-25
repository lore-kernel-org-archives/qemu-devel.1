Return-Path: <SRS0=PjAl=5K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 824F0C54FD0
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 13:19:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4FB542077D
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 13:19:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d6v9oDGM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FB542077D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36152 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jH5wd-0002ms-BU
	for qemu-devel@archiver.kernel.org; Wed, 25 Mar 2020 09:19:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52983)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1jH5tp-0006bB-1A
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 09:16:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1jH5tn-0005zd-SY
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 09:16:48 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:33351)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1jH5tn-0005yo-PG
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 09:16:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585142207;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=w0e863PwX6d7J/JmPX14i8QvC2RmA0dRj3ib8BKw8Vk=;
 b=d6v9oDGMykDMYkFRO+zP1szH2eUfwRbKGtj04wlzbhzva0yUSnV/EV1LHjANG7g05ZYMBW
 ruE3dFgGeHA31K+t5m/KqyQNaRp38IKoztlB57l6x4GA2OSpc/1TOkeivhueuzU7b9m97Q
 GgtI00jyipPJhOiJo0hmjsYCnZymyrM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-40-okfhtMq_MCaZtVa_UVFyhQ-1; Wed, 25 Mar 2020 09:16:45 -0400
X-MC-Unique: okfhtMq_MCaZtVa_UVFyhQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5AD17107ACC4;
 Wed, 25 Mar 2020 13:16:39 +0000 (UTC)
Received: from dgilbert-t580.localhost (ovpn-114-213.ams2.redhat.com
 [10.36.114.213])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D9DC05C3F8;
 Wed, 25 Mar 2020 13:16:37 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org, pannengyuan@huawei.com,
 maozhongyi@cmss.chinamobile.com, vsementsov@virtuozzo.com,
 imammedo@redhat.com, philmd@redhat.com
Subject: [PULL 1/9] hmp-cmd: fix a missing_break warning
Date: Wed, 25 Mar 2020 13:16:24 +0000
Message-Id: <20200325131632.311034-2-dgilbert@redhat.com>
In-Reply-To: <20200325131632.311034-1-dgilbert@redhat.com>
References: <20200325131632.311034-1-dgilbert@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 63.128.21.74
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

From: Pan Nengyuan <pannengyuan@huawei.com>

This fix coverity issues 94417686:
    1260        break;
    CID 94417686: (MISSING_BREAK)
    1261. unterminated_case: The case for value "MIGRATION_PARAMETER_THROTT=
LE_TRIGGER_THRESHOLD" is not terminated by a 'break' statement.
    1261    case MIGRATION_PARAMETER_THROTTLE_TRIGGER_THRESHOLD:
    1262        p->has_throttle_trigger_threshold =3D true;
    1263        visit_type_int(v, param, &p->throttle_trigger_threshold, &e=
rr);
    1264    case MIGRATION_PARAMETER_CPU_THROTTLE_INITIAL:

Fixes: dc14a470763c96fd9d360e1028ce38e8c3613a77
Fixes: Coverity (CID 1421950)
Reported-by: Euler Robot <euler.robot@huawei.com>
Signed-off-by: Pan Nengyuan <pannengyuan@huawei.com>
Message-Id: <20200318071620.59748-1-pannengyuan@huawei.com>
Reviewed-by: Keqian Zhu <zhukeqian1@huawei.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 monitor/hmp-cmds.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/monitor/hmp-cmds.c b/monitor/hmp-cmds.c
index 58724031ea..c882c9f3cc 100644
--- a/monitor/hmp-cmds.c
+++ b/monitor/hmp-cmds.c
@@ -1261,6 +1261,7 @@ void hmp_migrate_set_parameter(Monitor *mon, const QD=
ict *qdict)
     case MIGRATION_PARAMETER_THROTTLE_TRIGGER_THRESHOLD:
         p->has_throttle_trigger_threshold =3D true;
         visit_type_int(v, param, &p->throttle_trigger_threshold, &err);
+        break;
     case MIGRATION_PARAMETER_CPU_THROTTLE_INITIAL:
         p->has_cpu_throttle_initial =3D true;
         visit_type_int(v, param, &p->cpu_throttle_initial, &err);
--=20
2.25.1


