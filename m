Return-Path: <SRS0=L+nc=BH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64EBBC433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 15:12:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E208204EA
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 15:12:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AhDdQ+iD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E208204EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44902 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0RHY-00038S-DS
	for qemu-devel@archiver.kernel.org; Tue, 28 Jul 2020 11:12:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39990)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1k0R9Z-0006IU-30
 for qemu-devel@nongnu.org; Tue, 28 Jul 2020 11:04:29 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:21203
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1k0R9V-0006uE-UF
 for qemu-devel@nongnu.org; Tue, 28 Jul 2020 11:04:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595948665;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kEro/WGEDa7FLpObt0GBhXJnpiF9wp9HuVFS+fPX2vU=;
 b=AhDdQ+iDADqz+amOEYn11uLvXqczSer8KaZ4unc3jAmFX73lThE8kBHwpVL+PObFpUysYV
 5PWMgnxg9buNNsTBc3KCriJ4Qx8lzZOJs/23cArpY9+onJqWtdzuDw4CKbgFWhAKrj0LVN
 hgXdcU5+a2JgtyV5jitY+UsD/KtkuBU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-472-arlqmFcUPm6xpcDegXiJqA-1; Tue, 28 Jul 2020 11:04:16 -0400
X-MC-Unique: arlqmFcUPm6xpcDegXiJqA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A9346800460;
 Tue, 28 Jul 2020 15:04:15 +0000 (UTC)
Received: from blue.redhat.com (ovpn-118-248.rdu2.redhat.com [10.10.118.248])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 968FB19C71;
 Tue, 28 Jul 2020 15:04:14 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 4/9] iotests: Add more qemu_img helpers
Date: Tue, 28 Jul 2020 10:04:02 -0500
Message-Id: <20200728150408.291299-5-eblake@redhat.com>
In-Reply-To: <20200728150408.291299-1-eblake@redhat.com>
References: <20200728150408.291299-1-eblake@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/28 11:04:16
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Nir Soffer <nirsof@gmail.com>,
 "open list:Block layer core" <qemu-block@nongnu.org>,
 Max Reitz <mreitz@redhat.com>, Nir Soffer <nsoffer@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Nir Soffer <nirsof@gmail.com>

Add 2 helpers for measuring and checking images:
- qemu_img_measure()
- qemu_img_check()

Both use --output-json and parse the returned json to make easy to use
in other tests. I'm going to use them in a new test, and I hope they
will be useful in may other tests.

Signed-off-by: Nir Soffer <nsoffer@redhat.com>
Message-Id: <20200727215846.395443-4-nsoffer@redhat.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Signed-off-by: Eric Blake <eblake@redhat.com>
---
 tests/qemu-iotests/iotests.py | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests.py
index 8f79668435a0..717b5b652c45 100644
--- a/tests/qemu-iotests/iotests.py
+++ b/tests/qemu-iotests/iotests.py
@@ -141,6 +141,12 @@ def qemu_img_create(*args):

     return qemu_img(*args)

+def qemu_img_measure(*args):
+    return json.loads(qemu_img_pipe("measure", "--output", "json", *args))
+
+def qemu_img_check(*args):
+    return json.loads(qemu_img_pipe("check", "--output", "json", *args))
+
 def qemu_img_verbose(*args):
     '''Run qemu-img without suppressing its output and return the exit code'''
     exitcode = subprocess.call(qemu_img_args + list(args))
-- 
2.27.0


