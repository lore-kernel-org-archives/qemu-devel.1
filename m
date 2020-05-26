Return-Path: <SRS0=4PQo=7I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89430C433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 07:59:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 50B2320776
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 07:59:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GK6CzKoy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50B2320776
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42310 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdUV7-0008Aw-HE
	for qemu-devel@archiver.kernel.org; Tue, 26 May 2020 03:59:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45096)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jdUSE-00031u-Iy
 for qemu-devel@nongnu.org; Tue, 26 May 2020 03:56:54 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:59993
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jdUSD-0002sB-Or
 for qemu-devel@nongnu.org; Tue, 26 May 2020 03:56:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590479812;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nAnIFVMBOy0omXP3sWTo/UUsmM8hMwNCz8GOBpVX8+g=;
 b=GK6CzKoyQN05ZA7DuWXkzwWEVDQOEdaxYnHgRwOF9eqffnEFq99LYWO7F11YA119Q8dkRb
 dt29si0++AdH+WV25c4WfihkVpfNrnOam0Yok8UMQ0tW7qbHfYoeaz8g1xJz948CRoeR0H
 2lvCVdN2yXz/ea20gEWLgbp28vYqfkI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-278-oZZMjt7DMzm9A91HeOg_zQ-1; Tue, 26 May 2020 03:56:48 -0400
X-MC-Unique: oZZMjt7DMzm9A91HeOg_zQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 97AD918C35A0;
 Tue, 26 May 2020 07:56:47 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-113-50.ams2.redhat.com
 [10.36.113.50])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 38E675C1BB;
 Tue, 26 May 2020 07:56:47 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 37EC59D56; Tue, 26 May 2020 09:56:40 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 7/8] audio: Let capture_callback handler use const buffer
 argument
Date: Tue, 26 May 2020 09:56:38 +0200
Message-Id: <20200526075639.27949-8-kraxel@redhat.com>
In-Reply-To: <20200526075639.27949-1-kraxel@redhat.com>
References: <20200526075639.27949-1-kraxel@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/26 01:14:47
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

The buffer is the captured input to pass to backends.
As we should not modify it, mark the argument const.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Message-Id: <20200505132603.8575-3-f4bug@amsat.org>
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 audio/audio.h      | 2 +-
 audio/wavcapture.c | 2 +-
 ui/vnc.c           | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/audio/audio.h b/audio/audio.h
index f27a12298fe5..b883ebfb1f8e 100644
--- a/audio/audio.h
+++ b/audio/audio.h
@@ -60,7 +60,7 @@ typedef enum {
 
 struct audio_capture_ops {
     void (*notify) (void *opaque, audcnotification_e cmd);
-    void (*capture) (void *opaque, void *buf, int size);
+    void (*capture) (void *opaque, const void *buf, int size);
     void (*destroy) (void *opaque);
 };
 
diff --git a/audio/wavcapture.c b/audio/wavcapture.c
index 8d7ce2eda145..17e87ed6f45e 100644
--- a/audio/wavcapture.c
+++ b/audio/wavcapture.c
@@ -71,7 +71,7 @@ static void wav_destroy (void *opaque)
     g_free (wav->path);
 }
 
-static void wav_capture (void *opaque, void *buf, int size)
+static void wav_capture(void *opaque, const void *buf, int size)
 {
     WAVState *wav = opaque;
 
diff --git a/ui/vnc.c b/ui/vnc.c
index 1d7138a3a073..12a12714e129 100644
--- a/ui/vnc.c
+++ b/ui/vnc.c
@@ -1177,7 +1177,7 @@ static void audio_capture_destroy(void *opaque)
 {
 }
 
-static void audio_capture(void *opaque, void *buf, int size)
+static void audio_capture(void *opaque, const void *buf, int size)
 {
     VncState *vs = opaque;
 
-- 
2.18.4


