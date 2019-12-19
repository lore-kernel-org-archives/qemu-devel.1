Return-Path: <SRS0=p/0J=2J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C854DC43603
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 16:09:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 92E86206D8
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 16:09:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="Una/LWLi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92E86206D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=yandex-team.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44080 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihyMq-0005FZ-9Q
	for qemu-devel@archiver.kernel.org; Thu, 19 Dec 2019 11:09:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41064)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <yury-kotov@yandex-team.ru>) id 1ihyLc-0003tc-Na
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 11:08:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <yury-kotov@yandex-team.ru>) id 1ihyLZ-0006FK-Lg
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 11:08:18 -0500
Received: from forwardcorp1j.mail.yandex.net ([5.45.199.163]:44128)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <yury-kotov@yandex-team.ru>)
 id 1ihyLY-0005vO-Vm
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 11:08:17 -0500
Received: from mxbackcorp1o.mail.yandex.net (mxbackcorp1o.mail.yandex.net
 [IPv6:2a02:6b8:0:1a2d::301])
 by forwardcorp1j.mail.yandex.net (Yandex) with ESMTP id 1BCE42E0B04;
 Thu, 19 Dec 2019 19:08:13 +0300 (MSK)
Received: from vla5-58875c36c028.qloud-c.yandex.net
 (vla5-58875c36c028.qloud-c.yandex.net [2a02:6b8:c18:340b:0:640:5887:5c36])
 by mxbackcorp1o.mail.yandex.net (mxbackcorp/Yandex) with ESMTP id
 4t5pKRZ8DK-8BHe1Mkd; Thu, 19 Dec 2019 19:08:13 +0300
Precedence: bulk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; 
 t=1576771693; bh=USineli/sKqEICn+rKU7uhe9cefKFDPyk6NtUuItsbg=;
 h=Message-Id:Date:Subject:To:From:Cc;
 b=Una/LWLiAkXuHYHgH6/VWlLgx5JFfZWaIbsZimAvnkz26oJoemsDyOHTjnm3i0xfR
 6Jr0FIMECrhF/LqmBBOnOdpL+jBu4IuRi2Rh6X066nLneelTN6dHKT4lsvOnH63o5t
 WWiNMfXOTpf1hGafTda6baml2OtbBJBhUoGU7DwA=
Authentication-Results: mxbackcorp1o.mail.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Received: from dynamic-red.dhcp.yndx.net (dynamic-red.dhcp.yndx.net
 [2a02:6b8:0:408:9915:7a93:bd7b:686c])
 by vla5-58875c36c028.qloud-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id
 FfZMqtXGzo-8BWedSqH; Thu, 19 Dec 2019 19:08:11 +0300
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (Client certificate not present)
From: Yury Kotov <yury-kotov@yandex-team.ru>
To: qemu-devel@nongnu.org
Subject: [PATCH 0/2] Speed up QMP stream reading
Date: Thu, 19 Dec 2019 19:07:54 +0300
Message-Id: <20191219160756.22389-1-yury-kotov@yandex-team.ru>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 5.45.199.163
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
Cc: =?utf-8?B?RGFuaWVsIFAuIEJlcnJhbmfDqQ==?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Denis Plotnikov <dplotnikov@virtuozzo.com>, yc-core@yandex-team.ru,
 =?utf-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>,
 "Denis V. Lunev" <den@openvz.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi,

This series is continuation of another one:
[PATCH] monitor: Fix slow reading
https://lists.gnu.org/archive/html/qemu-devel/2019-11/msg03722.html

Which also tried to read more than one byte from a stream at a time,
but had some problems with OOB and HMP:
https://lists.gnu.org/archive/html/qemu-devel/2019-11/msg05018.html

This series is an attempt to fix problems described.

Regards,
Yury

Yury Kotov (2):
  monitor: Split monitor_can_read for QMP and HMP
  monitor: Add an input buffer for QMP reading

 monitor/hmp.c              |  7 +++++++
 monitor/monitor-internal.h | 12 +++++++++++-
 monitor/monitor.c          | 34 +++++++++++++++++++++++++++-------
 monitor/qmp.c              | 26 +++++++++++++++++++++++---
 4 files changed, 68 insertions(+), 11 deletions(-)

--=20
2.24.1


