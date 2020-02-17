Return-Path: <SRS0=CnYV=4F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB8F8C35254
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 09:44:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 95F79206F4
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 09:44:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RsdYhbfj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95F79206F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42680 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j3cxI-0005ll-R0
	for qemu-devel@archiver.kernel.org; Mon, 17 Feb 2020 04:44:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53917)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j3cvS-0002Qp-Qz
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 04:42:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j3cvR-00045i-Ue
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 04:42:50 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:45547
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j3cvR-00045K-QR
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 04:42:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581932569;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+0K9/hhcGuMRqV64Bb6WocCgg5svmiUON88ZVzCS73g=;
 b=RsdYhbfjK6ZVb4wkWCHDARh8Kp1b3JF0pL0WhuuNt+SXpmAcR4Y23tqP8AWwlnYx+lvtUP
 EeYmj2uayZV92Aw2cEiz0QvuQ6XKdcWE+wWRSwMIzqTHIzoigMpMyV5yHLnvEa1tVbczmT
 Zy/LsQqgXqq6rVGGKoyjElj1SOYd8BQ=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-341-z-6UEmF0NMqgkLIuGVmClA-1; Mon, 17 Feb 2020 04:42:47 -0500
Received: by mail-wr1-f69.google.com with SMTP id w17so8689595wrr.9
 for <qemu-devel@nongnu.org>; Mon, 17 Feb 2020 01:42:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=016NXjobK1ZSPrbhkh4SMG/lamO/sVwpkeO1WxFp7YQ=;
 b=OFyd2GwVLc1f27jaDdndMBz62YEkox1FOjgO7Lw6HKuRcIxRH7vdC+okJ0HTbJ5Hmb
 B0V8kx2b2uKBq3Q5UjdON9JxfPbRJf2Y33kBDozGDFk85cTNMjH/vpncmBHg0TyTZfkV
 luAYiGrXvKhv8YXet9y6pZ0qLgtz/7VKafQni2IgLsa1tlzEHcUYJeWdbSVhGmzwyiZn
 G03Z04Mf9oPL9PFXE0V0z3uJ+Am76PIJJbvSCqLC7ATZsYe4w8Q7i1Veu5AlGUyzoGfi
 25EH4pkphvtNbjJNB+b7lTwUl0O1vKih/HC8LvheW2eHBDS8cfvtYM3ayxzGC4udKOFI
 eurw==
X-Gm-Message-State: APjAAAUdCBMz/cJPy6kBbDlzlxdzPRj7s0LAQvybYkTip+PB4aIWLgAx
 k4a8QOM/wcAXhgWn2AYwlF7cXqCz3WbpZt1MvgnRVpVxjs3rtdr3ttml+tiWYuJZuVoDQg8H7B0
 daljvRSXWE82RnTE=
X-Received: by 2002:a5d:6545:: with SMTP id z5mr20756203wrv.3.1581932566337;
 Mon, 17 Feb 2020 01:42:46 -0800 (PST)
X-Google-Smtp-Source: APXvYqz6r2ka1BsqIqbzkkdfs3hJMWQvGzyKpdzx6zVs++fAcZaRu61dYyoaBQiBwo9Nq0oPhYOmZA==
X-Received: by 2002:a5d:6545:: with SMTP id z5mr20756181wrv.3.1581932566093;
 Mon, 17 Feb 2020 01:42:46 -0800 (PST)
Received: from x1w.redhat.com (78.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.78])
 by smtp.gmail.com with ESMTPSA id t187sm17789442wmt.25.2020.02.17.01.42.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Feb 2020 01:42:45 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH v2 3/3] tools/virtiofsd/fuse_lowlevel: Fix
 fuse_out_header::error value
Date: Mon, 17 Feb 2020 10:42:40 +0100
Message-Id: <20200217094240.9927-4-philmd@redhat.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200217094240.9927-1-philmd@redhat.com>
References: <20200217094240.9927-1-philmd@redhat.com>
MIME-Version: 1.0
X-MC-Unique: z-6UEmF0NMqgkLIuGVmClA-1
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 =?UTF-8?q?J=C3=A1n=20Tomko?= <jtomko@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Fix warning reported by Clang static code analyzer:

    CC      tools/virtiofsd/fuse_lowlevel.o
  tools/virtiofsd/fuse_lowlevel.c:195:9: warning: Value stored to 'error' i=
s never read
          error =3D -ERANGE;
          ^       ~~~~~~~

Fixes: 2de121f01e
Reported-by: Clang Static Analyzer
Reviewed-by: J=C3=A1n Tomko <jtomko@redhat.com>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
RFC because untested
---
 tools/virtiofsd/fuse_lowlevel.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/virtiofsd/fuse_lowlevel.c b/tools/virtiofsd/fuse_lowleve=
l.c
index 704c0369b2..2dd36ec03b 100644
--- a/tools/virtiofsd/fuse_lowlevel.c
+++ b/tools/virtiofsd/fuse_lowlevel.c
@@ -192,7 +192,7 @@ int fuse_send_reply_iov_nofree(fuse_req_t req, int erro=
r, struct iovec *iov,
=20
     if (error <=3D -1000 || error > 0) {
         fuse_log(FUSE_LOG_ERR, "fuse: bad error value: %i\n", error);
-        error =3D -ERANGE;
+        out.error =3D -ERANGE;
     }
=20
     iov[0].iov_base =3D &out;
--=20
2.21.1


