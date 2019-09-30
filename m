Return-Path: <SRS0=LaQQ=XZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 689D1C32792
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2019 20:51:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2FF6F224FE
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2019 20:51:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r+9j5fBp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FF6F224FE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57186 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iF2dY-0006Pc-8b
	for qemu-devel@archiver.kernel.org; Mon, 30 Sep 2019 16:51:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45799)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dirty.ice.hu@gmail.com>) id 1iF2Hg-00043S-AQ
 for qemu-devel@nongnu.org; Mon, 30 Sep 2019 16:28:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dirty.ice.hu@gmail.com>) id 1iF2Hf-0002bY-0n
 for qemu-devel@nongnu.org; Mon, 30 Sep 2019 16:28:40 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:51246)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <dirty.ice.hu@gmail.com>)
 id 1iF2He-0002ah-Nv
 for qemu-devel@nongnu.org; Mon, 30 Sep 2019 16:28:38 -0400
Received: by mail-wm1-x344.google.com with SMTP id 7so874237wme.1
 for <qemu-devel@nongnu.org>; Mon, 30 Sep 2019 13:28:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=csUz3G+oANfAghQDvskgbpzawb3MHELRqPU8L59Mp1o=;
 b=r+9j5fBpxg2iXZ/pwK5GGJgBTHSX9ohZZLZwfrphP5xJ99fWoYD4Qj+dvNFyh7oeJa
 2gHRZ8+RDzLHJipaTtbwbACjWlLBnHA7KHrvyN+klV+tEHPAWMpjx/ztvjwDVYNb5R0M
 hPRmVrdDVXPr1OlFaNO+VUlg2amIXA5KJCO5bqD7ZbZ8Wp2ei7TLac3UslzOmQc5y1Wh
 NfH278NNjV3ZXrWKgQswOTr+W18nwtJA2P9nhd7cckzs0/qD1lUcBO0jsJw1FheY8w6R
 0zYMNBZfohGxpyQuUFm5uf4kZfCr/sKOauJSij021pVTGk1xSzxJJoLzO2ldIAplIOUS
 pV8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=csUz3G+oANfAghQDvskgbpzawb3MHELRqPU8L59Mp1o=;
 b=PDVYRf4TPJqdzWvn268lU8dqmPEo2F3akQPVO5RdEhepx2njGdlqkH+g8s0DhTT1dn
 9cna6l2xI/N77+KdMOLrJt4Gdt76GXSARTxPub/3tnv8hZ/e19I6H0IpFrjHiZsoFmVm
 6wIfqJKNkD9NrDmWFhdqjSdNpO9Pjj9sePrwer2n+fhkN8SiCdNXOpDJY/iqA/mgCITB
 ++XmYb/1KFTNRBHcHDNYypBgyONmZmYiN7flJmUfwyeF83M+/TIm/v/7Jyr+6KK9geBv
 xQbeaKOMVDHkhbP0MpXxHiFYyUwkYuCuJJpPdFQrkDXlANvqlXNH00YFDIwEbdSC0yp8
 TLDA==
X-Gm-Message-State: APjAAAV//+hnrz8QLgEn+zV2TBTaNHKJ+sYSrwAWaXjImdMDKk4D8Tah
 SlOcc1npb//67kbk1p3GIT8Amxmi
X-Google-Smtp-Source: APXvYqwj2MLAWGG5qz0BviLXevTshuUWdIf+8rgrkIimcTbAQD7rAiT2RlpN8qm0JvX7dYKji7kHOg==
X-Received: by 2002:a05:600c:2059:: with SMTP id
 p25mr800019wmg.50.1569875317622; 
 Mon, 30 Sep 2019 13:28:37 -0700 (PDT)
Received: from nullptr.home.dirty-ice.org
 (2a01-036c-0113-e8f4-0000-0000-0000-0005.pool6.digikabel.hu.
 [2a01:36c:113:e8f4::5])
 by smtp.gmail.com with ESMTPSA id o9sm34402911wrh.46.2019.09.30.13.28.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Sep 2019 13:28:37 -0700 (PDT)
From: "=?UTF-8?q?K=C5=91v=C3=A1g=C3=B3=2C=20Zolt=C3=A1n?="
 <dirty.ice.hu@gmail.com>
X-Google-Original-From: =?UTF-8?q?K=C5=91v=C3=A1g=C3=B3=2C=20Zolt=C3=A1n?=
 <DirtY.iCE.hu@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 09/10] usbaudio: change playback counters to 64 bit
Date: Mon, 30 Sep 2019 22:29:02 +0200
Message-Id: <2c3ce2e69a1be1ff362dca8d6c8f5aa6d228382c.1569874641.git.DirtY.iCE.hu@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <cover.1569874641.git.DirtY.iCE.hu@gmail.com>
References: <cover.1569874641.git.DirtY.iCE.hu@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::344
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
Cc: Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

With stereo playback, they need about 375 minutes of continuous audio
playback to overflow, which is usually not a problem (as stopping and
later resuming playback resets the counters).  But with 7.1 audio, they
only need about 95 minutes to overflow.

After the overflow, the buf->prod % USBAUDIO_PACKET_SIZE(channels)
assertion no longer holds true, which will result in overflowing the
buffer.  With 64 bit variables, it would take about 762000 years to
overflow.

Signed-off-by: Kővágó, Zoltán <DirtY.iCE.hu@gmail.com>
---
 hw/usb/dev-audio.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/hw/usb/dev-audio.c b/hw/usb/dev-audio.c
index e42bdfbdc1..ea604bbb8e 100644
--- a/hw/usb/dev-audio.c
+++ b/hw/usb/dev-audio.c
@@ -578,9 +578,9 @@ static const USBDesc desc_audio_multi = {
 
 struct streambuf {
     uint8_t *data;
-    uint32_t size;
-    uint32_t prod;
-    uint32_t cons;
+    size_t size;
+    uint64_t prod;
+    uint64_t cons;
 };
 
 static void streambuf_init(struct streambuf *buf, uint32_t size,
@@ -601,7 +601,7 @@ static void streambuf_fini(struct streambuf *buf)
 
 static int streambuf_put(struct streambuf *buf, USBPacket *p, uint32_t channels)
 {
-    uint32_t free = buf->size - (buf->prod - buf->cons);
+    int64_t free = buf->size - (buf->prod - buf->cons);
 
     if (free < USBAUDIO_PACKET_SIZE(channels)) {
         return 0;
@@ -610,6 +610,8 @@ static int streambuf_put(struct streambuf *buf, USBPacket *p, uint32_t channels)
         return 0;
     }
 
+    /* can happen if prod overflows */
+    assert(buf->prod % USBAUDIO_PACKET_SIZE(channels) == 0);
     usb_packet_copy(p, buf->data + (buf->prod % buf->size),
                     USBAUDIO_PACKET_SIZE(channels));
     buf->prod += USBAUDIO_PACKET_SIZE(channels);
@@ -618,10 +620,10 @@ static int streambuf_put(struct streambuf *buf, USBPacket *p, uint32_t channels)
 
 static uint8_t *streambuf_get(struct streambuf *buf, size_t *len)
 {
-    uint32_t used = buf->prod - buf->cons;
+    int64_t used = buf->prod - buf->cons;
     uint8_t *data;
 
-    if (!used) {
+    if (used <= 0) {
         *len = 0;
         return NULL;
     }
-- 
2.23.0


