Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F6EEC10F29
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 16:38:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4AB342073E
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 16:38:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ACFs/TYA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4AB342073E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36594 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEFEV-0007Wg-E2
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 12:38:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60625)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jEFA6-0006q0-Kh
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 12:33:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1jEFA5-0004iW-1u
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 12:33:50 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:49254)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1jEFA4-0004bw-SI
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 12:33:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584462828;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Zwk95DpFFuptjbLYNRG1EzSZXfhzBy3b1e1F1Ltf2e8=;
 b=ACFs/TYA8y7UTzrVnmU8wM+8EhfEuXFSxma4bZnsxenZ6CGIeh4ZMrJbrcnRuZL9w34/Kp
 QK0TNg24uMNzCd2FaG+TJ2PwaZmno2rA9IGZdXPDYgx3hbIMI2PWEHOV5ABnV49ilablDv
 W/ZdVE5qzpwJf+9hwto+/3cU4Ewd0IY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-139-SFY181HrOUiJS-q4U-GhDg-1; Tue, 17 Mar 2020 12:33:46 -0400
X-MC-Unique: SFY181HrOUiJS-q4U-GhDg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4E53C8010E7
 for <qemu-devel@nongnu.org>; Tue, 17 Mar 2020 16:33:45 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-130.ams2.redhat.com
 [10.36.112.130])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 20EFD19C70
 for <qemu-devel@nongnu.org>; Tue, 17 Mar 2020 16:33:45 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id A1C4D1138404; Tue, 17 Mar 2020 17:33:43 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 0/4] Error reporting patches for 2020-03-17
Date: Tue, 17 Mar 2020 17:33:39 +0100
Message-Id: <20200317163343.25028-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 216.205.24.74
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

The following changes since commit 40c67636f67c2a89745f2e698522fe917326a952=
:

  Merge remote-tracking branch 'remotes/kraxel/tags/usb-20200317-pull-reque=
st' into staging (2020-03-17 14:00:56 +0000)

are available in the Git repository at:

  git://repo.or.cz/qemu/armbru.git tags/pull-error-2020-03-17

for you to fetch changes up to 709dfb64925ed2b2978bf4c17ab98b2c7a9a05c1:

  hw/sd/ssi-sd: fix error handling in ssi_sd_realize (2020-03-17 17:30:03 +=
0100)

----------------------------------------------------------------
Error reporting patches for 2020-03-17

----------------------------------------------------------------
Markus Armbruster (3):
      Use &error_abort instead of separate assert()
      hw/misc/ivshmem: Use one Error * variable instead of two
      xen-block: Use one Error * variable instead of two

Vladimir Sementsov-Ogievskiy (1):
      hw/sd/ssi-sd: fix error handling in ssi_sd_realize

 block/monitor/block-hmp-cmds.c |  4 +---
 hw/block/xen-block.c           | 10 ++++------
 hw/misc/ivshmem.c              |  7 +++----
 hw/sd/ssi-sd.c                 | 16 ++++++++++++++--
 target/arm/monitor.c           |  8 ++------
 tests/qtest/fuzz/qos_fuzz.c    |  7 ++-----
 6 files changed, 26 insertions(+), 26 deletions(-)

--=20
2.21.1


