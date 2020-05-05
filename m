Return-Path: <SRS0=1jZz=6T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC01CC47247
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 14:29:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A11CD206A5
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 14:29:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EHH9uMEY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A11CD206A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51930 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVyZY-0007BU-Kf
	for qemu-devel@archiver.kernel.org; Tue, 05 May 2020 10:29:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60128)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jVyYt-0006ew-Fx
 for qemu-devel@nongnu.org; Tue, 05 May 2020 10:28:43 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:30774
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jVyYs-0005xm-OK
 for qemu-devel@nongnu.org; Tue, 05 May 2020 10:28:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588688921;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=SODIKxZt1q2rQc3n2F7gikb/kboYOa22VRDmN6O5sjc=;
 b=EHH9uMEYiKXQsMyju88v85Eqv8naplXXJQ26lqRdlfLaYXn0H0kOL33ysN7anfUQh/KLl8
 PmIhgPvpCFg8trC5diZPkZXRoCxnFqN9iWw+oZ+dZMuJAybZv7u4C99r4yEILUvdIx5pwA
 QyxV8+sordPUOXJV6F4yXIiaNtO1qkE=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-184-oN_j531kN8yaqSb-mlPM_A-1; Tue, 05 May 2020 10:28:40 -0400
X-MC-Unique: oN_j531kN8yaqSb-mlPM_A-1
Received: by mail-wr1-f71.google.com with SMTP id q13so1291616wrn.14
 for <qemu-devel@nongnu.org>; Tue, 05 May 2020 07:28:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=l7ZiJPL7K6pr7CqBYpvvYjXrgczUlL8OlxjhI3odDYw=;
 b=OeL4Zr3FltuA6bwdsPAZoC0+ajh+2v3/5LZADv++sWtfmNcWI9DN9DHx5XKcVLpmuc
 zXBqcMUgj+hM+BgQYzkugppzjb/GPchO0zP+5sCsO59WIv2ZcdWw0eqDobiNTvr2Q2V4
 ILZhHDyQsn2L9Ig2RVjffqJFAf8EOIemftP7GaIBpWQ3l3rxNIWINKqtLJynRuox2S5M
 OEdDukM+Bfn8sIdk/kxsdOdcbFdFOa2KtByw76L2xWYOGj8t7GE3rnTXCr3YBqHTOl7e
 udDrzj0UTqYfhbZedOGmQim9h2VVpL46mU6ABKDHHmW1JKslp+/k7yz2BmunYv4CNdw1
 mtJg==
X-Gm-Message-State: AGi0Pubapc86/O+yKWmVZsIfChobeOT9im+4ts/W+OZhssdM96pgPRqM
 VN2SeEb99Bx8H9pRmVPq8saZpCWU114pxU3FKyEbiUvSNdA0Rs9DRRV9NqtEeHkUpPrY5mH8zCz
 PPifKU8IFlWoqe3U=
X-Received: by 2002:a5d:4c4b:: with SMTP id n11mr4212989wrt.139.1588688919014; 
 Tue, 05 May 2020 07:28:39 -0700 (PDT)
X-Google-Smtp-Source: APiQypJlT+XEDvfcZoEq3FuYBp6cP51UAet/z0Xr0BwF9nqyKqwe2w8NWFg9tAJthsxjtZap7RBO3w==
X-Received: by 2002:a5d:4c4b:: with SMTP id n11mr4212945wrt.139.1588688918544; 
 Tue, 05 May 2020 07:28:38 -0700 (PDT)
Received: from x1w.redhat.com (26.red-88-21-207.staticip.rima-tde.net.
 [88.21.207.26])
 by smtp.gmail.com with ESMTPSA id c128sm1167317wma.42.2020.05.05.07.28.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 May 2020 07:28:37 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] hw/i386/vmport: Drop superfluous parenthesis around function
 typedef
Date: Tue,  5 May 2020 16:28:36 +0200
Message-Id: <20200505142836.16903-1-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/05 03:48:16
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
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
Cc: Eduardo Habkost <ehabkost@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-trivial@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Drop superfluous parenthesis around VMPortReadFunc typedef
(added in d67f679d99, missed to remove when moved in e595112985).

Suggested-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 hw/i386/vmport.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/i386/vmport.h b/hw/i386/vmport.h
index 47eda7a22b..a6624e3045 100644
--- a/hw/i386/vmport.h
+++ b/hw/i386/vmport.h
@@ -27,7 +27,7 @@
=20
 #define TYPE_VMPORT "vmport"
=20
-typedef uint32_t (VMPortReadFunc)(void *opaque, uint32_t address);
+typedef uint32_t VMPortReadFunc(void *opaque, uint32_t address);
=20
 void vmport_register(unsigned char command, VMPortReadFunc *func, void *op=
aque);
=20
--=20
2.21.3


