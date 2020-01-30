Return-Path: <SRS0=hbhd=3T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49434C2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 13:48:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E55B20707
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 13:48:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E55B20707
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jolla.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32790 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ixAB8-0003wN-B1
	for qemu-devel@archiver.kernel.org; Thu, 30 Jan 2020 08:48:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36716)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <franz.haider@jolla.com>) id 1ix9R2-0007Zg-2P
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 08:00:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <franz.haider@jolla.com>) id 1ix9Qw-0006vF-Ub
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 08:00:39 -0500
Received: from smtp81.ord1d.emailsrvr.com ([184.106.54.81]:35817)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <franz.haider@jolla.com>)
 id 1ix9Qw-0006uW-Qp
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 08:00:34 -0500
X-Auth-ID: franz.haider@jollamobile.com
Received: by smtp3.relay.ord1d.emailsrvr.com (Authenticated sender:
 franz.haider-AT-jollamobile.com) with ESMTPSA id 9D6B160140; 
 Thu, 30 Jan 2020 08:00:32 -0500 (EST)
X-Sender-Id: franz.haider@jollamobile.com
Received: from [10.1.3.125] ([UNAVAILABLE]. [185.252.118.68])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA)
 by 0.0.0.0:465 (trex/5.7.12); Thu, 30 Jan 2020 08:00:33 -0500
To: Riku Voipio <riku.voipio@iki.fi>
From: Frajo <franz.haider@jolla.com>
Subject: linux-user: Support f_flags in statfs64 when available.
Message-ID: <2e405fe7-efab-dae5-93d6-02575773fd6e@jolla.com>
Date: Thu, 30 Jan 2020 15:00:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [fuzzy]
X-Received-From: 184.106.54.81
X-Mailman-Approved-At: Thu, 30 Jan 2020 08:47:11 -0500
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
Cc: Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

linux-user: Support f_flags in statfs64 when available.
Same as d4247ec2d79ef2477cb886fa688706b068119736 but for statfs64
When running rpm within qemu-arm-dynamic this could cause rpm fail with=20
an error like
"installing package A needs B MB on the C filesystem" depending on what=20
is in memory in f_flags.
https://github.com/rpm-software-management/rpm/blob/af06db1d5558870f7fb8f=
5c502572c2d27af5c71/lib/transaction.c#L164

 From 6ceb5662b5fae827d2c0cdd9896eec75997c060a Mon Sep 17 00:00:00 2001
From: Franz-Josef Haider <franz.haider@jolla.com>
Date: Thu, 30 Jan 2020 14:28:24 +0200
Subject: [PATCH 1/1] linux-user: Support f_flags in statfs64 when availab=
le.

Same as d4247ec2d79ef2477cb886fa688706b068119736 but for statfs64

Signed-off-by: Franz-Josef Haider <franz.haider@jolla.com>
---
 =C2=A0linux-user/syscall.c | 5 +++++
 =C2=A01 file changed, 5 insertions(+)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index d60142f069..45782b1009 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -8997,6 +8997,11 @@ static abi_long do_syscall1(void *cpu_env, int=20
num, abi_long arg1,
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 __put_user(stfs.f_fsid.__val[1], &target_stfs->f_fsid.val[1]);
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 __put_user(stfs.f_namelen, &target_stfs->f_namelen);
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 __put_user(stfs.f_frsize, &target_stfs->f_frsize);
+#ifdef _STATFS_F_FLAGS
+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 __put=
_user(stfs.f_flags, &target_stfs->f_flags);
+#else
+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 __put=
_user(0, &target_stfs->f_flags);
+#endif
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 memset(target_stfs->f_spare, 0, sizeof(target_stfs->f_spare));
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 unlock_user_struct(target_stfs, arg3, 1);
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
--=20
2.20.1


