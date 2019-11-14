Return-Path: <SRS0=NHD5=ZG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A74CAC43215
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2019 21:36:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7615420709
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2019 21:36:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J4vZJQKk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7615420709
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33950 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iVMnF-0005RL-IU
	for qemu-devel@archiver.kernel.org; Thu, 14 Nov 2019 16:36:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49438)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1iVMky-0002Ug-76
 for qemu-devel@nongnu.org; Thu, 14 Nov 2019 16:34:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1iVMkx-0004Ma-3d
 for qemu-devel@nongnu.org; Thu, 14 Nov 2019 16:34:24 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:20350
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1iVMkw-0004MB-WD
 for qemu-devel@nongnu.org; Thu, 14 Nov 2019 16:34:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573767262;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ErE597zNsknTpXwjlbggVGyQOq4x4Cnoeq1ubYOh5+o=;
 b=J4vZJQKkMAGroRVg7sf1eJ8ezH/LkADPpN0nKm0egWm4CUkgi8h+SFod6zKedYyR7Khbwd
 vJI8nuIq+B3WSpw7aR8ogCHnYHZP0hxhRwLLsudA57ho44xBFl6MPW21GWxx4k97XMl9Wm
 IZcIwZaTPy1am9VGF2QR98bF7VTLECE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-196-WvLMB20wNCGxRy4Q93-PDg-1; Thu, 14 Nov 2019 16:34:19 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3DD3B1005502;
 Thu, 14 Nov 2019 21:34:18 +0000 (UTC)
Received: from blue.redhat.com (ovpn-116-242.phx2.redhat.com [10.3.116.242])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D129067661;
 Thu, 14 Nov 2019 21:34:17 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 1/4] iotests: Fix 173
Date: Thu, 14 Nov 2019 15:34:12 -0600
Message-Id: <20191114213415.23499-2-eblake@redhat.com>
In-Reply-To: <20191114213415.23499-1-eblake@redhat.com>
References: <20191114213415.23499-1-eblake@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: WvLMB20wNCGxRy4Q93-PDg-1
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 "open list:Block layer core" <qemu-block@nongnu.org>, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This test has been broken since 3.0.  It used TEST_IMG to influence
the name of a file created during _make_test_img, but commit 655ae6bb
changed things so that the wrong file name is being created, which
then caused _launch_qemu to fail.  In the meantime, the set of events
issued for the actions of the test has increased.

Why haven't we noticed the failure? Because the test rarely gets run:
'./check -qcow2 173' is insufficient (that defaults to using file protocol)
'./check -nfs 173' is insufficient (that defaults to using raw format)
so the test is only run with:
./check -qcow2 -nfs 173

Note that we already have a number of other problems with -nfs:
./check -nfs (fails 18/30)
./check -qcow2 -nfs (fails 45/76 after this patch, if exports does
not permit 'insecure')
and it's not on my priority list to fix those.  Rather, I found this
because of my next patch's work on tests using _send_qemu_cmd.

Fixes: 655ae6b
Signed-off-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
---
 tests/qemu-iotests/173     | 4 ++--
 tests/qemu-iotests/173.out | 6 +++++-
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/tests/qemu-iotests/173 b/tests/qemu-iotests/173
index 9e2fa2e73cb9..29dcaa1960df 100755
--- a/tests/qemu-iotests/173
+++ b/tests/qemu-iotests/173
@@ -47,9 +47,9 @@ size=3D100M
 BASE_IMG=3D"${TEST_DIR}/image.base"
 TOP_IMG=3D"${TEST_DIR}/image.snp1"

-TEST_IMG=3D"${BASE_IMG}" _make_test_img $size
+TEST_IMG_FILE=3D"${BASE_IMG}" _make_test_img $size

-TEST_IMG=3D"${TOP_IMG}" _make_test_img $size
+TEST_IMG_FILE=3D"${TOP_IMG}" _make_test_img $size

 echo
 echo =3D=3D=3D Running QEMU, using block-stream to find backing image =3D=
=3D=3D
diff --git a/tests/qemu-iotests/173.out b/tests/qemu-iotests/173.out
index f477a0099a32..e83d17ec2f64 100644
--- a/tests/qemu-iotests/173.out
+++ b/tests/qemu-iotests/173.out
@@ -7,6 +7,10 @@ Formatting 'TEST_DIR/image.snp1', fmt=3DIMGFMT size=3D1048=
57600
 {"return": {}}
 {"return": {}}
 {"return": {}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "JOB_STATUS_CHANGE", "data": {"status": "created", "id": "disk2"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "JOB_STATUS_CHANGE", "data": {"status": "running", "id": "disk2"}}
 {"return": {}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "BLOCK_JOB_COMPLETED", "data": {"device": "disk2", "len": 104857600, "off=
set": 104857600, "speed": 0, "type": "stream"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "JOB_STATUS_CHANGE", "data": {"status": "waiting", "id": "disk2"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "JOB_STATUS_CHANGE", "data": {"status": "pending", "id": "disk2"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "BLOCK_JOB_COMPLETED", "data": {"device": "disk2", "len": 0, "offset": 0,=
 "speed": 0, "type": "stream"}}
 *** done
--=20
2.21.0


