Return-Path: <SRS0=3yEa=UG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FB38C28CC3
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 09:25:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1ACAF208E3
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 09:25:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="gO4UxnIi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1ACAF208E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=yandex-team.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47452 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hZB7X-0002CD-CC
	for qemu-devel@archiver.kernel.org; Fri, 07 Jun 2019 05:25:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40565)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <yury-kotov@yandex-team.ru>) id 1hZArh-0007aj-A1
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 05:08:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <yury-kotov@yandex-team.ru>) id 1hZArf-0003U4-0j
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 05:08:49 -0400
Received: from forwardcorp1o.mail.yandex.net ([95.108.205.193]:52210)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <yury-kotov@yandex-team.ru>)
 id 1hZArb-0003E9-Mx
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 05:08:45 -0400
Received: from mxbackcorp2j.mail.yandex.net (mxbackcorp2j.mail.yandex.net
 [IPv6:2a02:6b8:0:1619::119])
 by forwardcorp1o.mail.yandex.net (Yandex) with ESMTP id 4B9FC2E0954;
 Fri,  7 Jun 2019 12:08:38 +0300 (MSK)
Received: from smtpcorp1j.mail.yandex.net (smtpcorp1j.mail.yandex.net
 [2a02:6b8:0:1619::137])
 by mxbackcorp2j.mail.yandex.net (nwsmtp/Yandex) with ESMTP id
 4bLm70LFf7-8bd8QAge; Fri, 07 Jun 2019 12:08:38 +0300
Precedence: bulk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; 
 t=1559898518; bh=R8uPoPGRvxFNM8lt1+H9ryaMBzDEuHrWONRcg8/fq0A=;
 h=Message-Id:Date:Subject:To:From:Cc;
 b=gO4UxnIij5bzbOG6iOr6cD30fg7Ptyp8FzUiyP/9ACPq8NS8VSCrCCbwORIupF/4s
 f1v6mk2pM+OU00qr8QVsTUWTwHWqxFxvT4R1hbWRQGMikMg1oquzFv4CfabO1G1MQW
 IDo+cX2D+jReMVLgJM02sHMvLQ32G7WYr3Xw/O2I=
Authentication-Results: mxbackcorp2j.mail.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Received: from dynamic-red.dhcp.yndx.net (dynamic-red.dhcp.yndx.net
 [2a02:6b8:0:40c:8805:5eb3:3042:85af])
 by smtpcorp1j.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id
 GZHLba17P1-8beaiqb7; Fri, 07 Jun 2019 12:08:37 +0300
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
 (Client certificate not present)
From: Yury Kotov <yury-kotov@yandex-team.ru>
To: Paolo Bonzini <pbonzini@redhat.com>,
 kvm@vger.kernel.org (open list:Overall)
Date: Fri,  7 Jun 2019 12:08:30 +0300
Message-Id: <20190607090830.18807-1-yury-kotov@yandex-team.ru>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 95.108.205.193
Subject: [Qemu-devel] [PATCH] kvm-all: Add/update fprintf's for
 kvm_*_ioeventfd_del
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: "open list:All patches CC here" <qemu-devel@nongnu.org>,
 yc-core@yandex-team.ru
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Yury Kotov <yury-kotov@yandex-team.ru>
---
 accel/kvm/kvm-all.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 524c4ddfbd..e4ac3386cb 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -864,8 +864,8 @@ static void kvm_mem_ioeventfd_add(MemoryListener *lis=
tener,
                                data, true, int128_get64(section->size),
                                match_data);
     if (r < 0) {
-        fprintf(stderr, "%s: error adding ioeventfd: %s\n",
-                __func__, strerror(-r));
+        fprintf(stderr, "%s: error adding ioeventfd: %s (%d)\n",
+                __func__, strerror(-r), -r);
         abort();
     }
 }
@@ -882,6 +882,8 @@ static void kvm_mem_ioeventfd_del(MemoryListener *lis=
tener,
                                data, false, int128_get64(section->size),
                                match_data);
     if (r < 0) {
+        fprintf(stderr, "%s: error deleting ioeventfd: %s (%d)\n",
+                __func__, strerror(-r), -r);
         abort();
     }
 }
@@ -898,8 +900,8 @@ static void kvm_io_ioeventfd_add(MemoryListener *list=
ener,
                               data, true, int128_get64(section->size),
                               match_data);
     if (r < 0) {
-        fprintf(stderr, "%s: error adding ioeventfd: %s\n",
-                __func__, strerror(-r));
+        fprintf(stderr, "%s: error adding ioeventfd: %s (%d)\n",
+                __func__, strerror(-r), -r);
         abort();
     }
 }
@@ -917,6 +919,8 @@ static void kvm_io_ioeventfd_del(MemoryListener *list=
ener,
                               data, false, int128_get64(section->size),
                               match_data);
     if (r < 0) {
+        fprintf(stderr, "%s: error deleting ioeventfd: %s (%d)\n",
+                __func__, strerror(-r), -r);
         abort();
     }
 }
--=20
2.21.0


