Return-Path: <SRS0=NdIa=7N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88F31C433E0
	for <qemu-devel@archiver.kernel.org>; Sun, 31 May 2020 16:40:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 54BB22074A
	for <qemu-devel@archiver.kernel.org>; Sun, 31 May 2020 16:40:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WWgHRcTa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54BB22074A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51120 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jfR12-0003RY-Df
	for qemu-devel@archiver.kernel.org; Sun, 31 May 2020 12:40:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55268)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jfQzs-0001da-09
 for qemu-devel@nongnu.org; Sun, 31 May 2020 12:39:40 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:39484
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jfQzr-0006kx-6m
 for qemu-devel@nongnu.org; Sun, 31 May 2020 12:39:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590943178;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gbfmbJetD8UXBRyHPiWp2CZGSyL0yCJiZ8wSWR7Ajrc=;
 b=WWgHRcTauvbPDjd2H4idUM9PvClm6ie1dsT5v3I5FbRT4WEPQWca3sYHkVYW++tGPocT9l
 E+FUUUvima4ckm66DTEuIWQ2JK/3ySHoKQn3avhK2oLPGo2HcthAi/CFpteAa3wTMaAdQz
 F0jmMdK3h0rBIMSyCF8S44RAjyGRhO0=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-137-Ioi2TqhyMkKHRozy2hLV8A-1; Sun, 31 May 2020 12:39:36 -0400
X-MC-Unique: Ioi2TqhyMkKHRozy2hLV8A-1
Received: by mail-wr1-f71.google.com with SMTP id n6so3624099wrv.6
 for <qemu-devel@nongnu.org>; Sun, 31 May 2020 09:39:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=gbfmbJetD8UXBRyHPiWp2CZGSyL0yCJiZ8wSWR7Ajrc=;
 b=MH9ADqAlJrx+HP+9xa2oBiffr0bPEXnz/MUl8xHeN/ID0CW93r5aOSVhz4oyLTiWyn
 jhHdD+dEwhEKQIrRfZHSsXzvVfAB4joD8I9DGXqfSyZMGD4SxPfo7aKzpVF+FPVgq2ie
 Vxcy9KynconmOaMWjiUclLNliwAaLPI8QrgqH/vlgQERKgEbvs15RnuuS9nwOpffTGwV
 V97PxNo9Xn5SOgVWtdcUr+ZsKPkQ3R2GR99Zgakh/8LL3ZKOCidvoEF7UQiYtYGA8ixt
 Z3PiTjYg8oZ9E2Z3tKSLHVDFoAcEtnXCIYXBAyHtWpdEc4z4wyTT8vwQHPmZmR+i+zeM
 R97A==
X-Gm-Message-State: AOAM530gAh9oySby+eQ23B6vpJd15HoKpia7rsmRyL4eaEpLBsMnuwbP
 Ck0EiXWeMXwgvuu4pVHvNfSv7bZo95CYM7+2/WzkLp4yjLi/HZ06ayPMd6I1HFxHQbW4hAu3AaA
 3F6sm0QbYOCcI65A=
X-Received: by 2002:a5d:6905:: with SMTP id t5mr17760709wru.113.1590943175696; 
 Sun, 31 May 2020 09:39:35 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyR0WKTSgw9DfCBwsj7WS7gvkIpsMb9ekd4IwqI/sxgbznb+YzTnTNNzeC4sMj2PMSV+Th05w==
X-Received: by 2002:a5d:6905:: with SMTP id t5mr17760696wru.113.1590943175563; 
 Sun, 31 May 2020 09:39:35 -0700 (PDT)
Received: from localhost.localdomain (43.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.43])
 by smtp.gmail.com with ESMTPSA id s7sm17688910wrr.60.2020.05.31.09.39.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 31 May 2020 09:39:35 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 09/25] python/qemu/machine: remove logging configuration
Date: Sun, 31 May 2020 18:38:30 +0200
Message-Id: <20200531163846.25363-10-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200531163846.25363-1-philmd@redhat.com>
References: <20200531163846.25363-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/31 12:38:54
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 Eduardo Habkost <ehabkost@redhat.com>, kvm@vger.kernel.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Max Reitz <mreitz@redhat.com>, John Snow <jsnow@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-block@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: John Snow <jsnow@redhat.com>

Python 3.5 and above do not print a warning when logging is not
configured. As a library, it's best practice to leave logging
configuration to the client executable.

Signed-off-by: John Snow <jsnow@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20200514055403.18902-22-jsnow@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 python/qemu/machine.py | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/python/qemu/machine.py b/python/qemu/machine.py
index d2f531f1b4..41554de533 100644
--- a/python/qemu/machine.py
+++ b/python/qemu/machine.py
@@ -119,9 +119,6 @@ def __init__(self, binary, args=None, wrapper=None, name=None,
         self._console_socket = None
         self._remove_files = []
 
-        # just in case logging wasn't configured by the main script:
-        logging.basicConfig()
-
     def __enter__(self):
         return self
 
-- 
2.21.3


