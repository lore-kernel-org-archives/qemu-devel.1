Return-Path: <SRS0=Qmby=6N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93C98C83007
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 07:24:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 602A72076B
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 07:24:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gLtccPIV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 602A72076B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59688 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTh5M-0004kd-Cy
	for qemu-devel@archiver.kernel.org; Wed, 29 Apr 2020 03:24:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46094)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jTh1k-0007tE-O7
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 03:22:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jTh1b-0003t3-Vj
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 03:21:04 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:27377
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jTh1b-0003qB-Bn
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 03:20:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588144853;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PPD7lNvI/SDnbRnovak9k9THltlmpEMwSUgo+tpzTEw=;
 b=gLtccPIVPvustBe3mR3/FT8ZTIIZke7tr/1RxEfsgPw4Lb4fFZHs11mFem3h33tvxtsReI
 7POzoiS8qVF4y07F3xCOSMIiHQaCw6ncxRDlluWSFVikOOckqF+5KQso8FoYPotSMOws1h
 UM0ABWzoC4EIyWBQ7WsIZoriQTyK4O0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-337-sI8aPHUuNEK7ZjoV4yiFtg-1; Wed, 29 Apr 2020 03:20:51 -0400
X-MC-Unique: sI8aPHUuNEK7ZjoV4yiFtg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A120680058A
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2020 07:20:50 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-113-6.ams2.redhat.com [10.36.113.6])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6B15D648C8;
 Wed, 29 Apr 2020 07:20:50 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id CD95C11358C0; Wed, 29 Apr 2020 09:20:48 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 04/32] qemu-option: Fix sloppy recognition of "id=..." after ", ,
 "
Date: Wed, 29 Apr 2020 09:20:20 +0200
Message-Id: <20200429072048.29963-5-armbru@redhat.com>
In-Reply-To: <20200429072048.29963-1-armbru@redhat.com>
References: <20200429072048.29963-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.120; envelope-from=armbru@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/29 01:18:10
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
Cc: Kevin Wolf <kwolf@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Message-Id: <20200415074927.19897-4-armbru@redhat.com>
---
 tests/test-qemu-opts.c |  4 ++--
 util/qemu-option.c     | 27 +++++++++++++++++++--------
 2 files changed, 21 insertions(+), 10 deletions(-)

diff --git a/tests/test-qemu-opts.c b/tests/test-qemu-opts.c
index 88a3e7bdf4..8ff97268d8 100644
--- a/tests/test-qemu-opts.c
+++ b/tests/test-qemu-opts.c
@@ -500,10 +500,10 @@ static void test_opts_parse(void)
     g_assert(!opts);
     /* TODO Cover .merge_lists =3D true */
=20
-    /* Buggy ID recognition */
+    /* Buggy ID recognition (fixed) */
     opts =3D qemu_opts_parse(&opts_list_03, "x=3D,,id=3Dbar", false, &erro=
r_abort);
     g_assert_cmpuint(opts_count(opts), =3D=3D, 1);
-    g_assert_cmpstr(qemu_opts_id(opts), =3D=3D, "bar"); /* BUG */
+    g_assert(!qemu_opts_id(opts));
     g_assert_cmpstr(qemu_opt_get(opts, "x"), =3D=3D, ",id=3Dbar");
=20
     /* Anti-social ID */
diff --git a/util/qemu-option.c b/util/qemu-option.c
index f08f4bc458..d2956082bd 100644
--- a/util/qemu-option.c
+++ b/util/qemu-option.c
@@ -872,6 +872,24 @@ static void opts_do_parse(QemuOpts *opts, const char *=
params,
     }
 }
=20
+static char *opts_parse_id(const char *params)
+{
+    const char *p;
+    char *name, *value;
+
+    for (p =3D params; *p;) {
+        p =3D get_opt_name_value(p, NULL, &name, &value);
+        if (!strcmp(name, "id")) {
+            g_free(name);
+            return value;
+        }
+        g_free(name);
+        g_free(value);
+    }
+
+    return NULL;
+}
+
 /**
  * Store options parsed from @params into @opts.
  * If @firstname is non-null, the first key=3Dvalue in @params may omit
@@ -889,20 +907,13 @@ static QemuOpts *opts_parse(QemuOptsList *list, const=
 char *params,
                             bool *invalidp, Error **errp)
 {
     const char *firstname;
-    char *id =3D NULL;
-    const char *p;
+    char *id =3D opts_parse_id(params);
     QemuOpts *opts;
     Error *local_err =3D NULL;
=20
     assert(!permit_abbrev || list->implied_opt_name);
     firstname =3D permit_abbrev ? list->implied_opt_name : NULL;
=20
-    if (strncmp(params, "id=3D", 3) =3D=3D 0) {
-        get_opt_value(params + 3, &id);
-    } else if ((p =3D strstr(params, ",id=3D")) !=3D NULL) {
-        get_opt_value(p + 4, &id);
-    }
-
     /*
      * This code doesn't work for defaults && !list->merge_lists: when
      * params has no id=3D, and list has an element with !opts->id, it
--=20
2.21.1


