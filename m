Return-Path: <SRS0=1jZz=6T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FACCC47247
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 15:35:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 38BA8206B9
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 15:35:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YTIevjcM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38BA8206B9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56500 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVzb9-0000iI-7n
	for qemu-devel@archiver.kernel.org; Tue, 05 May 2020 11:35:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45986)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jVzVp-0003Lq-MF
 for qemu-devel@nongnu.org; Tue, 05 May 2020 11:29:37 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:26883
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jVzVl-0007Qk-Kq
 for qemu-devel@nongnu.org; Tue, 05 May 2020 11:29:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588692572;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/KTY1YJwO4io6kj73OhAeYOH0wTKz3YRUEyHY+Q3lGM=;
 b=YTIevjcM8c5yHWF/93tnCiih4mygP069mqN02DVqrOMVM5fVWA6OhD3VBggr7FlYM2tbx0
 HIjEVbAaonU0BR8o2/7q0q2hNw8bQZXVz5yASYErGOGOvSUHiey2UJ723emKwkjXkyoBhw
 ZxQWuQGSEg0Mt1ztt873vLWzxkaOmYE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-335-nXEETCDnO9mp4KZrMeNo6w-1; Tue, 05 May 2020 11:29:30 -0400
X-MC-Unique: nXEETCDnO9mp4KZrMeNo6w-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9E522107ACF4;
 Tue,  5 May 2020 15:29:29 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-113-6.ams2.redhat.com [10.36.113.6])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 68CB35C1BD;
 Tue,  5 May 2020 15:29:29 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 58C3D11358CA; Tue,  5 May 2020 17:29:26 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 13/18] qdev: Clean up qdev_connect_gpio_out_named()
Date: Tue,  5 May 2020 17:29:21 +0200
Message-Id: <20200505152926.18877-14-armbru@redhat.com>
In-Reply-To: <20200505152926.18877-1-armbru@redhat.com>
References: <20200505152926.18877-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.81; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/05 00:37:19
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: Peter Crosthwaite <peter.crosthwaite@xilinx.com>, berrange@redhat.com,
 ehabkost@redhat.com, philmd@redhat.com, pbonzini@redhat.com
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
Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 hw/core/qdev.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/hw/core/qdev.c b/hw/core/qdev.c
index ea7118ab0e..2e6c29ba78 100644
--- a/hw/core/qdev.c
+++ b/hw/core/qdev.c
@@ -542,15 +542,12 @@ void qdev_connect_gpio_out_named(DeviceState *dev, co=
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


