Return-Path: <SRS0=HfOj=DH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00DBEC4727E
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 16:55:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 61EE620738
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 16:55:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iR56GaE4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61EE620738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46070 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNfOD-0003VO-Cr
	for qemu-devel@archiver.kernel.org; Wed, 30 Sep 2020 12:55:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39808)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kNfJM-0006Ve-38
 for qemu-devel@nongnu.org; Wed, 30 Sep 2020 12:50:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:20684)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kNfJF-00078X-QS
 for qemu-devel@nongnu.org; Wed, 30 Sep 2020 12:50:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601484628;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=C6Fm2xUD2RWK8sXQLgIXMwM+hS3JLybHuCGcigeuHtk=;
 b=iR56GaE4fWpKT5de14g6weylljUFEeyOoaWvqCkqXgXQxl0ts35zs7V/YErQwIAoFT3ygq
 wj00Kgqhd+G2RCOx36kHtUYLYXTttx00mgXAS4KiJ3zDT9CA8lAcnBBDGJ2oaHCtImdw0h
 iQNJ3Ta6ifKSTyP5CjV2IjN0JR7Rd60=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-34-gCmbycgHOXmjtr5On0CD3w-1; Wed, 30 Sep 2020 12:50:26 -0400
X-MC-Unique: gCmbycgHOXmjtr5On0CD3w-1
Received: by mail-wm1-f69.google.com with SMTP id 73so60797wma.5
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2020 09:50:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=C6Fm2xUD2RWK8sXQLgIXMwM+hS3JLybHuCGcigeuHtk=;
 b=NL6LrjuxLjBmXCakwsRmObaR0Kxmuct3XHZHdOyq/vwp33RYnd5isT2+sQ9i3jJK9b
 2ad2m40kKRMyPVuBU/f8qptZdOPPxUZ6wnf+dzzT4XY44Fl4bqDYh2xK1DV0UafTXReB
 GAt6x2i5/Gp11z5OEm5pZ6qRAssMpdXjzyazY2zd6yMMYtjOYudurgpA45ELQtdHmTmg
 KLC2TjPYBsgHZL8bPS098BVXKP34JjnixiZIvBBTFn8LFXVElMkFo1BZgT47anfqvX81
 wFnHJLdzZLGb+4U+/53/aejZnzt7PluI1q9kazEmDu2P9dzhuucDkS1yrdOseyDCpLVt
 A7ag==
X-Gm-Message-State: AOAM533yUI42EXr3xkKHeFSYHizyjDApWSFa6RrpHqyqwsrWBCdMrxUc
 Y98KGfXZceB3XKW4nDCNqsg5ET+wDXnuwfpi5PVqqf6LGIuFxjse+6LyBYaUHw4rakizMBkpRcr
 Q1+xqB8YF7snEhg8=
X-Received: by 2002:a1c:96cf:: with SMTP id y198mr4218423wmd.104.1601484624054; 
 Wed, 30 Sep 2020 09:50:24 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwZwYKXrf/pCor3fL0qkRpuOATDY1ZY0R/nDzSeJ/dAFin5woJ3Ks49fKghYaGUVgJYglJlcg==
X-Received: by 2002:a1c:96cf:: with SMTP id y198mr4218397wmd.104.1601484623802; 
 Wed, 30 Sep 2020 09:50:23 -0700 (PDT)
Received: from x1w.redhat.com (74.red-83-53-161.dynamicip.rima-tde.net.
 [83.53.161.74])
 by smtp.gmail.com with ESMTPSA id a15sm4405097wrn.3.2020.09.30.09.50.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Sep 2020 09:50:23 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org,
	Laurent Vivier <laurent@vivier.eu>
Subject: [PATCH v3 06/11] hw/core/qdev-properties: Export qdev_prop_enum
Date: Wed, 30 Sep 2020 18:49:44 +0200
Message-Id: <20200930164949.1425294-7-philmd@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200930164949.1425294-1-philmd@redhat.com>
References: <20200930164949.1425294-1-philmd@redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/30 00:31:59
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.469,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Ronnie Sahlberg <ronniesahlberg@gmail.com>, qemu-block@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Peter Lieven <pl@kamp.de>, Michael Roth <mdroth@linux.vnet.ibm.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 include/hw/qdev-properties.h | 1 +
 hw/core/qdev-properties.c    | 7 +++++++
 2 files changed, 8 insertions(+)

diff --git a/include/hw/qdev-properties.h b/include/hw/qdev-properties.h
index 528310bb22..4437450065 100644
--- a/include/hw/qdev-properties.h
+++ b/include/hw/qdev-properties.h
@@ -8,6 +8,7 @@
 extern const PropertyInfo qdev_prop_bit;
 extern const PropertyInfo qdev_prop_bit64;
 extern const PropertyInfo qdev_prop_bool;
+extern const PropertyInfo qdev_prop_enum;
 extern const PropertyInfo qdev_prop_uint8;
 extern const PropertyInfo qdev_prop_uint16;
 extern const PropertyInfo qdev_prop_uint32;
diff --git a/hw/core/qdev-properties.c b/hw/core/qdev-properties.c
index 76417d0936..31dfe441e2 100644
--- a/hw/core/qdev-properties.c
+++ b/hw/core/qdev-properties.c
@@ -86,6 +86,13 @@ void qdev_propinfo_set_default_value_enum(ObjectProperty *op,
         qapi_enum_lookup(prop->info->enum_table, prop->defval.i));
 }
 
+const PropertyInfo qdev_prop_enum = {
+    .name  = "enum",
+    .get   = qdev_propinfo_get_enum,
+    .set   = qdev_propinfo_set_enum,
+    .set_default_value = qdev_propinfo_set_default_value_enum,
+};
+
 /* Bit */
 
 static uint32_t qdev_get_prop_mask(Property *prop)
-- 
2.26.2


