Return-Path: <SRS0=EwQe=57=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B7E7C2BB1D
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2020 03:31:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 131C120774
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2020 03:31:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=smartx-com.20150623.gappssmtp.com header.i=@smartx-com.20150623.gappssmtp.com header.b="rhvuh+n0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 131C120774
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=smartx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42286 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jOYm2-0000EB-8s
	for qemu-devel@archiver.kernel.org; Tue, 14 Apr 2020 23:31:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47553)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <fengli@smartx.com>) id 1jOYij-0003vX-4g
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 23:28:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <fengli@smartx.com>) id 1jOYii-0003VR-7a
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 23:28:13 -0400
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643]:45653)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <fengli@smartx.com>) id 1jOYii-0003VB-1m
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 23:28:12 -0400
Received: by mail-pl1-x643.google.com with SMTP id t4so733822plq.12
 for <qemu-devel@nongnu.org>; Tue, 14 Apr 2020 20:28:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:from:to:cc:subject:date:message-id:in-reply-to
 :references:content-transfer-encoding;
 bh=7QrF3lqnF8J6N38bFem6LFl6ts/NWaHVdZgVmsDDT/8=;
 b=rhvuh+n0LI9F/aDAXM7keiZ++BeWK0sIaxx3ZNxVaMPMdxIEhH2o8np7hw4V9riKxB
 TiHUV8N3yOxzX0LwYQnlnLks8y/5usVAG4R5lAn4M7q0Dc9bNmvKZ/38w3x/l6ui0Vbn
 iZ4caRLh64BVaY9CiW8fIah8cjmKvE399fZWqHcwgsN4jn/bUOLqisjqsE0cbBD1gddG
 LKmpxSJsEcsScAvEtO9YyZaPKOYDpIEnWjy0UYchi/pFw6Jz6oFuc5IXG1F70kztbEfl
 f6BbUNQ9JFvVwXPy6sgxMonRzBfcHiDbyTzUSBezFwDFgV4xfWHBZ7bveVhWUnfTYZ5Y
 o2Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :in-reply-to:references:content-transfer-encoding;
 bh=7QrF3lqnF8J6N38bFem6LFl6ts/NWaHVdZgVmsDDT/8=;
 b=uFbwqw2AqReGCDtCoIF3eBRoIIJLJAZvV5YNOJWVNnHHbrBUXRTAMPYaH59Hhs2PbM
 PhaCGRnqz3qt/7Ewe/j0L/xTnvKZ3RCSQar/Ew318urmDhn+1Ta8ek0VGc428rawMs80
 Y1r919Q1k6tKnsYxdgtMcYJRkHWd+8phi5VwoCtKsBcv6UffcGwqL391rLr1d49VFcBM
 P0JdxljnObFv/Flos36614WoItiLZJ3OM5nPF8NfJIg84xxY73SahlFuHvSePukIchzx
 ptkcUK7wTaPpt3MAzq9G/D+V92VX2AeXfn8iZYYXxXTk6nTUy8rvBnghgDVYbni2dXrn
 o1RA==
MIME-Version: 1.0
X-Gm-Message-State: AGi0Pubmm5XQS5Kxm4CJKWytM/72SztuXIAlEvsd7u+KHkkww0CeDav0
 ODlLafko9I7XcDkeqIozeITsdYZkOah2YakfgqWTWf2hJ04JeAg8RogmBeYEJUSZCPt/6AKEpNf
 mbb/FYrZL
X-Google-Smtp-Source: APiQypL8yMIrHuYc6CsLq+cP2DLYGggxNSzC/75KshAyFMXdrb3tkk/9D5J+5AWxBAtxN4awGDwxpA==
X-Received: by 2002:a17:90a:fe8:: with SMTP id 95mr3815506pjz.45.1586921290457; 
 Tue, 14 Apr 2020 20:28:10 -0700 (PDT)
Received: from 31_216.localdomain ([47.240.167.159])
 by smtp.gmail.com with ESMTPSA id d21sm5915061pjs.3.2020.04.14.20.28.08
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 14 Apr 2020 20:28:10 -0700 (PDT)
From: Li Feng <fengli@smartx.com>
To: kyle@smartx.com,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 qemu-devel@nongnu.org (open list:All patches CC here)
Subject: [PATCH 3/4] char-socket: avoid double call tcp_chr_free_connection
Date: Wed, 15 Apr 2020 11:28:25 +0800
Message-Id: <20200415032826.16701-4-fengli@smartx.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20200415032826.16701-1-fengli@smartx.com>
References: <20200415032826.16701-1-fengli@smartx.com>
Content-Type: text/plain; charset="GB2312"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::643
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
Cc: Li Feng <fengli@smartx.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

double call tcp_chr_free_connection generates a crash.

Signed-off-by: Li Feng <fengli@smartx.com>
---
 chardev/char-socket.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/chardev/char-socket.c b/chardev/char-socket.c
index 185fe38dda..43aab8f24b 100644
--- a/chardev/char-socket.c
+++ b/chardev/char-socket.c
@@ -476,6 +476,11 @@ static void tcp_chr_disconnect_locked(Chardev *chr)
     SocketChardev *s =3D SOCKET_CHARDEV(chr);
     bool emit_close =3D s->state =3D=3D TCP_CHARDEV_STATE_CONNECTED;
=20
+    /* avoid re-enter when socket read/write error and disconnect event. *=
/
+    if (s->state =3D=3D TCP_CHARDEV_STATE_DISCONNECTED) {
+        return;
+    }
+
     tcp_chr_free_connection(chr);
=20
     if (s->listener) {
--=20
2.11.0


--=20
The SmartX email address is only for business purpose. Any sent message=20
that is not related to the business is not authorized or permitted by=20
SmartX.
=B1=BE=D3=CA=CF=E4=CE=AA=B1=B1=BE=A9=D6=BE=C1=E8=BA=A3=C4=C9=BF=C6=BC=BC=D3=
=D0=CF=DE=B9=AB=CB=BE=A3=A8SmartX=A3=A9=B9=A4=D7=F7=D3=CA=CF=E4. =C8=E7=B1=
=BE=D3=CA=CF=E4=B7=A2=B3=F6=B5=C4=D3=CA=BC=FE=D3=EB=B9=A4=D7=F7=CE=DE=B9=D8=
,=B8=C3=D3=CA=BC=FE=CE=B4=B5=C3=B5=BD=B1=BE=B9=AB=CB=BE=C8=CE=BA=CE=B5=C4=
=C3=F7=CA=BE=BB=F2=C4=AC=CA=BE=B5=C4=CA=DA=C8=A8.



