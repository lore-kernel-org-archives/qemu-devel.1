Return-Path: <SRS0=brme=YQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85BAECA9EB6
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 08:51:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D644205C9
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 08:51:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H2wTZd2m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D644205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57486 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNCMX-0008Iz-Dp
	for qemu-devel@archiver.kernel.org; Wed, 23 Oct 2019 04:51:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48548)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jfreimann@redhat.com>) id 1iNC0I-0003Iv-1a
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 04:28:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jfreimann@redhat.com>) id 1iNC0F-0006RM-Eg
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 04:28:25 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:39497
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jfreimann@redhat.com>)
 id 1iNC0F-0006Qq-91
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 04:28:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1571819302;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RDg9Tl3+mjfssH5RsGrJw5+5sFGZgOaBVb+IEJM3M2A=;
 b=H2wTZd2m94iPkHlwX0xAuZpttT4BggOofxeT6k1ioxn/dvnxpRlQn6e8TzRLXds8k3Ph8J
 Kd651VFVcSbu86moOzfrHPXE3Y+P+mxF+1xbNLCa7E7lA0TRpidvgQZS76TxHMNsl040F7
 aeJOf+d+i6eMWRbiT+jTexJe3PPIZ3I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-151-fSD6D3AXNN60JIhHXnwDyQ-1; Wed, 23 Oct 2019 04:28:19 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C05B11800D6B;
 Wed, 23 Oct 2019 08:28:18 +0000 (UTC)
Received: from localhost (dhcp-192-217.str.redhat.com [10.33.192.217])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9FB72600CC;
 Wed, 23 Oct 2019 08:28:11 +0000 (UTC)
From: Jens Freimann <jfreimann@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 06/11] qapi: add failover negotiated event
Date: Wed, 23 Oct 2019 10:27:06 +0200
Message-Id: <20191023082711.16694-7-jfreimann@redhat.com>
In-Reply-To: <20191023082711.16694-1-jfreimann@redhat.com>
References: <20191023082711.16694-1-jfreimann@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: fSD6D3AXNN60JIhHXnwDyQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: pkrempa@redhat.com, berrange@redhat.com, ehabkost@redhat.com,
 mst@redhat.com, aadam@redhat.com, dgilbert@redhat.com,
 alex.williamson@redhat.com, laine@redhat.com, ailan@redhat.com,
 parav@mellanox.com
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
+# Emitted when VIRTIO_NET_F_STANDBY was negotiated during feature negotiat=
ion
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


