Return-Path: <SRS0=Tmh/=3Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B382C35254
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 11:10:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 08BB52082E
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 11:10:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Nv/kUyfL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08BB52082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45046 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izIZO-0005r2-1a
	for qemu-devel@archiver.kernel.org; Wed, 05 Feb 2020 06:10:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45856)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kraxel@redhat.com>) id 1izITZ-00053r-LV
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 06:04:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kraxel@redhat.com>) id 1izITY-0000am-KQ
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 06:04:09 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:59164
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1izITY-0000U8-Cz
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 06:04:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580900647;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pTrNYiUvQNT+/fzdXbSfIQyC8vcvnbRrhBUzFETpfJc=;
 b=Nv/kUyfLA24lX2K8Bggr7Uux9hAczWx7OoAvcw8kOg73y+mVhQUAe4UkgtLjPBMkBoueQe
 5vmWT81OFCWcJ8Yt00iw7p+YhqPTYi6qHUdXP5+tc6659PMiKtBqhmSmlCvHJOldQVAruj
 FNYdAmhzi8S3hv/X2bScfRjQNqw71zA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-33-Ytts3cYwOKiYcKYivBUtwg-1; Wed, 05 Feb 2020 06:04:03 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6D7748C86C5;
 Wed,  5 Feb 2020 11:04:02 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-112.ams2.redhat.com
 [10.36.116.112])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5F305790C0;
 Wed,  5 Feb 2020 11:03:57 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id AEBA4939C; Wed,  5 Feb 2020 12:03:56 +0100 (CET)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 4/5] ui: wire up legacy -show-cursor option
Date: Wed,  5 Feb 2020 12:03:55 +0100
Message-Id: <20200205110356.3491-5-kraxel@redhat.com>
In-Reply-To: <20200205110356.3491-1-kraxel@redhat.com>
References: <20200205110356.3491-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: Ytts3cYwOKiYcKYivBUtwg-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
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
Cc: libvir-list@redhat.com, Markus Armbruster <armbru@redhat.com>,
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
index 80c57fdc4e64..da2f87c3e63a 100644
--- a/include/sysemu/sysemu.h
+++ b/include/sysemu/sysemu.h
@@ -42,7 +42,6 @@ extern const char *keyboard_layout;
 extern int win2k_install_hack;
 extern int alt_grab;
 extern int ctrl_grab;
-extern int cursor_hide;
 extern int graphic_rotate;
 extern int no_quit;
 extern int no_shutdown;
diff --git a/vl.c b/vl.c
index 24951b51a94b..0db0aa0fa040 100644
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


