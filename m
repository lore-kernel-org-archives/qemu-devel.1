Return-Path: <SRS0=0TZc=4P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A65EC4BA37
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 02:36:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 20518222C2
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 02:36:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20518222C2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52950 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j792a-0001ZU-C2
	for qemu-devel@archiver.kernel.org; Wed, 26 Feb 2020 21:36:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60066)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pannengyuan@huawei.com>) id 1j791Q-0007we-Qw
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 21:35:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pannengyuan@huawei.com>) id 1j791P-0001YH-Rz
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 21:35:32 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:52400 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pannengyuan@huawei.com>)
 id 1j791N-0001F8-7W; Wed, 26 Feb 2020 21:35:29 -0500
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id 71FF85D8E690F1870F94;
 Thu, 27 Feb 2020 10:35:21 +0800 (CST)
Received: from localhost.localdomain (10.175.104.216) by
 DGGEMS409-HUB.china.huawei.com (10.3.19.209) with Microsoft SMTP Server id
 14.3.439.0; Thu, 27 Feb 2020 10:35:14 +0800
From: Pan Nengyuan <pannengyuan@huawei.com>
To: <peter.maydell@linaro.org>
Subject: [PATCH v3 0/6] delay timer_new from init to realize to fix memleaks.
Date: Thu, 27 Feb 2020 10:50:49 +0800
Message-ID: <20200227025055.14341-1-pannengyuan@huawei.com>
X-Mailer: git-send-email 2.18.2
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
X-Originating-IP: [10.175.104.216]
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
Cc: euler.robot@huawei.com, qemu-arm@nongnu.org,
 Pan Nengyuan <pannengyuan@huawei.com>, qemu-devel@nongnu.org,
 zhang.zhanghailiang@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This series delay timer_new from init into realize to avoid memleaks when=
 we call 'device_list_properties'.
And do timer_free only in s390x_cpu_finalize because it's hotplugable. Ho=
wever, It's not valid in mos6522
if we move timer_new from init to realize, because it's never called at a=
ll. So we also add calls to mos6522_realize()
in mac_via_realize to make this move to be valid.

v1:
   - Delay timer_new() from init() to realize() to fix memleaks.
v2:
   - Similarly to other cleanups, move timer_new into realize in target/s=
390x/cpu.c (Suggested by Philippe Mathieu-Daud=C3=A9).
   - Send these two patches as a series instead of send each as a single =
patch but with wrong subject in v1.
v3:
   - It's not valid in mos6522 if we move timer_new from init to realize,=
 because it's never called at all.
     Thus, we remove null check in reset, and add calls to mos6522_realiz=
e() in mac_via_realize to make this move to be valid.
   - split patch by device to make it more clear.

Pan Nengyuan (6):
  s390x: fix memleaks in cpu_finalize
  hw/arm/pxa2xx: move timer_new from init() into realize() to avoid
    memleaks
  hw/arm/spitz: move timer_new from init() into realize() to avoid
    memleaks
  hw/arm/strongarm: move timer_new from init() into realize() to avoid
    memleaks
  hw/misc/mos6522: move timer_new from init() into realize() to avoid
    memleaks
  hw/timer/cadence_ttc: move timer_new from init() into realize() to
    avoid memleaks

 hw/arm/pxa2xx.c        | 17 +++++++++++------
 hw/arm/spitz.c         |  8 +++++++-
 hw/arm/strongarm.c     | 18 ++++++++++++------
 hw/misc/mac_via.c      |  5 +++++
 hw/misc/mos6522.c      |  6 ++++++
 hw/timer/cadence_ttc.c | 16 +++++++++++-----
 target/s390x/cpu.c     | 22 ++++++++++++++++++----
 7 files changed, 70 insertions(+), 22 deletions(-)

--=20
2.18.2


