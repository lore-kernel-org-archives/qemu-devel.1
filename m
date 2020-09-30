Return-Path: <SRS0=HfOj=DH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B843C4363D
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 22:06:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D35A2206BE
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 22:06:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="FgtkE3El"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D35A2206BE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44000 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNkEa-0006mN-Lx
	for qemu-devel@archiver.kernel.org; Wed, 30 Sep 2020 18:06:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56072)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kbusch@kernel.org>)
 id 1kNkD3-0005NK-4N; Wed, 30 Sep 2020 18:04:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:50384)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kbusch@kernel.org>)
 id 1kNkD1-0007vA-5W; Wed, 30 Sep 2020 18:04:24 -0400
Received: from dhcp-10-100-145-180.wdl.wdc.com (unknown [199.255.45.60])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id AD1C820719;
 Wed, 30 Sep 2020 22:04:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1601503461;
 bh=s2wAl/3xB6v3exDiLG5O0uRXNeKF7WV4JveoQPEkHdY=;
 h=From:To:Cc:Subject:Date:From;
 b=FgtkE3ElJTj1zP7ZmhmLSzSIBnIpYDn9mVZMdQNm4gFUfUo7gOEOwzTRUd+0SPEQs
 qn61qmXw6KH+qvuCgc5IfRwxkW+e9Y+Unw3QZIAk8zlDCMDlz0rQx4V/vTtDR7IXLt
 xQK39v/ts1HGJXLJUIfQplDymkVthgvYIxMeQ5bk=
From: Keith Busch <kbusch@kernel.org>
To: qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Klaus Jensen <k.jensen@samsung.com>
Subject: [PATCH 0/9] nvme qemu cleanups and fixes
Date: Wed, 30 Sep 2020 15:04:05 -0700
Message-Id: <20200930220414.562527-1-kbusch@kernel.org>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.145.29.99; envelope-from=kbusch@kernel.org;
 helo=mail.kernel.org
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/30 18:04:21
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -75
X-Spam_score: -7.6
X-Spam_bar: -------
X-Spam_report: (-7.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.469,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_HI=-5, SPF_HELO_NONE=0.001,
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
Cc: Dmitry Fomichev <dmitry.fomichev@wdc.com>,
 Niklas Cassel <Niklas.Cassel@wdc.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Keith Busch <kbusch@kernel.org>, Kevin Wolf <kwolf@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

After going through the zns enabling, I notice the controller enabling
is not correct. Then I just continued maked more stuff. The series, I
think, contains some of the less controversial patches from the two
conflicting zns series, preceeded by some cleanups and fixes from me.

If this is all fine, I took the liberty of porting the zns enabling to
it and made a public branch for consideration here:

 http://git.infradead.org/qemu-nvme.git/shortlog/refs/heads/kb-zns 

Dmitry Fomichev (1):
  hw/block/nvme: report actual LBA data shift in LBAF

Keith Busch (5):
  hw/block/nvme: remove pointless rw indirection
  hw/block/nvme: fix log page offset check
  hw/block/nvme: support per-namespace smart log
  hw/block/nvme: validate command set selected
  hw/block/nvme: support for admin-only command set

Klaus Jensen (3):
  hw/block/nvme: reject io commands if only admin command set selected
  hw/block/nvme: add nsid to get/setfeat trace events
  hw/block/nvme: add trace event for requests with non-zero status code

 hw/block/nvme-ns.c    |   5 ++
 hw/block/nvme.c       | 194 ++++++++++++++++++++----------------------
 hw/block/trace-events |   6 +-
 include/block/nvme.h  |  11 +++
 4 files changed, 114 insertions(+), 102 deletions(-)

-- 
2.24.1


