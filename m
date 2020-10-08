Return-Path: <SRS0=Ajie=DP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A058C4363A
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 14:48:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE3E821789
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 14:48:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE3E821789
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54792 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQXDr-0005vm-MU
	for qemu-devel@archiver.kernel.org; Thu, 08 Oct 2020 10:48:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42918)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cfontana@suse.de>) id 1kQXDK-0005Wd-22
 for qemu-devel@nongnu.org; Thu, 08 Oct 2020 10:48:14 -0400
Received: from mx2.suse.de ([195.135.220.15]:41544)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cfontana@suse.de>) id 1kQXDI-0000TH-Fb
 for qemu-devel@nongnu.org; Thu, 08 Oct 2020 10:48:13 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 1FB28AB91;
 Thu,  8 Oct 2020 14:48:11 +0000 (UTC)
To: Paolo Bonzini <pbonzini@redhat.com>
From: Claudio Fontana <cfontana@suse.de>
Subject: does make check now require TCG? Or is it a parallelism issue?
Message-ID: <11ef73ff-4178-b3e8-2e49-44ff014a13ed@suse.de>
Date: Thu, 8 Oct 2020 16:48:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=195.135.220.15; envelope-from=cfontana@suse.de;
 helo=mx2.suse.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/07 23:49:25
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x (no timestamps) [generic]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
Cc: Alex Bennee <alex.bennee@linaro.org>, qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


on master, a build without tcg like:

exec '../configure' '--disable-tcg' '--enable-kvm' '--enable-hax' "$@"

make -j120 check
Generating qemu-version.h with a meson_exe.py custom command
make: *** No rule to make target 'qemu-system-aarch64', needed by 'check-block'.  Stop.
make: *** Waiting for unfinished jobs....

qemu-system-aarch64 is required for check-block now?

If I run without -j:

Running test qtest-i386: qmp-cmd-test
Broken pipe
../tests/qtest/libqtest.c:175: kill_qemu() detected QEMU death from signal 6 (Aborted) (core dumped)
ERROR qtest-i386: qmp-cmd-test - too few tests run (expected 53, got 45)
make: *** [Makefile.mtest:1074: run-test-151] Error 1

Ciao,

Claudio


