Return-Path: <SRS0=2Sdx=UN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85707C31E4C
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2019 10:11:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 61A8920665
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2019 10:11:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61A8920665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49834 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbjB6-0005Dz-5G
	for qemu-devel@archiver.kernel.org; Fri, 14 Jun 2019 06:11:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48514)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hbj7S-0003ZF-2E
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 06:07:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hbj7Q-0008V2-Iz
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 06:07:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51700)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>)
 id 1hbj7N-0008S5-Q8; Fri, 14 Jun 2019 06:07:33 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id E80263084213;
 Fri, 14 Jun 2019 10:07:31 +0000 (UTC)
Received: from x1w.redhat.com (unknown [10.40.205.27])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 15FA21001B0F;
 Fri, 14 Jun 2019 10:07:21 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Date: Fri, 14 Jun 2019 12:07:09 +0200
Message-Id: <20190614100718.14019-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.40]); Fri, 14 Jun 2019 10:07:32 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v2 0/9] configure: Fix softmmu --static linking
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
Cc: Fam Zheng <fam@euphon.net>, Peter Maydell <peter.maydell@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-block@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>, Bharata B Rao <bharata@linux.ibm.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Niels de Vos <ndevos@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi,

Apparently QEMU static linking is slowly bitroting. Obviously it
depends the libraries an user has installed, anyway it seems there
are not much testing done.

This series fixes few issues, enough to build QEMU on a Ubuntu
18.04 host.

Peter commented on v1:

  The main reason for supporting static linking is so we can build
  the user-mode emulators. Almost always the problems with
  static linking the softmmu binaries and the tools are
  issues with the distro's packaging of the static libraries
  (pkg-config files which specify things that don't work for
  static is a common one).

  So we could put in a lot of checking of "is what pkg-config
  tells us broken". Or we could just say "we don't support static
  linking for anything except the usermode binaries". We
  should probably phase in deprecation of that because it's
  possible somebody's using it seriously, but it seems like
  a fairly weird thing to do to me.

I share his view on this (restricting static linking to qemu-user)
but since the work was already done when I read his comment, I still
send the v2.

Since v1:
- pkg-config already use the '--static' argument, do not add it twice
- Fixed x86_64 host builds (was missing GTK and OpenGL patches)
- Added Niels R-b tag on the first patch
- The Travis-CI job now succeeds:
  https://travis-ci.org/philmd/qemu/jobs/545653697 (6 min 7 sec)

Regards,

Phil.

Philippe Mathieu-Daud=C3=A9 (9):
  configure: Only generate GLUSTERFS variables if glusterfs is usable
  configure: Link test before auto-enabling GlusterFS libraries
  configure: Link test before auto-enabling libusb library
  configure: Link test before auto-enabling libusbredir library
  configure: Link test before auto-enabling PulseAudio library
  configure: Link test before auto-enabling OpenGL libraries
  configure: Link test before auto-enabling GTK libraries
  tests/docker: Kludge for missing libunistring.so symlink on Ubuntu
    18.04
  .travis.yml: Test softmmu static linking

 .travis.yml                                |   5 +
 configure                                  | 121 ++++++++++++++++-----
 tests/docker/dockerfiles/ubuntu1804.docker |   4 +
 3 files changed, 100 insertions(+), 30 deletions(-)

--=20
2.20.1


