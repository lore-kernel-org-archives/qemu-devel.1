Return-Path: <SRS0=ZkAM=AH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74618C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 16:51:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 40355206BE
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 16:51:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D2npcwkr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40355206BE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33880 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jorZy-0004QD-BE
	for qemu-devel@archiver.kernel.org; Fri, 26 Jun 2020 12:51:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58098)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dinechin@redhat.com>)
 id 1jorSA-0006MH-7x
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 12:43:51 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:31998
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dinechin@redhat.com>)
 id 1jorS6-00071t-LE
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 12:43:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593189826;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kUK4reOFVx7Y6uLGGUzuxOqez+MxH7/jHg5WH/q9hGI=;
 b=D2npcwkr1q+vSYmX82wPBaeG+tkGGdF6LO+dc2fJ8lGfT9ILTU1ZMOVnXGrU7/OrIC/r9e
 xsBB6HdPmArOvPMfRRHsSgJxg3bYvDXbjzJo9iMAG9YKUerAImpSAFRkpKmErUJPcvhm8e
 teV1Dq5RXgDOWZFVuCby89tTLwwwYrA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-445-T-VK_PluMkiXUddw8QrRMw-1; Fri, 26 Jun 2020 12:43:42 -0400
X-MC-Unique: T-VK_PluMkiXUddw8QrRMw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5FEBF8064AE;
 Fri, 26 Jun 2020 16:43:40 +0000 (UTC)
Received: from turbo.com (ovpn-112-91.ams2.redhat.com [10.36.112.91])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DCC435C1BB;
 Fri, 26 Jun 2020 16:43:28 +0000 (UTC)
From: Christophe de Dinechin <dinechin@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 04/10] spice: Move all the spice-related code in spice-app.so
Date: Fri, 26 Jun 2020 18:43:01 +0200
Message-Id: <20200626164307.3327380-5-dinechin@redhat.com>
In-Reply-To: <20200626164307.3327380-1-dinechin@redhat.com>
References: <20200626164307.3327380-1-dinechin@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=dinechin@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/26 03:23:21
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: Eduardo Habkost <ehabkost@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-trivial@nongnu.org,
 Cleber Rosa <crosa@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>,
 Laurent Vivier <laurent@vivier.eu>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

If we want to build spice as a separately loadable module, we need to
put all the spice code in one loadable module, because the build
system does not know how to deal with dependencies yet.

Signed-off-by: Christophe de Dinechin <dinechin@redhat.com>
---
 audio/Makefile.objs   | 2 +-
 chardev/Makefile.objs | 3 +--
 ui/Makefile.objs      | 8 ++++----
 3 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/audio/Makefile.objs b/audio/Makefile.objs
index b4a4c11f31..298c895ff5 100644
--- a/audio/Makefile.objs
+++ b/audio/Makefile.objs
@@ -1,5 +1,5 @@
 common-obj-y = audio.o audio_legacy.o noaudio.o wavaudio.o mixeng.o
-common-obj-$(CONFIG_SPICE) += spiceaudio.o
+spice-app.mo-objs += ../audio/spiceaudio.o
 common-obj-$(CONFIG_AUDIO_COREAUDIO) += coreaudio.o
 common-obj-$(CONFIG_AUDIO_DSOUND) += dsoundaudio.o
 common-obj-$(CONFIG_AUDIO_WIN_INT) += audio_win_int.o
diff --git a/chardev/Makefile.objs b/chardev/Makefile.objs
index fc9910d4f2..955fac0cf9 100644
--- a/chardev/Makefile.objs
+++ b/chardev/Makefile.objs
@@ -22,5 +22,4 @@ common-obj-$(CONFIG_BRLAPI) += baum.o
 baum.o-cflags := $(SDL_CFLAGS)
 baum.o-libs := $(BRLAPI_LIBS)
 
-common-obj-$(CONFIG_SPICE) += spice.mo
-spice.mo-objs := spice.o
+spice-app.mo-objs += ../chardev/spice.o
diff --git a/ui/Makefile.objs b/ui/Makefile.objs
index 504b196479..1ab515e23d 100644
--- a/ui/Makefile.objs
+++ b/ui/Makefile.objs
@@ -11,7 +11,6 @@ common-obj-y += keymaps.o console.o cursor.o qemu-pixman.o
 common-obj-y += input.o input-keymap.o input-legacy.o kbd-state.o
 common-obj-y += input-barrier.o
 common-obj-$(CONFIG_LINUX) += input-linux.o
-common-obj-$(CONFIG_SPICE) += spice-core.o spice-input.o spice-display.o
 common-obj-$(CONFIG_COCOA) += cocoa.o
 common-obj-$(CONFIG_VNC) += $(vnc-obj-y)
 common-obj-$(call lnot,$(CONFIG_VNC)) += vnc-stubs.o
@@ -53,10 +52,11 @@ curses.mo-objs := curses.o
 curses.mo-cflags := $(CURSES_CFLAGS) $(ICONV_CFLAGS)
 curses.mo-libs := $(CURSES_LIBS) $(ICONV_LIBS)
 
-ifeq ($(CONFIG_GIO)$(CONFIG_SPICE),yy)
-common-obj-$(if $(CONFIG_MODULES),m,y) += spice-app.mo
+common-obj-$(CONFIG_SPICE) += spice-app.mo
+spice-app.mo-objs += spice-core.o spice-input.o spice-display.o
+ifeq ($(CONFIG_GIO)$(CONFIG_SPICE),ym)
+spice-app.mo-objs += spice-app.o
 endif
-spice-app.mo-objs := spice-app.o
 spice-app.mo-cflags := $(GIO_CFLAGS)
 spice-app.mo-libs := $(GIO_LIBS)
 
-- 
2.26.2


