Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89A71C10F29
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 11:56:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E57420714
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 11:56:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OubgA5XS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E57420714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59622 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEApj-0001HH-GD
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 07:56:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56574)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jEAoN-0007jP-Jm
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 07:55:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1jEAoL-0005HE-TX
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 07:55:07 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:56633)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1jEAoL-0005Eu-PW
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 07:55:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584446105;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aDxvVmkPXexgiS9X3iRKQ8orejZNzGobrPsRmXPMC7I=;
 b=OubgA5XSi3tWfGdOO3W0TVr4EmPuqF5NCD9wACfrij2AKY+zV5DPPR4LXxMZQ9tazAJLK/
 xnExLispqsgv5y97axAClBLZOavyMuH2/82QBNMzTb70x80kfFh8F8WrMjrRCC6Ym4lUgL
 Ei+EDMnWCyG1BcW3d1FDru5L4NbnJao=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-449-GNYpot09PqiC-XRZAk3obA-1; Tue, 17 Mar 2020 07:55:03 -0400
X-MC-Unique: GNYpot09PqiC-XRZAk3obA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 45EA21007272;
 Tue, 17 Mar 2020 11:55:02 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-130.ams2.redhat.com
 [10.36.112.130])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6C5E528982;
 Tue, 17 Mar 2020 11:55:01 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id EE6E01138405; Tue, 17 Mar 2020 12:54:59 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 01/34] qemu-doc: Belatedly document QMP command arg &
 result deprecation
Date: Tue, 17 Mar 2020 12:54:26 +0100
Message-Id: <20200317115459.31821-2-armbru@redhat.com>
In-Reply-To: <20200317115459.31821-1-armbru@redhat.com>
References: <20200317115459.31821-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 216.205.24.74
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
Cc: marcandre.lureau@gmail.com, mdroth@linux.vnet.ibm.com
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
Reviewed-by: Eric Blake <eblake@redhat.com>
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


