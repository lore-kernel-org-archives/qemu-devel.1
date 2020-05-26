Return-Path: <SRS0=4PQo=7I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EE7CC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 07:57:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E56CE20776
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 07:57:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ST908Tf7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E56CE20776
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33746 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdUT5-0004iD-3v
	for qemu-devel@archiver.kernel.org; Tue, 26 May 2020 03:57:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45084)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jdUSB-0002wb-V3
 for qemu-devel@nongnu.org; Tue, 26 May 2020 03:56:51 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:23250
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jdUSA-0002rf-G4
 for qemu-devel@nongnu.org; Tue, 26 May 2020 03:56:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590479809;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:in-reply-to:in-reply-to:
 references:references; bh=XKjVgjzeHfNNiDkPKkAQa1ppfJfg/MOx2HQs/UenFpQ=;
 b=ST908Tf7UTc1G1z6F611gHUImEsmOvnbeDb1FwxNbG6O9V3PbJYyimkITvlFAL4JaC2h2L
 yMPVI9wz3jVEXAn/9cmh1dbqirCQ7fWROROIrp7JvyveOhqhqX0dXkzk+PsEd/I5FkE2Ti
 vRGQjHFZj+IfHJ+PLs6RiGIGaHTxNTU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-418-6kBLZwY9PcSqOPBNPjShQA-1; Tue, 26 May 2020 03:56:47 -0400
X-MC-Unique: 6kBLZwY9PcSqOPBNPjShQA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A95AE464;
 Tue, 26 May 2020 07:56:46 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-113-50.ams2.redhat.com
 [10.36.113.50])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1BA2360CD0;
 Tue, 26 May 2020 07:56:42 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id E276B1753B; Tue, 26 May 2020 09:56:39 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 1/8] es1370: check total frame count against current frame
Date: Tue, 26 May 2020 09:56:32 +0200
Message-Id: <20200526075639.27949-2-kraxel@redhat.com>
In-Reply-To: <20200526075639.27949-1-kraxel@redhat.com>
References: <20200526075639.27949-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Received-SPF: pass client-ip=205.139.110.120; envelope-from=kraxel@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/26 01:19:28
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Prasad J Pandit <pjp@fedoraproject.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Aurelien Jarno <aurelien@aurel32.net>
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
Message-id: 20200514200608.1744203-1-ppandit@redhat.com
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/audio/es1370.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/hw/audio/es1370.c b/hw/audio/es1370.c
index 89c4dabcd44f..5f8a83ff5624 100644
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
2.18.4


