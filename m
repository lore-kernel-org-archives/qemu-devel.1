Return-Path: <SRS0=JMAk=UT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	T_HK_NAME_DR autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FAF8C43613
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2019 19:39:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF889206BA
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2019 19:39:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF889206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52480 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1he2uE-0007uU-ER
	for qemu-devel@archiver.kernel.org; Thu, 20 Jun 2019 15:39:34 -0400
Received: from eggs.gnu.org ([209.51.188.92]:49925)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dgilbert@redhat.com>) id 1he26x-0003qq-Mz
 for qemu-devel@nongnu.org; Thu, 20 Jun 2019 14:48:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1he26v-0001QY-3F
 for qemu-devel@nongnu.org; Thu, 20 Jun 2019 14:48:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45372)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1he26t-0008Js-3G
 for qemu-devel@nongnu.org; Thu, 20 Jun 2019 14:48:35 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 1F97060CC
 for <qemu-devel@nongnu.org>; Thu, 20 Jun 2019 18:47:18 +0000 (UTC)
Received: from dgilbert-t580.localhost (ovpn-117-203.ams2.redhat.com
 [10.36.117.203])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E5E645D71C;
 Thu, 20 Jun 2019 18:47:16 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org, jasowang@redhat.com, eblake@redhat.com,
 armbru@redhat.com, laine@redhat.com
Date: Thu, 20 Jun 2019 19:47:05 +0100
Message-Id: <20190620184706.19988-5-dgilbert@redhat.com>
In-Reply-To: <20190620184706.19988-1-dgilbert@redhat.com>
References: <20190620184706.19988-1-dgilbert@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.30]); Thu, 20 Jun 2019 18:47:18 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v5 4/5] net/announce: Add HMP optional ID
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
 hmp-commands.hx    | 7 ++++---
 monitor/hmp-cmds.c | 3 +++
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/hmp-commands.hx b/hmp-commands.hx
index c2a2df9708..61d0be29d8 100644
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
diff --git a/monitor/hmp-cmds.c b/monitor/hmp-cmds.c
index a3d34b12fe..96715c7103 100644
--- a/monitor/hmp-cmds.c
+++ b/monitor/hmp-cmds.c
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


