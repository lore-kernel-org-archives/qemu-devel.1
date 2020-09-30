Return-Path: <SRS0=HfOj=DH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13BBDC4727C
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 16:57:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9170B2085B
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 16:57:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G/Wxa4mf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9170B2085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53452 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNfPy-0006VG-EA
	for qemu-devel@archiver.kernel.org; Wed, 30 Sep 2020 12:57:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39692)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kNfJ8-0006RR-7h
 for qemu-devel@nongnu.org; Wed, 30 Sep 2020 12:50:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:32953)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kNfJ3-00074I-Cl
 for qemu-devel@nongnu.org; Wed, 30 Sep 2020 12:50:20 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601484616;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zXLYVmcZORAN1WI9rIV4a3OMV4bhJ5fCBxobebcKs5M=;
 b=G/Wxa4mfeQwJ2R83jjvJdR7ectfjH1/j1t/fgcUKuwfPnfTKZ9Di1Pie4L3SYL41wCiSbc
 MNW53F6Ow11DsKndu6MtU9OfmNk8CbXLbk/h3G7DTCzhOSwNailc8j7fRnf7iV1cL/u8qj
 bxizXKO6obsjYAClYqMnPdoOe50Sdxs=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-575-umcGSJv3Pgu7PnVPDupZvg-1; Wed, 30 Sep 2020 12:50:14 -0400
X-MC-Unique: umcGSJv3Pgu7PnVPDupZvg-1
Received: by mail-wm1-f69.google.com with SMTP id l15so52386wmh.9
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2020 09:50:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=zXLYVmcZORAN1WI9rIV4a3OMV4bhJ5fCBxobebcKs5M=;
 b=iodlu57cVvGjQUGcm23ivmOYxbUdroEUCOJCe8RkSSOp9GHCW9hr4jsJiCS5nqzRxY
 VW8Ka9lbEWR4QonSDSm1aIDiGFtyKtApYAz4f2zHp63JN3kLOFd07iJVHq5eaO+uBS2B
 irIsxJlAdboBA2wIpwaxMV2XBOTskwUykeBGm1pynGW/CEBquSG5J5isEX0qci8A5Kez
 PgrhW/6QeKNzzg0Mf1sHRw/lvoXdE5ER8bCD7z5SDbYGlIvbkxlbo4fDrK6RbwtGPZAE
 i2BR1tRwHG7uUc3gFBk99y5oFEdDyU41Hs22Bs0ghceoQhqJKkXWRksIueJOCezzd7yE
 kAMQ==
X-Gm-Message-State: AOAM532Kg6AV2glqiM1T53Vwb74kSEb/OT2hSMbMac2tYvn0MRBmh81m
 5vYj8u8dslbDHX+YUHPU2YYxR9Iqglal6KG10h9qRBUBS+ENerS1YCSeSlpeX8qCZ92d/FP4Yhl
 6XsxcY3jr4rHX5LU=
X-Received: by 2002:a1c:59c2:: with SMTP id n185mr3938722wmb.43.1601484613368; 
 Wed, 30 Sep 2020 09:50:13 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx9t/R0crJ5TioAioJD4m7jku3Gfqpg0Q8CECC1TjraYneMkxr7YZqz8+8/jjFJLXK3cxZWUQ==
X-Received: by 2002:a1c:59c2:: with SMTP id n185mr3938695wmb.43.1601484613132; 
 Wed, 30 Sep 2020 09:50:13 -0700 (PDT)
Received: from x1w.redhat.com (74.red-83-53-161.dynamicip.rima-tde.net.
 [83.53.161.74])
 by smtp.gmail.com with ESMTPSA id v2sm4040504wme.19.2020.09.30.09.50.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Sep 2020 09:50:12 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org,
	Laurent Vivier <laurent@vivier.eu>
Subject: [PATCH v3 04/11] hw/core/qdev-properties: Fix code style
Date: Wed, 30 Sep 2020 18:49:42 +0200
Message-Id: <20200930164949.1425294-5-philmd@redhat.com>
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
Received-SPF: pass client-ip=216.205.24.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/30 00:26:33
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.469,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

We will soon move this code, fix its style to avoid checkpatch.pl
to complain.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 hw/core/qdev-properties.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/hw/core/qdev-properties.c b/hw/core/qdev-properties.c
index a1190a5db9..071fd5864a 100644
--- a/hw/core/qdev-properties.c
+++ b/hw/core/qdev-properties.c
@@ -543,15 +543,15 @@ static void set_mac(Object *obj, Visitor *v, const char *name, void *opaque,
         if (!qemu_isxdigit(str[pos])) {
             goto inval;
         }
-        if (!qemu_isxdigit(str[pos+1])) {
+        if (!qemu_isxdigit(str[pos + 1])) {
             goto inval;
         }
         if (i == 5) {
-            if (str[pos+2] != '\0') {
+            if (str[pos + 2] != '\0') {
                 goto inval;
             }
         } else {
-            if (str[pos+2] != ':' && str[pos+2] != '-') {
+            if (str[pos + 2] != ':' && str[pos + 2] != '-') {
                 goto inval;
             }
         }
@@ -898,8 +898,8 @@ static void set_blocksize(Object *obj, Visitor *v, const char *name,
     /* We rely on power-of-2 blocksizes for bitmasks */
     if ((value & (value - 1)) != 0) {
         error_setg(errp,
-                  "Property %s.%s doesn't take value '%" PRId64 "', it's not a power of 2",
-                  dev->id ?: "", name, (int64_t)value);
+                  "Property %s.%s doesn't take value '%" PRId64 "', "
+                  "it's not a power of 2", dev->id ?: "", name, (int64_t)value);
         return;
     }
 
-- 
2.26.2


