Return-Path: <SRS0=Qmby=6N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32CD0C83007
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 11:07:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ED3E9206C0
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 11:07:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WJ9bTePb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED3E9206C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47542 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTkZI-00037q-3A
	for qemu-devel@archiver.kernel.org; Wed, 29 Apr 2020 07:07:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44836)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kraxel@redhat.com>) id 1jTkUw-0005Bk-VN
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 07:03:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <kraxel@redhat.com>) id 1jTkTz-0003ys-DY
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 07:03:26 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:44903
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jTkTx-0003sl-CS
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 07:02:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588158144;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=F1VEyEy6/SYTd+tGBUceu/egLeZngUGGZbtKyuAeHtE=;
 b=WJ9bTePbx53Miii0twfP+ccP48dWKC4q+vynWoXiIkxWu53FOOguGizQVH7MZEsdj4E4xD
 9HyXUWGGP+H+LBHgynMYkuJa64WJHkHgSWaWsTro/AuPUgCe4BbTy+9wQjXMyUWr5N7Kao
 K2l916ljPoj2VIqnr+WPnFM3fQI1l5g=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-368-Upyp2VRHOz-7PtxZqr6rWA-1; Wed, 29 Apr 2020 07:02:19 -0400
X-MC-Unique: Upyp2VRHOz-7PtxZqr6rWA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1E63BEC1A2
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2020 11:02:19 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-113-193.ams2.redhat.com
 [10.36.113.193])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 080255D9F1;
 Wed, 29 Apr 2020 11:02:16 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 20ACD9D9C; Wed, 29 Apr 2020 13:02:15 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 03/12] audio: add deprecated_register_soundhw
Date: Wed, 29 Apr 2020 13:02:05 +0200
Message-Id: <20200429110214.29037-4-kraxel@redhat.com>
In-Reply-To: <20200429110214.29037-1-kraxel@redhat.com>
References: <20200429110214.29037-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.120; envelope-from=kraxel@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/29 01:42:37
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
 Eduardo Habkost <ehabkost@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add helper function for -soundhw deprecation.  It can replace the
simple init functions which just call {isa,pci}_create_simple()
with a hardcoded type.  It also prints a deprecation message.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 include/hw/audio/soundhw.h |  2 ++
 hw/audio/soundhw.c         | 24 +++++++++++++++++++++++-
 2 files changed, 25 insertions(+), 1 deletion(-)

diff --git a/include/hw/audio/soundhw.h b/include/hw/audio/soundhw.h
index c8eef8241846..f09a297854af 100644
--- a/include/hw/audio/soundhw.h
+++ b/include/hw/audio/soundhw.h
@@ -6,6 +6,8 @@ void isa_register_soundhw(const char *name, const char *des=
cr,
=20
 void pci_register_soundhw(const char *name, const char *descr,
                           int (*init_pci)(PCIBus *bus));
+void deprecated_register_soundhw(const char *name, const char *descr,
+                                 int isa, const char *typename);
=20
 void soundhw_init(void);
 void select_soundhw(const char *optarg);
diff --git a/hw/audio/soundhw.c b/hw/audio/soundhw.c
index c750473c8f0c..173b674ff53a 100644
--- a/hw/audio/soundhw.c
+++ b/hw/audio/soundhw.c
@@ -22,6 +22,7 @@
  * THE SOFTWARE.
  */
 #include "qemu/osdep.h"
+#include "qemu/option.h"
 #include "qemu/help_option.h"
 #include "qemu/error-report.h"
 #include "qom/object.h"
@@ -32,6 +33,7 @@
 struct soundhw {
     const char *name;
     const char *descr;
+    const char *typename;
     int enabled;
     int isa;
     union {
@@ -65,6 +67,17 @@ void pci_register_soundhw(const char *name, const char *=
descr,
     soundhw_count++;
 }
=20
+void deprecated_register_soundhw(const char *name, const char *descr,
+                                 int isa, const char *typename)
+{
+    assert(soundhw_count < ARRAY_SIZE(soundhw) - 1);
+    soundhw[soundhw_count].name =3D name;
+    soundhw[soundhw_count].descr =3D descr;
+    soundhw[soundhw_count].isa =3D isa;
+    soundhw[soundhw_count].typename =3D typename;
+    soundhw_count++;
+}
+
 void select_soundhw(const char *optarg)
 {
     struct soundhw *c;
@@ -136,7 +149,16 @@ void soundhw_init(void)
=20
     for (c =3D soundhw; c->name; ++c) {
         if (c->enabled) {
-            if (c->isa) {
+            if (c->typename) {
+                warn_report("'-soundhw %s' is deprecated, "
+                            "please use '-device %s' instead",
+                            c->name, c->typename);
+                if (c->isa) {
+                    isa_create_simple(isa_bus, c->typename);
+                } else {
+                    pci_create_simple(pci_bus, -1, c->typename);
+                }
+            } else if (c->isa) {
                 if (!isa_bus) {
                     error_report("ISA bus not available for %s", c->name);
                     exit(1);
--=20
2.18.2


