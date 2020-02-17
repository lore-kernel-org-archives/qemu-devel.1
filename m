Return-Path: <SRS0=CnYV=4F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 811AAC7619F
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 09:43:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5175F206F4
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 09:43:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z03rmNOa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5175F206F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42665 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j3cwE-0003w5-E9
	for qemu-devel@archiver.kernel.org; Mon, 17 Feb 2020 04:43:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53903)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j3cvR-0002Qn-VF
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 04:42:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j3cvQ-000450-Se
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 04:42:49 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:47687
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j3cvQ-000430-PP
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 04:42:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581932567;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fSHAaR1gXXH5k9LwDaCpBNS4L+tDUAamhwQ4C2uJFaQ=;
 b=Z03rmNOayFlgT6IOO52CgYvvEQG/MeopzNaHAnsQSQYA4bHN+6lyQBcwYKhKyTFBGTP8YW
 5fvV524ipIS1oYckTmh7u/ZbS6hQjCMc8jwg0sgd3mYEMAiacftacj/1D3EcLDICvp0Wmd
 f5lvrwUGAF1sa+XHoHaTydpAeU8jE4k=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-281-me0OdVfJODKFYx8Sa1p-Tg-1; Mon, 17 Feb 2020 04:42:46 -0500
Received: by mail-wm1-f70.google.com with SMTP id u11so5993579wmb.4
 for <qemu-devel@nongnu.org>; Mon, 17 Feb 2020 01:42:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Lmx88FjCexpm4lMxL/UVZWV2Q83uqv/LDyi8iNcgg/g=;
 b=erJer01R73VpkXRcySl6tidoxt4AWYivVh/e09X+/mN8H8AJBWocB58WJJuVoh8U+C
 WFmpeIMyCx2a6qxokgCDJ4RuxsWXq/XwpuR3JsPAroOUyKYK0MGYUA/o2qax74UDadcd
 TAblT52f1ktLbYQtknbDYdivpZ2VSoqY/e48Ws0VjplG8eBDfqjmZo3pZaGDTYn6WZ93
 mwmEaLbxU7EgJWFF3weuPEtrB64aA1KKJQre6C2hZVhRv+zzvSa5jADrM49bNuitiurQ
 JrClPdEyxlKTnx4fArZWoCp35qAvk3I1b7x6K3qde8v6LL3Z9eBDFBEyDYaj6xl/jEB6
 Ac5g==
X-Gm-Message-State: APjAAAVIVjKxq65en/EbgUTpHW0bdmxQv4xD0dt9n2zNJSRhDs3NX/uU
 fPWEteiLaVTTwjdZNnocjcMGZ/MOZzVQFufUmSSMV7Hv90aviL12r5s8wJ38sMkuY/QZ9h9R+BK
 Vftb/6l1+c474TsE=
X-Received: by 2002:a5d:4a91:: with SMTP id o17mr20181636wrq.232.1581932564827; 
 Mon, 17 Feb 2020 01:42:44 -0800 (PST)
X-Google-Smtp-Source: APXvYqzGXM+zWMFzZzJ2Y57mzZo7hdo8ksdlAfktwUO7UPOq8q/9JfAsLuQhwdPE+NqjZiGoT0YriA==
X-Received: by 2002:a5d:4a91:: with SMTP id o17mr20181616wrq.232.1581932564604; 
 Mon, 17 Feb 2020 01:42:44 -0800 (PST)
Received: from x1w.redhat.com (78.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.78])
 by smtp.gmail.com with ESMTPSA id t187sm17789442wmt.25.2020.02.17.01.42.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Feb 2020 01:42:44 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 2/3] tools/virtiofsd/passthrough_ll: Remove unneeded
 variable assignment
Date: Mon, 17 Feb 2020 10:42:39 +0100
Message-Id: <20200217094240.9927-3-philmd@redhat.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200217094240.9927-1-philmd@redhat.com>
References: <20200217094240.9927-1-philmd@redhat.com>
MIME-Version: 1.0
X-MC-Unique: me0OdVfJODKFYx8Sa1p-Tg-1
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 =?UTF-8?q?J=C3=A1n=20Tomko?= <jtomko@redhat.com>,
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
v2: do not set newfd, use it (jtomko)
---
 tools/virtiofsd/passthrough_ll.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/tools/virtiofsd/passthrough_ll.c b/tools/virtiofsd/passthrough=
_ll.c
index e9e71d5fc2..02ff01fad0 100644
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
@@ -939,7 +938,6 @@ static int lo_do_lookup(fuse_req_t req, fuse_ino_t pare=
nt, const char *name,
=20
         inode->nlookup =3D 1;
         inode->fd =3D newfd;
-        newfd =3D -1;
         inode->key.ino =3D e->attr.st_ino;
         inode->key.dev =3D e->attr.st_dev;
         pthread_mutex_init(&inode->plock_mutex, NULL);
--=20
2.21.1


