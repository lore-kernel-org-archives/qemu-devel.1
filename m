Return-Path: <SRS0=+QfZ=VN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFDE9C76195
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2019 08:12:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE26C2145D
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2019 08:12:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G7G7Vr+1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE26C2145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46156 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hnIZv-0004zy-Fb
	for qemu-devel@archiver.kernel.org; Tue, 16 Jul 2019 04:12:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59894)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <paolo.bonzini@gmail.com>) id 1hnIYc-0008AM-6D
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 04:11:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1hnIYa-0003F8-TD
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 04:11:30 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433]:46510)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1hnIYa-0003Dr-Iy
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 04:11:28 -0400
Received: by mail-wr1-x433.google.com with SMTP id z1so19805354wru.13
 for <qemu-devel@nongnu.org>; Tue, 16 Jul 2019 01:11:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Uzf2A9RIPGCOKfkWZQp0qQsgDZ85Q4jENmEVZz/U6uE=;
 b=G7G7Vr+1TGUVJbCd3aYKeTfbPQv/GD4WFbonGf8+VxcKVRTWLSWMvUruKojcl/FM4R
 +qB+VlIqRIG2+Ur0qxVjpTjLrmFwWjPtkhOxvyxJVaA7iC1Svs4pyp/BxgKCQFCT1Lf5
 m8J9Vt69Nr+iMfm/PwGLrvq7PymgQo7RLLHmH33ik77wa/Z8Tn5qrMRe8CUdBiQoHXxl
 V8LtCA1OSVque5vj7Vhiey/MsIBeUTwW1+fURxOwFGb8GMPH3rY3pAIr8mVLmnKE7jxb
 DQ4PUzn7Vf0jchg/HGqpwp7+zRpKR9cPPp45RzhpTf4wMSTHeCjD5drwCKUzvehegbpQ
 c2eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=Uzf2A9RIPGCOKfkWZQp0qQsgDZ85Q4jENmEVZz/U6uE=;
 b=sAwgdrFxfr4aYFmDD6RTXPaFySyvqaYFrzRB4k4EUEUS6fVchff8VnIjDLrp3yMSub
 iLXtwV3cRz3BcioqpmdtfbpgMAPOR6zYfnsyLwH7UqJJydKzNENWJKsD70A2STWa48g5
 /GwOmNC54jf/VhJwMTzBrE3HWuAFJaLlSib85sNy8KqzBGr+EvtxrQYldwW8paA/nGOQ
 4SweZCXDVlZgDz2nPeCRSakSC+tXj9/ANQeQW+aweHMHqPBXLV1Sf65CSjHlA/k016VF
 zuJLMbK0vyNptEB0pCNJd8Q0Jm+Ee+28TI6NmazkZluFU2F/7A2Dx2BWLG4vFhX1GCub
 I56g==
X-Gm-Message-State: APjAAAWQN9FLXm8p2C/X5xYoBFtlXRiOfL7hn6+KFoLgnr72XivnbqlL
 V2tICtnhZ7GaEM2Uu84L2JXxHKkKBio=
X-Google-Smtp-Source: APXvYqwhcLaOnj8WcBudDA4aNk3/isetR7YFIDpEDTjZaEXY5qKLlIVYWuRkNjrdSggUUv6rKEOg5Q==
X-Received: by 2002:adf:c803:: with SMTP id d3mr10741302wrh.130.1563264687081; 
 Tue, 16 Jul 2019 01:11:27 -0700 (PDT)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id c1sm37723879wrh.1.2019.07.16.01.11.26
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 16 Jul 2019 01:11:26 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Date: Tue, 16 Jul 2019 10:11:05 +0200
Message-Id: <1563264677-39718-8-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1563264677-39718-1-git-send-email-pbonzini@redhat.com>
References: <1563264677-39718-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::433
Subject: [Qemu-devel] [PULL 07/19] rdmacm-mux: fix strcpy string warning
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
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Marc-André Lureau <marcandre.lureau@redhat.com>

../contrib/rdmacm-mux/main.c: In function ‘parse_args’:
../contrib/rdmacm-mux/main.c:118:13: error: ‘strncpy’ specified bound 3835 equals destination size [-Werror=stringop-truncation]
  118 |             strncpy(unix_socket_path, optarg, SOCKET_PATH_MAX);

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-Id: <20190712165154.11504-1-marcandre.lureau@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 contrib/rdmacm-mux/main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/rdmacm-mux/main.c b/contrib/rdmacm-mux/main.c
index 30c7052..de53048 100644
--- a/contrib/rdmacm-mux/main.c
+++ b/contrib/rdmacm-mux/main.c
@@ -115,7 +115,7 @@ static void parse_args(int argc, char *argv[])
 
         case 's':
             /* This is temporary, final name will build below */
-            strncpy(unix_socket_path, optarg, SOCKET_PATH_MAX);
+            strncpy(unix_socket_path, optarg, SOCKET_PATH_MAX - 1);
             break;
 
         case 'p':
-- 
1.8.3.1



