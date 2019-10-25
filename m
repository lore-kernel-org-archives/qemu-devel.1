Return-Path: <SRS0=bySr=YS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8F2FCA9EA0
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 12:29:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C53C2084C
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 12:29:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z7d8tU7S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C53C2084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59338 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNyiY-0001VC-Mq
	for qemu-devel@archiver.kernel.org; Fri, 25 Oct 2019 08:29:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50461)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jfreimann@redhat.com>) id 1iNyZy-0004Xb-5S
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 08:20:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jfreimann@redhat.com>) id 1iNyZw-00078f-Fk
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 08:20:29 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:48018
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jfreimann@redhat.com>)
 id 1iNyZw-00078P-Bo
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 08:20:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1572006027;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aovuIgy1P3PdVoLkBnYKklpbnFWIRj6bjX96lsBnopI=;
 b=Z7d8tU7SuDdC8uZyFW1leAFR02vmmvnrT41nPgf7fNiEFdXNr/+w9FLOoW/Nf6GAiLcSAi
 6UqkgNDLgMqKUj8VJVnToiGycvvDWWuCJIJPbXvQdV2O1t1Q3i4ye9s252NTGZvvHPaacY
 zPy9HhZI85cqbdsKz4BA48o7390SUTY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-296-6qEPX8mzOayV4ExWYreyUA-1; Fri, 25 Oct 2019 08:20:24 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9EC7A5E9;
 Fri, 25 Oct 2019 12:20:23 +0000 (UTC)
Received: from localhost (ovpn-117-235.ams2.redhat.com [10.36.117.235])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B4AAE5C223;
 Fri, 25 Oct 2019 12:20:14 +0000 (UTC)
From: Jens Freimann <jfreimann@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v6 05/11] qapi: add unplug primary event
Date: Fri, 25 Oct 2019 14:19:24 +0200
Message-Id: <20191025121930.6855-6-jfreimann@redhat.com>
In-Reply-To: <20191025121930.6855-1-jfreimann@redhat.com>
References: <20191025121930.6855-1-jfreimann@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: 6qEPX8mzOayV4ExWYreyUA-1
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
Cc: pkrempa@redhat.com, berrange@redhat.com, ehabkost@redhat.com,
 mst@redhat.com, aadam@redhat.com, jasowang@redhat.com, dgilbert@redhat.com,
 armbru@redhat.com, alex.williamson@redhat.com, laine@redhat.com,
 ailan@redhat.com, parav@mellanox.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This event is emitted when we sent a request to unplug a
failover primary device from the Guest OS and it includes the
device id of the primary device.

Signed-off-by: Jens Freimann <jfreimann@redhat.com>
Acked-by: Cornelia Huck <cohuck@redhat.com>
---
 qapi/migration.json | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/qapi/migration.json b/qapi/migration.json
index 82feb5bd39..e9e7a97c03 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -1448,3 +1448,22 @@
 # Since: 3.0
 ##
 { 'command': 'migrate-pause', 'allow-oob': true }
+
+##
+# @UNPLUG_PRIMARY:
+#
+# Emitted from source side of a migration when migration state is
+# WAIT_UNPLUG. Device was unplugged by guest operating system.
+# Device resources in QEMU are kept on standby to be able to re-plug it in=
 case
+# of migration failure.
+#
+# @device-id: QEMU device id of the unplugged device
+#
+# Since: 4.2
+#
+# Example:
+#   {"event": "UNPLUG_PRIMARY", "data": {"device-id": "hostdev0"} }
+#
+##
+{ 'event': 'UNPLUG_PRIMARY',
+  'data': { 'device-id': 'str' } }
--=20
2.21.0


