Return-Path: <SRS0=gSpC=6G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E340EC54FCB
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 13:15:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A0F692077D
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 13:15:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QuUhs/xR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0F692077D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50378 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRFDU-0007Y2-Of
	for qemu-devel@archiver.kernel.org; Wed, 22 Apr 2020 09:15:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46868)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jRF69-0003n5-Gd
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 09:07:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jRF66-0003jx-0O
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 09:07:29 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:33734
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jRF65-0003fv-IG
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 09:07:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587560844;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fidAYO+9hszl7oApQssrrQ9tS5TjJYShG/nQrI4K8HU=;
 b=QuUhs/xRtgmJeM4s7dM5LsUitr5ZMqAr0oKUE4lb2WgT43mQ9Pg3OIUX6xxevnuH5sazpO
 S5A8WlrhfkWAQhUN2tw6uyr9nEHUKic/q+Fpt0uOHm1UyM1jRvFgPFYflJbzRcY3vc1IdQ
 /yw6vREOwWqn2uNXx5wNy3t/6w+Tpyk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-217-Fv6SnpdwPb2ugqxmOswErw-1; Wed, 22 Apr 2020 09:07:22 -0400
X-MC-Unique: Fv6SnpdwPb2ugqxmOswErw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C6FBC18CA247
 for <qemu-devel@nongnu.org>; Wed, 22 Apr 2020 13:07:21 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-113-6.ams2.redhat.com [10.36.113.6])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 945DA60C88;
 Wed, 22 Apr 2020 13:07:21 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 0795211358BF; Wed, 22 Apr 2020 15:07:20 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 03/14] cpus: Fix configure_icount() error API violation
Date: Wed, 22 Apr 2020 15:07:08 +0200
Message-Id: <20200422130719.28225-4-armbru@redhat.com>
In-Reply-To: <20200422130719.28225-1-armbru@redhat.com>
References: <20200422130719.28225-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.81; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/22 02:12:04
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
Cc: Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The Error ** argument must be NULL, &error_abort, &error_fatal, or a
pointer to a variable containing NULL.  Passing an argument of the
latter kind twice without clearing it in between is wrong: if the
first call sets an error, it no longer points to NULL for the second
call.

configure_icount() is wrong that way.  Harmless, because its @errp is
always &error_abort or &error_fatal.

Just as wrong (and just as harmless): when it fails, it can still
update global state.

Fix all that.

Cc: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 cpus.c | 51 ++++++++++++++++++++++++++++++---------------------
 1 file changed, 30 insertions(+), 21 deletions(-)

diff --git a/cpus.c b/cpus.c
index ef441bdf62..1b542b37f9 100644
--- a/cpus.c
+++ b/cpus.c
@@ -797,40 +797,49 @@ void cpu_ticks_init(void)
=20
 void configure_icount(QemuOpts *opts, Error **errp)
 {
-    const char *option;
+    const char *option =3D qemu_opt_get(opts, "shift");
+    bool sleep =3D qemu_opt_get_bool(opts, "sleep", true);
+    bool align =3D qemu_opt_get_bool(opts, "align", false);
+    long time_shift =3D -1;
     char *rem_str =3D NULL;
=20
-    option =3D qemu_opt_get(opts, "shift");
-    if (!option) {
-        if (qemu_opt_get(opts, "align") !=3D NULL) {
-            error_setg(errp, "Please specify shift option when using align=
");
-        }
+    if (!option && qemu_opt_get(opts, "align")) {
+        error_setg(errp, "Please specify shift option when using align");
         return;
     }
=20
-    icount_sleep =3D qemu_opt_get_bool(opts, "sleep", true);
+    if (align && !sleep) {
+        error_setg(errp, "align=3Don and sleep=3Doff are incompatible");
+        return;
+    }
+
+    if (strcmp(option, "auto") !=3D 0) {
+        errno =3D 0;
+        time_shift =3D strtol(option, &rem_str, 0);
+        if (errno !=3D 0 || *rem_str !=3D '\0' || !strlen(option)) {
+            error_setg(errp, "icount: Invalid shift value");
+            return;
+        }
+    } else if (icount_align_option) {
+        error_setg(errp, "shift=3Dauto and align=3Don are incompatible");
+        return;
+    } else if (!icount_sleep) {
+        error_setg(errp, "shift=3Dauto and sleep=3Doff are incompatible");
+        return;
+    }
+
+    icount_sleep =3D sleep;
     if (icount_sleep) {
         timers_state.icount_warp_timer =3D timer_new_ns(QEMU_CLOCK_VIRTUAL=
_RT,
                                          icount_timer_cb, NULL);
     }
=20
-    icount_align_option =3D qemu_opt_get_bool(opts, "align", false);
+    icount_align_option =3D align;
=20
-    if (icount_align_option && !icount_sleep) {
-        error_setg(errp, "align=3Don and sleep=3Doff are incompatible");
-    }
-    if (strcmp(option, "auto") !=3D 0) {
-        errno =3D 0;
-        timers_state.icount_time_shift =3D strtol(option, &rem_str, 0);
-        if (errno !=3D 0 || *rem_str !=3D '\0' || !strlen(option)) {
-            error_setg(errp, "icount: Invalid shift value");
-        }
+    if (time_shift >=3D 0) {
+        timers_state.icount_time_shift =3D time_shift;
         use_icount =3D 1;
         return;
-    } else if (icount_align_option) {
-        error_setg(errp, "shift=3Dauto and align=3Don are incompatible");
-    } else if (!icount_sleep) {
-        error_setg(errp, "shift=3Dauto and sleep=3Doff are incompatible");
     }
=20
     use_icount =3D 2;
--=20
2.21.1


