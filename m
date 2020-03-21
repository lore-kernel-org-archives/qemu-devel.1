Return-Path: <SRS0=wc0w=5G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D238AC4332B
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Mar 2020 12:07:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5523420724
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Mar 2020 12:07:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Pp8jMwCm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5523420724
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36112 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jFcuu-0007BE-E6
	for qemu-devel@archiver.kernel.org; Sat, 21 Mar 2020 08:07:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38733)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jFcu7-0006Py-6h
 for qemu-devel@nongnu.org; Sat, 21 Mar 2020 08:07:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jFcu5-0006Zy-8J
 for qemu-devel@nongnu.org; Sat, 21 Mar 2020 08:07:02 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:23294)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jFcu5-0006ZW-5K
 for qemu-devel@nongnu.org; Sat, 21 Mar 2020 08:07:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584792420;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=zZrhKz3u83FapzjTI2PhSDcr87b8tpaT6o8iRS52yek=;
 b=Pp8jMwCmkKfrJ89F48WtY3DoMhXsubjFCMA5ZVsIk5O0I4klR8lE5nsYpRbkVRM4bXpWAg
 2Tyo4fIQw0AEQimgotwJvPNoOaoQQiZc6JlXEn2i/RunZUmUhq6bYFnW2tJKSU5/phseSW
 B7tjayitoJs23FNFA2x4PS7RVjiOhw4=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-356-stvARVJmPUm70g1z1mLHeQ-1; Sat, 21 Mar 2020 08:06:59 -0400
X-MC-Unique: stvARVJmPUm70g1z1mLHeQ-1
Received: by mail-wr1-f69.google.com with SMTP id v7so4246587wrp.0
 for <qemu-devel@nongnu.org>; Sat, 21 Mar 2020 05:06:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=c+ODi2pX71vXFX/hS6ufzKlC/YUkXmAqowyc+WHVWO4=;
 b=f/97RlWc857/xQpyEXgtkLuNS0zXZS762C3JPiEMkB9+eR2RUxkJnUOzPb7yokZFNB
 t5pY0FwLyFMBwxE1KKOEvJIRSDZJK60DQ32j+nVjdAppjynK2hDp1t2kmRAZ5jFN2yJj
 Qr6DeThh+7FaHfAswV3xS5jNSIr57AY532lEJcxCjSecY+GIEQRKOfEVdqZJuseEV5Oc
 haeZNDYYP3RXJSpPcI2ot80tlppoqE4o52MdzIKQ7AUA/wopDi17XF7FD06Bo6th5Bud
 U7LXwFF1DSoHOeftTQWaXHxf98fgMyuCwuYWSkM/gAZP5Kbsw5QZEl9kJJ3nkI3/vPEh
 36Bg==
X-Gm-Message-State: ANhLgQ0k9sVd7X5IYNI1wYzTRCTttR3wnDwQtYEavXhe7UX3X83ZlaVe
 83O2kNVGDYpd82a382E8v3w39syF5e/qcuWLuvmRrYvuhbswxI9qMLXCUzxlU18peNGVTLWCqE8
 EtDaUwqKZ+b8bwhY=
X-Received: by 2002:a1c:a78a:: with SMTP id
 q132mr16043930wme.107.1584792417713; 
 Sat, 21 Mar 2020 05:06:57 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vsH41NaM0XzEQGhJDWy4Q640I+hQ1/eupWIfpECtSG65DE5nmbN83S3haqU5r7+Tdw381Q71A==
X-Received: by 2002:a1c:a78a:: with SMTP id
 q132mr16043906wme.107.1584792417354; 
 Sat, 21 Mar 2020 05:06:57 -0700 (PDT)
Received: from localhost.localdomain (37.red-83-52-54.dynamicip.rima-tde.net.
 [83.52.54.37])
 by smtp.gmail.com with ESMTPSA id u5sm5450516wrp.81.2020.03.21.05.06.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 21 Mar 2020 05:06:56 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH-for-5.0] tools/virtiofsd/passthrough_ll: Fix double close()
Date: Sat, 21 Mar 2020 13:06:54 +0100
Message-Id: <20200321120654.7985-1-philmd@redhat.com>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 63.128.21.74
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, qemu-stable@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On success, the fdopendir() call closes fd. Later on the error
path we try to close an already-closed fd. This can lead to
use-after-free. Fix by only closing the fd if the fdopendir()
call failed.

Cc: qemu-stable@nongnu.org
Fixes: 7c6b66027 (Import passthrough_ll from libfuse fuse-3.8.0)
Reported-by: Coverity (CID 1421933 USE_AFTER_FREE)
Suggested-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 tools/virtiofsd/passthrough_ll.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/tools/virtiofsd/passthrough_ll.c b/tools/virtiofsd/passthrough=
_ll.c
index 4f259aac70..4c35c95b25 100644
--- a/tools/virtiofsd/passthrough_ll.c
+++ b/tools/virtiofsd/passthrough_ll.c
@@ -1520,8 +1520,7 @@ out_err:
     if (d) {
         if (d->dp) {
             closedir(d->dp);
-        }
-        if (fd !=3D -1) {
+        } else if (fd !=3D -1) {
             close(fd);
         }
         free(d);
--=20
2.21.1


