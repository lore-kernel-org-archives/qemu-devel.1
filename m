Return-Path: <SRS0=hU7S=42=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31833C10F25
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 20:26:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0504620409
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 20:26:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hdDoSxdt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0504620409
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49426 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBOyu-0007LL-73
	for qemu-devel@archiver.kernel.org; Mon, 09 Mar 2020 16:26:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60918)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jBOvw-0001wJ-MX
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 16:23:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1jBOvu-0005At-OV
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 16:23:28 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e]:35698)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1jBOvu-0005AY-It
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 16:23:26 -0400
Received: by mail-wr1-x42e.google.com with SMTP id r7so12934320wro.2
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2020 13:23:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=GepS+RBgIfLthS0hHsFgjFpLev7UFXBivw+uaPGBApc=;
 b=hdDoSxdtGpdEUg47rwmx8A35TVhb+KLgOby/S0kGES6R4S1Azy1awTdiEzWFlPItdd
 fA45wvIZ1scYWcEVFj+gQwqRo1smMBAA2xbiCgkegihlTSVjIXkptI0EL/QcBD3iGIVW
 8lqbzNnQIdh6pZZbiujvZ83JSLz+1A1D6akU8gTDYO5WBgQt0Up5VB3CoaN6SVpz9tvy
 alniOdNiTgSwiHfuOAeyMflBLRB4uLWWMaRQpZ3c8WR3JuD1zcL2mi70dgZjpGmzUK0V
 zwNe9iUTJoFS/0kgbgScIJLtbSL1Wq3HxicnUBP9nP7kPQ8I95HUncCiyKtQgBlXHLzB
 n7cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=GepS+RBgIfLthS0hHsFgjFpLev7UFXBivw+uaPGBApc=;
 b=tZtLrGXbItFhFwcdbA2XG7HaN++qCy+XgF0pOohe9xfoX04gkex6ET9BNhYs79XHHB
 f39Y8a6055X61L7BV7DtzxrE6wzrjK5DyIG3Vmoj8McvnUv5r/hBWsIpwfRtJ9RJTF2f
 EjdsMhz1ZrlyZ42nsNhS0YiMy6jwE/56PdBi3aQ71CzVJSi0fIBp22t3sVwL6dMFMB7T
 2XrPl7sCoRKFLa1B0IjnPSC8C7Df+gI58eU9QB7wbG6XDatB3ovg+ic6CT6LCuMNGMLq
 TxdZS4+KKNkIbjbR4XEg5aqaaCZv2O8gGQWDyKb+9h7Sam22Khyhs0TnBQ8QNe6Kn5go
 e59g==
X-Gm-Message-State: ANhLgQ20HEA3HOxEoJFktumrY5ZD90AfLz8zqR1YYtnxxkopUQhPodF5
 QdBgnw7PI5d8i8nMn7OPra9KVw==
X-Google-Smtp-Source: ADFU+vsiDJwIlqQ5cYYZ3bf/HoogWW5EcwRPIsuhwSU/C4XLiTvQ1l5HWpCrLts4KXO5qJOB9pfF9g==
X-Received: by 2002:a5d:5512:: with SMTP id b18mr22252469wrv.215.1583785405562; 
 Mon, 09 Mar 2020 13:23:25 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id h3sm762031wmi.41.2020.03.09.13.23.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Mar 2020 13:23:22 -0700 (PDT)
Received: from zen.home.arpa (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id D6F5C1FF90;
 Mon,  9 Mar 2020 20:23:18 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v1 4/5] tests/docker: Update VirGL to v0.8.0
Date: Mon,  9 Mar 2020 20:23:17 +0000
Message-Id: <20200309202318.3481-5-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200309202318.3481-1-alex.bennee@linaro.org>
References: <20200309202318.3481-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42e
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
---
 tests/docker/dockerfiles/debian-amd64.docker | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

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


