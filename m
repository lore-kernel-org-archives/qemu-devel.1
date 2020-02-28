Return-Path: <SRS0=EIn8=4Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FBB4C3F2D1
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 12:37:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 37DDC24677
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 12:37:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BtKEm3Oo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37DDC24677
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46304 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7etV-0004kp-GD
	for qemu-devel@archiver.kernel.org; Fri, 28 Feb 2020 07:37:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48129)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j7esp-000437-0h
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 07:36:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j7esm-0005VS-Mp
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 07:36:46 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:36529
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j7esm-0005VK-Ic
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 07:36:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582893404;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=FIlmTMpu0TR3Jm42CC0ZHrTElMZFcdsAoFIuBStU0bM=;
 b=BtKEm3Oo31He0Xq0ChSPfD91lYE32wEvVVVX5bCxlY2FbCOl+ceB+kKnHa+g3rpabTByKU
 qvtgkz11yN8B9miJ5l197S3xYrgW1cnb+fibc9nnxU8z9TQTgFZXsbGcRPtYFfCIEI9yPf
 PyDUqhcBqwlFbEsTKY46zNNf77PMvkU=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-107-0rGoLUcFOmST9s52sO7CNw-1; Fri, 28 Feb 2020 07:36:42 -0500
X-MC-Unique: 0rGoLUcFOmST9s52sO7CNw-1
Received: by mail-wm1-f69.google.com with SMTP id c5so1091613wmd.8
 for <qemu-devel@nongnu.org>; Fri, 28 Feb 2020 04:36:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=ui2X/d9KJvnejpVIJRlUZq/jpmWowgwNnjLdKR9edYk=;
 b=NLVMyfWpqc93ImfRV92in5CN1lBsL1vHRCRHb/r8bWmDrIzbRjRXfBI5QI9IJzqlFU
 metZa0SW5OzVCI1xg8xK63x4Ii8L4PHG0w40+/8SvlruZltx6WDgi1pVD+2erq4tqNYt
 SPAP2MndxY09HCHP0f9n4NrVTkRS1Ttv5iTwp38AiYN2+yjIJG9GRweUZxr4z1no9GR9
 l618JcHPYEO5Fi9QJ5t4sNinFDI4yEdQ37k+pyhb1T/gmgbcNQBbfU2cTgeqcOlDMnou
 8kOXQunOn7b5UH+SpVjoO3+WLoCtMKCvOQffOqprGtR2IbA196QnGwQUIJXgZyURX0Db
 WfKg==
X-Gm-Message-State: APjAAAVxSS93AjGauIThEuDNIjPgGIHFl1UbC8gwkVx1d7iA7OwgfHPA
 obJqkW6Db1H3iZMsrQ0TjqH5gVtuafBSCWkvPOfWaZt3onmCtqf9/y2vycwNu+ClBvyPiIMg35L
 jFv8+25Kc3/42eM4=
X-Received: by 2002:a05:600c:34d:: with SMTP id
 u13mr4767675wmd.77.1582893401141; 
 Fri, 28 Feb 2020 04:36:41 -0800 (PST)
X-Google-Smtp-Source: APXvYqyH9w9R1EfBb7gx62CPkXsPJGhW+QUb0FJZX6k84o0bpSaaMRTVkDvWwWncpDj+9faUVbshng==
X-Received: by 2002:a05:600c:34d:: with SMTP id
 u13mr4767656wmd.77.1582893400978; 
 Fri, 28 Feb 2020 04:36:40 -0800 (PST)
Received: from x1w.moovbox.local ([185.102.219.36])
 by smtp.gmail.com with ESMTPSA id f11sm2032593wml.3.2020.02.28.04.36.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Feb 2020 04:36:40 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] block: Remove trailing newline in format used by error_report
 API
Date: Fri, 28 Feb 2020 13:36:37 +0100
Message-Id: <20200228123637.15160-1-philmd@redhat.com>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: qemu-trivial@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The error_report API doesn't want trailing newline characters.
Remove it, to avoid and error when moving the code around:

  ERROR: Error messages should not contain newlines

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 block.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block.c b/block.c
index 1bdb9c679d..e466d15914 100644
--- a/block.c
+++ b/block.c
@@ -5994,7 +5994,7 @@ void bdrv_img_create(const char *filename, const char=
 *fmt,
             /* Couldn't open BS, but we have a size, so it's nonfatal */
             warn_reportf_err(local_err,
                             "Could not verify backing image. "
-                            "This may become an error in future versions.\=
n");
+                            "This may become an error in future versions."=
);
             local_err =3D NULL;
         } else if (!bs) {
             /* Couldn't open bs, do not have size */
--=20
2.21.1


