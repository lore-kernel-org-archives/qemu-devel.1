Return-Path: <SRS0=QLzr=44=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56621C10F27
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 14:01:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1BDA921D56
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 14:01:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MEJB4336"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1BDA921D56
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52636 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jC1uz-0004gx-2S
	for qemu-devel@archiver.kernel.org; Wed, 11 Mar 2020 10:01:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36119)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1jC1mm-0003nn-Gv
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 09:52:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1jC1mk-0002TV-K4
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 09:52:36 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:41618
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1jC1mk-0002R9-Er
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 09:52:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583934753;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=a6t3X74nlBAIN+SErRk0soe+wHgMWzGzq3342XWA9qk=;
 b=MEJB43366p1KXM6uFISdBzqoHY7rehQudka9A0BditQsdWeJTxua+0FQuzNMtNVQkACEWc
 WcmiCcmuPeHOaD9o9fpOHzCifsiSN1pUQunhGaS/F2Y4jISOk1q8/xDNgyjMkayH4fDuEG
 FCuSeZRLPHY2K7Ov9WSOSrtaJG0wZ6w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-301-yCqzhhXQN4CdysaCqDxJUQ-1; Wed, 11 Mar 2020 09:52:31 -0400
X-MC-Unique: yCqzhhXQN4CdysaCqDxJUQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 90F0B107ACC7;
 Wed, 11 Mar 2020 13:52:30 +0000 (UTC)
Received: from localhost (ovpn-117-216.ams2.redhat.com [10.36.117.216])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1065A5D9C5;
 Wed, 11 Mar 2020 13:52:29 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 05/19] block/curl: HTTP header fields allow whitespace around
 values
Date: Wed, 11 Mar 2020 14:51:59 +0100
Message-Id: <20200311135213.1242028-6-mreitz@redhat.com>
In-Reply-To: <20200311135213.1242028-1-mreitz@redhat.com>
References: <20200311135213.1242028-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: David Edmondson <david.edmondson@oracle.com>

RFC 7230 section 3.2 indicates that whitespace is permitted between
the field name and field value and after the field value.

Signed-off-by: David Edmondson <david.edmondson@oracle.com>
Message-Id: <20200224101310.101169-2-david.edmondson@oracle.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block/curl.c | 31 +++++++++++++++++++++++++++----
 1 file changed, 27 insertions(+), 4 deletions(-)

diff --git a/block/curl.c b/block/curl.c
index f86299378e..f9ffb7f4e2 100644
--- a/block/curl.c
+++ b/block/curl.c
@@ -214,11 +214,34 @@ static size_t curl_header_cb(void *ptr, size_t size, =
size_t nmemb, void *opaque)
 {
     BDRVCURLState *s =3D opaque;
     size_t realsize =3D size * nmemb;
-    const char *accept_line =3D "Accept-Ranges: bytes";
+    const char *header =3D (char *)ptr;
+    const char *end =3D header + realsize;
+    const char *accept_ranges =3D "Accept-Ranges:";
+    const char *bytes =3D "bytes";
=20
-    if (realsize >=3D strlen(accept_line)
-        && strncmp((char *)ptr, accept_line, strlen(accept_line)) =3D=3D 0=
) {
-        s->accept_range =3D true;
+    if (realsize >=3D strlen(accept_ranges)
+        && strncmp(header, accept_ranges, strlen(accept_ranges)) =3D=3D 0)=
 {
+
+        char *p =3D strchr(header, ':') + 1;
+
+        /* Skip whitespace between the header name and value. */
+        while (p < end && *p && g_ascii_isspace(*p)) {
+            p++;
+        }
+
+        if (end - p >=3D strlen(bytes)
+            && strncmp(p, bytes, strlen(bytes)) =3D=3D 0) {
+
+            /* Check that there is nothing but whitespace after the value.=
 */
+            p +=3D strlen(bytes);
+            while (p < end && *p && g_ascii_isspace(*p)) {
+                p++;
+            }
+
+            if (p =3D=3D end || !*p) {
+                s->accept_range =3D true;
+            }
+        }
     }
=20
     return realsize;
--=20
2.24.1


