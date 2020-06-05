Return-Path: <SRS0=hXcz=7S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F05ABC433E0
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 09:34:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BCBC920772
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 09:34:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PRFdofBQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BCBC920772
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43434 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jh8k4-0001gX-1e
	for qemu-devel@archiver.kernel.org; Fri, 05 Jun 2020 05:34:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39768)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jh8j5-0000Iq-QT
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 05:33:23 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:30972
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jh8j3-0004Zo-SN
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 05:33:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591349601;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OHk2hvp/I3N6csdyclibeQLQrPIWchtpAoc6xxVu9kE=;
 b=PRFdofBQSKqTNSM/IlUlpMgdHpsWOVWdTNzD/hGdEA12fVpdpSzgrPFmv0XDS2VDiLA2M9
 D9tI6nj2NWvJZba7aw5gVJc/WuHkRnayGEN9TuSsgb6fvfBG7h5IpfBhKZZEdZ8fdKwpXA
 htdYdJX8tFmBideKFFPLKg5vzp9BIwQ=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-188-yTl2zcJXO7OhPLfwIF01vA-1; Fri, 05 Jun 2020 05:33:19 -0400
X-MC-Unique: yTl2zcJXO7OhPLfwIF01vA-1
Received: by mail-wr1-f72.google.com with SMTP id p10so3549545wrn.19
 for <qemu-devel@nongnu.org>; Fri, 05 Jun 2020 02:33:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=OHk2hvp/I3N6csdyclibeQLQrPIWchtpAoc6xxVu9kE=;
 b=GQnnt0OZCJO1D8VyoG0XF+xX5i7UvduIEvDY0Xeg+waBthaR2YYQyRGnfIXt6CeP3J
 N3Vs4YeQ58o2UQRhJhf3dC2hHOhwD0K0JLLmeROeGZ7wjLYui9BMNa/9/yXqN4vP/KsN
 Fc3KDB6Ixg3fVv6pVurJ9XPUKYO+1XzQ8vqKWtubKvZwP25Z8UL1rZGpbNR47EL89Fm7
 6ZZPCnwGFyhHTCY6mEVuIBErn4QOc4hmaSbG4GQIvEyM0e+pvT5g7YAQBJUqTuw05XiH
 jyLE7ofVJcbhjtI7EKm75RASQ9EFFK+gRZw5DGrJ473EoipoBX0f278BXM/hz0b7Bd32
 gOMA==
X-Gm-Message-State: AOAM530EpUwX+w79OpHhijYQNcO4cabazIwKEEP0zEVFFd0ZfHN5Vhl3
 gZF2mZhp3K6viNvX9eFgeX9kNKR7HYahFw4+64QwGUwswEJZOkvjoLvjrirXRVlLrNdN/DUkg+1
 nk82N6D0xr3iOjHs=
X-Received: by 2002:adf:fd48:: with SMTP id h8mr9361318wrs.226.1591349598410; 
 Fri, 05 Jun 2020 02:33:18 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwhA+hB3tn5MvRWc0RXkdkrTUtZ0V2j0/aeJ9SZgZdV7BssyWou47DhB2XozOHOtLS9DZuEJw==
X-Received: by 2002:adf:fd48:: with SMTP id h8mr9361309wrs.226.1591349598212; 
 Fri, 05 Jun 2020 02:33:18 -0700 (PDT)
Received: from localhost.localdomain
 (181.red-88-10-103.dynamicip.rima-tde.net. [88.10.103.181])
 by smtp.gmail.com with ESMTPSA id i3sm11548685wrm.83.2020.06.05.02.33.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Jun 2020 02:33:17 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v6 04/11] rules.mak: Add strequal() and startwith() rules
Date: Fri,  5 Jun 2020 11:32:49 +0200
Message-Id: <20200605093256.30351-5-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200605093256.30351-1-philmd@redhat.com>
References: <20200605093256.30351-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/05 03:35:49
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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


