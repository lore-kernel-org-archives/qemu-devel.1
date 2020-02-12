Return-Path: <SRS0=xDnh=4A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71CD2C352A4
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2020 20:28:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 328C02465D
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2020 20:28:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="awoDAf++"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 328C02465D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42978 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1ycl-0006sc-9D
	for qemu-devel@archiver.kernel.org; Wed, 12 Feb 2020 15:28:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41209)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j1ybX-0005ZJ-2b
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 15:27:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j1ybS-0001Tx-Ag
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 15:27:27 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:37242
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j1ybS-0001Tk-6t
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 15:27:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581539241;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4dt12/fsz18+vpvPJ46eJPhavyfCB8csIW/8fBeGbhY=;
 b=awoDAf++klcFnT/E1+KjxbCgTvkRdf3hHA8KQnu0QnncILQZK1GVwPzD+aXsUZc01Xuqqa
 +W5VzfR1ckKVjBJK9Tr3msryzs1hQBNgqcT9y447e4ckjZy5qBadauJc0f0rhYj6J0Qvzs
 iFh7KQq7Rf85l+4K7y+ybMu9iVvERFA=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-127-ZWF5AtTDPaK9MZ7epofy8A-1; Wed, 12 Feb 2020 15:27:13 -0500
Received: by mail-wr1-f70.google.com with SMTP id d8so1292422wrq.12
 for <qemu-devel@nongnu.org>; Wed, 12 Feb 2020 12:27:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Z+RrXkUgYY9Z7ttpomK0V9SrygV+e7seR6giOjcMU5k=;
 b=NmHemZHUeMF2mlhO7v4ATz2h8vxTjE34Pny4k6/dY4Hzx2Hoay+2wE/qqj9Dlf8u6L
 PgO2r1Bmg2w0PW4VjqpjvF0w6KQnQJbCvsyQAk7P/dwmCzH4roJUOjauvzXEBqi6ifU5
 FY6dz1L3XjS+yhebb2pHg/g0XolzkL+nVAMy1te65rUwCPOHmK/ms8HanAIVK6Zd9OLw
 SJG+HW7p0oDgl88/rPu0Aum8z4iKxguz/00YV5QXKwDRg0GrDjQbf58F4K8/Qn0Tqsqa
 sU7T9dMV2tPt05480CzJVTs73YqCK3y5v5pfgCj5D1QBIR7/VPa4J1UfilfiJaOy+1Kj
 fK2w==
X-Gm-Message-State: APjAAAWkdFq+TwdttLeCbeKhCfHRn9YNdQbWKT39OHv/tyeTJBxgXWhF
 mbTh0Ddtyz8B9ZZWv3X50xomJI/VjNJfFQE/XvfebcBR0dU0tTjW72Q36g7lafQdrxIT8zE9VCl
 peHKmAZJ6Jk9/acQ=
X-Received: by 2002:a5d:4b03:: with SMTP id v3mr17775770wrq.178.1581539232192; 
 Wed, 12 Feb 2020 12:27:12 -0800 (PST)
X-Google-Smtp-Source: APXvYqxAGlXWuTCrKv49Yc6xROQiqNjVL6xspIbrgr49hM3OZHlObOAi0klbwQ0ZX96xi3LFJVR2IA==
X-Received: by 2002:a5d:4b03:: with SMTP id v3mr17775751wrq.178.1581539231877; 
 Wed, 12 Feb 2020 12:27:11 -0800 (PST)
Received: from x1w.redhat.com (78.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.78])
 by smtp.gmail.com with ESMTPSA id x14sm1957035wmj.42.2020.02.12.12.27.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Feb 2020 12:27:11 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/3] tests/docker: Update VirGL git repository URL
Date: Wed, 12 Feb 2020 21:27:07 +0100
Message-Id: <20200212202709.12665-2-philmd@redhat.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200212202709.12665-1-philmd@redhat.com>
References: <20200212202709.12665-1-philmd@redhat.com>
MIME-Version: 1.0
X-MC-Unique: ZWF5AtTDPaK9MZ7epofy8A-1
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

freedesktop.org is moving to a GitLab instance,
use the new url.

- https://www.fooishbar.org/blog/gitlab-fdo-introduction/
- https://gitlab.freedesktop.org/freedesktop/freedesktop/-/wikis/home

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 tests/docker/dockerfiles/debian-amd64.docker | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/docker/dockerfiles/debian-amd64.docker b/tests/docker/do=
ckerfiles/debian-amd64.docker
index 3b860af106..b67fad54cb 100644
--- a/tests/docker/dockerfiles/debian-amd64.docker
+++ b/tests/docker/dockerfiles/debian-amd64.docker
@@ -27,7 +27,7 @@ RUN apt update && \
         libegl1-mesa-dev \
         libepoxy-dev \
         libgbm-dev
-RUN git clone https://anongit.freedesktop.org/git/virglrenderer.git /usr/s=
rc/virglrenderer && \
+RUN git clone https://gitlab.freedesktop.org/virgl/virglrenderer.git /usr/=
src/virglrenderer && \
     cd /usr/src/virglrenderer && git checkout virglrenderer-0.7.0
 RUN cd /usr/src/virglrenderer && ./autogen.sh && ./configure --with-glx --=
disable-tests && make install
=20
--=20
2.21.1


