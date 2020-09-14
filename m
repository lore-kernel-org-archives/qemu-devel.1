Return-Path: <SRS0=afRr=CX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F164C43461
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 11:11:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B855421D1A
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 11:11:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SpASuyHU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B855421D1A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34976 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kHmOf-0005Sd-LI
	for qemu-devel@archiver.kernel.org; Mon, 14 Sep 2020 07:11:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44642)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kHmMw-0004RE-Q4
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 07:09:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:47185)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kHmMu-000696-Mt
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 07:09:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600081795;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=RWDXeAVIfJMI1YzhpIDf2TIslxLGj/o3X6RabWaJ5Pk=;
 b=SpASuyHUu/mFKXMIKgMOedHTwOdhagIB+AkAHpsivY38OjrmWDBym7skOFNoEin8cf01Nb
 sB3VKaK7FzDDQ4CxU08Kl2E/5+i2zrs7EVHA/mghkQ1BT0TQKjFi4UioDBl3nxaFYI7EHG
 9VmJpFqbWkSwWqrjTuySXsZv/A7jgLQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-33-QBGFO-4lOQi6OiijxSx-Ng-1; Mon, 14 Sep 2020 07:09:51 -0400
X-MC-Unique: QBGFO-4lOQi6OiijxSx-Ng-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E81F2427F2
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2020 11:09:50 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-114-99.ams2.redhat.com
 [10.36.114.99])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 95CA95DA60;
 Mon, 14 Sep 2020 11:09:49 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] scripts: display how long each test takes to execute
Date: Mon, 14 Sep 2020 12:09:48 +0100
Message-Id: <20200914110948.1425082-1-berrange@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=berrange@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/14 02:10:37
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.792,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Sometimes under CI tests non-deterministically take longer to execute
than expected which can trigger timeouts. It is almost impossible to
diagnose this though without seeing execution time for each test case.

With this change, when passing "V=1" to make, we get a duration printed
at test completion:

$ make check V=1
...snip...
MALLOC_PERTURB_=${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))} QTEST_QEMU_IMG=./qemu-img G_TEST_DBUS_DAEMON=/home/berrange/src/virt/qemu/tests/dbus-vmstate-daemon.sh QTEST_QEMU_BINARY=./qemu-system-x86_64 tests/qtest/migration-test --tap -k
PASS 1 qtest-x86_64: migration-test /x86_64/migration/deprecated
PASS 2 qtest-x86_64: migration-test /x86_64/migration/bad_dest
PASS 3 qtest-x86_64: migration-test /x86_64/migration/fd_proto
PASS 4 qtest-x86_64: migration-test /x86_64/migration/validate_uuid
PASS 5 qtest-x86_64: migration-test /x86_64/migration/validate_uuid_error
PASS 6 qtest-x86_64: migration-test /x86_64/migration/validate_uuid_src_not_set
PASS 7 qtest-x86_64: migration-test /x86_64/migration/validate_uuid_dst_not_set
PASS 8 qtest-x86_64: migration-test /x86_64/migration/auto_converge
PASS 9 qtest-x86_64: migration-test /x86_64/migration/postcopy/unix
PASS 10 qtest-x86_64: migration-test /x86_64/migration/postcopy/recovery
PASS 11 qtest-x86_64: migration-test /x86_64/migration/precopy/unix
PASS 12 qtest-x86_64: migration-test /x86_64/migration/precopy/tcp
PASS 13 qtest-x86_64: migration-test /x86_64/migration/xbzrle/unix
PASS 14 qtest-x86_64: migration-test /x86_64/migration/multifd/tcp/none
PASS 15 qtest-x86_64: migration-test /x86_64/migration/multifd/tcp/cancel
PASS 16 qtest-x86_64: migration-test /x86_64/migration/multifd/tcp/zlib
TIME 28 seconds

Output without V=1 is unchanged.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---

BTW, this script probably needs an update in MAINTAINERS as the
suggested CC's have never touched it.

Also, I feel this is quite a gross hack. If there is a better approach
I'm happy to hear suggestions. I was hoping to modify tap-driver.pl
originally, but then I discovered it doesn't actually invoke the test
program, it merely receives its output so can't track timings.

I'm unclear if meson's native test runner can print timings. If not,
we might want to submit an RFE there too.

 scripts/mtest2make.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/mtest2make.py b/scripts/mtest2make.py
index 9cbb2e374d..9103ae65b9 100644
--- a/scripts/mtest2make.py
+++ b/scripts/mtest2make.py
@@ -20,7 +20,7 @@ print('''
 SPEED = quick
 
 # $1 = environment, $2 = test command, $3 = test name, $4 = dir
-.test-human-tap = $1 $(if $4,(cd $4 && $2),$2) < /dev/null | ./scripts/tap-driver.pl --test-name="$3" $(if $(V),,--show-failures-only)
+.test-human-tap = export then=`date +%s` ; $1 $(if $4,(cd $4 && $2),$2) < /dev/null | ./scripts/tap-driver.pl --test-name="$3" $(if $(V),,--show-failures-only) ; export now=`date +%s` ; delta=`expr $$now - $$then` ; $(if $(V),echo "TIME $$delta seconds",true)
 .test-human-exitcode = $1 $(PYTHON) scripts/test-driver.py $(if $4,-C$4) $(if $(V),--verbose) -- $2 < /dev/null
 .test-tap-tap = $1 $(if $4,(cd $4 && $2),$2) < /dev/null | sed "s/^[a-z][a-z]* [0-9]*/& $3/" || true
 .test-tap-exitcode = printf "%s\\n" 1..1 "`$1 $(if $4,(cd $4 && $2),$2) < /dev/null > /dev/null || echo "not "`ok 1 $3"
-- 
2.26.2


