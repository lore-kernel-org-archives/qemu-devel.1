Return-Path: <SRS0=7PPA=SN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E654C10F14
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Apr 2019 12:34:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 188AB2073F
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Apr 2019 12:34:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="S0RNLLC5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 188AB2073F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:48185 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hEYud-0004VU-8z
	for qemu-devel@archiver.kernel.org; Thu, 11 Apr 2019 08:34:39 -0400
Received: from eggs.gnu.org ([209.51.188.92]:59601)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1hEYt0-0003dr-4P
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 08:32:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1hEYss-0001Sw-UZ
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 08:32:54 -0400
Received: from fanzine.igalia.com ([91.117.99.155]:54613)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <berto@igalia.com>)
	id 1hEYsr-0001Q1-EG; Thu, 11 Apr 2019 08:32:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Message-Id:Date:Subject:Cc:To:From;
	bh=HFgM74WSpnOWLb7q5Z50SO0RiAeGQrpznJX4OnkqsDI=; 
	b=S0RNLLC5yIjOSGhj11/NNObcomPwhD1bD2Da2Dmr35cbrxZ2hNoyhbz0G3p2rrPI2NZRgId0Tk0TGbzJJRs3EG3cWR7sVgdznB6cglQpTEz+UZVU/EGX5dhWF8u4+vBQBGtXK1HfiaFmAll56lZSStzFVRpALHW6DPtSRXnccaiLArrftRZ0LLuP1Yp8aO8RVjUHr/+hcROhVNA0bSK1zrWgCOF12BJ0CXVUn2+E53vy5+Vdg63I721hykeN3fP1efWZJNVBiOhVcRMel4ubUfXCGQF8L8EkAIvsCHKKlcNGNacWhG9mIhf18xwcUSgS+3sLxtMb17MnN4xW4Hxb0Q==;
Received: from 178-55-128-240.bb.dnainternet.fi ([178.55.128.240]
	helo=perseus.local) by fanzine.igalia.com with esmtpsa 
	(Cipher TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim)
	id 1hEYso-000271-L8; Thu, 11 Apr 2019 14:32:47 +0200
Received: from berto by perseus.local with local (Exim 4.89)
	(envelope-from <berto@igalia.com>)
	id 1hEYsZ-0007fF-IH; Thu, 11 Apr 2019 15:32:31 +0300
From: Alberto Garcia <berto@igalia.com>
To: qemu-devel@nongnu.org
Date: Thu, 11 Apr 2019 15:32:26 +0300
Message-Id: <cover.1554985749.git.berto@igalia.com>
X-Mailer: git-send-email 2.11.0
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x (no
	timestamps) [generic] [fuzzy]
X-Received-From: 91.117.99.155
Subject: [Qemu-devel] [PATCH for-4.1 v2 0/2] commit: Make base read-only if
 there is an early failure
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
Message-ID: <20190411123226.ShEpj9tBk-5MSuYgX07R1MdSdKuiK3_d-I_vVaA50FM@z>

Hi,

this is the same patch I posted yesterday, but with a test case.

Berto

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


