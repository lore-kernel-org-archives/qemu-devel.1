Return-Path: <SRS0=CnYV=4F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDBF1C7619F
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 09:43:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9AE37206F4
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 09:43:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TgtpAZKJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9AE37206F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42666 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j3cwJ-00046J-Q8
	for qemu-devel@archiver.kernel.org; Mon, 17 Feb 2020 04:43:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53937)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j3cvV-0002V0-Du
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 04:42:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j3cvU-00047o-Ft
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 04:42:53 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:44785
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j3cvU-00047U-Bp
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 04:42:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581932571;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MYAelrCTwzXEpeXTjGoeLvSObmJVSDbDIvbl+/nkeqU=;
 b=TgtpAZKJqo9tNk5Q3Bz0jyVXLyOJI3TRyj9Rtin0hPA9hZBVODaHYzfU5dyhLFJSg6ion3
 PUcDMfc8RNN8aQFZlclDV7MYecXAVZoVGoVXuJ2xScMMjL5Ldb93FPscWT381GJGfZ8BMj
 t6vpRXezDDyPO6EDnCwpvhOV0GeC4ek=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-8-3eFmizFwMK2YlIw-SpOpaQ-1; Mon, 17 Feb 2020 04:42:44 -0500
Received: by mail-wr1-f70.google.com with SMTP id n23so8658385wra.20
 for <qemu-devel@nongnu.org>; Mon, 17 Feb 2020 01:42:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=nY/FwSJNIP8tGgbzcIhnsTAXLH61fhI3XyE0WWi+eWM=;
 b=A0vS3zaCxMaLxLbe5hiv/C7ukOgBSQYCkyfPOdsP9Kshu6mr6GZmL1A4GZ+SE+y1Jb
 CVTtZz3ISIpZ4szSbM38WmSzmWLI5DodqoYxYrvzPcxjYuXhOVSnMtrbzsNNCZcEly45
 zFdcW99Voo6jer+4JCZ+eRam3sn5HD9rH4Tze1otfCnJ55E7RHGqjzOrDu/XxE5Z9+aT
 y/GXSK/bjzU+EBBJyJ0sDjD8vUtxcvtiHNcyJSyx5y0ffhcB9Ssk8cxeKTxEdvT6hgD2
 ofVV8iRe6P5Uc/BsJGswAe3MkK5USn3x6WbyhPdJkNfVbK8xtbsgD1j5aJnYqwm289AF
 BvOw==
X-Gm-Message-State: APjAAAVHVdT5YdHfEtzKjh+D9XTOe40r9VPwy9zyxTzG37QpIub2BVlz
 sdnkFxIQQ9N8rPZcwmehp95x6tvJ7A/suY1Y+Iz/+6PE9+h3t87C4SrOLuybXPTqnqZKvnZweGT
 Cp0cJwtU0m6WsgIw=
X-Received: by 2002:adf:f80b:: with SMTP id s11mr21977817wrp.12.1581932563545; 
 Mon, 17 Feb 2020 01:42:43 -0800 (PST)
X-Google-Smtp-Source: APXvYqyx3EBu+FoflpE03lVufFajOhpAVZN10mLkueH2EYY9MwAIamDe3WMoSK7ys9LsyB38t1Wwcg==
X-Received: by 2002:adf:f80b:: with SMTP id s11mr21977802wrp.12.1581932563390; 
 Mon, 17 Feb 2020 01:42:43 -0800 (PST)
Received: from x1w.redhat.com (78.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.78])
 by smtp.gmail.com with ESMTPSA id t187sm17789442wmt.25.2020.02.17.01.42.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Feb 2020 01:42:42 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 1/3] tools/virtiofsd/passthrough_ll: Remove unneeded
 variable assignment
Date: Mon, 17 Feb 2020 10:42:38 +0100
Message-Id: <20200217094240.9927-2-philmd@redhat.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200217094240.9927-1-philmd@redhat.com>
References: <20200217094240.9927-1-philmd@redhat.com>
MIME-Version: 1.0
X-MC-Unique: 3eFmizFwMK2YlIw-SpOpaQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
  tools/virtiofsd/passthrough_ll.c:1083:5: warning: Value stored to 'saverr=
' is never read
      saverr =3D ENOMEM;
      ^        ~~~~~~

Fixes: 7c6b66027
Reported-by: Clang Static Analyzer
Reviewed-by: J=C3=A1n Tomko <jtomko@redhat.com>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 tools/virtiofsd/passthrough_ll.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/tools/virtiofsd/passthrough_ll.c b/tools/virtiofsd/passthrough=
_ll.c
index c635fc8820..e9e71d5fc2 100644
--- a/tools/virtiofsd/passthrough_ll.c
+++ b/tools/virtiofsd/passthrough_ll.c
@@ -1080,8 +1080,6 @@ static void lo_mknod_symlink(fuse_req_t req, fuse_ino=
_t parent,
         return;
     }
=20
-    saverr =3D ENOMEM;
-
     saverr =3D lo_change_cred(req, &old);
     if (saverr) {
         goto out;
--=20
2.21.1


