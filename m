Return-Path: <SRS0=8N/K=Z4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80674C43603
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2019 05:38:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A7AB2245C
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2019 05:38:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OcL5mEzX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A7AB2245C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35842 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1id6Jq-0002XV-6s
	for qemu-devel@archiver.kernel.org; Fri, 06 Dec 2019 00:38:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37881)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1id6IR-0001fE-Fq
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 00:36:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1id6IP-00047v-Gg
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 00:36:54 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:31854
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>) id 1id6IP-00043y-Bt
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 00:36:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575610612;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YY8FOOL5oTPpCvzIkk6vxcAQ2Nu3DuSMiFoOEgtXOJY=;
 b=OcL5mEzXB/gjvPYM3Wp0gPXfigYe40At21f8emEy20+6yZCr4rkhZNhoO64YFQ+fh0hQd0
 5ATTaquLz/B5NNZzwzALJu/U/F4vawfFIaYbmYAyeHPkIjAIWLonzP/5UUHL4087+I0bSg
 FQx72r3amJM+9WPMIbnK3NPoZu2luK8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-167-0_dPT5VKOxarv0mlf0cF6w-1; Fri, 06 Dec 2019 00:36:50 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7D51980059D
 for <qemu-devel@nongnu.org>; Fri,  6 Dec 2019 05:36:49 +0000 (UTC)
Received: from thuth.com (ovpn-116-97.ams2.redhat.com [10.36.116.97])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 11FC560FC1;
 Fri,  6 Dec 2019 05:36:47 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org, Jason Wang <jasowang@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>
Subject: [PATCH 1/2] net: Drop the legacy "name" parameter from the -net option
Date: Fri,  6 Dec 2019 06:36:39 +0100
Message-Id: <20191206053640.29368-2-thuth@redhat.com>
In-Reply-To: <20191206053640.29368-1-thuth@redhat.com>
References: <20191206053640.29368-1-thuth@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: 0_dPT5VKOxarv0mlf0cF6w-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: libvir-list@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

It's been deprecated since QEMU v3.1, so it's time to finally
remove it. The "id" parameter can simply be used instead.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 net/net.c            | 10 +---------
 qapi/net.json        |  4 +---
 qemu-deprecated.texi | 12 +++++++-----
 3 files changed, 9 insertions(+), 17 deletions(-)

diff --git a/net/net.c b/net/net.c
index 84aa6d8d00..ee4a76eb3e 100644
--- a/net/net.c
+++ b/net/net.c
@@ -969,12 +969,10 @@ static int net_client_init1(const void *object, bool =
is_netdev, Error **errp)
 {
     Netdev legacy =3D {0};
     const Netdev *netdev;
-    const char *name;
     NetClientState *peer =3D NULL;
=20
     if (is_netdev) {
         netdev =3D object;
-        name =3D netdev->id;
=20
         if (netdev->type =3D=3D NET_CLIENT_DRIVER_NIC ||
             !net_client_init_fun[netdev->type]) {
@@ -987,12 +985,6 @@ static int net_client_init1(const void *object, bool i=
s_netdev, Error **errp)
         const NetLegacyOptions *opts =3D net->opts;
         legacy.id =3D net->id;
         netdev =3D &legacy;
-        /* missing optional values have been initialized to "all bits zero=
" */
-        name =3D net->has_id ? net->id : net->name;
-
-        if (net->has_name) {
-            warn_report("The 'name' parameter is deprecated, use 'id' inst=
ead");
-        }
=20
         /* Map the old options to the new flat type */
         switch (opts->type) {
@@ -1052,7 +1044,7 @@ static int net_client_init1(const void *object, bool =
is_netdev, Error **errp)
         }
     }
=20
-    if (net_client_init_fun[netdev->type](netdev, name, peer, errp) < 0) {
+    if (net_client_init_fun[netdev->type](netdev, netdev->id, peer, errp) =
< 0) {
         /* FIXME drop when all init functions store an Error */
         if (errp && !*errp) {
             error_setg(errp, QERR_DEVICE_INIT_FAILED,
diff --git a/qapi/net.json b/qapi/net.json
index 335295be50..ff280ccd16 100644
--- a/qapi/net.json
+++ b/qapi/net.json
@@ -488,18 +488,16 @@
 #
 # @id: identifier for monitor commands
 #
-# @name: identifier for monitor commands, ignored if @id is present
-#
 # @opts: device type specific properties (legacy)
 #
 # Since: 1.2
 #
 # 'vlan': dropped in 3.0
+# 'name': dropped in 5.0
 ##
 { 'struct': 'NetLegacy',
   'data': {
     '*id':   'str',
-    '*name': 'str',
     'opts':  'NetLegacyOptions' } }
=20
 ##
diff --git a/qemu-deprecated.texi b/qemu-deprecated.texi
index 2850f9a520..2f9efb45ba 100644
--- a/qemu-deprecated.texi
+++ b/qemu-deprecated.texi
@@ -42,11 +42,6 @@ The 'file' driver for drives is no longer appropriate fo=
r character or host
 devices and will only accept regular files (S_IFREG). The correct driver
 for these file types is 'host_cdrom' or 'host_device' as appropriate.
=20
-@subsection -net ...,name=3D@var{name} (since 3.1)
-
-The @option{name} parameter of the @option{-net} option is a synonym
-for the @option{id} parameter, which should now be used instead.
-
 @subsection -smp (invalid topologies) (since 3.1)
=20
 CPU topology properties should describe whole machine topology including
@@ -371,6 +366,13 @@ What follows is a record of recently removed, formerly=
 deprecated
 features that serves as a record for users who have encountered
 trouble after a recent upgrade.
=20
+@section System emulator command line arguments
+
+@subsection -net ...,name=3D@var{name} (removed in 5.0)
+
+The @option{name} parameter of the @option{-net} option was a synonym
+for the @option{id} parameter, which should now be used instead.
+
 @section Human Monitor Protocol (HMP) commands
=20
 @subsection The hub_id parameter of 'hostfwd_add' / 'hostfwd_remove' (remo=
ved in 5.0)
--=20
2.18.1


