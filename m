Return-Path: <SRS0=LOIU=A4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28999C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2020 09:57:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E524E20684
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2020 09:57:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cy0rCcBY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E524E20684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38376 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jwN7A-0003OR-5B
	for qemu-devel@archiver.kernel.org; Fri, 17 Jul 2020 05:57:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57214)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jwN6G-0002Fr-K2
 for qemu-devel@nongnu.org; Fri, 17 Jul 2020 05:56:16 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:23819
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jwN6D-0001An-Ls
 for qemu-devel@nongnu.org; Fri, 17 Jul 2020 05:56:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594979772;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=yh4hBsKoBUXLVrSekHzHPpyNOBqMQDynT6R0h9wq0Pk=;
 b=cy0rCcBYJ3KFq15wlm3RBqQDfiKJT0cVOSt4DLgN9ERqS4tcLp0TkJJ2Zcb9iPbKSWICtw
 JJqXvsueVwq3WtLTpBnww2n9YmcCJ359aIJvQgxgUhEjcLf0TMLlAsVzx3ydZl2cQ6Q1z3
 n4StRkXZPdNF12TBQqfc/6MSuR/lHug=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-30-z-JUj1IBObiC3eps0urJlw-1; Fri, 17 Jul 2020 05:56:09 -0400
X-MC-Unique: z-JUj1IBObiC3eps0urJlw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 536F1106B245;
 Fri, 17 Jul 2020 09:56:08 +0000 (UTC)
Received: from thuth.com (ovpn-112-62.ams2.redhat.com [10.36.112.62])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6212E5C240;
 Fri, 17 Jul 2020 09:56:07 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: peter.maydell@linaro.org,
	qemu-devel@nongnu.org
Subject: [PULL 0/6] Leak fixes for qtests + fuzzer CI
Date: Fri, 17 Jul 2020 11:55:59 +0200
Message-Id: <20200717095605.27589-1-thuth@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=thuth@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=thuth@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/16 23:13:19
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
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

 Hi Peter,

the following changes since commit 95d1fbabae0cd44156ac4b96d512d143ca7dfd5e:

  Merge remote-tracking branch 'remotes/kraxel/tags/fixes-20200716-pull-request' into staging (2020-07-16 18:50:51 +0100)

are available in the Git repository at:

  https://gitlab.com/huth/qemu.git tags/pull-request-2020-07-17

for you to fetch changes up to b610eba335d5c8ac7484dbb1c886b125e2dea058:

  gitlab-ci.yml: Add fuzzer tests (2020-07-17 10:44:23 +0200)

----------------------------------------------------------------
* Leak fixes
* One fix for running with --enable-werror on macOS
* Add fuzzer test to the Gitlab-CI
----------------------------------------------------------------

Alexander Bulekov (1):
      fuzz: Expect the cmdline in a freeable GString

Li Qiang (2):
      qtest: bios-tables-test: fix a memory leak
      tests: qmp-cmd-test: fix memory leak

Markus Armbruster (1):
      qom: Plug memory leak in "info qom-tree"

Thomas Huth (2):
      configure: Fix for running with --enable-werror on macOS
      gitlab-ci.yml: Add fuzzer tests

 .gitlab-ci.yml                 | 20 +++++++++++++++++++-
 configure                      |  2 +-
 qom/qom-hmp-cmds.c             |  6 ++++--
 tests/qtest/bios-tables-test.c |  1 +
 tests/qtest/fuzz/fuzz.c        | 13 ++++++-------
 tests/qtest/fuzz/fuzz.h        |  6 +++---
 tests/qtest/fuzz/i440fx_fuzz.c |  4 ++--
 tests/qtest/fuzz/qos_fuzz.c    |  6 +++---
 tests/qtest/qmp-cmd-test.c     | 13 +++++++++++++
 9 files changed, 52 insertions(+), 19 deletions(-)


