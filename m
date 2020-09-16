Return-Path: <SRS0=+YCa=CZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F7F1C43461
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 11:52:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3BC8C22208
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 11:52:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JLp5Aad+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BC8C22208
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45186 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIVzI-00053P-7V
	for qemu-devel@archiver.kernel.org; Wed, 16 Sep 2020 07:52:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54092)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kIVuY-0006Wn-Qq
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 07:47:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:50278)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kIVuW-00085i-QN
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 07:47:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600256859;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=aCGoLUB/3C+UKaOM/2a/E5qmcsroF3zxNVaOeTyeKbI=;
 b=JLp5Aad+IV3DQ4gb3uNK5tdlVHvbYIi3wMgDkRYuMzMCUldLSpaY73E/IwFF8TwMU+38FW
 RmP803qyITjbgBZMbs2+m02eTHXb8pfBae+tK7HagqglfY8vFPzPGzOkF3kH92scvBHtad
 Y7p+vGsVCoGYqhQL2ANUQOLzs71jekM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-188-mfU0nl-6POeNsiWHd5P1Pg-1; Wed, 16 Sep 2020 07:47:36 -0400
X-MC-Unique: mfU0nl-6POeNsiWHd5P1Pg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3FCED186DD25;
 Wed, 16 Sep 2020 11:47:35 +0000 (UTC)
Received: from thuth.com (ovpn-113-19.ams2.redhat.com [10.36.113.19])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 110AD5DA71;
 Wed, 16 Sep 2020 11:47:33 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 00/24] qtests, unit tests and Cirrus-CI fixes / improvements
Date: Wed, 16 Sep 2020 13:47:07 +0200
Message-Id: <20200916114731.102080-1-thuth@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=thuth@redhat.com
X-Mimecast-Spam-Score: 0.003
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/16 02:35:56
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.999,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Yonggang Luo <luoyonggang@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

 Hi Peter,

the following changes since commit de39a045bd8d2b49e4f3d07976622c29d58e0bac:

  Merge remote-tracking branch 'remotes/kraxel/tags/vga-20200915-pull-request' into staging (2020-09-15 14:25:05 +0100)

are available in the Git repository at:

  https://gitlab.com/huth/qemu.git tags/pull-request-2020-09-16

for you to fetch changes up to 114daec31d64600e5a070abcdb8de2cf74d01e94:

  cirrus: Building freebsd in a single shot (2020-09-16 12:15:07 +0200)

----------------------------------------------------------------
* Fix "readlink -f" problem in iotests on macOS (to fix the Cirrus-CI tests)
* Some minor qtest improvements
* Fix the unit tests to work on MSYS2, too
* Enable building and testing on MSYS2 in the Cirrus-CI
* Build FreeBSD with one task again in the Cirrus-CI
----------------------------------------------------------------

Alexander Bulekov (1):
      fuzz: Change the way we write qtest log to stderr

Max Reitz (1):
      iotests: Drop readlink -f

Maxim Levitsky (1):
      rcu: Implement drain_call_rcu

Thomas Huth (4):
      tests/qtest/qmp-cmd-test: Use inclusive language
      tests/socket-helpers: Treat EAI_NONAME as EADDRNOTAVAIL
      Simplify the .gitignore file
      qga/commands-win32: Fix problem with redundant protype declaration

Yonggang Luo (17):
      tests: Convert g_free to g_autofree macro in test-logging.c
      rcu: fixes test-logging.c by call drain_call_rcu before rmdir_full
      meson: Disable test-char on msys2/mingw for fixing tests stuck
      meson: disable crypto tests are empty under win32
      tests: Fixes test-replication.c on msys2/mingw.
      tests: test-replication disable /replication/secondary/* on msys2/mingw.
      osdep: file locking functions are not available on Win32
      meson: Use -b to ignore CR vs. CR-LF issues on Windows
      meson: remove empty else and duplicated gio deps
      vmstate: Fixes test-vmstate.c on msys2/mingw
      tests: Fixes test-io-channel-socket.c tests under msys2/mingw
      tests: fixes aio-win32 about aio_remove_fd_handler, get it consistence with aio-posix.c
      tests: Fixes test-io-channel-file by mask only owner file state mask bits
      tests: fix test-util-sockets.c
      tests: Fixes test-qdev-global-props.c
      ci: Enable msys2 ci in cirrus
      cirrus: Building freebsd in a single shot

 .cirrus.yml                    |  98 ++++++++++++++++++--------
 .gitignore                     | 152 -----------------------------------------
 include/qemu/osdep.h           |   2 +-
 include/qemu/rcu.h             |   1 +
 meson.build                    |   6 --
 qga/commands-win32.c           |   5 +-
 tests/meson.build              |  10 ++-
 tests/qapi-schema/meson.build  |   2 +-
 tests/qemu-iotests/check       |   2 +-
 tests/qtest/fuzz/fuzz.c        |   5 +-
 tests/qtest/qmp-cmd-test.c     |  10 +--
 tests/socket-helpers.c         |   3 +-
 tests/test-io-channel-file.c   |  12 +++-
 tests/test-io-channel-socket.c |   2 +
 tests/test-logging.c           |   5 +-
 tests/test-qdev-global-props.c |   9 ++-
 tests/test-replication.c       |  22 ++++--
 tests/test-util-sockets.c      |   6 +-
 tests/test-vmstate.c           |   3 +-
 util/aio-win32.c               |  12 +++-
 util/rcu.c                     |  55 +++++++++++++++
 21 files changed, 207 insertions(+), 215 deletions(-)


