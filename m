Return-Path: <SRS0=OA/w=ZN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF878C432C0
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2019 14:03:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 79DD520679
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2019 14:03:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jEKQNSrn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79DD520679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40926 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXn38-0006Lw-80
	for qemu-devel@archiver.kernel.org; Thu, 21 Nov 2019 09:03:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35336)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <slp@redhat.com>) id 1iXmyS-00022l-4Q
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 08:58:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <slp@redhat.com>) id 1iXmyP-0001Ns-OB
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 08:58:18 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:44078
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <slp@redhat.com>) id 1iXmyP-0001Ms-K0
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 08:58:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574344697;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2NO3Y+YgqZ7oFYwXVncrtROSpQ6dChJQOlWLkeEdQDQ=;
 b=jEKQNSrn8Ad5tOOdYmnXPOtUfcJmlLk3AWAKhwZNIFueS5j0OuSXUINFFrYwDU+54UGf+G
 ZBDk/GtQ/P59cOUoKBST6BcK6aOwCG35BE96od4rUSfyRMxTVty2RnrAj4BrsP3ydn/vZF
 SGeVAACazoFCSFMq8YPq3EsySVigf2s=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-398-3TiI-n2EP4GLS_86DMQ8Rw-1; Thu, 21 Nov 2019 08:58:15 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F08AA64A7E;
 Thu, 21 Nov 2019 13:58:14 +0000 (UTC)
Received: from dritchie.redhat.com (unknown [10.33.36.14])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5F8DA6E70E;
 Thu, 21 Nov 2019 13:58:13 +0000 (UTC)
From: Sergio Lopez <slp@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 5/5] iotests: fix 141 after qmp_drive_backup with
 transactions
Date: Thu, 21 Nov 2019 14:57:59 +0100
Message-Id: <20191121135759.101655-6-slp@redhat.com>
In-Reply-To: <20191121135759.101655-1-slp@redhat.com>
References: <20191121135759.101655-1-slp@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: 3TiI-n2EP4GLS_86DMQ8Rw-1
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
Cc: Kevin Wolf <kwolf@redhat.com>, Sergio Lopez <slp@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, qemu-block@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

qmp_drive_backup now creates and starts a transactions, which implies
that the job will transition to pause and running twice. Fix test 141
to be aware of this change.

Signed-off-by: Sergio Lopez <slp@redhat.com>
---
 tests/qemu-iotests/141.out | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tests/qemu-iotests/141.out b/tests/qemu-iotests/141.out
index 3645675ce8..263b680bdf 100644
--- a/tests/qemu-iotests/141.out
+++ b/tests/qemu-iotests/141.out
@@ -13,6 +13,8 @@ Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D10485=
76 backing_file=3DTEST_DIR/m.
 Formatting 'TEST_DIR/o.IMGFMT', fmt=3DIMGFMT size=3D1048576 backing_file=
=3DTEST_DIR/t.IMGFMT backing_fmt=3DIMGFMT
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "JOB_STATUS_CHANGE", "data": {"status": "created", "id": "job0"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "JOB_STATUS_CHANGE", "data": {"status": "running", "id": "job0"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "JOB_STATUS_CHANGE", "data": {"status": "paused", "id": "job0"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "JOB_STATUS_CHANGE", "data": {"status": "running", "id": "job0"}}
 {'execute': 'blockdev-del', 'arguments': {'node-name': 'drv0'}}
 {"error": {"class": "GenericError", "desc": "Node 'drv0' is busy: node is =
used as backing hd of 'NODE_NAME'"}}
 {'execute': 'block-job-cancel', 'arguments': {'device': 'job0'}}
--=20
2.23.0


