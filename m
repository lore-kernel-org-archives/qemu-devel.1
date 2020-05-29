Return-Path: <SRS0=UjLb=7L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13382C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2020 07:05:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC9CA207D4
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2020 07:05:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC9CA207D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60996 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jeZ5T-0005BE-Ut
	for qemu-devel@archiver.kernel.org; Fri, 29 May 2020 03:05:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40702)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Pavel.Dovgaluk@gmail.com>)
 id 1jeZ4I-0003Ab-1u
 for qemu-devel@nongnu.org; Fri, 29 May 2020 03:04:38 -0400
Received: from mail.ispras.ru ([83.149.199.45]:33198)
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <Pavel.Dovgaluk@gmail.com>) id 1jeZ4G-0000is-Vv
 for qemu-devel@nongnu.org; Fri, 29 May 2020 03:04:37 -0400
Received: from [127.0.1.1] (unknown [62.118.151.149])
 by mail.ispras.ru (Postfix) with ESMTPSA id EDD6BCD461;
 Fri, 29 May 2020 10:04:33 +0300 (MSK)
Subject: [PATCH v3 00/11] Record/replay acceptance tests
From: Pavel Dovgalyuk <Pavel.Dovgaluk@gmail.com>
To: qemu-devel@nongnu.org
Date: Fri, 29 May 2020 10:04:33 +0300
Message-ID: <159073587336.20809.5404476664125786279.stgit@pasha-ThinkPad-X280>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: softfail client-ip=83.149.199.45;
 envelope-from=Pavel.Dovgaluk@gmail.com; helo=mail.ispras.ru
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/29 01:56:22
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: 7
X-Spam_score: 0.7
X-Spam_bar: /
X-Spam_report: (0.7 / 5.0 requ) BAYES_00=-1.9, DKIM_ADSP_CUSTOM_MED=0.001,
 FORGED_GMAIL_RCVD=1, FREEMAIL_FROM=0.001, NML_ADSP_CUSTOM_MED=0.9,
 SPF_SOFTFAIL=0.665 autolearn=_AUTOLEARN
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
Cc: wrampazz@redhat.com, alex.bennee@linaro.org, dovgaluk@ispras.ru,
 pavel.dovgaluk@ispras.ru, crosa@redhat.com, pbonzini@redhat.com,
 philmd@redhat.com, ehabkost@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following series adds record/replay tests to the acceptance group.
Test pass successfully with the latest submitted record/replay fixes:
 - replay: notify the main loop when there are no instructions
 - replay: synchronize on every virtual timer callback

The provided tests perform kernel boot and disk image boot scenarios.
For all of them recording and replaying phases are executed.
Tests were borrowed from existing boot_linux*.py tests. But some
of the platforms and images were excluded, because icount for them
still has some issues.

Tested-by: Philippe Mathieu-Daude <philmd@redhat.com>

v3 changes:
 - Added record/replay logging (suggested by Philippe Mathieu-Daudé)
 - Changed the console pattern to get longer kernel execution (suggested by Alex Bennée)
 - Coding style fixes
 - Other minor changes
v2 changes:
 - Some test structure refactoring (suggested by Willian Rampazzo)

---

Pavel Dovgaluk (11):
      tests/acceptance: allow console interaction with specific VMs
      tests/acceptance: refactor boot_linux_console test to allow code reuse
      tests/acceptance: add base class record/replay kernel tests
      tests/acceptance: add kernel record/replay test for x86_64
      tests/acceptance: add record/replay test for aarch64
      tests/acceptance: add record/replay test for arm
      tests/acceptance: add record/replay test for ppc64
      tests/acceptance: add record/replay test for m68k
      tests/acceptance: record/replay tests with advcal images
      tests/acceptance: refactor boot_linux to allow code reuse
      tests/acceptance: Linux boot test for record/replay


 0 files changed

--
Pavel Dovgalyuk

