Return-Path: <SRS0=BVCf=4W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4629C3F2CD
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 12:48:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B8D420848
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 12:48:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LXZF6hxk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B8D420848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48368 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9pvg-0003Wx-H9
	for qemu-devel@archiver.kernel.org; Thu, 05 Mar 2020 07:48:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41794)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j9ptC-0007VO-8l
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 07:46:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j9ptB-0001hx-CR
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 07:46:10 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:39623
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j9ptB-0001hS-8w
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 07:46:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583412368;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CFcihQRQW984a0z/mekZG0vNwXsxhiN/8+AlkGU0X9k=;
 b=LXZF6hxkRfrgJrPJPqdv3y0FvtkYPXEc95IEAzYNVH+roOc4gO3pZlb0pA/PXfo/e3rsom
 +soeu/fMh7p9YMvUGtfambVdlE7fmXZU4FrfYarYz1VS2oiemEw3hAU+usVOAM4O6Y7fes
 WbSd+K7Yv/fd7IGPlTOwc8Rg+1CbZmE=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-428--SSzPZvrMQ23pLLWQoIX2Q-1; Thu, 05 Mar 2020 07:46:07 -0500
X-MC-Unique: -SSzPZvrMQ23pLLWQoIX2Q-1
Received: by mail-wr1-f69.google.com with SMTP id u8so273486wrq.13
 for <qemu-devel@nongnu.org>; Thu, 05 Mar 2020 04:46:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=NxwSRvf3xC8N2g5o+oXCsfEFodIN9fcThiRrbeywMlg=;
 b=o7PSfusuSPcNi5lhCyQMjMLhZ61ui8VX6woEc9oHJ4OHTO0WwpnbIFh/2x8Ypl7IEu
 A+8vsC+H8aWUaiP2ECSEqy0vZDjdxHf7veNb2ghNVbv/VYzv9awzsYsiEj72QBGSVeJ2
 nyG36/ICZtqlFOjaJ5wJtLw7Pnz6hFSsM5Evz4enre3uzzE8bF3MZLxX7+v9raolRWwJ
 5Yw5vg+DsK5V7meo0SFOhtX/IcWnIXtyZFILBtrry5ZlVJNy39zb6QpsjmY5eHyje0Jk
 24ft7RfNzp75oVMAp73DhxcSePx8cDATny2uWdOwmaD2hQHPtBGBQzwFb1xGVWEWX3DL
 0KCg==
X-Gm-Message-State: ANhLgQ1o+Ju4N3bsV6JQ8XGOznff4L88NpDVi5W7v2vL7w0baIYH9pE4
 E2bLY8PGdg1Qy3op01uIkrulRWSA11qQrjEkfFbvEifbPcA4w4tAk8f9I2e1cFxsb5TaUYeTe4/
 OEEMGiC9yUF2swCk=
X-Received: by 2002:a7b:c5cd:: with SMTP id n13mr9396188wmk.172.1583412366070; 
 Thu, 05 Mar 2020 04:46:06 -0800 (PST)
X-Google-Smtp-Source: ADFU+vtEolt81viS5nizZiXUpufL+W79KWORVOPU66RVR7yAROIfUMT4WtGb5nf8YINqFgi/mzUU9A==
X-Received: by 2002:a7b:c5cd:: with SMTP id n13mr9396172wmk.172.1583412365912; 
 Thu, 05 Mar 2020 04:46:05 -0800 (PST)
Received: from localhost.localdomain (47.red-88-21-205.staticip.rima-tde.net.
 [88.21.205.47])
 by smtp.gmail.com with ESMTPSA id s15sm19858655wrr.45.2020.03.05.04.46.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Mar 2020 04:46:05 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-trivial@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH v2 7/9] ui/curses: Make control_characters[] array const
Date: Thu,  5 Mar 2020 13:45:23 +0100
Message-Id: <20200305124525.14555-8-philmd@redhat.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200305124525.14555-1-philmd@redhat.com>
References: <20200305124525.14555-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
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
Cc: Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Jason Wang <jasowang@redhat.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>, Greg Kurz <groug@kaod.org>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

As we only use this array as input, make it const.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 ui/curses.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/ui/curses.c b/ui/curses.c
index 3a1b71451c..3bafc10c1c 100644
--- a/ui/curses.c
+++ b/ui/curses.c
@@ -529,7 +529,7 @@ static void font_setup(void)
      * Control characters are normally non-printable, but VGA does have
      * well-known glyphs for them.
      */
-    static uint16_t control_characters[0x20] =3D {
+    static const uint16_t control_characters[0x20] =3D {
       0x0020,
       0x263a,
       0x263b,
--=20
2.21.1


