Return-Path: <SRS0=QtPl=S4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 487D2C43219
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2019 10:22:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 08236206BA
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2019 10:22:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="Ui2qkksB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08236206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=yandex-team.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:44374 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJxzr-0006Pq-Rr
	for qemu-devel@archiver.kernel.org; Fri, 26 Apr 2019 06:22:23 -0400
Received: from eggs.gnu.org ([209.51.188.92]:39129)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yury-kotov@yandex-team.ru>) id 1hJxyy-0005zg-63
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 06:21:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yury-kotov@yandex-team.ru>) id 1hJxyw-00006q-L7
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 06:21:28 -0400
Received: from forwardcorp1p.mail.yandex.net ([77.88.29.217]:35820)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yury-kotov@yandex-team.ru>) id 1hJxyw-0008Uw-5J
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 06:21:26 -0400
Received: from mxbackcorp2j.mail.yandex.net (mxbackcorp2j.mail.yandex.net
	[IPv6:2a02:6b8:0:1619::119])
	by forwardcorp1p.mail.yandex.net (Yandex) with ESMTP id E50342E0B0C;
	Fri, 26 Apr 2019 13:21:20 +0300 (MSK)
Received: from smtpcorp1o.mail.yandex.net (smtpcorp1o.mail.yandex.net
	[2a02:6b8:0:1a2d::30])
	by mxbackcorp2j.mail.yandex.net (nwsmtp/Yandex) with ESMTP id
	caDrKcVAM1-LKjabE4l; Fri, 26 Apr 2019 13:21:20 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
	s=default; 
	t=1556274080; bh=xpJBT+6r35+/phclvoITZ9MSI4fYnvLXh5dRpcfww7A=;
	h=Message-Id:Date:Subject:To:From:Cc;
	b=Ui2qkksBWWv4bh3vgjltPK2fky1L2pOJoMiYdyAFsl4f4L8rj638Ad39CNgdT3gIB
	SV18bO0d4ukPkE2efysX2bMwhD+lszRj188O88zc3rhG1jHuQhdiyF5XdHQZpQPpVc
	63AAzk3LzHiXyaUp+rSJpln7y29PjPU3gAM7oCXo=
Authentication-Results: mxbackcorp2j.mail.yandex.net;
	dkim=pass header.i=@yandex-team.ru
Received: from dynamic-red.dhcp.yndx.net (dynamic-red.dhcp.yndx.net
	[2a02:6b8:0:40c:b098:c275:36ae:dc7d])
	by smtpcorp1o.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id
	kSMSqoPIcC-LKGSkZ7x; Fri, 26 Apr 2019 13:21:20 +0300
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
	(Client certificate not present)
From: Yury Kotov <yury-kotov@yandex-team.ru>
To: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 26 Apr 2019 13:21:15 +0300
Message-Id: <20190426102115.30002-1-yury-kotov@yandex-team.ru>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 77.88.29.217
Subject: [Qemu-devel] [PATCH] trace: fix runstate tracing
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
	qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190426102115.iq_IXg1-B7LYCtCs6oc0eA2diTMyLkCteg_Ztea99Jk@z>

Signed-off-by: Yury Kotov <yury-kotov@yandex-team.ru>
---
 vl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/vl.c b/vl.c
index ff5dfb6fbc..ad9b181e57 100644
--- a/vl.c
+++ b/vl.c
@@ -725,7 +725,7 @@ void runstate_set(RunState new_state)
     assert(new_state < RUN_STATE__MAX);
=20
     trace_runstate_set(current_run_state, RunState_str(current_run_state=
),
-                       new_state, RunState_str(current_run_state));
+                       new_state, RunState_str(new_state));
=20
     if (current_run_state =3D=3D new_state) {
         return;
--=20
2.21.0


