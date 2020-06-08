Return-Path: <SRS0=zEF8=7V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A123BC433E0
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 16:47:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6BC41206A4
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 16:47:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y4RpTzCa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BC41206A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36480 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jiKwG-0007Jv-JT
	for qemu-devel@archiver.kernel.org; Mon, 08 Jun 2020 12:47:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42150)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jiKnp-0003NB-U1
 for qemu-devel@nongnu.org; Mon, 08 Jun 2020 12:39:13 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:23105
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jiKnb-0005vy-SZ
 for qemu-devel@nongnu.org; Mon, 08 Jun 2020 12:39:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591634338;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Jgu4QABfITiikWyPyGwiSTC6XzxqUjphWSXX0h5vBwk=;
 b=Y4RpTzCaLiAliY8c7lM3PT+VVgc85Thy5ffL+Xcx1JznymVKRidv0hBNSAKuZEHyk6/buB
 OAFiSsYXEXrDHsnCbKqYuwH649ysVnCp1fCe09P49EFWNzt0C7sbyhLLgbJYH+60yw25ua
 UQOT3uAum8Pf9EJS5KunZzgE0kiLyz4=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-170-vSHgzQ7oOEKBnvDzShFIzg-1; Mon, 08 Jun 2020 12:38:51 -0400
X-MC-Unique: vSHgzQ7oOEKBnvDzShFIzg-1
Received: by mail-wr1-f69.google.com with SMTP id o1so7339595wrm.17
 for <qemu-devel@nongnu.org>; Mon, 08 Jun 2020 09:38:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Jgu4QABfITiikWyPyGwiSTC6XzxqUjphWSXX0h5vBwk=;
 b=J1+BIT3LetwPkGoWtdAwD3XMGyp1VWLbpaJI7zSO43QoAxzYHmnDesYuegrW4prmyt
 QA8xmzXbVV+QREQgQw8UcG0H7CvK8j9+LoOTQBa3c73nvooh9vz3yamBzteQo8WbQ4xZ
 t8vQhX9ov99fpftpBG83CRSzZqtJOBPxtzn9/IGHHnvzJmGLI0TxJUbOgHRUF1kM0PzU
 a6cXx/voP/s1sjEsaysazNSFun1Q5BJze6rp+Yp8qNCkl1HdKoL32uniaBwLhQ6kaEM2
 RBjEBvT8+SrqOvU/oLp955gEo7UbWRxBRRkCBNQHtGtasGh8OMRI6s++qFtl+F7SZmaP
 Q81A==
X-Gm-Message-State: AOAM533TBGr4gthSt4FM14ANrc1Or0RAFvSZmN32unBBFjlr+F3nB84q
 nno3vHnADUP6XD3JiArQ6ROb3XaIO1HpO6OJe2l+8KSpbjFFbRfhXOpvBH6p92CmAAL9yJyh6Nr
 Oq8JQFHaiT0jmWh8=
X-Received: by 2002:a05:6000:1289:: with SMTP id
 f9mr24902617wrx.5.1591634329792; 
 Mon, 08 Jun 2020 09:38:49 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwAzod7d1mzuyx5ToUWeqie2VPdM6tsEMhrMcZihH6HiD9B+z0SaW9Ph3g8LSoEfx1ZMi4JpA==
X-Received: by 2002:a05:6000:1289:: with SMTP id
 f9mr24902594wrx.5.1591634329594; 
 Mon, 08 Jun 2020 09:38:49 -0700 (PDT)
Received: from localhost.localdomain
 (181.red-88-10-103.dynamicip.rima-tde.net. [88.10.103.181])
 by smtp.gmail.com with ESMTPSA id f9sm276472wrf.74.2020.06.08.09.38.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Jun 2020 09:38:49 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v8 05/10] Makefile: Remove dangerous EOL trailing backslash
Date: Mon,  8 Jun 2020 18:38:18 +0200
Message-Id: <20200608163823.8890-6-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200608163823.8890-1-philmd@redhat.com>
References: <20200608163823.8890-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/08 11:58:00
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

One might get caught trying to understand unexpected Makefile
behavior. Trailing backslash can help to split very long lines,
but are rather dangerous when nothing follow. Preserve other
developers debugging time by removing this one.

Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index d1af126ea1..52956b16fd 100644
--- a/Makefile
+++ b/Makefile
@@ -420,7 +420,7 @@ MINIKCONF_ARGS = \
 
 MINIKCONF_INPUTS = $(SRC_PATH)/Kconfig.host $(SRC_PATH)/hw/Kconfig
 MINIKCONF_DEPS = $(MINIKCONF_INPUTS) $(wildcard $(SRC_PATH)/hw/*/Kconfig)
-MINIKCONF = $(PYTHON) $(SRC_PATH)/scripts/minikconf.py \
+MINIKCONF = $(PYTHON) $(SRC_PATH)/scripts/minikconf.py
 
 $(SUBDIR_DEVICES_MAK): %/config-devices.mak: default-configs/%.mak $(MINIKCONF_DEPS) $(BUILD_DIR)/config-host.mak
 	$(call quiet-command, $(MINIKCONF) $(MINIKCONF_ARGS) > $@.tmp, "GEN", "$@.tmp")
-- 
2.21.3


