Return-Path: <SRS0=IjNW=VM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEFE2C76191
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2019 11:15:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AB0BD20665
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2019 11:15:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB0BD20665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37246 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hmyxH-0005vu-KX
	for qemu-devel@archiver.kernel.org; Mon, 15 Jul 2019 07:15:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47172)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dgilbert@redhat.com>) id 1hmywu-0004pX-49
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 07:15:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1hmyws-0002Th-77
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 07:15:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45706)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1hmywr-0002RL-Ug
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 07:15:14 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id C8D36307D88D
 for <qemu-devel@nongnu.org>; Mon, 15 Jul 2019 11:15:11 +0000 (UTC)
Received: from dgilbert-t580.localhost (ovpn-117-181.ams2.redhat.com
 [10.36.117.181])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0ECE71001B18;
 Mon, 15 Jul 2019 11:15:09 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org,
	dinechin@redhat.com
Date: Mon, 15 Jul 2019 12:15:01 +0100
Message-Id: <20190715111501.22368-2-dgilbert@redhat.com>
In-Reply-To: <20190715111501.22368-1-dgilbert@redhat.com>
References: <20190715111501.22368-1-dgilbert@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.48]); Mon, 15 Jul 2019 11:15:11 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 1/1] Fix build error when VNC is configured out
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

From: Christophe de Dinechin <dinechin@redhat.com>

In hmp_change(), the variable hmp_mon is only used
by code under #ifdef CONFIG_VNC. This results in a build
error when VNC is configured out with the default of
treating warnings as errors:

monitor/hmp-cmds.c: In function =E2=80=98hmp_change=E2=80=99:
monitor/hmp-cmds.c:1946:17: error: unused variable =E2=80=98hmp_mon=E2=80=
=99 [-Werror=3Dunused-variable]
1946 |     MonitorHMP *hmp_mon =3D container_of(mon, MonitorHMP, common);
     |                 ^~~~~~~

Signed-off-by: Christophe de Dinechin <dinechin@redhat.com>
Message-Id: <20190625123905.25434-1-dinechin@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 monitor/hmp-cmds.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/monitor/hmp-cmds.c b/monitor/hmp-cmds.c
index 99ceb0846b..5ca3ebe942 100644
--- a/monitor/hmp-cmds.c
+++ b/monitor/hmp-cmds.c
@@ -1962,7 +1962,6 @@ static void hmp_change_read_arg(void *opaque, const=
 char *password,
=20
 void hmp_change(Monitor *mon, const QDict *qdict)
 {
-    MonitorHMP *hmp_mon =3D container_of(mon, MonitorHMP, common);
     const char *device =3D qdict_get_str(qdict, "device");
     const char *target =3D qdict_get_str(qdict, "target");
     const char *arg =3D qdict_get_try_str(qdict, "arg");
@@ -1980,6 +1979,7 @@ void hmp_change(Monitor *mon, const QDict *qdict)
         if (strcmp(target, "passwd") =3D=3D 0 ||
             strcmp(target, "password") =3D=3D 0) {
             if (!arg) {
+                MonitorHMP *hmp_mon =3D container_of(mon, MonitorHMP, co=
mmon);
                 monitor_read_password(hmp_mon, hmp_change_read_arg, NULL=
);
                 return;
             }
--=20
2.21.0


