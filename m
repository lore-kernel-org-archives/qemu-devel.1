Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 395D1C433E9
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 15:32:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ECD312072A
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 15:32:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b="O0bAtapV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECD312072A
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=crudebyte.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47840 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDrDn-00076Z-43
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 11:32:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51570)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <e6fc84845c95816ad5baecb0abd6bfefdcf7ec9f@lizzy.crudebyte.com>)
 id 1kDrA4-0002qG-4U
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 11:28:28 -0400
Received: from lizzy.crudebyte.com ([91.194.90.13]:35115)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <e6fc84845c95816ad5baecb0abd6bfefdcf7ec9f@lizzy.crudebyte.com>)
 id 1kDrA0-0000IS-5F
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 11:28:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=lizzy; h=Cc:To:Subject:Date:From:Message-Id:Content-Type:
 Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Content-ID:
 Content-Description; bh=vx57K1wc1xGgy2DPCY1ae4OjWB0mT7ARSVHxC8srhNw=; b=O0bAt
 apVgueAPF15GraKOimjiujYBJkVw/m3iDf925Kf1m5NPrrEgICibLeryKbkqvjKKfm+aTmlvTtXji
 7wo5j/tAPDefNNKBOOXq0l9Wo51c3pNqhJ+czUEkopiXhPWh0b4Nk+FAV9fnYzMpRHkpd+vnGUOmE
 5rBPo+liQs9gFxTOxstASTZg5yA/SWdyS7r78qRIi3bqNwtm5sMGHWi+aNRw0mBm5T16Sx29Gv3Co
 21yqSQ7RLVIVFUbUrqM4Pxjp6Xbvj6dI2WkgIo7eaoqnnw6vvYNGjKIzuQgTYBfdmtSiTBKGYDWUq
 Ml8mV+Wb78FMKvipchQB8OB7I592Q==;
Message-Id: <cover.1599144062.git.qemu_oss@crudebyte.com>
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
Date: Thu, 3 Sep 2020 16:41:02 +0200
Subject: [PATCH v2 0/1] 9pfs: log warning if msize <= 8192
To: qemu-devel@nongnu.org
Cc: Greg Kurz <groug@kaod.org>
Cc: berrange@redhat.com
Received-SPF: none client-ip=91.194.90.13;
 envelope-from=e6fc84845c95816ad5baecb0abd6bfefdcf7ec9f@lizzy.crudebyte.com;
 helo=lizzy.crudebyte.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/03 10:59:11
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

I have updated the QEMU 9P setup wiki page about this 'msize' issue. For
some reason the dedicated anchor 'msize' does not work though:

https://wiki.qemu.org/Documentation/9psetup#msize

Not sure whether that's a wiki installation problem? When I view the wiki
source, it looks like it is showing some errors there.

v1->v2:

  * Updated commit log message to make it more clear why the client cannot
    auto pick a good value for 'msize'.

  * Added a web link to the log message, pointing to the appropriate QEMU
    wiki page which explains the 'msize' issue in detail.

Message-ID of previous version (v1):
  E1kDR8W-0001s4-Sr@lizzy.crudebyte.com

Christian Schoenebeck (1):
  9pfs: log warning if msize <= 8192

 hw/9pfs/9p.c | 9 +++++++++
 1 file changed, 9 insertions(+)

-- 
2.20.1


