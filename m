Return-Path: <SRS0=p/0J=2J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EA2AC43603
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 17:43:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3CDE5222C2
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 17:43:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cDfnNbIi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CDE5222C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45526 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihzpn-0003Rs-9Z
	for qemu-devel@archiver.kernel.org; Thu, 19 Dec 2019 12:43:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46099)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1ihzYE-0006l9-24
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 12:25:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1ihzYC-0007Ju-P4
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 12:25:25 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:52066
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1ihzYB-0007Hg-L5
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 12:25:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576776322;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3On4XWfVcj5B+no5b4p44Jfdeq4GsAjz4vRXBd1i3iM=;
 b=cDfnNbIiZD94SsM7HVXUvW0o2QGfvLvWfdmI+n4iqfSQcZzocAIUMaqekEj2599CjRyr95
 F0UcwLzBmIM/9oELmaPVJhExUIz78MOpKwFeN1LghRSvwWXGwqXJPNJiLy0s/7gn9xIJme
 rDUs8F/+7lxwRshhxOr+mG82yqx5ag4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-254-SbwOIM2oNHCmbOtMlHhAgA-1; Thu, 19 Dec 2019 12:25:19 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 082A4107ACC9;
 Thu, 19 Dec 2019 17:25:18 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-117-53.ams2.redhat.com [10.36.117.53])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E7ECD620C0;
 Thu, 19 Dec 2019 17:25:15 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 18/30] iotests: Create VM.blockdev_create()
Date: Thu, 19 Dec 2019 18:24:29 +0100
Message-Id: <20191219172441.7289-19-kwolf@redhat.com>
In-Reply-To: <20191219172441.7289-1-kwolf@redhat.com>
References: <20191219172441.7289-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: SbwOIM2oNHCmbOtMlHhAgA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
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
Cc: kwolf@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org
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


