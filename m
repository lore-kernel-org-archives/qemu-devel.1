Return-Path: <SRS0=axyf=VH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C50EAC74A2B
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2019 16:17:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 97A10208E4
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2019 16:17:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Om8+VeSr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97A10208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35228 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hlFHg-000815-RH
	for qemu-devel@archiver.kernel.org; Wed, 10 Jul 2019 12:17:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55334)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <paolo.bonzini@gmail.com>) id 1hlFEt-00067G-SR
 for qemu-devel@nongnu.org; Wed, 10 Jul 2019 12:14:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1hlFEp-0007Rm-UN
 for qemu-devel@nongnu.org; Wed, 10 Jul 2019 12:14:37 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d]:54127)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1hlFEo-0007Pt-PD
 for qemu-devel@nongnu.org; Wed, 10 Jul 2019 12:14:35 -0400
Received: by mail-wm1-x32d.google.com with SMTP id x15so2902455wmj.3
 for <qemu-devel@nongnu.org>; Wed, 10 Jul 2019 09:14:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=YGykOkEMYXRBis9yBQtAq0dGo3SPwqnrceEfw3LjUE8=;
 b=Om8+VeSruTtqZxFKcQ9y0EMrGVA9MJwYDhp5kJMrrBtM1694YUA3sMqUGNVwfnqpqB
 s/WT7xTcVsV+DhZXh8dc7rxnmV4BS4Pdd+zoeYgfVBRZWRJSCPJ0E569uPHaexXV2KcS
 tFtQweZNsqaB7VZoTK6RSTPayGTJTjCzxPIpy3ql9TDZxAmF9JsP0C9A8q0thpIKl2pW
 FNhU3t1El/LTYCwz6nGm82xMIQBgHL211pobYD/kyIGLPlunNN349OnCQSy1Elepx5vf
 mcJxZtxy7u+CyDRtGwP1YwFuZ2pcgT5Um5KXZfcy6kMormgKgk0DlV4ocQ+aLq1zKU/v
 fdsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references;
 bh=YGykOkEMYXRBis9yBQtAq0dGo3SPwqnrceEfw3LjUE8=;
 b=Gg1gs1iQsAYYo9WA4P+1B3KX0ZabWVMrlq+uf97jCZJONhGw8mkO9gcRoG5PzomV1y
 C7OSL2kV08fJLk6cYQZ/fL6FotRIZIfp2Wzx1yCUzYkpDKggayegsp1ECezC3k/iYfoG
 2kuvYEVvk+qe6jIYe6RkGtyCkBGVs1s+V5UHm4e0lSjQO2f7hFVUDXl2Njm9n8pRSyA0
 F7srsyHsJe7n4sKb9IU+5ddOr2H76pZ+jxxKueOBtINO6uRxfBopebxHocIWMPbSbDdW
 4ubZOC2kb93/lzBYlxMNVTZPiaJeDVmX/TH1gsObbD04e/+5wCpEYnHD55L8JZRMkpXZ
 IMcQ==
X-Gm-Message-State: APjAAAWi4lhGCYePfauCXNLzGQv4NfF2kGRa1wZn255bsGRLvDcyoMsb
 iXKUW3Xgl1wDe+pdhs4sAdGrQoLn7ac=
X-Google-Smtp-Source: APXvYqzEwnf4/iuECcjc6dXTSaUTwTvIFdm0jmZoWozuugY10RUk8bv0l6ndHp0AoujxaWsIDS/WcQ==
X-Received: by 2002:a1c:a8d7:: with SMTP id r206mr6139390wme.47.1562775272893; 
 Wed, 10 Jul 2019 09:14:32 -0700 (PDT)
Received: from 640k.localdomain ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id w14sm2573747wrk.44.2019.07.10.09.14.31
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 10 Jul 2019 09:14:31 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Date: Wed, 10 Jul 2019 18:14:21 +0200
Message-Id: <1562775267-1222-3-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1562775267-1222-1-git-send-email-pbonzini@redhat.com>
References: <1562775267-1222-1-git-send-email-pbonzini@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32d
Subject: [Qemu-devel] [PATCH 2/8] configure: set $PYTHON to a full path
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
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 berrange@redhat.com, armbru@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This will make it possible to replace it in a shebang line.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 configure | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/configure b/configure
index b0b8bdd..49cb3f3 100755
--- a/configure
+++ b/configure
@@ -918,7 +918,7 @@ for binary in "${PYTHON-python3}" python python2
 do
     if has "$binary"
     then
-        python="$binary"
+        python=$(command -v "$binary")
         break
     fi
 done
-- 
1.8.3.1



