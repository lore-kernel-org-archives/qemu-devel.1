Return-Path: <SRS0=vd3Y=BW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DCEFC433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2020 12:48:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F06A12065C
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2020 12:48:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b="RpfJje5o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F06A12065C
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=crudebyte.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35968 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5qAq-0002fj-97
	for qemu-devel@archiver.kernel.org; Wed, 12 Aug 2020 08:48:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34996)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <da9f2eda2551c1cbd98f72730e5b754f2149a85c@lizzy.crudebyte.com>)
 id 1k5q7m-0006sQ-Nc
 for qemu-devel@nongnu.org; Wed, 12 Aug 2020 08:44:58 -0400
Received: from lizzy.crudebyte.com ([91.194.90.13]:38073)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <da9f2eda2551c1cbd98f72730e5b754f2149a85c@lizzy.crudebyte.com>)
 id 1k5q7l-0005aN-0W
 for qemu-devel@nongnu.org; Wed, 12 Aug 2020 08:44:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=lizzy; h=Cc:To:Subject:Date:From:Message-Id:Content-Type:
 Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Content-ID:
 Content-Description; bh=EdPQXeHtKqcOCfIalL50wrWd4H4Jn91T4azKgrLItYs=; b=RpfJj
 e5o6KO2G/jA/8XSHpnfbmEQ8LhHncMtJDLDo4TFTWMoB5nWNkQyQ908BbyQNYGLeZEntaqKp2aMti
 WryoZ/M/Si0h4tGBr0HFByBw/fvHT757Sy9w0Px7bzDko8u71FuhRLYCvWr42gFZLqmJwKPgVoVPS
 MzSSHAjHPUpFvnrskBn3hzVNLnkGhvMwYgniF7cGUfV2pPnGMnUK17aoT31S6eQMSbhGZqGtaktV7
 aweSdCP3qOKPQ/e6Tw3vxab0uqOCVXUZihnHv0XupOXLI8nyCZhVy3FtcDbVPDmVhmiSOBWq2itTl
 zrvJdfHe3BWu1pCoQwuf1lXc1TA/g==;
Message-Id: <cover.1597226797.git.qemu_oss@crudebyte.com>
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
Date: Wed, 12 Aug 2020 12:06:37 +0200
Subject: [PULL 0/7] 9p performance fix for 5.2 2020-08-12
To: qemu-devel@nongnu.org,
    Peter Maydell <peter.maydell@linaro.org>
Cc: Greg Kurz <groug@kaod.org>
Received-SPF: none client-ip=91.194.90.13;
 envelope-from=da9f2eda2551c1cbd98f72730e5b754f2149a85c@lizzy.crudebyte.com;
 helo=lizzy.crudebyte.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/12 08:16:56
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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

The following changes since commit d0ed6a69d399ae193959225cdeaa9382746c91cc:

  Update version for v5.1.0 release (2020-08-11 17:07:03 +0100)

are available in the Git repository at:

  https://github.com/cschoenebeck/qemu.git tags/pull-9p-20200812

for you to fetch changes up to da9f2eda2551c1cbd98f72730e5b754f2149a85c:

  9pfs: clarify latency of v9fs_co_run_in_worker() (2020-08-12 09:17:32 +0200)

----------------------------------------------------------------
9pfs: Fix severe performance issue of Treaddir requests.

----------------------------------------------------------------
Christian Schoenebeck (7):
      tests/virtio-9p: added split readdir tests
      9pfs: make v9fs_readdir_response_size() public
      9pfs: split out fs driver core of v9fs_co_readdir()
      9pfs: add new function v9fs_co_readdir_many()
      9pfs: T_readdir latency optimization
      9pfs: differentiate readdir lock between 9P2000.u vs. 9P2000.L
      9pfs: clarify latency of v9fs_co_run_in_worker()

 hw/9pfs/9p.c                 | 159 +++++++++++++++++----------------
 hw/9pfs/9p.h                 |  50 +++++++++--
 hw/9pfs/codir.c              | 203 ++++++++++++++++++++++++++++++++++++++++---
 hw/9pfs/coth.h               |  15 +++-
 tests/qtest/virtio-9p-test.c | 108 +++++++++++++++++++++++
 5 files changed, 441 insertions(+), 94 deletions(-)

