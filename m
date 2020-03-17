Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03E00C1975A
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 20:19:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BCB252051A
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 20:19:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Nq75zUXe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BCB252051A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40828 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEIgu-0002mi-Ty
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 16:19:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33229)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1jEIeN-0008Ep-Nb
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 16:17:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1jEIeM-00081m-GN
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 16:17:19 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:51213)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1jEIeM-0007ze-Cb
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 16:17:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584476238;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Srff7EUbPO7ccQO9oqvxam9/2s+uONoH4QC6YsPP9q8=;
 b=Nq75zUXexOYMPGZ+R2l9G6Q8UA3jQv1KC6TjrAWX0J8iHCAAPQOzbGyiW8PIE6+TnDAkhL
 +WVSlO4SdOYQJlILHh8CLpSV22HWjjfneaCs1kljHN6jMFEiQEan8cW63FaADEZVuwcUtr
 l6JlObIeDoyolxCcTk1jK6Q/uDK1znU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-307-PkJiHCcaOHqr7TtZrif-oQ-1; Tue, 17 Mar 2020 16:17:16 -0400
X-MC-Unique: PkJiHCcaOHqr7TtZrif-oQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2C10B100726D;
 Tue, 17 Mar 2020 20:17:15 +0000 (UTC)
Received: from blue.redhat.com (ovpn-112-193.phx2.redhat.com [10.3.112.193])
 by smtp.corp.redhat.com (Postfix) with ESMTP id ADE4910027A3;
 Tue, 17 Mar 2020 20:17:14 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 2/2] net: Track netdevs in NetClientState rather than
 QemuOpt
Date: Tue, 17 Mar 2020 15:17:11 -0500
Message-Id: <20200317201711.322764-3-eblake@redhat.com>
In-Reply-To: <20200317201711.322764-1-eblake@redhat.com>
References: <20200317201711.322764-1-eblake@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
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
Cc: lekiravi@yandex-team.ru, jasowang@redhat.com, armbru@redhat.com,
 dgilbert@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

As mentioned in the previous patch, our use of QemuOpt group "netdev"
has two purposes: collect the CLI arguments, and serve as a witness
for monitor hotplug actions.  As the latter didn't use anything but an
id, it felt rather unclean to have to touch QemuOpts at all when going
through QMP, so let's instead track things with a bool field in
NetClientState.

Suggested-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Eric Blake <eblake@redhat.com>
---
 include/net/net.h |  1 +
 monitor/misc.c    |  4 +---
 net/net.c         | 37 +++++++++++--------------------------
 3 files changed, 13 insertions(+), 29 deletions(-)

diff --git a/include/net/net.h b/include/net/net.h
index 96e6eae8176e..094e966af9ec 100644
--- a/include/net/net.h
+++ b/include/net/net.h
@@ -98,6 +98,7 @@ struct NetClientState {
     unsigned rxfilter_notify_enabled:1;
     int vring_enable;
     int vnet_hdr_len;
+    bool is_netdev;
     QTAILQ_HEAD(, NetFilterState) filters;
 };

diff --git a/monitor/misc.c b/monitor/misc.c
index 41a86e7012a1..6c45fa490ff5 100644
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
index a2065aabede2..38778e831da2 100644
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

@@ -1172,34 +1181,12 @@ void netdev_add(QemuOpts *opts, Error **errp)

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

 void qmp_netdev_del(const char *id, Error **errp)
 {
     NetClientState *nc;
-    QemuOpts *opts;

     nc =3D qemu_find_netdev(id);
     if (!nc) {
@@ -1208,14 +1195,12 @@ void qmp_netdev_del(const char *id, Error **errp)
         return;
     }

-    opts =3D qemu_opts_find(qemu_find_opts_err("netdev", NULL), id);
-    if (!opts) {
+    if (!nc->is_netdev) {
         error_setg(errp, "Device '%s' is not a netdev", id);
         return;
     }

     qemu_del_net_client(nc);
-    qemu_opts_del(opts);
 }

 static void netfilter_print_info(Monitor *mon, NetFilterState *nf)
--=20
2.25.1


