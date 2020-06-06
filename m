Return-Path: <SRS0=faK4=7T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8808BC433DF
	for <qemu-devel@archiver.kernel.org>; Sat,  6 Jun 2020 10:07:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B2DC206DC
	for <qemu-devel@archiver.kernel.org>; Sat,  6 Jun 2020 10:07:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="E1UbGvV6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B2DC206DC
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52318 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jhVjP-0006zN-Io
	for qemu-devel@archiver.kernel.org; Sat, 06 Jun 2020 06:07:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51410)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3q2rbXgYKCuoeMYQUPSaaSXQ.OaYcQYg-PQhQXZaZSZg.adS@flex--sameid.bounces.google.com>)
 id 1jhViq-0006Zl-2N
 for qemu-devel@nongnu.org; Sat, 06 Jun 2020 06:06:40 -0400
Received: from mail-qt1-x84a.google.com ([2607:f8b0:4864:20::84a]:55126)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3q2rbXgYKCuoeMYQUPSaaSXQ.OaYcQYg-PQhQXZaZSZg.adS@flex--sameid.bounces.google.com>)
 id 1jhVip-0001Ch-6K
 for qemu-devel@nongnu.org; Sat, 06 Jun 2020 06:06:39 -0400
Received: by mail-qt1-x84a.google.com with SMTP id u26so10860861qtj.21
 for <qemu-devel@nongnu.org>; Sat, 06 Jun 2020 03:06:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:in-reply-to:message-id:mime-version:references:subject:from:to
 :cc; bh=SJF0uEjYNQkzF8wPTCq68VSh6VbSoGFPM81EwD3Amec=;
 b=E1UbGvV69zaBEgg9UyXoYy88D8O7vOxOK4EgCwu0+IMNYg8fs3mNzuH1h9vZ8fncge
 pziX2aWtAHXwpojeFaMX/y991qaaykBWmW9DHCAdyEwso7ndjNwh2sVt8l1OHWpH8m+k
 d5eijP9kZuiJtDU/h7bdRgNu5KvaO9D6FJ+wNTGzFDRYW/wehSHAWVZ2NR5706EQcwij
 oPiRosfC8mhpMUsBDQaGABNa5Uk1yYplJE83IA7SJGoNC/oyHA5dMb1SSx9MqDGfqAvJ
 TLvZ0E3PZWtQc6T2Za7rgbJn+D8EQk8apvPiqIxajQCu4O0LSYtuHQpVY1CXe46IbeSX
 uNwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc;
 bh=SJF0uEjYNQkzF8wPTCq68VSh6VbSoGFPM81EwD3Amec=;
 b=ryYbSiIPzx/sqVJjHia4MaylGkrU8WYltqLnAANi0jG5PgdfZg09uirGga6RA1Q9iC
 MTKMABRkGuUkdPR+RzvMQoEsqSsTiGZ2gBnVQXDlPIfv1YkwtahGvjSNv7AZ8HlnZ32D
 2G1c9QfXYM+PgssHWXLMO5Y2XKkLMFVDcDcPwwY6qQnCoB9uqalSLIf+DP68eDh58uX0
 ewJYDJ2iFJ5ZnQfnUH1OwYGcExCHkwJgIOT+mc+GAVxoGi95QBL/LDcTG9C1ZIwztc4+
 qkK1+JTI+Ojsm0WaYbEiDCD282fusXZq7DzqyBnvU5uzXpPh//MS4d6Lh2bKGBxPTECC
 TYaQ==
X-Gm-Message-State: AOAM532t/llpNYSCiA/Gx2J8aajz6uGsNilsaQJVHovJnmUpgjl1pT+L
 Yftc2bgIpwZLOxR4SjML+9YN2G1kUX8=
X-Google-Smtp-Source: ABdhPJyfGNw1vTzCLeC/EjBKzGx03YuoKLmi0x3pMmOGXFQaK7Q0BayOo1+9wMZSTlsBJfA79xmB6bGqwEk=
X-Received: by 2002:ad4:54ee:: with SMTP id k14mr1374643qvx.9.1591437995858;
 Sat, 06 Jun 2020 03:06:35 -0700 (PDT)
Date: Sat,  6 Jun 2020 13:06:32 +0300
In-Reply-To: <20200528101039.24600-7-thuth@redhat.com>
Message-Id: <20200606100632.26442-1-sameid@google.com>
Mime-Version: 1.0
References: <20200528101039.24600-7-thuth@redhat.com>
X-Mailer: git-send-email 2.27.0.278.ge193c7cf3a9-goog
Subject: gitlab-ci: Do not use the standard container images from gitlab
From: Sam Eiderman <sameid@google.com>
To: thuth@redhat.com
Cc: alex.bennee@linaro.org, crosa@redhat.com, peter.maydell@linaro.org, 
 philmd@redhat.com, qemu-devel@nongnu.org, wainersm@redhat.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::84a;
 envelope-from=3q2rbXgYKCuoeMYQUPSaaSXQ.OaYcQYg-PQhQXZaZSZg.adS@flex--sameid.bounces.google.com;
 helo=mail-qt1-x84a.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Hi,

I am using debian 10 container to compile qemu too.

I think that what happens here is that

  /usr/include/linux/swab.h

Uses BITS_PER_LONG instead of __BITS_PER_LONG which is actually defined before
in qemu at:

  include/qemu/bitops.h:#define BITS_PER_LONG           (sizeof (unsigned long) * BITS_PER_BYTE)

which injects this definition into the linux swab.h header.

By changing BITS_PER_LONG to __BITS_PER_LONG in the linux headers, I managed to
successfully compile qemu.

A different approach would be to move the linux header includes
(#include <linux/cdrom.h>) in file-posix.c above all other includes - which in
some way makes more sense (since we probaly don't want qemu defines to control
linux headers) but it requires a more complex refactoring.

