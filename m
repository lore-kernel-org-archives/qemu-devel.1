Return-Path: <SRS0=rzeH=64=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E362CC433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 19:20:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ADA6020643
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 19:20:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b="i5B+8k6u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADA6020643
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=crudebyte.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59964 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZJPS-0005OH-TX
	for qemu-devel@archiver.kernel.org; Thu, 14 May 2020 15:20:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57820)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <2cc8d6c4ae9fa8210c48c349b207dfb68cb15290@lizzy.crudebyte.com>)
 id 1jZJOg-0004Yv-2m
 for qemu-devel@nongnu.org; Thu, 14 May 2020 15:19:58 -0400
Received: from lizzy.crudebyte.com ([91.194.90.13]:35835)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <2cc8d6c4ae9fa8210c48c349b207dfb68cb15290@lizzy.crudebyte.com>)
 id 1jZJOf-0006mF-C3
 for qemu-devel@nongnu.org; Thu, 14 May 2020 15:19:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=lizzy; h=Cc:To:Subject:Date:From:Message-Id:Content-Type:
 Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Content-ID:
 Content-Description; bh=e9u88LgdXUTxkH4h+KzhZ6eqEhCccDieL1U3FIc+XEg=; b=i5B+8
 k6uJLjTpa3wvGXpUgQxRIEhOBJ6iB69rVieNqd+KUfZui8wannN+fDeSM6wDdnnh3fKGhUXMdYalw
 0JzLz02pRhaQ9DdFQGO2LiOeSNCq6OZLYMjXl5iWgi+p04EfoqPv4LE2i7lHl4bdBcfE5m5hbznvu
 D4BPNNDLk+GpmYeG0Q+NCd5KRIXuygv3n5MGkArR8oTjVvtOJ7L6m957MhYB9erE89+yVVJm9u5Gc
 vkKH3Sy9ru26H6tfdRN/gXdR6kioJJErKApNDjfd2b4yoYPOe1bg6eCW94h7bD0dC5OQELreFPza8
 ULrg7uWphfqmRDgM9/XeULCZw101w==;
Message-Id: <cover.1589481482.git.qemu_oss@crudebyte.com>
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
Date: Thu, 14 May 2020 20:38:02 +0200
Subject: [PATCH 0/1] virtio-9pfs: don't truncate response
To: qemu-devel@nongnu.org
Cc: Greg Kurz <groug@kaod.org>, Stefano Stabellini <sstabellini@kernel.org>,
 Anthony Perard <anthony.perard@citrix.com>, Paul Durrant <paul@xen.org>
Received-SPF: none client-ip=91.194.90.13;
 envelope-from=2cc8d6c4ae9fa8210c48c349b207dfb68cb15290@lizzy.crudebyte.com;
 helo=lizzy.crudebyte.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/14 14:49:51
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

The following patch reverts
SHA-1 16724a173049ac29c7b5ade741da93a0f46edff for the virtio backend.

Greg, it is intended as a quick fix for
https://bugs.launchpad.net/bugs/1877688 at least for virtio, for the
case the appropriate fix on Xen side might still take a while. Because
this bug is too serious to let it rest for too long.

In case Stefano comes up with a fix for Xen soon, you might just ignore
this patch and just revert SHA-1 16724a173049ac29c7b5ade741da93a0f46edff
entirely instead of course.

Christian Schoenebeck (1):
  virtio-9pfs: don't truncate response

 hw/9pfs/virtio-9p-device.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

-- 
2.20.1


