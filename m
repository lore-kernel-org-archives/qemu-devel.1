Return-Path: <SRS0=i8Yf=47=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6F9DC0044D
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Mar 2020 08:37:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D4462073C
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Mar 2020 08:37:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D4462073C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42500 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jD2I9-0007zJ-Qq
	for qemu-devel@archiver.kernel.org; Sat, 14 Mar 2020 04:37:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54500)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pannengyuan@huawei.com>) id 1jD2HC-0006cu-4S
 for qemu-devel@nongnu.org; Sat, 14 Mar 2020 04:36:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pannengyuan@huawei.com>) id 1jD2HA-0004Xw-TK
 for qemu-devel@nongnu.org; Sat, 14 Mar 2020 04:36:09 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:3287 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pannengyuan@huawei.com>)
 id 1jD2HA-0003x0-GE
 for qemu-devel@nongnu.org; Sat, 14 Mar 2020 04:36:08 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id E821862D9F99863BFB72;
 Sat, 14 Mar 2020 16:35:57 +0800 (CST)
Received: from localhost.huawei.com (10.175.104.216) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.487.0; Sat, 14 Mar 2020 16:35:49 +0800
From: Pan Nengyuan <pannengyuan@huawei.com>
To: <qemu-devel@nongnu.org>
Subject: [PATCH v5 0/4] delay timer_new from init to realize to fix memleaks.
Date: Sat, 14 Mar 2020 16:47:26 +0800
Message-ID: <20200314084730.25876-1-pannengyuan@huawei.com>
X-Mailer: git-send-email 2.18.2
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
X-Originating-IP: [10.175.104.216]
X-CFilter-Loop: Reflected
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 45.249.212.191
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
Cc: peter.maydell@linaro.org, Pan Nengyuan <pannengyuan@huawei.com>,
 zhang.zhanghailiang@huawei.com, euler.robot@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This series delay timer_new from init into realize to avoid memleaks when=
 we call 'device_list_properties'.
And do timer_free only in s390x_cpu_finalize because it's hotplugable. Ho=
wever, mos6522_realize is never called
at all due to the incorrect creation of it. So we fix the incorrect creat=
ion in mac_via/cuda/pmu first, then=20
move the timer_new to mos6522_realize().

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
v4:
   - Also do timer_free on the error path in realize() and fix some codin=
g style. Then use device_class_set_parent_unrealize to declare unrealize.
   - split the mos6522 patch into two, one to fix incorrect creation of m=
os6522, the other to fix memleak.

v5:=20
   - Fix two other places where we create mos6522's subclasses but forgot=
 to realize it(macio/cuda,macio/pmu).=20
     Otherwise, this will cause SEGVs during make check-qtest-ppc64.
   - Remove timer_del on the error path of s390x_cpu_realize() and simply=
 use errp instead a temporary variable.

Pan Nengyuan (4):
  s390x: fix memleaks in cpu_finalize
  mac_via: fix incorrect creation of mos6522 device in mac_via
  hw/misc/macio: fix incorrect creation of mos6522's subclasses
  hw/misc/mos6522: move timer_new from init() into realize() to avoid
    memleaks

 hw/misc/mac_via.c      | 40 +++++++++++++++++++++++++++-------------
 hw/misc/macio/cuda.c   | 11 +++++++++--
 hw/misc/macio/pmu.c    | 11 +++++++++--
 hw/misc/mos6522.c      |  6 ++++++
 target/s390x/cpu-qom.h |  1 +
 target/s390x/cpu.c     | 30 ++++++++++++++++++++++++++----
 6 files changed, 78 insertions(+), 21 deletions(-)

--=20
2.18.2


