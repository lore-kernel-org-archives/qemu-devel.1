Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0796BC10DCE
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 01:35:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BCBF720663
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 01:35:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KboQaqPK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BCBF720663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32946 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDeev-0006ST-Hl
	for qemu-devel@archiver.kernel.org; Sun, 15 Mar 2020 21:35:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57273)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jDdLw-0008FJ-Km
 for qemu-devel@nongnu.org; Sun, 15 Mar 2020 20:11:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jDdLu-0004SK-Is
 for qemu-devel@nongnu.org; Sun, 15 Mar 2020 20:11:32 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:54767
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jDdLu-0004OK-EA
 for qemu-devel@nongnu.org; Sun, 15 Mar 2020 20:11:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584317489;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PL9v4CeGO/2oc9s92a/R9E/v/MDOYA5KsXid6uFaEzU=;
 b=KboQaqPKwqrDJMghpJFVZjRTiQYxnt3GEaXcWJort8dZzYNBJb6xeT/ovFopXL1e17P856
 oxXZdcrn+LS4AxtJ0iSrW9sqGmgPLk6/qjjwUTjqka1Cq3sqX3dDg+jwHQEvgPYk5LGw3l
 sz2zREJusMAARoOsH/uzqwXV++7fzg0=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-74-12iizrilNICfVH_XfYAsBA-1; Sun, 15 Mar 2020 20:11:27 -0400
X-MC-Unique: 12iizrilNICfVH_XfYAsBA-1
Received: by mail-wr1-f70.google.com with SMTP id b12so8207499wro.4
 for <qemu-devel@nongnu.org>; Sun, 15 Mar 2020 17:11:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Z/zbte99k4d/M7DBGyDBjG9o4G746mqNhzLp9Pz4m/w=;
 b=e7cL6xsFbojZIywZ3p2aE9A7QcsLYG4QLbeplkgV/4DuccdoqMoaq/cGUP7n80hsc3
 BcL6xyElZ2U8MTcoTztgIXMyrga5xkeH7T6B3XGe6bFAy6sLmlR7pVmzKWfkD4I/D03e
 61Z2/udQ32lqg6+6sq38/EF6jg4BDxtRpADXjj6QS/M4+PTFgzU/lh9zqB2txMO+XgF/
 uozVqyr8H+26MrtOrL6JtejPIGhF8MyWUZg9bsJlboO9GhewGpyNJDk07uS99a9t/qy4
 p87gE3qBx76AhIFmnemVv0VvfLWfXucllj91S/7FV1a4l2qAWmH2PEfOOZxRRqeUTR5v
 FqnQ==
X-Gm-Message-State: ANhLgQ0VfK8FrEt3Q6IOFg8Qc+ebX2XlIKYQnVuKKrukQ8nQ0s9YxnZC
 zLWcGENQgTyx/OlhpT8GGjmSTumQqKQSVhuefIBwIqFzyKdylyUhZF/U5RhkEIyR7VQ9xp8eqje
 lmJ1LOQAt3CGpGZs=
X-Received: by 2002:a1c:2358:: with SMTP id j85mr25807428wmj.137.1584317485187; 
 Sun, 15 Mar 2020 17:11:25 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vtymsgRj0mrAJNPsEgdU5AEA8Svcc7shBBY9ByFbMcPebmUKjEk2yAZlPPkxZkTU9TPcTsfpw==
X-Received: by 2002:a1c:2358:: with SMTP id j85mr25807406wmj.137.1584317484960; 
 Sun, 15 Mar 2020 17:11:24 -0700 (PDT)
Received: from localhost.localdomain (191.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.191])
 by smtp.gmail.com with ESMTPSA id m10sm713458wmc.24.2020.03.15.17.11.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Mar 2020 17:11:24 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 2/9] hw/core/qdev-properties: Use qemu_strtoul() in
 set_pci_host_devaddr()
Date: Mon, 16 Mar 2020 01:11:04 +0100
Message-Id: <20200316001111.31004-3-philmd@redhat.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200316001111.31004-1-philmd@redhat.com>
References: <20200316001111.31004-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Michael Roth <mdroth@linux.vnet.ibm.com>,
 Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Replace strtoul() by qemu_strtoul() so checkpatch.pl won't
complain if we move this code later. Increase the slot and
func local variables to unsigned long so that the range check
isn't truncated. Remove the 'e =3D=3D p' test which is done in
check_strtox_error(), called by qemu_strtoul().

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
v2: drop the e =3D=3D p test, do not do modify range check (rth)
---
 hw/core/qdev-properties.c | 25 ++++++++++++-------------
 1 file changed, 12 insertions(+), 13 deletions(-)

diff --git a/hw/core/qdev-properties.c b/hw/core/qdev-properties.c
index 48e4c98cf0..0e4da655c1 100644
--- a/hw/core/qdev-properties.c
+++ b/hw/core/qdev-properties.c
@@ -820,10 +820,10 @@ static void set_pci_host_devaddr(Object *obj, Visitor=
 *v, const char *name,
     PCIHostDeviceAddress *addr =3D qdev_get_prop_ptr(dev, prop);
     Error *local_err =3D NULL;
     char *str, *p;
-    char *e;
+    const char *e;
     unsigned long val;
     unsigned long dom =3D 0, bus =3D 0;
-    unsigned int slot =3D 0, func =3D 0;
+    unsigned long slot =3D 0, func =3D 0;
=20
     if (dev->realized) {
         qdev_prop_set_after_realize(dev, name, errp);
@@ -837,23 +837,23 @@ static void set_pci_host_devaddr(Object *obj, Visitor=
 *v, const char *name,
     }
=20
     p =3D str;
-    val =3D strtoul(p, &e, 16);
-    if (e =3D=3D p || *e !=3D ':') {
+    if (qemu_strtoul(p, &e, 16, &val) < 0) {
+        goto inval;
+    }
+    if (*e !=3D ':') {
         goto inval;
     }
     bus =3D val;
=20
-    p =3D e + 1;
-    val =3D strtoul(p, &e, 16);
-    if (e =3D=3D p) {
+    p =3D (char *)e + 1;
+    if (qemu_strtoul(p, &e, 16, &val) < 0) {
         goto inval;
     }
     if (*e =3D=3D ':') {
         dom =3D bus;
         bus =3D val;
-        p =3D e + 1;
-        val =3D strtoul(p, &e, 16);
-        if (e =3D=3D p) {
+        p =3D (char *)e + 1;
+        if (qemu_strtoul(p, &e, 16, &val) < 0) {
             goto inval;
         }
     }
@@ -862,9 +862,8 @@ static void set_pci_host_devaddr(Object *obj, Visitor *=
v, const char *name,
     if (*e !=3D '.') {
         goto inval;
     }
-    p =3D e + 1;
-    val =3D strtoul(p, &e, 10);
-    if (e =3D=3D p) {
+    p =3D (char *)e + 1;
+    if (qemu_strtoul(p, &e, 10, &val) < 0) {
         goto inval;
     }
     func =3D val;
--=20
2.21.1


