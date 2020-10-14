Return-Path: <SRS0=kfsL=DV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89BAEC433E7
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 13:58:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B16192222A
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 13:58:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U7ayvkpw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B16192222A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35718 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kShIE-0001RD-Fw
	for qemu-devel@archiver.kernel.org; Wed, 14 Oct 2020 09:58:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55420)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kShEY-0005ua-Qy
 for qemu-devel@nongnu.org; Wed, 14 Oct 2020 09:54:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:54619)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kShEV-0000bL-TP
 for qemu-devel@nongnu.org; Wed, 14 Oct 2020 09:54:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602683663;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=KSjFTyKV1FmAzhbrYIKQ9fJezvJwLV4i3CoQU6AoNfg=;
 b=U7ayvkpw2mmNani3qFhYJdIn3XZhCB1jDJIZiF9DqmvwwqNW1UKbxtV87Q9GuW2dsXdBfQ
 0od2gxbvsjZHkVDqg4yASZLILHdFkIN7j4HKHnZLozzNWaaoGGUtiybnhKoEDddzPjB1ws
 O/WHXAcrsAZfKYwTMAxDp1frkP34tYI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-19-V3gA-XAkMFWCrqqCCSFMxg-1; Wed, 14 Oct 2020 09:54:19 -0400
X-MC-Unique: V3gA-XAkMFWCrqqCCSFMxg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 383058CCB71;
 Wed, 14 Oct 2020 13:54:18 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B682D60C0F;
 Wed, 14 Oct 2020 13:54:17 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 0/7] build: replace ninjatool with ninja
Date: Wed, 14 Oct 2020 09:54:09 -0400
Message-Id: <20201014135416.1290679-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=216.205.24.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/14 01:12:43
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
Cc: berrange@redhat.com, alex.bennee@linaro.org, peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This pull request is the last build system change for 5.2 from
me, and it is simple: similar to how we are invoking
ROM or tests/tcg "make" from the main Makefile, we now invoke ninja
to build QEMU.  Unlike those cases, however, build.ninja targets are
forwarded transparently.

The advantages cover various areas:

- maintainability: we drop scripts/ninjatool.py, which is
a large and hairy piece of code, and generally remove one
thing that can go wrong and one thing that is unique to QEMU;

- platform support: we remove the requirement for GNU make
3.82, which was annoying on Mac.  We also avoid bugs on Windows
due to meson emitting Windows rather than POSIX escapes (as
expected by Ninja) and ninjatool ignoring the difference;

- speed: invoking "configure" does not have to generate
44k lines of rules, while invoking "Make" does not anymore have
to parse 44k lines of rules.

- ease of use: Ninja tracks command lines, hence the problem
of static library changing the objects they hold goes away

Paolo

Paolo Bonzini (7):
  tests/Makefile.include: unbreak non-tcg builds
  make: run shell with pipefail
  tests: add missing generated sources to testqapi
  configure: move QEMU_INCLUDES to meson
  dockerfiles: enable Centos 8 PowerTools
  add ninja to dockerfiles, CI configurations and test VMs
  build: replace ninjatool with ninja

 .cirrus.yml                                |    6 +-
 .travis.yml                                |   13 +
 Makefile                                   |   42 +-
 configure                                  |   29 +-
 docs/devel/build-system.rst                |    6 +-
 meson.build                                |   34 +-
 scripts/mtest2make.py                      |    4 +-
 scripts/ninjatool.py                       | 1008 --------------------
 tests/Makefile.include                     |    2 +-
 tests/docker/dockerfiles/centos7.docker    |    1 +
 tests/docker/dockerfiles/centos8.docker    |    4 +
 tests/docker/dockerfiles/debian10.docker   |    1 +
 tests/docker/dockerfiles/fedora.docker     |    1 +
 tests/docker/dockerfiles/travis.docker     |    2 +-
 tests/docker/dockerfiles/ubuntu.docker     |    1 +
 tests/docker/dockerfiles/ubuntu1804.docker |    1 +
 tests/docker/dockerfiles/ubuntu2004.docker |    1 +
 tests/include/meson.build                  |    8 +-
 tests/meson.build                          |   14 +-
 tests/vm/centos                            |    2 +-
 tests/vm/centos.aarch64                    |    2 +-
 tests/vm/fedora                            |    2 +-
 tests/vm/freebsd                           |    1 +
 tests/vm/netbsd                            |    1 +
 tests/vm/openbsd                           |    1 +
 tests/vm/ubuntu.aarch64                    |    2 +-
 tests/vm/ubuntu.i386                       |    2 +-
 27 files changed, 121 insertions(+), 1070 deletions(-)
 delete mode 100755 scripts/ninjatool.py

-- 
2.26.2


