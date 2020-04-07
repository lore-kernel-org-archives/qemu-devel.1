Return-Path: <SRS0=U3m5=5X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C15F7C2BABC
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2020 09:23:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8BE2C206C0
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2020 09:23:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EsSCTj0I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8BE2C206C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43826 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jLkS6-0003ki-PP
	for qemu-devel@archiver.kernel.org; Tue, 07 Apr 2020 05:23:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33133)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kraxel@redhat.com>) id 1jLkR2-0002Km-Ur
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 05:22:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kraxel@redhat.com>) id 1jLkQz-0000cX-Vc
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 05:22:19 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:46945
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1jLkQz-0000be-Px
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 05:22:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1586251337;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QVjatr9rz5RUyOiLoTZe55id78U+fzRl2nagBZR8ICI=;
 b=EsSCTj0I1IK4nsEqp0wDvs1UNSNhaX9uh99eBUE8LH3eg5Y6y1eRFKgzRubGq+n7WyJ1Ax
 oOouS0vKDLCDIhSuHN9i5dNWuKbqfRa7T0D7ahxKrkPigxymLLAoywes8S6jGUrMqcS5Zv
 jp1fJvpfIWxDm0aq3OtHyfafl1CWnh8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-486-lE_g3bzUMMK10FFXPG2pNA-1; Tue, 07 Apr 2020 05:22:13 -0400
X-MC-Unique: lE_g3bzUMMK10FFXPG2pNA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2ADB913FC;
 Tue,  7 Apr 2020 09:22:12 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-113-60.ams2.redhat.com
 [10.36.113.60])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1F5CA9D36A;
 Tue,  7 Apr 2020 09:22:08 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 0D45617510; Tue,  7 Apr 2020 11:22:07 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 1/4] dsoundaudio: fix never-ending playback loop
Date: Tue,  7 Apr 2020 11:22:03 +0200
Message-Id: <20200407092207.6079-2-kraxel@redhat.com>
In-Reply-To: <20200407092207.6079-1-kraxel@redhat.com>
References: <20200407092207.6079-1-kraxel@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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

Currently the DirectSound backend fails to stop audio playback
in dsound_enable_out(). To detect a lost buffer condition
dsound_get_status_out() incorrectly uses the error code
DSERR_BUFFERLOST instead of flag DSBSTATUS_BUFFERLOST as a mask
and returns with an error. As a result dsound_enable_out()
returns early and doesn't stop playback.

To reproduce the bug start qemu on a Windows host with
-soundhw pcspk -audiodev dsound,id=3Daudio0. On the guest
FreeDOS 1.2 command line enter beep. The image Day 1 - F-Bird
from the QEMU Advent Calendar 2018 shows the bug as well.

Buglink: https://bugs.launchpad.net/qemu/+bug/1699628
Signed-off-by: Volker R=C3=BCmelin <vr_qemu@t-online.de>
Message-id: 20200405075017.9901-1-vr_qemu@t-online.de
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 audio/dsoundaudio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/audio/dsoundaudio.c b/audio/dsoundaudio.c
index bd57082a8dce..9e621c889954 100644
--- a/audio/dsoundaudio.c
+++ b/audio/dsoundaudio.c
@@ -279,7 +279,7 @@ static int dsound_get_status_out (LPDIRECTSOUNDBUFFER d=
sb, DWORD *statusp,
         return -1;
     }
=20
-    if (*statusp & DSERR_BUFFERLOST) {
+    if (*statusp & DSBSTATUS_BUFFERLOST) {
         dsound_restore_out(dsb, s);
         return -1;
     }
--=20
2.18.2


