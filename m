Return-Path: <SRS0=N0XV=XP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE2E5C3A5A2
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2019 22:22:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8DE7E2086A
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2019 22:22:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DE7E2086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35716 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iBR4q-0006Md-Td
	for qemu-devel@archiver.kernel.org; Fri, 20 Sep 2019 18:08:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57088)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1iBR45-0005wT-9O
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 18:07:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1iBR43-00036E-VM
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 18:07:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55053)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>)
 id 1iBR3z-0002t9-Tv; Fri, 20 Sep 2019 18:07:40 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 23F913086218;
 Fri, 20 Sep 2019 22:07:37 +0000 (UTC)
Received: from blue.redhat.com (ovpn-116-249.phx2.redhat.com [10.3.116.249])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DF57D5D9C3;
 Fri, 20 Sep 2019 22:07:31 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 2/1] tests: Use iothreads during iotest 223
Date: Fri, 20 Sep 2019 17:07:29 -0500
Message-Id: <20190920220729.31801-1-eblake@redhat.com>
In-Reply-To: <20190917023917.32226-1-eblake@redhat.com>
References: <20190917023917.32226-1-eblake@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.42]); Fri, 20 Sep 2019 22:07:37 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
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
Cc: kwolf@redhat.com, jsnow@redhat.com,
 "open list:Block layer core" <qemu-block@nongnu.org>, slp@redhat.com,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Doing so catches the bugs we just fixed with NBD not properly using
correct contexts.

Signed-off-by: Eric Blake <eblake@redhat.com>
---

This is https://bugzilla.redhat.com/show_bug.cgi?id=3D1741094,
distinct from Sergio's patch also related to aiocontext in NBD, which is
https://bugzilla.redhat.com/show_bug.cgi?id=3D1748253

I could not easily figure out how to tweak iotests to cover Sergio's
issue, but really want to get both fixes in a pull request soon.

 tests/qemu-iotests/223     | 6 ++++--
 tests/qemu-iotests/223.out | 1 +
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/tests/qemu-iotests/223 b/tests/qemu-iotests/223
index cc48e78ea7dc..2ba3d8124b4f 100755
--- a/tests/qemu-iotests/223
+++ b/tests/qemu-iotests/223
@@ -2,7 +2,7 @@
 #
 # Test reading dirty bitmap over NBD
 #
-# Copyright (C) 2018 Red Hat, Inc.
+# Copyright (C) 2018-2019 Red Hat, Inc.
 #
 # This program is free software; you can redistribute it and/or modify
 # it under the terms of the GNU General Public License as published by
@@ -109,7 +109,7 @@ echo
 echo "=3D=3D=3D End dirty bitmaps, and start serving image over NBD =3D=3D=
=3D"
 echo

-_launch_qemu 2> >(_filter_nbd)
+_launch_qemu -object iothread,id=3Dio0 2> >(_filter_nbd)

 # Intentionally provoke some errors as well, to check error handling
 silent=3D
@@ -117,6 +117,8 @@ _send_qemu_cmd $QEMU_HANDLE '{"execute":"qmp_capabili=
ties"}' "return"
 _send_qemu_cmd $QEMU_HANDLE '{"execute":"blockdev-add",
   "arguments":{"driver":"qcow2", "node-name":"n",
     "file":{"driver":"file", "filename":"'"$TEST_IMG"'"}}}' "return"
+_send_qemu_cmd $QEMU_HANDLE '{"execute":"x-blockdev-set-iothread",
+  "arguments":{"node-name":"n", "iothread":"io0"}}' "return"
 _send_qemu_cmd $QEMU_HANDLE '{"execute":"block-dirty-bitmap-disable",
   "arguments":{"node":"n", "name":"b"}}' "return"
 _send_qemu_cmd $QEMU_HANDLE '{"execute":"nbd-server-add",
diff --git a/tests/qemu-iotests/223.out b/tests/qemu-iotests/223.out
index 5d00398c11cb..23b34fcd202e 100644
--- a/tests/qemu-iotests/223.out
+++ b/tests/qemu-iotests/223.out
@@ -27,6 +27,7 @@ wrote 2097152/2097152 bytes at offset 2097152
 {"return": {}}
 {"return": {}}
 {"return": {}}
+{"return": {}}
 {"error": {"class": "GenericError", "desc": "NBD server not running"}}
 {"return": {}}
 {"error": {"class": "GenericError", "desc": "NBD server already running"=
}}
--=20
2.21.0


