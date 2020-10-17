Return-Path: <SRS0=yvcL=DY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F443C433E7
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2020 14:50:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF74B20708
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2020 14:50:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BWPPw2ex"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF74B20708
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41268 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kTnXa-0005h5-Tf
	for qemu-devel@archiver.kernel.org; Sat, 17 Oct 2020 10:50:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43764)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kTnVJ-0004L6-5H
 for qemu-devel@nongnu.org; Sat, 17 Oct 2020 10:48:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:26748)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kTnVE-0000NX-DV
 for qemu-devel@nongnu.org; Sat, 17 Oct 2020 10:48:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602946091;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=jzLM894UY3vLab07xZ9cF8YaWzI50YiKNhyVhJR7m40=;
 b=BWPPw2exbNgoHefaqOcJeQTzUHkTfGRyT0lTWB9hyjSVIS8yGV29yHYKoMDyKQzBKnrne0
 vgqXoPW9oWw57zVzt0Sz0J9PwWEbxdXNc8BIm6OYUol5xDfJSWRR1r74wwQsduoEdGqk5w
 zruID/Cjr6oM0YwxBWq+6g1RgAo+Uww=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-403-c6ehkFY0Pp6w2uNJ2Gyntw-1; Sat, 17 Oct 2020 10:48:07 -0400
X-MC-Unique: c6ehkFY0Pp6w2uNJ2Gyntw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EB093393B1
 for <qemu-devel@nongnu.org>; Sat, 17 Oct 2020 14:48:06 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id AECBA6EF70
 for <qemu-devel@nongnu.org>; Sat, 17 Oct 2020 14:48:06 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v3 00/22] Build system + misc changes for 2020-10-16
Date: Sat, 17 Oct 2020 10:48:03 -0400
Message-Id: <20201017144805.1641371-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/17 05:57:47
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit 3e40748834923798aa57e3751db13a069e2c617b:

  Merge remote-tracking branch 'remotes/rth/tags/pull-mb-20201014' into staging (2020-10-15 20:30:24 +0100)

are available in the Git repository at:

  https://gitlab.com/bonzini/qemu.git tags/for-upstream

for you to fetch changes up to c47110d90fa5401bcc42c17f8ae0724a1c96599a:

  ci: include configure and meson logs in all jobs if configure fails (2020-10-17 10:45:53 -0400)

----------------------------------------------------------------
* Drop ninjatool and just require ninja (Paolo)
* Fix docs build under msys2 (Yonggang)
* HAX snafu fix (Claudio)
* Disable signal handlers during fuzzing (Alex)
* Miscellaneous fixes (Bruce, Greg)

----------------------------------------------------------------
Alexander Bulekov (1):
      fuzz: Disable QEMU's SIG{INT,HUP,TERM} handlers

Bruce Rogers (3):
      meson.build: don't condition iconv detection on library detection
      configure: fix handling of --docdir parameter
      meson: Only install icons and qemu.desktop if have_system

Claudio Fontana (1):
      hax: unbreak accelerator cpu code after cpus.c split

Greg Kurz (1):
      Makefile: Ensure cscope.out/tags/TAGS are generated in the source tree

Paolo Bonzini (13):
      submodules: bump meson to 0.55.3
      tests/Makefile.include: unbreak non-tcg builds
      make: run shell with pipefail
      tests: add missing generated sources to testqapi
      configure: move QEMU_INCLUDES to meson
      dockerfiles: enable Centos 8 PowerTools
      add ninja to dockerfiles, CI configurations and test VMs
      build: cleanups to Makefile
      build: replace ninjatool with ninja
      build: add --enable/--disable-libudev
      meson: cleanup curses/iconv test
      meson: move SPHINX_ARGS references within "if build_docs"
      ci: include configure and meson logs in all jobs if configure fails

Yonggang Luo (3):
      docs: Fix Sphinx configuration for msys2/mingw
      meson: Move the detection logic for sphinx to meson
      cirrus: Enable doc build on msys2/mingw

 .cirrus.yml                                |   21 +-
 .gitlab-ci.yml                             |    6 +-
 .travis.yml                                |   21 +-
 Makefile                                   |  135 ++--
 configure                                  |  101 +--
 docs/conf.py                               |    2 +-
 docs/devel/build-system.rst                |    6 +-
 docs/meson.build                           |   46 ++
 docs/sphinx/kerneldoc.py                   |    2 +-
 meson                                      |    2 +-
 meson.build                                |  185 ++---
 meson_options.txt                          |    6 +
 scripts/mtest2make.py                      |    3 +-
 scripts/ninjatool.py                       | 1008 ----------------------------
 target/i386/hax-cpus.c                     |    1 +
 tests/Makefile.include                     |    2 +-
 tests/docker/dockerfiles/centos7.docker    |    1 +
 tests/docker/dockerfiles/centos8.docker    |    5 +-
 tests/docker/dockerfiles/debian10.docker   |    1 +
 tests/docker/dockerfiles/fedora.docker     |    1 +
 tests/docker/dockerfiles/travis.docker     |    2 +-
 tests/docker/dockerfiles/ubuntu.docker     |    1 +
 tests/docker/dockerfiles/ubuntu1804.docker |    1 +
 tests/docker/dockerfiles/ubuntu2004.docker |    1 +
 tests/include/meson.build                  |    8 +-
 tests/meson.build                          |   14 +-
 tests/qapi-schema/meson.build              |   88 +--
 tests/qtest/fuzz/fuzz.c                    |    8 +
 tests/vm/centos                            |    2 +-
 tests/vm/centos.aarch64                    |    2 +-
 tests/vm/fedora                            |    2 +-
 tests/vm/freebsd                           |    1 +
 tests/vm/netbsd                            |    1 +
 tests/vm/openbsd                           |    1 +
 tests/vm/ubuntu.aarch64                    |    2 +-
 tests/vm/ubuntu.i386                       |    2 +-
 ui/meson.build                             |    7 +-
 37 files changed, 389 insertions(+), 1309 deletions(-)
 delete mode 100755 scripts/ninjatool.py
-- 
2.26.2


