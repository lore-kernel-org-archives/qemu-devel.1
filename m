Return-Path: <SRS0=K/vF=5H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 433C6C4332E
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Mar 2020 12:04:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0BCB92070A
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Mar 2020 12:04:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E5Cz9VyI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0BCB92070A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45722 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jFzLX-0003l8-6C
	for qemu-devel@archiver.kernel.org; Sun, 22 Mar 2020 08:04:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44757)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jFzIG-0000du-Lg
 for qemu-devel@nongnu.org; Sun, 22 Mar 2020 08:01:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jFzIF-0001Ul-Jw
 for qemu-devel@nongnu.org; Sun, 22 Mar 2020 08:01:28 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:52604)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jFzIE-0001UA-6h
 for qemu-devel@nongnu.org; Sun, 22 Mar 2020 08:01:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584878485;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bAmyqKwhwrh0ajYsjXgnnfj5OQ7B6gbp+kGYEsb8iLc=;
 b=E5Cz9VyIOsvcg/43ymALrPxTelSnt9EnuMqNQvcuHveP8mxW1KLCb7rL1KhoKE3lFes5Nt
 sA38MvQfLnCrtIpH3ITWvQc2qpJHA5RJz9f7bFuqp82HT50H9D/+uMa/oYh2NY0/x1N8hO
 J7eG2PxwSNzCL46fA9I9rlGojubiIKM=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-386-SqhcyXlBO2KGZxtXdAeNyQ-1; Sun, 22 Mar 2020 08:01:23 -0400
X-MC-Unique: SqhcyXlBO2KGZxtXdAeNyQ-1
Received: by mail-wr1-f70.google.com with SMTP id j12so1865611wrr.18
 for <qemu-devel@nongnu.org>; Sun, 22 Mar 2020 05:01:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=HJcf06D8sxzN11xhJWZW2vo0/WKoNsGqvt6TggY9h44=;
 b=MyPkBwe2jjullA2Ls4+3XABgWAKW25IIWgTiM1nB1NnC7QPyx8qdhEMxRdbgZ7lRDM
 ygEqYXx2TKpAw/ioUC31zmEJ7EXj0kG13jzY/7l68Nb1ytHjnnnAj4vpxOpZ30uAsT+E
 CFjhcIRR6zRdvrppb0d7Vt/D38Pmhvggxsx+GbC0snIZaeHo/+5LpVOQNiEKzZQmpqCq
 ezDuqQe0IrylXIOLG3zaY0p9yHK6dHivN3nf8TbaSTgUrM7xg2aVyKnZ4KDeUJHrjQEG
 O1hSREOQB+0IcqZmKPDVOcnbNOIIlmC0Rly3k3tYPSSTG6Q9gcRhM31Wp2ySavRT8CQJ
 C8hg==
X-Gm-Message-State: ANhLgQ2IJi4hA2uT2uFn+0EJ/I8omvPRcpP83pWHjySb4iui6FP6Gbbq
 xbIU4m13MfqwkM8z8P1SL8Cv7vuUvIEM4Aw50YrTUvlEOaMSVnBIkS992E4c2AFGD5XxunZXQtR
 dPjoBYyHauK3jGP0=
X-Received: by 2002:a1c:e109:: with SMTP id y9mr20615162wmg.62.1584878482119; 
 Sun, 22 Mar 2020 05:01:22 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vsernfEE6duT0VWgij4EJid1CYeQkTXZqVoi4696MmWxQnkPGkXebuPMFyIYQstMuw3MqA2Gg==
X-Received: by 2002:a1c:e109:: with SMTP id y9mr20615139wmg.62.1584878481936; 
 Sun, 22 Mar 2020 05:01:21 -0700 (PDT)
Received: from localhost.localdomain (37.red-83-52-54.dynamicip.rima-tde.net.
 [83.52.54.37])
 by smtp.gmail.com with ESMTPSA id f10sm18212205wrw.96.2020.03.22.05.01.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Mar 2020 05:01:21 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH-for-5.0 v2 3/4] tests/docker: Use Python3 PyYAML in the Fedora
 image
Date: Sun, 22 Mar 2020 13:01:03 +0100
Message-Id: <20200322120104.21267-4-philmd@redhat.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200322120104.21267-1-philmd@redhat.com>
References: <20200322120104.21267-1-philmd@redhat.com>
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
Cc: Fam Zheng <fam@euphon.net>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The Python2 PyYAML is now pointless, switch to the Python3 version.

Fixes: bcbf27947 (docker: move tests from python2 to python3)
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 tests/docker/dockerfiles/fedora.docker | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/docker/dockerfiles/fedora.docker b/tests/docker/dockerfi=
les/fedora.docker
index 019eb12dcb..174979c7af 100644
--- a/tests/docker/dockerfiles/fedora.docker
+++ b/tests/docker/dockerfiles/fedora.docker
@@ -79,8 +79,8 @@ ENV PACKAGES \
     perl-Test-Harness \
     pixman-devel \
     python3 \
+    python3-PyYAML \
     python3-sphinx \
-    PyYAML \
     rdma-core-devel \
     SDL2-devel \
     snappy-devel \
--=20
2.21.1


