Return-Path: <SRS0=bySr=YS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 127A1CA9EA0
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 19:42:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF81021D71
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 19:42:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DmOc/wqx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF81021D71
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35552 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iO5TE-0000Oo-He
	for qemu-devel@archiver.kernel.org; Fri, 25 Oct 2019 15:42:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57702)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iO5Oc-0007xV-CA
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 15:37:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iO5Oa-00034B-Oo
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 15:37:13 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e]:39389)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iO5Oa-00033e-Ht
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 15:37:12 -0400
Received: by mail-wm1-x32e.google.com with SMTP id r141so3157082wme.4
 for <qemu-devel@nongnu.org>; Fri, 25 Oct 2019 12:37:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=sTOfEhzF4CkD36tK1j3vVGGUpu8OV4pb02B9crA6v3g=;
 b=DmOc/wqxTidZARjHsCSXPQYTtO5Sz8R9gHgOxdrqQtRBnvus8QLS73fpeyBLNaU6Ea
 u01nsGOLFjpT8UjVjDEGKup3zoKMy129jJNNQLqC1+IgmTF0POHxhiivlbQJsyGFuLv0
 mRG5Izr/285PSNU/SRtKINGL0s4NbyULbjXSUAm7s6nqZC6lxScYtum1nyR1wOZCHqYx
 rRA/onmN+vMSzE5QdvRTE7ofY60E397S6fs8pcJp6afwqZiOtEecao9I773fiKLhrSZ0
 AMaKJ4yIX5481QN4IZXP3o+Ye2fe2KXrFZig52wSOKdiOji3IEADQOS042LcHrzHM9sD
 y13A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=sTOfEhzF4CkD36tK1j3vVGGUpu8OV4pb02B9crA6v3g=;
 b=M5WWp/E1qADm3d+zRV90Cce0S+3uisEJ9YJMxY68rcCyz0rL3+wBZECrgDA3jscKNg
 GvgOktkcGAubpd2XNV8ErZQQJvzJh10BSBDHCwswg0L13YXW+Cgwt9Z7YTBE9AmVe0Yu
 Eny4jBfaHnLF4V9nauidpIBRcBdoMO/9Ur/DXxNPvdsDFGXAY5hYNCrikhYvL6TJI6RW
 W7SJ8RA3yMljS5PLMrVvvoNeOOq/d4/SlI7/LDmLoa8EjLcXZHYRIrKpeHMBBKmhCVzm
 cS91vYz8VKDKjoYZHYFUJNIRAXefSJ3fUA2pFgZtI8dRYliXftE0jUsXJtBsOqToFZyt
 nvyA==
X-Gm-Message-State: APjAAAXrqljM0h+GHSM8nVvleBie3j7D7Znd8dOJAcHBKTb5MSVmCtBr
 448foA3+d5aNCrn30p//dG2RLQ==
X-Google-Smtp-Source: APXvYqz58J8BvfbjDYuK/0LMSfC34OF1lA0dvQYle/EhlIYpwUGFkly9bePOaqsickD+KZDKNn3kRA==
X-Received: by 2002:a7b:cb42:: with SMTP id v2mr4759507wmj.165.1572032230822; 
 Fri, 25 Oct 2019 12:37:10 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id g184sm4406471wma.8.2019.10.25.12.37.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Oct 2019 12:37:10 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 7B4C61FF87;
 Fri, 25 Oct 2019 20:37:09 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL v3 00/15] testing updates
Date: Fri, 25 Oct 2019 20:36:54 +0100
Message-Id: <20191025193709.28783-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32e
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
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit 03bf012e523ecdf047ac56b2057950247256064d:

  Merge remote-tracking branch 'remotes/kevin/tags/for-upstream' into staging (2019-10-25 14:59:53 +0100)

are available in the Git repository at:

  https://github.com/stsquad/qemu.git tags/pull-testing-next-251019-3

for you to fetch changes up to 8ce2f68fc90e36d8cd57585f7f4bc75e5038f0b1:

  tests/docker: update Travis image to a more current version (2019-10-25 19:24:21 +0100)

----------------------------------------------------------------
Testing updates (split from mega PR)

  - various Travis dependency updates
  - enable tcg debug for check-tcg
  - additional Xcode build for Cirrus
  - dependency tweak for gitlab

----------------------------------------------------------------
Alex Bennée (7):
      travis.yml: reduce scope of the --enable-debug build
      travis.yml: bump Xcode 10 to latest dot release
      cirrus.yml: add latest Xcode build target
      travis.yml: cache the clang sanitizer build
      travis.yml: --enable-debug-tcg to check-tcg
      tests/docker: set HOST_ARCH if we don't have ARCH
      tests/docker: update Travis image to a more current version

Eduardo Habkost (2):
      tests/vm: Let subclasses disable IPv6
      tests/vm/netbsd: Disable IPv6

Philippe Mathieu-Daudé (1):
      travis.yml: Test the release tarball

Thomas Huth (5):
      travis.yml: Add libvdeplug-dev to compile-test net/vde.c
      travis.yml: Use libsdl2 instead of libsdl1.2, and install libsdl2-image
      travis.yml: Use newer version of libgnutls and libpng
      travis.yml: Fix the ccache lines
      gitlab-ci.yml: Use libvdeplug-dev to compile-test the VDE network backend

 .cirrus.yml                            | 11 ++++++++
 .gitlab-ci.yml                         |  2 +-
 .shippable.yml                         |  2 --
 .travis.yml                            | 50 ++++++++++++++++++++++++++--------
 tests/docker/Makefile.include          |  6 ++--
 tests/docker/dockerfiles/travis.docker |  6 +++-
 tests/vm/basevm.py                     |  5 +++-
 tests/vm/netbsd                        |  7 +++++
 8 files changed, 71 insertions(+), 18 deletions(-)

-- 
2.20.1


