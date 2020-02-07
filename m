Return-Path: <SRS0=2niX=33=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 865CCC352A2
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 07:54:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 50E4120838
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 07:54:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H24blGap"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50E4120838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51480 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izySv-0007BO-I6
	for qemu-devel@archiver.kernel.org; Fri, 07 Feb 2020 02:54:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38567)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kraxel@redhat.com>) id 1izyL3-0005a5-4c
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 02:46:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kraxel@redhat.com>) id 1izyL2-0003NE-1B
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 02:46:09 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:40821
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1izyL1-0003La-TC
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 02:46:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581061567;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=89MwTjI5ssFFlAD2rPdHAiWJEtAHiV1CU9SAxfrvBDE=;
 b=H24blGapClKzADkRaetAacScayVRwBVdb+hO7+x00Gwj3xOa2EqnwWodRJuS5g4mZTPhcV
 HNjPB0WlLvwJ7vPs4GH9en/KNZeQjqCMYCih6bC1zXBRfeDk0mECqQ3yYcw30M72ElGkeu
 0ZQoBYGK8Q6WwuNudwp6RQ9ent8KDpE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-393-qdIEMnjhMuK5prRFDkudAA-1; Fri, 07 Feb 2020 02:46:03 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6AE52189F760;
 Fri,  7 Feb 2020 07:46:02 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-112.ams2.redhat.com
 [10.36.116.112])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1434F60C05;
 Fri,  7 Feb 2020 07:46:02 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 0842E31EAC; Fri,  7 Feb 2020 08:45:58 +0100 (CET)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 05/12] audio: prevent SIGSEGV in AUD_get_buffer_size_out
Date: Fri,  7 Feb 2020 08:45:50 +0100
Message-Id: <20200207074557.26073-6-kraxel@redhat.com>
In-Reply-To: <20200207074557.26073-1-kraxel@redhat.com>
References: <20200207074557.26073-1-kraxel@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: qdIEMnjhMuK5prRFDkudAA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
 Markus Armbruster <armbru@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Volker R=C3=BCmelin <vr_qemu@t-online.de>

With audiodev parameter out.mixing-engine=3Doff hw->mix_buf is
NULL. This leads to a segmentation fault in
AUD_get_buffer_size_out. This patch reverts a small part of
dc88e38fa7 "audio: unify input and output mixeng buffer
management".

To reproduce the problem start qemu with
-soundhw adlib -audiodev pa,id=3Daudio0,out.mixing-engine=3Doff

Signed-off-by: Volker R=C3=BCmelin <vr_qemu@t-online.de>
Message-Id: <20200123074943.6699-4-vr_qemu@t-online.de>
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 audio/audio.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/audio/audio.c b/audio/audio.c
index 9cd76a331d7a..12ed318813f4 100644
--- a/audio/audio.c
+++ b/audio/audio.c
@@ -879,9 +879,9 @@ size_t AUD_read(SWVoiceIn *sw, void *buf, size_t size)
     }
 }
=20
-int AUD_get_buffer_size_out (SWVoiceOut *sw)
+int AUD_get_buffer_size_out(SWVoiceOut *sw)
 {
-    return sw->hw->mix_buf->size * sw->hw->info.bytes_per_frame;
+    return sw->hw->samples * sw->hw->info.bytes_per_frame;
 }
=20
 void AUD_set_active_out (SWVoiceOut *sw, int on)
--=20
2.18.1


