Return-Path: <SRS0=IvAo=6E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2228C3815B
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2020 08:34:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 917ED20CC7
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2020 08:34:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dWg61J3v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 917ED20CC7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59616 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jQRsO-0004k1-Nd
	for qemu-devel@archiver.kernel.org; Mon, 20 Apr 2020 04:34:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56440 helo=eggs1p.gnu.org)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jQRrA-0002sr-HL
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 04:32:45 -0400
Received: from Debian-exim by eggs1p.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jQRr9-0006tI-9X
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 04:32:44 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:36321
 helo=us-smtp-1.mimecast.com)
 by eggs1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jQRr8-0006rb-O7
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 04:32:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587371560;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fidAYO+9hszl7oApQssrrQ9tS5TjJYShG/nQrI4K8HU=;
 b=dWg61J3v5x5QA99KFuhwXaykFc1vWBBQYlYNUP2O44VDYIEinA+hHCU/zaJ3p3mJxd/FrN
 y+b7xsDDn3MFeTojvkElOBycRwJwQ9YTOWSCoxP0iX9sugtB5yse+6N0bBglQ+rEev3aM9
 zQkJvYyEitX7NE5nUfpUPTN6avrMY1E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-433-CWf20Rd8PYKHZhVUN4Knrg-1; Mon, 20 Apr 2020 04:32:39 -0400
X-MC-Unique: CWf20Rd8PYKHZhVUN4Knrg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 77854DB20
 for <qemu-devel@nongnu.org>; Mon, 20 Apr 2020 08:32:38 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-113-6.ams2.redhat.com [10.36.113.6])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 464EF60BE1;
 Mon, 20 Apr 2020 08:32:38 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id A60F511358BF; Mon, 20 Apr 2020 10:32:36 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 03/11] cpus: Fix configure_icount() error API violation
Date: Mon, 20 Apr 2020 10:32:28 +0200
Message-Id: <20200420083236.19309-4-armbru@redhat.com>
In-Reply-To: <20200420083236.19309-1-armbru@redhat.com>
References: <20200420083236.19309-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.120; envelope-from=armbru@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs1p.gnu.org: First seen = 2020/04/20
 03:29:13
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
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


