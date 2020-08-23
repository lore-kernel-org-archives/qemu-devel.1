Return-Path: <SRS0=gE17=CB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=BAYES_00,HK_RANDOM_FROM,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AF96C433E1
	for <qemu-devel@archiver.kernel.org>; Sun, 23 Aug 2020 22:59:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6F8D6206BE
	for <qemu-devel@archiver.kernel.org>; Sun, 23 Aug 2020 22:59:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F8D6206BE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38522 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k9yxO-0002st-MQ
	for qemu-devel@archiver.kernel.org; Sun, 23 Aug 2020 18:59:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40238)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1k9ywi-0002Mx-HR
 for qemu-devel@nongnu.org; Sun, 23 Aug 2020 18:58:40 -0400
Received: from relay64.bu.edu ([128.197.228.104]:46726)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1k9ywg-0000Dx-1D
 for qemu-devel@nongnu.org; Sun, 23 Aug 2020 18:58:39 -0400
X-Envelope-From: alxndr@bu.edu
X-BU-AUTH: mozz.bu.edu [128.197.127.33]
Received: from BU-AUTH (localhost.localdomain [127.0.0.1]) (authenticated
 bits=0)
 by relay64.bu.edu (8.14.3/8.14.3) with ESMTP id 07NMw4Qa005932
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
 Sun, 23 Aug 2020 18:58:09 -0400
Date: Sun, 23 Aug 2020 18:58:04 -0400
From: Alexander Bulekov <alxndr@bu.edu>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: [Fwd] Issue 25164 in oss-fuzz: qemu: Fuzzing build failure
Message-ID: <20200823225804.umk5gh6knptqo5mw@mozz.bu.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=128.197.228.104; envelope-from=alxndr@bu.edu;
 helo=relay64.bu.edu
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/23 18:58:35
X-ACL-Warn: Detected OS   = Linux 2.6.x
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, HK_RANDOM_ENVFROM=0.001,
 HK_RANDOM_FROM=0.999, RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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
Cc: Darren Kenny <darren.kenny@oracle.com>, Bandan Das <bsd@redhat.com>,
 qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Paolo,
Our oss-fuzz builds started failing, after the meson merge. I think I
tracked down the issues:
1.) Looking at the build-log here:
https://oss-fuzz-build-logs.storage.googleapis.com/log-d43d402c-1ce5-4422-b3db-ccbf83a862a0.txt
The error happens at link-time. Re-running the build with V=1:
"/usr/bin/ld" ...
--whole-archive /usr/local/lib/clang/12.0.0/.../libclang_rt.asan-x86_64.a \
--start-group ..... -T /src/qemu/tests/qtest/fuzz/fork_fuzz.ld  \
-wrap qtest_inb -wrap qtest_inw ..... --end-group .....

I compared this against what we had before meson, and noticed that the
start-group/end-group are new. Removing those manually from the link
command, I can link successfully. It looks like these linker groups are
something that meson controls. Is there something we can tweak to make
the fork_fuzz.ld linker script apply to all the objects?

2.) 77afc75f69 ("oss-fuzz/build: remove LIB_FUZZING_ENGINE")

On oss-fuzz, we cannot explicitly specify fsanitize=fuzzer: We have to
leverage the $CC $CXX $CFLAGS $CXXFLAGS $LIB_FUZZING_ENGINE from
oss-fuzz. That was the reason for the "make CONFIG_FUZZ CFLAGS" trickery
in the original build script.

Details:
https://google.github.io/oss-fuzz/getting-started/new-project-guide/#Requirements

To work around this, I think we can create separate configure options
--enable-oss-fuzz and --oss-fuzz-cflags and CONFIG_OSS_FUZZ. In meson we
create a new "source-set" specific_oss_fuzz_ss which is identical to
specific_fuzz_ss, except it does not depend on "-fsanitize=fuzzer",
which is specified in tests/qtest/fuzz/meson.build

I've been working on patches to do (2) but I don't know how to fix (1).
Do you have any ideas?

-Alex

----- Forwarded message from ClusterFuzz-External via monorail <monorail+v2.382749006@chromium.org> -----

Date: Sun, 23 Aug 2020 03:10:14 -0700
From: ClusterFuzz-External via monorail <monorail+v2.382749006@chromium.org>
To: alxndr@bu.edu
Subject: Issue 25164 in oss-fuzz: qemu: Fuzzing build failure

Status: New
Owner: ----
CC: b...@redhat.com, stefa...@redhat.com, alx...@bu.edu, pbonz...@redhat.com, darren.k...@oracle.com 
Labels: Proj-qemu
Type: Build-Failure

New issue 25164 by ClusterFuzz-External: qemu: Fuzzing build failure
https://bugs.chromium.org/p/oss-fuzz/issues/detail?id=25164

The last 2 builds for qemu have been failing.
Build log: https://oss-fuzz-build-logs.storage.googleapis.com/log-d43d402c-1ce5-4422-b3db-ccbf83a862a0.txt
Build type: fuzzing

To reproduce locally, please see: https://google.github.io/oss-fuzz/advanced-topics/reproducing#reproducing-build-failures

This bug tracker is not being monitored by OSS-Fuzz team. If you have any questions, please create an issue at https://github.com/google/oss-fuzz/issues/new.

**This bug will be automatically closed within a day once it is fixed.**

-- 
You received this message because:
  1. You were specifically CC'd on the issue

You may adjust your notification preferences at:
https://bugs.chromium.org/hosting/settings

Reply to this email to add a comment.

----- End forwarded message -----

