Return-Path: <SRS0=T2pn=YE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86838C47404
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2019 11:23:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C33621A4A
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2019 11:23:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C33621A4A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48626 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIt1a-0001oF-9B
	for qemu-devel@archiver.kernel.org; Fri, 11 Oct 2019 07:23:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43513)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jfreimann@redhat.com>) id 1iIsyw-0006pI-Ay
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 07:21:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jfreimann@redhat.com>) id 1iIsyu-0001ul-Kx
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 07:21:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47094)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jfreimann@redhat.com>)
 id 1iIsyu-0001uX-Cj
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 07:21:12 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id A43533090FDE;
 Fri, 11 Oct 2019 11:21:11 +0000 (UTC)
Received: from localhost (dhcp-192-238.str.redhat.com [10.33.192.238])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7F21B5D9C3;
 Fri, 11 Oct 2019 11:21:02 +0000 (UTC)
From: Jens Freimann <jfreimann@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 05/10] qapi: add failover negotiated event
Date: Fri, 11 Oct 2019 13:20:10 +0200
Message-Id: <20191011112015.11785-6-jfreimann@redhat.com>
In-Reply-To: <20191011112015.11785-1-jfreimann@redhat.com>
References: <20191011112015.11785-1-jfreimann@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.43]); Fri, 11 Oct 2019 11:21:11 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: parav@mellanox.com, mst@redhat.com, aadam@redhat.com, dgilbert@redhat.com,
 alex.williamson@redhat.com, laine@redhat.com, ailan@redhat.com,
 ehabkost@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This event is sent to let libvirt know that VIRTIO_NET_F_STANDBY
feature was not negotiated during virtio feature negotiation. If this
event is received it means any primary devices hotplugged before
this were were never really added to QEMU devices.

Signed-off-by: Jens Freimann <jfreimann@redhat.com>
---
 qapi/net.json | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/qapi/net.json b/qapi/net.json
index 728990f4fb..8c5f3f1fb2 100644
--- a/qapi/net.json
+++ b/qapi/net.json
@@ -737,3 +737,19 @@
 ##
 { 'command': 'announce-self', 'boxed': true,
   'data' : 'AnnounceParameters'}
+
+##
+# @FAILOVER_NEGOTIATED:
+#
+# Emitted when VIRTIO_NET_F_STANDBY was negotiated during feature negoti=
ation
+#
+# Since: 4.2
+#
+# Example:
+#
+# <- { "event": "FAILOVER_NEGOTIATED",
+#      "data": {} }
+#
+##
+{ 'event': 'FAILOVER_NEGOTIATED',
+  'data': {} }
--=20
2.21.0


