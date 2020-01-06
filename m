Return-Path: <SRS0=kvq2=23=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9980C33CA1
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2020 12:56:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A720F20731
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2020 12:56:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LsH5oMmY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A720F20731
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51488 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ioRvq-0006DE-L6
	for qemu-devel@archiver.kernel.org; Mon, 06 Jan 2020 07:56:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58302)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kraxel@redhat.com>) id 1ioRsF-0000rp-8p
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 07:52:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kraxel@redhat.com>) id 1ioRsE-0000sE-7J
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 07:52:47 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:52069
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1ioRsE-0000rY-3r
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 07:52:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578315165;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Te2JijOz57Os2mZyO59E9CRodauE2oIIc487Aq0SD7U=;
 b=LsH5oMmYymX32oWQ+vseGoXxzAZIt/p7mHFaYupIrqw9lo8LoB0QRQBnTkzE5j2p1kl+i8
 f0wAS+fOYOmS4Zr4ZF/cWXRm673X7mRrhilktzXcRsKWY7kUrvoJ6aKHK0emKBFkTsphBf
 XlShdfc8Lcl9WvWL55Rw1/SkZbLhii0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-313-yz8t2z8TMsKeK-oGgtberg-1; Mon, 06 Jan 2020 07:52:42 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5AA9918C8C00;
 Mon,  6 Jan 2020 12:52:41 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-98.ams2.redhat.com
 [10.36.116.98])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 138CF5C21A;
 Mon,  6 Jan 2020 12:52:41 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id B13E031E8E; Mon,  6 Jan 2020 13:52:36 +0100 (CET)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 5/6] paaudio: wait until the recording stream is ready
Date: Mon,  6 Jan 2020 13:52:35 +0100
Message-Id: <20200106125236.24132-6-kraxel@redhat.com>
In-Reply-To: <20200106125236.24132-1-kraxel@redhat.com>
References: <20200106125236.24132-1-kraxel@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: yz8t2z8TMsKeK-oGgtberg-1
X-Mimecast-Spam-Score: 0
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
 Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Volker R=C3=BCmelin <vr_qemu@t-online.de>

Don't call pa_stream_peek before the recording stream is ready.

Information to reproduce the problem.

Start and stop Audacity in the guest several times because the
problem is racy.

libvirt log file:
-audiodev pa,id=3Daudio0,server=3Dlocalhost,out.latency=3D30000,
 out.mixing-engine=3Doff,in.mixing-engine=3Doff \
-sandbox on,obsolete=3Ddeny,elevateprivileges=3Ddeny,spawn=3Ddeny,
 resourcecontrol=3Ddeny \
-msg timestamp=3Don
: Domain id=3D4 is tainted: custom-argv
char device redirected to /dev/pts/1 (label charserial0)
audio: Device pcspk: audiodev default parameter is deprecated,
 please specify audiodev=3Daudio0
audio: Device hda: audiodev default parameter is deprecated,
 please specify audiodev=3Daudio0
pulseaudio: pa_stream_peek failed
pulseaudio: Reason: Bad state
pulseaudio: pa_stream_peek failed
pulseaudio: Reason: Bad state

Signed-off-by: Volker R=C3=BCmelin <vr_qemu@t-online.de>
Message-id: 20200104091122.13971-5-vr_qemu@t-online.de
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 audio/paaudio.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/audio/paaudio.c b/audio/paaudio.c
index b23274550e1c..dbfe48c03a1d 100644
--- a/audio/paaudio.c
+++ b/audio/paaudio.c
@@ -162,6 +162,10 @@ static size_t qpa_read(HWVoiceIn *hw, void *data, size=
_t length)
=20
     CHECK_DEAD_GOTO(c, p->stream, unlock_and_fail,
                     "pa_threaded_mainloop_lock failed\n");
+    if (pa_stream_get_state(p->stream) !=3D PA_STREAM_READY) {
+        /* wait for stream to become ready */
+        goto unlock;
+    }
=20
     while (total < length) {
         size_t l;
@@ -191,6 +195,7 @@ static size_t qpa_read(HWVoiceIn *hw, void *data, size_=
t length)
         }
     }
=20
+unlock:
     pa_threaded_mainloop_unlock(c->mainloop);
     return total;
=20
--=20
2.18.1


