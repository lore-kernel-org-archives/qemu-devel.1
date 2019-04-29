Return-Path: <SRS0=sEuR=S7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34B8BC43219
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2019 13:53:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F1E6820652
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2019 13:53:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="YQOBI8uF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1E6820652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:57930 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hL6ig-0005xw-7R
	for qemu-devel@archiver.kernel.org; Mon, 29 Apr 2019 09:53:22 -0400
Received: from eggs.gnu.org ([209.51.188.92]:36254)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1hL6h9-0004zj-TM
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 09:51:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1hL6h8-0007tL-U3
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 09:51:47 -0400
Received: from fanzine.igalia.com ([91.117.99.155]:44142)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <berto@igalia.com>)
	id 1hL6h8-0007jI-Bb; Mon, 29 Apr 2019 09:51:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Message-Id:Date:Subject:Cc:To:From;
	bh=V6V+6gs479Lpx/sIYxF6V6eoMUt9qNSGtB44q3GL2jc=; 
	b=YQOBI8uF/xsCAJjmm598BY1hPP+gxP+JQ3Lh4DT0bH+xnzh37fdN6Ze1l/LyjELtoVfzDFJyDq5M4/UNvrlgHCIZdw+ckG3MC5tTHJ7SoUzK0XZSY2pHoc5HtyeWCvqw61Ww10IP4WBp4bxndzZXhz+l0LvKvqrgxsz+a7vDFmIzNWKo1rz8TqD97H+kNVb7QAgt1cH1Ry8+siwPXI2+Gj7UELq1L+oJ00BDRbwgbVk1hjxTS2co206I61IQ55+QE+M3ZcZsR6+/JYloF0fVCC4IXDP8lAGhWar6YztaNDw1jFXcuTP5buaNxzEsMhxC/Qa9xR7mMxq6uU4m5+R2FA==;
Received: from [212.145.226.66] (helo=perseus.local)
	by fanzine.igalia.com with esmtpsa 
	(Cipher TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim)
	id 1hL6gq-0006BZ-SU; Mon, 29 Apr 2019 15:51:28 +0200
Received: from berto by perseus.local with local (Exim 4.89)
	(envelope-from <berto@igalia.com>)
	id 1hL6gd-0007Kh-9b; Mon, 29 Apr 2019 16:51:15 +0300
From: Alberto Garcia <berto@igalia.com>
To: qemu-devel@nongnu.org
Date: Mon, 29 Apr 2019 15:51:07 +0200
Message-Id: <cover.1556540297.git.berto@igalia.com>
X-Mailer: git-send-email 2.11.0
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x (no
	timestamps) [generic] [fuzzy]
X-Received-From: 91.117.99.155
Subject: [Qemu-devel] [PATCH v3 0/2] commit: Make base read-only if there is
 an early failure
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Kevin Wolf <kwolf@redhat.com>, Alberto Garcia <berto@igalia.com>,
	qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190429135107.XtSg7r6g5JpzotLePcNSKV3hM19DdGe8Q44Qpx8TZVw@z>

Hi,

Here's v3 of this series, the only changes are the corrections in the
iotest suggested by Max.

Regards,

Berto

v3:
- Patch 2: Use $() instead of backquotes, remove 'here' variable and
  don't use 'sleep' when waiting for block-commit to finish [Max]

v2: https://lists.gnu.org/archive/html/qemu-block/2019-04/msg00334.html
- Patch 2: Added test case

v1: https://lists.gnu.org/archive/html/qemu-block/2019-04/msg00281.html

Output of backport-diff against v2:

Key:
[----] : patches are identical
[####] : number of functional differences between upstream/downstream patch
[down] : patch is downstream-only
The flags [FC] indicate (F)unctional and (C)ontextual differences, respectively

Alberto Garcia (2):
  commit: Make base read-only if there is an early failure
  iotests: Check that images are in read-only mode after block-commit

 block/commit.c             |   3 ++
 tests/qemu-iotests/249     | 115 +++++++++++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/249.out |  35 ++++++++++++++
 tests/qemu-iotests/group   |   1 +
 4 files changed, 154 insertions(+)
 create mode 100755 tests/qemu-iotests/249
 create mode 100644 tests/qemu-iotests/249.out

-- 
2.11.0


