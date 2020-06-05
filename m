Return-Path: <SRS0=hXcz=7S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1FF4C433E0
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 07:43:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B55D207D3
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 07:43:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VwdtgmSv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B55D207D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36310 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jh70m-0008LK-OA
	for qemu-devel@archiver.kernel.org; Fri, 05 Jun 2020 03:43:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54740)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jh6xg-00020d-Cr
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 03:40:20 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:28344
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jh6xf-00051y-JY
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 03:40:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591342818;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EjTnugmHQF57SpUUQ7kXu5I8kuNEH9ZLUz5L6DRtXdw=;
 b=VwdtgmSvinurPQ1vO7ynui3DdeJH7qkwUvr9ac8nXlpZJONXph1UlG03zZZ++ROoqXBZ56
 ufFvq/NXzXs5lbPMR5oNRMgTHSx6uaGS6zsCr7TUfY9xfHe5It5hDQBJqv//U0RYH8uL2d
 rQLnnswWaJN1vg5L5DbsYoN8/gycxdg=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-365-PSgsnAyRNqiukZkWh4NTRQ-1; Fri, 05 Jun 2020 03:40:17 -0400
X-MC-Unique: PSgsnAyRNqiukZkWh4NTRQ-1
Received: by mail-wr1-f69.google.com with SMTP id w16so3402793wru.18
 for <qemu-devel@nongnu.org>; Fri, 05 Jun 2020 00:40:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=EjTnugmHQF57SpUUQ7kXu5I8kuNEH9ZLUz5L6DRtXdw=;
 b=YtLy3dtJv0hcYhwro2CeQBGBw6fJlj22fx8Mj327MGheX5wcrCBa0Qr9yn6w3DVb0L
 KeFVWJc6n4jfHF0t1ADeRnam4fdOUU3xYRKifs8nUTwA99rIar3KoQALTVPFdzOU/PT/
 DHJtvCIOVi6ADDAOHutoFvGqhCeH0By2CVYeOveFEnQbAyr9/kaQ2LaWgJ+oEqDUVQq9
 OlIRs9RtcBi2kj/EFxQmKg6ufdGC9kEHQEsKdTT3sVnwNMToYOXoXKdWCOWXzZ89y88o
 QPqlSmuS0NEzAcv9suEUIjqAE1azZcN9gTRhjbY7dRUdolyG2UcYKGq9i232ul1f+aln
 pUfw==
X-Gm-Message-State: AOAM533H1gKMn12WISuknviwX6DjBtzg8kVdYTr2CMqJly1Dt2F3+oyt
 6bS/RK7lluuxqV5EBwYaskv3qGh+UCun1xEJ40ufiDn/d831DHzdWFUwIyajYSYTFHt32bB29Gq
 WTvlXhUO00PkYesc=
X-Received: by 2002:a5d:62c2:: with SMTP id o2mr7933451wrv.51.1591342815900;
 Fri, 05 Jun 2020 00:40:15 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxQayMquIzJxv5b4YMZdlMR4T7N8POT838zHVttlRHQBYEzZu3o5yMQsQn8FIrfhsMQW8Klvg==
X-Received: by 2002:a5d:62c2:: with SMTP id o2mr7933431wrv.51.1591342815670;
 Fri, 05 Jun 2020 00:40:15 -0700 (PDT)
Received: from localhost.localdomain
 (181.red-88-10-103.dynamicip.rima-tde.net. [88.10.103.181])
 by smtp.gmail.com with ESMTPSA id j18sm11440178wrn.59.2020.06.05.00.40.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Jun 2020 00:40:15 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 04/11] rules.mak: Add strequal() and startwith() and rules
Date: Fri,  5 Jun 2020 09:39:46 +0200
Message-Id: <20200605073953.19268-5-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200605073953.19268-1-philmd@redhat.com>
References: <20200605073953.19268-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/05 03:07:04
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add a rule to test if two strings are equal,
and another to test if a string starts with a substring,

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 rules.mak | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/rules.mak b/rules.mak
index 694865b63e..ccc1c49604 100644
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
+# startwith
+# Usage: $(call startwith, startstr, fullstr)
+#
+# This macro returns a string (TRUE) when @fullstr starts with
+# @startstr, else returns the empty string (FALSE)
+startwith = $(findstring :$1,:$2)
+
 # Generate files with tracetool
 TRACETOOL=$(PYTHON) $(SRC_PATH)/scripts/tracetool.py
 
-- 
2.21.3


