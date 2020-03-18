Return-Path: <SRS0=a3Gm=5D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19F79C5ACD6
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2020 06:53:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E3CD820724
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2020 06:53:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3CD820724
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46260 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jESZq-0002U5-1o
	for qemu-devel@archiver.kernel.org; Wed, 18 Mar 2020 02:53:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39957)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <guoheyi@huawei.com>) id 1jESXC-0000Gp-QP
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 02:50:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <guoheyi@huawei.com>) id 1jESXB-0005mF-IO
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 02:50:34 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:57264 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <guoheyi@huawei.com>) id 1jESXB-0004x2-71
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 02:50:33 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id 678E35DAE9A951D0D0E9;
 Wed, 18 Mar 2020 14:50:26 +0800 (CST)
Received: from linux-kDCJWP.huawei.com (10.175.104.212) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.487.0; Wed, 18 Mar 2020 14:50:18 +0800
From: Heyi Guo <guoheyi@huawei.com>
To: <qemu-devel@nongnu.org>
Subject: [PATCH v4 0/2] add new options to set smbios type 4 fields
Date: Wed, 18 Mar 2020 14:48:18 +0800
Message-ID: <20200318064820.19363-1-guoheyi@huawei.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
X-Originating-IP: [10.175.104.212]
X-CFilter-Loop: Reflected
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 45.249.212.32
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Heyi Guo <guoheyi@huawei.com>,
 wanghaibin.wang@huawei.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Common VM users sometimes care about CPU speed, so we add two new
options to allow VM vendors to present CPU speed to their users.
Normally these information can be fetched from host smbios.

v3 -> v4:
- Fix the default value when not specifying "-smbios type=3D4" option;
  it would be 0 instead of 2000 in previous versions
- Use uint64_t type to check value overflow
- Add test case to check smbios type 4 CPU speed

Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Igor Mammedov <imammedo@redhat.com>
Cc: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>
Cc: Laurent Vivier <lvivier@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>

Heyi Guo (2):
  hw/smbios: add options for type 4 max-speed and current-speed
  tests/bios-tables-test: add smbios cpu speed test

 hw/smbios/smbios.c             | 36 +++++++++++++++++++++++++----
 qemu-options.hx                |  3 ++-
 tests/qtest/bios-tables-test.c | 42 ++++++++++++++++++++++++++++++++++
 3 files changed, 76 insertions(+), 5 deletions(-)

--=20
2.19.1


