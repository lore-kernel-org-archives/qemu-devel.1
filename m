Return-Path: <SRS0=2cnN=BD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6E67C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 13:49:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B1450206D8
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 13:49:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cItXaUGZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1450206D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33758 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyy4V-0006ix-SA
	for qemu-devel@archiver.kernel.org; Fri, 24 Jul 2020 09:49:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52184)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jyy2b-00043w-On
 for qemu-devel@nongnu.org; Fri, 24 Jul 2020 09:47:13 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:51617
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jyy2Z-0004Cu-TT
 for qemu-devel@nongnu.org; Fri, 24 Jul 2020 09:47:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595598431;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=REUrC7H8Zd2rs6IvbWmz4M2uKfF3n+4pdQVSlKgpyz4=;
 b=cItXaUGZhLJwiOxqmksc7WTIyNSk5yUgEoABtzNyR+h+l3cCHY9wn2zxL7oS+opekgHvqQ
 g5Z5u34U6AVDsR8YbpEhHRztcIWHTZxz4WDZf47KnDzECIX/kwD+ZeKgyegFW+owRlbRFe
 /qGa4UUy/pN2jUq5yiTGIlZ7061ZAbI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-302-s1rp5r8cNnmPuZDEyVPGhg-1; Fri, 24 Jul 2020 09:47:07 -0400
X-MC-Unique: s1rp5r8cNnmPuZDEyVPGhg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 53A10193F566;
 Fri, 24 Jul 2020 13:47:06 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-143.ams2.redhat.com
 [10.36.112.143])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 26D452DE71;
 Fri, 24 Jul 2020 13:47:06 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id A11811138648; Fri, 24 Jul 2020 15:47:04 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 0/4] Error reporting patches patches for 2020-07-24
Date: Fri, 24 Jul 2020 15:47:00 +0200
Message-Id: <20200724134704.2248335-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=armbru@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/24 08:23:04
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit 09e0cd773723219d21655587954da2769f64ba01:

  Merge remote-tracking branch 'remotes/alistair/tags/pull-riscv-to-apply-20200722-1' into staging (2020-07-23 19:00:42 +0100)

are available in the Git repository at:

  git://repo.or.cz/qemu/armbru.git tags/pull-error-2020-07-24

for you to fetch changes up to 192cf54ac5408d21c20c17b3794a632970bbb880:

  qapi/error: Check format string argument in error_*prepend() (2020-07-24 15:03:09 +0200)

----------------------------------------------------------------
Error reporting patches patches for 2020-07-24

----------------------------------------------------------------
Markus Armbruster (2):
      coccinelle/err-bad-newline: Fix for Python 3, and add patterns
      error: Strip trailing '\n' from error string arguments (again)

Philippe Mathieu-Daudé (1):
      qapi/error: Check format string argument in error_*prepend()

Stefan Weil (1):
      sd/milkymist-memcard: Fix format string

 scripts/coccinelle/err-bad-newline.cocci | 24 ++++++++++++++++++++++--
 include/qapi/error.h                     |  6 ++++--
 hw/i386/intel_iommu.c                    |  6 +++---
 hw/sd/milkymist-memcard.c                |  2 +-
 target/ppc/mmu-hash64.c                  |  2 +-
 5 files changed, 31 insertions(+), 9 deletions(-)

-- 
2.26.2


