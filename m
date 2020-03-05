Return-Path: <SRS0=BVCf=4W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B872C3F2CD
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 06:39:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D5B3D208CD
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 06:39:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5B3D208CD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43916 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9kAo-0004pR-2F
	for qemu-devel@archiver.kernel.org; Thu, 05 Mar 2020 01:39:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60620)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pannengyuan@huawei.com>) id 1j9kA3-0003er-SO
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 01:39:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pannengyuan@huawei.com>) id 1j9kA2-0006Po-PB
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 01:39:11 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:3183 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pannengyuan@huawei.com>)
 id 1j9kA2-0006N2-DP
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 01:39:10 -0500
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id 59236A1343639CBC2B43;
 Thu,  5 Mar 2020 14:39:05 +0800 (CST)
Received: from localhost.huawei.com (10.175.104.216) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.439.0; Thu, 5 Mar 2020 14:38:54 +0800
From: Pan Nengyuan <pannengyuan@huawei.com>
To: <qemu-devel@nongnu.org>
Subject: [PATCH v4 0/3] delay timer_new from init to realize to fix memleaks.
Date: Thu, 5 Mar 2020 14:54:19 +0800
Message-ID: <20200305065422.12707-1-pannengyuan@huawei.com>
X-Mailer: git-send-email 2.18.2
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
X-Originating-IP: [10.175.104.216]
X-CFilter-Loop: Reflected
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 45.249.212.190
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
wever, mos6522_realize is never called=20
at all due to the incorrect creation of it. So we aslo fix the incorrect =
creation in mac_via first, then move the
timer_new to mos6522_realize().

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
   - Aslo do timer_free on the error path in realize() and fix some codin=
g style. Then use device_class_set_parent_unrealize to declare unrealize.=
=20
   - split the mos6522 patch into two, one to fix incorrect creation of m=
os6522, the other to fix memleak.

Pan Nengyuan (3):
  s390x: fix memleaks in cpu_finalize
  mac_via: fix incorrect creation of mos6522 device in mac_via
  hw/misc/mos6522: move timer_new from init() into realize() to avoid
    memleaks

 hw/misc/mac_via.c      | 43 +++++++++++++++++++++++++++++-------------
 hw/misc/mos6522.c      |  6 ++++++
 target/s390x/cpu-qom.h |  1 +
 target/s390x/cpu.c     | 41 ++++++++++++++++++++++++++++++++++++----
 4 files changed, 74 insertions(+), 17 deletions(-)

--=20
2.18.2


