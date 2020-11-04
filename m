Return-Path: <SRS0=hH57=EK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E2B2C4741F
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 08:46:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DADC1208C7
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 08:46:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GqvVpUDy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DADC1208C7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36940 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kaERD-0002o3-TV
	for qemu-devel@archiver.kernel.org; Wed, 04 Nov 2020 03:46:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46656)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kaEOc-00075B-Mb
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 03:43:58 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:33996)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kaEOZ-0005vr-SN
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 03:43:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604479435;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZwDUJFjz9JABmwe+3ZrGGChU+tAgL0zg4MdKFtTFkJg=;
 b=GqvVpUDyC7qOPuGUSVm16BG2GEj7CGjqjmI2e+nyOuWVT799sMY3Kq6ofqP+xEs2UTza+t
 UY4AB7L7oSdP2Ge4IY/t/4QI5m4BlYbAaNJbwpOAlLKct8o7jIKrxcmrSTydB8DL629eTb
 TrH/0qZQm522GQBQ5QUPVHmNktOw4zA=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-399-iRuEC_QkMs-LQW91udNuzw-1; Wed, 04 Nov 2020 03:43:53 -0500
X-MC-Unique: iRuEC_QkMs-LQW91udNuzw-1
Received: by mail-wr1-f70.google.com with SMTP id t14so9028839wrs.2
 for <qemu-devel@nongnu.org>; Wed, 04 Nov 2020 00:43:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ZwDUJFjz9JABmwe+3ZrGGChU+tAgL0zg4MdKFtTFkJg=;
 b=GPW5fL19w18fAAQbekvXrrmBbWdltE06ZAU1gzr2/Q56jQEdldGjNTBX2yrkaoy8B6
 SsuUQgbnWyfrojZ2yl7c0Pol0YjYPhzPF1de6jhKXYSKw137HfGc9LKdqE3+kcymTZ9X
 BpM5c1DHjhfTxYDWt09IXu3RblCn9amXg1THVMBLlN17u3EBtbjP+K2InIZMzMz5rHXf
 PccGVB3lj5kg7AFuQKdiiwS8wLlypXsAkijLLBrfczqMtBrsY/Buns1a3U77cc0rwnqn
 JwzHUdCxiE2mezQNbKRcvzLHUlePJF+KDjWhsPLwYCbWnDWcITczPhmbFna7Ehi1WctR
 nauA==
X-Gm-Message-State: AOAM532N8Isa0Nb8HbcAVjl6cL4TjHpLRcRmolJ7ctctUjVR1ABHELBN
 AEob1F+0J3Wiu2ogwM0idGzOw/N/DR+YES2LUe3swFtLQOc2lpEO1WrGQ4IZZfLFo8+s2meSR7J
 AlFmWirKvHB7DtkE=
X-Received: by 2002:a05:6000:1046:: with SMTP id
 c6mr6336526wrx.315.1604479431928; 
 Wed, 04 Nov 2020 00:43:51 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzeVlDgUrZBYkvkHMCqHU568OoUWtm47TYzRSs8nhu6I7ALy135n/dMwGZBiC6s2EO0WL7UIw==
X-Received: by 2002:a05:6000:1046:: with SMTP id
 c6mr6336512wrx.315.1604479431799; 
 Wed, 04 Nov 2020 00:43:51 -0800 (PST)
Received: from localhost.localdomain (234.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.234])
 by smtp.gmail.com with ESMTPSA id o7sm1490765wrp.23.2020.11.04.00.43.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Nov 2020 00:43:51 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH-for-5.2 v2 4/4] travis-ci: Remove the
 --without-default-devices job
Date: Wed,  4 Nov 2020 09:43:27 +0100
Message-Id: <20201104084327.3010593-5-philmd@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201104084327.3010593-1-philmd@redhat.com>
References: <20201104084327.3010593-1-philmd@redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/03 00:03:41
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Fam Zheng <fam@euphon.net>, Thomas Huth <thuth@redhat.com>,
 "Daniel P . Berrange" <berrange@redhat.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>, David Hildenbrand <david@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>, Greg Kurz <groug@kaod.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We replicated the --without-default-devices job on GitLab-CI
in the previous commit. We can now remove it from Travis-CI.

Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 .travis.yml | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/.travis.yml b/.travis.yml
index a3d78171cab..15d92291358 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -224,14 +224,6 @@ jobs:
         - ${SRC_DIR}/scripts/travis/coverage-summary.sh
 
 
-    # We manually include builds which we disable "make check" for
-    - name: "GCC without-default-devices (softmmu)"
-      env:
-        - CONFIG="--without-default-devices --disable-user"
-        - CACHE_NAME="${TRAVIS_BRANCH}-linux-gcc-default"
-        - TEST_CMD=""
-
-
     # We don't need to exercise every backend with every front-end
     - name: "GCC trace log,simple,syslog (user)"
       env:
-- 
2.26.2


