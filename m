Return-Path: <SRS0=3v23=UE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46274C282CE
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2019 01:02:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 21FE9206B8
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2019 01:02:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21FE9206B8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nongnu.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:33543 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYKJg-0007dN-6h
	for qemu-devel@archiver.kernel.org; Tue, 04 Jun 2019 21:02:12 -0400
Received: from eggs.gnu.org ([209.51.188.92]:52568)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cuser@cusers-Mac-mini.local>) id 1hYKI9-0006am-Oe
	for qemu-devel@nongnu.org; Tue, 04 Jun 2019 21:00:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cuser@cusers-Mac-mini.local>) id 1hYKI7-000782-8z
	for qemu-devel@nongnu.org; Tue, 04 Jun 2019 21:00:37 -0400
Received: from [36.106.167.139] (port=63967 helo=cusers-Mac-mini.local)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cuser@cusers-Mac-mini.local>) id 1hYKI5-00070q-9f
	for qemu-devel@nongnu.org; Tue, 04 Jun 2019 21:00:34 -0400
Received: by cusers-Mac-mini.local (Postfix, from userid 501)
	id EFE5DEFD86D; Tue,  4 Jun 2019 17:13:59 +0800 (CST)
To: peter.maydell@linaro.org,
	kraxel@redhat.com
Date: Tue,  4 Jun 2019 17:12:45 +0800
Message-Id: <0095872e709300198d5fc96f42b112a6fd724391.1559638310.git.tgfbeta@me.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1559638310.git.tgfbeta@me.com>
References: <cover.1559638310.git.tgfbeta@me.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Mac OS X  [generic] [fuzzy]
X-Received-From: 36.106.167.139
Subject: [Qemu-devel] [PATCH 2/2] ui/cocoa: Fix mouse grabbing in fullscreen
 mode for relative input device
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
From: Chen Zhang via Qemu-devel <qemu-devel@nongnu.org>
Reply-To: Chen Zhang <tgfbeta@me.com>
Cc: qemu-devel@nongnu.org, Chen Zhang <tgfbeta@me.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

In fullscreen mode, the window property of cocoaView may not be the key
window, and the current implementation would not re-grab cursor by left c=
lick
in fullscreen mode after ungrabbed in fullscreen mode with hot-key ctrl-o=
pt-g.

This patch used value of isFullscreen as a short-cirtuit condition for
relative input device grabbing.

Signed-off-by: Chen Zhang <tgfbeta@me.com>
---
 ui/cocoa.m | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/ui/cocoa.m b/ui/cocoa.m
index 474d44cb9f..aa7cf07368 100644
--- a/ui/cocoa.m
+++ b/ui/cocoa.m
@@ -901,7 +901,12 @@ QemuCocoaView *cocoaView;
         case NSEventTypeLeftMouseUp:
             mouse_event =3D true;
             if (!isMouseGrabbed && [self screenContainsPoint:p]) {
-                if([[self window] isKeyWindow]) {
+                /*
+                 * In fullscreen mode, the window of cocoaView may not b=
e the
+                 * key window, therefore the position relative to the vi=
rtual
+                 * screen alone will be sufficient.
+                 */
+                if(isFullscreen || [[self window] isKeyWindow]) {
                     [self grabMouse];
                 }
             }
--=20
2.21.0


