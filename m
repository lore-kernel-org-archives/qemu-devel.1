Return-Path: <SRS0=8bV5=CN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90960C28E83
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 11:44:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5E4B42074D
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 11:44:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E4B42074D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42066 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kEA98-0004ti-Ds
	for qemu-devel@archiver.kernel.org; Fri, 04 Sep 2020 07:44:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42388)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kEA61-00088I-Rv
 for qemu-devel@nongnu.org; Fri, 04 Sep 2020 07:41:34 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:48952
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kEA5w-0005Ar-DH
 for qemu-devel@nongnu.org; Fri, 04 Sep 2020 07:41:33 -0400
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-363-BTHO2joHPc6k9vjCVRTCsw-1; Fri, 04 Sep 2020 07:41:26 -0400
X-MC-Unique: BTHO2joHPc6k9vjCVRTCsw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4408A344F1
 for <qemu-devel@nongnu.org>; Fri,  4 Sep 2020 11:41:25 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 090495D9F7
 for <qemu-devel@nongnu.org>; Fri,  4 Sep 2020 11:41:24 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 04/46] mtest2make: split environment from test command
Date: Fri,  4 Sep 2020 07:40:40 -0400
Message-Id: <20200904114122.31307-5-pbonzini@redhat.com>
In-Reply-To: <20200904114122.31307-1-pbonzini@redhat.com>
References: <20200904114122.31307-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0.0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/04 03:57:33
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Pass the environment and test command in separate macro arguments,
so that we will be able to insert a test driver in the next patch.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 scripts/mtest2make.py | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/scripts/mtest2make.py b/scripts/mtest2make.py
index d7a51bf97e..f4ee4d3994 100644
--- a/scripts/mtest2make.py
+++ b/scripts/mtest2make.py
@@ -19,16 +19,16 @@ class Suite(object):
 print('''
 SPEED = quick
 
-# $1 = test command, $2 = test name
-.test-human-tap = $1 < /dev/null | ./scripts/tap-driver.pl --test-name="$2" $(if $(V),,--show-failures-only)
-.test-human-exitcode = $1 < /dev/null
-.test-tap-tap = $1 < /dev/null | sed "s/^[a-z][a-z]* [0-9]*/& $2/" || true
-.test-tap-exitcode = printf "%s\\n" 1..1 "`$1 < /dev/null > /dev/null || echo "not "`ok 1 $2"
-.test.print = echo $(if $(V),'$1','Running test $2') >&3
+# $1 = environment, $2 = test command, $3 = test name
+.test-human-tap = $1 $2 < /dev/null | ./scripts/tap-driver.pl --test-name="$3" $(if $(V),,--show-failures-only)
+.test-human-exitcode = $1 $2 < /dev/null
+.test-tap-tap = $1 $2 < /dev/null | sed "s/^[a-z][a-z]* [0-9]*/& $3/" || true
+.test-tap-exitcode = printf "%s\\n" 1..1 "`$1 $2 < /dev/null > /dev/null || echo "not "`ok 1 $3"
+.test.print = echo $(if $(V),'$1 $2','Running test $3') >&3
 .test.env = MALLOC_PERTURB_=$${MALLOC_PERTURB_:-$$(( $${RANDOM:-0} % 255 + 1))}
 
 # $1 = test name, $2 = test target (human or tap)
-.test.run = $(call .test.print,$(.test.cmd.$1),$(.test.name.$1)) && $(call .test-$2-$(.test.driver.$1),$(.test.cmd.$1),$(.test.name.$1))
+.test.run = $(call .test.print,$(.test.env.$1),$(.test.cmd.$1),$(.test.name.$1)) && $(call .test-$2-$(.test.driver.$1),$(.test.env.$1),$(.test.cmd.$1),$(.test.name.$1))
 
 define .test.human_k
         @exec 3>&1; rc=0; $(foreach TEST, $1, $(call .test.run,$(TEST),human) || rc=$$?;) \\
@@ -65,7 +65,7 @@ for test in json.load(sys.stdin):
             test['cmd'][0] = executable
     else:
         test['cmd'][0] = executable
-    cmd = '$(.test.env) %s %s' % (env, ' '.join((shlex.quote(x) for x in test['cmd'])))
+    cmd = ' '.join((shlex.quote(x) for x in test['cmd']))
     if test['workdir'] is not None:
         cmd = '(cd %s && %s)' % (shlex.quote(test['workdir']), cmd)
     driver = test['protocol'] if 'protocol' in test else 'exitcode'
@@ -73,6 +73,7 @@ for test in json.load(sys.stdin):
     i += 1
     print('.test.name.%d := %s' % (i, test['name']))
     print('.test.driver.%d := %s' % (i, driver))
+    print('.test.env.%d := $(.test.env) %s' % (i, env))
     print('.test.cmd.%d := %s' % (i, cmd))
 
     test_suites = test['suite'] or ['default']
-- 
2.26.2



