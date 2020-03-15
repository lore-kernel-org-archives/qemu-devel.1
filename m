Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4894EC10DCE
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 00:05:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 170A7205C9
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 00:05:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RyuDFkTW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 170A7205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60506 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDdG0-0005HE-So
	for qemu-devel@archiver.kernel.org; Sun, 15 Mar 2020 20:05:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43483)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jDd8X-0003H0-TZ
 for qemu-devel@nongnu.org; Sun, 15 Mar 2020 19:57:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jDd8W-0008J6-8x
 for qemu-devel@nongnu.org; Sun, 15 Mar 2020 19:57:41 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:31652
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jDd8W-0008Gt-5a
 for qemu-devel@nongnu.org; Sun, 15 Mar 2020 19:57:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584316659;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UoMB8bAs+BncojjHOENLqWi5wv0KsLpWCZpM5Av+CV4=;
 b=RyuDFkTWuUNxoT+MX5Ex7iNy4OAJ94fCyBrtMHS5fDczkoY4QltWjgezES/Ovmjw9jtv0N
 N8Ps10DhodUHWffid4b/CcNIg+4Vi/7HWem1zVsj95ydJEWvsXktZPd3N80gl79YtQDsWG
 iWmwNJKcApBJ804cf8rq669Y8YeSv9E=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-372-oBWu5dj3MwKJMwPNUgrs4Q-1; Sun, 15 Mar 2020 19:57:37 -0400
X-MC-Unique: oBWu5dj3MwKJMwPNUgrs4Q-1
Received: by mail-wr1-f69.google.com with SMTP id o9so8138660wrw.14
 for <qemu-devel@nongnu.org>; Sun, 15 Mar 2020 16:57:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=GFbiob2Atl72mu88AerDnyLW7Ta1dRxhgYxkqDYaKSk=;
 b=uJtbMJpi+n21V6ASnrDafa2pTKMwLpGTtnzgsUEnknYea6mTAFFeydeNBJTLVQGQj2
 J4HoWo8whXtmCX3WJLedDwNj5W8sJV2qsY0gYPtFOKAElapb28eSv8x92kBmnV9YgEf5
 0H3rCunwzVmcVzmze/UJSSmMYsYrjdroRKuS44QNSR0uxNH9THge9nMio4zUXekIlX4/
 Se6CNZcEv+PdLVoXVGywrw2W9GOcVc9qtNzIKOZzBeXy3pqUsxg/rPYw1+Z9yo0lvBhc
 MLuze/j6HI1b92hExdLsOYjPYrR2cVgc1ClYwplejaUB+zWcBC7/O18XjscsKxJFYVln
 pBtg==
X-Gm-Message-State: ANhLgQ0joN+C4ETEszEnsAVwJmmq6yrH5s6WrnA5mUZTRHiGwmzeM5E1
 ngIADGTIDfwOk14DZBaNAzFq+GanjfnAqpUKK4/we2zUt1wJe/MFq2wBcDV/Odiu1FO5JEb4nvH
 rtYtYfdEfWfLX6SI=
X-Received: by 2002:adf:a547:: with SMTP id j7mr9469928wrb.323.1584316656144; 
 Sun, 15 Mar 2020 16:57:36 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vuNuI6y9YupTJFQCEULH5aq2IZZu851yo2rOhRx9U7Sp7HVlLf0nVrF6OjHe7ObL1R1IgOoAQ==
X-Received: by 2002:adf:a547:: with SMTP id j7mr9469900wrb.323.1584316655986; 
 Sun, 15 Mar 2020 16:57:35 -0700 (PDT)
Received: from localhost.localdomain (191.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.191])
 by smtp.gmail.com with ESMTPSA id w81sm27421808wmg.19.2020.03.15.16.57.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Mar 2020 16:57:35 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 03/12] tests/Makefile: Only display TCG-related tests when
 TCG is available
Date: Mon, 16 Mar 2020 00:57:07 +0100
Message-Id: <20200315235716.28448-4-philmd@redhat.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200315235716.28448-1-philmd@redhat.com>
References: <20200315235716.28448-1-philmd@redhat.com>
MIME-Version: 1.0
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, qemu-s390x@nongnu.org,
 Alistair Francis <alistair.francis@wdc.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 tests/Makefile.include | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tests/Makefile.include b/tests/Makefile.include
index 67e8fcddda..99db5eb3e0 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -12,8 +12,10 @@ check-help:
 =09@echo " $(MAKE) check-speed          Run qobject speed tests"
 =09@echo " $(MAKE) check-qapi-schema    Run QAPI schema tests"
 =09@echo " $(MAKE) check-block          Run block tests"
+ifeq ($(CONFIG_TCG),y)
 =09@echo " $(MAKE) check-tcg            Run TCG tests"
 =09@echo " $(MAKE) check-softfloat      Run FPU emulation tests"
+endif
 =09@echo " $(MAKE) check-acceptance     Run all acceptance (functional) te=
sts"
 =09@echo
 =09@echo " $(MAKE) check-report.tap     Generates an aggregated TAP test r=
eport"
--=20
2.21.1


