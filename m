Return-Path: <SRS0=buBk=6M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06EB7C83000
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 16:42:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C261E206D6
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 16:42:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MCU24AOs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C261E206D6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38836 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTTJn-0005ze-MX
	for qemu-devel@archiver.kernel.org; Tue, 28 Apr 2020 12:42:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34378)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jTTFE-0006hi-4I
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 12:38:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jTTBm-0000su-Rj
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 12:38:03 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:23869
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jTTBm-0000sD-9r
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 12:34:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588091669;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hAzx4L6XZ95jKtwmSOGit0Azv0WOaUz0H5sjP4J0U58=;
 b=MCU24AOsgOMp5zPf5FLuDVuKuur77Ij43lVfn9bncbzpB1vKp08Cvao/e5x7WoOkopgPTh
 OPUWjDWpPJgqVH66TPCyxRe7kJwPRBQ1ZpV1D3omAQbI1S+yRNGzxnmPmTLNP9A6YMMCrk
 KwsZN9caikirNAvSzneO4c/Zw7FUei4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-213-M7vD1GpJNYW_lT3xfGSFMQ-1; Tue, 28 Apr 2020 12:34:27 -0400
X-MC-Unique: M7vD1GpJNYW_lT3xfGSFMQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 82A92EC1A3;
 Tue, 28 Apr 2020 16:34:26 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-113-6.ams2.redhat.com [10.36.113.6])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 29A3C6918A;
 Tue, 28 Apr 2020 16:34:25 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 2609911358C8; Tue, 28 Apr 2020 18:34:20 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 12/17] qdev: Clean up qdev_connect_gpio_out_named()
Date: Tue, 28 Apr 2020 18:34:14 +0200
Message-Id: <20200428163419.4483-13-armbru@redhat.com>
In-Reply-To: <20200428163419.4483-1-armbru@redhat.com>
References: <20200428163419.4483-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.81; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/28 04:11:46
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
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
Cc: pbonzini@redhat.com, Peter Crosthwaite <peter.crosthwaite@xilinx.com>,
 berrange@redhat.com, ehabkost@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Both qdev_connect_gpio_out_named() and device_set_realized() put
objects without a parent into the "/machine/unattached/" orphanage.

qdev_connect_gpio_out_named() needs a lengthy comment to explain how
it works.  It exploits that object_property_add_child() can fail only
when we got a parent already, and ignoring that error does what we
want.  True.  If it failed due to "duplicate property", we'd be in
trouble, but that would be a programming error.

device_set_realized() is cleaner: it checks whether we need a parent,
then calls object_property_add_child(), aborting on failure.  No need
for a comment, and programming errors get caught.

Change qdev_connect_gpio_out_named() to match.

Cc: Peter Crosthwaite <peter.crosthwaite@xilinx.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 hw/core/qdev.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/hw/core/qdev.c b/hw/core/qdev.c
index c3a6a11b19..888a1de931 100644
--- a/hw/core/qdev.c
+++ b/hw/core/qdev.c
@@ -541,15 +541,12 @@ void qdev_connect_gpio_out_named(DeviceState *dev, co=
nst char *name, int n,
 {
     char *propname =3D g_strdup_printf("%s[%d]",
                                      name ? name : "unnamed-gpio-out", n);
-    if (pin) {
-        /* We need a name for object_property_set_link to work.  If the
-         * object has a parent, object_property_add_child will come back
-         * with an error without doing anything.  If it has none, it will
-         * never fail.  So we can just call it with a NULL Error pointer.
-         */
+    if (pin && !OBJECT(pin)->parent) {
+        /* We need a name for object_property_set_link to work */
         object_property_add_child(container_get(qdev_get_machine(),
                                                 "/unattached"),
-                                  "non-qdev-gpio[*]", OBJECT(pin), NULL);
+                                  "non-qdev-gpio[*]", OBJECT(pin),
+                                  &error_abort);
     }
     object_property_set_link(OBJECT(dev), OBJECT(pin), propname, &error_ab=
ort);
     g_free(propname);
--=20
2.21.1


