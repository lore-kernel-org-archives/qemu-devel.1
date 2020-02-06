Return-Path: <SRS0=rlpO=32=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD297C2D0B1
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 11:34:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A7F9620730
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 11:34:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N2zL4OaY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7F9620730
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36914 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izfQ2-00071A-TX
	for qemu-devel@archiver.kernel.org; Thu, 06 Feb 2020 06:34:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40237)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kraxel@redhat.com>) id 1izfLW-0008VS-Pa
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 06:29:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kraxel@redhat.com>) id 1izfLV-00025b-Q1
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 06:29:22 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:25952
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1izfLV-00023P-Lx
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 06:29:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580988561;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VV+baVbE0iCSyAaPQPldJWITCP9tg+jCQxrFr9GIeHA=;
 b=N2zL4OaYJH5WKKNUL3GwvdG6GOOqNxk9mkKIsznPfojvxvcfKJv2Z9m3k7WR6e/jb9FWg9
 fffEx/OgwLLqNcmpqLg2oS2r/ByO3RrzptRu6pMQPi3QHbNmX5pJisITAs41+LyPVfuwve
 A27HTBFuDG7AozQmV9umFh+MIyqols4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-212-meAhyeVDNWqIl1E_aNHz2Q-1; Thu, 06 Feb 2020 06:29:17 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2ACA2801A02;
 Thu,  6 Feb 2020 11:29:16 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-112.ams2.redhat.com
 [10.36.116.112])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C222226FA8;
 Thu,  6 Feb 2020 11:29:15 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 282391FCD6; Thu,  6 Feb 2020 12:29:09 +0100 (CET)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 5/6] ui: wire up legacy -show-cursor option
Date: Thu,  6 Feb 2020 12:29:07 +0100
Message-Id: <20200206112908.5002-6-kraxel@redhat.com>
In-Reply-To: <20200206112908.5002-1-kraxel@redhat.com>
References: <20200206112908.5002-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: meAhyeVDNWqIl1E_aNHz2Q-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
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
Cc: Peter Maydell <peter.maydell@linaro.org>, jtomko@redhat.com,
 libvir-list@redhat.com, Markus Armbruster <armbru@redhat.com>,
 jpewhacker@gmail.com, Gerd Hoffmann <kraxel@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 include/sysemu/sysemu.h | 1 -
 vl.c                    | 4 ++--
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/include/sysemu/sysemu.h b/include/sysemu/sysemu.h
index 6358a324a711..7956e9054ade 100644
--- a/include/sysemu/sysemu.h
+++ b/include/sysemu/sysemu.h
@@ -41,7 +41,6 @@ extern const char *keyboard_layout;
 extern int win2k_install_hack;
 extern int alt_grab;
 extern int ctrl_grab;
-extern int cursor_hide;
 extern int graphic_rotate;
 extern int no_shutdown;
 extern int old_param;
diff --git a/vl.c b/vl.c
index 7dcb0879c497..fd96d04578cd 100644
--- a/vl.c
+++ b/vl.c
@@ -168,7 +168,6 @@ int no_hpet =3D 0;
 int fd_bootchk =3D 1;
 static int no_reboot;
 int no_shutdown =3D 0;
-int cursor_hide =3D 1;
 int graphic_rotate =3D 0;
 const char *watchdog;
 QEMUOptionRom option_rom[MAX_OPTION_ROMS];
@@ -3553,7 +3552,8 @@ int main(int argc, char **argv, char **envp)
                 no_shutdown =3D 1;
                 break;
             case QEMU_OPTION_show_cursor:
-                cursor_hide =3D 0;
+                dpy.has_show_cursor =3D true;
+                dpy.show_cursor =3D true;
                 break;
             case QEMU_OPTION_uuid:
                 if (qemu_uuid_parse(optarg, &qemu_uuid) < 0) {
--=20
2.18.1


