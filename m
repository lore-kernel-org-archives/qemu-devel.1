Return-Path: <SRS0=+sEj=XT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EE0EC432C2
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 22:32:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 248E02146E
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 22:32:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xtCRAeaA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 248E02146E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43156 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iCtMP-0007GK-Oq
	for qemu-devel@archiver.kernel.org; Tue, 24 Sep 2019 18:32:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56681)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iCs4x-00035n-7A
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 17:10:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iCs4w-0007Vj-2Z
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 17:10:34 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c]:34855)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iCs4v-0007Uf-SQ
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 17:10:34 -0400
Received: by mail-wr1-x42c.google.com with SMTP id v8so3652779wrt.2
 for <qemu-devel@nongnu.org>; Tue, 24 Sep 2019 14:10:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=6+idHhTAwwZaYQkSKifAY2XlNpSeZuGlnlutrp4cNmk=;
 b=xtCRAeaAaHX/8PacqUPFbx6iKKEMd+NlMli/2OyLSPE81ilbTCyHMELR/GZXlxYv6S
 bW/J3+kTH4Q5mKqozQ4UQCoDU0P6R7tQn9MEucPsuuYY+XRdPGq5Wvj7CJjoxIO7H8Ah
 Dp3O/+F9Uelo71WqwM+/eUtxro4acXIHS6h2cuC/nobQ2s0TgMOoV+H2btwYop9MT+mT
 wXo88LXOjD8bIYh8KAXzVc9HsgQETEqMJz9hbSCT98NVgjlnb3PoiMUBFb3kQbd6aLfJ
 7MZhJCF2N528/ASZtGl0ZM5Zxcs7gdM4/Wpmnvyo3ysp4KBre2p1cesDWEYV5GK/FU87
 XMww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=6+idHhTAwwZaYQkSKifAY2XlNpSeZuGlnlutrp4cNmk=;
 b=OIKUYsKfVtdPmN7Xup6dqYAXTtWV4/ncChalWR8iv4PFgdXeyYLrE6HpO473NIdCDv
 aTzS926OoC/cxWagDjJARrjRf9RF0oxbZxzfDk1MgzFINdcAfZGHg36AdF+yup+12nk/
 +2BOVw30E/3/DmFjFwReTwKROFtz2LbxaPGY6dOveDjyafhdSyvpU14EdQIC9KA10BQd
 C8oHzCL34DJn3umSLvvrttWfDTt5af0h0c9NKbLrZUD0FqvXwazDOPpWC1VnnDyn339q
 /G4+U6WUjFvrbSMz632UKXBESTkeb+R+sf2f9GrA/6hNgnFtTant+CRDzJEYslDZkRbT
 T2ug==
X-Gm-Message-State: APjAAAUXki4eFFU5Smq8xr1xcxs9dJU6vsrkoeLDaupP3LblGgb+Vie7
 WxcPEFSMgPDYF9majjA5oiS62w==
X-Google-Smtp-Source: APXvYqwDldWOhc94Lv35jAJgNa5DDF/dWNVNoWgVwCo8NR54FRVO7OJeaLOR/PdiaAXPqbsY/p3QxQ==
X-Received: by 2002:a5d:4a03:: with SMTP id m3mr4893611wrq.182.1569359432689; 
 Tue, 24 Sep 2019 14:10:32 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id x6sm1390148wmf.35.2019.09.24.14.10.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Sep 2019 14:10:32 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 5B0471FFB1;
 Tue, 24 Sep 2019 22:01:09 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v3 27/33] docker: remove debian8-mxe definitions
Date: Tue, 24 Sep 2019 22:01:00 +0100
Message-Id: <20190924210106.27117-28-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190924210106.27117-1-alex.bennee@linaro.org>
References: <20190924210106.27117-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42c
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
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Fam Zheng <fam@euphon.net>, jsnow@redhat.com, f4bug@amsat.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: John Snow <jsnow@redhat.com>

We don't have a debian8-mxe dockerfile anymore.

Fixes: 67bd36beda1ae
Signed-off-by: John Snow <jsnow@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20190923181140.7235-2-jsnow@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/docker/Makefile.include | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/docker/Makefile.include b/tests/docker/Makefile.include
index e85e73025ba..47d2273f29d 100644
--- a/tests/docker/Makefile.include
+++ b/tests/docker/Makefile.include
@@ -7,7 +7,7 @@ DOCKER_FILES_DIR := $(SRC_PATH)/tests/docker/dockerfiles
 DOCKER_DEPRECATED_IMAGES := debian
 # we don't run tests on intermediate images (used as base by another image)
 DOCKER_PARTIAL_IMAGES := debian debian8 debian9 debian10 debian-sid
-DOCKER_PARTIAL_IMAGES += debian8-mxe debian9-mxe debian-ports debian-bootstrap
+DOCKER_PARTIAL_IMAGES += debian9-mxe debian-ports debian-bootstrap
 DOCKER_IMAGES := $(filter-out $(DOCKER_DEPRECATED_IMAGES),$(sort $(notdir $(basename $(wildcard $(DOCKER_FILES_DIR)/*.docker)))))
 DOCKER_TARGETS := $(patsubst %,docker-image-%,$(DOCKER_IMAGES))
 # Use a global constant ccache directory to speed up repetitive builds
-- 
2.20.1


