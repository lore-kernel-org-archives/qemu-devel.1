Return-Path: <SRS0=clLO=73=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5949DC433E0
	for <qemu-devel@archiver.kernel.org>; Sun, 14 Jun 2020 04:43:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2789520747
	for <qemu-devel@archiver.kernel.org>; Sun, 14 Jun 2020 04:43:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=hostfission.com header.i=@hostfission.com header.b="owXNvoTL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2789520747
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=hostfission.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41874 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jkKUe-0006Tn-Ci
	for qemu-devel@archiver.kernel.org; Sun, 14 Jun 2020 00:43:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35872)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <root@moya.office.hostfission.com>)
 id 1jkKTe-0004jv-CH
 for qemu-devel@nongnu.org; Sun, 14 Jun 2020 00:42:38 -0400
Received: from mail1.hostfission.com ([139.99.139.48]:57370)
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <root@moya.office.hostfission.com>)
 id 1jkKTa-0005Ar-OI
 for qemu-devel@nongnu.org; Sun, 14 Jun 2020 00:42:38 -0400
Received: from moya.office.hostfission.com (office.hostfission.com
 [220.233.29.71])
 by mail1.hostfission.com (Postfix) with ESMTP id F0390445B1;
 Sat, 13 Jun 2020 14:05:55 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=hostfission.com;
 s=mail; t=1592021156;
 bh=PPeacZfz0/H7c3zbFUwy7ib18/dqZAjQwotikYVk6OU=;
 h=From:To:Cc:Subject:Date:From;
 b=owXNvoTLgtgD0VSMZobwq8jk+O0FVpPyQMMx8T0g1u9P9bu0g/yUv/tXiy9jescZb
 9b//79crxZw9n/Gzv5rnE293s/ZbK6ee6F/QHpi/2hGN1ZWuw2ZCyWc1+JHanVqzLr
 yyEsa6FT8eToXV8h6na2a4YetLPRdygfre/N14rg=
Received: by moya.office.hostfission.com (Postfix, from userid 0)
 id C22723A01AD; Sat, 13 Jun 2020 14:05:55 +1000 (AEST)
From: Geoffrey McRae <geoff@hostfission.com>
To: qemu-devel@nongnu.org
Cc: kraxel@redhat.com,
	geoff@hostfission.com
Subject: [PATCH 0/6] audio/jack: fixes to overall jack behaviour
Date: Sat, 13 Jun 2020 14:05:12 +1000
Message-Id: <20200613040518.38172-1-geoff@hostfission.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=139.99.139.48;
 envelope-from=root@moya.office.hostfission.com; helo=mail1.hostfission.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/13 00:05:57
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=_AUTOLEARN
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

This patch set addresses several issues that cause inconsistent
behaviour in the guest when the sound device is stopped and started or
the JACK server stops responding on the host.

Geoffrey McRae (6):
  audio/jack: fix invalid minimum buffer size check
  audio/jack: remove unused stopped state
  audio/jack: remove invalid set of input support bool
  audio/jack: do not remove ports when finishing
  audio/jack: honour the enable state of the audio device
  audio/jack: simplify the re-init code path

 audio/jackaudio.c | 73 ++++++++++++++++++++++++-----------------------
 1 file changed, 38 insertions(+), 35 deletions(-)

-- 
2.20.1


