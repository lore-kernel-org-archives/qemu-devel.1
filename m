Return-Path: <SRS0=xDnh=4A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61BE1C3B188
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2020 20:30:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 29BCF2469A
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2020 20:30:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hbSkxjq+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29BCF2469A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42994 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1yeD-0000Xz-8v
	for qemu-devel@archiver.kernel.org; Wed, 12 Feb 2020 15:30:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41221)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j1ybY-0005ah-7c
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 15:27:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j1ybW-0001VJ-Bm
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 15:27:28 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:20551
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j1ybW-0001UF-3p
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 15:27:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581539243;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/pvYM7d48NNpCECZok6PLdb72r+aCwIa4RoEtGdV12U=;
 b=hbSkxjq+Qm8KuE4Cje+wl5swmhESQbS8Xrp8fRNLeBJj+oP7jg5M7CqphFJH7Si4i8bn3p
 3uGZR3bh8k+g9p5cckOPLau/uzfQ0S2T+0sq/hd7Ji7M0jvcP/ZrW+BKrPixaNZdwF0OJh
 0lqNgG+Dcx1aw2BuIax4s+btpqopPsQ=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-389-lusoBBK0NJmuMSajhCC7BQ-1; Wed, 12 Feb 2020 15:27:14 -0500
Received: by mail-wm1-f70.google.com with SMTP id n17so1213105wmk.1
 for <qemu-devel@nongnu.org>; Wed, 12 Feb 2020 12:27:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=xoUWrCAyReDiTTD0lt/rLk+igyCaLsky1TOc8aI0IsA=;
 b=GnqI1wV7CNOslsvGe8sMYP4E/eSyWqZbBV3qIwkpasd68r9K05L6kIDywFKoDaSL7h
 5EXPHE9u6yOf6uqm9cQJjIEqq2Jkh3j0tqiY22z9zQe9KazkNGBI2mSMAVTsXmDT/MJH
 vJ9hIdO0tJVip4g035pXBJrO+Jy0lbZj847onYHN7LgZSwi4sHMexsgGOvywZcKFSSuO
 rkrRGgQCg4czkOxwt3Vnf+hIvCjT8oCLJ84FIn0wuifCQW3tVgyOHKVIDzTrmkfNLNpO
 aZ45tZ8wcW2X7Nl3ZfKVZ0f5rud6DHUdUsvcTwmLXZgcMuy5VjxSsovA84C/IAvbFNGw
 Aqjg==
X-Gm-Message-State: APjAAAXckny/cCwbURC+kRzZIMzl+/qAyYCiENUPdbF3XmZltVDE3Kng
 QAtavDdFE4CZm7kS9ih0qOw8+KXltjGOifVKmE+sS9ik/s6rAVqmkJCtkvbvALhAyu3jAoaT8Oi
 V2AGY0ae3qcMxbLU=
X-Received: by 2002:adf:b7c2:: with SMTP id t2mr17022353wre.269.1581539233508; 
 Wed, 12 Feb 2020 12:27:13 -0800 (PST)
X-Google-Smtp-Source: APXvYqwicSQf+qOaywmpoLqQ6w9sx/m4GPVzTQD56Kb1kl884xqaOa+9zTHGDjKUUUUQSZ2PPFQgrA==
X-Received: by 2002:adf:b7c2:: with SMTP id t2mr17022335wre.269.1581539233265; 
 Wed, 12 Feb 2020 12:27:13 -0800 (PST)
Received: from x1w.redhat.com (78.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.78])
 by smtp.gmail.com with ESMTPSA id x14sm1957035wmj.42.2020.02.12.12.27.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Feb 2020 12:27:12 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 2/3] tests/docker: Remove obsolete VirGL --with-glx configure
 option
Date: Wed, 12 Feb 2020 21:27:08 +0100
Message-Id: <20200212202709.12665-3-philmd@redhat.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200212202709.12665-1-philmd@redhat.com>
References: <20200212202709.12665-1-philmd@redhat.com>
MIME-Version: 1.0
X-MC-Unique: lusoBBK0NJmuMSajhCC7BQ-1
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
Cc: Fam Zheng <fam@euphon.net>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Dave Airlie <airlied@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The GLX configure option has been removed in 71c75f201d [*].
We missed that when updating to v0.7.0 in commit fab3220f97.

This silents:

  configure: creating ./config.status
  config.status: creating virglrenderer.pc
  ...
  configure: WARNING: unrecognized options: --with-glx

[*] https://gitlab.freedesktop.org/virgl/virglrenderer/commit/71c75f201d

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 tests/docker/dockerfiles/debian-amd64.docker | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/docker/dockerfiles/debian-amd64.docker b/tests/docker/do=
ckerfiles/debian-amd64.docker
index b67fad54cb..a1d40a56fa 100644
--- a/tests/docker/dockerfiles/debian-amd64.docker
+++ b/tests/docker/dockerfiles/debian-amd64.docker
@@ -29,7 +29,7 @@ RUN apt update && \
         libgbm-dev
 RUN git clone https://gitlab.freedesktop.org/virgl/virglrenderer.git /usr/=
src/virglrenderer && \
     cd /usr/src/virglrenderer && git checkout virglrenderer-0.7.0
-RUN cd /usr/src/virglrenderer && ./autogen.sh && ./configure --with-glx --=
disable-tests && make install
+RUN cd /usr/src/virglrenderer && ./autogen.sh && ./configure --disable-tes=
ts && make install
=20
 # netmap
 RUN apt update && \
--=20
2.21.1


