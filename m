Return-Path: <SRS0=sZ1e=65=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B08D5C433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 13:17:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7DC5020759
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 13:17:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g/XuDCh0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7DC5020759
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56664 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZaDi-0003qC-D2
	for qemu-devel@archiver.kernel.org; Fri, 15 May 2020 09:17:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46014)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jZZjh-0003uI-Se
 for qemu-devel@nongnu.org; Fri, 15 May 2020 08:46:48 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:44225
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jZZjh-0002Vg-1U
 for qemu-devel@nongnu.org; Fri, 15 May 2020 08:46:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589546804;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hwiHccn7lvl/1r6qMKiGeYIvBED9KWcgn7MSl576gJI=;
 b=g/XuDCh0UeLmJRYNhwOHjmleUtprOwoz1JCX7Tbt70y1OdvDqs4VYzrJ9qpWtiapuqJBoX
 i66pp+7ZL75qCEjS2D2wCulbMB31DeVRNzkNA60/eeLftO4IhMnFeS2OI52mS8oJ4ne7pr
 8M92H7nXWRJa6EPxNEvtP5wedud0j8M=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-161-oheZTiRMO26wnlXoJ7fyCA-1; Fri, 15 May 2020 08:46:42 -0400
X-MC-Unique: oheZTiRMO26wnlXoJ7fyCA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EB34F8005AD;
 Fri, 15 May 2020 12:46:40 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-113-110.ams2.redhat.com
 [10.36.113.110])
 by smtp.corp.redhat.com (Postfix) with ESMTP id F145A2E024;
 Fri, 15 May 2020 12:46:39 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 51/51] iotests/030: Reduce run time by unthrottling job earlier
Date: Fri, 15 May 2020 14:45:21 +0200
Message-Id: <20200515124521.335403-52-kwolf@redhat.com>
In-Reply-To: <20200515124521.335403-1-kwolf@redhat.com>
References: <20200515124521.335403-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/15 00:39:12
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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

test_overlapping_3() throttles its active commit job so it can be sure
the job is still busy when it checks that you can't start a conflicting
streaming job.

However, it only sets the commit job back to full speed when it is
ready, which takes a few seconds while it's throttled. We can already
reset the limit after having checked that block-stream returns an error
and save these seconds.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Message-Id: <20200513100025.33543-1-kwolf@redhat.com>
Reviewed-by: Alberto Garcia <berto@igalia.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 tests/qemu-iotests/030 | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tests/qemu-iotests/030 b/tests/qemu-iotests/030
index 104e3cee1b..1cdd7e2999 100755
--- a/tests/qemu-iotests/030
+++ b/tests/qemu-iotests/030
@@ -354,14 +354,14 @@ class TestParallelOps(iotests.QMPTestCase):
         self.assert_qmp(result, 'error/desc',
             "Node 'node5' is busy: block device is in use by block job: commit")
 
+        result = self.vm.qmp('block-job-set-speed', device='commit-drive0', speed=0)
+        self.assert_qmp(result, 'return', {})
+
         event = self.vm.event_wait(name='BLOCK_JOB_READY')
         self.assert_qmp(event, 'data/device', 'commit-drive0')
         self.assert_qmp(event, 'data/type', 'commit')
         self.assert_qmp_absent(event, 'data/error')
 
-        result = self.vm.qmp('block-job-set-speed', device='commit-drive0', speed=0)
-        self.assert_qmp(result, 'return', {})
-
         result = self.vm.qmp('block-job-complete', device='commit-drive0')
         self.assert_qmp(result, 'return', {})
 
-- 
2.25.4


