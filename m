Return-Path: <SRS0=u0tK=2G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7C2FC43603
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 17:32:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B1431206E0
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 17:32:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VPtmUsor"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1431206E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57718 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iguEd-0002VL-Az
	for qemu-devel@archiver.kernel.org; Mon, 16 Dec 2019 12:32:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49649)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1igtrp-000531-Hc
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 12:09:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1igtro-0004Op-DH
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 12:09:09 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:47237
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1igtro-0004OC-8z
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 12:09:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576516147;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3On4XWfVcj5B+no5b4p44Jfdeq4GsAjz4vRXBd1i3iM=;
 b=VPtmUsor3lZmpNKF8TTmdJPlJ13bkO72gaDVRdd7O8afIasgrYG31uDGXDsDtqrjj2Lox1
 THiO9rUtGKGZZXsIUgCwZKaBkgaF1hpL0ci9ugUceYRlwisg6pYPrfwsPQdwAuxsySdCRj
 WvQQaKbrLc3IEaWO/+x47cRkfI8ZChk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-122-ZWR0TYuIO22l0utsbNBxbg-1; Mon, 16 Dec 2019 12:09:04 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 255BE1005514;
 Mon, 16 Dec 2019 17:09:03 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-117-54.ams2.redhat.com [10.36.117.54])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0287E6FEE8;
 Mon, 16 Dec 2019 17:09:01 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH 01/10] iotests: Create VM.blockdev_create()
Date: Mon, 16 Dec 2019 18:08:48 +0100
Message-Id: <20191216170857.11880-2-kwolf@redhat.com>
In-Reply-To: <20191216170857.11880-1-kwolf@redhat.com>
References: <20191216170857.11880-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: ZWR0TYuIO22l0utsbNBxbg-1
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
Cc: kwolf@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We have several almost identical copies of a blockdev_create() function
in different test cases. Time to create one unified function in
iotests.py.

To keep the diff managable, this patch only creates the function and
follow-up patches will convert the individual test cases.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 tests/qemu-iotests/iotests.py | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests.py
index b46d298766..8739ec6613 100644
--- a/tests/qemu-iotests/iotests.py
+++ b/tests/qemu-iotests/iotests.py
@@ -643,6 +643,22 @@ class VM(qtest.QEMUQtestMachine):
             elif status =3D=3D 'null':
                 return error
=20
+    # Returns None on success, and an error string on failure
+    def blockdev_create(self, options, job_id=3D'job0', filters=3DNone):
+        if filters is None:
+            filters =3D [filter_qmp_testfiles]
+        result =3D self.qmp_log('blockdev-create', filters=3Dfilters,
+                              job_id=3Djob_id, options=3Doptions)
+
+        if 'return' in result:
+            assert result['return'] =3D=3D {}
+            job_result =3D self.run_job(job_id)
+        else:
+            job_result =3D result['error']
+
+        log("")
+        return job_result
+
     def enable_migration_events(self, name):
         log('Enabling migration QMP events on %s...' % name)
         log(self.qmp('migrate-set-capabilities', capabilities=3D[
--=20
2.20.1


