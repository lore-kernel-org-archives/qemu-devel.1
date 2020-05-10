Return-Path: <SRS0=vfNf=6Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBBB4C38A2A
	for <qemu-devel@archiver.kernel.org>; Sun, 10 May 2020 18:31:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9CDBD2080C
	for <qemu-devel@archiver.kernel.org>; Sun, 10 May 2020 18:31:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b="QUOAoj53"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CDBD2080C
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=crudebyte.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51320 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jXqjQ-0007vz-Sb
	for qemu-devel@archiver.kernel.org; Sun, 10 May 2020 14:31:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44928)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <54f3b9c9f05a77ccdd6103bd46c828fcb675cbac@lizzy.crudebyte.com>)
 id 1jXqii-0007Pb-IR
 for qemu-devel@nongnu.org; Sun, 10 May 2020 14:30:36 -0400
Received: from lizzy.crudebyte.com ([91.194.90.13]:37277)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <54f3b9c9f05a77ccdd6103bd46c828fcb675cbac@lizzy.crudebyte.com>)
 id 1jXqih-0005Tq-JG
 for qemu-devel@nongnu.org; Sun, 10 May 2020 14:30:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=lizzy; h=Cc:To:Subject:Date:From:Message-Id:Content-Type:
 Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Content-ID:
 Content-Description; bh=UebelJDT2xscJ0xutgOC5nXDYSZbB+bu9nsRtWdbs/I=; b=QUOAo
 j53ocmHyEwKDudQWtQ+Fee2f9VIN5LcmPHMpe369jidBQYaPv4Xg4mDpG3wQgEtKjtNc5zwtCPTob
 //cn0FTogD2QT6i9uuIH80LeAggUPP+6pBqcfqHzlwAXbcgnno5NwBW2Cy0ubgPgI1uRJejCdxNUY
 e7dmJNEP1acML8RE5KxHMG+tqIMmN45dFnz3ru6DBpIV8yQwe1s0Kvnn89uAfL2C5jCLYoKpTeUUC
 blGOC7P9/xvMnROQYE+5ZZm9TK8ienGGPwqW/PuiWeJztGTad/EsyEKzy3f7hSiRps8xz2jSQTo4z
 SkxaR2xc91I5bk1U4F8oz2Yq4gYRg==;
Message-Id: <cover.1589132512.git.qemu_oss@crudebyte.com>
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
Date: Sun, 10 May 2020 19:41:52 +0200
Subject: [PATCH 0/2] 9pfs: regression init_in_iov_from_pdu truncating size
To: qemu-devel@nongnu.org
Cc: Greg Kurz <groug@kaod.org>, Stefano Stabellini <sstabellini@kernel.org>,
 Anthony Perard <anthony.perard@citrix.com>, Paul Durrant <paul@xen.org>
Received-SPF: none client-ip=91.194.90.13;
 envelope-from=54f3b9c9f05a77ccdd6103bd46c828fcb675cbac@lizzy.crudebyte.com;
 helo=lizzy.crudebyte.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/10 14:00:36
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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

Stefano, looks like your original patch needs some more fine tuning:

https://bugs.launchpad.net/bugs/1877688

Please check if the assumptions I made about Xen are correct, and please
also test whether these changes still work for you with Xen as intended by
you.

Christian Schoenebeck (2):
  xen-9pfs: Fix log messages of reply errors
  9pfs: fix init_in_iov_from_pdu truncating size

 hw/9pfs/virtio-9p-device.c | 35 ++++++++++++++++++++++++--------
 hw/9pfs/xen-9p-backend.c   | 41 ++++++++++++++++++++++++++++----------
 2 files changed, 58 insertions(+), 18 deletions(-)

-- 
2.20.1


