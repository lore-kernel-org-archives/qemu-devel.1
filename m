Return-Path: <SRS0=bzpH=76=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88D7DC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 06:20:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 52029208C3
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 06:20:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Xd2w66Gh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52029208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49994 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlRQY-0001m9-JC
	for qemu-devel@archiver.kernel.org; Wed, 17 Jun 2020 02:20:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54228)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jlRP7-00019s-9Z
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 02:18:33 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:51707
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jlRP4-0008Rj-4d
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 02:18:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592374709;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:openpgp:openpgp;
 bh=twrI3OKoGebtO3bNfSOHeOmuQ145WYRVbssqRgSOGL4=;
 b=Xd2w66Gh9A9PyxbuLP2junY6W2PZSDuA3760hJLu792mnMy2EdlRPlVT6NM7utbGBlWvGG
 wXtgWACvzd9HB18pcpd7ski9mpaw6U72iN8/SL3DPqDInuP4zxoo510lqDr7oKA0svCqNv
 8exSamnvVlEzmiMuWTg98twX7X7zELk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-472-4so7_6aKPCyYK7NypXh67Q-1; Wed, 17 Jun 2020 02:18:21 -0400
X-MC-Unique: 4so7_6aKPCyYK7NypXh67Q-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F36DD18585C5;
 Wed, 17 Jun 2020 06:18:20 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-112-131.ams2.redhat.com [10.36.112.131])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0BE9810013D6;
 Wed, 17 Jun 2020 06:18:19 +0000 (UTC)
To: QEMU Developers <qemu-devel@nongnu.org>
From: Thomas Huth <thuth@redhat.com>
Subject: iotest 041 is failing with -qed
Openpgp: preference=signencrypt
Message-ID: <900ebe8c-ac9e-a355-b068-41735863dce4@redhat.com>
Date: Wed, 17 Jun 2020 08:18:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=thuth@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/16 23:30:45
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Kevin Wolf <kwolf@redhat.com>, Qemu-block <qemu-block@nongnu.org>,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


 Hi!

I just noticed that iotest 041 is failing with -qed:

$ ./check -qed 041
QEMU          --
"tests/qemu-iotests/../../x86_64-softmmu/qemu-system-x86_64" -nodefaults
-display none -accel qtest
QEMU_IMG      -- "tests/qemu-iotests/../../qemu-img"
QEMU_IO       -- "tests/qemu-iotests/../../qemu-io"  --cache writeback
--aio threads -f qed
QEMU_NBD      -- "tests/qemu-iotests/../../qemu-nbd"
IMGFMT        -- qed
IMGPROTO      -- file
PLATFORM      -- Linux/x86_64 thuth 4.18.0-80.11.2.el8_0.x86_64
TEST_DIR      -- tests/qemu-iotests/scratch
SOCK_DIR      -- /tmp/tmp.Fgwzwl4EoG
SOCKET_SCM_HELPER -- tests/qemu-iotests/socket_scm_helper

041      fail       [08:12:36] [08:13:09]      (last: 31s)   output
mismatch (see 041.out.bad)
--- tests/qemu-iotests/041.out	2020-06-15 14:11:05.389400610 +0200
+++ tests/qemu-iotests/041.out.bad	2020-06-17 08:13:09.205195987 +0200
@@ -1,5 +1,33 @@
-........................................................................................................
+........................................F............F..................................................
+======================================================================
+FAIL: test_small_target (__main__.TestSingleBlockdev)
+----------------------------------------------------------------------
+Traceback (most recent call last):
+  File "041", line 281, in test_small_target
+    self.do_test_target_size(self.image_len // 2)
+  File "041", line 270, in do_test_target_size
+    self.assert_qmp(result, 'return', {})
+  File "tests/qemu-iotests/iotests.py", line 848, in assert_qmp
+    result = self.dictpath(d, path)
+  File "tests/qemu-iotests/iotests.py", line 822, in dictpath
+    self.fail(f'failed path traversal for "{path}" in "{d}"')
+AssertionError: failed path traversal for "return" in "{'error':
{'class': 'GenericError', 'desc': 'Shrinking images is currently not
supported'}}"
+
+======================================================================
+FAIL: test_small_target (__main__.TestSingleBlockdevUnalignedLength)
+----------------------------------------------------------------------
+Traceback (most recent call last):
+  File "041", line 281, in test_small_target
+    self.do_test_target_size(self.image_len // 2)
+  File "041", line 270, in do_test_target_size
+    self.assert_qmp(result, 'return', {})
+  File "tests/qemu-iotests/iotests.py", line 848, in assert_qmp
+    result = self.dictpath(d, path)
+  File "tests/qemu-iotests/iotests.py", line 822, in dictpath
+    self.fail(f'failed path traversal for "{path}" in "{d}"')
+AssertionError: failed path traversal for "return" in "{'error':
{'class': 'GenericError', 'desc': 'Shrinking images is currently not
supported'}}"
+
 ----------------------------------------------------------------------
 Ran 104 tests

-OK
+FAILED (failures=2)
Failures: 041
Failed 1 of 1 iotests

Is it a known problem already?

 Thomas


