Return-Path: <SRS0=OzdF=4N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A97E5C35DF5
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 10:28:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8278F20714
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 10:28:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8278F20714
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52048 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6XS9-0003pI-Ph
	for qemu-devel@archiver.kernel.org; Tue, 25 Feb 2020 05:28:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34250)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jslaby@suse.cz>) id 1j6XRa-0003QG-7J
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 05:28:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jslaby@suse.cz>) id 1j6XRZ-0007PS-4N
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 05:28:02 -0500
Received: from mx2.suse.de ([195.135.220.15]:58500)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jslaby@suse.cz>) id 1j6XRY-0007MX-V5
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 05:28:01 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 5B2B6AE0F;
 Tue, 25 Feb 2020 10:27:59 +0000 (UTC)
From: Jiri Slaby <jslaby@suse.cz>
To: Samuel Thibault <samuel.thibault@ens-lyon.org>
Subject: [PATCH] slirp: samba, set 'server min protocol' to NT1
Date: Tue, 25 Feb 2020 11:27:58 +0100
Message-Id: <20200225102758.21074-1-jslaby@suse.cz>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x (no
 timestamps) [generic]
X-Received-From: 195.135.220.15
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
Cc: Jiri Slaby <jslaby@suse.cz>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Samba changed the default of server min protocol from LANMAN1 (very old
protocol) to SMB2_02 (only Vista and newer) in commit 840b8501b436
(docs-xml: change "server min protocol" to SMB2_02).

WXP guests cannot use the samba shares since then as it uses a protocol
newer than LANMAN1, but older than SMB2_02: NT1 protocol. So set 'server
min protocol' in the samba config used in qemu to NT1. This restores
support for WinNT and newer (WXP including).

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 net/slirp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/slirp.c b/net/slirp.c
index c4334ee876c7..b3bc4a2bded7 100644
--- a/net/slirp.c
+++ b/net/slirp.c
@@ -887,6 +887,7 @@ static int slirp_smb(SlirpState* s, const char *expor=
ted_dir,
             "printing =3D bsd\n"
             "disable spoolss =3D yes\n"
             "usershare max shares =3D 0\n"
+            "server min protocol =3D NT1\n"
             "[qemu]\n"
             "path=3D%s\n"
             "read only=3Dno\n"
--=20
2.25.1


