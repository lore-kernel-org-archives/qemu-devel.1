Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51BB4C1975A
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 17:52:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 24C9F20735
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 17:52:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WPb0FEwG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24C9F20735
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38062 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEGO9-0002Ic-8R
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 13:52:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56920)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jEGMs-0000JQ-77
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 13:51:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1jEGMm-00020t-OA
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 13:51:05 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431]:35112)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1jEGMm-0001rv-CJ
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 13:51:00 -0400
Received: by mail-wr1-x431.google.com with SMTP id h4so6269763wru.2
 for <qemu-devel@nongnu.org>; Tue, 17 Mar 2020 10:51:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=y/xH7KKbev8lpysybsWMzMTaGtbZlSBv+uAIC7/GWhE=;
 b=WPb0FEwGGjDjC+kAwgIdvsyZ6f10D556yNER69hAeS5roDzoQqzMA7P6y+0rvp4mt2
 H52efzx5PwLUJLyB3FcIehksDmLunUGDk+hK0y2M71s6kTtNtVPj+fqaT8Txuutvhe6H
 r78i3UP9FcB/wBHjEt161B+wQLoIAejWy/C39C6rclKWmELPjMU8BLW19eaeuP3dxH2o
 sjjiw07l2txW3oIAhX3cX1mY0nYN+lUzSvp9kvNpsN72Qu1vjOO5ZICoyuR7parVUVY9
 gMy3E/ToybI679jNpYRY0wxgPiW9DJTy+IQx57ivSn1wTaeDjgIanHHBVJVyvBgJWJRg
 P8uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=y/xH7KKbev8lpysybsWMzMTaGtbZlSBv+uAIC7/GWhE=;
 b=QIH5LHp8rx5NCDfVMzB9682+q8DuxIn08W/gyBcGlRUiPA3Z7BoBZhVASj54cmUKsJ
 9hs66lgXtKUZgwvArOX5oe8fUyZOu3XsPDWH56Iw9D1ONzsC9zazCaqKuxBI3FNPvA8D
 6hnrAT9/cnuYpa+D/UnmVWKWg1CnNqXQBXhQL2kvQgkIIf9siZM+lzFraGiC1fMHapco
 FG9YJc4VIa3hKY9wps2AZHRKx2Mm057y86oqEsl522T+FZ59+VSxmXRGccqsWb2bmmvc
 mjvnb+oh7u4IPMVI1oyK6UMfLSC8s0IsNUMAHPDtaPK5VNQixHGFp/F7lmxOg8VcmBjy
 JqMQ==
X-Gm-Message-State: ANhLgQ0SybRAO6GuAeEzpaoNQB5FdZOl51MfFZse3akN+gVHVQ1edLL/
 t4rye80WNisGGXoLjRwTS7HAhg==
X-Google-Smtp-Source: ADFU+vtP+aBDr2tiFKYWYh1W7UwEx5vbqd3w3mawfzM0QhWqgwuCYUiluP2EsWfM1gfZZTD8AjPTbw==
X-Received: by 2002:a5d:5504:: with SMTP id b4mr134936wrv.181.1584467459325;
 Tue, 17 Mar 2020 10:50:59 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id n10sm5768352wro.14.2020.03.17.10.50.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Mar 2020 10:50:54 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 99B0B1FF90;
 Tue, 17 Mar 2020 17:50:53 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL 04/28] tests/docker: Update VirGL to v0.8.0
Date: Tue, 17 Mar 2020 17:50:29 +0000
Message-Id: <20200317175053.5278-5-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200317175053.5278-1-alex.bennee@linaro.org>
References: <20200317175053.5278-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::431
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
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <philmd@redhat.com>

Building the qemu:debian-amd64 fails when building VirGL:

  make[2]: Entering directory '/usr/src/virglrenderer/src/gallium/auxiliary'
    CC       cso_cache/cso_cache.lo
    CC       cso_cache/cso_hash.lo
    CC       os/os_misc.lo
    CC       util/u_debug.lo
    CC       util/u_debug_describe.lo
    CC       util/u_format.lo
    GEN      util/u_format_table.c
  Traceback (most recent call last):
    File "./util/u_format_table.py", line 168, in <module>
      main()
    File "./util/u_format_table.py", line 164, in main
      write_format_table(formats)
    File "./util/u_format_table.py", line 132, in write_format_table
      print("   %s,\t/* is_array */" % (bool_map(format.is_array()),))
    File "/usr/src/virglrenderer/src/gallium/auxiliary/util/u_format_parse.py", line 164, in is_array
      return self.array_element() != None
    File "/usr/src/virglrenderer/src/gallium/auxiliary/util/u_format_parse.py", line 73, in __eq__
      return self.type == other.type and self.norm == other.norm and self.pure == other.pure and self.size == other.size
  AttributeError: 'NoneType' object has no attribute 'type'
  make[2]: Leaving directory '/usr/src/virglrenderer/src/gallium/auxiliary'
  make[2]: *** [Makefile:906: util/u_format_table.c] Error 1
  make[1]: *** [Makefile:631: install-recursive] Error 1

VirGL commits a8962eda1..a613dcc82 fix this problem.
Update to VirGL 0.8.0 which contains them.

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20200212202709.12665-4-philmd@redhat.com>
Message-Id: <20200316172155.971-5-alex.bennee@linaro.org>

diff --git a/tests/docker/dockerfiles/debian-amd64.docker b/tests/docker/dockerfiles/debian-amd64.docker
index a1d40a56fa1..c70c916343e 100644
--- a/tests/docker/dockerfiles/debian-amd64.docker
+++ b/tests/docker/dockerfiles/debian-amd64.docker
@@ -28,7 +28,7 @@ RUN apt update && \
         libepoxy-dev \
         libgbm-dev
 RUN git clone https://gitlab.freedesktop.org/virgl/virglrenderer.git /usr/src/virglrenderer && \
-    cd /usr/src/virglrenderer && git checkout virglrenderer-0.7.0
+    cd /usr/src/virglrenderer && git checkout virglrenderer-0.8.0
 RUN cd /usr/src/virglrenderer && ./autogen.sh && ./configure --disable-tests && make install
 
 # netmap
-- 
2.20.1


