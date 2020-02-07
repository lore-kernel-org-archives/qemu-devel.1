Return-Path: <SRS0=2niX=33=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7251C352A2
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 07:55:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 81E4F20838
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 07:55:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DjnmHHA7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81E4F20838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51546 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izyTu-0008Jt-Mj
	for qemu-devel@archiver.kernel.org; Fri, 07 Feb 2020 02:55:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38610)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kraxel@redhat.com>) id 1izyL4-0005bv-Kb
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 02:46:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kraxel@redhat.com>) id 1izyL0-0003Ik-DU
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 02:46:10 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:40160
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1izyL0-0003GB-5Z
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 02:46:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581061565;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jQ33PVIzGLKgeiNygAl1hS3jQvDU1sm3Hnlo7xwUwhw=;
 b=DjnmHHA7elbC4ipCU3MqoFkZvU0vMwKYV980usPYPVS3enpleTJjN4B/c5gPt7NCV1mBO0
 245tIL3PQm+1ZBQfkoCsGcJuUtU5SFTgD0Dx7BHYkBmumVmx/zWrkXmoaK2AjBjWCiQFGU
 sMdgrtnVbXjnmPTlpXfCyvBRCuDcY2Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-193-FFySL5GxN9aKwVLf7beh0w-1; Fri, 07 Feb 2020 02:46:03 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 77F958010EF;
 Fri,  7 Feb 2020 07:46:02 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-112.ams2.redhat.com
 [10.36.116.112])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2BE6660C85;
 Fri,  7 Feb 2020 07:46:02 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 2B53A31F2A; Fri,  7 Feb 2020 08:45:58 +0100 (CET)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 08/12] ossaudio: disable poll mode can't be reached
Date: Fri,  7 Feb 2020 08:45:53 +0100
Message-Id: <20200207074557.26073-9-kraxel@redhat.com>
In-Reply-To: <20200207074557.26073-1-kraxel@redhat.com>
References: <20200207074557.26073-1-kraxel@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: FFySL5GxN9aKwVLf7beh0w-1
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

Currently there is no way to disable poll mode in
oss_enable_out and oss_enable_in when it was enabled before.
The enable code path always resets the poll mode state variable.

Fixes: b027a538c6 "oss: Remove unused error handling of qemu_set_fd_handler=
"
Signed-off-by: Volker R=C3=BCmelin <vr_qemu@t-online.de>
Message-Id: <20200123074943.6699-8-vr_qemu@t-online.de>
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 audio/ossaudio.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/audio/ossaudio.c b/audio/ossaudio.c
index 39a6fc09e5df..f88d076ec236 100644
--- a/audio/ossaudio.c
+++ b/audio/ossaudio.c
@@ -579,14 +579,12 @@ static void oss_enable_out(HWVoiceOut *hw, bool enabl=
e)
     AudiodevOssPerDirectionOptions *opdo =3D oss->dev->u.oss.out;
=20
     if (enable) {
-        bool poll_mode =3D opdo->try_poll;
+        hw->poll_mode =3D opdo->try_poll;
=20
         ldebug("enabling voice\n");
-        if (poll_mode) {
+        if (hw->poll_mode) {
             oss_poll_out(hw);
-            poll_mode =3D 0;
         }
-        hw->poll_mode =3D poll_mode;
=20
         if (!oss->mmapped) {
             return;
@@ -708,17 +706,15 @@ static void oss_enable_in(HWVoiceIn *hw, bool enable)
     AudiodevOssPerDirectionOptions *opdo =3D oss->dev->u.oss.out;
=20
     if (enable) {
-        bool poll_mode =3D opdo->try_poll;
+        hw->poll_mode =3D opdo->try_poll;
=20
-        if (poll_mode) {
+        if (hw->poll_mode) {
             oss_poll_in(hw);
-            poll_mode =3D 0;
         }
-        hw->poll_mode =3D poll_mode;
     } else {
         if (hw->poll_mode) {
-            hw->poll_mode =3D 0;
             qemu_set_fd_handler (oss->fd, NULL, NULL, NULL);
+            hw->poll_mode =3D 0;
         }
     }
 }
--=20
2.18.1


