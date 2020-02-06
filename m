Return-Path: <SRS0=rlpO=32=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82D4DC2D0B1
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 13:06:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5016321741
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 13:06:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PdvH698a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5016321741
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38514 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izgrQ-0007WC-Gm
	for qemu-devel@archiver.kernel.org; Thu, 06 Feb 2020 08:06:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57582)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1izgdU-0003Mr-8r
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 07:52:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1izgdS-0001Ad-UJ
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 07:52:00 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:58586
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1izgdS-00018a-Ou
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 07:51:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580993518;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sYBoCWe/bXn0garbx204DM8ysDebbz1E6xy+YbNyAkE=;
 b=PdvH698amlktPLYiPaDuWI4KIi6Ut9J2wfxZ5jcaTfryimo4Zq0yeA/QzwkszVQFn8L+cp
 KEtIDuapvKeBjstHgiQ/5rjfmqtVZAfdGOzw1BUL9wMfQDLQCmVWBwOO34ooB0uyjQ730I
 7IPY0XjxFNh7DLf2eX6m2Rsv5cYVrHU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-412-vradT7UROwCsmFhtGTMUvA-1; Thu, 06 Feb 2020 07:51:56 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2305F80257C;
 Thu,  6 Feb 2020 12:51:55 +0000 (UTC)
Received: from localhost (unknown [10.36.118.15])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6B11F26E4B;
 Thu,  6 Feb 2020 12:51:54 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 10/17] iotests: Enable more tests in the 'auto' group to
 improve test coverage
Date: Thu,  6 Feb 2020 13:51:25 +0100
Message-Id: <20200206125132.594625-11-mreitz@redhat.com>
In-Reply-To: <20200206125132.594625-1-mreitz@redhat.com>
References: <20200206125132.594625-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: vradT7UROwCsmFhtGTMUvA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Thomas Huth <thuth@redhat.com>

According to Kevin, tests 030, 040 and 041 are among the most valuable
tests that we have, so we should always run them if possible, even if
they take a little bit longer.

According to Max, it would be good to have a test for iothreads and
migration. 127 and 256 seem to be good candidates for iothreads. For
migration, let's enable 181 and 203 (which also tests iothreads).
(091 would be a good candidate for migration, too, but Alex Benn=C3=A9e
reported that this test fails on ZFS file systems, so it can't be
included yet)

Reviewed-by: Max Reitz <mreitz@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
Message-id: 20200121095205.26323-7-thuth@redhat.com
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 tests/qemu-iotests/group | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/tests/qemu-iotests/group b/tests/qemu-iotests/group
index e041cc1ee3..9d30a4b6c4 100644
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
@@ -148,7 +148,7 @@
 124 rw backing
 125 rw
 126 rw auto backing
-127 rw backing quick
+127 rw auto backing quick
 128 rw quick
 129 rw quick
 130 rw quick
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
2.24.1


