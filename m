Return-Path: <SRS0=e3er=AV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 204F4C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 05:09:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DAF6B20663
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 05:09:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="co/azkCV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DAF6B20663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38186 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtlI4-0004tW-3q
	for qemu-devel@archiver.kernel.org; Fri, 10 Jul 2020 01:09:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47746)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1jtlFV-0008AP-JB
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 01:07:01 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:33474
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1jtlFT-0006VZ-7c
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 01:07:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594357617;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=/tQhZbL3eFOg3ToNRuxhDEp6R2PwkxqoPcInhqsgN34=;
 b=co/azkCV/z8CIqLfR7cTBhx7EOZ9U03gA/OfkizMPXkIbHk+5oMcqGU/ovhtHpz4orBFCu
 OStvqU+Ko4/TDUA0/zoU4/Fpn9MwLYGyjju98tQrRFC3D2n5zlYgmgGT9/V4n7pMQSmOSX
 mYhlQQryWmvg018OMW8T8oxLya6Q1Qc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-405-ZLVU2FAcPKOYNhvcSt02WQ-1; Fri, 10 Jul 2020 01:06:55 -0400
X-MC-Unique: ZLVU2FAcPKOYNhvcSt02WQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 05F69106B242;
 Fri, 10 Jul 2020 05:06:54 +0000 (UTC)
Received: from probe.redhat.com (ovpn-118-196.rdu2.redhat.com [10.10.118.196])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B54AF10016DA;
 Fri, 10 Jul 2020 05:06:49 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 00/12] python/machine.py: refactor shutdown
Date: Fri, 10 Jul 2020 01:06:37 -0400
Message-Id: <20200710050649.32434-1-jsnow@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=jsnow@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/10 00:36:21
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
Cc: kwolf@redhat.com, Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Eduardo Habkost <ehabkost@redhat.com>, John Snow <jsnow@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

v5: More or less rewritten.

This series is motivated by a desire to move python/qemu onto a strict
mypy/pylint regime to help prevent regressions in the python codebase.

1. Remove the "bare except" pattern in the existing shutdown code, which
   can mask problems and make debugging difficult.

2. Ensure that post-shutdown cleanup is always performed, even when
   graceful termination fails.

3. Unify cleanup paths such that no matter how the VM is terminated, the
   same functions and steps are always taken to reset the object state.

4. Rewrite shutdown() such that any error encountered when attempting a
   graceful shutdown will be raised as an AbnormalShutdown exception.
   The pythonic idiom is to allow the caller to decide if this is a
   problem or not.

Previous versions of this series did not engage the fourth goal, and ran
into race conditions. When I was trying to allow shutdown to succeed if
QEMU was already closed, it became impossible to tell in which cases
QEMU not being present was "OK" and in which cases it was evidence of a
problem.

This refactoring is even more explicit. If a graceful shutdown is
requested and cannot be performed, an exception /will/ be raised.

In cases where the test writer expects QEMU to already have exited,
vm.wait() should be used in preference to vm.shutdown(). In cases where
a graceful shutdown is not interesting or necessary to the test,
vm.kill() should be used.

John Snow (12):
  python/machine.py: consolidate _post_shutdown()
  python/machine.py: Close QMP socket in cleanup
  python/machine.py: Add _early_cleanup hook
  python/machine.py: Perform early cleanup for wait() calls, too
  python/machine.py: Prohibit multiple shutdown() calls
  python/machine.py: Add a configurable timeout to shutdown()
  python/machine.py: Make wait() call shutdown()
  tests/acceptance: wait() instead of shutdown() where appropriate
  tests/acceptance: Don't test reboot on cubieboard
  python/machine.py: split shutdown into hard and soft flavors
  python/machine.py: re-add sigkill warning suppression
  python/machine.py: change default wait timeout to 3 seconds

 python/qemu/machine.py                   | 166 ++++++++++++++++++-----
 tests/acceptance/boot_linux_console.py   |  14 +-
 tests/acceptance/linux_ssh_mips_malta.py |   2 +
 3 files changed, 141 insertions(+), 41 deletions(-)

-- 
2.21.3


