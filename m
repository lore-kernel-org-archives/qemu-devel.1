Return-Path: <SRS0=qR42=YW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A1EACA9EAE
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Oct 2019 11:58:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 638202086A
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Oct 2019 11:58:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EQpBOV05"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 638202086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55388 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iPQ8j-0005pZ-1H
	for qemu-devel@archiver.kernel.org; Tue, 29 Oct 2019 07:58:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40617)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jfreimann@redhat.com>) id 1iPQ1S-0005sd-3O
 for qemu-devel@nongnu.org; Tue, 29 Oct 2019 07:50:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jfreimann@redhat.com>) id 1iPQ1R-0002Zq-1d
 for qemu-devel@nongnu.org; Tue, 29 Oct 2019 07:50:50 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:39648)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jfreimann@redhat.com>)
 id 1iPQ1Q-0002Yw-9M
 for qemu-devel@nongnu.org; Tue, 29 Oct 2019 07:50:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1572349846;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dMxCkQqQ81+XieGHkRmNtptV6lSyK7Nuc9eatSPqjTs=;
 b=EQpBOV05R1YRVLzet+m8vRAM7WgKiMf6bFrJM+cQyBjT/FL1E5hhhg+v5Mc58z+sXM/53F
 JlO+dsLn8Z4hH5f4xu9PcANgPXoh69/yxnIqztnnYO2D4Rl+Qat35RzcK6AHa6EO0pdho2
 X1+LPvAb++vCI4mjIxRJ4iM9JM2rmlc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-8-0v6aYrgYMKq173X_1B4PRw-1; Tue, 29 Oct 2019 07:50:41 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C4A8F85B6EE;
 Tue, 29 Oct 2019 11:50:40 +0000 (UTC)
Received: from localhost (ovpn-116-231.ams2.redhat.com [10.36.116.231])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E815B60870;
 Tue, 29 Oct 2019 11:50:39 +0000 (UTC)
From: Jens Freimann <jfreimann@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v7 06/11] qapi: add failover negotiated event
Date: Tue, 29 Oct 2019 12:49:00 +0100
Message-Id: <20191029114905.6856-7-jfreimann@redhat.com>
In-Reply-To: <20191029114905.6856-1-jfreimann@redhat.com>
References: <20191029114905.6856-1-jfreimann@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: 0v6aYrgYMKq173X_1B4PRw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
Cc: berrange@redhat.com, ehabkost@redhat.com, mst@redhat.com, aadam@redhat.com,
 jasowang@redhat.com, quintela@redhat.com, dgilbert@redhat.com,
 armbru@redhat.com, alex.williamson@redhat.com, laine@redhat.com,
 pbonzini@redhat.com, ailan@redhat.com, parav@mellanox.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This event is sent to let libvirt know that VIRTIO_NET_F_STANDBY feature
is enabled. The primary device this virtio-net (standby) device is
associated with, is now hotplugged by the virtio-net device.

Signed-off-by: Jens Freimann <jfreimann@redhat.com>
---
 qapi/net.json | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/qapi/net.json b/qapi/net.json
index 728990f4fb..ea6eeee4f7 100644
--- a/qapi/net.json
+++ b/qapi/net.json
@@ -737,3 +737,22 @@
 ##
 { 'command': 'announce-self', 'boxed': true,
   'data' : 'AnnounceParameters'}
+
+##
+# @FAILOVER_NEGOTIATED:
+#
+# Emitted when VIRTIO_NET_F_STANDBY was enabled during feature negotiation=
.
+# Failover primary devices which were hidden (not hotplugged when requeste=
d)
+# before will now be hotplugged by the virtio-net standby device.
+#
+# device-id: QEMU device id of the unplugged device
+# Since: 4.2
+#
+# Example:
+#
+# <- { "event": "FAILOVER_NEGOTIATED",
+#      "data": "net1" }
+#
+##
+{ 'event': 'FAILOVER_NEGOTIATED',
+  'data': {'device-id': 'str'} }
--=20
2.21.0


