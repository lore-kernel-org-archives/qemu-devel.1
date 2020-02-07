Return-Path: <SRS0=2niX=33=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAA97C352A2
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 07:57:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A5C4020838
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 07:57:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hByybcYC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5C4020838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51586 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izyWE-00030y-T4
	for qemu-devel@archiver.kernel.org; Fri, 07 Feb 2020 02:57:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38644)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kraxel@redhat.com>) id 1izyL6-0005dJ-0p
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 02:46:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kraxel@redhat.com>) id 1izyL4-0003Yn-VW
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 02:46:11 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:60768
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1izyL4-0003Xq-RO
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 02:46:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581061570;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TxdF4U8CUMJlk+/8yfkdI7k1P7e+b8uWQ+YEHyvtuhg=;
 b=hByybcYC4uFxT6trbssR33H8jqbifFvHFnUMc3kWYY3kwboe6KKknjBalKRB08aFLEsFeB
 2yGMA0yXBhpjuJQjn8H4Mi99iM2/ohnuxKxnl2z3A/faYr+PYfAkFIYlatjhHfwGCrba0b
 d7niSb8LIGHzSfKXdA9HRSP6sd3jk9c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-389-okgyi-UtOp-g1LHbSCpOIA-1; Fri, 07 Feb 2020 02:46:06 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E4362107B276;
 Fri,  7 Feb 2020 07:46:04 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-112.ams2.redhat.com
 [10.36.116.112])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 316AF89A7A;
 Fri,  7 Feb 2020 07:46:02 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 33BBD31F39; Fri,  7 Feb 2020 08:45:58 +0100 (CET)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 09/12] audio: audio_generic_get_buffer_in should honor *size
Date: Fri,  7 Feb 2020 08:45:54 +0100
Message-Id: <20200207074557.26073-10-kraxel@redhat.com>
In-Reply-To: <20200207074557.26073-1-kraxel@redhat.com>
References: <20200207074557.26073-1-kraxel@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: okgyi-UtOp-g1LHbSCpOIA-1
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

The function generic_get_buffer_in currently ignores the *size
parameter and may return a buffer larger than *size.

As a result the variable samples in function
audio_pcm_hw_run_in may underflow. The while loop then most
likely will never termiate.

Buglink: http://bugs.debian.org/948658
Signed-off-by: Volker R=C3=BCmelin <vr_qemu@t-online.de>
Message-Id: <20200123074943.6699-9-vr_qemu@t-online.de>
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 audio/audio.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/audio/audio.c b/audio/audio.c
index b686429203d6..f9859408f340 100644
--- a/audio/audio.c
+++ b/audio/audio.c
@@ -1407,7 +1407,8 @@ void *audio_generic_get_buffer_in(HWVoiceIn *hw, size=
_t *size)
     }
     assert(start >=3D 0 && start < hw->size_emul);
=20
-    *size =3D MIN(hw->pending_emul, hw->size_emul - start);
+    *size =3D MIN(*size, hw->pending_emul);
+    *size =3D MIN(*size, hw->size_emul - start);
     return hw->buf_emul + start;
 }
=20
--=20
2.18.1


