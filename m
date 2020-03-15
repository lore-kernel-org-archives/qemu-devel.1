Return-Path: <SRS0=WIOf=5A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3557C10DCE
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Mar 2020 15:11:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1ECA420637
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Mar 2020 15:11:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BbqJEb3Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1ECA420637
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54972 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDUvj-0000MD-St
	for qemu-devel@archiver.kernel.org; Sun, 15 Mar 2020 11:11:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40339)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jDUXf-0005Wx-Ck
 for qemu-devel@nongnu.org; Sun, 15 Mar 2020 10:47:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1jDUXc-0002Eo-Om
 for qemu-devel@nongnu.org; Sun, 15 Mar 2020 10:47:03 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:42270
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1jDUXc-0002B1-I3
 for qemu-devel@nongnu.org; Sun, 15 Mar 2020 10:47:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584283620;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=G3gldn13+rEHEEDZV+NrWfuPEvINGJrpCchV2rYKIZE=;
 b=BbqJEb3Z9TAK1UUbKFasLVD7Nt9/XCgYQgVuYwfyvyMManiWZtQlmg0hHb4qZIcmzYtYXC
 XClfXiyYNnVYfUcBEvkG3JF19dP5JhxTTXjnPerkvObiAY+KhI9MpZAK9+WCxnfasRGlgn
 eMQTHlBqHbZgGoOOs21FnwpYMpk8wbc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-40-VwdLwlqDPqGuJJJFDMbaOQ-1; Sun, 15 Mar 2020 10:46:56 -0400
X-MC-Unique: VwdLwlqDPqGuJJJFDMbaOQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6379F8017CC;
 Sun, 15 Mar 2020 14:46:55 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-49.ams2.redhat.com
 [10.36.116.49])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E82BB5DA2C;
 Sun, 15 Mar 2020 14:46:54 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 7882C1138405; Sun, 15 Mar 2020 15:46:53 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 01/34] qemu-doc: Belatedly document QMP command arg &
 result deprecation
Date: Sun, 15 Mar 2020 15:46:20 +0100
Message-Id: <20200315144653.22660-2-armbru@redhat.com>
In-Reply-To: <20200315144653.22660-1-armbru@redhat.com>
References: <20200315144653.22660-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
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
Cc: mdroth@linux.vnet.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

A number of deprecated QMP arguments and results were missed in commit
eb22aeca65 "docs: document deprecation policy & deprecated features in
appendix" (v2.10.0):

* Commit b33945cfff "block: Accept device model name for
  blockdev-open/close-tray" (v2.8.0) deprecated blockdev-open-tray,
  blockdev-close-tray argument @device.

* Commit fbe2d8163e "block: Accept device model name for eject"
  (v2.8.0) deprecated eject argument @device.

* Commit 70e2cb3bd7 "block: Accept device model name for
  blockdev-change-medium" (v2.8.0) deprecated blockdev-change-medium
  argument @device.

* Commit 7a9877a026 "block: Accept device model name for
  block_set_io_throttle" (v2.8.0) deprecated block_set_io_throttle
  argument @device.

* Commit c01c214b69 "block: remove all encryption handling APIs"
  (v2.10.0) deprecated query-named-block-nodes result
  @encryption_key_missing and query-block result @inserted member
  @encryption_key_missing.

* Commit c42e8742f5 "block: Use JSON null instead of "" to disable
  backing file" (v2.10.0) deprecated blockdev-add empty string
  argument @backing.

Since then, we missed a few more:

* Commit 3c605f4074 "commit: Add top-node/base-node options" (v3.1.0)
  deprecated block-commit arguments @base and @top.

* Commit 4db6ceb0b5 "block/dirty-bitmap: add recording and busy
  properties" (v4.0.0) deprecated query-named-block-nodes result
  @dirty-bitmaps member @status, not just query-block.

Make up for all that.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 docs/system/deprecated.rst | 48 ++++++++++++++++++++++++++++++++++----
 1 file changed, 44 insertions(+), 4 deletions(-)

diff --git a/docs/system/deprecated.rst b/docs/system/deprecated.rst
index 0838338d8f..bfc693e8e0 100644
--- a/docs/system/deprecated.rst
+++ b/docs/system/deprecated.rst
@@ -180,27 +180,67 @@ QEMU Machine Protocol (QMP) commands
=20
 Use ``blockdev-change-medium`` or ``change-vnc-password`` instead.
=20
+``blockdev-open-tray``, ``blockdev-close-tray`` argument ``device`` (since=
 2.8.0)
+''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''=
'''''''
+
+Use argument ``id`` instead.
+
+``eject`` argument ``device`` (since 2.8.0)
+'''''''''''''''''''''''''''''''''''''''''''
+
+Use argument ``id`` instead.
+
+``blockdev-change-medium`` argument ``device`` (since 2.8.0)
+''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
+
+Use argument ``id`` instead.
+
+``block_set_io_throttle`` argument ``device`` (since 2.8.0)
+'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
+
+Use argument ``id`` instead.
+
 ``migrate_set_downtime`` and ``migrate_set_speed`` (since 2.8.0)
 ''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
=20
 Use ``migrate-set-parameters`` instead.
=20
+``query-named-block-nodes`` result ``encryption_key_missing`` (since 2.10.=
0)
+''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''=
''
+
+Always false.
+
+``query-block`` result ``inserted.encryption_key_missing`` (since 2.10.0)
+'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
+
+Always false.
+
+``blockdev-add`` empty string argument ``backing`` (since 2.10.0)
+'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
+
+Use argument value ``null`` instead.
+
 ``migrate-set-cache-size`` and ``query-migrate-cache-size`` (since 2.11.0)
 ''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
=20
 Use ``migrate-set-parameters`` and ``query-migrate-parameters`` instead.
=20
+``block-commit`` arguments ``base`` and ``top`` (since 3.1.0)
+'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
+
+Use arguments ``base-node`` and ``top-node`` instead.
+
 ``object-add`` option ``props`` (since 5.0)
 '''''''''''''''''''''''''''''''''''''''''''
=20
 Specify the properties for the object as top-level arguments instead.
=20
-``query-block`` result field ``dirty-bitmaps[i].status`` (since 4.0)
-''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
+``query-named-block-nodes`` and ``query-block`` result dirty-bitmaps[i].st=
atus (since 4.0)
+''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''=
''''''''''''''''
=20
 The ``status`` field of the ``BlockDirtyInfo`` structure, returned by
-the query-block command is deprecated. Two new boolean fields,
-``recording`` and ``busy`` effectively replace it.
+these commands is deprecated. Two new boolean fields, ``recording`` and
+``busy`` effectively replace it.
=20
 ``query-block`` result field ``dirty-bitmaps`` (Since 4.2)
 ''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
--=20
2.21.1


