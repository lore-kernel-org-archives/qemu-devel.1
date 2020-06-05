Return-Path: <SRS0=hXcz=7S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F25EC433E0
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 18:01:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0BED5206FA
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 18:01:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EL/SwIkw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0BED5206FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39460 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jhGeq-0000J8-A3
	for qemu-devel@archiver.kernel.org; Fri, 05 Jun 2020 14:01:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50630)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jhGcC-00059i-A3
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 13:58:48 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:49154)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jhGcB-0000Ag-IK
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 13:58:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591379926;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=F4y5IQpGf/GV4LRRYiibUWruxkZPEhl4TqSSBLgIauk=;
 b=EL/SwIkwxW2YSlmVtG65NOhS/war7h5dyD6cfTgr/9guWNRHbSh7n32ObzRn9Dfb4u/bEv
 V0nx2487Xz6q7iFocSK1oDAA/JvsxocaUPYMrFMeVYgk3aUPtS4wqSrB0nM91MrEaJYMK3
 irNdPjTCnzlMTvwS+s54BP8XWGS12Yo=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-7-4kn5lVqfNz2JeRrA9yEd_g-1; Fri, 05 Jun 2020 13:58:45 -0400
X-MC-Unique: 4kn5lVqfNz2JeRrA9yEd_g-1
Received: by mail-wr1-f71.google.com with SMTP id f4so4069036wrp.21
 for <qemu-devel@nongnu.org>; Fri, 05 Jun 2020 10:58:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=F4y5IQpGf/GV4LRRYiibUWruxkZPEhl4TqSSBLgIauk=;
 b=Z2Dxq5uKCIG7brtjPgqYf808Evu56EVSXW+9A5XGSW10v0Ff3l5cn/H6GJe4fb1YX5
 c0YfwJdm2LRsbB9r4UrvFTtT8AVuvg6geCULkQZ8LvX7SZh9mQS0XjMFsE/h8NB5Aqwm
 eoQY0qYNqm9ueNd5iiJzphijmpOOhmvAk/Cv8VLdHMuoILckhh+HvHuBDDVNx+Zf9JmB
 fbyH0bbfQDLwGfwl5Be0hocUnGFdx3Qs46Z+B1/aIla16V1gnu7ZysxGJ0WWwN3hmCK1
 mA+SdAF3NguuUIEP5MvJjudAZcB+Cvk8kTWAu4zl/1cHN51CjZbjlWXv/aHQ/UGRYJQV
 Foew==
X-Gm-Message-State: AOAM531d1zC4jePu2KVcGqlKqdW32ZyDDHBNTJL7+gCnZvMeccici4Sc
 asp2pA9hEjmxDT0gtERNkpooYD1DyNIB3lxIy5v2YfPHzRiQqP4S8ncHdolyqIJI4G6/fFdgqcE
 c8AnU1U3oZuorihY=
X-Received: by 2002:a5d:4204:: with SMTP id n4mr11439313wrq.247.1591379924140; 
 Fri, 05 Jun 2020 10:58:44 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz19FKuiuhZYJMF69Sb6ErmxI2bf7pEgOLXO1prxo62z+iTRkR48+IN2dIotDRzT669b1dwjw==
X-Received: by 2002:a5d:4204:: with SMTP id n4mr11439299wrq.247.1591379923931; 
 Fri, 05 Jun 2020 10:58:43 -0700 (PDT)
Received: from localhost.localdomain
 (181.red-88-10-103.dynamicip.rima-tde.net. [88.10.103.181])
 by smtp.gmail.com with ESMTPSA id v19sm11918990wml.26.2020.06.05.10.58.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Jun 2020 10:58:43 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v7 04/11] rules.mak: Add strequal() and startswith() rules
Date: Fri,  5 Jun 2020 19:58:14 +0200
Message-Id: <20200605175821.20926-5-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200605175821.20926-1-philmd@redhat.com>
References: <20200605175821.20926-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/05 03:40:54
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add a rule to test if two strings are equal,
and another to test if a string starts with a substring.

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 rules.mak | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/rules.mak b/rules.mak
index 694865b63e..7b58a6b8c5 100644
--- a/rules.mak
+++ b/rules.mak
@@ -191,6 +191,20 @@ ne = $(if $(subst $2,,$1)$(subst $1,,$2),y,n)
 isempty = $(if $1,n,y)
 notempty = $(if $1,y,n)
 
+# strequal
+# Usage: $(call strequal, str1, str2)
+#
+# This macro returns a string (TRUE) when @str1 and @str2
+# are equal, else returns the empty string (FALSE)
+strequal = $(if $(subst $2,,$1)$(subst $1,,$2),,$1)
+
+# startswith
+# Usage: $(call startswith, startstr, fullstr)
+#
+# This macro returns a string (TRUE) when @fullstr starts with
+# @startstr, else returns the empty string (FALSE)
+startswith = $(findstring :$1,:$2)
+
 # Generate files with tracetool
 TRACETOOL=$(PYTHON) $(SRC_PATH)/scripts/tracetool.py
 
-- 
2.21.3


