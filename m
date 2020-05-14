Return-Path: <SRS0=rzeH=64=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B813C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 20:09:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 536E72065F
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 20:09:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iB0TszsM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 536E72065F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52428 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZKA9-0003vw-K7
	for qemu-devel@archiver.kernel.org; Thu, 14 May 2020 16:09:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36040)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1jZK9Y-00033a-QU
 for qemu-devel@nongnu.org; Thu, 14 May 2020 16:08:24 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:27935
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1jZK9X-0001JO-OI
 for qemu-devel@nongnu.org; Thu, 14 May 2020 16:08:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589486902;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=hSXR5jJWOGd/BcvJ8LYhrdnNS7VKoedTsAfIMjZslLo=;
 b=iB0TszsMolNQNPadXxKpZcDnVBbO9cbfBrn9utUWqbemrjYXHhlazbOXWGhVopXfTjrRP9
 LO4UD2YWzPxtI2ZR9dkp6HEuMVINBjdqGiYufMqpC7T/xsJTtdCqCDjlM0qIazP5G48CRZ
 3O0Bad7CQl4eurah1OIXYi04HhZ+aHA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-351-hrkAjoQ4OhCj-PKgQA9mxw-1; Thu, 14 May 2020 16:08:20 -0400
X-MC-Unique: hrkAjoQ4OhCj-PKgQA9mxw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BE6DC474;
 Thu, 14 May 2020 20:08:19 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.40.192.26])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 56CBC1001920;
 Thu, 14 May 2020 20:08:12 +0000 (UTC)
From: P J P <ppandit@redhat.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH] es1370: check total frame count against current frame
Date: Fri, 15 May 2020 01:36:08 +0530
Message-Id: <20200514200608.1744203-1-ppandit@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=ppandit@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/14 12:05:55
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
Cc: Ren Ding <rding@gatech.edu>, QEMU Developers <qemu-devel@nongnu.org>,
 Hanqing Zhao <hanqing@gatech.edu>, Prasad J Pandit <pjp@fedoraproject.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Prasad J Pandit <pjp@fedoraproject.org>

A guest user may set channel frame count via es1370_write()
such that, in es1370_transfer_audio(), total frame count
'size' is lesser than the number of frames that are processed
'cnt'.

    int cnt = d->frame_cnt >> 16;
    int size = d->frame_cnt & 0xffff;

if (size < cnt), it results in incorrect calculations leading
to OOB access issue(s). Add check to avoid it.

Reported-by: Ren Ding <rding@gatech.edu>
Reported-by: Hanqing Zhao <hanqing@gatech.edu>
Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>
---
 hw/audio/es1370.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/hw/audio/es1370.c b/hw/audio/es1370.c
index 89c4dabcd4..5f8a83ff56 100644
--- a/hw/audio/es1370.c
+++ b/hw/audio/es1370.c
@@ -643,6 +643,9 @@ static void es1370_transfer_audio (ES1370State *s, struct chan *d, int loop_sel,
     int csc_bytes = (csc + 1) << d->shift;
     int cnt = d->frame_cnt >> 16;
     int size = d->frame_cnt & 0xffff;
+    if (size < cnt) {
+        return;
+    }
     int left = ((size - cnt + 1) << 2) + d->leftover;
     int transferred = 0;
     int temp = MIN (max, MIN (left, csc_bytes));
@@ -651,7 +654,7 @@ static void es1370_transfer_audio (ES1370State *s, struct chan *d, int loop_sel,
     addr += (cnt << 2) + d->leftover;
 
     if (index == ADC_CHANNEL) {
-        while (temp) {
+        while (temp > 0) {
             int acquired, to_copy;
 
             to_copy = MIN ((size_t) temp, sizeof (tmpbuf));
@@ -669,7 +672,7 @@ static void es1370_transfer_audio (ES1370State *s, struct chan *d, int loop_sel,
     else {
         SWVoiceOut *voice = s->dac_voice[index];
 
-        while (temp) {
+        while (temp > 0) {
             int copied, to_copy;
 
             to_copy = MIN ((size_t) temp, sizeof (tmpbuf));
-- 
2.25.4


