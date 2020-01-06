Return-Path: <SRS0=kvq2=23=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2088AC33C8C
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2020 12:54:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E26C42072E
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2020 12:54:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="efqBmje0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E26C42072E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51452 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ioRtn-0002bB-Jp
	for qemu-devel@archiver.kernel.org; Mon, 06 Jan 2020 07:54:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58296)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kraxel@redhat.com>) id 1ioRsE-0000rS-V7
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 07:52:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kraxel@redhat.com>) id 1ioRsD-0000rc-Sn
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 07:52:46 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:39298
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1ioRsD-0000rP-Oa
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 07:52:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578315165;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lXOGosYvPW6jgvcFaLnN32Way/3Noo2iJQc1+mSjxOc=;
 b=efqBmje0qIRrrqG1Cqw2IVAZiRtfT/wqKUD0k/BUDIYzQmJ3+2CWBZeQOioYPEyKq6brWZ
 58tDChagf73bd60uV40/6sxVfLonFHlBIzQMAZc4lnVpdiYt7LUs758Fm5ebjkpKJDbqRX
 sVN9qXayKglHgoEWYmE2hpM21wnH1KQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-278-3elVJeAVMmeD-CBR-P-_fw-1; Mon, 06 Jan 2020 07:52:41 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5D3F7800D48;
 Mon,  6 Jan 2020 12:52:40 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-98.ams2.redhat.com
 [10.36.116.98])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 87A3484FE2;
 Mon,  6 Jan 2020 12:52:37 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 8ED756DF9; Mon,  6 Jan 2020 13:52:36 +0100 (CET)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 1/6] hda-codec: fix playback rate control
Date: Mon,  6 Jan 2020 13:52:31 +0100
Message-Id: <20200106125236.24132-2-kraxel@redhat.com>
In-Reply-To: <20200106125236.24132-1-kraxel@redhat.com>
References: <20200106125236.24132-1-kraxel@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: 3elVJeAVMmeD-CBR-P-_fw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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
Cc: =?UTF-8?q?Volker=20R=C3=BCmelin?= <vr_qemu@t-online.de>,
 Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Volker R=C3=BCmelin <vr_qemu@t-online.de>

Since commit 1930616b98 "audio: make mixeng optional" the
function hda_audio_output_cb can no longer assume the function
parameter avail contains the free buffer size. With the playback
mixing-engine turned off this leads to a broken playback rate
control and playback buffer drops in regular intervals.

This patch moves down the rate calculation, so the correct
buffer fill level is used for the calculation.

Signed-off-by: Volker R=C3=BCmelin <vr_qemu@t-online.de>
Message-id: 20200104091122.13971-1-vr_qemu@t-online.de
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/audio/hda-codec.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/audio/hda-codec.c b/hw/audio/hda-codec.c
index f17e8d8dcea2..768ba31e7926 100644
--- a/hw/audio/hda-codec.c
+++ b/hw/audio/hda-codec.c
@@ -338,8 +338,6 @@ static void hda_audio_output_cb(void *opaque, int avail=
)
         return;
     }
=20
-    hda_timer_sync_adjust(st, (wpos - rpos) - to_transfer - (B_SIZE >> 1))=
;
-
     while (to_transfer) {
         uint32_t start =3D (uint32_t) (rpos & B_MASK);
         uint32_t chunk =3D (uint32_t) MIN(B_SIZE - start, to_transfer);
@@ -351,6 +349,8 @@ static void hda_audio_output_cb(void *opaque, int avail=
)
             break;
         }
     }
+
+    hda_timer_sync_adjust(st, (wpos - rpos) - (B_SIZE >> 1));
 }
=20
 static void hda_audio_compat_input_cb(void *opaque, int avail)
--=20
2.18.1


