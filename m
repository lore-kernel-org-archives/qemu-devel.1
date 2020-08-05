Return-Path: <SRS0=Uy1J=BP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3ACEC433E1
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2020 09:59:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C33C32076E
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2020 09:59:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ql5TG0mv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C33C32076E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60266 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3GCf-0002iD-2g
	for qemu-devel@archiver.kernel.org; Wed, 05 Aug 2020 05:59:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36742)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1k3GBV-00019m-JA
 for qemu-devel@nongnu.org; Wed, 05 Aug 2020 05:58:09 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:54952
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1k3GBS-0008St-7A
 for qemu-devel@nongnu.org; Wed, 05 Aug 2020 05:58:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596621484;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Fc569LUqMn8GM7EcFsQCJVWEf24o3nz4h4YQ0E7RVws=;
 b=Ql5TG0mvLElmWokKcDwDaDOvr4aK4zDzS42zacgLXnbzfPvplKmmaSsosYoxboCDGWg8wr
 c0ejdrMrdh8FkVeZWViIdzxcdMVBuxoiFU4S4UTynwwHThLaJElbmH5kO0qJE5G/jnIzI4
 vAOcX6Z5lvfahghd2wwloGp+/JHcids=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-39-Iut4aMXwMcuPJ3BQjv_YaQ-1; Wed, 05 Aug 2020 05:58:00 -0400
X-MC-Unique: Iut4aMXwMcuPJ3BQjv_YaQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7D87D1009639;
 Wed,  5 Aug 2020 09:57:59 +0000 (UTC)
Received: from thuth.com (ovpn-112-142.ams2.redhat.com [10.36.112.142])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B15802DE77;
 Wed,  5 Aug 2020 09:57:57 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 0/6] Improve gitlab-CI and fix a compiler warning
Date: Wed,  5 Aug 2020 11:57:49 +0200
Message-Id: <20200805095755.16414-1-thuth@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=thuth@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=thuth@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/05 01:46:02
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
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

 Hi Peter,

the following changes since commit fd3cd581f9dcd11286daacaa5272e721c65aece8:

  Merge remote-tracking branch 'remotes/pmaydell/tags/pull-target-arm-20200804' into staging (2020-08-04 18:20:32 +0100)

are available in the Git repository at:

  https://gitlab.com/huth/qemu.git tags/pull-request-2020-08-05

for you to fetch changes up to d2a71d7474d4649eabe554994a3fcba75244cce3:

  Get rid of the libqemustub.a remainders (2020-08-05 11:45:43 +0200)

(I know it's late in the 5.1 cycle, feel free to ignore this if it's
too much for 5.1)

----------------------------------------------------------------
* Test rx-softmmu, avr-softmmu, Centos7 and Debian on gitlab-CI
* Fix compiler warning on 32-bit big endian systems
* Remove remainders of libqemustub.a
----------------------------------------------------------------

Thomas Huth (6):
      tests/docker: Add python3-venv and netcat to the debian-amd64 container
      tests/acceptance: Disable the rx sash and arm cubieboard replay test on Gitlab
      gitlab-ci.yml: Add build-system-debian and build-system-centos jobs
      gitlab-ci: Fix Avocado cache usage
      target/riscv/vector_helper: Fix build on 32-bit big endian hosts
      Get rid of the libqemustub.a remainders

 .gitlab-ci.yml                               | 109 ++++++++++++++++++++++-----
 Makefile                                     |   2 +-
 scripts/coverity-scan/run-coverity-scan      |   3 -
 target/riscv/vector_helper.c                 |   4 +-
 tests/acceptance/machine_rx_gdbsim.py        |   4 +
 tests/acceptance/replay_kernel.py            |   1 +
 tests/docker/dockerfiles/debian-amd64.docker |   4 +-
 tests/test-util-sockets.c                    |   3 +-
 8 files changed, 103 insertions(+), 27 deletions(-)


