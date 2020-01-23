Return-Path: <SRS0=mO9Z=3M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C21C1C33CAA
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 07:51:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9769124125
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 07:51:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9769124125
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=t-online.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52378 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuXGj-0007DF-AF
	for qemu-devel@archiver.kernel.org; Thu, 23 Jan 2020 02:51:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46026)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <volker.ruemelin@t-online.de>) id 1iuXFN-0005hA-Nc
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 02:49:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <volker.ruemelin@t-online.de>) id 1iuXFM-0004Px-QZ
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 02:49:49 -0500
Received: from mailout01.t-online.de ([194.25.134.80]:36340)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <volker.ruemelin@t-online.de>)
 id 1iuXFM-0004P9-Ku
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 02:49:48 -0500
Received: from fwd28.aul.t-online.de (fwd28.aul.t-online.de [172.20.26.133])
 by mailout01.t-online.de (Postfix) with SMTP id 5BBAC42DD470;
 Thu, 23 Jan 2020 08:49:47 +0100 (CET)
Received: from linpower.localnet
 (GvE5AwZawhyHpEISWGUAR6yEAWHXtdmV5fAU0TtZcH1uphGC7+rltvL1mYr6Y36QlL@[46.86.62.122])
 by fwd28.t-online.de
 with (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384 encrypted)
 esmtp id 1iuXFK-468UOO0; Thu, 23 Jan 2020 08:49:46 +0100
Received: by linpower.localnet (Postfix, from userid 1000)
 id 55E302006F4; Thu, 23 Jan 2020 08:49:43 +0100 (CET)
From: =?UTF-8?q?Volker=20R=C3=BCmelin?= <vr_qemu@t-online.de>
To: Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH 2/9] audio: fix audio_generic_read
Date: Thu, 23 Jan 2020 08:49:36 +0100
Message-Id: <20200123074943.6699-2-vr_qemu@t-online.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <1e29e1d3-b59b-fcd6-cdff-a680bcdbffa4@t-online.de>
References: <1e29e1d3-b59b-fcd6-cdff-a680bcdbffa4@t-online.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-ID: GvE5AwZawhyHpEISWGUAR6yEAWHXtdmV5fAU0TtZcH1uphGC7+rltvL1mYr6Y36QlL
X-TOI-MSGID: aaa557f0-0931-451b-b1ee-f95a482e22fe
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 194.25.134.80
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
Cc: QEMU <qemu-devel@nongnu.org>,
 =?UTF-8?q?Zolt=C3=A1n=20K=C5=91v=C3=A1g=C3=B3?= <dirty.ice.hu@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

It seems the function audio_generic_read started as a copy of
function audio_generic_write and some necessary changes were
forgotten. Fix the mixed up source and destination pointers and
rename misnamed variables.

Signed-off-by: Volker R=C3=BCmelin <vr_qemu@t-online.de>
---
 audio/audio.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/audio/audio.c b/audio/audio.c
index db44482342..bf0f01e17f 100644
--- a/audio/audio.c
+++ b/audio/audio.c
@@ -1480,12 +1480,12 @@ size_t audio_generic_write(HWVoiceOut *hw, void *=
buf, size_t size)
=20
 size_t audio_generic_read(HWVoiceIn *hw, void *buf, size_t size)
 {
-    size_t dst_size, copy_size;
-    void *dst =3D hw->pcm_ops->get_buffer_in(hw, &dst_size);
-    copy_size =3D MIN(size, dst_size);
+    size_t src_size, copy_size;
+    void *src =3D hw->pcm_ops->get_buffer_in(hw, &src_size);
+    copy_size =3D MIN(size, src_size);
=20
-    memcpy(dst, buf, copy_size);
-    hw->pcm_ops->put_buffer_in(hw, buf, copy_size);
+    memcpy(buf, src, copy_size);
+    hw->pcm_ops->put_buffer_in(hw, src, copy_size);
     return copy_size;
 }
=20
--=20
2.16.4


