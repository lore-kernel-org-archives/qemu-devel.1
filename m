Return-Path: <SRS0=Jnn8=YR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9227BCA9EAF
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 11:17:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5E0012084C
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 11:17:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dmNxLKCe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E0012084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39296 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNb7c-0002U1-0Q
	for qemu-devel@archiver.kernel.org; Thu, 24 Oct 2019 07:17:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59313)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1iNatJ-0000xi-RX
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 07:02:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1iNatE-0004pF-5H
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 07:02:53 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:20743
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1iNatC-0004mK-66
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 07:02:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1571914964;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TS6mWmulSsOlAprbPsy9Eyv9dHRNJ+A89O7z6zn2tvg=;
 b=dmNxLKCeGB3d/7yROQ8ztDpiQiHK+6EYTpgRKAX0UJ+IRMZYXhD5m0g1WQV2ixzsMxbAZk
 dRlXjjka1IYMjWySNtrh2OJd2iXQIlEILA1g5vQD6e7GTXlYA/81XmT5rkNJz3A2gjENbm
 CRyB57A6LLc8x85BsZ/F/8X92LlIFLk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-278-vMQ4mVauP-C8VRjmJYCDyQ-1; Thu, 24 Oct 2019 07:02:43 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 139E6107AD31;
 Thu, 24 Oct 2019 11:02:42 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.36.118.123])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D3DE1608C1;
 Thu, 24 Oct 2019 11:02:41 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 7AFCF1130344; Thu, 24 Oct 2019 13:02:37 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 15/19] qapi: Fold normalize_features() into check_features()
Date: Thu, 24 Oct 2019 13:02:33 +0200
Message-Id: <20191024110237.30963-16-armbru@redhat.com>
In-Reply-To: <20191024110237.30963-1-armbru@redhat.com>
References: <20191024110237.30963-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: vMQ4mVauP-C8VRjmJYCDyQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: kwolf@redhat.com, pkrempa@redhat.com, mdroth@linux.vnet.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

check_features() is always called together with normalize_features():
the former in check_struct() and check_command(), the latter in their
caller check_exprs().  Fold the latter into the former.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 scripts/qapi/expr.py | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/scripts/qapi/expr.py b/scripts/qapi/expr.py
index aa0fe69f99..66014e2bb2 100644
--- a/scripts/qapi/expr.py
+++ b/scripts/qapi/expr.py
@@ -173,17 +173,13 @@ def check_type(value, info, source,
         check_type(arg['type'], info, key_source, allow_array=3DTrue)
=20
=20
-def normalize_features(features):
-    if isinstance(features, list):
-        features[:] =3D [f if isinstance(f, dict) else {'name': f}
-                       for f in features]
-
-
 def check_features(features, info):
     if features is None:
         return
     if not isinstance(features, list):
         raise QAPISemError(info, "'features' must be an array")
+    features[:] =3D [f if isinstance(f, dict) else {'name': f}
+                   for f in features]
     for f in features:
         source =3D "'features' member"
         assert isinstance(f, dict)
@@ -347,7 +343,6 @@ def check_exprs(exprs):
             check_keys(expr, info, meta,
                        ['struct', 'data'], ['base', 'if', 'features'])
             normalize_members(expr['data'])
-            normalize_features(expr.get('features'))
             check_struct(expr, info)
         elif meta =3D=3D 'command':
             check_keys(expr, info, meta,
@@ -356,7 +351,6 @@ def check_exprs(exprs):
                         'gen', 'success-response', 'allow-oob',
                         'allow-preconfig'])
             normalize_members(expr.get('data'))
-            normalize_features(expr.get('features'))
             check_command(expr, info)
         elif meta =3D=3D 'event':
             check_keys(expr, info, meta,
--=20
2.21.0


