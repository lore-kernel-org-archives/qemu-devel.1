Return-Path: <SRS0=Y1tr=UJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	T_HK_NAME_DR autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C356C4321A
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Jun 2019 18:53:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ED121207E0
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Jun 2019 18:53:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED121207E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49010 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1haPPy-0005FN-PN
	for qemu-devel@archiver.kernel.org; Mon, 10 Jun 2019 14:53:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44696)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dgilbert@redhat.com>) id 1haPHM-0007Nd-7t
 for qemu-devel@nongnu.org; Mon, 10 Jun 2019 14:44:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1haPHI-00028R-Fs
 for qemu-devel@nongnu.org; Mon, 10 Jun 2019 14:44:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52028)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1haPHE-00025I-QT
 for qemu-devel@nongnu.org; Mon, 10 Jun 2019 14:44:18 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 2ECE73087BA9
 for <qemu-devel@nongnu.org>; Mon, 10 Jun 2019 18:44:14 +0000 (UTC)
Received: from dgilbert-t580.localhost (ovpn-117-16.ams2.redhat.com
 [10.36.117.16])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0513460BF1;
 Mon, 10 Jun 2019 18:44:12 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org, jasowang@redhat.com, eblake@redhat.com,
 armbru@redhat.com, laine@redhat.com
Date: Mon, 10 Jun 2019 19:44:02 +0100
Message-Id: <20190610184402.7090-5-dgilbert@redhat.com>
In-Reply-To: <20190610184402.7090-1-dgilbert@redhat.com>
References: <20190610184402.7090-1-dgilbert@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.45]); Mon, 10 Jun 2019 18:44:14 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v3 4/4] net/announce: Add HMP optional ID
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

Add the optional ID to the HMP command.

e.g.
   # start an announce for a long time on eth1
   migrate_set_parameter announce-rounds 1000
   announce_self "eth1" e1

   # start an announce on eth2
   announce_self "eth2" e2

   # Change e1 to be announcing on eth1 and eth3
   announce_self "eth1,eth3" e1

   # Cancel e1
   migrate_set_parameter announce-rounds 0
   announce_self "" e1

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 hmp-commands.hx | 7 ++++---
 hmp.c           | 3 +++
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/hmp-commands.hx b/hmp-commands.hx
index 1b63372713..7ba8543cc3 100644
--- a/hmp-commands.hx
+++ b/hmp-commands.hx
@@ -955,8 +955,8 @@ ETEXI
=20
     {
         .name       =3D "announce_self",
-        .args_type  =3D "interfaces:s?",
-        .params     =3D "[interfaces]",
+        .args_type  =3D "interfaces:s?,id:s?",
+        .params     =3D "[interfaces] [id]",
         .help       =3D "Trigger GARP/RARP announcements",
         .cmd        =3D hmp_announce_self,
     },
@@ -968,7 +968,8 @@ Trigger a round of GARP/RARP broadcasts; this is usef=
ul for explicitly updating
 network infrastructure after a reconfiguration or some forms of migratio=
n.
 The timings of the round are set by the migration announce parameters.
 An optional comma separated @var{interfaces} list restricts the announce=
 to the
-named set of interfaces.
+named set of interfaces. An optional @var{id} can be used to start a sep=
arate announce
+timer and to change the parameters of it later.
 ETEXI
=20
     {
diff --git a/hmp.c b/hmp.c
index 52efb4a4fa..fd498ca0a8 100644
--- a/hmp.c
+++ b/hmp.c
@@ -1669,12 +1669,15 @@ void hmp_info_snapshots(Monitor *mon, const QDict=
 *qdict)
 void hmp_announce_self(Monitor *mon, const QDict *qdict)
 {
     const char *interfaces_str =3D qdict_get_try_str(qdict, "interfaces"=
);
+    const char *id =3D qdict_get_try_str(qdict, "id");
     AnnounceParameters *params =3D QAPI_CLONE(AnnounceParameters,
                                             migrate_announce_params());
=20
     qapi_free_strList(params->interfaces);
     params->interfaces =3D strList_from_comma_list(interfaces_str);
     params->has_interfaces =3D params->interfaces !=3D NULL;
+    params->id =3D g_strdup(id);
+    params->has_id =3D !!params->id;
     qmp_announce_self(params, NULL);
     qapi_free_AnnounceParameters(params);
 }
--=20
2.21.0


