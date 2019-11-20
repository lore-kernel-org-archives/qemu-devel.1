Return-Path: <SRS0=6hMH=ZM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2904CC432C0
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 15:54:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E4FBB20714
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 15:54:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PnOovLJJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4FBB20714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59708 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXSJV-0001KA-MZ
	for qemu-devel@archiver.kernel.org; Wed, 20 Nov 2019 10:54:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37793)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jfreimann@redhat.com>) id 1iXSFC-000495-Is
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 10:50:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jfreimann@redhat.com>) id 1iXSFB-0002Oi-Ea
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 10:50:14 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:54455
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jfreimann@redhat.com>)
 id 1iXSFB-0002OP-AY
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 10:50:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574265013;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=S4GebjPiX21nLkyXjWoYg0C+5rWkbSfx0p5LGY4gmms=;
 b=PnOovLJJPUHMX010Dd7HTBf+e+uNSxeypP5YJjiUVYcSt7ou2H+6y4vP02lQuwchoW+GNA
 dXIidqamZKF0Pi4V5dILUhYtWONmAHOHVT+SS6N0Syaot88yEXh4lNMRbhLpYCmYeFXtEH
 7FFRWcBAdl8ysvs8r34Aw0INfMoAtAw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-411-s_5Py7XUPp6YRdu7CDl3Cg-1; Wed, 20 Nov 2019 10:50:11 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 76FDA800054;
 Wed, 20 Nov 2019 15:50:10 +0000 (UTC)
Received: from localhost (dhcp-192-217.str.redhat.com [10.33.192.217])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1FCFB63646;
 Wed, 20 Nov 2019 15:50:09 +0000 (UTC)
From: Jens Freimann <jfreimann@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 4/4] net/virtio: return error when device_opts arg is NULL
Date: Wed, 20 Nov 2019 16:49:51 +0100
Message-Id: <20191120154951.27877-5-jfreimann@redhat.com>
In-Reply-To: <20191120154951.27877-1-jfreimann@redhat.com>
References: <20191120154951.27877-1-jfreimann@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: s_5Py7XUPp6YRdu7CDl3Cg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
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
Cc: peter.maydell@linaro.org, jasowang@redhat.com, dgilbert@redhat.com,
 mst@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This fixes CID 1407222.

Fixes: 9711cd0dfc3f ("net/virtio: add failover support")
Signed-off-by: Jens Freimann <jfreimann@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/net/virtio-net.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index 565dea0b93..3c31471026 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -2880,9 +2880,12 @@ static int virtio_net_primary_should_be_hidden(Devic=
eListener *listener,
             QemuOpts *device_opts)
 {
     VirtIONet *n =3D container_of(listener, VirtIONet, primary_listener);
-    bool match_found;
-    bool hide;
+    bool match_found =3D false;
+    bool hide =3D false;
=20
+    if (!device_opts) {
+        return -1;
+    }
     n->primary_device_dict =3D qemu_opts_to_qdict(device_opts,
             n->primary_device_dict);
     if (n->primary_device_dict) {
@@ -2890,7 +2893,7 @@ static int virtio_net_primary_should_be_hidden(Device=
Listener *listener,
         n->standby_id =3D g_strdup(qdict_get_try_str(n->primary_device_dic=
t,
                     "failover_pair_id"));
     }
-    if (device_opts && g_strcmp0(n->standby_id, n->netclient_name) =3D=3D =
0) {
+    if (g_strcmp0(n->standby_id, n->netclient_name) =3D=3D 0) {
         match_found =3D true;
     } else {
         match_found =3D false;
--=20
2.21.0


