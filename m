Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85F06C2BB1D
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 21:06:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 50DFC2051A
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 21:06:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Gyk1qo4K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50DFC2051A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41420 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEJPg-0008Ej-Fm
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 17:06:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51468)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jEJL9-0002p1-Ia
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 17:01:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1jEJL4-0002eV-6P
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 17:01:30 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:37706)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1jEJL3-0002Zm-TB
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 17:01:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584478885;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nPARO1vXN+TA8DfH0V/DonvjOr9NCs6Vz6KhiahqUME=;
 b=Gyk1qo4KOyFRism6jgKgTUu8s4VaDqAQIkO6AL0JhcCWnueRjcfU9+vUkZKTFKm8SnYfg9
 UUYobdERUjFlWhmmDcIuYohjBbtZLvB5l7bDayEOHx01syKkrSxmNwMcHgxpzcWSjxAo0S
 AK/TS1RHfq4e76OvH9ZLg1IASrT8LT0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-455-lAmbIzv-OU-Is1pU5HBxtw-1; Tue, 17 Mar 2020 17:01:24 -0400
X-MC-Unique: lAmbIzv-OU-Is1pU5HBxtw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 048291005516
 for <qemu-devel@nongnu.org>; Tue, 17 Mar 2020 21:01:23 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-130.ams2.redhat.com
 [10.36.112.130])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C57A85C1D8;
 Tue, 17 Mar 2020 21:01:22 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id AE742113525D; Tue, 17 Mar 2020 22:01:15 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 30/30] net: Track netdevs in NetClientState rather than QemuOpt
Date: Tue, 17 Mar 2020 22:01:15 +0100
Message-Id: <20200317210115.8864-31-armbru@redhat.com>
In-Reply-To: <20200317210115.8864-1-armbru@redhat.com>
References: <20200317210115.8864-1-armbru@redhat.com>
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

From: Eric Blake <eblake@redhat.com>

As mentioned in the previous patch, our use of QemuOpt group "netdev"
has two purposes: collect the CLI arguments, and serve as a witness
for monitor hotplug actions.  As the latter didn't use anything but an
id, it felt rather unclean to have to touch QemuOpts at all when going
through QMP, so let's instead track things with a bool field in
NetClientState.

Suggested-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Eric Blake <eblake@redhat.com>
Message-Id: <20200317201711.322764-3-eblake@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 include/net/net.h |  1 +
 monitor/misc.c    |  4 +---
 net/net.c         | 37 +++++++++++--------------------------
 3 files changed, 13 insertions(+), 29 deletions(-)

diff --git a/include/net/net.h b/include/net/net.h
index 96e6eae817..094e966af9 100644
--- a/include/net/net.h
+++ b/include/net/net.h
@@ -98,6 +98,7 @@ struct NetClientState {
     unsigned rxfilter_notify_enabled:1;
     int vring_enable;
     int vnet_hdr_len;
+    bool is_netdev;
     QTAILQ_HEAD(, NetFilterState) filters;
 };
=20
diff --git a/monitor/misc.c b/monitor/misc.c
index 41a86e7012..6c45fa490f 100644
--- a/monitor/misc.c
+++ b/monitor/misc.c
@@ -2035,13 +2035,11 @@ void netdev_del_completion(ReadLineState *rs, int n=
b_args, const char *str)
     count =3D qemu_find_net_clients_except(NULL, ncs, NET_CLIENT_DRIVER_NI=
C,
                                          MAX_QUEUE_NUM);
     for (i =3D 0; i < MIN(count, MAX_QUEUE_NUM); i++) {
-        QemuOpts *opts;
         const char *name =3D ncs[i]->name;
         if (strncmp(str, name, len)) {
             continue;
         }
-        opts =3D qemu_opts_find(qemu_find_opts_err("netdev", NULL), name);
-        if (opts) {
+        if (ncs[i]->is_netdev) {
             readline_add_completion(rs, name);
         }
     }
diff --git a/net/net.c b/net/net.c
index a2065aabed..38778e831d 100644
--- a/net/net.c
+++ b/net/net.c
@@ -1060,6 +1060,15 @@ static int net_client_init1(const void *object, bool=
 is_netdev, Error **errp)
         }
         return -1;
     }
+
+    if (is_netdev) {
+        NetClientState *nc;
+
+        nc =3D qemu_find_netdev(netdev->id);
+        assert(nc);
+        nc->is_netdev =3D true;
+    }
+
     return 0;
 }
=20
@@ -1172,34 +1181,12 @@ void netdev_add(QemuOpts *opts, Error **errp)
=20
 void qmp_netdev_add(Netdev *netdev, Error **errp)
 {
-    Error *local_err =3D NULL;
-    QemuOptsList *opts_list;
-    QemuOpts *opts;
-
-    opts_list =3D qemu_find_opts_err("netdev", &local_err);
-    if (local_err) {
-        goto out;
-    }
-
-    opts =3D qemu_opts_create(opts_list, netdev->id, 1, &local_err);
-    if (local_err) {
-        goto out;
-    }
-
-    net_client_init1(netdev, true, &local_err);
-    if (local_err) {
-        qemu_opts_del(opts);
-        goto out;
-    }
-
-out:
-    error_propagate(errp, local_err);
+    net_client_init1(netdev, true, errp);
 }
=20
 void qmp_netdev_del(const char *id, Error **errp)
 {
     NetClientState *nc;
-    QemuOpts *opts;
=20
     nc =3D qemu_find_netdev(id);
     if (!nc) {
@@ -1208,14 +1195,12 @@ void qmp_netdev_del(const char *id, Error **errp)
         return;
     }
=20
-    opts =3D qemu_opts_find(qemu_find_opts_err("netdev", NULL), id);
-    if (!opts) {
+    if (!nc->is_netdev) {
         error_setg(errp, "Device '%s' is not a netdev", id);
         return;
     }
=20
     qemu_del_net_client(nc);
-    qemu_opts_del(opts);
 }
=20
 static void netfilter_print_info(Monitor *mon, NetFilterState *nf)
--=20
2.21.1


