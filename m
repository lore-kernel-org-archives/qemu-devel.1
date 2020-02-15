Return-Path: <SRS0=Sgwn=4D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE124C2BA83
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Feb 2020 16:09:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9727E2083B
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Feb 2020 16:09:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dc8DkIUN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9727E2083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52326 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j300Z-0008F5-QG
	for qemu-devel@archiver.kernel.org; Sat, 15 Feb 2020 11:09:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46953)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j2zye-0004da-7h
 for qemu-devel@nongnu.org; Sat, 15 Feb 2020 11:07:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j2zyd-0001Pt-9A
 for qemu-devel@nongnu.org; Sat, 15 Feb 2020 11:07:32 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:48410
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j2zyd-0001P9-5D
 for qemu-devel@nongnu.org; Sat, 15 Feb 2020 11:07:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581782848;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bKQaDu+Pxo8HkKDct+RYKqIHdUOrJxHSe3xvMAMjwlU=;
 b=dc8DkIUNJRj5WK2kI/aJU67Vw0v524u+KNDAqb29L0zBsx+Of2V7mcCbMy9SmLTsyCTe2V
 eBuXohNdXVEYhyD3oI8XqRv53hWB8xUPw/AiH+t7qOxD+rurBUevlX6tow+gl7gN8uRYfF
 GudBiMAPIQgTjHVYqCq2ugYyzXBDzh4=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-320-Pt7P-SEuPWqMj_9z8M9Pmw-1; Sat, 15 Feb 2020 11:07:23 -0500
Received: by mail-wr1-f70.google.com with SMTP id 90so5909295wrq.6
 for <qemu-devel@nongnu.org>; Sat, 15 Feb 2020 08:07:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=dR3FO8AbsV49vnTIXTFL7LHBNhiT1rIcfLpNSebEqDw=;
 b=A/Cae3t2yQwWnKAJlVWEV2NEo56JA72bsfxIJWhxmz0gArYx66uvnG3I6N94L6NTEs
 uNjGQIFy+DnUKXfVgF8DC7ZIhVxAC+1Gd9D4iH4acMOfaZaJ8sMqZKRI2l9hb7ae57TT
 G8qOg4DzOzxzlMPCyqb2MyjrjiZLbnavsAj6PexH6UqTQ3xsiHfHi4lTv+vHk335PE0X
 +iUEgxCxGuIEvGRFV46yeHM9+5jQgdAJr+AOiH5lOKjw5nYjPKWfhbPxWiEBfCj+NQ19
 8vDb+BiF02zRfbmxAHNOVDRo0fkJmaGjPFTT49fQAXCMjnI5v8Ra4svOTawEtv+hYCnb
 NzXA==
X-Gm-Message-State: APjAAAUBslItDul5CoRda2rCNi+qJzCxH4hHUlPucWnjRUpdGO4jk83i
 afc7COR4Ge+ZaPfHNeuFvmxBD+vOnmjKfpOiKBK26suTq6i4bLGI1CWU1UNXSt/zUuB8G4crARX
 C03fyt/ylfz1eZnw=
X-Received: by 2002:a1c:4383:: with SMTP id q125mr11426740wma.88.1581782841817; 
 Sat, 15 Feb 2020 08:07:21 -0800 (PST)
X-Google-Smtp-Source: APXvYqyPLf67se2pRBLgHpvgNeNOvdjimB4WAYcx6lLZb1YHzgnjxE/DUp92hEFZNR/y05JPDo8m6w==
X-Received: by 2002:a1c:4383:: with SMTP id q125mr11426729wma.88.1581782841664; 
 Sat, 15 Feb 2020 08:07:21 -0800 (PST)
Received: from localhost.localdomain (78.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.78])
 by smtp.gmail.com with ESMTPSA id b18sm12103829wru.50.2020.02.15.08.07.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 15 Feb 2020 08:07:21 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 2/3] tools/virtiofsd/passthrough_ll: Remove unneeded variable
 assignment
Date: Sat, 15 Feb 2020 17:07:15 +0100
Message-Id: <20200215160716.1262-3-philmd@redhat.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200215160716.1262-1-philmd@redhat.com>
References: <20200215160716.1262-1-philmd@redhat.com>
MIME-Version: 1.0
X-MC-Unique: Pt7P-SEuPWqMj_9z8M9Pmw-1
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Fix warning reported by Clang static code analyzer:

    CC      tools/virtiofsd/passthrough_ll.o
  tools/virtiofsd/passthrough_ll.c:925:9: warning: Value stored to 'newfd' =
is never read
          newfd =3D -1;
          ^       ~~
  tools/virtiofsd/passthrough_ll.c:942:9: warning: Value stored to 'newfd' =
is never read
          newfd =3D -1;
          ^       ~~

Fixes: 7c6b66027
Reported-by: Clang Static Analyzer
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 tools/virtiofsd/passthrough_ll.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/tools/virtiofsd/passthrough_ll.c b/tools/virtiofsd/passthrough=
_ll.c
index e9e71d5fc2..b38e0e4d84 100644
--- a/tools/virtiofsd/passthrough_ll.c
+++ b/tools/virtiofsd/passthrough_ll.c
@@ -922,7 +922,6 @@ static int lo_do_lookup(fuse_req_t req, fuse_ino_t pare=
nt, const char *name,
     inode =3D lo_find(lo, &e->attr);
     if (inode) {
         close(newfd);
-        newfd =3D -1;
     } else {
         inode =3D calloc(1, sizeof(struct lo_inode));
         if (!inode) {
@@ -938,8 +937,7 @@ static int lo_do_lookup(fuse_req_t req, fuse_ino_t pare=
nt, const char *name,
         g_atomic_int_set(&inode->refcount, 2);
=20
         inode->nlookup =3D 1;
-        inode->fd =3D newfd;
-        newfd =3D -1;
+        inode->fd =3D -1;
         inode->key.ino =3D e->attr.st_ino;
         inode->key.dev =3D e->attr.st_dev;
         pthread_mutex_init(&inode->plock_mutex, NULL);
--=20
2.21.1


