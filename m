Return-Path: <SRS0=2niX=33=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E680AC352A2
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 07:53:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 720B320838
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 07:53:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OUdsxMUd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 720B320838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51444 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izyRs-0006HZ-Cg
	for qemu-devel@archiver.kernel.org; Fri, 07 Feb 2020 02:53:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38546)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kraxel@redhat.com>) id 1izyL2-0005Z2-6X
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 02:46:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kraxel@redhat.com>) id 1izyL0-0003HQ-62
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 02:46:08 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:21570
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1izyL0-0003FL-0g
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 02:46:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581061565;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WEal6v0StLv5MdRInwTQ1K88ni/qhZL/bT4j/z1X320=;
 b=OUdsxMUdM//EynUZ26Qs92HUJBGckkgyDzqtlNaROSjPafVPR2DVPhhfc534sf45DpCcbm
 ik5HaZrfkWwhgIvbZ3hVY/Qghej9+1SSHkIG+Bz0XH5vRUaD4ueE+NtnklW00Ia+ZGn4oK
 /YJI54lZFJgh67Kr/EIT+7oG6/zowi4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-27-nUKWvTuXNCGvq6WOM1cP8w-1; Fri, 07 Feb 2020 02:46:02 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 82CAB107B27F;
 Fri,  7 Feb 2020 07:46:01 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-112.ams2.redhat.com
 [10.36.116.112])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A281989A9C;
 Fri,  7 Feb 2020 07:45:58 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id EB6897707; Fri,  7 Feb 2020 08:45:57 +0100 (CET)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 03/12] audio: fix audio_generic_read
Date: Fri,  7 Feb 2020 08:45:48 +0100
Message-Id: <20200207074557.26073-4-kraxel@redhat.com>
In-Reply-To: <20200207074557.26073-1-kraxel@redhat.com>
References: <20200207074557.26073-1-kraxel@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: nUKWvTuXNCGvq6WOM1cP8w-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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

It seems the function audio_generic_read started as a copy of
function audio_generic_write and some necessary changes were
forgotten. Fix the mixed up source and destination pointers and
rename misnamed variables.

Signed-off-by: Volker R=C3=BCmelin <vr_qemu@t-online.de>
Message-Id: <20200123074943.6699-2-vr_qemu@t-online.de>
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 audio/audio.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/audio/audio.c b/audio/audio.c
index 7226aa64ff93..9cd76a331d7a 100644
--- a/audio/audio.c
+++ b/audio/audio.c
@@ -1481,12 +1481,12 @@ size_t audio_generic_write(HWVoiceOut *hw, void *bu=
f, size_t size)
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
2.18.1


