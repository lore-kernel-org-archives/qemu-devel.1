Return-Path: <SRS0=cs6B=3X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8FB3C3524D
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 12:41:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BA15720721
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 12:41:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Av2hLKe2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA15720721
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39378 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iyb2a-0000np-UJ
	for qemu-devel@archiver.kernel.org; Mon, 03 Feb 2020 07:41:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56572)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1iyazq-0004PJ-U3
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 07:38:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1iyazp-00060t-Ob
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 07:38:34 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:29422
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>) id 1iyazp-00060l-K4
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 07:38:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580733513;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6BAfDRfyVrac8vqNlqJsxXbM7U3B9FzdnCCJs7abenY=;
 b=Av2hLKe2CMA5UgcTnoWPEXlKp7/h2QcUVYcn5fPi2DuxmFK+kw9tsCSeP1TueC96EQOJ2V
 c2Cijwdr3rsJ1cjChzCkpGnbv9kWWv6lYoDw0w0iXYejqK9ytHSoydH7qs7LYzYkgnjwTH
 7oHmbzYmdr3XCBSJyr7OCVBFBKWnWPU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-423-W7J98HmMOX2dwbG-Sv8C8A-1; Mon, 03 Feb 2020 07:38:27 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 269F213E5;
 Mon,  3 Feb 2020 12:38:26 +0000 (UTC)
Received: from thuth.com (ovpn-116-129.ams2.redhat.com [10.36.116.129])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4B8B6196B1;
 Mon,  3 Feb 2020 12:38:25 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 07/13] gitlab-ci: Refresh the list of iotests
Date: Mon,  3 Feb 2020 13:38:05 +0100
Message-Id: <20200203123811.8651-8-thuth@redhat.com>
In-Reply-To: <20200203123811.8651-1-thuth@redhat.com>
References: <20200203123811.8651-1-thuth@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: W7J98HmMOX2dwbG-Sv8C8A-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

iotest 147 and 205 have recently been marked as "NBD-only", so they
are currently simply skipped and thus can be removed.

iotest 129 occasionally fails in the gitlab-CI, and according to Max,
there are some known issues with this test (see for example this URL:
https://lists.nongnu.org/archive/html/qemu-block/2019-06/msg00499.html ),
so for the time being, let's disable it until the problems are fixed.

The iotests 040, 127, 203 and 256 are scheduled to become part of "make
check-block", so we also do not have to test them seperately here anymore.

On the other side, new iotests have been added to the QEMU repository
in the past months, so we can now add some new test > 256 instead.

Message-Id: <20200121131936.8214-1-thuth@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 .gitlab-ci.yml | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 228783993e..c15e394f09 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -54,12 +54,12 @@ build-tcg-disabled:
  - make check-qapi-schema
  - cd tests/qemu-iotests/
  - ./check -raw 001 002 003 004 005 008 009 010 011 012 021 025 032 033 04=
8
-            052 063 077 086 101 104 106 113 147 148 150 151 152 157 159 16=
0
-            163 170 171 183 184 192 194 197 205 208 215 221 222 226 227 23=
6
- - ./check -qcow2 028 040 051 056 057 058 065 067 068 082 085 091 095 096 =
102
-            122 124 127 129 132 139 142 144 145 147 151 152 155 157 165 19=
4
-            196 197 200 202 203 205 208 209 215 216 218 222 227 234 246 24=
7
-            248 250 254 255 256
+            052 063 077 086 101 104 106 113 148 150 151 152 157 159 160 16=
3
+            170 171 183 184 192 194 197 208 215 221 222 226 227 236 253 27=
7
+ - ./check -qcow2 028 051 056 057 058 065 067 068 082 085 091 095 096 102 =
122
+            124 132 139 142 144 145 151 152 155 157 165 194 196 197 200 20=
2
+            208 209 215 216 218 222 227 234 246 247 248 250 254 255 257 25=
8
+            260 261 262 263 264 270 272 273 277 279
=20
 build-user:
  script:
--=20
2.18.1


