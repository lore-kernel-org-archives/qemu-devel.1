Return-Path: <SRS0=U3m5=5X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD3E5C2BB1D
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2020 11:46:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8FE2620678
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2020 11:46:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8FE2620678
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45800 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jLmg4-0004AL-MV
	for qemu-devel@archiver.kernel.org; Tue, 07 Apr 2020 07:46:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55272)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <clg@kaod.org>) id 1jLmfB-0003Rp-Bu
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 07:45:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1jLmf8-0007yp-WB
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 07:45:05 -0400
Received: from 6.mo173.mail-out.ovh.net ([46.105.43.93]:42492)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1jLmf8-0007wF-Ji
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 07:45:02 -0400
Received: from player739.ha.ovh.net (unknown [10.108.35.59])
 by mo173.mail-out.ovh.net (Postfix) with ESMTP id 4B8ED136841
 for <qemu-devel@nongnu.org>; Tue,  7 Apr 2020 13:45:00 +0200 (CEST)
Received: from kaod.org (82-64-250-170.subs.proxad.net [82.64.250.170])
 (Authenticated sender: clg@kaod.org)
 by player739.ha.ovh.net (Postfix) with ESMTPSA id 56405D2B9B6E;
 Tue,  7 Apr 2020 11:44:53 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To: "Dr . David Alan Gilbert" <dgilbert@redhat.com>
Subject: [RFC PATCH] qom: Implement qom-get HMP command
Date: Tue,  7 Apr 2020 13:44:49 +0200
Message-Id: <20200407114449.482532-1-clg@kaod.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Ovh-Tracer-Id: 7474568006855920434
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduhedrudehgdeghecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffufffkofggtgfgsehtkeertdertdejnecuhfhrohhmpeevrogurhhitgcunfgvucfiohgrthgvrhcuoegtlhhgsehkrghougdrohhrgheqnecukfhppedtrddtrddtrddtpdekvddrieegrddvhedtrddujedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepphhlrgihvghrjeefledrhhgrrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpegtlhhgsehkrghougdrohhrghdprhgtphhtthhopehqvghmuhdquggvvhgvlhesnhhonhhgnhhurdhorhhg
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 46.105.43.93
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
Cc: =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Reimplement it based on qmp_qom_get() to avoid converting QObjects back
to strings.

Inspired-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Andreas F=C3=A4rber <afaerber@suse.de>

Slight fix for bit-rot:
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
[clg: updates for QEMU 5.0 ]
Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---

 I would like to restart the discussion on qom-get command to understand
 what was the conclusion and see if things have changed since.

 Thanks,

 C.

 include/monitor/hmp.h |  1 +
 qom/qom-hmp-cmds.c    | 23 +++++++++++++++++++++++
 hmp-commands.hx       | 13 +++++++++++++
 3 files changed, 37 insertions(+)

diff --git a/include/monitor/hmp.h b/include/monitor/hmp.h
index e33ca5a911a5..c986cfd28bc3 100644
--- a/include/monitor/hmp.h
+++ b/include/monitor/hmp.h
@@ -96,6 +96,7 @@ void hmp_info_memdev(Monitor *mon, const QDict *qdict);
 void hmp_info_numa(Monitor *mon, const QDict *qdict);
 void hmp_info_memory_devices(Monitor *mon, const QDict *qdict);
 void hmp_qom_list(Monitor *mon, const QDict *qdict);
+void hmp_qom_get(Monitor *mon, const QDict *qdict);
 void hmp_qom_set(Monitor *mon, const QDict *qdict);
 void hmp_info_qom_tree(Monitor *mon, const QDict *dict);
 void object_add_completion(ReadLineState *rs, int nb_args, const char *s=
tr);
diff --git a/qom/qom-hmp-cmds.c b/qom/qom-hmp-cmds.c
index cd08233a4cfe..b14cf6e785f4 100644
--- a/qom/qom-hmp-cmds.c
+++ b/qom/qom-hmp-cmds.c
@@ -40,6 +40,29 @@ void hmp_qom_list(Monitor *mon, const QDict *qdict)
     hmp_handle_error(mon, err);
 }
=20
+void hmp_qom_get(Monitor *mon, const QDict *qdict)
+{
+    const char *path =3D qdict_get_str(qdict, "path");
+    const char *property =3D qdict_get_str(qdict, "property");
+    Error *err =3D NULL;
+    Object *obj;
+    char *value;
+
+    obj =3D object_resolve_path(path, NULL);
+    if (obj =3D=3D NULL) {
+        error_set(&err, ERROR_CLASS_DEVICE_NOT_FOUND,
+                  "Device '%s' not found", path);
+        hmp_handle_error(mon, err);
+        return;
+    }
+    value =3D object_property_print(obj, property, true, &err);
+    if (err =3D=3D NULL) {
+        monitor_printf(mon, "%s\n", value);
+        g_free(value);
+    }
+    hmp_handle_error(mon, err);
+}
+
 void hmp_qom_set(Monitor *mon, const QDict *qdict)
 {
     const char *path =3D qdict_get_str(qdict, "path");
diff --git a/hmp-commands.hx b/hmp-commands.hx
index 7f0f3974ad90..4e39b9caed3e 100644
--- a/hmp-commands.hx
+++ b/hmp-commands.hx
@@ -1790,6 +1790,19 @@ SRST
   Print QOM properties of object at location *path*
 ERST
=20
+    {
+        .name       =3D "qom-get",
+        .args_type  =3D "path:s,property:s",
+        .params     =3D "path property",
+        .help       =3D "print QOM property",
+        .cmd        =3D hmp_qom_get,
+    },
+
+SRST
+``qom-get``  *path* *property*
+  Print QOM property *property* of object at location *path*
+ERST
+
     {
         .name       =3D "qom-set",
         .args_type  =3D "path:s,property:s,value:s",
--=20
2.25.1


