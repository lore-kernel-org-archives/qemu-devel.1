Return-Path: <SRS0=4Hnu=AF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 202C8C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 08:14:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E00CE20738
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 08:14:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Bk7/dk87"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E00CE20738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46280 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jo0YY-0004iq-4f
	for qemu-devel@archiver.kernel.org; Wed, 24 Jun 2020 04:14:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42158)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jo0Xe-0003MX-U3
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 04:13:58 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:58607
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jo0Xd-0004oU-8y
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 04:13:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592986436;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=QHWb0wN3WQXQM3FyetgX4l+fgCBkZJR6FaWXU32SuN0=;
 b=Bk7/dk8705A0xttohW30mywcKmfC4SE3kg56W6NXHRW0p5FuOScfRREPZhQjScTzP6IlOG
 HSsWXSktwpIluWTuoRfN0V/2vS0/IZofxTMbJVRNCNu8HgNHAXwx2tKFf7qnvlbjFPBja+
 FwyF5a6aKD0/gCKSYn1EaOc0xmRC590=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-221-P2oajm2gPSu65GYX3A-gZw-1; Wed, 24 Jun 2020 04:13:52 -0400
X-MC-Unique: P2oajm2gPSu65GYX3A-gZw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8D55180401A;
 Wed, 24 Jun 2020 08:13:51 +0000 (UTC)
Received: from localhost (ovpn-113-239.ams2.redhat.com [10.36.113.239])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2F8297C375;
 Wed, 24 Jun 2020 08:13:51 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL v2 0/2] Block patches
Date: Wed, 24 Jun 2020 10:13:47 +0200
Message-Id: <20200624081349.121791-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=mreitz@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/24 01:59:40
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit d88d5a3806d78dcfca648c62dae9d88d3e803bd2:

  Merge remote-tracking branch 'remotes/philmd-gitlab/tags/renesas-hw-20200622' into staging (2020-06-23 13:55:52 +0100)

are available in the Git repository at:

  https://github.com/XanClic/qemu.git tags/pull-block-2020-06-24

for you to fetch changes up to 24b861c0386a17ea31eb824310c21118fb7be883:

  iotests: don't test qcow2.py inside 291 (2020-06-24 10:00:04 +0200)

----------------------------------------------------------------
Block patches:
- Two iotest fixes

----------------------------------------------------------------
This is v2, where I dropped Maxim’s LUKS keyslot amendment series and my
iotest patches, because both caused iotest failures on some test
machines.
----------------------------------------------------------------
Philippe Mathieu-Daudé (1):
  iotests: Fix 051 output after qdev_init_nofail() removal

Vladimir Sementsov-Ogievskiy (1):
  iotests: don't test qcow2.py inside 291

 tests/qemu-iotests/051.pc.out |  4 ++--
 tests/qemu-iotests/291        |  4 ----
 tests/qemu-iotests/291.out    | 33 ---------------------------------
 3 files changed, 2 insertions(+), 39 deletions(-)

-- 
2.26.2


