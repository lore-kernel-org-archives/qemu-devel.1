Return-Path: <SRS0=v1sw=4G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82AF2C34026
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 09:48:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4578D2070B
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 09:48:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FBuP2m39"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4578D2070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59322 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j3zU2-0006rK-8d
	for qemu-devel@archiver.kernel.org; Tue, 18 Feb 2020 04:48:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43209)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j3zQM-00014d-9f
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 04:44:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j3zQL-0005pg-9T
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 04:44:14 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:28587
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j3zQL-0005pF-5m
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 04:44:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582019052;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZU7fveF1nmznN+St3KEHVmWeNf346k9KkwUIERJBNlc=;
 b=FBuP2m39Ei0u5yezOGWskeu39oWChFC0pyaj2rfFkmB/w3/gu6MaCBGvA1g8wJTuB3Wn9L
 5bkE+jmN1SVmm7b1zR6Q+dLjp34l452wqTJFEYxcxJqmpPbiRu8kxSD8MB2PdifvKeD7mv
 A8x+hnVpW+gV6YNH9QTXIBxPrlFUjFs=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-384-mthIcPaDMA6RRZQSUAqd6g-1; Tue, 18 Feb 2020 04:44:11 -0500
Received: by mail-wm1-f72.google.com with SMTP id g138so230410wmg.8
 for <qemu-devel@nongnu.org>; Tue, 18 Feb 2020 01:44:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ajGEvpxvLQVL8Fd5Rt9Hd36QOTmv1kRHcUMcc2d9U3U=;
 b=JNI94fDYuhyn6q8Wzaufgw+vZoWwRW4DKNbPnvbXlzIA45CffBMUi6gdWsU6W2O3Tn
 y0/Ld8ztzLMOD7L7tnRYlgqzMf3MShOTsz8Tf1ak0weAFzDPPXIuXGBfPxUX27nYl8/r
 y8wuRSTMlFinLvAst8E2NCUBtvYDaY8ZE8PK2BoRl1S9gJ9793Jph6uhXJD2I605tmyq
 2dQKaDVksXr6VBoLHzsRnARF/apQy+pzwyKQ1T3gYMA1j6rYyn6X3I82QAX9BMxlxuMy
 v0K21YmCwcucBvPqtyWiyGfJaFEBcjJa22C9eCdp4o//wf3KtEI6UDF1YMf6JFi9suTB
 JkTA==
X-Gm-Message-State: APjAAAVnHxVmHqQS+2fCH8c4+wY8YMCSW8YDoY2Sb7xV0wac/zLiCWqX
 hx/tLkrf0NkIsgQWxmHHg8hkFyqrLUXyrTLkN5khYzqTW47xPoUSvMRtysD16Ci0kqH6EtwA9wE
 wXc3dkOK4yLKkJRE=
X-Received: by 2002:a7b:c119:: with SMTP id w25mr2205619wmi.116.1582019049853; 
 Tue, 18 Feb 2020 01:44:09 -0800 (PST)
X-Google-Smtp-Source: APXvYqwB3rGLxQZLgg+OP0hNSeyQWsU6nFZjDKtPoOMnFmWEI1CmOX2tYvfjrMRtNoIZv/SUqeisfQ==
X-Received: by 2002:a7b:c119:: with SMTP id w25mr2205584wmi.116.1582019049667; 
 Tue, 18 Feb 2020 01:44:09 -0800 (PST)
Received: from x1w.redhat.com (78.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.78])
 by smtp.gmail.com with ESMTPSA id z10sm2735588wmk.31.2020.02.18.01.44.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Feb 2020 01:44:09 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH RESEND 02/13] audio/alsaaudio: Remove superfluous semicolons
Date: Tue, 18 Feb 2020 10:43:51 +0100
Message-Id: <20200218094402.26625-3-philmd@redhat.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200218094402.26625-1-philmd@redhat.com>
References: <20200218094402.26625-1-philmd@redhat.com>
MIME-Version: 1.0
X-MC-Unique: mthIcPaDMA6RRZQSUAqd6g-1
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
Cc: Fam Zheng <fam@euphon.net>, Peter Maydell <peter.maydell@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>, Yuval Shaia <yuval.shaia.ml@gmail.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, qemu-block@nongnu.org,
 Juan Quintela <quintela@redhat.com>, qemu-trivial@nongnu.org,
 =?UTF-8?q?K=C5=91v=C3=A1g=C3=B3=2C=20Zolt=C3=A1n?= <DirtY.iCE.hu@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Alistair Francis <alistair@alistair23.me>, Julia Suvorova <jusual@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>, qemu-arm@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>, Aarushi Mehta <mehta.aaru20@gmail.com>,
 Richard Henderson <rth@twiddle.net>, Kevin Wolf <kwolf@redhat.com>,
 Thomas Huth <huth@tuxfamily.org>, Laurent Vivier <laurent@vivier.eu>,
 Max Reitz <mreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Luc Michel <luc.michel@greensocs.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Fixes: 286a5d201e4
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
Cc: "K=C5=91v=C3=A1g=C3=B3, Zolt=C3=A1n" <DirtY.iCE.hu@gmail.com>
---
 audio/alsaaudio.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/audio/alsaaudio.c b/audio/alsaaudio.c
index a23a5a0b60..a8e62542f9 100644
--- a/audio/alsaaudio.c
+++ b/audio/alsaaudio.c
@@ -819,7 +819,7 @@ static size_t alsa_read(HWVoiceIn *hw, void *buf, size_=
t len)
             switch (nread) {
             case 0:
                 trace_alsa_read_zero(len);
-                return pos;;
+                return pos;
=20
             case -EPIPE:
                 if (alsa_recover(alsa->handle)) {
@@ -835,7 +835,7 @@ static size_t alsa_read(HWVoiceIn *hw, void *buf, size_=
t len)
             default:
                 alsa_logerr(nread, "Failed to read %zu frames to %p\n",
                             len, dst);
-                return pos;;
+                return pos;
             }
         }
=20
--=20
2.21.1


