Return-Path: <SRS0=tSBD=YP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9ABECA9EA0
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 07:28:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8399F2064B
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 07:28:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Gte1KvYq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8399F2064B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51040 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMoaO-0004wf-IM
	for qemu-devel@archiver.kernel.org; Tue, 22 Oct 2019 03:28:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39169)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1iMoUg-0005ZE-CQ
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 03:22:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1iMoUf-0005L5-9q
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 03:22:14 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:24737
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>) id 1iMoUf-0005Ku-5l
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 03:22:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1571728932;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=W/3jEa0khY8EIsvamGoGXV0Y4SSFZ2VbgKsJcLDSgeg=;
 b=Gte1KvYqP9CygaoKifNYfa3VVUjJN438PgjK8Ya1RXUpS3OJsn0oHy3Eh6hxqo3Aue0i3z
 JJXWa/HAB/AK2sOAc8s1jcCubAOZuk19+niLydhswmOTn+kzZ3eWyMRt4jt4P0F21weYEM
 u//ES4jEe3qUWVR203YIN747G8gP6OA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-264-Dn9t54yaO2-3ghxvc8YNtw-1; Tue, 22 Oct 2019 03:22:09 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 554251800D6A;
 Tue, 22 Oct 2019 07:22:08 +0000 (UTC)
Received: from thuth.com (dhcp-200-228.str.redhat.com [10.33.200.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DB2942965D;
 Tue, 22 Oct 2019 07:21:57 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Max Reitz <mreitz@redhat.com>,
	qemu-block@nongnu.org
Subject: [PATCH v3 5/6] iotests: Enable more tests in the 'auto' group to
 improve test coverage
Date: Tue, 22 Oct 2019 09:21:34 +0200
Message-Id: <20191022072135.11188-6-thuth@redhat.com>
In-Reply-To: <20191022072135.11188-1-thuth@redhat.com>
References: <20191022072135.11188-1-thuth@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: Dn9t54yaO2-3ghxvc8YNtw-1
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
Cc: Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

According to Kevin, tests 030, 040 and 041 are among the most valuable
tests that we have, so we should always run them if possible, even if
they take a little bit longer.

According to Max, it would be good to have a test for iothreads and
migration. 127 and 256 seem to be good candidates for iothreads. For
migration, let's enable 091, 181, and 203 (which also tests iothreads).

Reviewed-by: Max Reitz <mreitz@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/qemu-iotests/group | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/tests/qemu-iotests/group b/tests/qemu-iotests/group
index a73df279e5..33b499ed41 100644
--- a/tests/qemu-iotests/group
+++ b/tests/qemu-iotests/group
@@ -51,7 +51,7 @@
 027 rw auto quick
 028 rw backing quick
 029 rw auto quick
-030 rw backing
+030 rw auto backing
 031 rw auto quick
 032 rw auto quick
 033 rw auto quick
@@ -61,8 +61,8 @@
 037 rw auto backing quick
 038 rw auto backing quick
 039 rw auto quick
-040 rw
-041 rw backing
+040 rw auto
+041 rw auto backing
 042 rw auto quick
 043 rw auto backing
 044 rw
@@ -112,7 +112,7 @@
 088 rw quick
 089 rw auto quick
 090 rw auto quick
-091 rw migration
+091 rw auto migration
 092 rw quick
 093 throttle
 094 rw quick
@@ -148,7 +148,7 @@
 124 rw backing
 125 rw
 126 rw auto backing
-127 rw backing quick
+127 rw auto backing quick
 128 rw quick
 129 rw quick
 130 rw auto quick
@@ -197,7 +197,7 @@
 177 rw auto quick
 178 img
 179 rw auto quick
-181 rw migration
+181 rw auto migration
 182 rw quick
 183 rw migration
 184 rw auto quick
@@ -218,7 +218,7 @@
 200 rw
 201 rw migration
 202 rw quick
-203 rw migration
+203 rw auto migration
 204 rw quick
 205 rw quick
 206 rw
@@ -270,7 +270,7 @@
 253 rw quick
 254 rw backing quick
 255 rw quick
-256 rw quick
+256 rw auto quick
 257 rw
 258 rw quick
 260 rw quick
--=20
2.18.1


