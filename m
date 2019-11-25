Return-Path: <SRS0=/cID=ZR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FB0AC432C0
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2019 13:41:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA615207FD
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2019 13:41:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="avYSbkXJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA615207FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44090 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iZEch-0003dO-TP
	for qemu-devel@archiver.kernel.org; Mon, 25 Nov 2019 08:41:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43966)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1iZEZr-0000Zw-Kl
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 08:38:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1iZEZp-0007iD-Hf
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 08:38:55 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:34320
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1iZEZn-0007h0-Hl
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 08:38:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574689130;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wo8nMmg5eLNgbhvYGkzsTMpiAjxrROXdulWsJagBLNU=;
 b=avYSbkXJhQX37uiRckAv8rKlLlRCd6mZRsAoxnGJZyZ/ZJzirUCUADtLyEOucLEaIE1Dw6
 +DCn1BLu33jkyIgjZNgGCaf5Qy1oliJqhwG3VQ0Yb65kZe1vUoF05QXCW6nxNkm91ju6OH
 s1C1Ax7+UIWrZbQ8oq6PiSw1zE1YLzs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-208-dxS8kqqFNAau4tSY7DjKEQ-1; Mon, 25 Nov 2019 08:38:49 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CCB2DDB61;
 Mon, 25 Nov 2019 13:38:48 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-134.ams2.redhat.com
 [10.36.116.134])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 83BBF19C6A;
 Mon, 25 Nov 2019 13:38:48 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 056A011385C7; Mon, 25 Nov 2019 14:38:47 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/2] util/cutils: Turn FIXME comment into QEMU_BUILD_BUG_ON()
Date: Mon, 25 Nov 2019 14:38:45 +0100
Message-Id: <20191125133846.27790-2-armbru@redhat.com>
In-Reply-To: <20191125133846.27790-1-armbru@redhat.com>
References: <20191125133846.27790-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: dxS8kqqFNAau4tSY7DjKEQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
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
Cc: qemu-trivial@nongnu.org, tao3.xu@intel.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

qemu_strtoi64() assumes int64_t is long long.  This is marked FIXME.
Replace by a QEMU_BUILD_BUG_ON() to avoid surprises.

Same for qemu_strtou64().

Fix a typo in qemu_strtoul()'s contract while there.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 util/cutils.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/util/cutils.c b/util/cutils.c
index fd591cadf0..b372dd3e68 100644
--- a/util/cutils.c
+++ b/util/cutils.c
@@ -502,7 +502,7 @@ int qemu_strtoul(const char *nptr, const char **endptr,=
 int base,
  * Convert string @nptr to an int64_t.
  *
  * Works like qemu_strtol(), except it stores INT64_MAX on overflow,
- * and INT_MIN on underflow.
+ * and INT64_MIN on underflow.
  */
 int qemu_strtoi64(const char *nptr, const char **endptr, int base,
                  int64_t *result)
@@ -517,8 +517,9 @@ int qemu_strtoi64(const char *nptr, const char **endptr=
, int base,
         return -EINVAL;
     }
=20
+    /* This assumes int64_t is long long TODO relax */
+    QEMU_BUILD_BUG_ON(sizeof(int64_t) !=3D sizeof(long long));=20
     errno =3D 0;
-    /* FIXME This assumes int64_t is long long */
     *result =3D strtoll(nptr, &ep, base);
     return check_strtox_error(nptr, ep, endptr, errno);
 }
@@ -541,8 +542,9 @@ int qemu_strtou64(const char *nptr, const char **endptr=
, int base,
         return -EINVAL;
     }
=20
+    /* This assumes uint64_t is unsigned long long TODO relax */
+    QEMU_BUILD_BUG_ON(sizeof(uint64_t) !=3D sizeof(unsigned long long));
     errno =3D 0;
-    /* FIXME This assumes uint64_t is unsigned long long */
     *result =3D strtoull(nptr, &ep, base);
     /* Windows returns 1 for negative out-of-range values.  */
     if (errno =3D=3D ERANGE) {
--=20
2.21.0


