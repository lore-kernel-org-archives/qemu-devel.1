Return-Path: <SRS0=v1sw=4G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FD3FC34034
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 09:56:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1FE7520659
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 09:56:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="biXCmqSM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FE7520659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59592 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j3zbw-00059F-Au
	for qemu-devel@archiver.kernel.org; Tue, 18 Feb 2020 04:56:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43824)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j3zQl-0002Fx-Li
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 04:44:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j3zQk-0006Ax-HR
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 04:44:39 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:29632
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j3zQk-00069p-EE
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 04:44:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582019077;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Xoqi0ftXRFYJhu37T0Dgt5lu+ZSvSZSENltlLvBq3/Y=;
 b=biXCmqSM1IyCcX3tpygHdGOmeaIeWTlZj2LjxFGaHlFeUY7twL74EF3m7tV8seKbeyrS6S
 U9I8uI1BnAqjPZ28EF6Yy1YpSPj+dmnbLtZ9QTtmGrWPBIP/PiYp98dHaf+6TvdWfXOyFw
 FYOkg7K8jgMowVeCXl0Ip+P2rE7BZsk=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-179-9lUM-JYMO-O6-9g4rpOLsQ-1; Tue, 18 Feb 2020 04:44:33 -0500
Received: by mail-wr1-f69.google.com with SMTP id a12so10517422wrn.19
 for <qemu-devel@nongnu.org>; Tue, 18 Feb 2020 01:44:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Ro3XhYqIaHVGzILEuv36nU5CQfCJ3/xXhyZLIOGXLvI=;
 b=rCz6Z4uWxIfOO86MKDc/tWwEbt0yCQvrVwafT01W2BnWLLvaa9UZDZB7mJp2A2fchv
 XysiyEvbQQQuRS+pa1sqoV7/NHUrITKesl0aIG27+ndeIXM58NZ6ZxCyFNV1E9GfYHV+
 ZY4arNYKDop0liIHDWD5TGSHnOkNoRRS9qSfW1G/2Nbc5gLFH4YQ4IxwJd3nB5B+wntu
 s0v/PKtJD3tH4P/QOoe1lD0kvZ7aqnZy80SJXMBlcmKJpfR/Fcay4xQKFH65IroD3rJY
 a/2cD+c4Nkoj2cpFyQ/O7AjpGRuGmYXJmD+I8dqiDoIw7P723Aw5T1r6bTlnDhLPoCdc
 PmZA==
X-Gm-Message-State: APjAAAWf7ZEuPhTokVExQ+MVBpTGmCIeXq8fGVMIAmkCJY0ajmtmVgkx
 /dJu2vKKlKEke2ThJ61oXfTT15FSAqPLSkeuk5kukGmuE9KHGYGBsr5lHmmufTOpg2e4j3PZ2g+
 kt8oca1GNcvR0Bzw=
X-Received: by 2002:adf:ed09:: with SMTP id a9mr28611387wro.350.1582019071983; 
 Tue, 18 Feb 2020 01:44:31 -0800 (PST)
X-Google-Smtp-Source: APXvYqya+zpW/vUmislY11k6LSMsxvRy1DxyMqWM3G2WICj/hpS/OZsN9IvFspogUYDC3vJfiONy9Q==
X-Received: by 2002:adf:ed09:: with SMTP id a9mr28611329wro.350.1582019071762; 
 Tue, 18 Feb 2020 01:44:31 -0800 (PST)
Received: from x1w.redhat.com (78.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.78])
 by smtp.gmail.com with ESMTPSA id z10sm2735588wmk.31.2020.02.18.01.44.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Feb 2020 01:44:31 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH RESEND 13/13] contrib/rdmacm-mux: Remove superfluous semicolon
Date: Tue, 18 Feb 2020 10:44:02 +0100
Message-Id: <20200218094402.26625-14-philmd@redhat.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200218094402.26625-1-philmd@redhat.com>
References: <20200218094402.26625-1-philmd@redhat.com>
MIME-Version: 1.0
X-MC-Unique: 9lUM-JYMO-O6-9g4rpOLsQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
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
Cc: Fam Zheng <fam@euphon.net>, Peter Maydell <peter.maydell@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>, Yuval Shaia <yuval.shaia.ml@gmail.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, qemu-block@nongnu.org,
 Juan Quintela <quintela@redhat.com>, qemu-trivial@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Alistair Francis <alistair@alistair23.me>, Julia Suvorova <jusual@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>, qemu-arm@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>, Aarushi Mehta <mehta.aaru20@gmail.com>,
 Richard Henderson <rth@twiddle.net>, Kevin Wolf <kwolf@redhat.com>,
 Shamir Rabinovitch <shamir.rabinovitch@oracle.com>,
 Thomas Huth <huth@tuxfamily.org>, Laurent Vivier <laurent@vivier.eu>,
 Max Reitz <mreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Luc Michel <luc.michel@greensocs.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Fixes: a5d2f6f8773
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
Cc: Shamir Rabinovitch <shamir.rabinovitch@oracle.com>
---
 contrib/rdmacm-mux/main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/rdmacm-mux/main.c b/contrib/rdmacm-mux/main.c
index de53048f06..bd82abbad3 100644
--- a/contrib/rdmacm-mux/main.c
+++ b/contrib/rdmacm-mux/main.c
@@ -490,7 +490,7 @@ static int read_and_process(int fd)
=20
 static int accept_all(void)
 {
-    int fd, rc =3D 0;;
+    int fd, rc =3D 0;
=20
     pthread_rwlock_wrlock(&server.lock);
=20
--=20
2.21.1


