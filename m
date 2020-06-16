Return-Path: <SRS0=f7ls=75=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C73ACC433E3
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 16:10:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9CA76208B3
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 16:10:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b="j9e5myq6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CA76208B3
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=crudebyte.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60634 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlEAi-0005Jo-U2
	for qemu-devel@archiver.kernel.org; Tue, 16 Jun 2020 12:10:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57218)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1jlE9K-0003m1-0A; Tue, 16 Jun 2020 12:09:22 -0400
Received: from lizzy.crudebyte.com ([91.194.90.13]:57855)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1jlE9H-0004m4-KA; Tue, 16 Jun 2020 12:09:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=lizzy; h=Content-Type:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
 Content-ID:Content-Description;
 bh=8Rk9Uo2xN9yWmXLDN78khPtPXmhGX2X1/96JRmm4vhg=; b=j9e5myq6WZJy38fA88ExitP2aV
 SOvi9SPab6W58quEfE0t9kFGWgQ/xw1lfAe8GQU/5REUaXY34hU7yGeqedEo+OG0LoQ53USs2peg+
 P0R2RccMm8mFeAV9Ucw1s6WrHuKh2dMMG0L3dofOoA8tmWC6YhdD+xc5q2PyRxVQ5Ro92TOXwRmpn
 hKiiM+NNKCSrzzCOaHBZ/5/R11EQHasveSny6DYM5U1OHLj6Y2GfhZPtZmeXK9/77W295Vwta8Pv9
 s1/zZrsQvE5qMEq4Zj8ELxqFdC/PBKNk6k5x2f5L1cea18PaQMHzDVFV2pqaqXn6p1T5Qia6wjEql
 W24oDb2g==;
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
To: qemu-devel@nongnu.org
Cc: Greg Kurz <groug@kaod.org>, Michael Roth <mdroth@linux.vnet.ibm.com>,
 qemu-stable@nongnu.org
Subject: Re: [PATCH 72/78] 9p: Lock directory streams with a CoMutex
Date: Tue, 16 Jun 2020 18:09:04 +0200
Message-ID: <2182702.l5DGtSyN0k@silver>
In-Reply-To: <20200616171440.172f1173@bahia.lan>
References: <20200616141547.24664-1-mdroth@linux.vnet.ibm.com>
 <20200616141547.24664-73-mdroth@linux.vnet.ibm.com>
 <20200616171440.172f1173@bahia.lan>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Received-SPF: pass client-ip=91.194.90.13; envelope-from=qemu_oss@crudebyte.com;
 helo=lizzy.crudebyte.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/16 12:09:10
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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

On Dienstag, 16. Juni 2020 17:14:40 CEST Greg Kurz wrote:
> Cc'ing co-maintainer Christian Schoenebeck.
> 
> Christian,
> 
> If there are some more commits you think are worth being cherry picked
> for QEMU 4.2.1, please inform Michael before freeze on 2020-06-22.

Indeed, for that particular stable branch I would see the following 9p fixes
as additional candidates (chronologically top down):

841b8d099c [trivial] 9pfs: local: Fix possible memory leak in local_link()
846cf408a4 [maybe] 9p: local: always return -1 on error in local_unlinkat_common
9580d60e66 [maybe] virtio-9p-device: fix memleak in virtio_9p_device_unrealize
659f195328 [trivial] 9p/proxy: Fix export_flags
a5804fcf7b [maybe] 9pfs: local: ignore O_NOATIME if we don't have permissions
03556ea920 [trivial] 9pfs: include linux/limits.h for XATTR_SIZE_MAX
a4c4d46272 [recommended] xen/9pfs: yield when there isn't enough room on the ring

What do you think Greg?

What's the recommended way for me to keep track of imminent stable picks/
freezes in future?

Best regards,
Christian Schoenebeck



