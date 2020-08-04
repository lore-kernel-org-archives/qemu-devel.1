Return-Path: <SRS0=UEgn=BO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72620C433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2020 17:03:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 48EFF207FC
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2020 17:03:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b+Vwc1ii"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48EFF207FC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39990 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k30M2-0001Q1-Ed
	for qemu-devel@archiver.kernel.org; Tue, 04 Aug 2020 13:03:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60608)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1k30JZ-0006xK-H6
 for qemu-devel@nongnu.org; Tue, 04 Aug 2020 13:01:25 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:42826
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1k30JP-0005R8-W1
 for qemu-devel@nongnu.org; Tue, 04 Aug 2020 13:01:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596560474;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Ml4pToayktzu6pOgvsvGNQfwf979wKFzAc50p9F933A=;
 b=b+Vwc1iilI+5gDLAhQoBq81Af6O8poBKwRldnLQmHL2de265cikgzsHcnlvM9Z47jYq8RE
 biJ7Xjr/1ULCyhg2AaZo1E2FVcZVr9H15scF5xpEqKaZDBPw6Z03xydHxswh+WpO0dZM/G
 5mmaxo1ML/74RpIH1JPs0C9EjkAULwE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-341-V0OZqaIqNLWYt209TR2j3w-1; Tue, 04 Aug 2020 13:01:12 -0400
X-MC-Unique: V0OZqaIqNLWYt209TR2j3w-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4759A100AA22;
 Tue,  4 Aug 2020 17:01:11 +0000 (UTC)
Received: from thuth.com (ovpn-112-162.ams2.redhat.com [10.36.112.162])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3C73E10013D0;
 Tue,  4 Aug 2020 17:00:57 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH 00/11] Run cross-compilation build tests in the gitlab-CI
Date: Tue,  4 Aug 2020 19:00:44 +0200
Message-Id: <20200804170055.2851-1-thuth@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=thuth@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/04 01:28:11
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Stefan Weil <sw@weilnetz.de>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Now that we can use all our QEMU build containers in the gitlab-CI,
we can also run the cross-compilation jobs there. Of course, some
problems have to be fixed first, since apparently nobody was running
"make check-build" for QEMU for 32-bit big endian targets or MinGW
recently...

As a bonus, the last two patches also enable WHPX builds with our
debian-win64-cross container, so that we can compile-test this accelerator
code now, too.

Bruce Rogers (1):
  virtio-mem: Correct format specifier mismatch for RISC-V

Thomas Huth (10):
  target/riscv/vector_helper: Fix build on 32-bit big endian targets
  tests/Makefile: test-image-locking needs CONFIG_POSIX
  tests/Makefile: test-replication needs CONFIG_POSIX
  tests/Makefile: Only build usable targets during 'make check-build'
  tests/Makefile: Add $(EXESUF) to fp-test target
  Get rid of the libqemustub.a remainders
  stubs/notify-event: Mark qemu_notify_event() stub as "weak"
  gitlab-ci: Add cross-compiling build tests
  configure: Allow automatic WHPX detection
  dockerfiles/debian-win64-cross: Download WHPX MinGW headers

 .gitlab-ci.d/crossbuilds.yml                  | 113 ++++++++++++++++++
 .gitlab-ci.yml                                |   1 +
 MAINTAINERS                                   |   1 +
 Makefile                                      |   2 +-
 configure                                     |   1 +
 hw/virtio/virtio-mem.c                        |   2 +-
 scripts/coverity-scan/run-coverity-scan       |   3 -
 stubs/notify-event.c                          |   2 +-
 target/riscv/vector_helper.c                  |   4 +-
 tests/Makefile.include                        |  13 +-
 .../dockerfiles/debian-win64-cross.docker     |   9 +-
 tests/test-util-sockets.c                     |   3 +-
 12 files changed, 141 insertions(+), 13 deletions(-)
 create mode 100644 .gitlab-ci.d/crossbuilds.yml

-- 
2.18.1


