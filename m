Return-Path: <SRS0=d4IR=4I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1457DC11D12
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2020 16:57:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D91F220801
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2020 16:57:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fotyVy9T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D91F220801
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46104 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4p96-0004G2-2b
	for qemu-devel@archiver.kernel.org; Thu, 20 Feb 2020 11:57:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34987)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jusual@redhat.com>) id 1j4p7X-0001bE-UD
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 11:56:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jusual@redhat.com>) id 1j4p7W-0003cK-AX
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 11:56:15 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:22363
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jusual@redhat.com>) id 1j4p7W-0003c7-7A
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 11:56:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582217772;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=MR2xy9h3+TeHGqE8C15PVFs0Ntc53grKi8YbA0xN9Zw=;
 b=fotyVy9T4QF7XSofAeqzCGd6zYpQdC1gzCIoKLdorURqUR6rk7nRQGjHqn+cEmx+GfEzfz
 ZmALoYrGzpNI0QR8rtUM9ST3vThSYEAU8OI4QNeEKuyUsTSyj7ie1by0Ltx1KLx/jlkFe9
 TUsFt8b0AXJdb3GFk3lBFyHYaaQI92A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-357-ygaaks2SNqup-B5kczDP1g-1; Thu, 20 Feb 2020 11:56:10 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 81A7E107ACC4
 for <qemu-devel@nongnu.org>; Thu, 20 Feb 2020 16:56:09 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-204-157.brq.redhat.com
 [10.40.204.157])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2E21684BCC;
 Thu, 20 Feb 2020 16:56:01 +0000 (UTC)
From: Julia Suvorova <jusual@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] qdev-monitor: Forbid repeated device_del
Date: Thu, 20 Feb 2020 17:55:56 +0100
Message-Id: <20200220165556.39388-1-jusual@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: ygaaks2SNqup-B5kczDP1g-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Julia Suvorova <jusual@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Device unplug can be done asynchronously. Thus, sending the second
device_del before the previous unplug is complete may lead to
unexpected results. On PCIe devices, this cancels the hot-unplug
process.

Signed-off-by: Julia Suvorova <jusual@redhat.com>
---
 qdev-monitor.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/qdev-monitor.c b/qdev-monitor.c
index 8ce71a206b..8a2a9538cd 100644
--- a/qdev-monitor.c
+++ b/qdev-monitor.c
@@ -887,6 +887,12 @@ void qmp_device_del(const char *id, Error **errp)
 {
     DeviceState *dev =3D find_device_state(id, errp);
     if (dev !=3D NULL) {
+        if (dev->pending_deleted_event) {
+            error_setg(errp, "Device %s is already in the "
+                             "process of unplug", id);
+            return;
+        }
+
         qdev_unplug(dev, errp);
     }
 }
--=20
2.24.1


