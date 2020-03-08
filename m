Return-Path: <SRS0=qQQb=4Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77E5CC10F27
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Mar 2020 19:36:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 568752067C
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Mar 2020 19:36:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 568752067C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=t-online.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32808 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jB1iY-0004yi-FE
	for qemu-devel@archiver.kernel.org; Sun, 08 Mar 2020 15:36:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37267)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <volker.ruemelin@t-online.de>) id 1jB1g9-0002Rk-RQ
 for qemu-devel@nongnu.org; Sun, 08 Mar 2020 15:33:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <volker.ruemelin@t-online.de>) id 1jB1g8-000723-UQ
 for qemu-devel@nongnu.org; Sun, 08 Mar 2020 15:33:37 -0400
Received: from mailout06.t-online.de ([194.25.134.19]:48954)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <volker.ruemelin@t-online.de>)
 id 1jB1g8-00071Z-OI
 for qemu-devel@nongnu.org; Sun, 08 Mar 2020 15:33:36 -0400
Received: from fwd24.aul.t-online.de (fwd24.aul.t-online.de [172.20.26.129])
 by mailout06.t-online.de (Postfix) with SMTP id 6CF10417E467;
 Sun,  8 Mar 2020 20:33:35 +0100 (CET)
Received: from linpower.localnet
 (rXpqIYZfohqLY+clO6MgLyQ3aZgR2oSiY7BLQbrYIZnbOIaXplSPlwfrDvRRXsLZPv@[79.208.31.100])
 by fwd24.t-online.de
 with (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384 encrypted)
 esmtp id 1jB1g4-1Samyu0; Sun, 8 Mar 2020 20:33:32 +0100
Received: by linpower.localnet (Postfix, from userid 1000)
 id 99A702006D0; Sun,  8 Mar 2020 20:33:21 +0100 (CET)
From: =?UTF-8?q?Volker=20R=C3=BCmelin?= <vr_qemu@t-online.de>
To: Gerd Hoffmann <kraxel@redhat.com>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Subject: [PATCH v2 5/6] audio: fix saturation nonlinearity in clip_* functions
Date: Sun,  8 Mar 2020 20:33:20 +0100
Message-Id: <20200308193321.20668-5-vr_qemu@t-online.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <2a4ade5f-d39b-3094-578f-6cced4650720@t-online.de>
References: <2a4ade5f-d39b-3094-578f-6cced4650720@t-online.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-ID: rXpqIYZfohqLY+clO6MgLyQ3aZgR2oSiY7BLQbrYIZnbOIaXplSPlwfrDvRRXsLZPv
X-TOI-MSGID: ea02d5cd-b794-468a-8c7a-c5530fe25ba6
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 194.25.134.19
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
Cc: John Arbuckle <programmingkidx@gmail.com>,
 Howard Spoelstra <hsp.cat7@gmail.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, QEMU <qemu-devel@nongnu.org>,
 =?UTF-8?q?Zolt=C3=A1n=20K=C5=91v=C3=A1g=C3=B3?= <dirty.ice.hu@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The current positive limit for the saturation nonlinearity is
only correct if the type of the result has 8 bits or less.

Signed-off-by: Volker R=C3=BCmelin <vr_qemu@t-online.de>
---
 audio/mixeng_template.h | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/audio/mixeng_template.h b/audio/mixeng_template.h
index fc8e1d4d9e..bc8509e423 100644
--- a/audio/mixeng_template.h
+++ b/audio/mixeng_template.h
@@ -83,10 +83,9 @@ static inline int64_t glue (conv_, ET) (IN_T v)
=20
 static inline IN_T glue (clip_, ET) (int64_t v)
 {
-    if (v >=3D 0x7f000000) {
+    if (v >=3D 0x7fffffffLL) {
         return IN_MAX;
-    }
-    else if (v < -2147483648LL) {
+    } else if (v < -2147483648LL) {
         return IN_MIN;
     }
=20
--=20
2.16.4


